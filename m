Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AE445AD1
	for <live-patching@vger.kernel.org>; Fri,  9 Oct 2026 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527315; cv=pass; b=EutwiAzkZwUQoFebxnqEmeBdygNJZya+tf59T0aQZRdHbF5tkpRFFhOAGGum5cHhdAwEo6Ftpy2MNGu4k2+hnnxEv+4U68QLyykHRHeciKR8dDgAi4M804WmokG8bRNoEuZ7K1nzhXNmgNLjeUZ75p/hJEm7rhUXMYE9KZQ0oQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527315; c=relaxed/simple;
	bh=nIKpbv2RO8oGZRd2yIp30nXCo/En4v7x/XnTXfq6DPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is3Lqs9+XM1ABIOiwhXaQ8ohBB4xc1DuJZFGYLF+v5JwLpqEHy4ODkciPybV0a58WFWaqtFZTrnwOiDA1FLadx5v3jO3azoxBICjmvPe1DEM/ZuvTDYApw7ueuonkljsYSNbCrg7WQ6bccE6yJTZYSW6VN2PV5L0CsPyxjyZWvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJgE6glv; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJgE6glv"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so5255118e0c.2
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 23:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791527312; cv=none;
        d=google.com; s=arc-20260327;
        b=kNIeB8zGlee+/1J2RF9S33adfYtwzAqF+asCmHi9NmHD/FxF7TaQ81q7GEoRT0gD6t
         mIPYHvRhkoDNiAqhgNeqJFQmzHeNH/V3M5KlEERa888bTN/BM+TQKDpleZrRMR/jxtIK
         XiVu5VW/EbfxbhIXCYoSKBubEjkgE7iHvhz43ih250VaxLgI1zrrWetJil+1vVPjLGCu
         LeL1kuDvibDFaIU16qzPwfolLHx1UwVAyyiGMvrQar+FqTGY9tAJ3cf1JLlsgwAGmG+y
         GTmG7D4I5KOvu0ympOLHX85SVMFi3w2rP4MLC+fmKwTJ866JRpuWqlXtyiwGmbw2A3E/
         lRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nIKpbv2RO8oGZRd2yIp30nXCo/En4v7x/XnTXfq6DPU=;
        fh=4Sj8pkGcq7NQes+Ca2UNDSzfOnlWPzDgrT/kOn14Duk=;
        b=qlJKQ9gdVwrPOuQDqaU7c8sBWGKoP1m4uXfWyserNGrx1OtKBWZLCM+RRlzbJpzM33
         JPISA0ckJYWYCxN4vuBBKPzLG+/x1sd52kcAkQUaMeLFwpsMf30TNjm6/fNAzZ5NrpdP
         cPeZpzrhbZP+JNeb7Y19OJtFJ8bwEYo9yNmknp138L1qTIFesx5Pz4e8ctnFiNdqOR6E
         7Yt5qFVBuy2jh+Pg55Qr8+RDUy0+vW63QrT6TIkA2wLyR7yjST3YSQHsUEHZgoxtiohY
         77j6q5r/oIcmzB5J9hLurMcXl3qgE/VblaLrvtlsaKVeiMeKRqjvsx19zMyA5FG6gnGi
         kzgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791527312; x=1792132112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIKpbv2RO8oGZRd2yIp30nXCo/En4v7x/XnTXfq6DPU=;
        b=dJgE6glvh/SB+lXtYRjHy5lA5iewsp/W6Taf2ASnkkZnxY0dBYQQFMkEPDMyazrRXR
         Mv84WDB4X8P/vLvjSm220kQNQhjPnFalokGe3jkfC8ydqQ8mFRomS9+9y7UecmIRKZ4s
         SO9/azhDqDglFmOoQ1J1xQobTgxZw9JY0vYQKGCHlz80p7NPtvb4toz5vVYqJFXFpfd8
         MRTkNZn4WjfRYKq2XimStKIK4qoKY3wzUbh8aVGQWntjysY27Q7mGNXvou5W49/4rfZt
         xdecPBp7ZUYvfr6/+z6if9Zo2RRhOJ9UZxyBTe3H4aFbAvEzzrHCee1ORXwJIIg3ABC6
         +CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791527312; x=1792132112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIKpbv2RO8oGZRd2yIp30nXCo/En4v7x/XnTXfq6DPU=;
        b=bzbtqNr6jE3whSoD/SNsy13d3C3nYRetWDzUsemTmXL+3Lfturwb/CrbOQ9sGeWRep
         nEkMQeFVqivrChFwqTFUm3hLSpSC3dukHF7piqVcs511mP1SregowQdE9NZM1krgUptD
         nWm2mOezMRJt+WkNW2gh2aKvjQ4U6MXxPSigrDXIQdCpdhMrR+8c6rQ53BSr8gv6vi0c
         dxx1q36qFvANoFxCmBaWAla0XhoQjlQb9xYDnKtRaYbAzqmP1BqEVmPyv4lF2Ce7gyeY
         rHix/qN5Uz8VMuJ6pv59xy5Dlg1Mm4vQT0JGElPtcF37lPMW5eYtP9wSGgCEW2yRzkEf
         HwjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLMq48W4GLNqUeT7fXyR2/m3e18ySYxoCXPM1ivpYiLP9fh1RxiBK0RphtyW+zq1MJLMrpaA0JL0P65vqd@vger.kernel.org
X-Gm-Message-State: AFq9FYKnKca4vr4nj2BmK5LMN9qnZp214pwgEl8/g8uSsKaZ38IQrE9B
	SnuBGVaGzn1G1lwfHACoRKLvCLSltqIV4rFnrvnpOABuHm6XFsHUBS75CptU7CdjPWd/2VbqL/t
	AG308zR3SXLiTFolsfl/J7Znc+jGsGn+33ClWdoI9
X-Gm-Gg: AYBFou27Rg/R4BKp64KWl5l/YP40TZmNHCmtZw6txQOCRr4WxYUP8kGmRO06JAVGSse
	OYu4+mJl77tc/E1jsUTqF5wYC1SzN0ZwUflgRSsAV5L18CoKHHQNr1VBOYzQmJXJMZ91WznvSQ1
	TF8VG1IOcp8MpGgFzQgpPf3tOuAMciNErGErv52q6WpquTQkBd402h9MN3aOGgItAmoWH9BM/f2
	ZRnIFptRWzpEQe51M/ahZYOmxYqXazyhv25fWID6Xjf7JwJq/QrYKadzIJW4NhJMFlaTDR2vsGw
	c7RS6qnAwpEdQn8jBDbh7JvsFAUQr9spUu+aBvFTwO/5r6KREOQfJg4fKRHaBmtu8g==
X-Received: by 2002:a05:6122:e189:b0:5dc:aa1e:8a06 with SMTP id
 71dfb90a1353d-5e91f43f417mr266429e0c.5.1791527311933; Thu, 08 Oct 2026
 23:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 9 Oct 2026 08:28:20 +0200
X-Gm-Features: AclHuK8g8wzpeXyMue5uZareIGGpfm7oWlT7bNlgcuKmGssBskC1rzSd82Cda-Y
Message-ID: <CADBMgpyF+QgmLjX9p9wfikZksFFg47QaQU6fHrnX=y58Wvk-gg@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] unwind, arm64: add sframe unwinder for kernel
To: Roman Gushchin <roman.gushchin@linux.dev>, Weinan Liu <wnliu@google.com>, 
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jens Remus <jremus@linux.ibm.com>
Cc: Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Song Liu <song@kernel.org>, joe.lawrence@redhat.com, linux-toolchains@vger.kernel.org, 
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>, 
	Mostafa Saleh <smostafa@google.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:43=E2=80=AFPM Dylan Hatch <dylanbhatch@google.com>=
 wrote:
>
> This full series is available on github: [4].
>
> Ref:
> [1]: https://sourceware.org/binutils/docs/sframe-spec.html
> [2]: https://lore.kernel.org/all/20260505121718.3572346-1-jremus@linux.ib=
m.com/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.=
git/log/?h=3Dsframe/core
> [4]: https://github.com/dylanbhatch/linux/tree/sframe-v7

Apologies, I forgot to update the github link:
https://github.com/dylanbhatch/linux/tree/sframe-v8

> [5]: https://lore.kernel.org/all/20260821195259.2688377-1-jremus@linux.ib=
m.com/
