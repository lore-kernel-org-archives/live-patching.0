Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625896;
	b=xBvlwTOiHv58/ytpoVun0rnTXGUPW3RY903zS1PQtzZmkSQE96WMe+jjOmH9SWtq5GXy
	 MjEcoVMmc9ovaOHF2/1QFvxO6f9dyjydc9BMQBtV/7gGc+HoBnRBVMtsxCmB7+mRNBuJX
	 UbdocK/gDwooI1xsMvj8iUCMKi4VlkX9eMgkjw7gdFCgDuL3JOiWvpJeXw0CWvTRfZFEn
	 SaMXu3ZQ3MhdofGFJcIb4LB6Pchia2zbjQMqCtUSc2P6lyo3GHuXUbzJ6qQtMEf7Ep5+M
	 tTsvO6ucZSVKLhiM8nXjLB2kNj4We2P/6/a/6qP6FGqupo6C0wEfM27O0bksA+i1Gxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625896;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XKZAiKGbiib5zp4TSw/Q6LRpir6OwzmcI8NEHPK6cRM=;
	b=tIxF28V9ECLK4deBB/GYmLs8rLYqEz598UELkKoD/BG85EDdIaub/YRWfiqCDY1cMxIF
	 QF62rQA1pi4ffr2xvuofxQUwddQTUa4EXhMGDlR4FksNglZ5e4X5RuBaZ/9lh9GoV+kza
	 5eCEjfrcofwNZ0XzY/2MmXknEomJQq9p+dmz+twJU6iYJ1WMGth5g7i8Za8+/MvUCwXzy
	 /D1wBtOGDiS/65jCiKEB2GOlNwh9sr8vy0oHdgmrdsFaugw0BmPqE9ULjsIl06me2gl/j
	 kMvT1gdnGD/cxUVZuXhfsh9JZElTx9TUvZPKgwxIVJ/XDkwodOlnh4oSB0cTZ3p9f7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgMVqk7b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62479606A31A
	for <live-patching@vger.kernel.org>; Wed, 21 Oct 2026 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgMVqk7b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11C91F000C4
	for <live-patching@vger.kernel.org>; Wed, 21 Oct 2026 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625896;
	bh=XKZAiKGbiib5zp4TSw/Q6LRpir6OwzmcI8NEHPK6cRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MgMVqk7bGrp6Ls7lIijkuqzS2bPELzf388vN3Ahkv5vSs3t+pZAr/5v6ecs8I+Nlj
	 YapOkwComR8CE1pa9p/RwTVrAJjY+ia3CF2mHTdISibWS8FPYu7yTOBk4OcOqYQ2af
	 c0Jma87QHmwk+xshEgSyGx/7BgGVnlxVosa+bJcEIybK5qRqmR5VpeNDPgD4JnT24C
	 f5h+hu4mrZzK/Yq32b4XNEmV4F5lvAIfY+7WC0DtDHfdfhOBQ5iPiP+mS/0fPyv7nO
	 SI4SMRGI+SBLSwdBE0cJ2VOWmmtTkU8ngaa/YaKSbvtOKmvpBhMCD5+QchN+H18QXq
	 +LGw1gIU0ZesA==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f30660e69so81403185a.0
        for <live-patching@vger.kernel.org>; Wed, 21 Oct 2026 16:38:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByVH2f1kE/BpebFdeaccH6CVappMGueIPgYCOnv1da8gAFEv6Vi5Vl2TWw2r2sEIt9y3Z4QG/rKKuvWMsTn@vger.kernel.org
X-Gm-Message-State: AFq9FYJR+DzQ/8W1fK11ODqqMWGdyga9Jj3kt8Il8yuObSGeDCVCyT47
	CUA75t1EeBCp7BdcmYsbwRot01c6tg4R9CAL/mBOE3uzugXBb27PNHxKTUvE1bAosA7E//gsoHh
	mqwjakVKLh7DnPHS8iUeQnU4XJd8lwEs=
X-Received: by 2002:a05:620a:601a:b0:93e:5daa:67a4 with SMTP id
 af79cd13be357-93f57f0a0d9mr727720585a.29.1792625895221; Wed, 21 Oct 2026
 16:38:15 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021222255.3124940-1-song@kernel.org> <sashiko-outbox-180771@kernel.org>
In-Reply-To: <sashiko-outbox-180771@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 21 Oct 2026 16:38:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5BhxAUC=OE=mjZ32vtYpsGM2WYw6bKTXF5GrTDh8CiSA@mail.gmail.com>
X-Gm-Features: AclHuK_CkLDvphCAJPCC_oZ2GWHVamkqhlYW3dwZFYCLJHlJKYBN8UaCaDlSLYA
Message-ID: <CAPhsuW5BhxAUC=OE=mjZ32vtYpsGM2WYw6bKTXF5GrTDh8CiSA@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Do not mark inline functions notrace
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 4:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [Critical] x86/paravirt: removing notrace from inline instruments pv_op=
s and resume
> - [High] tracing: removing notrace from inline breaks ftrace recursion pr=
otection
> - [High] rcu: srcu_read_lock_fast_notrace() and tracepoints lose notrace =
attribute
> - [High] bpf: removing notrace from inline exposes trampoline helpers to =
fentry
> - [High] entry: removing notrace from inline instruments unvalidated entr=
y helpers

Wow. I didn't expect this from Sashiko.

> --
>
> commit 1eb6626c4a5ab70e5858a8a8f1c9edfca235db57
> Author: Song Liu <song@kernel.org>
>
> compiler_types: Do not mark inline functions notrace
>
> This commit removes the notrace attribute from the inline macro definitio=
n
> in include/linux/compiler_types.h so that inline functions emitted
> out-of-line by the compiler can be traced by ftrace, attached to via BPF
> fentry/fexit, and livepatched.
>
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_ty=
pes.h
> > index c5921f1390079..ea7f2a928b4da 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -230,9 +230,8 @@ struct ftrace_likely_data {
> >   * externally visible function. This makes extern inline behave as per=
 gnu89
> >   * semantics rather than c99. This prevents multiple symbol definition=
 errors
> >   * of extern inline functions at link time.
> > - * A lot of inline functions can cause havoc with function tracing.
> >   */
> > -#define inline inline __gnu_inline __inline_maybe_unused notrace
> > +#define inline inline __gnu_inline __inline_maybe_unused
> >
> >  /*
> >   * gcc provides both __inline__ and __inline as alternate spellings of
>
> [Severity: Critical]
> Could removing notrace from inline cause a triple-fault during x86 suspen=
d
> resume, secondary CPU bringup, or kexec when function tracing or call-dep=
th
> tracking is active?
>
> In include/linux/compiler_attributes.h, __always_inline expands to inline=
:
>
>     #define __always_inline inline __attribute__((__always_inline__))

I wonder whether we need __always_inline to be notrace, and whether
this resolves any of these concerns.

Thanks,
Song

>
> Because __always_inline only inherits notrace through inline, removing
> notrace here strips notrace from both inline and __always_inline function=
s
> whenever their address is taken and the compiler emits an out-of-line cop=
y.
>

[...]
