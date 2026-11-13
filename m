Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602021;
	b=LrJ14fhdVyR4aMtzc5nVrQ8wtJIyJ5adV5jM3MeRlP36Yo7XSQIXeCk9NZKmPKeXg6M0
	 QaNyep/7HMATFqKpuyWRUyRAqAenFTIxBV9CxHqA0Mr28Df9/exV+YrAtlu81+bNMAsZy
	 RsglOjXsZ/py8hBydGw9SYIeO+dq+U4ic5oGZFv3DlWerHz/E5ieD8dWcYYc0k5XMxym9
	 R6T5zx2dxn/OsrqEcdUsELLH7pE7E5+GMPEXV+MOIUg775toEmhZP4Rgn2dx3FI3B/qcc
	 ATIN6YGuq6Jh650ouwS8WczpK27I7zg61QJrk50nbPGk3hOBnZwA+rl2QKGYDy84kCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602021;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0OsjdM0NG82VrsvgjNyYKiZJaDnLzyogGoOyzCq1L2g=;
	b=S9e8MbvhGP2VwwXZEJIWNrdL6C2O2rmIBMyXsRlzwuDzpD4LhVPUbxUCOs0//XQOiT0/
	 Oj7m+ZRyUxkfdXugFHDzipiQOk+EzGFFZYn9EUF+UzeOJvSlsa5TgKYC/HZ6Gz8NLboAG
	 7qZWxN8WWgRKNRs55TVE0KXE65Pgdcfd9SN/y9jM4OZAel23BKWWfLVhWJBnLJyWdKhjx
	 S0efkJHlGgkoLqrG3sA2/Qs/WgnvLswHVOLNnsaJqFEfy/IYyL8BdG0Q+8MKeYA+zMZ3e
	 GwSxCLbMiaE1/54VJsVmKJ8kgECN2nmcQbMIbCBMNL4VNj4CS+t77cqlMUlFpeHZvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAai4WZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD6606A890
	for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAai4WZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153791F000CA
	for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602021;
	bh=0OsjdM0NG82VrsvgjNyYKiZJaDnLzyogGoOyzCq1L2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BAai4WZlNWwzT9+2xAyLlroczosJHzv7Crz8ma/56YbZo06sPtNX7pW9RLd1VYwsr
	 fkKXQI4yllqPat3kLn1cUytuFkt7wgO0URiUw/G4Y0sAjMjNHrcoyaojoSsFiqNNl4
	 g5lVMcnX9IgFe3XlTPoH5sgZqvzvghkyP+uOrdnX90D77FbHMvxJA5ozZrhjK2dfvI
	 TODcpGiuJeDg2mp3uKuWkl60E06jcVTniQiIL1DMxm+lshRetxVIEXwl3J2MUB6cLx
	 W5vK/D2XwCCixwFrA2owonq/VRq6Vf8+FUtqT9tGEKYJRZ+ztQjzkkIb1PnzSUPiJF
	 RM9E//vFQsu5g==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso31979306d6.0
        for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 12:33:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFPcCL1FdNqjzVu4Dt+IWCgm+rpQY3bO5xpZc9meDpXaeDItL+ch3lidSIA+OMaT+wJq0gULG2H+KktB7C3@vger.kernel.org
X-Gm-Message-State: APuU4Z+Y3b65lU+7F/cVYPAkDBgAYl4BNjZKR7YdhT8FEZoBvUMA5OZP
	yKCE1t4WXqFfFFkvxEX9XhNHiI9vNdauxYDrneFw/C08gjFsJH7tMaD9vKAVY10akiD9ln+iAhL
	zMmO4dSEyw90zIv0SUgol2DgTLtvLMlc=
X-Received: by 2002:a05:620a:6f0c:b0:93a:1b82:4962 with SMTP id
 af79cd13be357-9494bc846d6mr601897885a.47.1794602020285; Fri, 13 Nov 2026
 12:33:40 -0800 (PST)
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
 <20261028210844.105c431f@fedora> <CAPhsuW54Tco1Y_khWHeomq_ZTxvDoHFuX77w9cqojuXCrhGKWg@mail.gmail.com>
 <20261029134721.66bb584c@gandalf.local.home>
In-Reply-To: <20261029134721.66bb584c@gandalf.local.home>
From: Song Liu <song@kernel.org>
Date: Fri, 13 Nov 2026 12:33:28 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5t2OqERqVm5LDCGDjae17LNpijqRgB3mbi8Mmv41P2RQ@mail.gmail.com>
X-Gm-Features: AclHuK_QviZ6vy2B9azKKn61eNt7bUleWDksUblkFaiXDohfL6g9U7WqxoxsBwQ
Message-ID: <CAPhsuW5t2OqERqVm5LDCGDjae17LNpijqRgB3mbi8Mmv41P2RQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, Oct 29, 2026 at 10:47=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
[...]
> >
> > I think this should go through the ftrace tree. It has very little to d=
o with
> > BPF. We discovered the need for this change when building live patches.
> >
> > Regarding ACKs, it is a bit tricky. For the code we touched in this set=
,
> > there is actually no behavior change at all. OTOH, the real change
> > happens to "inline"s that we didn't touch in this set. If such a functi=
on
> > was left out-of-line by the compiler, it was not traceable before, but =
is
> > traceable after this set. How should we approach this? Maybe we can
> > just ask ACKs from the maintainers of all the code touched here.
> >
>
> OK, I'll just add it to Linux next around -rc2 then.

I haven't seen this set in linux-next yet. I guess we would like to queue i=
t
up soon so it gets enough pre-upstream testing?

Thanks,
Song
