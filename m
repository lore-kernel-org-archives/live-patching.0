Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402235295C
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509377; cv=none; b=GOjMHmN7wzCNfP8HOcUJC7XnxYvnTjq0+Dfyg85oACxPKcmRNMdcbw2/UsM5CUXPFn2n9HtbK25wan7LzAqh5vHlOE7Co8yOzkbPbXJH7piizjByoZApna3prGWlRm6yZFs9wu7c/mcI6sHJL1C6/iSBDsnF5ImQuCCu6+yHe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509377; c=relaxed/simple;
	bh=gKPQVc+cna4+Hx3kVZSzb88SEZbuTTuSs2FHp81Jemw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofe3tJ5mg5n/oiRbywTfU+Mq4W3eTzJm8oD9ynSI5juB7CG0SzbEY698b4iT00IZ6wzFx8awTv6a7LhxVGjdX0xuI27FoAHWnMCIVCEarFQwrNQtQrNuMUF0+4BI5fYA+Xy3A2rng+ketb4TuUqDNX2Qdj5mytyYtyBxkcBH17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUv2AeVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUv2AeVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB81F0089A
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789509375;
	bh=Tk2ETKTorV/A6TS8+8Wkf7n3G73+O0mzgbaD7rvcfy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OUv2AeVQ/pyEVkoBhhkDHBZ62XdLnI3aaLrHK7U+FkpIqoJpOF95fGczifsI7fjxF
	 5oC5laQNz2ibS5mcj6fphjVXJ0rK3IF28V7ZGDnhAKC1flLwnCSsqGZzbT8Gumiyp4
	 0bEZkwtpSuFrm91ABkH8Ciqb0iBwbF9GnBdunTKigKzn+uQcXYY0c68ztu8esqdkQx
	 SkwK9cEa5N41YffQCnSiBvYbBnceEKsANgk9Yo2q8QwVeL8Z6c5J3mbhPwycErTDiF
	 2m9xFcdBDEvlAIfsrIJC35MVru/lRttOEJAxYxU9lwnJ1aXUhTqTm0iMM5c144MIez
	 R3M4IewEFJDbQ==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910a0cefaso23705885a.2
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 14:56:15 -0700 (PDT)
X-Gm-Message-State: AFuF++lMopFt2nNqQEDaE3FqPeroaj9blCFTFIkHrj0RfXum3oUiOPZx
	QaZmNYfZeU9U6tBe6/oziBPqXjKkJ2F3jKOzhiPhOaIqpVrF0KZjs3fRYZ7bx7MujFEbYGWROQn
	Fi1RAJ1wGuGBnPqQy+abXzGnRPY/p4eQ=
X-Received: by 2002:a05:620a:8014:b0:939:fce5:f6d2 with SMTP id
 af79cd13be357-93bb78f9fcemr12260585a.27.1789509374826; Tue, 15 Sep 2026
 14:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-15-song@kernel.org>
 <20260914234620.122791F000FF@smtp.kernel.org>
In-Reply-To: <20260914234620.122791F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 14:56:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4+CgzPEsosV3dzw5BhBty1eiLwSPVTk3QazN+_nKh4ow@mail.gmail.com>
X-Gm-Features: AcwNN1UdB_AtXXP_PuSuSEcBB1v4fjnD2paULr2tbVU4aGfVGfyL9qC8Kz-ZqB0
Message-ID: <CAPhsuW4+CgzPEsosV3dzw5BhBty1eiLwSPVTk3QazN+_nKh4ow@mail.gmail.com>
Subject: Re: [PATCH v3 14/58] objtool/klp: Add test for newly introduced functions
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, pmladek@suse.com, peterz@infradead.org, 
	joe.lawrence@redhat.com, jikos@kernel.org, jpoimboe@kernel.org, 
	puranjay@kernel.org, kernel-team@meta.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests/objtool: fragile symbol check matches section names
> --
>
> commit da3ad59507d5d910ed876f2401fd7f2746140303
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> objtool/klp: Add test for newly introduced functions
>
> A function added by the patch has no original to correlate against, and
> still has to be carried into the livepatch or the changed caller ends up
> referencing something which does not exist.
>
> > diff --git a/tools/objtool/tests/generic/test-new-function.sh b/tools/o=
bjtool/tests/generic/test-new-function.sh
> > new file mode 100755
> > index 0000000000000..17af18545b7de
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-new-function.sh
> > @@ -0,0 +1,17 @@
>
> [ ... ]
>
> > +setup
> > +build_pair new_function.c
> > +run_diff
> > +
> > +assert_patched target
> > +out_symbols | grep -q 'klp_new_helper' ||
> > +     fail "new function was not carried into the patch"
>
> [Severity: Medium]
> Will this grep check falsely pass on newer versions of binutils?
>
> It seems `grep -q 'klp_new_helper'` matches substrings, and newer version=
s of
> binutils print section names (e.g., `.text.klp_new_helper`) in `readelf -=
s`
> output. This could cause the test to erroneously pass if the section symb=
ol
> is present but the actual function symbol is missing.
>
> Could this be updated to use the robust `assert_symbol` helper provided b=
y
> the test framework rather than directly grepping `out_symbols`?

Fixed in v4.

Thanks,
Song
