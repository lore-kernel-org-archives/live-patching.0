Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69A38757C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410325; cv=none; b=Hm2xhQRmAkvrR7QeVX0PJ39S5BWtPvDrrcj3tD1guvvD6urPLsi1hlHimEungHFwVsRYQsOEb6Uxh/+M3SuGXTSdVnnCxXidmmNkjP5ZVP+2HNsnLzfnWj0fCqLV/L9YFhT126ut6LibdfoW30+UQ1NjWBiK1JWRCA470zSEXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410325; c=relaxed/simple;
	bh=sqsbDhf8/vykTPI0FFSA0x67K7EgbRexIgykj5m32F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVbnlTggcJVQ49vrV0wxOcVl4iC7bzNEL2CHLQ1HZ/OVP0RbuTpnh5RIHvZEJhN3VOCvqUvbX+sCyzUULk/n2Qp6KVy6u8d+8roFMHaxWkW4ZzX6i0NqCqf/gxJ7gvbDL8zyaXRNfo7ih5Nx0IJd5oL+1ap74eQERcbGDbXQzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFPBKqJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFPBKqJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883681F00893
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410323;
	bh=pJdmS+x/1vPF2Qs60Ujuk+QWWE5dNTLa5JBaBjShvas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jFPBKqJokivmbz+VQ+0kSyIcRiQwUaQikqLDTNKoqxE6uItQyDkexZS1hFJUc2Dmr
	 zrIcDBgCt7pm9DPingLmI+fGScGo5NfO1C8v/W8A326OJTwGlnIZ4z9sFYQqsAH0l+
	 QQ/WPakwC8If6WJZvvMruSUXaUGWhXrtPYCkPaiCZQDwglzyDeOOIRln2xJN76jbAi
	 sDL4+psmW53CsGP1Wy2GyaZSabDOmmdX0FehC8QdBEJ2xHHsUPtAlEvhHweeawfZSU
	 bpNFLrKE0F4h+aGHQ2bUS8SClavoXmDq2IWMPDOiE7uiC/owA4S57SIPxtqHcaSp/L
	 tlSgsrikj6SEA==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c8so161234785a.0
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 11:25:23 -0700 (PDT)
X-Gm-Message-State: AFuF++kHpW+NIk4ULnV91dHcV7Zk2iW+rXBaaxhj3PYFaPzRE7EKzwPy
	y6469R4Uh9Jw4YBbstcfjI90owF1O8NUuS2/xB3uPHLHAmcuDQ3/501Xk2a06nkIG4k5HWsxuza
	2uXX1u+yuCBMvRJGiitRi85An/CG2ADE=
X-Received: by 2002:a05:620a:2548:b0:939:78ab:3c5f with SMTP id
 af79cd13be357-93a297c8d1cmr542380885a.9.1789410322806; Mon, 14 Sep 2026
 11:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-11-song@kernel.org>
 <20260914063734.71E531F000FF@smtp.kernel.org>
In-Reply-To: <20260914063734.71E531F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 11:25:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6D=wVVNWLOkYBVaSVsVcS=rf2HDW_m7m8AWRWy1=YdLA@mail.gmail.com>
X-Gm-Features: AcwNN1Xni1Kt8KtwU2LaozWdg9R3wKky_BCliNy5lwwVTNo3V8_0n75xlCDMvjA
Message-ID: <CAPhsuW6D=wVVNWLOkYBVaSVsVcS=rf2HDW_m7m8AWRWy1=YdLA@mail.gmail.com>
Subject: Re: [PATCH v2 10/58] objtool: Keep failing test workdirs by default
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	kernel-team@meta.com, peterz@infradead.org, jpoimboe@kernel.org, 
	pmladek@suse.com, puranjay@kernel.org, joe.lawrence@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Incorrect shell logic nesting hides failure hints and masks le=
aked artifacts in KEEP=3Dnone mode
> --
>
> commit 3f45b4f5eca60d068a16adeda22b98b456f84450
> Author: Joe Lawrence <joe.lawrence@redhat.com>
>
> objtool: Keep failing test workdirs by default
>
> Change the default test behavior to save failing test working directories
> instead of deleting them. Add a KEEP Makefile variable to optionally reta=
in
> all or none of these directories.
>
> > diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run=
-tests.sh
> > index e6f1ac1b5d0da..81dd33f1819b5 100755
> > --- a/tools/objtool/tests/run-tests.sh
> > +++ b/tools/objtool/tests/run-tests.sh
> [ ... ]
> > @@ -167,15 +182,44 @@ done
> [ ... ]
> > +none)
> > +     if ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
> > +             if [ "$fail" !=3D 0 ] || [ "$xpass" !=3D 0 ]; then
>
> [Severity: Medium]
> Does nesting the failure hint inside the ! rmdir check in the KEEP=3Dnone
> case block prevent the hint from being printed when tests successfully
> clean up?
>
> If rmdir succeeds, meaning tests cleaned up properly, this entire block i=
s
> skipped. Also, if a test leaks files (causing rmdir to fail) and tests
> also fail, won't this logic print the hint but skip the leak warning due =
to
> the elif statement? This would effectively mask the leaked artifacts when
> tools/objtool/tests/run-tests.sh is run with KEEP=3Dnone.

I think this is OK. We still print out "not ok" and "fail: <none zero>".

Thanks,
Song
