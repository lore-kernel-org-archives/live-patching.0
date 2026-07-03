Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A6341AC7
	for <live-patching@vger.kernel.org>; Fri,  3 Jul 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067953; cv=none; b=GDlppooZBg6MJOavDMi/sD/Xcr5BC5Vyg/KL9cLFQXB9R3/KYcs3OWj0mgUGZxZ4tR9XbHZ/jFMT3Gg7S+kchgfMWilGypReg7+BaHKSgzJJwqaYonuH21SYvFk+KrwHHi8I2FK17wxsjtYNm3vMG7MipCBtKw5ySZZcaTxcFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067953; c=relaxed/simple;
	bh=cc1YF5Xt6ILBwZEpNWgVPIYMTH4RiRIUrO8CEZqCiAI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=O7MgeFhpTDWubj745NweSoai42yK9tukerDsWanUC9xJIE2twXvV17LUhJk3fHKOFIVmiidv6z4HtpXD//FODQZPj3fXjcRCj1V2y3F+DjkbjsalZtrWWs6zw6J+wEoW8kThbb9TnU7/ys6Zh01+myJbNMPjVgNwuRmCnhTWHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zCNOBjzx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H/v83nw5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YIN6v6wc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oJ0bmoSU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zCNOBjzx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H/v83nw5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YIN6v6wc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oJ0bmoSU"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id C279776295;
	Fri,  3 Jul 2026 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783067950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVCN46FUPtrb2rabya6kBc7h7xw67ekcKSWMFjZW77M=;
	b=zCNOBjzxpmleslMmlUNaH+UCwwGNlKkZZqDmQH8EVA9HCbEjVy4r0TpXodHevqutoi5ayV
	pYlepXhM5JI35yQY+s6HgeX8uphAI/7dndoitiDHw/dqITHdWLLGzwXi0KweziZsOOD1sL
	eXidzRLNI1WpkzM2KH9PfPXP82ook3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783067950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVCN46FUPtrb2rabya6kBc7h7xw67ekcKSWMFjZW77M=;
	b=H/v83nw5Yt5xuNM/cOyvbsxd+kDhKsEBKDgE7GaxccCFyE7N2z7GZ0Q4PUY5q2rkDWtgul
	vZLWOdsDFrUHNdCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YIN6v6wc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oJ0bmoSU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783067949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVCN46FUPtrb2rabya6kBc7h7xw67ekcKSWMFjZW77M=;
	b=YIN6v6wcGBmPdER1DLZaFrgjXjY/QFShEFFyX+pfaLyvLyUOVHW6RI4f3E2A/13x4wf8Vb
	nSUF+tvUFtU7Xnx8xIYqgdHjY0h6dFZRBG+wkpmIqDVmaEDsW08RG+2ZduYCGoa0I/9YVb
	xCR4t0CHhw50uDZBIAX+LKKVSZkB7bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783067949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVCN46FUPtrb2rabya6kBc7h7xw67ekcKSWMFjZW77M=;
	b=oJ0bmoSU8Z3ld2eavU6EN0EZOtWQJokai34GjWF+5DiD9BbvVCMOArCZG2rqVBwBigMWWn
	06UDxonY4+DYMwBw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] kbuild: unset sub_make_done before calling kselftest
 build system
From: Miroslav Benes <mbenes@suse.cz>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 live-patching@vger.kernel.org, shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, Zelin Deng <zelin.deng@linux.alibaba.com>
In-Reply-To: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
References: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
Date: Fri, 03 Jul 2026 10:39:01 +0200
Message-Id: <178306794166.34581.9718581938044856305.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=227; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=cc1YF5Xt6ILBwZEpNWgVPIYMTH4RiRIUrO8CEZqCiAI=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhiz3Uq1DAXPUxDeGX3jLENvXlDQ38cC2ud07A6TtFZdtd
 W5X9LrVyejPwsDIwWAppsjyeq+znOGUXAPN6nd3YQaxMoFMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MApvrYb/b/nq//srGJ/z4gFJtelHPny1vhla8uCQrr88x93y1b62QrtfHzbEG/Zpk
 /Gs/nvmXqvF99xlY0abLPNoOSFQceeL72SJWL/GO6rdRvygqn3lc9TVdS0loj0icU3A9/tHDDr5
 tXzea2fvEJY1wZ/YtxXqifrdK0orP93xpb4jYckP/swBCfKb54pvQy//kNWux7ygx51+d0pDpPN
 D/4I/qD1t3zzQb8Z+8nb8vvubVx273fvfyLVON4nQTCSt7EXAxRTNJiXfTT5c8uu+mV89SUnZKP
 L3apZjJ2KH284oCYuuaRewpx6+Q/ZG0N3C2p6ntvTs02zW0e/mylAif23a4QdYsMrmuZsT7MO+y
 gnjwA
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: *****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.38 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(2.99)[0.997];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,linutronix.de:email]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: C279776295
X-Spam-Score: 17.38
X-Spam: Yes

On Fri, 03 Jul 2026 08:04:08 +0200, Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:
> kbuild: unset sub_make_done before calling kselftest build system

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

