Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5A223328
	for <live-patching@vger.kernel.org>; Mon, 12 Oct 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790116; cv=none; b=qQB/uU0VMOjeqAaKiQ4ceTkQfgqdHUruRbYILol1tSuCQxMxZLwALIp3jkLQVxc031pcpKPvzIw0iE3+sDiL+4c714YL1cnIiJo2FtXJiFbxs7RM6F9nFos4k/aYKfOlQfFE9dzf1AIcpyDZ3Xf0rlP3AKQiQeP28oekyLLudDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790116; c=relaxed/simple;
	bh=Tc/sacdyWHL8SkuhfcMIQ1fz8hopbKPvIyPkcnmDMmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE58jElcUQfyPfC7b3zvAtZ+/5Jd8Z9HcQeFHAJvLJvax1QLp4E7pAjzoW0bDt9uNVho/O/FAkLbEfH6TgdIqaU7NhkpghR2dug+RR974uhg4KZy9MTw4eox6CsPjQ2PeRmzKwinkuW4FcC4v4p7XPCmPa39b4Omg7m49Pj3j9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=At+gV2up; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="At+gV2up"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b042c0759so1081545f8f.2
        for <live-patching@vger.kernel.org>; Mon, 12 Oct 2026 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791790113; x=1792394913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DlkU4W9laIcoZeaq9AIilXLK67G0zj9voBK3DqRejbM=;
        b=At+gV2up7rBancdA0c9Au/OJcfyyePnpgRbsqHlr5x+s+lXsYGUZ4wYmup7Fs/pfdV
         vnlHxLQMg4jlSiyjLEMd7RQiBV9U+mKH8X84pUmawhWIfZ6q1w+fbIbU18eNc0/jp/e8
         njX/WDd2Voi1VFIIswSZjrANlMr5pqHKFf5PVlijap651mgiggDdef486wCQZQyW7u0W
         9Kgzs3/lBB03Rs74rgDNGwDafjIlcZZWUbc+c1iRA3rQisWfM5MDJ1e92WZvIrKepS2y
         +bfzqtE9cJXZKV6y/JpxgrHA0ubBVH/7hJD2ppIOtR3wPrhWXc0FZ0HEKGnjTAStVfvY
         Atlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790113; x=1792394913;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlkU4W9laIcoZeaq9AIilXLK67G0zj9voBK3DqRejbM=;
        b=24jFIzpDnFJ0RIJobFytV8JsCnxsTVe0ZihxQEBl07sVLgsm96DPds0E1DSBsjnVR0
         0+HiMsjNMeHbV32OGicLlqdprV+e3SdPKXQuI48jT6Xy3zwMvz1pLW6USMyN5DWqAXGQ
         MidkT5mxT/j6gKl9+zbH+zj5sklSV4XTGVi+wu6V/NhC9Y2cSlVP7LMfG8c/L21MvMRs
         5E7eE2DlZtIL6w3lRAswGCR4pg5+lyXyM5P6A2QTTG0PQ5Vs4YVSGpRSB68GgfpPkAvy
         PTZhOm9PEV5DnGzniufgup3b8fTbrYY4CblFQdO8xw6kKTKorTzADh4QKrx4YY5GbotP
         mmyQ==
X-Gm-Message-State: AFq9FYJGvDiZak0+sPaeDrqM5RnkufDM5sAST236gQ3NRTVH2E14mN6P
	rv06AmY3vnh2ES/srMMNojQtlNGBIzTth8feQYFqxQ5yZ+qcnVgFAMAJcjv7J/vAh2w=
X-Gm-Gg: AYBFou2gzgGR4Bs1cqsgLN0DoUATqB38OV+MoWkN2m1Fgp4HcacKfazsOFV4baI5jL+
	MrthDHJLo+niJV+gPO2R9nztxeoI/B4RbpHMV+1nrvW2ZAlCi22Jjdgr2mNl0OieNJTnMAvnIGM
	JHbAO9SA+pwZpXAEsWPgIvqS+hqAcLxPM4u8g5FLQWowcv/YnvjxEv+sdQtn8CcgLEPaztglMSg
	W48sKnQf9h1QAIfUSWhYhNJfzj3uh2QUke09RFKkF5RC99kJpn+YHlxTHLQFNB8nw4M3pbynWVN
	8dSHa7uy/lZXoEDgQFZBtgHcOnhq2pOGu4dtTLh/0b1Klvic3uxoYIFPvHyZwZEylGTmYjkBza4
	zeCVlUFn/JO5rjaF7TUpfxLfb6eeYyk2F5bujlvYHuyYExjdo3PPziHeehCmt0Yj86Y2ch0bNdS
	Qijmk4rDczbpdt9N5dUH89qMxeLM/o0o4bZSYeg4IZGqZ443iwRxpaYheTvoviozCR5llNMlPSd
	Zc9Wwvzh+0=
X-Received: by 2002:a05:6000:184e:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-48dbaceb3f2mr13605725f8f.36.1791790113226;
        Mon, 12 Oct 2026 00:28:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm18153423f8f.57.2026.10.12.00.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:28:32 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:28:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH] livepatch: Add Joe and Song as maintainers
Message-ID: <asyMHlXrYVUKJyxc@pathway.suse.cz>
References: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>

On Sat 2026-10-10 13:31:49, Josh Poimboeuf wrote:
> Joe and Song have both been key contributors to livepatch for several
> years.  They have graciously agreed to become maintainers; add them.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
