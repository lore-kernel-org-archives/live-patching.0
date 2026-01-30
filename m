Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD42FC86C
	for <live-patching@vger.kernel.org>; Fri, 30 Jan 2026 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803323; cv=none; b=oCkgf8FTWKMR5v3AYAM0S08XO8S7hIMVZu6Q6BSOptxhCKInEjySZQ2DcUkXXhQFj9JTbu5HHLwtdL8sRO4ObQwOjYzRlUp+vJ6oftuDmEQTMNBAOI9QTk0bis2+YdQuDsJklLSEs1C5gIJwPTZCNZAVAeZHnomfxoW5oRR0zHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803323; c=relaxed/simple;
	bh=/rA4lrDBnNPGpxsAfKRPjAg94mUDQCfAo/iY8BjMs5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC4PMcB5THurkftn40r8d+7E+tkR4a1A2ewHhR/8I8/7B4diaB90bcTrTCui/SRG136BHPCqhqPxOpiAiVZbbqeXy8FJ0ouOZt14Z0hx4ICDgA7Ak36xvxqHrs9Ff/lWnmlbYS4yX2qiqBpUBt+1XMgWYCo/1tQukLTER5Cijmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBQbifpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBQbifpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAF6C4CEF7;
	Fri, 30 Jan 2026 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769803322;
	bh=/rA4lrDBnNPGpxsAfKRPjAg94mUDQCfAo/iY8BjMs5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBQbifpoxMpnLGIrObtnjT65hGI6JljmCRmSilll8FnuVBWmYb3mMDfv8XwOIfXvM
	 Sx3V48R39TVue8drl4YRk+XoeJp1akmm3xRczIBQBJ6wFsvUD4OwEln1duIsqZE3M6
	 IZwEGtBITrrurYvfOkEZYLRJOMYKef3umA7FE5/oFxkNnENc5hUphGO5xlwKFIWXxb
	 4V0LraEoV3AyLhanzCIibDV/8jcCvjecETGVEVGjFJelmls2/CAnEAQAPppASkilBr
	 GuhQfa8iPp7a2pNUSNMO68QqCwOQ61nEmeNIj7VliXqSKq5XE+Hm1zvNvX4SMHQesJ
	 8a3cKz1kh5wRQ==
Date: Fri, 30 Jan 2026 12:02:00 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/5] objtool/klp: handle patches that add new files
Message-ID: <gcsc5wrpcbavzrezyxgsmhix33mr2jhp5zroidpvnxt2nzy4vv@3hjjkziw6ab6>
References: <20260130175950.1056961-1-joe.lawrence@redhat.com>
 <20260130175950.1056961-3-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130175950.1056961-3-joe.lawrence@redhat.com>

On Fri, Jan 30, 2026 at 12:59:47PM -0500, Joe Lawrence wrote:
> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index 964f9ed5ee1b..5a8c592c4c15 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build
> @@ -426,6 +426,8 @@ refresh_patch() {
>  	local patch="$1"
>  	local tmpdir="$PATCH_TMP_DIR"
>  	local files=()
> +	local orig_files=()
> +	local patched_files=()
>  
>  	rm -rf "$tmpdir"
>  	mkdir -p "$tmpdir/a"
> @@ -434,12 +436,20 @@ refresh_patch() {
>  	# Get all source files affected by the patch
>  	get_patch_files "$patch" | mapfile -t files
>  
> -	# Copy orig source files to 'a'
> -	( cd "$SRC" && echo "${files[@]}" | xargs cp --parents --target-directory="$tmpdir/a" )
> +	# Copy orig source files to 'a', filter to only existing files
> +	for file in "${files[@]}"; do
> +		[[ "$file" != "dev/null" ]] && [[ -f "$SRC/$file" ]] && orig_files+=("$file")

Can we fix get_patch_files() so it filters out /dev/null (or "dev/null"
as it appears to be for some reason)?  I don't think any of its callers
would want that.

Also I'm thinking these checks would be more precise if they parsed the
patch file directly to get the before/after file names, as that would
catch more cases of malformed patches.

So maybe we'd just need something like get_patch_input_files() and
get_patch_output_files() here (not sure about the naming)?

BTW, for the patch subject prefixes I've been using
"livepatch/klp-build" for changes to klp-build and "objtool/klp" for
objtool/klp-diff.c, so let's keep doing that unless anybody has any
better suggestions.

-- 
Josh
