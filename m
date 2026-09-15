Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209029B781
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505829; cv=none; b=kyEM4xupIEzLt1IQKyK6Wb5rMxjQRm5GBDJfNPHPvaBSCDzICtDMJbhu0y2JLV1OHH0fHO3GjOMHvI4PNfW//3B3J1p0kbUMXvH0M+qGjLpiCniZ/IvqjghxaB4uebTSRjRCLdpx8HUxAwgGQKgqT7rIIDdlEQNo7rjoZpvA864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505829; c=relaxed/simple;
	bh=F20XL5v8/1WKKj0v3q5wMhgalZtJadt6kMHr5kX4ptw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYPg/Fz8r9LrKU2xmYYvDfgX/hri0A7VSsV8cTrheY/59Xktzqvh6k5/hlfP9VIBG1Ux2aeY/g0AK0m24n4AdjWI9ziR4BxtwQiZs1ynn2yaHzod8tRQpeMGtIdsER2VpZ91QS/C3iQGAcTKz0vbxp+rfmpj618R2HES7Rj+aZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW1ftprL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW1ftprL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B19C1F0089E
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789505827;
	bh=CID9dPM6rVuPkyI+gF8J/cFYJpsH133faCUI+QAzZII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZW1ftprLfuvhAouEGZ0DFTSlISJrZ7/JKMjrBnMBZuvUaGKn/7ohfTLNj2O5hKOX2
	 i1h0lHCm1NTPqBv5YW4aRnn+Uk502od5VNwxEy3V5Czwb3+gYvavHXGOlVFG0NdkLg
	 fy0HHCcIhFN6X0Hd+IGLfz8/WvhlS6rRYnI12ybaq43B/rjXvfp0T5TMZcqcPhnNEz
	 XQuD/DIb0H4209a9DM3mW/Vxroqj0zlshZBcHNvXvxYQzb0DoNlpWcFrZewD3PY9OX
	 MDZIgHctMhr8vJQq3y1326Aeh59VBfWma/sVLWHoR0oWJeYyNzVlVreXgd1Px5nDBA
	 8ULiU2/HcZhBQ==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910a0cb7aso20577885a.1
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 13:57:07 -0700 (PDT)
X-Gm-Message-State: AFuF++nOvMphVxHcHD6wNKxsTY3JBYLoD66LtDibqaqBtobYQYgChTz4
	S9gNEomRDynqArALRlQub3O0AwK8a8TID9tjmDGmSjitjnaknWNlEWVT3B23eOuiD7U4skKUeeO
	qOQtC2vdJ3r+bDxAIlNhD2g2Y492nm4w=
X-Received: by 2002:a05:620a:44d5:b0:939:3100:750c with SMTP id
 af79cd13be357-93a407c7017mr436646285a.22.1789505826818; Tue, 15 Sep 2026
 13:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-11-song@kernel.org>
 <20260914234110.97F551F000FF@smtp.kernel.org>
In-Reply-To: <20260914234110.97F551F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 13:56:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5StkY6=HAu3Ak6aub2g5jLpqBAMJ_=wzN18jH2ND-5aQ@mail.gmail.com>
X-Gm-Features: AcwNN1WTgTGXGVUNUAnxfbd_oHXoPrVTDvPQzalxKuiqtiNgQIn0haUVqb66uSg
Message-ID: <CAPhsuW5StkY6=HAu3Ak6aub2g5jLpqBAMJ_=wzN18jH2ND-5aQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/58] objtool: Keep failing test workdirs by default
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, joe.lawrence@redhat.com, jikos@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, pmladek@suse.com, 
	puranjay@kernel.org, mbenes@suse.cz, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:41=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool/tests: misplaced artifact removal warning in KEEP=3Dno=
ne block
> --
>
> commit 6a850bca1e88fd95f7b038a701cf95c2d9700c66
> Author: Joe Lawrence <joe.lawrence@redhat.com>
>
> objtool: Keep failing test workdirs by default
>
> This commit modifies the objtool test runner to keep the working
> directories of failing tests by default. It introduces a KEEP variable
> that can be set to 'all', 'none', or 'failed' to manage these artifacts.
>
> > diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run=
-tests.sh
> > index e6f1ac1b5d0da..81dd33f1819b5 100755
> > --- a/tools/objtool/tests/run-tests.sh
> > +++ b/tools/objtool/tests/run-tests.sh
>
> [ ... ]
>
> > @@ -167,15 +182,44 @@ done
> >  echo "# pass:$pass fail:$fail static-skip:$static_skip" \
> >       "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
> >
> > -# A failure is the one time the objects matter, and by default they ar=
e
> > -# already gone.  Say so then rather than in the usage text nobody read=
s while
> > -# something is broken.
> > -if [ -n "${KLP_TEST_KEEP:-}" ]; then
> > -     echo "# working directories kept in $rundir -- inspect, then rm -=
rf it"
> > -elif ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
> > -     echo "# $rundir was not empty; a test did not clean up after itse=
lf"
> > -elif [ "$fail" !=3D 0 ] || [ "$xpass" !=3D 0 ]; then
> > -     echo "# re-run with --keep to hold on to what a failing test buil=
t"
> > -fi
> > +case "$KLP_TEST_KEEP" in
>
> [ ... ]
>
> > +none)
> > +     if ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
> > +             if [ "$fail" !=3D 0 ] || [ "$xpass" !=3D 0 ]; then
> > +                     echo "# keep=3Dnone: artifacts were removed" \
> > +                          "(re-run with KEEP=3Dfailed or KEEP=3Dall)"
> > +             elif [ -d "$rundir" ]; then
> > +                     echo "# $rundir was not empty; a test did not cle=
an up after itself"
> > +             fi
> > +     fi
> > +     ;;
> > +esac
>
> [Severity: Medium]
> Does nesting the failure advice inside the if ! rmdir block prevent it fr=
om
> being displayed?
>
> If a test fails but successfully cleans up its individual subdirectories,=
 the
> rmdir command will succeed and return 0. This skips the entire block,
> swallowing the intended "artifacts were removed" advice message.
>
> Could this also fail to report test leaks if they occur alongside test
> failures?

Fixed in v4.

Thanks,
Song
