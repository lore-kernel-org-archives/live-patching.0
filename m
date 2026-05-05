Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B29391512
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981436; cv=none; b=KU/IFn/sXb8APlVkSaMH7Knn5L51vO2dUZRXjw/PxQk9jhyev5OIaK4uWVuBg/gaFkIbYTZI1SLXt3F5lOwZjISKKO+PLjvDjuEZ5U9tze1W3cSaHbX05AuQxGFpZgzpJJ+hFkmRz8eJwCRf2eaCN39Fm2UOUh/TKjSBqiRrAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981436; c=relaxed/simple;
	bh=Q/sF0WZxt5TQZ1Yv1QCNTQi37Acj3AfvATNrtAwmpgo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nTeX0GVl7/4kUgSXxY4d+sVMaYjBNeZk0WqOLAWLgJ9BR0qBwoaYEfiQOyCfEuxUmnbXZgQNji50Oje5jbjq6TlLfuKOqhFwUxgyVCLIEcQpUc+mcwR4vT75oE2lIEERdr02tvwVsP9ZaEyPoqq0w5Vm4Mck6i3IEKQ1YHaM4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IbZIn2+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONjGYGzX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IbZIn2+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONjGYGzX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IbZIn2+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONjGYGzX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IbZIn2+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONjGYGzX"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id D6CCE5C3ED;
	Tue,  5 May 2026 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777981420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ1szlbpOQadkRcx/o+CVi+mS+JG1pIFeQQrWov5+o4=;
	b=IbZIn2+YTdFSyMfhoxFxQpB8yx6UoTdXX/4mbaBiCDRS8o9Jp7XmlgrVZ7U8guiud2Mi5y
	IYA6Rm2iaw6gYqn/8FLvPvQ/EVgvI8Gs51AOHBlCcNzkdothM5RkTMbnZkiFmKk9ARVuWi
	DHzbSXhVQaSzsrR7pf/LqPew8Ay7Ays=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777981420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ1szlbpOQadkRcx/o+CVi+mS+JG1pIFeQQrWov5+o4=;
	b=ONjGYGzXv1XMd18XpWyy8l2fMnG0ZUQcL/H3YrYyrDvGD5kUp9NLW2XCjt38KA3AJbgb9N
	geqrvBRC/k1055AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IbZIn2+Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ONjGYGzX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777981420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ1szlbpOQadkRcx/o+CVi+mS+JG1pIFeQQrWov5+o4=;
	b=IbZIn2+YTdFSyMfhoxFxQpB8yx6UoTdXX/4mbaBiCDRS8o9Jp7XmlgrVZ7U8guiud2Mi5y
	IYA6Rm2iaw6gYqn/8FLvPvQ/EVgvI8Gs51AOHBlCcNzkdothM5RkTMbnZkiFmKk9ARVuWi
	DHzbSXhVQaSzsrR7pf/LqPew8Ay7Ays=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777981420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ1szlbpOQadkRcx/o+CVi+mS+JG1pIFeQQrWov5+o4=;
	b=ONjGYGzXv1XMd18XpWyy8l2fMnG0ZUQcL/H3YrYyrDvGD5kUp9NLW2XCjt38KA3AJbgb9N
	geqrvBRC/k1055AQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 41/53] objtool/klp: Add "objtool klp checksum"
 subcommand
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <ce954af546c49aab9a02de2fa85fb6565ebd3aef.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <ce954af546c49aab9a02de2fa85fb6565ebd3aef.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 13:43:37 +0200
Message-Id: <177798141796.9921.12051369709257464112.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=570; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=Q/sF0WZxt5TQZ1Yv1QCNTQi37Acj3AfvATNrtAwmpgo=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBp+dfsFlpbNGTIeHePpjoPwjy52WY/Rq/qmHdp9
 +LbH9gHuhyJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCafnX7BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyzExggAidRrsYzo2Lf6JFb2i0YWQ8dqDo5ooUo
 G7HJRnhY2Wajquc6htdDGBc5k8/8IUpjRCA0CMF6idld/m8/CB7uuYMaVtePip/PY6EHFTYjGkl
 ibVcKmmJoF6dJbBvPjqryef0yi4/cdJ7AnYTFBNFRIjDjn4jGt1dWC9KbKcE/O2SEJWHZ3AjFtR
 F62vOVvayWGfng0iqGrafV8JcTcs0OIhVXYVS5mizHfyae46u21N2J8TxWdOEfGtwHLsv2kSOxe
 ISlnarR5D7iWuZtne4bROMulNFkLyZUPyuC65e4XU1HLSd8TNqn6l/NsufPHe4usKkAnu+OnikF
 T/IPGWXnhJw==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [20.69 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_SPAM(0.00)[37.56%];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	TO_DN_SOME(0.00)[];
	GREYLIST(0.00)[pass,meta];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_RATELIMIT(0.00)[to_ip_from(RLhhr1kjtirn5oxn4gcky1j98z)];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,localhost.localdomain:helo]
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: D6CCE5C3ED
X-Spam-Score: 20.69
X-Spam-Level: ********************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:29 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Move the checksum functionality out of the main objtool command into a
> new "objtool klp checksum" subcommand.
> 
> This has the benefit of making the code (and the patch generation
> process itself) more modular.
> 
> For bisectability, both "objtool --checksum" and "objtool klp checksum"
> work for now.  The former will be removed after klp-build has been
> converted to use the new subcommand.
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

