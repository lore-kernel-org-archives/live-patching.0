Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F772D2381
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931370; cv=none; b=cAI1VS83vkhro2W03iYjBlffV1C4tC+tCk6J+UN1O6QLKDEmSiMDt7Wtx5jKGxsZjEac9IMBQw5FcCiW/75nHpHLa3vsAXznwxkqvn/jhT+erU0/rcMGtjRZJZuSrlu4lbA1NTiBUipukQi1IR0kxYfBzGFyimUExJz/KtDIt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931370; c=relaxed/simple;
	bh=WT/sm3spy5/yDO6sWwljMXNxlj3UBBp/mRgK3xWLzmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAN+tuk+zbVGYcyrMSO8miJh/VtlVzImUQpQYLPpuTHHwULsBQxZl25QOQkYS+erYZBD1e3Ttq5sZ72JWYLggB6DT7hEYKXtvAgi5bMhmQT6L7ZJbvUlE74Vb/3alzQLnTpMxOhAd1P97f+A3Fz3a9G45RyucyEDRvdRXuyrTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH8eltJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH8eltJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B621F00A3E
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 05:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931369;
	bh=WT/sm3spy5/yDO6sWwljMXNxlj3UBBp/mRgK3xWLzmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JH8eltJN6kf0VOGLbCxBghfqSYpo/nigCRBgnjHuD+dE5M1Kk6FXUTlBD7oUYxkdc
	 aZT7G8DoF0ZLE2sjg/Xy9qo5Dnsg3mOlshXZAVofa1Cqtfo4wcXDpXusLbsj6nIcFs
	 237w1mtXofNkIQwQNylupzuddiLzDz13zHGpDjFojhFBKK7G2zYkXupmI5EvtuNhl5
	 dnRLUKDPvFLfn/zSyp43DfDdXbW/DEQR2Y9HCVKjHI2SdIS/hb3mutKRqTNNZfHdIk
	 +fJ/THg3WIi5KzVB5QIs8XbfmPXCyKKDyNzb8DhZp+j5qmm5RzqsTk0deHVFKQ9DX4
	 BdesZEsvvXx9w==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939adff838bso202886885a.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 22:22:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZm6IbAiZ0KuFML9Ihv/gXHH07l0jA8Jmcg5TqgmODUDEO4VpO6FF8MLgwtObAMgI2IvRFPt/4q33nA/OI@vger.kernel.org
X-Gm-Message-State: AFuF++leL3H5ztIWYo1IW0CDgU/+dLBBynsUdED1V6szZhd3kg4AxYP5
	KEiaI4kriI3mGvR8I7Sc+13zeAKRapPmqWOcrzaMBK7r7UD0e21fwomGMpIXprZVK8aLQt3NzGM
	9tiTJZzBfgyJM7D2W39e3GzaqteSjbec=
X-Received: by 2002:a05:620a:6413:b0:939:5cd5:e243 with SMTP id
 af79cd13be357-93980324c12mr3770698485a.6.1788931368914; Tue, 08 Sep 2026
 22:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024324.16002-1-laoar.shao@gmail.com> <20260909024324.16002-2-laoar.shao@gmail.com>
In-Reply-To: <20260909024324.16002-2-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 8 Sep 2026 22:22:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7j10oCBK-_t=uG-KneD41xrwLCJafy9JPs18jDMj+OPQ@mail.gmail.com>
X-Gm-Features: AcwNN1WhV4O-lhYsNq_BlvbeLNGUIO91_lKZIf6iAoqiXhR053SJLfdA0MSWyJw
Message-ID: <CAPhsuW7j10oCBK-_t=uG-KneD41xrwLCJafy9JPs18jDMj+OPQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] selftests/livepatch: Clarify test module file names
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:43=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Rename the test module files to be more descriptive of what they
> actually test, as suggested by Petr.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Song Liu <song@kernel.org>
