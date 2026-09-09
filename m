Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E741A680B
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931693; cv=none; b=kXaYw4O2DyCAxTlfWlASy76C9z2TRtPuGK37CUpTBNxhSZGpHPr6s0YSfORs2xrg4WNyEc9JRg5MBj9uDyEh+DFOfpLDMUfVg0ewdwKmWV0nqlRUx7ijTRhAmn2b4Je+bo3Mjtpyh1WLbdsEfBeGpFfZe0SfqJVKha2aqp6H+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931693; c=relaxed/simple;
	bh=8xh9jp59Q5laUNuD7ujDzTGWmuYBbDUzcdRZrorgYN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piCBW9VZ/DOsaCJB03eUHN950f5Ei1hkmSwN0cKFF4jEPLmklbxPCu7o/bFhFqeiz+2cr5j2wHf96dy9IruMxs6j+LyNForbmbc6jlmvAMOXp/ZIkFJ/ruEiwX97zaGdz9CVGVJSMfyYijxDtphqz+fJeXRWa0Q44MhgTQaynko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP4o9v/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP4o9v/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464961F00ACF
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 05:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931692;
	bh=E3rSnZDm37yLBnQyHxwAEe6tbUMOZudkO1lSEVitJms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JP4o9v/ZdkvNAN43pInDm97nlfCnb8yklJ35GLOTGXTV5V39eDh3TYXNKE3jPA0qJ
	 RgTXOCGORqTzz2sOLfWAyBS6Q2XvJS7a01+Afbwwy++fGYhBgfbKe7aeVK7E3G6bvt
	 6ZHlMWt9GS8FxL95eW5gWkf8KSbOtsTVJJFpf4HoF9IQaGlTxmrM55gMiNqIhzmy6D
	 XLBUVWZwaGVlY3jotHoPqTH0g3KGqIgoXaGXOC/a/W1vBQiOOYuAQieezqd5p+ccgU
	 1o7qKldC5k352m6qPSxBd7ir9WcoEG5MFvn3IDcrjeMCXoSI3/o70G+BiCeVMEdFCZ
	 a2cN78k6G0Rsg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9377f717879so267719485a.1
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 22:28:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByrikviw6tCwU5IsVKaX7gMMZtLTOb7oAZoeT0cpJrNTLugFhn+SqW7QqfVPHfIEpuzQEpX0bIf+/hBTPHl@vger.kernel.org
X-Gm-Message-State: AFuF++kvszz7p0FNWY56INqz/Eb02fJFroDO9mYIFpuTvDbGJ4l1LMLm
	BWuJSXFmsC7AA1qTF09ANQMGN5i4HceG7Zx0XMkcXQlokn1H235ZY0mAKXO2XclxQmSMC56sE+T
	UPdTJg01TRxiBpq8BpsDRdOFYDQyktPU=
X-Received: by 2002:a05:620a:404c:b0:939:3cb9:553d with SMTP id
 af79cd13be357-9398048b9f8mr4085625685a.38.1788931691488; Tue, 08 Sep 2026
 22:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024324.16002-1-laoar.shao@gmail.com> <20260909024324.16002-3-laoar.shao@gmail.com>
In-Reply-To: <20260909024324.16002-3-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 8 Sep 2026 22:27:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7iK5QeOGdbNr=0ygch=ySNbUuVPdvy2BWFieFAb14u4Q@mail.gmail.com>
X-Gm-Features: AcwNN1WMHGj7rWiPhGSYmUCL_w0llGLTGSOIOjpNGvTxaveIyEf6NrV54kX7r24
Message-ID: <CAPhsuW7iK5QeOGdbNr=0ygch=ySNbUuVPdvy2BWFieFAb14u4Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:43=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> The legacy "replace" field in struct klp_patch will be replaced by the
> provides/obsoletes mechanism. As a result, the atomic replace
> selftests fail to build against kernels that only support
> provides/obsoletes.
>
> Adapt the selftests so that they build and run on both old and new
> kernels.  On kernels without the legacy "replace" support, the
> replace-related test cases are skipped with a SKIP message instead
> of being run.
>
> The provides/obsoletes based selftests will be added later after the
> provides/obsoletes are substituted.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Shall we add functions for code blocks inside

   if [[ "$HAS_PROVIDES_ATTR" !=3D "1" ]]; then

etc.?

Other than this.

Acked-by: Song Liu <song@kernel.org>
