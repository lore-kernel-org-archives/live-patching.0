Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C243D50B
	for <live-patching@vger.kernel.org>; Tue, 28 Apr 2026 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380210; cv=none; b=B8ghRLc6Riy3+5Ocl0lLMpQlyj6g2g7lHMBouX2IX1DbkovTrBdJWbuMs24oxTHJuihpo79G0h8zMRBjjzq4jvT+N0pXCnD52n1lTWo0fsNiLejfODzs0w/UxXKjjvwEHIAdENC+kfsv//080esgt2Rl1QdANMDsjctZXVki5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380210; c=relaxed/simple;
	bh=j9zSvycfEI+cqAeqeLhj7cyloZsUH9IobGzcXD4Ol0g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=a1gpuM2ckkJ6jKPi6nCw/OdURZgbzEKrpF/y1vFPkPv54Ltgi2v3oGW0hL7xbsFkLsYGixxCX2ZdOt1nGxJ44bzZfbYqknUFlhLntKaoraOt5T3qmyC8zVpZC/sJSY1g2ILdFnhDidXlpfcafRrkZ/n8sUwvJtDP/6YAMf63Hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hGzPOc2Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rUu/OMyO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hGzPOc2Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rUu/OMyO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hGzPOc2Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rUu/OMyO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hGzPOc2Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rUu/OMyO"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id F1E7E6A85C;
	Tue, 28 Apr 2026 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/AXqg09/vAHVrcNUKkgCZqB8aBJIKXygM2QhrPjIh4=;
	b=hGzPOc2YV1et2upi/9Jr+Fu6ZM7wV1yHoGnpWrB1CFAfkhUStaFWLQYTegonVcGjiVSgQh
	obdvUTlWcCh7UxbXO5qmROtua/yq/KfHYZ7O9Pg5fiqgP3gV5nq2NJjs76REYEVy9uXJQy
	hZgr/ZkHKW5YZc1MNEv6Qlyaj5AYiuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/AXqg09/vAHVrcNUKkgCZqB8aBJIKXygM2QhrPjIh4=;
	b=rUu/OMyOd9ZgUCBFYZJy0ii/RTsi+0dMX1OakF77I3gUEbtNBcxEOmbnlJblFduEH7oWKV
	Q4x0TtX+ZTKR9TBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hGzPOc2Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="rUu/OMyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/AXqg09/vAHVrcNUKkgCZqB8aBJIKXygM2QhrPjIh4=;
	b=hGzPOc2YV1et2upi/9Jr+Fu6ZM7wV1yHoGnpWrB1CFAfkhUStaFWLQYTegonVcGjiVSgQh
	obdvUTlWcCh7UxbXO5qmROtua/yq/KfHYZ7O9Pg5fiqgP3gV5nq2NJjs76REYEVy9uXJQy
	hZgr/ZkHKW5YZc1MNEv6Qlyaj5AYiuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/AXqg09/vAHVrcNUKkgCZqB8aBJIKXygM2QhrPjIh4=;
	b=rUu/OMyOd9ZgUCBFYZJy0ii/RTsi+0dMX1OakF77I3gUEbtNBcxEOmbnlJblFduEH7oWKV
	Q4x0TtX+ZTKR9TBQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 14/48] objtool/klp: Fix extraction of text annotations
 for alternatives
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <5e67de043745aec66abf963edbd74d13c5ea142a.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <5e67de043745aec66abf963edbd74d13c5ea142a.1776916871.git.jpoimboe@kernel.org>
Date: Tue, 28 Apr 2026 14:42:55 +0200
Message-Id: <177738017546.11371.6806389605715238829.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=455; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=j9zSvycfEI+cqAeqeLhj7cyloZsUH9IobGzcXD4Ol0g=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBp8KtRnpNbGiH4FXZKqCzElMtGnG047Z0jG4bOm
 jwNBD12h5iJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCafCrURsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyy+UggAspa/WZUOLOqUbHrvoXiOL0Us4enuxbr
 ph4nMepGJoY+ALC3sh16QK+U3lBm88FxSrpo+/Y+0+75JNb34no5JcUodVBTSop1upy26bEfGQQ
 nKN00/sDcKR51tf1oL836wPeLF3T4/ERY1tQV2XsirWWgnwwcoC1nC8riHbu9r6ivD3QmNWV0MD
 drbtzHLvreK+VDax9bUbyTsjAUcX9D0qdTG33/Z6+979gC/8XipWgi62XTCPNvGFX6ocXgAu9Ca
 40xylpswP9yG1dnnhdhUAsGNZB4IGJomXh/7ABKgQJntqB3s0rqOjmLRs6TePFVmZ5jZvjNcvDA
 z+AkI3pX96w==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [20.69 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(2.99)[0.998];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_SPAM(0.00)[40.24%];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	GREYLIST(0.00)[pass,meta];
	R_RATELIMIT(0.00)[to_ip_from(RL9hqizkjz3dsdtq8ayfzuomua)];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: F1E7E6A85C
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 20.69
X-Spam-Level: ********************
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:42 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Objtool is failing to extract text annotations which reference
> .altinstr_replacement instructions:
> 
>   1) Alternative replacement fake symbols are NOTYPE rather than FUNC,
>      and they don't have sym->included set, thus they aren't recognized
>      by should_keep_special_sym().
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

