Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295670;
	b=eUG4/QL1+m6Z09DE8CFQA9z6hFDI2gn+3g83ws/AbkN98pj3GD9utBx7twscni7kj2jg
	 zZkFNaf5lO+bDrrm+OqkVztulLOtIuHmiDRRVfg1L3DsGmUrlNGawpOvgFzTjexWvS8Vp
	 c5mDzG5vltocb9mXRJfUjVBS/q2zXnwJl1QjRgk5jyCCwufjwKKY/Rlk1NrKIZs5zC5bg
	 9Slg6jSjlvW4zx9khzSHm0qUgpAFPaW675QOxZfaMIj151elbtUeSgwN6vU8oyJxwnKiP
	 55J3/+MoSICQ/PFMj8kkGXjWd11zFEXq9fSb69xPK7vhilDvcr03gOiw8fc8AZSpqjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295670;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w4MDwkoXI1zATkJgHvVo1zXWArUgOESYKVJ2mYTk7qI=;
	b=N4mDAhjddjLLh5EOZKQ4wKkSxs8YJYesOKqRCLf6Uu0EOFNW6Z52LjymZmfxee3Q/wMP
	 ikEhC6T5VAtIPgUVvOJnAOIGh0fHVYgTZIOqu7Lia/otLNBzuDAVAvk/notzwQBLzgvzH
	 NeLvP1zUHyjKYnXeS9z6m+kEv94N64NDLvjfrFlnl87sq5Ei88VaGspWmOV0iE+0BNXh+
	 Rvxg/AmWwuLq+O95SeFfMpYSKl1AWuE71Y0CY1saJfeUtVfaOFX8ySU5tIs3EX9TRM5Gv
	 LOY4h/fJmHJmrV+aXIbeTjhlbI9SbDoNWY9NvavP7/f2pOwCreeDdZD7feTU7OyRaIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0A606A31D
	for <live-patching@vger.kernel.org>; Thu, 29 Oct 2026 17:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D667B1F01826
	for <live-patching@vger.kernel.org>; Thu, 29 Oct 2026 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793295669;
	bh=w4MDwkoXI1zATkJgHvVo1zXWArUgOESYKVJ2mYTk7qI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A4KQ/1qL7mHlTs+aFc0e345VDHgTW/F2b8hoyvsBnB9B0xv8Wdjyt0sDuDGxxfmrQ
	 iHz/N6MwvneetlwuyEmsaU7gBxiV+xr4iJWavIv0QLZ8Ux+adpp7YQu5NNjcoXOt+H
	 ePND6EnvGAc3bgYj8GXWGK95G8rpiEp7M+Kcv/Z6zRC2xsRd5M/Sy4ijTwMEcsBeZZ
	 J9TqASsM8NQNxIMdqrJLJoKDa64AagErSpnBITiUuVxMYLWzAYqAmXptg7zxsS9u6r
	 Sr6phKZRLYRtwvJKmn/dX6Eo1LEg1MODNP9jbVFPK7a9TkrIeNzA1JDd9X1WwpSx2v
	 oJeZQXy6aD7cA==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f3c895a0eso205392385a.2
        for <live-patching@vger.kernel.org>; Thu, 29 Oct 2026 10:41:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByE5zQDnJ/0buZ3SJviaZUsgY9LOL6E7Vz/dXPPSVpff0otlqOyNLWi5GYszojQPDWK/283nKggzfCKy+wf@vger.kernel.org
X-Gm-Message-State: AFq9FYKaMQv5XHrRqPCSV5nGd9aJf2a2ZqJPnZPY9orMvtkCJ+oqyQOJ
	oKHfsWKXpfe6wGKdk8PFuVMWoVgyPIhGFnzlFt8gix28bm0yr8zlakRckGHH3iMcLBug7tKZFQQ
	puiu0y/5Qj+sdVNudaSZpy5tfXXTylkM=
X-Received: by 2002:a05:620a:1729:b0:93c:2726:77ec with SMTP id
 af79cd13be357-94408930698mr938682285a.5.1793295669104; Thu, 29 Oct 2026
 10:41:09 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023011049.1164625-1-song@kernel.org> <20261023011049.1164625-8-song@kernel.org>
 <20261023093256.20d3e300@gandalf.local.home> <CAPhsuW78w86tV3gwRWQMOdWUK7Rcc8dSsp==XypKdB5BMP6QiQ@mail.gmail.com>
 <20261028210844.105c431f@fedora>
In-Reply-To: <20261028210844.105c431f@fedora>
From: Song Liu <song@kernel.org>
Date: Thu, 29 Oct 2026 10:40:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW54Tco1Y_khWHeomq_ZTxvDoHFuX77w9cqojuXCrhGKWg@mail.gmail.com>
X-Gm-Features: AclHuK9fjwvJ3Xp1aqzF-DTK4K8-TXgRFJbKPS9ckUc2Nj-YxqUVgClutpWoo-0
Message-ID: <CAPhsuW54Tco1Y_khWHeomq_ZTxvDoHFuX77w9cqojuXCrhGKWg@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Wed, Oct 28, 2026 at 6:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 28 Oct 2026 15:20:37 -0700
> Song Liu <song@kernel.org> wrote:
>
> > Do you plan to apply this set to the trace tree (after the merge window=
,
> > I guess)? If not, how should we proceed?
>
> I can take it if we get all the necessary acks, or it can go through
> the BPF tree. Either way is fine with me.

> If you prefer me to take it (as I do have a lot of ftrace specific
> tests), I'll do it. But I'd like acks from maintainers of all the code
> this touches.

I think this should go through the ftrace tree. It has very little to do wi=
th
BPF. We discovered the need for this change when building live patches.

Regarding ACKs, it is a bit tricky. For the code we touched in this set,
there is actually no behavior change at all. OTOH, the real change
happens to "inline"s that we didn't touch in this set. If such a function
was left out-of-line by the compiler, it was not traceable before, but is
traceable after this set. How should we approach this? Maybe we can
just ask ACKs from the maintainers of all the code touched here.

Thanks,
Song
