Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A049253D
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921708; cv=none; b=WBW5aTw3OJyYOAPhW+LcdIMwtjTWfUZL5rdtlARgjkEEE+aiYC/iMRJnTKxiQVqQ+UJXrMackXIDM5leMT2dkTB5QJvk02Y10vfdHlIG2riUSKqWuis0qhNnzYulDIbBfAdzumM0Kz25NQm7A7ySDAAX84EJBAmH8FpJqaeC+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921708; c=relaxed/simple;
	bh=kOzK8Sb/BEPC9GFIXF/dUaN5CCdFXxj4X2mD0e76mbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BCUVMrVAzejdl3GUIEHMQBIp5mzXNnhJoQwovzBK/QazY2p9kp0kp7+KOvAj4nuXqgwKlhLMbRxMae23DZVpueridnbq2uCDyTcf4GpjUTnu4yvAQTrAHHv/r4Mbg12Y3vYCAF6vmrYVKJQ3Xgc5z5DnfHvMI3ZEHMP50SVSjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXsbgVJR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXsbgVJR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45fd464d51fso412418f8f.3
        for <live-patching@vger.kernel.org>; Wed, 01 Jul 2026 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782921706; x=1783526506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=179+zrseTR4/S/uTWf3ZnuYjyb9u/2hFDqTScZF/rko=;
        b=IXsbgVJRm72+SXIP5r7fDqC6h/RHrzuZ8OPjY01ZKCW98U8sfPP8Mln4WNq83V1tEI
         Bm5eGmvmNcQE0ST3YYLEOa4SGdjhWyvM+AJ8bd+4iCnl5UzdibWyp4Uauaiex9Fxop00
         HZSlqwegxLx9+R31J+Z+dliIjpmZil2w05FxPXq8yxr7Wb8AdxaNtoyUnWGCG8Vq8K8L
         Cwcv6PFK+4fXEjC9xSaphN8GbF6dqqnBQIb8yPl6OVCGilptbNxAIQezhLKfltZIWFBG
         W1+22e8pRku8DW2b7+p+B+JF7eZUCoUtJVrJM/x5KnUtteOhDmh04gERT0VotpUXYufO
         K0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921706; x=1783526506;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=179+zrseTR4/S/uTWf3ZnuYjyb9u/2hFDqTScZF/rko=;
        b=otckeYrEYk2d/+AQ75tyeLHyFyAqxJZrIWDzFhGLK1Pjq/wE26+3cccijtgCtlgUPZ
         xuQCiu7uZIbMEsIDBmRwSep+6bLJ33Bv7sPb6XKyx0YhyI2D23/qx3lOogBxZ6oH9A65
         S1FalKA8oiCt2yRILn0MUwO/+5Bm7Uj5vsw8pXD12NN14uIolK/hO7qPcqgpdf/SpLNr
         mcODW+seQVRXWT7N6wXjNN0CmLEA7zoiT4UpUcTrRBkWraDd7RAioGJNyIlFu+COes5n
         DxnMRN2NzdN3us1ojVsm9v5lWsR3uG8MK4Bb1d9HOAKuOdOLAvZP3DPnHuZFtJljeunO
         a5qA==
X-Gm-Message-State: AOJu0Ywft5w+QQeFNp2GkcQz5gS3cDrn32eshwWMWrlZLbJenXjLWrpd
	oQXVnRViOPN1fsxGOF6iVIEUuBuxI01rXPLkDuqXWAU85X2YHJZ5I9R/MGZsgOXN6+bmkhyWHvM
	VeQF11lQ=
X-Gm-Gg: AfdE7ckgcVoZNhi/bkZDAU+vwT0uRuWslv7Pu2LLLQuXrN69b2HT8+KbfIQQuMPy5N9
	WP4Hz6v4vgZOv/81LD4PS45e7HRFeS5I5+fpK6agXxyv45piFZvACqogPyHdaPzUGKWpq3tEdwa
	Byh8IzYT4PmKnC4U9OJMe6ut/WwYAO0tFnCwSLrjCjj+aHtqTBXHX7SrBXf1K96H34jSgowCORM
	fBqS/7EMRkOWh/sksufT6ZUiW3IUNdWkNeXN34j6t7bu3VKikJOsu9BgYgyiS6tmXmu7wlRCnyN
	UXYwGRlMr0IZbEQymfujy1tjh2ombYW1cCZFf+BRb/yMGUJxXKah2557gc3yE0N2J961pyWR4c4
	/nSzj6CMQqLTQmU50jIqrWM86of0oCubEpbdZORzNBrnvEIwkQc8IT5KlLi4/RpS9omuZnT27ma
	RR2tkm0f+ifMFfPp8=
X-Received: by 2002:a05:6000:471d:b0:464:8d68:618a with SMTP id ffacd0b85a97d-4775918f89emr3819505f8f.32.1782921705720;
        Wed, 01 Jul 2026 09:01:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dde19e8dsm855163f8f.27.2026.07.01.09.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:01:45 -0700 (PDT)
Date: Wed, 1 Jul 2026 18:01:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>
Subject: [ANNOUNCEMENT/CFP] LPC 2026 Live Patching MC
Message-ID: <akU55z5bzhHhUV9R@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

We are pleased to announce the Call for Subtopic Proposals (CFP)
for the Live Patching Micro Conference (MC)
at the 2026 edition of the Linux Plumbers Conference (LPC),
taking place in Prague, Czechia, from October 5–7, 2026:

 https://lpc.events/event/20/sessions/258/

The Live Patching MC at Linux Plumbers 2026 aims to gather
stakeholders  and interested parties to discuss proposed features
and outstanding issues in the kernel live patching.

Possible topics for this year:

  - Test framework for livepatch subsystem and the new klp-build
    toolchain

  - Live Patch compatibility with tracing solutions (kprobe, ftrace,
    BPF trampoline, etc.)

  - Replace the wild no-replace mode with independent replace sets,
    merge slots, provides, or obsoletes

  - Split a live patch module into submodules

  - SFrame and livepatch

  - Hybrid live patch idea

  - Use AI to help build live patch

Proposals can be submitted here (select "Live Patching MC" as the track):

 https://lpc.events/event/20/abstracts/

Please submit your proposals by August 7, 2026 to give us time to schedule talks
in advance of the conference.

Note that the primary purpose of a microconference talk is open discussion, not
formal presentations. Slides should be brief and only provide context. Each
15-30 minute topic is intended to encourage brainstorming and discuss open
issues, not necessarily to resolve them.

For any questions, feel free to contact the microconference leads:

 - Song Liu <song@kernel.org>
 - Joe Lawrence <joe.lawrence@redhat.com>
 - Josh Poimboeuf <jpoimboe@kernel.org>
 - Miroslav Benes <mbenes@suse.cz>
 - Petr Mladek <pmladek@suse.com>
 - Jiri Kosina <jikos@kernel.org>

We look forward to your proposals!

Best Regards,
Petr
