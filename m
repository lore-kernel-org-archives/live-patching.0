Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833F378D86
	for <live-patching@vger.kernel.org>; Mon, 23 Feb 2026 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882920; cv=none; b=C+1B6ZK+BGi5gDOaSv+08GA1lEF8yT+U3qW8tz0KvA60GbQ7YrfTnwF7M+pUwTlqpSZFv0lSkbhv+1pAVZZhe2Zm1+bZQWh7WGp3LE57YEi1qITKPEy8XdZcUwsSOGdnpJRkNDbS5DJS/i3E+/4RcVmQXZQqnN4bjFw0U8Nep3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882920; c=relaxed/simple;
	bh=ZGIF2UDvKN3SDHAoO9oD5ZFqA/jEhmM2DjkYx0hLc0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6GsKkUteuEd1rrvvnj1hBuGXRE0jk+C1AQDKVNE6hhP0D5w8RdsUdrzOVxAZSiwj0FwFeP8tkZpLOmParT2pceq6q1iJWkOfjiC5y9GXrrd3dK7LI2vkkpk+IhR86/8TYpxmRmQpubSfFPKCpkyR7LImzG0ZgRMqHbzrRHd0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7g9suhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7g9suhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F48C116C6;
	Mon, 23 Feb 2026 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771882920;
	bh=ZGIF2UDvKN3SDHAoO9oD5ZFqA/jEhmM2DjkYx0hLc0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7g9suhTNDHVAolkW52jHJv1EnOTsZANyXJichcxFOJ6tQbnoxRTUV0uTY5iDMrbe
	 QC3kYkpOJMyORUtg2WAK21c5vqoAvc19zLAYHUbufMcgHoeHqdSeNVX0HwP+uNCd0e
	 fOuHeAg8AcYS7oIb2/rCUKV5EIRsjbhKJLiTxjtffc4N3WnTLLiyAnAy+Qnf0tuBkg
	 9/xClOslwvmsd7UXowIiRcTnCuRjlvN77NUpoB4FP2mkeIKNn4/CA4Zf7pTWMUGDZH
	 veHrWC1ncbqf6BgnTr4D31o+6FLMMA8tWeuD0a88cALRbfoY2s2HZ6dRLteoenIeTr
	 OxqBur8HmjQyQ==
Date: Mon, 23 Feb 2026 13:41:58 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 13/13] livepatch/klp-build: don't look for changed
 objects in tools/
Message-ID: <os3ykxdsfe6bz2b2pd5x5wb76ya5ecogbvjgkcophf55wchv7r@vdp2dzrzrdny>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
 <20260217160645.3434685-14-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217160645.3434685-14-joe.lawrence@redhat.com>

On Tue, Feb 17, 2026 at 11:06:44AM -0500, Joe Lawrence wrote:
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  scripts/livepatch/klp-build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Why?

> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index 5367d573b94b..9bbce09cfb74 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build
> @@ -564,8 +564,8 @@ find_objects() {
>  	local opts=("$@")
>  
>  	# Find root-level vmlinux.o and non-root-level .ko files,
> -	# excluding klp-tmp/ and .git/
> -	find "$OBJ" \( -path "$TMP_DIR" -o -path "$OBJ/.git" -o	-regex "$OBJ/[^/][^/]*\.ko" \) -prune -o \
> +	# excluding klp-tmp/, .git/, and tools/
> +	find "$OBJ" \( -path "$TMP_DIR" -o -path "$OBJ/.git" -o -path "$OBJ/tools" -o -regex "$OBJ/[^/][^/]*\.ko" \) -prune -o \
>  		    -type f "${opts[@]}"				\
>  		    \( -name "*.ko" -o -path "$OBJ/vmlinux.o" \)	\
>  		    -printf '%P\n'
> -- 
> 2.53.0
> 

-- 
Josh
