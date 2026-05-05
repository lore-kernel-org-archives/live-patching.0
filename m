Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1A3264C8
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974269; cv=none; b=Po7XIwK6LbO1tJHjv/XTte8bMLiI3rda0+NP2fpQNkfF6OJ5wJO+GvHdqZmIqokNdJk1Hp7JQ2FZEhw/WClHnienFSaIGpmw9gxp2Wi+Ah2/twqBSCgsRQaBp2FY95kL+dUATODZl4KakS0ZUVQ3q0UaYn51b6I9Rsr6v7F9i1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974269; c=relaxed/simple;
	bh=IvkFq92tlZDzwjh8HUvBisnCIkLmYAmneEiKmUaeHsA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JtrE3zl2lGEmQf9NxqjVVSE4SSGx5E5gJtfhBk92GKqZ8pkgsyOZAQeSAJf1b4rVCqpuLzx5qsPVC8L0VlH8oLFmabyR2z3wF6wEc7GOeKFoUiHbl5P5j2cqZ3lVdLrb+mp/pKZ1L5bDW9O5JJZy12qDpRDjVvOa7Cn0ZU74ycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jDivtnlG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iPuGgGi4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jDivtnlG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iPuGgGi4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jDivtnlG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iPuGgGi4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jDivtnlG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iPuGgGi4"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9C1675BE33;
	Tue,  5 May 2026 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777974259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcM+s0oEFn277uRobkB4CSxs9GL0QzSFjJz2Xwom/bc=;
	b=jDivtnlGWz0Y+qzEts9+46W70eGh9rXrhDEWgIR0X8SXgBKASMnoccjfrtYD2Fq5aFRmy3
	Zjrxhdh6JqXeUFZMAie7p1z4CfBGrfy3hiRhX55nOx5dQ1onD4lPhCU+gqQQzbw0C4G7rJ
	5MOef9M88ki7l3gqjkcQQpJq3PIR1SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777974259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcM+s0oEFn277uRobkB4CSxs9GL0QzSFjJz2Xwom/bc=;
	b=iPuGgGi4diM9lop676MK0hVLQxDz4+1lf1ZdlzlVy1Pmpw287OsJBQud5/b/K8yqfN7uz+
	xqjRHLknwb5oVYBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jDivtnlG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iPuGgGi4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777974259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcM+s0oEFn277uRobkB4CSxs9GL0QzSFjJz2Xwom/bc=;
	b=jDivtnlGWz0Y+qzEts9+46W70eGh9rXrhDEWgIR0X8SXgBKASMnoccjfrtYD2Fq5aFRmy3
	Zjrxhdh6JqXeUFZMAie7p1z4CfBGrfy3hiRhX55nOx5dQ1onD4lPhCU+gqQQzbw0C4G7rJ
	5MOef9M88ki7l3gqjkcQQpJq3PIR1SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777974259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcM+s0oEFn277uRobkB4CSxs9GL0QzSFjJz2Xwom/bc=;
	b=iPuGgGi4diM9lop676MK0hVLQxDz4+1lf1ZdlzlVy1Pmpw287OsJBQud5/b/K8yqfN7uz+
	xqjRHLknwb5oVYBQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 20/53] objtool/klp: Don't correlate .rodata.cst*
 constant pool objects
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <80d6f8df4db610a6c9f68031dc0153f04814f2fa.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <80d6f8df4db610a6c9f68031dc0153f04814f2fa.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 11:44:14 +0200
Message-Id: <177797425477.9921.14939812739764742317.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=IvkFq92tlZDzwjh8HUvBisnCIkLmYAmneEiKmUaeHsA=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBp+bvx3mvJXBDxAIStCaA4OD3xcJtl9uyZMm1Is
 aM5Lbe0cxOJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCafm78RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyzfUwf+JzkC6VIBik6ZrvCybCxHAHnxbmyInPl
 PNqWjPFMYkeVrPE95uF6vC+BJNEEZAW3xpIRniESJD/Tsq83bnfhC9JF9VgT9WV6jACGIQa3oOF
 ZpSZ6zufQELxcbMySQE57JBKlSreH7u7P4yolojIUZE7p6ZjMHcMr3U5IY4pAYgTrPFzfxZ7wtu
 ndbaU/V6+KR7QKc1fW/Xy2q8SYZ529677zcVSWYyKHEqLLysuvKLYazkwUrY6l9+8KWii5BE3Lz
 mMoZ3Cptg4NM/TPXWsEbXcXSPCREx8OoJCrgAmirwNrxB5VEqw6FA8oRep4fnSbl7McMbPP68J6
 JvOj/04xvsA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [20.38 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.49)[0.998];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	GREYLIST(0.00)[pass,meta];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: 9C1675BE33
X-Spam-Flag: YES
X-Spam-Score: 20.38
X-Spam-Level: ********************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:08 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Clang aggregates UBSAN type descriptors into shared anonymous
> .data..L__unnamed_* sections.  This data is used by UBSAN trap handlers.
> 
> When a changed function has an UBSAN bounds check, klp-diff clones the
> entire UBSAN data section associated with the TU.  Relocations within
> the cloned section that reference named rodata objects in .rodata.cst*
> (like 'exponent', 'pirq_ali_set.irqmap') become KLP relocations because
> those objects now get correlated.
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

