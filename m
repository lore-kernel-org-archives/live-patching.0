Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684972;
	b=BA8oPHxwLti5bR1H26rCYVtOEysXRA8jFKN5NF7nsEdQOypvcrFcR+R528iFFIS9n1k9
	 BqknUaBPuzezxM1d0Y/Y2irSsubgE5TPvSq4mnD/sOmwphn0RtFFhdeBoqqpHgsDeAKS5
	 fi9vbrGhwnjt9Uu61wcbs63tqArtDNF5W6Bb0fNAiIftzNvIFjpz/1YWxIUMCeKdsIsHt
	 5RdJVda6wHpPlWZUa0s0eC8RTIpCuN3hnEO+CDHEuQviMjj4CCrghtQM0A34BZbRa0nTK
	 2KtQd6YMDyoPw5cuzRogLEMlagWjqICLJL8nK5ewnMmeacX9UERqEkmI5s1J/QarWGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684972;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=DKv58Efgci3z6wOk+CcOOnuJnHbP4dkIuHX7WooisXE=;
	b=bTaOMvSlMiM78o14OYjuTRYvkMKCTlRfSa3zy1+WHQLYjFk42iN/+Hnnwk7+3hbP6l5d
	 1Ls07qz30II6QqDLXj0w0tBJvX+QVjTeAkWCvhYRnYVIYCXf3rFmveEMCpbmBISAhkMTL
	 5G5FP5oEF6u/SpTptnjB2oZ82hlxkW0HWernjiF6Q3qfTMSUOWPa4q+pFSoiK+68/lfsx
	 ygi8uy2YRAA2b8sbX6JCnEbbTXX4kcTPzYC6X12ZRJcXw+Ow6L4mqAg2dSWoNqnnUJfch
	 Azmx0emHMIoAfo1aYpp28jlcubqHG8PMp0hjUqHzvmCz1nc4sIlR9CKkudei9NnfX5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OUKdrccZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468D606A32A
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 16:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3468D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OUKdrccZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792684971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DKv58Efgci3z6wOk+CcOOnuJnHbP4dkIuHX7WooisXE=;
	b=OUKdrccZiECkhJEw2PuHx5DmMbS1jkKQvga6MY6kuOLHtL6/90ppWWnC29XGVEB90LN1Ve
	grDtf8GE4zQ02v/qmQFMhbPvTSQXY3uBFXiE/4NIfIMUFRB3SFL4m7H1tsscgiELdBa+2I
	fKPLvh5uv6WMvf4Nv1ErIYIrhsr326U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-S2zDwerpNNy-uraKnYXqLA-1; Thu,
 22 Oct 2026 12:02:47 -0400
X-MC-Unique: S2zDwerpNNy-uraKnYXqLA-1
X-Mimecast-MFC-AGG-ID: S2zDwerpNNy-uraKnYXqLA_1792684966
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1552518011ED;
	Thu, 22 Oct 2026 16:02:46 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFE471800444;
	Thu, 22 Oct 2026 16:02:44 +0000 (UTC)
Date: Thu, 22 Oct 2026 12:02:42 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 3/3] objtool/klp: Add test for changed functions without
 an ftrace call site
Message-ID: <atozok6_aRetCLq2@redhat.com>
References: <20261022122544.125305-1-puranjay@kernel.org>
 <20261022122544.125305-4-puranjay@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022122544.125305-4-puranjay@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Oct 22, 2026 at 05:25:38AM -0700, Puranjay Mohan wrote:
> Test that klp diff rejects a changed function without an ftrace call
> site, both a notrace one and an inline one emitted out of line, and
> reports each of them.  Also test that a fully inlined function and an
> ordinary function can still be patched.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  .../tests/x86/fixtures/notrace_target.c       | 71 ++++++++++++++++++
>  .../objtool/tests/x86/test-notrace-target.sh  | 74 +++++++++++++++++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 tools/objtool/tests/x86/fixtures/notrace_target.c
>  create mode 100755 tools/objtool/tests/x86/test-notrace-target.sh
> 
> diff --git a/tools/objtool/tests/x86/fixtures/notrace_target.c b/tools/objtool/tests/x86/fixtures/notrace_target.c
> new file mode 100644
> index 0000000000000..64da58c872b8a
> --- /dev/null
> +++ b/tools/objtool/tests/x86/fixtures/notrace_target.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* PATCH_<name> changes <name> in the patched build. */
> +#define notrace __attribute__((__no_instrument_function__))
> +
> +static const char __modinfo[]
> +	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
> +
> +#ifndef PATCHED
> +#undef PATCH_OUTLINED
> +#undef PATCH_NOTRACE
> +#undef PATCH_INLINED
> +#undef PATCH_TRACED
> +#endif
> +
> +#ifdef PATCH_OUTLINED
> +#define OUTLINED_K 2
> +#else
> +#define OUTLINED_K 1
> +#endif
> +
> +#ifdef PATCH_NOTRACE
> +#define NOTRACE_K 2
> +#else
> +#define NOTRACE_K 1
> +#endif
> +
> +#ifdef PATCH_INLINED
> +#define INLINED_K 2
> +#else
> +#define INLINED_K 1
> +#endif
> +
> +#ifdef PATCH_TRACED
> +#define TRACED_K 2
> +#else
> +#define TRACED_K 1
> +#endif
> +
> +int sink;
> +
> +/* Address taken, so emitted out of line. */
> +static inline notrace int outlined(int x)
> +{
> +	int i;
> +
> +	for (i = 0; i < x; i++)
> +		sink += i * OUTLINED_K;
> +	return sink;
> +}
> +
> +int (*outlined_ptr)(int) = outlined;
> +
> +notrace int notrace_fn(int x)
> +{
> +	return x * 3 + NOTRACE_K;
> +}
> +
> +static inline int inlined(int x)
> +{
> +	return x + INLINED_K;
> +}
> +
> +int inlined_user(int x)
> +{
> +	return inlined(x) * 5;
> +}
> +
> +int traced(int x)
> +{
> +	return x * 7 + TRACED_K;
> +}
> diff --git a/tools/objtool/tests/x86/test-notrace-target.sh b/tools/objtool/tests/x86/test-notrace-target.sh
> new file mode 100755
> index 0000000000000..09414ae65fc2c
> --- /dev/null
> +++ b/tools/objtool/tests/x86/test-notrace-target.sh
> @@ -0,0 +1,74 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# A changed function without an ftrace call site can't be livepatched:
> +# klp_enable_patch() fails with "failed to find location for function".
> +# klp diff must reject it instead.
> +
> +. "$(dirname "$0")/../lib.sh"
> +
> +# mcount_entry <function>: orig.o has an __mcount_loc entry for it.
> +mcount_entry()
> +{
> +	in_relocs "$orig_obj" | awk '/rela__mcount_loc/,/^$/' |
> +		awk -v f="$1" '$5 == f || $5 == ".text." f' | grep -q .
> +}
> +
> +# check <expected exit status> <-DPATCH_... flags>
> +check()
> +{
> +	local expect="$1"; shift
> +
> +	setup
> +	build_pair notrace_target.c "$@"
> +
> +	assert_input_symbol outlined
> +	assert_input_symbol notrace_fn
> +	has_input_symbol "$orig_obj" inlined &&
> +		fail "inlined() was emitted out of line; the fixture tests nothing"
> +	mcount_entry traced ||
> +		fail "no __mcount_loc entry for traced(); the fixture tests nothing"
> +	mcount_entry inlined_user ||
> +		fail "no __mcount_loc entry for inlined_user(); the fixture tests nothing"
> +	mcount_entry outlined &&
> +		fail "outlined() has a __mcount_loc entry; it should be notrace"
> +	mcount_entry notrace_fn &&
> +		fail "notrace_fn() has a __mcount_loc entry; it should be notrace"
> +
> +	run_diff "$expect"
> +}
> +
> +rejected()
> +{
> +	local n
> +
> +	n="$(diff_log | grep -c "error: objtool: $1: no ftrace call site, can't patch")"
> +	[ "$n" = 1 ] ||
> +		fail "expected '$1' rejected once, found $n: $(diff_log | tail -2)"
> +}
> +
> +check 255 -DPATCH_OUTLINED
> +rejected outlined
> +cleanup
> +
> +check 255 -DPATCH_NOTRACE
> +rejected notrace_fn
> +cleanup
> +
> +check 255 -DPATCH_OUTLINED -DPATCH_NOTRACE
> +rejected outlined
> +rejected notrace_fn
> +cleanup
> +
> +# Fully inlined: the traceable caller gets patched.
> +check 0 -DPATCH_INLINED
> +assert_patched inlined_user
> +assert_not_patched traced
> +cleanup
> +
> +check 0 -DPATCH_TRACED
> +assert_patched traced
> +assert_not_patched inlined_user
> +cleanup
> +
> +pass "changed function without an ftrace call site rejected"
> -- 
> 2.53.0-Meta
> 
> 

Thanks for finding and fixing this bug!  By coincidence, I was debugging
this very problem yesterday (wondering why I couldn't load a patch that
modified an un-patchable function).

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

--
Joe

