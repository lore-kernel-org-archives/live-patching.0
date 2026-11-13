Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794536278;
	b=wwRprDFs9nde1Vp2ZXMc7vWuIzKAbo27F/f5tzLbZcgJUERQo1n1vARGzudFrjbq/g/B
	 AlzZ6Ivpr4M0Q4e+PKVz0n7EnX2tjPqMSsMvJQI36dqr08503HHySK05ZBdSMnK1Me0eF
	 2qzmqis6C5VDZrkOmptON6IrdeP6tAiGpmNmH/suJyCA7vAIqlixThgC8vRHZaPyHxj2M
	 8odkgXlsjdp+5XFaD4TENTZqXciYYZhEnLBKkTeaO8sDYlCoQ+UO7+tu3PyJ7xc5zbuh7
	 H7AsKcC/h1OvOZ8sc7SMbkDNx907BLrGu82jhSfPfeTgQssavsqJrClMJRXAUHVdcKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mMoLtoKVHPH3osTrOZ4lwcy29Ei9HXsWDANwzVPqOLQ=;
	b=F0FAY89CIrHxNUrymVD8+5oiQPKojyudDhZgGYjX+oovaLspN6iwVb9IrapUNn322ixh
	 Zja16obqgLNFRSmXLPK+xWEQ0x/nKlgBVbPgviP57NzuolRywW1FKGrIS9Yww2Hd4eQ1M
	 e8KUUXPaiiA7mfzIpeJGlB9WK9E+Vexxdq5CgsV6VmTpdnepsF7PnxW216HrGbNzigr4t
	 YxVtGXgavb9h6nurQAkmG9KfB1pOox6mblUr1zs0Z+vsWHboom4nOHGI30EjrRmdKJlIT
	 7l1XgHgN4LnfUAixRD9WuOBGYEEZRRqcuVebi8+sItia1QpBfAckgOKXE1JJqV9NV+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XzYSZ+lJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CB606A327
	for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 02:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B89CB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XzYSZ+lJ
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b3402105b9so4861307b3.0
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 18:17:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794536277; cv=none;
        d=google.com; s=arc-20260327;
        b=Zl3/9QUm3DGL9xe02Py9k0hLNnKnI9srIZ4ndvdn1YgYI+b8AvO3tstL3SuKJLiiOL
         CVZum+4lZnWxIHf9DMnJ3yIS139I85/8AlzThxMpAZ9cDcE3q8ndezCljVxffL/F0/na
         Pzo/nsErfSjK+D6vCESacbEu49aEHDt7PZfss2ZBxF5oE/xFja+gfd+nphuoGiKXRFXk
         iqmujn4kboQkv7K5ee4jqseWLvEmhw6hfyiVecq7jzzm88gJdvVOXxqI1RnUMlP3IeV4
         6F+pjamhAjDgIC4xVoRZ5kBQC4jgBtCZhb++UqB0PJGVtYjlKhmyy0oqKQLMNaA65o6L
         DsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mMoLtoKVHPH3osTrOZ4lwcy29Ei9HXsWDANwzVPqOLQ=;
        fh=0Ka9UBNsP2P77q2Hyh1ThtDHmbS1DUPoS1KtYhIvKIg=;
        b=GrA2cpWqRs92DgwS/wO6+Ajeb7oO8nEMlMwVz8rrvGQaX2sgvatdkl0YMioYzhSGML
         hzGqNtNAFu6Eg8Jw3WDrl1UJaH1cAv5ae0LniEG8jeujTs2EkiFwWiLDEkFg7JEOaVrg
         ukMDnNggesEE75+M+VI9iZKcj4VXZYFciYOjK0tbr/eL23wePqJ2YOlHwpbV5gK9egoG
         sNT9flsxDdEXHkHk7ygnuQS3F2UPTvbIFCimqLrPxuGe/SRwKXCodWVZvl7L4VtGCFl+
         OWoSct7LMVUJm5tHancihaU1Z6/u0cqueqU3+D9tnDv12Bahkw+QH+afdeSUbfDJ+u8n
         DWRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794536277; x=1795141077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mMoLtoKVHPH3osTrOZ4lwcy29Ei9HXsWDANwzVPqOLQ=;
        b=XzYSZ+lJyTAUK6ilnqwqKx/mfzWPe+1ovySBh/fHlHVSS/Vc30zGNYEjD7Rd9m8di7
         RF32Jt7OuWr9OrYLtpGXq7jyrTiYy63yPlczKxUz1bZEU3ham3X2VzuiQiJA92V0CgNH
         3S433LSJvW4CTBgNzKBCVhH/PG41TKQnuLHUuRkoKu4MACbNhT74ZQ+aASjXIh8DBBub
         hs9juuE7hx3wZwzOCLSBnyaAKIql4tGXqDQV1JA3Id27Zv9/pc96c2bclrh51pqhv34m
         lt4ZNjVWqJwGutxZl3ju+wkdarO4dILHzaEJuU2UFjF03tHbFyx09hHpgmIrq7wmABTk
         AffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794536277; x=1795141077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMoLtoKVHPH3osTrOZ4lwcy29Ei9HXsWDANwzVPqOLQ=;
        b=B0pjjvnTABBPDDuNfluSfuEGQyeTCWFevvenVIlEYZ1Pr1E+fSrBLU1TxCk/HR3/No
         RzC15Lh5eDBdd63PPAaa9HVVZJjjGmfDiWKHWh2FQbouBeR/zsdkJ5olechvlXaBWles
         oO+M8vdPWVGe9KuqjWCmqcolhmkkTyrXKYvlniN8dw2AhjqpBweOYnwZ11fO/tk3mL7T
         eNKvyFfe/zqZs5XIQ1/wFpW9cOzJfbemZe+x0SaLmMM1Ggn0UbTr+SSQM7RPnc2tr0iX
         e9PKX/XT0auC/CLOwP7M4eJ3NKWFR3XHyUEUp5E41YhAhTDMf9ozID1VQvkZ6Vs6ePsS
         RpvQ==
X-Forwarded-Encrypted: i=1; AL+hErGt4J2Sq0HkOHhS4xluwUnuRcjWk0kYf9pjl93ZNF2sN28u3vrEezaQV8G06qQqdoohvkXTidc81mbTJGUs@vger.kernel.org
X-Gm-Message-State: APuU4Z/Cwipvm/6iECsKwu4pUZLNRFWWII9NpH2a38+8lwC/X+hVambm
	Rt44oHLOuArRPMb4Sj9m39Uuadhy9rNo9HvNB5JI9Rxyo9K8CUR+yP/YEZ1HRd+10btV47LItzF
	SikoRCnXpS45bNnIBep8TXLZvnlY/0hof+vXC
X-Gm-Gg: AYBFou2o0zpWW6oxRdtARmUzvt0enO+DQ7UFf9LKPcuUiP1vl0RqgvidntzlQeSllTX
	3KR4H8wiq8jMFirNQFmqYj+ecjPYp5saYZLA0ZAMCyXcLb+YaOAZ93T2OmH5JA8KocRF0/B/ERl
	50xkg//Fzkb12dC7nCTSQuENSvP/F/ZlMsmq/O0SZMOR2CPXjbEaWUadxLIY6Glvz7JPlK3gfXi
	XtYfAoEeteO98aecmiJpUlFrUBZgKRf2bZc4TezaeYK35Budz5IpJ8P5HeSYi9pCLzdQ9elB9Xd
	05ZCsyE8QZ4skBs9HOKaHsGERp2bhzKIro967+dr+ttxImYc174zaJvkexMkb81mQyJmmwonL1D
	WdFJIsLgA+m2npuGgrQ1O302/Df8qVETVBhtQu22mHqbwNPQZg/NavaPxr6mTYbsQKPo6qJtJOe
	OjYdrbs8aj2hdq
X-Received: by 2002:a05:690c:d81:b0:8b3:7782:677f with SMTP id
 00721157ae682-8b4aa38fab4mr7489937b3.92.1794536276704; Thu, 12 Nov 2026
 18:17:56 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026133651.40061-1-laoar.shao@gmail.com> <avYNu60V0spG_xIf@jpoimboe>
In-Reply-To: <avYNu60V0spG_xIf@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 13 Nov 2026 10:17:20 +0800
X-Gm-Features: AclHuK9z04O_rInSIsxR6V59YpeEoWUG-2HR08CxR71RNvbY-rJ-pyw53dV-fPs
Message-ID: <CALOAHbCGy+tDn6b7rt11H99odZzRG6V67c17ToeHb_0SqVdxWA@mail.gmail.com>
Subject: Re: [PATCH v13 0/9] livepatch: Add support for scoped atomic replace
To: Josh Poimboeuf <jpoimboe@kernel.org>, Petr Mladek <pmladek@suse.com>
Cc: mbenes@suse.cz, joe.lawrence@redhat.com, song@kernel.org, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:05=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Mon, Oct 26, 2026 at 09:36:42PM +0800, Yafang Shao wrote:
> >   selftests/livepatch: Clarify test module file names
> >   selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
> >   livepatch: Make klp_find_func() non static
> >   livepatch: Call klp_init_patch_early() earlier
> >   livepatch: Implement provides and obsoletes for scoped atomic replace
> >   livepatch: Deprecate stack_order
>
> s/Deprecate/Remove/
>
> >   selftests/livepatch: Add provides/obsoletes test scenarios
> >   selftests/livepatch: Add state test for provides/obsoletes
> >   selftests/livepatch: Add function test for provides/obsoletes
> >
>
> With the subject fixed on the above patch:
>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks for your review.

Hello Petr,

Would you like me to send a new version with the change above, or will
you make the change on your end?

--=20
Regards
Yafang
