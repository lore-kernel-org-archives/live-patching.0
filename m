Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5F2D7380
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491057; cv=none; b=pQpGFf0e3qXmNCGYnCUvlq4dChIP6Mq9J6iL5zC+8mHIGmyI6sx1Ry21MbUIrTD20tftfpOLuDINdEsLfM/7dOFEFK73c6Tk1qMOqbwcrwckzd92ihs1tAtzZkit4v/3fTITJrW7Cm5GKgeGEKRKTb4VQHuLIbQm49t+NE9J5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491057; c=relaxed/simple;
	bh=mm10wdMdh/+6h4HJAKRKNt7oV5Saby0KSm+rAiNPAjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPSuO/zjz5mG6hYAEBiPoesymJJH39BhZNVRbPWohI7EQSK7bX+F4NHQLvrvZMDz14GgGeqN7w0pQoK3Xhoe1ZgRym2fYo12hNhIwIHczCwVcBdVt/PZlRLdYOXpyLCcqG+ewM6hDKrt0c/UuE15lxFrcayMOYdQmISs3l/Yxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn4DDQ7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn4DDQ7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3491F00A3A
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491056;
	bh=mm10wdMdh/+6h4HJAKRKNt7oV5Saby0KSm+rAiNPAjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jn4DDQ7hhCxJoo3tK++tbWVHNK4wNMPUDcEgrnwWDH0FghP3+gBVVBulNPQKR+CYj
	 eAR1nshAeb4/sx77Ra18u/bKHedPdVM/xjg0bN4kTHebwtcdu2dQbmmQp2LUYTiZcw
	 9f/lpxCI8TakDgy8+6xntXNt06bB2wnmnaP4P7yYixSSkUm7wFinit5typM08w9qK6
	 YCCktIHNLD2AVnwK9aIRPuP0P8f7QY0VdDrKGRvuuyv4+G/XxbXiozkhT+xlWcAA+j
	 OAh093MUjByxOCdTA39rCipxgeSYkoe4OYR1qkjSnw9Wdfkh3pnG1C4d+gHQydn5IK
	 rgR29a2Ib3cDw==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90a60a3ee0cso2728936d6.2
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:30:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp/IerwbKYrzUxo02Ca4DRnpooKv3KBmXkwVTUZOZtpalSTFtKqACR4++GXmfB27GJ1f9VRqdJptkv4maNz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ggBRgje3fw6jgLfrqZokMpoVtJqwBZOxOn5cftFFlwq0L7Kd
	xIsPTUYO7Lkwm5uxddkwuXsNYV4w8Bv5xMsOHfykYDqdFMxkRldJQwgGCIpv4Fxgms20CW0IjQs
	LE1GDkhxuKWs36/UgTavaWSWvA9VuTvM=
X-Received: by 2002:a05:6214:492:b0:8f0:a849:f392 with SMTP id
 6a1803df08f44-90a6ff45bdcmr7684206d6.14.1786491055243; Tue, 11 Aug 2026
 16:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <e246f9ed3b06724147ca801af3deea5e2cb3b80e.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <e246f9ed3b06724147ca801af3deea5e2cb3b80e.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 16:30:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW62H8-wCzh0fKN0Cakv5Av-A2=bKg1f7BkS3WYs+H7fLQ@mail.gmail.com>
X-Gm-Features: AUfX_mwAp1sFG-jsaJmeqTRSEzzIwn1foHFPe56LR-NW_OH8s91tXk8W6El9i-Y
Message-ID: <CAPhsuW62H8-wCzh0fKN0Cakv5Av-A2=bKg1f7BkS3WYs+H7fLQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/22] arm64: vdso: Discard .discard.* sections
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> In preparation for enabling objtool on arm64, add .discard.* to the
> vDSO's /DISCARD/ section so objtool annotations don't cause orphan
> section warnings or leak into the final vDSO binary.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
