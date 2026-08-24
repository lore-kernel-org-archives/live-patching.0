Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654253FCB3A
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591978; cv=none; b=MGWFwjO/HdXnZaYbgLeZ4OePa3/RNTHurdiqfCvZf37bB+GVaLJif/IvL7u2gluKKZ/bPHdi8B4tIzlrgWT2M4Fo6bA2VqWkXJl4JwWNctwPi3+stPUnCYkk0W5on1LKs2G49aIrvmUePJfvEp2xApGPqWM+9P6IvRZkrvpY7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591978; c=relaxed/simple;
	bh=AHD8nBZSI2/vheMMmSwDa4kogCqYQInIBFKPNtPNEHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2fIXXnmtbj8k08W9P9oWnaFb9qguL7sfYZIIACKKB/Q2yCODjTI1jA3NaSlGV91Uf1vihjNUFZ4HJK2mTZt+GMiT+ryGW3zbL4kB7OH/dgPtgGvaWrqpZixkBCrEZ5vU18Y2/4Vloq788y3yaJWHIUthQXbsnojggjAwF/sdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmAAVyGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmAAVyGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8A01F00A3E
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591974;
	bh=AHD8nBZSI2/vheMMmSwDa4kogCqYQInIBFKPNtPNEHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GmAAVyGGySnYfEuqHEYLGm46G7Gsjo2uTOr6w/BRRtO3KaYWqsfvZNEqb0oBdVbIn
	 st8BR7aPdntNd6iU91zyQqg8OO+KkiS6oVDPUEzI1FQcsI3dOsRY18vetiQAwgQfJ9
	 VA2G7t8eCi0oq6L2OT9upE31L/EVF5VVgnPVKdBeDYtWEP0wSJ4dxpcS2etxKB+y30
	 /6UcGCV3bpVx8C9Z1vgZZUxpqbbbXVSaVPFtXXGr+Yux+fYIG06FCgPcOiugakD+kj
	 u3NG9+58SSURJctLftAq6bT0OgbouqHdY23bQNDpawvc3LwiPL+qbZLy4TMO/mr6Nk
	 LVx3jt+9lXZcw==
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3162061a91.0
        for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 10:19:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqTFgnADVW/R4bladfFOKfRy96EdFtMKp2BnT9Z5uOzalsrRFitmlA9eKsdWk116O+svFyXXpJQyofTbJ80@vger.kernel.org
X-Gm-Message-State: AFuF++k6N7I7aXP/eCUnfRaxCcK9pDX8wtNtOxuum53fyfW5mzsseLrf
	bSV4kDM1mHRodKP7NW/R70ZvJuGFYXdQmLSErKcgVJpp5QYvKIbxTh6N/SqzvPwvY5a6K0yShkg
	Q43p0tv4rNYdMvpOS2XGiKVROvHZnwCA=
X-Received: by 2002:a17:90b:6cb:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-395c2f13243mr55934202a91.0.1787591974424; Mon, 24 Aug 2026
 10:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com> <20260824032732.56686-5-laoar.shao@gmail.com>
In-Reply-To: <20260824032732.56686-5-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 24 Aug 2026 10:19:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7-H--uswq+VFzZHwvhkHL_z6jTj1y3t9sb3qFEUa5bzg@mail.gmail.com>
X-Gm-Features: AcwNN1WIJQzYuqh9AfLMu30ZdS968uMBrIwdLleUPmcrU5SojhaSwIxehljjHbU
Message-ID: <CAPhsuW7-H--uswq+VFzZHwvhkHL_z6jTj1y3t9sb3qFEUa5bzg@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] livepatch: Deprecate stack_order
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
	Wardenjohn <zhangwarden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> stack_order is no longer needed for atomic-replace livepatches, as a
> single function can only be modified by a unique replace_set.
> Since this livepatch sysfs interface is mainly intended for kernel
> developers, backward compatibility does not need to be maintained.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Wardenjohn <zhangwarden@gmail.com>

Acked-by: Song Liu <song@kernel.org>
