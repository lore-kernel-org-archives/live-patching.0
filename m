Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D394CE67E
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504272; cv=none; b=hkDv8+EAkhXK7czDObtL3Oa7kGm+nBCc6AS7RDBNMT1+j+z7otT4+M9IHtiF77DxmxUO3AIrYMZ2YSjscsYXjPlEhzij3Xi38gmBd3mWmfo09ockM6hA723XO1d5gwrVQ4wmX6QuaMvhcUoZxnsZwb44ID0XiSTApr0u2BWYQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504272; c=relaxed/simple;
	bh=D17fcssPPHgntO6sYGtC953/eS33YpklLTz3YG/tHHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaY1m8ErTUZ00ADSjqy2yOPVr3I9fQRlLYPOkU+rbyI73lIjMZxng5CITqRu4g3xe/47uE3tDS0a8rGMfSdO2uQU7d/RWs7TDwGy7wjNQ65VIlJLW56fa65Tz33a9zyEYHFVJCYrYvQ9ug3hIOYzskwxuPooD4H4qliZvWClXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOXsrFiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOXsrFiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02111F00893
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789504270;
	bh=FBWXluVx1jaJMNxKKm1HopUNeOzvfDXiWVLOj3is80c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NOXsrFiYXO1U/JElBUHiqRgMiMRidi8JBsvS9gN8Slw3a6QifO9u9y78A8wtZTZ+1
	 HK4Vc1Bb7hSyruFdZonM9kkioNXgwgwAjYju9osN3mQd6oiT/WWoWY7vj6+Fq1w+uO
	 zvfz93doNhehJpJIdYmWcq40FPudaJQ50rS6BpbEbkq+n5RAQQywiGoasJBX005heX
	 b1kVe5uJMXfvpYdirbcF/vWFY6v8ZLvi4Uk1URJQmWf2Bj3kruvChimx346EW8o+XF
	 udTIKxBL1oEt9YDT1djd/WzAyAkBuYV2FOCwTVTvmmxFAGx4JlE29UndCly47tW0tg
	 lcs9drkCn9aFw==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90e9ad1a373so10734186d6.0
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 13:31:09 -0700 (PDT)
X-Gm-Message-State: AFuF++lgZ61gCjMfpRkM97zfWmFtXMmpkXvkUtcM7QMkHL8/HmIqzjC6
	and0IzRi8OGsHqFU8zRUrvwNuNAbUTex72fr9SXodf5XASn9fiD/6XaF+tMoruqrId7p8F7ZXo3
	vj96vUaPF6d4mkAz+Dvy+xptpkOFvOeQ=
X-Received: by 2002:a05:620a:6f0e:b0:939:72cb:baeb with SMTP id
 af79cd13be357-93a347253d5mr745846985a.34.1789504269142; Tue, 15 Sep 2026
 13:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-7-song@kernel.org>
 <20260914233559.2C05F1F000FF@smtp.kernel.org>
In-Reply-To: <20260914233559.2C05F1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 13:30:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YG9=dK=QvKuadpzMvLemE0Han1tLV9+_CM+nTo6y2CQ@mail.gmail.com>
X-Gm-Features: AcwNN1Unt1XARvt-Hw6vtay5AL7lyW8dSkDsaN1M-Hxjcq1U3Tk3n0CrAEb_Xjc
Message-ID: <CAPhsuW7YG9=dK=QvKuadpzMvLemE0Han1tLV9+_CM+nTo6y2CQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/58] objtool/klp: Grow the klp test harness vocabulary
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, pmladek@suse.com, mbenes@suse.cz, 
	jikos@kernel.org, puranjay@kernel.org, jpoimboe@kernel.org, 
	peterz@infradead.org, joe.lawrence@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool/klp: run_checksum failures swallowed in subshells mask=
 test failures
> --
>
> commit 3b088080b3fc17cb3c6bcdacd83b5a2febf34918
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Grow the klp test harness vocabulary
>
> Adds assertions for the output produced by klp diff, as well as for the
> input objects. Includes helpers to extract and verify checksums recorded
> for livepatch symbols.
>
> > diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> > index 35be42758ece8..1b1baff80a712 100644
> > --- a/tools/objtool/tests/lib.sh
> > +++ b/tools/objtool/tests/lib.sh
> [ ... ]
> > +checksum_of()
> > +{
> > +     local obj=3D"$workdir/$1" sym=3D"$2" off
> > +
> > +     run_checksum
> > +
> > +     off=3D"$($READELF -rW "$obj" 2>/dev/null |
> > +            awk -v s=3D"$sym" '/rela\.discard\.sym_checksum/,/^$/ {
> > +                     if ($5 =3D=3D s) { print $1; exit }
> > +            }')"
> > +
> > +     [ -n "$off" ] || return 1
> > +
> > +     $OBJCOPY -O binary --only-section=3D.discard.sym_checksum \
> > +             "$obj" "$workdir/checksums.bin" 2>/dev/null || return 1
> > +
> > +     dd if=3D"$workdir/checksums.bin" bs=3D1 skip=3D$((16#$off + 8)) c=
ount=3D8 \
> > +             status=3Dnone | od -An -tx1 | tr -d ' \n'
> > +}
> > +
> > +# assert_checksum_differs <symbol> / assert_checksum_matches <symbol>
> > +#
> > +# Compare what klp checksum recorded for a symbol in the original agai=
nst the
> > +# patched object.  This is what decides whether klp diff treats a func=
tion as
> > +# changed, so a test asserting only that the right functions were clon=
ed cannot
> > +# tell a correct checksum from one which happens to differ.
> > +checksum_pair()
> > +{
> > +     orig_checksum=3D"$(checksum_of "$orig_obj" "$1")"
> > +     patched_checksum=3D"$(checksum_of "$patched_obj" "$1")"
>
> [Severity: Medium]
> Will run_checksum failures be swallowed by these subshells, potentially
> masking test failures?
>
> If objtool klp checksum fails for orig_obj, it triggers the call chain
> checksum_pair() -> checksum_of() -> run_checksum() -> fail() in
> tools/objtool/tests/lib.sh. Since this occurs within a subshell, fail()
> exits only the subshell and its stdout (the "not ok..." string) is
> captured into orig_checksum instead of terminating the test. No
> .checksummed marker is created.
>
> When checksum_of() runs for patched_obj, run_checksum() attempts to proce=
ss
> orig_obj again and fails identically, capturing the exact same failure
> string into patched_checksum.
>
> Both variables will contain the identical "not ok..." error string.
>
> > +
> > +     [ -n "$orig_checksum" ] ||
> > +             fail "no checksum recorded for '$1' in $orig_obj"
> > +     [ -n "$patched_checksum" ] ||
> > +             fail "no checksum recorded for '$1' in $patched_obj"
> > +}
> > +
> > +assert_checksum_differs()
> > +{
> > +     checksum_pair "$1"
> > +
> > +     [ "$orig_checksum" !=3D "$patched_checksum" ] ||
> > +             fail "checksum for '$1' unchanged at $orig_checksum, expe=
cted it to differ"
> > +}
> > +
> > +assert_checksum_matches()
> > +{
> > +     checksum_pair "$1"
> > +
> > +     [ "$orig_checksum" =3D "$patched_checksum" ] ||
>
> As a result, assert_checksum_matches() evaluates to true here, and the te=
st
> silently passes despite a toolchain failure.

Fixed this by moving run_checksum call to checksum_pair().

Thanks,
Song
