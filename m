Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E840B373
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906887; cv=none; b=lsju4MLBHrcIgdKxi50WkZJyBKck04Obe5CyU5OvuKT7eGclE0XJcrFP49curKh1GhiIzn17wlmScOGAxRaevfRTExfdpZeejaDHNrZIByO/3oFD8Vee4m6kXTt81oIdR1kbqNR8r4dqVGYVtVVOEjfNAMDVFuVM03yZnCAfgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906887; c=relaxed/simple;
	bh=kVxNfQMERSgqbGB36yCf31iyzStLBuOolMk0TLqUSu4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KB/jH7hZBqpsCX/gwk5cggKEtrGe8QWwQDVqcz4jO6IVQqo9f+z5jDhewyPdkXU1dXtQrHJhGYj0+eYPe+o0SApokSD0OGBnYXNuoWiVuPV4pSp4p4GcGN8vtptDmxoLpvwf1ow8tJkAEXNgVsdhsE3Uw4uXZvqYF02WUNnAH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ZQoCx++; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVA5hglF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ZQoCx++; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVA5hglF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ZQoCx++";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVA5hglF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ZQoCx++";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVA5hglF"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id 8DB7275A11;
	Wed,  1 Jul 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782906884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9BReuThzxiLYQ8jve0220IDSFyVVKAZbSngbEwn7zc=;
	b=0ZQoCx++H+MpwRO0ICyVdFg9TWNHJQmLjYQ/MOaoN3mroFdco++MR/wOFyamo+yzYJDsSL
	CQnFB6fEmLWSqge0YhUF7f2ZVSdPbD7dYFyTyXI0Gksx9nYy2aL1JLiYDg2CY1IhLG1LMh
	xu3LhjTljKs09j0gTuZpkVzibgEt908=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782906884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9BReuThzxiLYQ8jve0220IDSFyVVKAZbSngbEwn7zc=;
	b=VVA5hglFm2aAn1VNl46hCwhwpzA5nM8+LE8c/pN+HonfHXMOTHRrGOJuI1BdYD4pb97dMg
	eDZycomtMLQsrRAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0ZQoCx++;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VVA5hglF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782906884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9BReuThzxiLYQ8jve0220IDSFyVVKAZbSngbEwn7zc=;
	b=0ZQoCx++H+MpwRO0ICyVdFg9TWNHJQmLjYQ/MOaoN3mroFdco++MR/wOFyamo+yzYJDsSL
	CQnFB6fEmLWSqge0YhUF7f2ZVSdPbD7dYFyTyXI0Gksx9nYy2aL1JLiYDg2CY1IhLG1LMh
	xu3LhjTljKs09j0gTuZpkVzibgEt908=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782906884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9BReuThzxiLYQ8jve0220IDSFyVVKAZbSngbEwn7zc=;
	b=VVA5hglFm2aAn1VNl46hCwhwpzA5nM8+LE8c/pN+HonfHXMOTHRrGOJuI1BdYD4pb97dMg
	eDZycomtMLQsrRAQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 03/21] arm64: Fix EFI linking with -fdata-sections
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <1e5281cfb9a7daec8283e46e2879be8ec468713c.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <1e5281cfb9a7daec8283e46e2879be8ec468713c.1778642120.git.jpoimboe@kernel.org>
Date: Wed, 01 Jul 2026 13:54:41 +0200
Message-Id: <178290688140.34581.8043883432177532488.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=313; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=kVxNfQMERSgqbGB36yCf31iyzStLBuOolMk0TLqUSu4=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhixXBhanPTHTntQp3uuZY/5uacrT/x80S3WD2OrWrG1g3
 a4s8fp5J6M/CwMjB4OlmCLL673OcoZTcg00q9/dhRnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMGLk4BmGrDKPY/PMempshZ7Xmaw1Yb1BWXremlXibweqLSkd9C4p9mcxYJr1m164fi4+a
 t615mMmb/Lfb/J/4s9v03JucaK4HHaTFXF73uYDRjlTu0l82w4zzzlAWnuSf3mMvM9ww7s1Vhna
 vCjt8CuVZH9GQmFi4I8La/lv8sjIVdePr6H+ryUluqHxw02dn8UVix4dW26Us888yVjDjVNjkx9
 6WIflitu/HBaSczD47GTbMX22d9CzXwCpswM3DFgmOyqosZb344w2yzcVXKytCtIU6887QN7vtq
 3cy7u8InbX3b/wJPly9Fp+YdOBV6t0JDZP702dmlBeds9TWXtx1uMRdZ7PozfYb1/2y1p9sicgO
 PbWkFAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: 8DB7275A11
X-Spam-Flag: YES
X-Spam-Score: 20.38
X-Spam-Level: ********************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [20.38 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[44.71%];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:2b::1244:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	GREYLIST(0.00)[pass,body];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:email,suse.cz:dkim]
X-Spam: Yes

On Tue, 12 May 2026 20:33:59 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> When building with -fdata-sections, the .init.bss section gets split up
> into a bunch of .init.bss.<var> sections.  Make sure they get linked
> into .init.data.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

