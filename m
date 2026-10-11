Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44C36194B
	for <live-patching@vger.kernel.org>; Sun, 11 Oct 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745109; cv=none; b=tmJ/w53lGm/LUWgg81aV7WQEgtWXN8g7uNdI3UxsqKQCfgdz6jtxXlZP9ayfOQ0KkPoK8G39inHeUsa8BzB9QxVaS0kCKmfStuWpd34daD6Rxz7QU7i7MpjKJkHCMmnpJvvkUgvqpcF/c8l56YeB/oRPEi+3vfoh50HnEEJZkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745109; c=relaxed/simple;
	bh=AqDSNOwmcHl4cR31yxAgWr2XCJN7ydUtB1mAbLpL3ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAN4zpMZpN70vK6nH0Q/6uOcAAjdrzcvc18qBHBQnyQloYhIRHjxt0kWG3vQhB5daUkinHEoxHn5gzYNXT6bC92/080/jNLULAT2qguZzens1D58jy3d9RU0XrtuZQ4DfIlk/LTDe8gWP0zcFOnAbGB0DrEtBEn1Z0V38a/AVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWmLxPg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWmLxPg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19A91F0089B
	for <live-patching@vger.kernel.org>; Sun, 11 Oct 2026 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791745107;
	bh=xJ21hrWJH9axY4jAzpc++zD1/Jz3sz4ZEQgfOFJFd5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FWmLxPg0Sr0huqO+WuYp3hVb5eIzu7US8qJVtA0hzyasPJ4LVY+Xy8h9Ed5gHeH6T
	 a7uFAYW864Xyfybmqj0x13FWu/d1ZvUyNIKphyI0xcRog/1l5AcMSKpvEc0XJUcr30
	 tAfYotnDH2R6sgOvHdkK1Xl4hBpSPelFDl9y7YTqIqgfPllDYdAIyP4Kq/478pd11A
	 WBYdvtb54h1G546vclTbY/iNPTtrR0HhtEbedF00V6D9MV54N8kBnsWRMrZQ6uUm3J
	 HVywmoKnRuLNumKnjK2lPBQH0u2Y/AV9SS0zGKt0sWp77ML4c8XwogOVAbGxoblXcG
	 14NaNMV4kWaVA==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e6eb77f0bso132116585a.3
        for <live-patching@vger.kernel.org>; Sun, 11 Oct 2026 11:58:27 -0700 (PDT)
X-Gm-Message-State: AFq9FYJVIMiIUbdikI5clrsAJeTtKBDiD0J/WAbEmXn4mhtcGn53FIj3
	8tFUtnG/hfAh2qnDzyhzZua2u9W2kvVTUVJVc8OQeEVcn/6+/GMHYSZXQrgSrTbbE4zElUMSHCh
	l8eU+lW1nG8fXKZHnD4sHLACopQ2QOzQ=
X-Received: by 2002:a05:620a:46ac:b0:93a:11a4:223c with SMTP id
 af79cd13be357-93ebd0c6dcfmr1205596485a.9.1791745107243; Sun, 11 Oct 2026
 11:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>
In-Reply-To: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Sun, 11 Oct 2026 19:58:14 +0100
X-Gmail-Original-Message-ID: <CAPhsuW5V-VEf3WUAo4LiLMNdXdiWJ0o9zeLx9aTasQfh2LK2LQ@mail.gmail.com>
X-Gm-Features: AclHuK-26tgjgTPgu-Qekfg2JGvHW8bPLOcwCrFPyxDypmNmI5Dx7Q9i19_Z47E
Message-ID: <CAPhsuW5V-VEf3WUAo4LiLMNdXdiWJ0o9zeLx9aTasQfh2LK2LQ@mail.gmail.com>
Subject: Re: [PATCH] livepatch: Add Joe and Song as maintainers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 9:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Joe and Song have both been key contributors to livepatch for several
> years.  They have graciously agreed to become maintainers; add them.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks Josh!

It is a great honor!

Acked-by: Song Liu <song@kernel.org>
