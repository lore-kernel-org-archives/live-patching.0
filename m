Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999795;
	b=qmG3AUjzvEMsmRr73mRblAh3ygaeCPAZjWs7c2OnShza1PWL8SXj7ixNW3mwsvgySRoR
	 cjHsR2gckgyWdVy9ggf3eUuI4tNp4g704dstm1uoLHva+rP+UaQeoYfP3eyt5VAQVfeOH
	 mpFa0Hyjrx8aa4cS5uYi47oCq7nxYcT3EREcQNkmMEZQ1PQXbYtcMyawps+4ZjRDrxRBX
	 1+QXXiR7AsflereOQyL4E1AwY1yxMTgbb8VrZH+r07EcyqVvT2WlbYlXtm76kaGbQtowH
	 CnI4fm812OgcYL/2EWRdrCTu6GKm2/S4xPTu0fA8mKCJOibcfoY/hPKCaZhyP7ey5wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999795;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xJl2OTNmMfTBfL4AgN9E0OxQR+h4k4fDuOq7xORUM0E=;
	b=zYscW7qFE8apZmSmH0NAp+oTujXno7RtS0RVjlXkXMilW1UNPn1HXzC7QQCPyoE4YTFj
	 vrCVjtY5rA395xN3ChKOKh6L8eIasqv/hxHvYkRyuAUdDEEjrWweg5JD4rL9eU+ucZE4S
	 VRthwWOXiXRWU90GxoFZ9XCpFIF0rdDvs8pEk8hTxwoT4iGS6/Ns/EV698+6aWN8RGUIM
	 HmMA2nMh+3DlZZGZijcq363/Ck2ISaFvoogTGOU0LhvoIk0M8nnQt9/WZYZ9tYYaic2zj
	 HT10XcbxaKiSONDkUJpa66ZQs+dJlS4XrzVPphq9sMquchT3WtzEIV9K42woOYBrTbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc2u4AmR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345A606A32C
	for <live-patching@vger.kernel.org>; Fri,  6 Nov 2026 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc2u4AmR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D72A1F008A1
	for <live-patching@vger.kernel.org>; Fri,  6 Nov 2026 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999795;
	bh=xJl2OTNmMfTBfL4AgN9E0OxQR+h4k4fDuOq7xORUM0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hc2u4AmRiCbpuySBVBsiFJjhK5OyEy4chsQgXiJvIQHOcnvTc6lqmCgNrarTItdGI
	 b4PtUqCHPqRqHnFYKS8X6sKxWwQDZ5bzutOx7NJ8FXfOQ/i6CZrLJ4B3lC83hjD5Mm
	 92zzKoyM6lHaV/O1JrCftWtbc3G1Hi+i82v2AujHNP9E5lvwmqVwhuNjkGb4jtBdBF
	 g4Rgj1MLTC1wOcP5PFAHN3Y+gjYbovmUMfihRC3sPNEIvmzIJeaeHHkcU29fls1S3A
	 FeN22iCCs0kH9uHH8kfT7vMPzEUh+9bk84tYyCMRk/T5EF2YHTYz5W9HN6BzWOyQEE
	 mVJIVJ7l2IiKQ==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f3c89594cso93931685a.2
        for <live-patching@vger.kernel.org>; Fri, 06 Nov 2026 13:16:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxY6I1REdiNb5YYADc/J5VN32bx/j8v4rAoCOZx9D5Tsbqnfyp8jMr+sfKplM7W7AxBgBE9utr+eLZ1QEvs@vger.kernel.org
X-Gm-Message-State: APuU4Z/4OBAhJW8VLZsbHpckmTy5Dq4VIc/LwaWho9V574HDCuKcNFRe
	CFM7p3cgWK1bZXtChnIFEBIf9B4MCf58BIqulRpNt2GnFXkYl/XU8VPoqRler16chrOxNCkDOYU
	r0ChO+6uWrfF5g7ZxP3nNpuFgE1v6e48=
X-Received: by 2002:a05:620a:1a17:b0:93f:4f87:4f5e with SMTP id
 af79cd13be357-945f3563aabmr612409085a.72.1793999794316; Fri, 06 Nov 2026
 13:16:34 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103233909.1364531-1-dylanbhatch@google.com>
In-Reply-To: <20261103233909.1364531-1-dylanbhatch@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 6 Nov 2026 13:16:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW72OT76aegak-WF26B-WOu5A1c=n1SVKOUWaeiq9BE1xg@mail.gmail.com>
X-Gm-Features: AclHuK_13JVN65cTQk2p3xkuhhhJkRuHZ2ecGR2Fh9GyIP9fsrWSWq6y8nfRH1o
Message-ID: <CAPhsuW72OT76aegak-WF26B-WOu5A1c=n1SVKOUWaeiq9BE1xg@mail.gmail.com>
Subject: Re: [PATCH] klp-build: Allow passing options to make via '--'
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:39=E2=80=AFPM Dylan Hatch <dylanbhatch@google.com>=
 wrote:
>
> Livepatch builds rely on reproducing the original kernel build
> environment. Currently, klp-build invokes bare 'make', which drops any
> command-line variables or flags used during the original build (such as
> 'LLVM=3D1', 'CC=3D...', 'KBUILD_BUILD_TIMESTAMP=3D...', or custom wrapper
> Makefiles via '-f').
>
> Refactor the make invocations to use a common MAKE array and allow
> passing arbitrary make options after '--' on the klp-build command line:
>
>   klp-build [OPTIONS] PATCH_FILE(s) [-- MAKE_OPTIONS]
>
> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

Acked-by: Song Liu <song@kernel.org>
