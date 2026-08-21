Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD25A486648
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312358; cv=none; b=KJIVEjONh8sTckB/vXBJQYaasNym8PPlA5n0kv9CnoNomVjfgJBT5ebV8py11TnlFArHtA/YyOtZ2uLwh6JoEx7EbGjtjlTWadfBmejcXZHj2tMzkJ49OjfQyrq41RsnggM384RIfldAGQXubbpHGnDlG1nmqKsRvdom1xsvu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312358; c=relaxed/simple;
	bh=ZCqP4JILFbPDSjTbp4IgJyVQ4m0n4F3q5nmoYZy7eO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EFrS3/CZEHdbXd0WDMcp/yL18TCvSNN6LkBg1VTa63ZZKOFUODHQv7xbfRJyUx3BgMpG0g5o1c4YQsuI4ztcP80mgnwRkYysYUyCVg6NnnzyNyge4eLm5WZHBGlMlojrI51W5pT3E2eRAHV5t+5j4QnUjj0uAGxKIobtMP0Q/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aKqnz9kV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aKqnz9kV"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so1794881a12.0
        for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787312352; x=1787917152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HCHBLwYOrzsMfLvGvn9+AELP12LoSDK9pA2FNZaHrcE=;
        b=aKqnz9kVQTK4L5XwHhFX/HeLvqMNBMEFRgL6pKVct5hj2Sgb8dGfIDDO4lr9jSopkw
         e155QRnAFrwnL57Gj8dsa1D9Xaw/ywpG5EIhSkhkAWYZM3Fu5TA6gDqs+hxIsrQHTOeA
         YLugD4iTQR6Q24gAtHXnJpYD3WwOMkOz387EFBgLe6b/XUca7FTZPl81KNlZS359Vn4d
         C3x+Cb2kQzQ7UiOfcF3oxxYJvLjOZ2Vko3z8hp5npjxJskip4eCJXYhuH/hNbOu2Qjmz
         OAZ/zfKwuBd8c55/noatFhbJSIUh+nqFM1BPA0TSxffpgDsoXswRXakAJLXulbnUeA7J
         4JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312352; x=1787917152;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HCHBLwYOrzsMfLvGvn9+AELP12LoSDK9pA2FNZaHrcE=;
        b=AP1mk81dJg1yUEJA5fz8AzAAt1bFu5L5VCtZwrmyV0p+VVd2F8LLtq89NZBIQCqk/t
         H9UrlIIIzz/K9qiAEkbNDatAJBj8wz8P4kaz3xi0G6N9SrK7zJ8zqE7UwmvpCxEu8Ao0
         1ygFeK1D0u48VLt5Svfc+GQc/XEBpTJVn1++ZkGIU/m/2yd5Xsn4KWNtOUMU6qJqt12a
         SjN2ZwGykmHUGLQ5J36CKUR1deiz5OUjQTwHCR/Gdgh0x9bp7WDjurJnpf8gy8Ar7VD9
         ig5LMTOHQcKwwrO93jIDQP97PKEwTXDCn4Jsj39jNqHHPoLHhGxTzOxfL4SoTI8FX53w
         mq6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpuof2QQ3r8nOFbTqMt63sO5aKPXlwaP4hJlXa0GEGEzIs71pTe7DVowq0qCBdnZ6i6yDPWisNWPVmrpmax@vger.kernel.org
X-Gm-Message-State: AFuF++m3wau2s6zvXJKFVSPo2M+XU/41Dus3YkMTqbu1BON+bcRdPNzj
	9LzgUc+aEflSigd96aZFAFe1jthdCs7wbz8FyjrPwrXQd1tJRSph2Qpk2leQPN2mrZE=
X-Gm-Gg: AR+sD12jcUL84dRN56OR0TgALjSehGvmwFLZWdZm6BIKnRxPcJMbzOdU6jjYKZPK0YO
	JiKAySyI2vRJgy1ZXLIMtdtfLYRb1qP7BKTpEsp1e9fOsbhLBSsjGQV3OmzlRaDKuh8iAqjvpck
	kuO5K4DrGjzXBjClnmtiaS0f+v+DtF+bdISRonuBbq2NSRFHqLsHKqJaUN3C8wC+5w98GoxtARX
	+t4rU51aDFLgzJBwyliZdyKOgRpxOLONB5dUaqhKoLh0+uEKrCAMeA37KnTlhbx2k3WLQiQ9k9x
	oOwz8FGBNrQbjbs4kbzQ7yfKoUrY3ObSzscXxdPFBNDlXlBPKlJpFbmVw/8+sZlIUhhNbB+F+Q2
	h89gIji+8Rhqpjjuu7wd1rt0GgWWCsV9sgCaFGoBxWUW15naFa2Q0o3S8by8oMj1uO27aI+GpqG
	uhi+yBBs+3OQUP2rgpUbDN0lSBX7H1mk26BMpHhWbW/H24vim747Eu2C/WNLakDw==
X-Received: by 2002:a05:6402:eaa:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a42f28e8e8mr6157293a12.15.1787312352266;
        Fri, 21 Aug 2026 04:39:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9e2esm6041668a12.5.2026.08.21.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:39:11 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:39:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 7.3
Message-ID: <aog43Saa86EsHfoX@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull the latest livepatching changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.3

===================================

- Move consistency checks to catch missing func->old_name before
  the first access

- Allow to run livepatching selftests from top-level directory

----------------------------------------------------------------
Thomas Weiﬂschuh (1):
      kbuild: unset sub_make_done before calling kselftest build system

Yafang Shao (1):
      livepatch: Fix NULL pointer dereference in klp_find_func()

 Makefile                |  4 ++--
 kernel/livepatch/core.c | 34 ++++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 14 deletions(-)
