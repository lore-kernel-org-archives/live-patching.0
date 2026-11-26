Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795690850;
	b=FkxsPTVi9KTpoCUOTz3uwFMVQ6gJqHzhw2b53YZ5OKoKnQTzX9FUzuEdjfLsrXrHpdQ6
	 BxADjCBP3Wrx0ljnoFbbVZLno3i2lGjAiv+gUQcz8SDs1bxR1IdVtayw5cEIGlySNB+Hm
	 po9UkGy7+Axt56LaAHhJmjEjLthF2d+4OWXS+Cuo73WTJ+N4yxSffEl3dDZPJDCiN5hz3
	 JZ5ZS8E1y5/UuoXJMLFsYE9e2/xRkiVj2LmI0A+vEnZRpj2PS9Q0XEDPgDL6LgBjichzW
	 78d7ZdOz1Hle2LUPGkVfxbGkwkbyYq/0iX8p1AJlmhsHjropBTQspeLGt4AMAT99/BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YBjrgG7MLY5ulGSrGu9idWUw2qJwnhY95Q5JsiJ363Y=;
	b=vgeEBZXRTEDTfkGrsEdUSRTs6fcBciXZ/9HpPf2+j1JnleggXsyI6iYlijx6KxPb69VO
	 eNlv6TBqHSuj+T0VYrGMuTcVKDMXCPgQsGoE/lpFzd+YLGS2gzyc4GAWVLD1DguIB/Tt+
	 Tn+p+V092tQjEbsiEJc+umk/FLWTyfSAHvfYLx804TMm7AD03e2joXQcZE640E3S+a0M1
	 yoNQgbbitJflQYZQwzI+ukXDSst20W1mWoCAEHoFzajT9VfUkCObOycn0NqBWddv2LZZT
	 npoGztuzI4MW0HAC4rQmh9/xaYze+oTDOd5IfqPUcrpzyJZ7+3p2nrx7NQduEGJ1hHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvS1hfLx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359A606A327
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 11:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9359A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvS1hfLx
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67da7d18f2fso7742689d50.0
        for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 03:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795690850; cv=none;
        d=google.com; s=arc-20260327;
        b=gWTGiUIcJiLEZvdXpyFE9PuZNYneBlmYV1xvlPfXkNoN1nYhcTJMhSP0/WG1jfylxA
         qSw7/HFI+bUp360ilYaLB86mbIXgEPtQ321cg1g1v3NWxOSEBqXMBkrPJZgxZWiP7yTj
         d2OU91noZYPFk4QI5o1cEnY3a4cIj7Mwb6BjeOk6ehrKkkMksQGn3LDaIywRpotDBb7o
         s+nMFsLLuOtAbcM7/8VjZ423W94+kxN7XTjjGt+BwVTkwBEiFB90Q3slacR0SA3M7/Ms
         SYmoc6sxTir1LcBg+Yc3gZrBspnIyA8bT19NZAtptpQxdvEa0cwzJPste07MT67+6n82
         oHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YBjrgG7MLY5ulGSrGu9idWUw2qJwnhY95Q5JsiJ363Y=;
        fh=N7tcN1cDpqdzrSFjBP1batJ1IaiuAipqJcFICK4UQTc=;
        b=W5cjgj5MSaAz50GdGREt57uKQPUEP1flS5dzAfffGjZYol+TUKCLAqYW3kLh3Y0HPq
         IcWjBFJ1mmxz6l3/1qaBNKXCM+DQbRy85JN+BXFmzh3PjJI5Q5WuYdmy3CI1+fVmhYuw
         yrT4jXHWdGXj/oPWMhCbJcEvwgn8XEKEErVjwKvJfqVnjhg2OhGjgthZxhuQNm31fqHW
         /DNOTCWKbSOt14mHOBcxs4u6mUJ6H811XU4tfm4Y7jVBikL+t0Rq6H8rUQCtuCdYrY1j
         I9wGS2PvDoNnqxEnQ3w1MySzYx1zwhjx9sDriwto0Zy0uMMdlUMLUOz3Ov6MW7V0sWKi
         ooAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795690850; x=1796295650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBjrgG7MLY5ulGSrGu9idWUw2qJwnhY95Q5JsiJ363Y=;
        b=pvS1hfLxhlftEaWbAgidd2ly8kGrGI4XkzJQDvuzbvyETadHYLmBq7EEkYpOCtwMkn
         XdER0L0sZyTM0GDLXrOe1uAC59a5Z7IHbTpipsKWfqA8s/CA3xE4ynITkny/kxfZwKP6
         jLPiZAE9faAhc7/sO0ymg/Pa7sxvAv8PYYCpHVMKbGebBVlytTmF1IXEMraNZNRLdIpM
         OOPwiJuvYuy/vmLJB8TJVRQFlA/NPikevlKIQ23YP4R43TEnaxmAWEGvs7VLW7lXQyTb
         5+sVjLgppZPh8f7JVhiRoOk+/3ySPlcJ+6flvWPxv0GvulqZjViIqqcf8ICAokobqj+3
         Ce/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690850; x=1796295650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBjrgG7MLY5ulGSrGu9idWUw2qJwnhY95Q5JsiJ363Y=;
        b=MSPm1r4L1Xfl+17f07lCa4G7GgGxoLV0aC2JyoWeAjKj7yTB5WXzRUvKx1bHZ4mHHZ
         JRsnZ/pfuGM6o/+G8650KVSspgsfofdgfU8iFwzaxmLuKW5+HQyg1Iib9RsLcGE82bWz
         WxhjAyrrv9eMFzaizdy9b8dhIUttXNNcxQrFYTQr3Iwk+OcgprZ6hN8jRnAFeXkNq9tr
         spbqcBrNSj3A4U2iHf+YrItzri06fa9FhFmywYufz4pdV9WHK71aNBoO0WNPq99JcnLb
         A0d0U6e/CHplnk/d/dH3c2fyfs02uT4EITG8Yr538MZG7xG4e8iOsknDsasE4/uUy3ze
         h9cA==
X-Forwarded-Encrypted: i=1; AL+hErFX1y2CTT2iVYMLEJM+gLijzB3D7EwAGbE0yRjzYxAswQBFUWlSiPu8pwV0rtIGYGNSHdnwR8ORbqhTE47r@vger.kernel.org
X-Gm-Message-State: APuU4Z8TOScPP0Kw7yrmuhF2HhqGDz//fJL1QqD8171S4W2GxMWN/a+6
	f4I48KMKYGI1XinjAe60oCI40e0InotNQIhZTKSqnfmaltoEttXviFmpf41kYv5tP+Ow1gg3U/4
	SU1e/AbXVBUaMgMlLyjqFDm3dwbxBc6c=
X-Gm-Gg: AZFdTZehqzVcEEQ6vWtuHKMNjoMpcZQsApk4T6OMtGBQVGNpe8LxJX/vL7EIIzpCz15
	gmM7qqQ4c+tI5wRyBokzDh/de3aJBwa1754wNJeEIUQrW+f4scCnaq1HJk8qrZYxx8astOUzB0e
	vd9VMMQ9FtpgfL1PX9zRrd+kHkEnRopeSYMlzkvGHbY8Cb+BSDeLqfI6BEwJk+EM4WVvhycEeGR
	lWcS3abhZTJPe5gyzHHqWnni5AFL+N1xOhnaGvnp733QngUmPWyI/i1XsBFAlpGW6Z4bT7MPgsx
	2crixUEfGzTjzCtL+IrQcxANQ2IT9CwCUVBHzJb5NcyiDh71pkpT6b+uih56WXkgHmGbbEHNzaH
	KRj0zn2PFqy9ztb1wj+mYlhR8eOq1jTL597MKWw==
X-Received: by 2002:a05:690e:480c:b0:67c:6bcd:b905 with SMTP id
 956f58d0204a3-67df440791dmr4500687d50.10.1795690849512; Thu, 26 Nov 2026
 03:00:49 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-2-luolongjuna@gmail.com> <avZ3jEbnuVu5Qv2G@jpoimboe>
 <CAKL4jwX=ctyjXmm=Oz_+HXe89vOHWHgT_-KGyL47fOBEQTYJiQ@mail.gmail.com> <avdWaZboJeDyyOMs@jpoimboe>
In-Reply-To: <avdWaZboJeDyyOMs@jpoimboe>
From: Longjun Luo <luolongjuna@gmail.com>
Date: Thu, 26 Nov 2026 19:00:37 +0800
X-Gm-Features: Aa3M54rwjsZu7jMc1Fcx0xLlcwpmIPWCqXj01ITTPuucs-yBR6GhxYBGJrQyqJo
Message-ID: <CAKL4jwXZQKf2XrkRmpws3BK6x6iyMD+BRY-NMfqzR1DMmowadg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/11] objtool/klp: Fix checksums and copying of
 wide strings
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, live-patching@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I sent string-related fixes as a separate series.
https://lore.kernel.org/live-patching/20261126105325.2521938-1-luolongjuna@=
gmail.com/

On Sat, Nov 14, 2026 at 2:27=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Fri, Nov 13, 2026 at 12:32:20PM +0800, Longjun Luo wrote:
> > Sorry, I left out the debugging context here. Both comments refer to
> > specific kernel build artifacts:
> >
> > On Thu, Nov 12, 2026 at 06:42:36PM -0800, Josh Poimboeuf wrote:
> > > Please give example(s) of such "wide strings" in the changelog.
> > >
> > > > +/* Wide strings, such as the u16 PSR setup table, end at an all-ze=
ro element. */
> > > > +ssize_t elf_string_len(struct section *sec, unsigned long offset)
> > >
> > > What is the "u16 PSR setup table"?
> >
> > PSR stands for Panel Self Refresh.
> >
> > Source    : drivers/gpu/drm/display/drm_dp_helper.c: drm_dp_psr_setup_t=
ime()
> >             /* macros expanded */
> >             static const u16 psr_setup_time_us[] =3D { 330, 275, 220,
> > 165, 110, 55, 0 };
> > Section   : .rodata.str2.2 (SHF_STRINGS, sh_entsize =3D 2, Clang ThinLT=
O)
> > Bytes     : 4a 01 13 01 dc 00 a5 00 6e 00 37 00 00 00
> >                         ^^^^^
> >                         220 (0x00dc) contains a zero byte at offset +5
> >
> > objtool   : strlen() returns 5. The checksum hashes only 5 bytes, and
> >             the copy includes only 6 of the table's 14 bytes.
> >
> > > > + /*
> > > > + * FIXME: GCC's range_string() uses a one-past-end string pointer.
> > > > + * strlen() reads past the section; preserve the string base and a=
ddend.
> > > > + */
> > > > + if (entsize =3D=3D 1)
> > > > + return strlen(sec->data->d_buf + offset);
> > >
> > > I don't understand what this comment means either.  Please make sure =
all
> > > comments and changelogs are written by humans, as LLMs tend to write
> > > nonsensically.
> >
> > Source    : lib/vsprintf.c: range_string()
> >             p =3D string_nocheck(p, pend, "[range ", default_str_spec);
> > Section   : .rodata.range_string.isra.0.str1.1 (8 bytes: "[range \0")
> > Reloc     : range_string.isra.0+0x9a: R_X86_64_32S .LC22+8
> >
> > GCC note  : Uses .LC22+8 (one-past-the-end pointer) as a loop bound wit=
hout
> >             dereferencing it.
> > objtool   : Passes offset =3D 8 to strlen(sec->data->d_buf + 8), readin=
g past
> >             the 8-byte section. Fixing this requires tracking the base
> >             string (.LC22) and the +8 addend separately (left as a FIXM=
E).
> >
> > I came across both while testing on full kernel builds rather than in
> > production livepatching, so I'll leave it to you whether they are worth
> > addressing in practice.
>
> It's probably worth fixing, just the comments and commit log need to be
> clear about what exactly we're fixing.
>
> --
> Josh
