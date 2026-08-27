Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AD1A6806
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865716; cv=none; b=OAwFXIotn22Q556fdQNCwGoY7k8PFAG+t7BD3rnUlAI0/bfdytm4/nxQE8l8TO1gZ5OqbYr0PAzdJyYHgPLVZCWaMSpPbXQKQpLx9dsWD1FOLdBuYzOAdTFRPlxFPl8J/Y2c5jh56wnl5DZ+WOygetolXpQQLNI/Zb6EM93s+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865716; c=relaxed/simple;
	bh=gqcD6NoUykZ8zivsM6YGJTtb1Nrxb5K+KMUBBQB2cFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbL0Va0lQUWJq3QMrGKDy7GDQxShTGhyZDtBaEgKzjX8KpYfS84bJMr1nfknmjz464gN6EwKiUxgL1TbkY2CkG8F9P3KstyyHbXYEA+g0WhPl95qsFf2/lmswxbfL/jszPQIuBGBUj1iKWNpKmGr2dDdIi8FtJq7VyiyBJfsGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y42vy0Gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y42vy0Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155E91F000E9;
	Thu, 27 Aug 2026 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787865714;
	bh=N8Wuu9Je9YQmGvVdRdqhomE08GqwGexkqntqXrSQUEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y42vy0Gb3z3SjN/KdO7kijO6sAeiomhsq2v13V/nzsE3Y+yFfp+RDRvFw95un8+Ow
	 6sAzar2wQKla7wbCQKyuGgdJCvbU/dxcMyRH4pg4G+QD4QD9FD5kIStF8Zfq9GFAoO
	 30TwZ9EDVroa7nQHcwIvkUDUjnqMaZrFv6F2NbnDjcyGLt0cEY1dJeAI9qal8A3cHc
	 8ML2dHi/IT/Et0DttVZMLizHtLITclIEjwLHeLC+UsPb1hS7QAvg+TyhW8Csmd2SYu
	 ipYLC/OLtaq2gRMOEAKQpFjS0ZJVTfH4Dp15T4/lLGzZGfRorp/ydlKlwPBNmzF2p4
	 EKq5XGu9JeO5A==
Date: Thu, 27 Aug 2026 14:21:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH v2 5/7] livepatch/klp-build: add basic out-of-tree
 module support
Message-ID: <apCnuKgI1Rt_XVYS@jpoimboe>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-6-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826195000.455905-6-joe.lawrence@redhat.com>

On Wed, Aug 26, 2026 at 03:49:58PM -0400, Joe Lawrence wrote:
> @@ -579,13 +610,20 @@ build_kernel() {
>  find_objects() {
>  	local opts=("$@")
>  
> -	# Find root-level vmlinux.o and non-root-level .ko files,
> -	# excluding klp-tmp/ and hidden directories.
> -	find "$PWD" -mindepth 1 \
> -		    \( -path "$TMP_DIR" -o -name ".*" -o -regex "$PWD/[^/][^/]*\.ko" \) -prune -o \
> -		    -type f "${opts[@]}"				\
> -		    \( -name "*.ko" -o -path "$PWD/vmlinux.o" \)	\
> -		    -printf '%P\n'
> +	if [[ -z "$OOT_DIR" ]]; then
> +		# In-tree: find root-level vmlinux.o and non-root-level .ko files,
> +		# excluding klp-tmp/ and hidden directories.
> +		find "$PWD" -mindepth 1 \
> +			    \( -path "$TMP_DIR" -o -name ".*" -o -regex "$PWD/[^/][^/]*\.ko" \) -prune -o \
> +			    -type f "${opts[@]}"				\
> +			    \( -name "*.ko" -o -path "$PWD/vmlinux.o" \)	\
> +			    -printf '%P\n'
> +	else
> +		# OOT: find .ko at any depth under the module dir
> +		find "$OOT_DIR" -path "$OOT_DIR/.git" -prune -o \
> +			-type f "${opts[@]}" \
> +			-name "*.ko" -printf '%P\n'

Can these be unified?  Something like:

	if [[ -n "$OOT_DIR ]]; then
		path="$OOT_DIR"
	else
		path="$PWD"
	fi

	find "$path" -mindepth 1 \
		    \( -path "$TMP_DIR" -o -name ".*" -o -regex "$PWD/[^/][^/]*\.ko" \) -prune -o \
		    -type f "${opts[@]}"				\
		    \( -name "*.ko" -o -path "$PWD/vmlinux.o" \)	\
		    -printf '%P\n'

That way we get consistent behavior and the two paths with $PWD would
get silently ignored for the OOT case anyway.

> @@ -717,6 +757,7 @@ diff_objects() {
>  		cmd+=("klp")
>  		cmd+=("diff")
>  		(( ${#opts[@]} > 0 )) && cmd+=("${opts[@]}")
> +		[[ -n "$OOT_DIR" ]] && cmd+=("--symvers" "$PWD/Module.symvers")

Even with OOT_DIR it still runs in the kernel build dir, which is where
objtool looks for this file anyway, so I don't think this line is
needed?

>  		cmd+=("$orig_file")
>  		cmd+=("$patched_file")
>  		cmd+=("$out_file")
> @@ -895,13 +936,16 @@ build_patch_module() {
>  process_args "$@"
>  do_init
>  
> +BUILD_TARGET="kernel"
> +[[ -n "$OOT_DIR" ]] && BUILD_TARGET="module ${OOT_DIR##*/}"
> +
>  if (( SHORT_CIRCUIT <= 2 )); then
>  	status "Validating patch(es)"
>  	validate_patches
>  fi
>  
>  if (( SHORT_CIRCUIT <= 1 )); then
> -	status "Building original kernel"
> +	status "Building original $BUILD_TARGET"

I think we can simplify this to just "Building original objects" or so...

>  	clean_kernel
>  	build_kernel "original"
>  	status "Copying original object files"
> @@ -912,7 +956,7 @@ if (( SHORT_CIRCUIT <= 2 )); then
>  	status "Fixing patch(es)"
>  	fix_patches
>  	apply_patches "--silent"
> -	status "Building patched kernel"
> +	status "Building patched $BUILD_TARGET"

... and "Building patched objects".

-- 
Josh
