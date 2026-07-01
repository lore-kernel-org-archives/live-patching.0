Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613F3E834F
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905895; cv=none; b=AqnCyQRG3F6KjtQAE7F2Ii/K3pmxD+w8tNraj6ImBZWDg5Whwye3dFQIIDIrxD6igZcjFVfgXI56884cHkjrGoj3bPiiSMEx6PeVzBxlj/vkZEyvJk1NeBQ0joihL1TZlti76W4bDJer/rOdhQPLv8eRMXEE3he93UWHJhmBiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905895; c=relaxed/simple;
	bh=SAMfrOb1p+K28pgyWC7bL51D2jmUXTJVsleCyv9BOJ8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lWq4x+m+2KNI33Hd+6zXZRChg5A2KQWhTv9Azp8FisOgPvEUk2AjuSVDdiQxM/0eDqA+0EuGbfS0Ldpp8+KRT6T9ARdUHDtuNwK894zrzwkWdWEYrYG8N+5PsiKsSmO8xsVPDR4CTgQ6sEMi7jxd7FG0OEE34nQxkEQ4kRR8Z48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQo0/3HU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HAi5PGU/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukvSJpCV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYEQ/nxT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQo0/3HU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HAi5PGU/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukvSJpCV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYEQ/nxT"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out1.suse.de (Postfix) with ESMTP id 06303720A8;
	Wed,  1 Jul 2026 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782905892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fb8f9wDfz7MXkE6k49lmg7rNVBIg8Uf45Fe7mYiAdc=;
	b=HQo0/3HU0XLn2+hrb6tJE9XCjtJPjOPb+tAQs7WV55FE8Tod9TnVxz9EuVzhT6NrgkskwN
	4uM6T2mJL2Kb+eCslpxs7QZ2Lh9DBkpv+1gjDUSDHWViGcnlKVciBK+xctxkm8aLV7IS2k
	Jb0YQoaO82EbfvJiYkNuZ6x/RNxQAEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782905892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fb8f9wDfz7MXkE6k49lmg7rNVBIg8Uf45Fe7mYiAdc=;
	b=HAi5PGU/atbbdvfUrGcCjg9z+6ZnVRqguzxAYHml8TXqeYUTfefpvuTn+H+Gl0tgbwS4lX
	xuOXaoRhhWZm3rAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ukvSJpCV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="MYEQ/nxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782905891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fb8f9wDfz7MXkE6k49lmg7rNVBIg8Uf45Fe7mYiAdc=;
	b=ukvSJpCV3g4XzwFNBQtNepv2cd9bjdk9ibQjpy/O/6ekO9C7Q/JHzuy0BkhaQTg0NIznmU
	AW4JnSL+1U1aWA87eIHHepMGd1bAFG3/fH2x1OY9Iv4KH1Tf0mhg4NrY9ksrmF7BRbXEMM
	iUVMCByz8TNI+8CrimsgpuZWl54EOh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782905891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fb8f9wDfz7MXkE6k49lmg7rNVBIg8Uf45Fe7mYiAdc=;
	b=MYEQ/nxTXRTZIQMu/xktEvsXFW9PS2qkG6YfJNqOG+4gS+PB2qE5CinZqQE7fAIPWo6A1+
	/TL7dnp/skLXwcCw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/21] klp-build: Reject patches to init/*.c
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <f32864b560d40894cdb70d613480d7c2ecdb55e0.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <f32864b560d40894cdb70d613480d7c2ecdb55e0.1778642120.git.jpoimboe@kernel.org>
Date: Wed, 01 Jul 2026 13:38:06 +0200
Message-Id: <178290588613.34581.17283919272821071617.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=401; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=SAMfrOb1p+K28pgyWC7bL51D2jmUXTJVsleCyv9BOJ8=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhiyXPwpG116LVll4T7662uzH3LJDu1a8MX6kfs353KUzZ
 3nVTue2djL6szAwcjBYiimyvN7rLGc4JddAs/rdXZhBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 zxDI0DFi4OIUgKn+Z8b+T+3Wz4367wT4wlW6Z06e4bU76YHgIY0FhrPP61o7PbrZsHa2w8yYs1O
 XtAg+Ms8qPPe+Korjsd/bxzLuQrXx2S5q3IesRJmbJvq9lTNbnlE559tj1QXHsiL4C+1btLo4La
 rTy6QSfrgc0V7wt+hgQ5n1xCf+Tnt5zcqfsbqpphwJn5fhk2B3vlj6Xfe0eXeSp5ersbfFJ9zwP
 Nj+6WG1t+qNtuXbTuvt2Rwv+GGmxbzkRR7BPQcXp56w96xa2JvOtZ+ZY9rXv36NhyXM4qVf/omc
 dervqhKupWuCOKcZepj/WrCxL21D75P5dxfat9hdjYkzfVK3ZVrb+k/fFkZ0TGeNsfjRUP/uQUT
 gc8UgAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 06303720A8
X-Spam-Flag: YES
X-Spam-Score: 17.61
X-Spam-Level: *****************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.61 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(2.97)[0.991];
	BAYES_HAM(-2.75)[98.92%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Spam: Yes

On Tue, 12 May 2026 20:33:57 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> init/Makefile hard-codes -fno-function-sections and -fno-data-sections,
> overriding the klp-build flags needed for patch generation.
> 
> Don't allow any changes to those files; being init code they aren't
> really patchable anyway.
> 
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

