Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAF374160
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022497; cv=none; b=R2Y5M7hk3YDvlVCRH2xYoTBJvImeN3kr6fNYpC5wpMpgFAndqVNX5I64DwtOBdxuFR4F+X8u3u8oPSnPm/tj5fIULpE3M4bn1f7OO34ifkOmW8+znI67KwIQhsqKBZUA6W42Lp+hEYJLEPEguGuIb0I/ERQHHWKE9g7YjJGVgaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022497; c=relaxed/simple;
	bh=gXUVOkKH4lvOD/nKiaycUJCBD0dXbIS4d0Lb0FKd8/A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZSjdSlvDaZNFw3fOQkrXNqlxFGN8cj1VDcTcsPuKQobdKb85yF/H+KOvR773es/Ie2j/FWZrTJBVkExJIvfTgJKnvRGKoEjyw1Z50SqQrihBnhtxAXy2f6kDef1RNRnFgst/PvLod4W0tUuLTJ8PoZTzUveAhX0wSnPoZeDpgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjMpZkNq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqI0oEDk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C/4JnMR0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vr8wVC9E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjMpZkNq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqI0oEDk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C/4JnMR0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vr8wVC9E"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id 023A85BD89;
	Fri, 24 Apr 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777022493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pJnErp+CYf4hd2uIiLFiT2edcsGTL0IGdjLyotclq8=;
	b=TjMpZkNqcYOOvLljnXynLX+0M/Ungs6LbmR2UFPNfPyorayQf0e9tuefSUcCGfGacpTagj
	ZR/KKPOGf4dJSmuiDzjhmt6A0Rbo2xqNxt5SDZz40Al0D7ZIrKo8yrmq40DqJMjnc2NQrQ
	Z2uib0wBjVssebl7JOQVacZO2HOq/fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777022493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pJnErp+CYf4hd2uIiLFiT2edcsGTL0IGdjLyotclq8=;
	b=HqI0oEDkbu6tVd5jTW8g0IphkNPtBoRc0sQ7paUXqUk7fg7YQxN8Z2SNq2kRqgmabFXHrt
	6lC5XCj6jnACg9Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="C/4JnMR0";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Vr8wVC9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777022492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pJnErp+CYf4hd2uIiLFiT2edcsGTL0IGdjLyotclq8=;
	b=C/4JnMR0o0pqqDMlIA5TfoNcBkM8/FPoE96TC0KM7WbgxtwhZKo8uOiNDWe++0mlJlZRvv
	M8SssJcZ8ymBadTgChdwZ5QOdNrCYJBhcmHRrJki59Jwi54AWS5pG2YdKBWGwNVT21D64I
	HrWb0snY0yYBsSGZpijDNGm3t3NTD1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777022492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pJnErp+CYf4hd2uIiLFiT2edcsGTL0IGdjLyotclq8=;
	b=Vr8wVC9ECJ+9fYMWYrg3U0SVMjdCK2BqsQ3UetNHNukUxf2mFOzKvlKVSyTXQjKkZirXrH
	EALUFUCKl+aHl5BA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/48] objtool/klp: Fix .data..once static local
 non-correlation
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <f34990d29dd7642ada7843613c96c563043c28a5.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <f34990d29dd7642ada7843613c96c563043c28a5.1776916871.git.jpoimboe@kernel.org>
Date: Fri, 24 Apr 2026 11:21:28 +0200
Message-Id: <177702248890.199199.1219124531741486005.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=345; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=gXUVOkKH4lvOD/nKiaycUJCBD0dXbIS4d0Lb0FKd8/A=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhszXZtK9Bdk9661OaHSfsnP81H5bZMfzk92rtfojTJ9Pt
 a15EfO1k9GfhYGRg8FSTJHl9V5nOcMpuQaa1e/uwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjhEDF6cATPWPzey/2QJljjxRWDwv8XuJFTt/58o9937XXNdzZTOqmnaQd+GNjQp8bYvL/lT
 VvLn7ylRndsmUC/0akQ+/sJZdalM4O02ixWDhdZtdP2vr6xdumft1o0ZVi8bS5O2H5ijwM5sZrj
 ruVmJdvTfkVpiBiLdGMqvEycofj4Skqv7UzD/9YwLX7Cf1W7Y8kz26NEmuKEIj1l5w48K648sFj
 DKLX4emSt36yn1KSO6DpQ3zyzsLAqwepF26unh+3ouVhZKTlpleaTG8rq5mz8KabS2ub8Z2IL7r
 l/394AsLk1Q+vNGYNfWLd61C/LSMbblnciVOybLNsRGyM+ir602aVSVe3r/iXJVw54IFu9Xv+x4
 tNVgKAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.70 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	BAYES_HAM(-2.69)[98.64%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:2b::1244:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,localhost.localdomain:helo]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 023A85BD89
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 17.70
X-Spam-Level: *****************
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:30 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> While there was once a section named .data.once, it has since been
> renamed to .data..once with commit dbefa1f31a91 ("Rename .data.once to
> .data..once to fix resetting WARN*_ONCE").  Fix it.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

