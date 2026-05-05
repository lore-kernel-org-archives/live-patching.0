Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89549309DAF
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982306; cv=none; b=brJuImzCFakqZn9/3SNis7LYR+2UjqWvq+imkwgEThU5XCX9sENs/rYOyK62ketiXKhM0xxPp864BTatDJgPf3XJ+sAXiBJxRn2X3XA8RaWqDN5Sp7kLjIWQDWEqaRKCNZh94NRt5H33NrevaasbzysXmB47EMQSDL+juat3vl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982306; c=relaxed/simple;
	bh=1Dxq+EgTlrUydcrMUuNz1uQsoKjWHmy6oriOlkjjUSg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=k47uh5tRlNOgkL2vRNDeJw2qeR5U9rUBp0kYSsdeeQN38cGpm8vtZ6uCpak8Tg8VdOMbJfHmVTx2rCIodNkVN9ZzFLnJcjN5pbu0W/g8jAlMe7sd6C4TgKX7MpNxZSuW7A+tE6NEXiNMp+p4ypsQDG0ccLwiSjO5LxvltlXBAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CTLe3wMB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFALdzyC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CTLe3wMB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFALdzyC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CTLe3wMB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFALdzyC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CTLe3wMB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFALdzyC"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 820AB6A801;
	Tue,  5 May 2026 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777982297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+QyTEAZgmN7RD/5PNx4hIuAbD+E3GghAr16rOaNpRY=;
	b=CTLe3wMBQYAkeY3r7rya4CVxdqhim0VB2TkZlK9HCspJ+HOy9Rhu0wlL8pIDko/uB6VIX7
	BcJk5hJ6jk42O2LH9NK8ammtCn2CgLTURrCTPG0QTZ6fgjfWpsE0jl+9/25IYGM4Jz7wB6
	JD6R7P+FmxhFJ3qn0AlzqLEh9XT7QR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777982297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+QyTEAZgmN7RD/5PNx4hIuAbD+E3GghAr16rOaNpRY=;
	b=aFALdzyCHqBwxhkvzHZvRKFu0l/yzt6zTTsPcNrahI0ZyG+LOu8xJKuQ9wvD087Q1tjLAE
	x+rETySgwet8BZBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CTLe3wMB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aFALdzyC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777982297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+QyTEAZgmN7RD/5PNx4hIuAbD+E3GghAr16rOaNpRY=;
	b=CTLe3wMBQYAkeY3r7rya4CVxdqhim0VB2TkZlK9HCspJ+HOy9Rhu0wlL8pIDko/uB6VIX7
	BcJk5hJ6jk42O2LH9NK8ammtCn2CgLTURrCTPG0QTZ6fgjfWpsE0jl+9/25IYGM4Jz7wB6
	JD6R7P+FmxhFJ3qn0AlzqLEh9XT7QR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777982297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+QyTEAZgmN7RD/5PNx4hIuAbD+E3GghAr16rOaNpRY=;
	b=aFALdzyCHqBwxhkvzHZvRKFu0l/yzt6zTTsPcNrahI0ZyG+LOu8xJKuQ9wvD087Q1tjLAE
	x+rETySgwet8BZBg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 42/53] klp-build: Use "objtool klp checksum"
 subcommand
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <1c4f6e2a4e0a3490947111970f2d8e884afa2588.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <1c4f6e2a4e0a3490947111970f2d8e884afa2588.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 13:58:15 +0200
Message-Id: <177798229504.9921.16630496791010851339.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=497; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=1Dxq+EgTlrUydcrMUuNz1uQsoKjWHmy6oriOlkjjUSg=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBp+dtZdE8E1DecDfLMvpUw+ra1WbFfUdyyNtyVP
 oirQufa4EeJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCafnbWRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyw7OggAkWiTqqnPuuftG8C9pgaeSfEVY7jzU6O
 1rB8mjynyENP6h9FwihtM+KgbQMBcptynetzFONeSifPd6sE8jjgiqaD8Sae4mhN4UgLaH51KxX
 98Mcu1G/BE251gWvbXAvxhissgXF5LJrt1lIbzrKBbB8IaQHbAxl2Rkbg00AR2ZRPjWzaW56BOC
 WVTpd6SeQJVyY1i/e57dvApY7V+Ud62pLsrWDEWOzVDVaSlmZiL7cbABLua6VBSC+8mSCmfcn6h
 +OKRvqzZVjxsEjjJAgIbi7mV24k62taSkRP7bm99Rzr6DBLCcnrND6cYwR0djfDGkFZ0F6Fhzda
 gC9cpG1KUTA==
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	GREYLIST(0.00)[pass,meta];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: 820AB6A801
X-Spam-Score: 20.39
X-Spam-Level: ********************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:30 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Use the new "objtool klp checksum" subcommand instead of injecting
> --checksum into every objtool invocation via OBJTOOL_ARGS during the
> kernel build.
> 
> This decouples checksum generation from the build, running it in
> separate post-build passes, making the code (and the patch generation
> pipeline itself) more modular.
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

