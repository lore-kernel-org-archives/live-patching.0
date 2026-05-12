Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FA25B0BE
	for <live-patching@vger.kernel.org>; Tue, 12 May 2026 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778628661; cv=none; b=ezlZEGZtEXaiIVRpWzHhSklOhpmcH2kV3FmtBK2SvAErqj+zqHIZ/OGlrj8KD+VGVgf8PkfejMOmTRvsMpIdkPPvm0/tx+46wHn5xPXYSlrlR0TAUgoHszuw2u6SEiz9lsNFOzTUNXR3uQJ2oFM7r0pLLW5qhCuFnZ8ryuwVC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778628661; c=relaxed/simple;
	bh=PWN9WjQeZL4CS/4El9jWxT1JcxI8SXHsZnSkEOumzvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyAIRoHdzFoqfI6gFC9Em2ec2rM0+WtjI7KjtDV5HcCHr9Pnc7Ree+OEEmstGsyBB7IdPCxVAwhniq+/iQlZaf4dmHONwYiIMbrYBHgdWrKArLuOglisGqLAnduMb6bXAmRIpL+Kypr6lhDNXqdFUdcYap1aUmniC0RLSgZyU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFwG7psz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFwG7psz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B5FC4AF0B
	for <live-patching@vger.kernel.org>; Tue, 12 May 2026 23:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778628661;
	bh=PWN9WjQeZL4CS/4El9jWxT1JcxI8SXHsZnSkEOumzvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RFwG7pszK6/F+uH3b0xWw/H6IKv5kkYRaBfDZl+lIgXXr/Irt4z0YwLJfNIcLFWB8
	 gfAibShqPZdB4R94LMczDd/bSsoEOk4T8JOxDBMZUWP4gdMyL19ydDni7pU9QphAI9
	 kXTa4iYkw4SdHSzBOuyvgInbj/cWR2T3v4q/kaRBJO+iZ4DCCJ9U91Pjd+6nqzNdcY
	 ud4lFuza5v60vczTusHLkylM/WeTVfyepUvTw7PNbEKF0/07V1Vic+6A7juW5ykJlS
	 eesj/IeOr+Mo130dMGhvM3+bgd2uTMtwpfeSiZB8yqtm5EeQk/74o/2dnVT9zziWMn
	 3LIrF8BT/dL5g==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651bf695701so6700824d50.2
        for <live-patching@vger.kernel.org>; Tue, 12 May 2026 16:31:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxyNF0fUnxX5BiL3XXKRYG446WpRwxwKqtoWOVw6lxBNaV2BKVJ
	nvXNM/cJzHCvEdmG+1sQ9A+Q48A14LYcAJr6uHpP9b+ywJcQv1/GTi3snVnJ2SY06ERfXQhE1GL
	oiTbfLXQq6WtjzL/J5q2aLl9TwwZBmOw=
X-Received: by 2002:a05:690e:480a:b0:65c:6164:f29a with SMTP id
 956f58d0204a3-65df6319231mr815659d50.46.1778628660547; Tue, 12 May 2026
 16:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512221102.2720763-1-joe.lawrence@redhat.com>
In-Reply-To: <20260512221102.2720763-1-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Tue, 12 May 2026 16:30:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6YGdh4xFcsfUiGtVzLg2nR_cEiQpvmyEN+Ffyf_O53LA@mail.gmail.com>
X-Gm-Features: AVHnY4K0Gfzdny_AK3Itks95571WEdlKM1aeyjNb4fcU-GF1M9WckymdT2XOs9I
Message-ID: <CAPhsuW6YGdh4xFcsfUiGtVzLg2nR_cEiQpvmyEN+Ffyf_O53LA@mail.gmail.com>
Subject: Re: [RFC 0/4] klp-build: simple OOT module support
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On Tue, May 12, 2026 at 3:11=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> This patchset introduces support for patching basic out-of-tree (OOT)
> modules.  The primary motivation is to streamline testing for objtool klp
> diff by providing a flexible and stable environment.

Thanks for this work!

I would like to add to the motivation here:

It is actually useful to livepatch OOT modules in production.
When using kpatch-build, we (Meta) generally do not patch OOT
modules. But there was one case where we had to do it, and it
required quite some manual work.

If we can make building livepatch for OOT easy, we are likely to
use it regularly in the future.

Thanks,
Song

[...]
