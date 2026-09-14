Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BA374A02
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422176; cv=none; b=UsHoKbXR0RQCJ7Ar7qULP6vAD6CseMXfepP6hEiTE/C5Rt29v1jzLSflR2aXoLRFR93Sd+Wm3pleVS9YiH1KffXXSj5kDdBZtILJaiPopJCiLaJMR3/l2wEp3H5FGlel0yT6Gl9i5Yo3RMsXgPQnOCuHqc4efT4Kc4VFfDihE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422176; c=relaxed/simple;
	bh=/BQ9F7h2741+9Wtwuj6YQq+usQ0rtrjgcFX/AqviUYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THsdhDVudol9xhLhwfiG/EHI0sTaHNWtWhyK5nf72ZxHIhDbY8MXw1zxqyGfb4tZJ+AUNL96RFRNhYkLKBsZqb1YY/Bpn2Rk5v4Fq8OOdTSC6fgnqIyteuQqGYoYQgS0iH7TiR/9ks4jbkZ3U0soK/SvPA9XkR3jFcdoSCQLxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ+yy9fg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ+yy9fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285061F00899
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 21:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789422175;
	bh=A+dgOxZ9F9PXL1RbM5QMwfPZZaOR2JbMJwH5h5iLJFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YZ+yy9fglAfNEHDrzqZJ+eSWB2L/ANFfBKrrcYwlTUvO86fj7wB+Uv2W/Zo2FI6bv
	 qa/261adKYXM8II9153/k7P9homZtaT3WhKVKwilCW/E9Sa79w6wj5zRBpiJB32P2J
	 gFZOxAkdbuXfcuLaXqbw08VBvos+yEau+iQmpAHwvIjLxwPJbSPpUQulAO8FMXc3cP
	 7SUBeXyMaVUdmOBivGb+NiX7L5+5MqZpY4OfepDEg9LJZkWBIoIwBSWd7kYZQtkxNS
	 IJCbIzqyu/m+HEVAn+YgNt1bXPZuEytoBH/Lnnj5kUdhc9FwcU1f3CwCF0zKbrUEtd
	 nIH9aEeBYjSBQ==
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcc3e14so10048836d6.0
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 14:42:55 -0700 (PDT)
X-Gm-Message-State: AFuF++m03Ji/F6SCGTlyV3OJFtDq4HR2YxfeImXmnlKqYZfHMuTFnh3k
	iwR3foFNbgwmVxBBK0qoA1AWqu9VA9YjB7c8L9gbdXpDzJCXI1H2aasiFR8wDRQXcoNJToD2TUC
	aQkmvl40r4shmX40ucK4jOYiomPU3tR0=
X-Received: by 2002:a05:620a:468a:b0:939:f188:6d98 with SMTP id
 af79cd13be357-93a345f9f86mr177567385a.10.1789422174263; Mon, 14 Sep 2026
 14:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-37-song@kernel.org>
 <20260914064652.3D9591F000FF@smtp.kernel.org>
In-Reply-To: <20260914064652.3D9591F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 14:42:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6rFMsr=RX_dbv33sHQrO-6gssd-2RDYFXzFJjZavEMMw@mail.gmail.com>
X-Gm-Features: AcwNN1UaxSDMMSrKy18sdowghGKr-AoRCPXxzuRPGLgxH7h8BCPvHNfmU1zpLjQ
Message-ID: <CAPhsuW6rFMsr=RX_dbv33sHQrO-6gssd-2RDYFXzFJjZavEMMw@mail.gmail.com>
Subject: Re: [PATCH v2 36/58] objtool/klp: Add test for position-independent checksums
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, jpoimboe@kernel.org, pmladek@suse.com, 
	joe.lawrence@redhat.com, mbenes@suse.cz, peterz@infradead.org, 
	jikos@kernel.org, kernel-team@meta.com, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The test script incorrectly assumes that if target() moves rel=
ative to the section start, its relative displacement to callee() must have=
 changed. This allows the test to falsely pass if the compiler shifts both =
functions by the same amount.
> --
>
> commit 3328da26fa650b64515b357106fb0c92f158e5b7
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Add test for position-independent checksums
>
> A function that only moves has not changed, and its checksum must not mov=
e
> with it. This commit adds a test to verify position-independent checksums=
 for
> non-relocated jumps/calls.
>
> > diff --git a/tools/objtool/tests/generic/test-checksum-position.sh b/to=
ols/objtool/tests/generic/test-checksum-position.sh
> > new file mode 100755
> > index 0000000000000..459a718d75e7e
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-checksum-position.sh
>
> [ ... ]
>
> > +orig_off=3D"$(in_symbols orig.o    | awk '$8 =3D=3D "target" { print $=
2 }')"
> > +new_off=3D"$( in_symbols patched.o | awk '$8 =3D=3D "target" { print $=
2 }')"
> > +[ -n "$orig_off" ] && [ -n "$new_off" ] ||
> > +     fail "target symbol not found in both objects"
> > +[ "$orig_off" !=3D "$new_off" ] ||
> > +     probe_skip "compiler did not move target() between builds"
>
> [Severity: Medium]
> Does this check guarantee the relative displacement between target() and
> callee() actually changed?
>
> Since the test is built with -O2 (which enables -ftoplevel-reorder) and
> -fno-function-sections, the compiler could group globals and statics,
> emitting padding() before both target() and callee(). In this case, targe=
t()
> and callee() would both shift by the exact size of padding().
>
> The script checks if target() moved relative to the section start:
>
>     [ "$orig_off" !=3D "$new_off" ]
>
> This would evaluate to true since target() did move, allowing the test to
> proceed. However, because the relative displacement between target() and
> callee() is unchanged, the encoded call displacement bytes within target(=
)
> will be identical in both builds. The checksum will trivially match witho=
ut
> exercising objtool's displacement-masking logic.

This is a real issue. I'm trying to fix this by enforcing some alignment fo=
r
patched version.

Thanks,
Song
