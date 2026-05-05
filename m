Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12838F957
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981423; cv=none; b=TRTISULhhVaJGTPIsOzBSZNJbMO/CmrDdjUuMFQQNsvi31/4v5rmHd6qRvbuxnU2XJNbF7cy+1+POmXoRfSXHuQQfCiaOQKVl3WSaihDIMv/MI5aW/nZUaFvgfKbzKp7Wq0GO2hUyckIrNe3Rr2R2kBA3HNovrC01Tf/kLKJZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981423; c=relaxed/simple;
	bh=Jmrc9QDVTQ6TCg2+yMkomIWdO4u+SFaOfX+RU0IQWIM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nYAfZH8hqMmh90hkGcygzCbbnN2bbf09vYKdJF23Hycl/Br7rr+icKL3D0vLN+kc/TqN1mcECXwu1QY3a87lKscEiiy7z+N6ubTTpOPzMKHBXiEixecn+pEz/qNLq1A63xY1059wnkOUZGWOenopB/zPxNPvG6jgP10d/OaRvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FIcSv933; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQBzMBqr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FIcSv933; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQBzMBqr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FIcSv933";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQBzMBqr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FIcSv933";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQBzMBqr"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 5CC945C164;
	Tue,  5 May 2026 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777981420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1F1IMX1vrVQQWv2vSE34FclQt6nEO6RqJePI4CxmdI=;
	b=FIcSv933kIqZ9/lhh6OUc89XYYsK/tlid/KwZn9TzQL1xKQKYSS6Hn9LHLIes3bqUnm8F2
	oc0qkU0tjCsDmSPCiYoKIh8j8e+oXezskGzvNMoOVmzQU786jDGe9xtPBxZ+TTxjddXm07
	SP6typfr7+yeQF3gDcPzM528nTYupnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777981420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1F1IMX1vrVQQWv2vSE34FclQt6nEO6RqJePI4CxmdI=;
	b=rQBzMBqryorAWCEl50LdDdnGEMc8JnFojCZZzH4UpKdS58SfLP+5oIPNqp4STz5u+Kwug9
	Bt7wDnQauAw0EjCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FIcSv933;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rQBzMBqr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777981420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1F1IMX1vrVQQWv2vSE34FclQt6nEO6RqJePI4CxmdI=;
	b=FIcSv933kIqZ9/lhh6OUc89XYYsK/tlid/KwZn9TzQL1xKQKYSS6Hn9LHLIes3bqUnm8F2
	oc0qkU0tjCsDmSPCiYoKIh8j8e+oXezskGzvNMoOVmzQU786jDGe9xtPBxZ+TTxjddXm07
	SP6typfr7+yeQF3gDcPzM528nTYupnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777981420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1F1IMX1vrVQQWv2vSE34FclQt6nEO6RqJePI4CxmdI=;
	b=rQBzMBqryorAWCEl50LdDdnGEMc8JnFojCZZzH4UpKdS58SfLP+5oIPNqp4STz5u+Kwug9
	Bt7wDnQauAw0EjCQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 39/53] objtool/klp: Extricate checksum calculation
 from validate_branch()
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <a455b47ef57dcc3506cd97e3c2027ac744941cf1.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <a455b47ef57dcc3506cd97e3c2027ac744941cf1.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 13:43:37 +0200
Message-Id: <177798141795.9921.5118223797275878948.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=486; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=Jmrc9QDVTQ6TCg2+yMkomIWdO4u+SFaOfX+RU0IQWIM=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBp+dfrshni3wmTdJacU5RYi+HAyqa23cwTwstmA
 oJFcsLpXlGJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCafnX6xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyzPsggAu9ai5GmtZB4AfdqTll8MYQVbrrHSUQL
 4NUDeopxJmWXysYJLStlEKQNuO5DpMs5U9WqRvbk5Q0BfqyW9vzUyn2cd+VXza43L37Aqc8MNHs
 TqH+P4KUXsiGBpd/AEFWh0DCziS9kE1MOQxSsE870Hs6hStX9RgzBwzJvYD7TrpcYqMyRinVIMs
 Af0OrEfkSPF0I88I0ufyEjMz2n90Kgp2Ig1JTyDTVBt3HH0juE/2A2Brv8AqZEis9/rd/GAPF6e
 eX0ZlbGxtREZMQE39/GRpXGfjbNlsnLeAD+0LomT56xBHIv9pTn/pQSomNtvPczUCe7nu58gZmn
 pkVUlJ1pDTQ==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [20.39 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[24.47%];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: 5CC945C164
X-Spam-Score: 20.39
X-Spam-Level: ********************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:27 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> In preparation for porting the checksum code to other arches, make its
> functionality independent from the CFG reverse engineering code.
> 
> Move it into a standalone calculate_checksums() function which iterates
> all functions and instructions directly, rather than being called inline
> from do_validate_branch().
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

