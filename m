Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035640682E
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906137; cv=none; b=XSxNpgEDRhukxvPR1Qa4KeCslxQlyq+CD7K16Ny6Rsia0+X1dGk8R4Yh1jHXlUdi0vPdI89Gp9bKAmbQeKsXnB7qPPX/jXoRsAQlXykw0WFhp2NazS7vO14Mk0rtJdhK73Y7EzUV30CLdimeMm1iV7V/V9U2vEiKtVsrk0JeNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906137; c=relaxed/simple;
	bh=JYSrCbrFKefp1hdojTUQBWfP3PbQAXF/uMs+RNkXoCg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YGe9VnOpTfp9OifvUj/1C9G3RNmxLXbfj1rru1z3TBPtj+X68TuBx8FvI46fSaRfIAdVgxSwvJjwDsXq3RkTTRKjU9L3SKfzKSLMFqGc/P6kOHcxJOH4ht831jR//UueVv9eOxQkWAFIsuLaet7OudSstm7l8/Qhcdclp0QKb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tRHDdpKi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pB4MPhLo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSQ123kQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KqCs2iDM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tRHDdpKi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pB4MPhLo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSQ123kQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KqCs2iDM"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0A78E71CD2;
	Wed,  1 Jul 2026 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782906132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piiWRlpYTRZAD2fjPOu7K7otZaFPuCsB+3Z6SScuXK0=;
	b=tRHDdpKiDpNocLlpLAx1gX634CPdip++I/uKLYP69gLAO0KjKkaPO2+mZK0SMEwQl/WqsH
	7rzf4N4sPa1LIaXwMNFgWg2IYXja1tZedoqviDrCiVrcCbTAr0BuNWAOhfFZ0xWpFWTMxX
	qgmWyLKFeCgp/G4XVCepiPWpYOFgD+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782906132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piiWRlpYTRZAD2fjPOu7K7otZaFPuCsB+3Z6SScuXK0=;
	b=pB4MPhLo1xFWevDZ9aDsgaNAXdzURi1WnoKc4KCtfYV30W/QpjnF6w9g5phpOYIyfhpw50
	VddCD28WR3f05TAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mSQ123kQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KqCs2iDM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782906131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piiWRlpYTRZAD2fjPOu7K7otZaFPuCsB+3Z6SScuXK0=;
	b=mSQ123kQ8fmUeNZR254R7qrvrlUbHfg/YMumaocC2GzbKpQvjrWDCmLwsFlQ+Ool+wgrWr
	TOJyHRgLJNyAxzIrZUCNrHmjTOfWd11uiFZOXbzEnxKG4cnXPEGyHG7vVGbIJLk1jtktXL
	Eblrug6ZU5DpryEMGKmQUFBOIa3SRjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782906131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piiWRlpYTRZAD2fjPOu7K7otZaFPuCsB+3Z6SScuXK0=;
	b=KqCs2iDMFJgQJPUX0kw0sKU+PSFmtd6n2kuXQAAGcRESn3P2sMespDsRG29Xs947Vq79WZ
	KFIYXCClL7I1VsCQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/21] arm64: Annotate intra-function calls
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <16bdb04ed6653809514d9f060702248b8e587f05.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <16bdb04ed6653809514d9f060702248b8e587f05.1778642120.git.jpoimboe@kernel.org>
Date: Wed, 01 Jul 2026 13:42:08 +0200
Message-Id: <178290612882.34581.5307798857792988726.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=229; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=JYSrCbrFKefp1hdojTUQBWfP3PbQAXF/uMs+RNkXoCg=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhiyXv0JxK7237TVLNJW7/Gb/E8+pvWk9tf4rH54L2FK1k
 qXgt2VwJ6M/CwMjB4OlmCLL673OcoZTcg00q9/dhRnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMGLk4BmGqtPPa/oqFLzilqqM/Ytsb4fVtH/YZr4bdjY8y4tptvqZ6TI/6jxKLSV6UgpH+
 vwospx/wrbr+TDeopmLPjxItZLOUZMyof1LUsY35TrP/dL19Xpalv/7wYb70g07Rgi48JvnY3S7
 7PM2R70Von8/3g1dAQ59DFTQ66M0zm9DTc2cblfXBTcZxZ++3+Bb+MdstMOXJcznmFYNH1sP0H/
 zkpieQWmPpOPfHpKgf/ahc+9sLLsdmbfthKTrIJ5ksOcF3l8/Phbwl2FY6S2OXZmec8WQL5v4pY
 3rp5vHaSQMnmiz//HQw8zTb9Q3zA9uKWjLifYT7dbr0Xf3/4s+PFXxulI04HON8mvYm+4imjUDK
 lrB8A
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: *****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.42 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	BAYES_HAM(-2.97)[99.88%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:2b::1244:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 0A78E71CD2
X-Spam-Score: 17.42
X-Spam: Yes

On Tue, 12 May 2026 20:33:58 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> In preparation for enabling objtool on arm64, annotate intra-function
> calls.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

