Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84D309F1D
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974274; cv=none; b=qJtUIAqkrloebcQBxJwfO2HtYr0hguK73iSyGufDGpaPZRmd2BdXcPOnGV3NOgt7p3RQjbtMlBiLonNnJ4sNJAHahnsr+M+x5VPQn8eoiMNEqslj44MuTk2F+veRvR4OWHUs9eySIK5UCXxs4hv7ONTwi8ocJYMOFsjjckiBWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974274; c=relaxed/simple;
	bh=U8ediHzQjywW9GUIfTiRkHhC3ryQi1ZQKB8wpn6Rz6g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=PpMb3kopWY1IJfxRQgn1hrQdX+wIGBNy198zKoEbNseRDtEvRWUlrWvPXfyS72IQCjCQAIdhJbuhmBaIUIDCp2K2lyMPtHyOjzCgd4CCUX5P51ydt6ud5CFoSYoPvyAJ3Uj3BNfwQfisZcywaMLFLRSPodJ0P0zFdgkNrqiKzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LfKLukFz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tbmvhoWh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LfKLukFz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tbmvhoWh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfKLukFz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tbmvhoWh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfKLukFz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tbmvhoWh"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id CBEAB5C515;
	Tue,  5 May 2026 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777974259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ibjfc/KPv+u9Xb16gzYUtBn0JbThgkFDy3swrOEiQnc=;
	b=LfKLukFzsJoIJ3AhPFO6NFM33aaVyX6SsxNerXybkVUCP2yu0sW+mNY/HWOMjCrTELIM0O
	7sf4LRYj2DHovlf9tRdoYWELFZBnlL0bkIMKIjeOzi6WhZCfT0S/m4O94I8Po6ETAw9K+T
	URj4zQONkVqZGtfEy04HXbTYlYk9bI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777974259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ibjfc/KPv+u9Xb16gzYUtBn0JbThgkFDy3swrOEiQnc=;
	b=tbmvhoWhEmy1dsoIYDIUMQUvAONCrNX6JJ6fAvSq+pkRMM3BS/yiXNnskOohXBtDGDq576
	GKfg2S7El9IWmbDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LfKLukFz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tbmvhoWh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777974259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ibjfc/KPv+u9Xb16gzYUtBn0JbThgkFDy3swrOEiQnc=;
	b=LfKLukFzsJoIJ3AhPFO6NFM33aaVyX6SsxNerXybkVUCP2yu0sW+mNY/HWOMjCrTELIM0O
	7sf4LRYj2DHovlf9tRdoYWELFZBnlL0bkIMKIjeOzi6WhZCfT0S/m4O94I8Po6ETAw9K+T
	URj4zQONkVqZGtfEy04HXbTYlYk9bI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777974259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ibjfc/KPv+u9Xb16gzYUtBn0JbThgkFDy3swrOEiQnc=;
	b=tbmvhoWhEmy1dsoIYDIUMQUvAONCrNX6JJ6fAvSq+pkRMM3BS/yiXNnskOohXBtDGDq576
	GKfg2S7El9IWmbDw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 21/53] objtool/klp: Fix reloc corruption in
 convert_reloc_sym_to_secsym()
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <9b419d82a20dbc54be4a59cfec04ab13987a2e6c.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <9b419d82a20dbc54be4a59cfec04ab13987a2e6c.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 11:44:14 +0200
Message-Id: <177797425478.9921.3938424058816708839.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=322; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=U8ediHzQjywW9GUIfTiRkHhC3ryQi1ZQKB8wpn6Rz6g=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhsyfuz8ufVVqpBg6deuBRw0rD/198ldpzYpF3jv//HJLZ
 v7zXkbFu5PRn4WBkYPBUkyR5fVeZznDKbkGmtXv7sIMYmUCmSIt0sAABCwMfLmJeaVGOkZ6ptqG
 eoZAho4RAxenAEx12H32fwZlNUwxrusM7qrwZO1T+rTn7EaHNzEl7+cULw9imZ4suWyd5aITKde
 WflLk4Xc49Vl6kepV/QamvuCOt/11a3SLgjfvWDXvi5+jWE3drwo9VoXFwY+OG3HFxhqYzcz5NM
 Xt0Zatfv8nvS743bi6QeKQUFzS6rU6W1mXGd8TXbdlvaP1+ZlT/kZFbL92fZ3utG2m1wvmHtqva
 V6196VP40EhzqSI9Ch1LYXnui+W7tPevjZgOmNEdUKSa9vLqf5PXvgoe0zO9ZihFvs/95rjZyNb
 6QsMDJxX6768vv3tg372H4dFHx+8rWSazqqmOiN//fGzTG/8124XLdI4wZ+VLpLlsCaG7WaQbBl
 f8fyzSQA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [17.88 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.49)[0.998];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	BAYES_HAM(-2.50)[97.74%];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	R_RATELIMIT(0.00)[to_ip_from(RLhhr1kjtirn5oxn4gcky1j98z)];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,localhost.localdomain:helo]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: CBEAB5C515
X-Spam-Flag: YES
X-Spam-Score: 17.88
X-Spam-Level: *****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:09 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Use the section symbol's index instead of the old symbol's index when
> updating the ELF relocation entry in convert_reloc_sym_to_secsym().
> 
> Found by Sashiko review.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

