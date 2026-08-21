Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD752D781B
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345164; cv=none; b=YQMCurYALIKG32/QX8+EEvWniGSSASuOjvKesMzQlMbl3SFmG04bJH2xbnDkUHEar+AUTyEV6CnDkeHl6TMztZvlwchVf9YB5ZO1/gqJPCixQrKHecA/k1OYptaMXHLr9OIEEnu+5Baw1n7CNFghXOvhKRGOfGUO3wGN5fpt1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345164; c=relaxed/simple;
	bh=M0dFDQ/Xoo04rbHs/A55S0BI1NO1LbkXQVDpJYALPqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvLrEW5LKWryNhcgamS9api32WVcn8kwcmPB6b9irp0yacXh//tKqdLCbimrmYqUjI9QkgnbjkIVzjKhATmKAWavdWeEco0YayyfN8RChu0RPhN8KOzENG5oYv327zPWkXuzdiIevRqIgPQgG9xPD25MqKRSFO6p6BZXlU56N0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlALvVEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlALvVEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEF51F00AC4
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787345163;
	bh=eo92fRkWKyfdcGR7p0mN6kh7aFKmIvHxaVkvmoCRYHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JlALvVENfsv3bmSgehRO8W4TgZwXbgKI2dfMBlCYZJbt3skzLm1nXZgEq4hdblQQP
	 wawGX/0ZLNtAlMi04FCOppqY3KvJlfv+oS/pGeEY75JoSs3YUH/HbqXn4fZLeSB5sN
	 tIDiH0HXhdBHqGKnuBhW7kZtlTYwCP0gQkFSUelZBzJQgh7mwbLUMFf3y04Cv2TwTq
	 bqFp/SLFbED4+cyMJepZrCq2v0+nueXk1TpekRmxbSyOvsUvgg+2QTcuFjfewXWgDC
	 ++WqOnQLCmK3rilxjRwWg8M1MDq5h1yIQPrLkBscRH8E3DhhgkmgjyNXmwt34OJenF
	 RuRRpXSjQnH6g==
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52d590ce5cdso10546801cf.1
        for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 13:46:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqbkSQxhpue/nZTf2GSrwWdWdiF+d3t9zXhH8RNbI4U/7lVc/j7WSR8u1zp414zAN60Rr4JJCEuScV1z5OY@vger.kernel.org
X-Gm-Message-State: AFuF++nTTGSO3efekILar7yrO18/nqjv7BySLdBrhbotueiwtEwDpHnF
	2vVYSSRQl3Soz4zXTb04NKrp0232khy9e0TRzx/jchMPlyOwZpJzu94GF066UBbnhuCllSkipNg
	8kz++va1Ja4Tir/0owAvFOFn4KHBgCjA=
X-Received: by 2002:a05:622a:5593:b0:52d:742b:aa58 with SMTP id
 d75a77b69052e-52df56e1157mr86239261cf.6.1787345162398; Fri, 21 Aug 2026
 13:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821031648.48195-1-laoar.shao@gmail.com> <20260821031648.48195-3-laoar.shao@gmail.com>
In-Reply-To: <20260821031648.48195-3-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 21 Aug 2026 13:45:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6tXmjqW17FquDeaCWwN_4D4ets1Y1xTk0yMfjdNczzxA@mail.gmail.com>
X-Gm-Features: AcwNN1X0em2RT8lpPrRDli0FHZ6vk90WthiSV1Nv6dZ58IxJNs25REvbGsO04sw
Message-ID: <CAPhsuW6tXmjqW17FquDeaCWwN_4D4ets1Y1xTk0yMfjdNczzxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/livepatch: filter debug messages in check_result()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:17=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
[...]
>
> Filtering out every "kobject:" line also hides real WARN()s, e.g. the
> one kobject_get() emits for an object whose refcount was not
> initialized.  Filtering with "dmesg --level=3D..." is not enough either,
> since the tests enable livepatch pr_debug() through dynamic_debug/control
> and expect its messages.  Read the log with "dmesg --raw" and drop only
> the debug-level messages without the "livepatch:" prefix, plus the
> specific delayed-release info message.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Song Liu <song@kernel.org>
