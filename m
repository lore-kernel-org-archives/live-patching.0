Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C653C9EF8
	for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201858; cv=pass; b=mQIHTek+dyWRI/VfxUbHPoW+vlQlhkN4BDqznZamnPS6HF71v69sr4Uyc7rRFefGF0CtrUFi3mDb+f7dUhe9IgalqOA53NjT02HXicxOfjrObN6HSKdoiiS0v8/kBZKweP07kfHdGr6NoRF720tLwmsIHAkUm6Mihv5HGrTN0AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201858; c=relaxed/simple;
	bh=rD4VubolRfPW2XJbGGmE3B0gKz/GN3+o5KWgHsdHBRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi1Z90o7gVgxAD4AWet2SnHUGAbzU5WRcyC6HajrkYL50IhT6akberHXIdJp+saYgZwTmQrhpuYTeh7/Fnm5+warBn6CylXaX0XHlbhBJY9J7I+cK80BtY+F9IcyKv9hwMeg4mMwvMDXZtQ1w+gVCEAjqsRPemx2TkuRbua9AHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA+GY2aK; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA+GY2aK"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7fdeab38240so46892807b3.2
        for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 01:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782201856; cv=none;
        d=google.com; s=arc-20240605;
        b=Hd8Zor4jmG0mOPZBcdLlXUFv9Roz3WYwETedUxZ4s6wnYO+SxH1J7vTDMsy3zveL0Q
         n/qdNpL2pKbECP5oQHG2foaJXW2TiXFXxeGmErwHnkM8OBcrwYJT6a1Te0UGPxK7wFXl
         gU/NNIxfBxoVnUrIRwq9K229Ci8AXtmrk0/4fIEFA4E0cmRctxCFAX6z7ZIrUM+pizdJ
         J1JAUtueQ3MWiFSKRnRAkMb4n2vT5HSjRF7tfhkOkZBblQMH0hRZnzTuQz/4SzbmL42K
         3OuKTtDCQx1LJvb0Q1yGAgxOV1cH3u8IiYUgPLs+MWvapU3+tf6IyYopPLFM0l29mW6e
         aquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alyjgtaODVsXtqQQlkODyv0LgxjgNhNMRtb6SqFU+Fk=;
        fh=RqNlRUKU+l7nyIhhO2QAIafcqbUshMLLCCzvktrpfhw=;
        b=bgDE1K2WUr5633lYsfz+My931nyWafG4DrAdezvVhhRCiRjFoZPSNQRJwWQC7wjWC8
         bJ2RSao6NnWNyNd7HG2K4qOeMtMKMbf8cbe0AU5MTGPDKOwhZWC5SksaA+S9C82fqrkt
         E3BJptkB4jrznawrDUEmC15vcsgwVbmib5iXeI4FoO6gLoZulSn6mWCNtu4/LWWwjGFU
         gdvmwRZTaJJ6Dcjx5f+y92aES7ypHXxsR2EsjiExtGOlvcy4PnmeFKPpBJgqe+ooZyi2
         Qt3vcXAwk8YZ7wETZaHuAH8W5x/AHVWaFTZj1zoxdQBs4uX2IcoYPa887VpzQwPheCVh
         cmXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782201856; x=1782806656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alyjgtaODVsXtqQQlkODyv0LgxjgNhNMRtb6SqFU+Fk=;
        b=IA+GY2aKgd4dKsB9L/KkFlIYwr9k2U5weCHNFo282//T4RJW/yfuRjE3Z0RoV7XE3h
         A+dmY4xL5DPkUBIuvguh3+1oBVcfY0eMIv+vK++ww1C06EfFbWs/5kb2NTs/dYGzEFyW
         vu+njHAmz3IDglzpEO6d198ohOuBTXt/gbb50GosdtGx4zUNl4jpE7kfDwroA7w3U6Zy
         es7GkRBAq9Z101L5KHnqJFWRXLLxvwESiC5d7Ts5/fl5KrMqlpIyl9LgD96nqj5oYrXt
         z8W4Fx/05fq4ZmCKr4+vgslFSWCSzqsBGEzckRWBfFm08IHN9CgUbHDb5jxVc6c8hB4c
         r1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201856; x=1782806656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alyjgtaODVsXtqQQlkODyv0LgxjgNhNMRtb6SqFU+Fk=;
        b=DTr1QGub4s0nkutTKxHKLcSeNzz75uBOdIm6GsxIqb9wZju7E2Qcm/fNddtNJgsiIw
         kKVi3MhpqDm5QdMLZgnznNFESz7GKuyRL220aHG7nR4vmeZkUsjnww5brhvbVpZha97u
         tg6nt45TJf18MwZ3xcnYJ3wda0d2DFPFMeTeBD7Quqil8TFwTP9qrLFM+/kguUG0J4z/
         /dKaIqmvjdfeBDmcWvhyHE+obXJUMRk3pMtWb57zRK8wgQ2GrdkQcnyjfPI5v2iKGhII
         v17GJ0ZwPgbk+kRhdZV78TdOVOd7sbpCRW5oVHjKMwXUVbtaJaXSVoaE1N+b/yqYD2Tk
         J+Yg==
X-Forwarded-Encrypted: i=1; AHgh+Rpxu2Q9X9sAHsPFy/o/j/ianSRtERmiDCtpdUFvPWPNtNxrnbcuLraLsjv9atCWiaU79CoO49DA6bU2IEgH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3bjeYshGaWW1u8lEfi4AkEVO2/DC/6CkEhp1uhmjp63AfSBz
	iWc+6QVWHqA/44xqEQHyG/3DhU+QbrZmoP27AYLDDq+ZJxP1UuMEewUhPEZHhmCLcdu9zvVlfdv
	Tz5S0RpdBb+6lwu7E3njf2gsMLD232FqbuiaP
X-Gm-Gg: AfdE7cnDpkHp/gfjfI42jAMebPzMX3BXaV1Qd2ad1O+HTUUYGaIXRUuVGtDKkzFBAgy
	c2dLE4dedtOORqmSrCpSTkBX0p070XEEDMq1Py/Vr111FRd1LNev89C2be79Phquy3H+HPM7wyB
	AbS9KcBOtRZ16ezGRzBDSZYve/N/Zi6DsEjfLfFfkf4u8pXdDO4p5i1kXnzPedplkPMss7MfUGm
	aeptRUqIdgsMciPq7vAkrkhTuUp9GY4hKVFZzWk6Kb7s6WoVz0owyo4CzW9ETl9BqjK+XN9ne3u
	M58rapMiy0ZG0pby7K0AgIM2BT7O0A==
X-Received: by 2002:a05:690c:968a:b0:7f8:7e11:d023 with SMTP id
 00721157ae682-801349890bfmr178936957b3.49.1782201855894; Tue, 23 Jun 2026
 01:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512221102.2720763-1-joe.lawrence@redhat.com>
 <CAPhsuW6YGdh4xFcsfUiGtVzLg2nR_cEiQpvmyEN+Ffyf_O53LA@mail.gmail.com> <alpine.LSU.2.21.2606191427090.26638@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2606191427090.26638@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 23 Jun 2026 16:03:38 +0800
X-Gm-Features: AVVi8CewJIDyt-__BDAEoH9Rzq3FthVhAKcdd_6U45G3MqHZ_0-OPaVIupamwes
Message-ID: <CALOAHbA27RHbFMgLvFh36AntYNVyd_m4vAQYkjKJEUEhG6nEXQ@mail.gmail.com>
Subject: Re: [RFC 0/4] klp-build: simple OOT module support
To: Miroslav Benes <mbenes@suse.cz>
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 8:28=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> On Tue, 12 May 2026, Song Liu wrote:
>
> > Hi Joe,
> >
> > On Tue, May 12, 2026 at 3:11=E2=80=AFPM Joe Lawrence <joe.lawrence@redh=
at.com> wrote:
> > >
> > > This patchset introduces support for patching basic out-of-tree (OOT)
> > > modules.  The primary motivation is to streamline testing for objtool=
 klp
> > > diff by providing a flexible and stable environment.
> >
> > Thanks for this work!
> >
> > I would like to add to the motivation here:
> >
> > It is actually useful to livepatch OOT modules in production.
> > When using kpatch-build, we (Meta) generally do not patch OOT
> > modules. But there was one case where we had to do it, and it
> > required quite some manual work.
> >
> > If we can make building livepatch for OOT easy, we are likely to
> > use it regularly in the future.

We previously had a use case on our production servers where we
attempted to livepatch the OOT mlx driver [0], but ultimately failed
due to complex dependencies. It would be beneficial to make this
process easier.

[0]. https://network.nvidia.com/products/ethernet-drivers/linux/mlnx_en/

>
> I know I am late, sorry about that, but I also think it is a nice feature
> to have. Testing would definitely benefit.

--=20
Regards
Yafang
