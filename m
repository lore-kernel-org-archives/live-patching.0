Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBE171BB
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787867125; cv=none; b=RrMuEqyRZGNMhCYzYlHR9hoXYtNv/9S6WhTfPSDiELREQSgH1FjnWz2e46vpuwI2BvUlHsCX1FI8L0U8MkXMdK2QmlEsJGSOQD744A08I659KMyh6Vd2OTGRbCVmgppAn5lTfD815W1FzLxVDVayUCfRy2TZNL1o9v58L8TZSbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787867125; c=relaxed/simple;
	bh=/ZAZeC7JwuZTx6VTkUYiBWweCx5mzxfQBcSMqxtBrM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq50L6zQfu2epjAHEXLoxiN8YkSdHzTF7Pft/fbDF/VscglSNHizrsm/09m3TG7SG34iMA2iJK2VxOW7Vjam2TIX7L5JoMzSY2XghvovMA1qPz9Bxrg1UqTBr0XX0WQS3lBkiPsC4VoDRT7HQctn/7GeXYQfi+Pf0rp/XiFS1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGyfmM13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGyfmM13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD991F000E9;
	Thu, 27 Aug 2026 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787867124;
	bh=cnEVcHQN1w/VR7xjC6xsO1o+3gSlsoOTtF7WYPkT6pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TGyfmM13oRvweYGsI++ddMpgsRQ9fYu2QJ59ZSDfzwYCCIgHxYcQ/01fRD6jvIQAe
	 pQUaBAG/iLLcZMwDNTm0EgN14+welLsz0vpdCcNzT10yav/BJnqpDjRmP57X0umcA5
	 ib3t6S8yEEsIvv+yNKGr6Po0p1IG4v3jdJ/lTgZgVZDfoYAatbhGqSt/76wbLUUBTz
	 NAYN1/yEw/ounyUPEi3Tr8ukQ+jQXWnmzi6pLuTQptp8HVL8xA4zu6HXiAKKPGtHEP
	 kRF4kixmKnBEYBCNHOx57YBCVUzcnGLkO110oBHm5H15f4HbpgXYpZlN9/h8Kraf8Q
	 nfA4nhPpzO2Zg==
Date: Thu, 27 Aug 2026 14:45:21 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH v2 6/7] livepatch/klp-build: add pre-built object
 support for advanced OOT workflows
Message-ID: <apCqiGX1QgrS2neQ@jpoimboe>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-7-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826195000.455905-7-joe.lawrence@redhat.com>

On Wed, Aug 26, 2026 at 03:49:59PM -0400, Joe Lawrence wrote:
> +setup_oot() {
> +	local files=()
> +	local rel
> +
> +	mkdir -p "$ORIG_DIR" "$PATCHED_DIR"
> +
> +	find "$USER_ORIG_DIR" -type f -name "*.o" -printf '%P\n' | mapfile -t files
> +	[[ ${#files[@]} -gt 0 ]] || die "no .o files found in $USER_ORIG_DIR"
> +	for rel in "${files[@]}"; do
> +		[[ -f "$USER_PATCHED_DIR/$rel" ]] ||
> +			die "$rel found in orig dir but missing from patched dir"
> +		mkdir -p "$ORIG_DIR/$(dirname "$rel")"
> +		mkdir -p "$PATCHED_DIR/$(dirname "$rel")"
> +		cp -f "$USER_ORIG_DIR/$rel" "$ORIG_DIR/$rel"
> +		cp -f "$USER_PATCHED_DIR/$rel" "$PATCHED_DIR/$rel"
> +	done
> +
> +	touch "$ORIG_DIR/.complete"
> +	touch "$PATCHED_DIR/.complete"
> +}

This is basically reimplementing copy_orig_objects() and copy_patched_objects().

>  ################################################################################
>  
>  process_args "$@"
>  do_init
>  
> +# User provided OOT original and patched object files can jump straight
> +# to checksum + diff + build steps
> +if [[ -n "$USER_ORIG_DIR" ]]; then
> +	status "Setting up OOT objects"
> +	setup_oot
> +
> +	status "Generating original checksums"
> +	generate_checksums "$ORIG_DIR" "$ORIG_CSUM_DIR" "$PATCHED_DIR"
> +	status "Generating patched checksums"
> +	generate_checksums "$PATCHED_DIR" "$PATCHED_CSUM_DIR"
> +
> +	status "Diffing objects"
> +	diff_objects
> +
> +	status "Building patch module: $OUTFILE"
> +	build_patch_module
> +
> +	status "SUCCESS"
> +	exit 0
> +fi

This is basically reimplementing --short-circuit=3.

Instead of --orig-dir and --patched-dir, I wonder if we could just have
--oot-build-cmd (combined with --oot-dir), so the user can specify
whatever make command is needed?

Then do_init() could have something like SRC_DIR="${OOT_DIR:-$PWD}" so
almost all the code for all the steps gets shared, except for the build
command.

The klp-specific build-isms like KCFLAGS could be exported instead of
added to the cmdline.

And then that would be easier for the user too, they wouldn't have to do
the building/copying of objects, filtering the patch, etc.

-- 
Josh
