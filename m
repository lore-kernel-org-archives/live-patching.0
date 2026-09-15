Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48B420E7C
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509121; cv=none; b=GrHAlaGrTWPjoZs0K3rhmmygGA4eVtP6ZSdphG5RajoTpSLb/F5fVDNPcTqiHFSprNkB59rf5cC82zTpjK42hSx30s+6qYQu2Bq+sIYc6JB5aXYecbNvyHIPiQoElPPMBXxG5TcfdTTbWskxZNaf84HgWlnqakf2/VF793S3YJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509121; c=relaxed/simple;
	bh=MzcXOhtCKPxO03FFFXJXau7uXL0Z69cTIv5A/pNVV7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eImVTiI+AcEQ0dUcYlEw5GdLD4AE2oBQmp4H62fsZMpG7cnG45749hTRzwxaZW1StqEXdar9wKgudySHHPhBnD/sAYv9c81KUSPPSbnbDd8kkefW5en/9VgjO/ZPLPzcMNZQA3rTlqbQ9Om+/lBepYMkfr4y5loc7V+O4d9yLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmlZD8tD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmlZD8tD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B51F0089D
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 21:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789509120;
	bh=nNYZbDj37BxVK3qCKOVg+WM7U1aNyTOTWumx9g5KggI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UmlZD8tDU4AkD8aWtj7k0NO9TtYACWoHLxJ64xZqnfO6r7lbeXuYaH+naHerkfqIw
	 YWcjjowx+J/M/vsvCGPhUqPbladTuAl3ihI1lBII8AR+b3agFIJRL9UCu91RK+UKJk
	 fz9tuOWG88fgyh4JHwYrrraJ1yA00Xwu+yaMQIeRmc3jmqEdS5GQ3V0A4gNB/Bb7w6
	 8WG/ZbTpsP/6/pqE7COR8MAtsOj25BTWNHk2XuwxwvIwplSE8pmGKnlOFPA5e5OMXd
	 1TsQtKfD/hIaICDUq9/Sy7l5YktRAYk2fHhC0ByNbJkhsUcy9i7RCobL+oXFiyiUU+
	 WN+oFngKuUGgA==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafddso21244285a.0
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 14:51:59 -0700 (PDT)
X-Gm-Message-State: AFuF++mF0kSshQeu0wnV9coJpSW++4Y/GYe5lqJYYsiyxxX2lepM5WUU
	uj9ozXEuUkejuC0XfCF38Igpr1LCfJTJMa168MLbnG7rQl2Sx5wtJ0f9jLee2ZOGUdjI7+01p3f
	vi+yPc5933avh3oMqU8v56WHpc/UWkXg=
X-Received: by 2002:a05:620a:2846:b0:93a:c69:69d6 with SMTP id
 af79cd13be357-93bb79414ccmr8781585a.43.1789509119139; Tue, 15 Sep 2026
 14:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-22-song@kernel.org>
 <20260915000515.B4B341F000FF@smtp.kernel.org>
In-Reply-To: <20260915000515.B4B341F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 14:51:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6dDO_FqgNQGRoSeFuj-NunQo7RZn5ya6aMRHT6FZx6aQ@mail.gmail.com>
X-Gm-Features: AcwNN1X-LUKAFbDlJ03bRLnPBER184JUdpSEnboDLDEf1y_QH95uCQ_4dOd6x5I
Message-ID: <CAPhsuW6dDO_FqgNQGRoSeFuj-NunQo7RZn5ya6aMRHT6FZx6aQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/58] objtool/klp: Add test for rejecting module-owned
 static call keys
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, jikos@kernel.org, jpoimboe@kernel.org, 
	peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, puranjay@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Low] objtool/klp test: manual .static_call_sites generation violates t=
est design
> - [Low] objtool/klp test: test-static-call-module-key.sh misses validatio=
n assertions
> --
>
> commit 07aa87afa035746af6f6fbcdd7b1840b00a88b3e
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> objtool/klp: Add test for rejecting module-owned static call keys
>
> This patch adds a test to verify that klp diff correctly accepts vmlinux-=
owned
> static call keys and rejects module-owned ones. It introduces a C fixture
> implementing the static call site and a bash script to test both paths.
>
> > diff --git a/tools/objtool/tests/generic/fixtures/static_call.c b/tools=
/objtool/tests/generic/fixtures/static_call.c
> > index 0000000000000..5975986c92eb0
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/fixtures/static_call.c
> [ ... ]
> > @@ -0,0 +1,53 @@
> [ ... ]
> > +int target(int x)
> > +{
> > +#if defined(NEW_CALL) && !defined(PATCHED)
> > +     /* The original has no static call at all. */
> > +     return x + 1;
> > +#else
> > +     __asm__ volatile(
> > +             "1:     nop\n\t"
> > +             ".pushsection   .static_call_sites, \"aw\"\n\t"
>
> [Severity: Low]
> Does this manual instantiation of the static_call_sites section bypass ob=
jtool's
> check generation?
>
> According to klp-write-tests.txt documentation, tests should not hand-wri=
te
> what objtool generates. This creates a synthetic edge case that artificia=
lly
> omits sh_entsize and adds .discard.annotate_data boundaries, which might =
not
> reflect how production objects are built.

Fixing klp-write-tests.txt in v4: hand-written code can be useful in
some cases.

>
> > +             ".balign        8\n\t"
> > +             "912:\n\t"
> [ ... ]
> > diff --git a/tools/objtool/tests/generic/test-static-call-module-key.sh=
 b/tools/objtool/tests/generic/test-static-call-module-key.sh
> > index 0000000000000..9ab373e90e10e
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-static-call-module-key.sh
> [ ... ]
> > @@ -0,0 +1,25 @@
> [ ... ]
> > +setup
> > +build_pair static_call.c
> > +
> > +has_input_section orig.o .static_call_sites ||
> > +     probe_skip "fixture produced no .static_call_sites on this arch"
> > +
> > +run_diff
> > +assert_patched target
>
> [Severity: Low]
> Does this successfully verify that the section was extracted and patched?
>
> Without a check like assert_section .static_call_sites, this test might p=
ass
> vacuously if klp diff silently drops the static call section.
>
> > +
> > +rm -f "$workdir/out.o"
> > +build_pair static_call.c -DMODNAME=3D'"klp_testmod"'
> > +run_diff 255
> > +
> > +diff_log | grep -q 'unsupported static call key __SCK__klp_test_call' =
||
> > +     fail "expected rejection, got: $(diff_log | tail -1)"
> > +
>
> [Severity: Low]
> Should there be a check here to ensure the malformed output object wasn't
> leaked?
>
> Usually module rejection paths are validated with something like
> [ -e "$workdir/out.o" ] && fail to ensure the file was not produced.

Fixing other issues reported here in v4.

Thanks,
Song
