Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C03859C2
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777632116; cv=none; b=pUJkWGvUQz/xdsWTWgOMfApr0rQdKHR5vDBJsP3DhBVM/R7Nad+2Yy0OLvCyHAyAqATGliq+Fp/3f3TeeLm2Ow9v+Yd0/qmhMpPI83ZIRZ1fPP+8A4iDypQDdbZMHTG8HJVsa2C0zUrDNR+qHkP5W0O0Sn5SO71/QfGM+yuVp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777632116; c=relaxed/simple;
	bh=MW+kKZpBMGELottVBuInenKwPurd9bmlzfGZlhXGDwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApNepus2s5G4WPy+RYMEQbNnAbZYaV2iiuWa6oI74BcpH0JybxZhgmqpAxjfKX5xJXQJBRYMkIW1fLdJYuBaqA7mZATqfPm6L5DeCSCTiCUeP0kN0cDCk8O69eJpaOiQ3cuybdEJE+EDIrkliIwjp7bC2YFxRkTiz84AaFzaDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhl+DrOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhl+DrOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3F1C2BCB7
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777632116;
	bh=MW+kKZpBMGELottVBuInenKwPurd9bmlzfGZlhXGDwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xhl+DrOhJH2v2jJ74S/0Rg+NfHBBHYbkH/pic4z4QhpJvLWPJhmgDbfXQFwNwHO4Y
	 wtFt4aCTY8FKCA6bLb6ixl87sX5gvxgof/9JB527DFGCGkQ4QouTujN5AFOgk+mboZ
	 X92fn3oYobGjpITNKklkdzaysynAs5Hhx0/6wAAq4X72mj52WXfqLBg7EJ5503ddx3
	 OsONFlPUOVjdYAVDA3BLTlp48SeVeMZmtMI3p1sSZ8yhyZ4Ht7Eu5erIVuOQk/DEYF
	 V1QC5c/Z2/kyX7cUo+h+dS6IdRNqmTCKLu/J+jqzt1tmTyGjyShhCcqRqOwMR1ddNm
	 cFokVO3dvVFXQ==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a016799d2cso18903366d6.1
        for <live-patching@vger.kernel.org>; Fri, 01 May 2026 03:41:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8LSd/klWLDhy4W9ZOjwDlnOVaBlSwJVKd8erd/BcfBxH1fw5UTGro3shStJrxxcJLhPSXjFVc2RmU8nHXh@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAVELua/K7mCjBye05YdbUKeFa6AqMXQ4wkJcIjPk975pQcFm
	5s4E+3V1gRm9WXWu/CaUHMBm8LkDS8BtEfXWcA14Vhtt8QpBMm8MvMHY/MW3TQrUFrESggJf0of
	50tHWPvWXqoJfzQsr3ShZXi0g/KHfy8w=
X-Received: by 2002:ad4:4ea1:0:b0:8ac:af40:53d5 with SMTP id
 6a1803df08f44-8b3fece7533mr100712496d6.34.1777632115352; Fri, 01 May 2026
 03:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777575752.git.jpoimboe@kernel.org> <6392d4f0c8837ccc0498a1c79a2d9534dacfce82.1777575752.git.jpoimboe@kernel.org>
In-Reply-To: <6392d4f0c8837ccc0498a1c79a2d9534dacfce82.1777575752.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 1 May 2026 11:41:42 +0100
X-Gmail-Original-Message-ID: <CAPhsuW6fDMrgYAHC+LZmDP+4-u_FaND3cb5U-vtQeM+FpV2XdA@mail.gmail.com>
X-Gm-Features: AVHnY4IzxmAmrpoN6Y71TuN0uZIU1P-H4pYL21ECEHEcCpHrs4eVqEaAI87nukI
Message-ID: <CAPhsuW6fDMrgYAHC+LZmDP+4-u_FaND3cb5U-vtQeM+FpV2XdA@mail.gmail.com>
Subject: Re: [PATCH v2 24/53] klp-build: Fix checksum comparison for changed offsets
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 5:09=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> The klp-build -f/--show-first-changed feature uses diff to compare
> checksum log lines between original and patched objects.  However, diff
> compares entire lines, including the offset field.  When a function is
> at a different section offset, the offset field differs even though the
> instruction checksum is identical, causing the wrong instruction to be
> printed.
>
> Only compare the checksum field when looking for the first changed
> instruction.  Also print both the original and patched offsets when they
> differ.
>
> Fixes: 78be9facfb5e ("livepatch/klp-build: Add --show-first-changed optio=
n to show function divergence")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
