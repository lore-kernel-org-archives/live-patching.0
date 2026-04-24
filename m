Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7174373BEB
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067909; cv=none; b=AfkcnSL6MgGHPHdj6Cc26bG6g6q2FNmLk5qa9FsXEGOhJUJbSJR3/+eaySS5n/HVrtrGcW0zUpKdtph8wK3aGumBzLeSa3MFHYdNeNKfUQ55dkWVoQEkp+eSkw7jQFeE2Q6y+VvUclno9ssjgV1b9L7Yk65dGHmPYM4JmqfASZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067909; c=relaxed/simple;
	bh=vaOltdXa4VAhEyfQ8+X7BRjyb8ljHVL/fDHb0qRp7L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B26jlmFxneJmMbQx74stxOeNNc5dnpwmx2PxE53923DQSsimYA2dxJkKoopmCTit/yZwFAaEiYhmWZkE1UaN3sOFyHAt2Bj4EoFhNQ7LKrrwc5kzAK+7kG4G2pb7kkvmJD0kUPpcye7CfDtoQ5456l7PSFxOCkalQPvZnF8RAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me8g6n8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me8g6n8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897D4C2BCB4
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 21:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777067908;
	bh=vaOltdXa4VAhEyfQ8+X7BRjyb8ljHVL/fDHb0qRp7L0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Me8g6n8qOPQ9ZXiLb/BNtNC3PktLaNpveiEUxVY3OrfhKBzKnHJ2hgW1s4Vgdg9bf
	 bzUIqEbR70yLM8Vjmj/UVfpsRfxjTQfsBDLlEYgtobSqVrOx3g9LOjBlddLkRlDCm/
	 KXH7ORo+V+cSSkYkPb+XyRYeoeCNIirmP0waE2kZMjuKpWNK40sBFMEfYfS1L8s1Bi
	 VGYRzVT0yC9oqwv3V6myEnHVhQ5DhlSHB1Nv6ITrUiEgnW4vfQZMr6u0U/gE4ohCoc
	 pGqACPonNQRli1wBPY4nOrzpbdTRlc4iCzJ/gXpWajKiINlg30uzUaijQMSp8t3zGO
	 uY2g0DDHy28aQ==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cbc593a67aso768497785a.2
        for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 14:58:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+gi5A/IgrgxLzXnjUmyqHJ8mcptGJA3CuX5PwjVmT6qS/fwIAmKaueC96ZIyx64NUjrdmkOrsM/eefE5ph@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/+IuDu/k9l3FwpaT+zg19K3biQ0ia6aCGKMPHN1IBsE3QiB9
	wzdyvFNsphF8TkVZaAQl10HBgE1kiSLLyW+2rtx/l5y7Tyx0+Uov9pBKhB2unHEFHJLwcRZk0iM
	DEZPTedRLerhEcbUw0+dwfd0b+wx3EmU=
X-Received: by 2002:a05:620a:2684:b0:8ed:dc5a:f668 with SMTP id
 af79cd13be357-8eddc5af741mr2874943985a.58.1777067907775; Fri, 24 Apr 2026
 14:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776916871.git.jpoimboe@kernel.org> <a051f7f3c6adb479cabe0b4e1f08552f1412583e.1776916871.git.jpoimboe@kernel.org>
 <20260423083416.GT3126523@noisy.programming.kicks-ass.net>
In-Reply-To: <20260423083416.GT3126523@noisy.programming.kicks-ass.net>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 14:58:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW680mpsSMUh2jTtH3e-9dKfGKGu4SNtK7Rf_2S0=Yd20g@mail.gmail.com>
X-Gm-Features: AQROBzCOht5ykAX76jFA8WCP8xmntn1nzVU0LWgnAXofi_ZsxEOKSHEnfSNHTVs
Message-ID: <CAPhsuW680mpsSMUh2jTtH3e-9dKfGKGu4SNtK7Rf_2S0=Yd20g@mail.gmail.com>
Subject: Re: [PATCH 26/48] objtool/klp: Don't set sym->file for section symbols
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 1:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Apr 22, 2026 at 09:03:54PM -0700, Josh Poimboeuf wrote:
> > Section symbols aren't grouped after their corresponding FILE symbols.
> > Their sym->file should really be NULL rather than whatever random FILE
> > happened to be last.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Song Liu <song@kernel.org>
