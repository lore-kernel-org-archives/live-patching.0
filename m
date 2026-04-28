Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7BF43D4F7
	for <live-patching@vger.kernel.org>; Tue, 28 Apr 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380245; cv=none; b=SUpml+WVLU//JenS/6UOM1bdUImkZaW9m/GxvLpjA1c9x4jgJfiE8iXBi/MSoEtxypFCsyaVxjxsdALx5eEQiZzEKZKy6wViC3UwhakTUqJGiylhKhVbsv1TCtPDLUdcCzjF2QrzrCKEqVt9kBuvksB9mvuDhxxXJMvreL2Y3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380245; c=relaxed/simple;
	bh=CcaEEf3raQ+8G3ikImRZLsiI8/I6/iYU3E/vFI6Tiik=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dcasEbCqCHZ8kGRhBte+AZD1ad0LlJYGdIIyf51SiYJHE4As0F2XdTwph6T6iTziYEktlokHBPILAfwpiL1RYWn0CJjjOCe93VDT545vZEytqOZDZsu4QSfN/wa/N2xXuee2XJOtz58JqLmIirrkYMhyqQJw0ACQSFYPwq0QWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pGUVQKl2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+p8JqZVv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pGUVQKl2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+p8JqZVv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pGUVQKl2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+p8JqZVv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pGUVQKl2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+p8JqZVv"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6552B6A881;
	Tue, 28 Apr 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y20POoP6V/cvXv8TWrMLc589N6UcfTk9Gsh8wUwAa3Q=;
	b=pGUVQKl2ofIBBJNt/TjkNsfUXjOuj/FoengPRYex4e7AClMlG11/DNtLS0TqgL1b58cfSa
	YA0cdeW4NjSxmZ1ewUE6x1fxLhrwjk1cHYJHV+yR7AuhfkTxxBrPjTtP1rQiRviZgjM2w/
	q4Ce+5WzqN9XQSyPRaf5JEn64XZLP7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y20POoP6V/cvXv8TWrMLc589N6UcfTk9Gsh8wUwAa3Q=;
	b=+p8JqZVvp/fOH7WI70aX9qml7foQHAS3XBFATEApSHf3r473+tBAte/DRkLCoWNK9KyeOX
	dzowZP7yeca/y6CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pGUVQKl2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+p8JqZVv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y20POoP6V/cvXv8TWrMLc589N6UcfTk9Gsh8wUwAa3Q=;
	b=pGUVQKl2ofIBBJNt/TjkNsfUXjOuj/FoengPRYex4e7AClMlG11/DNtLS0TqgL1b58cfSa
	YA0cdeW4NjSxmZ1ewUE6x1fxLhrwjk1cHYJHV+yR7AuhfkTxxBrPjTtP1rQiRviZgjM2w/
	q4Ce+5WzqN9XQSyPRaf5JEn64XZLP7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y20POoP6V/cvXv8TWrMLc589N6UcfTk9Gsh8wUwAa3Q=;
	b=+p8JqZVvp/fOH7WI70aX9qml7foQHAS3XBFATEApSHf3r473+tBAte/DRkLCoWNK9KyeOX
	dzowZP7yeca/y6CA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 16/48] objtool/klp: Fix relocation conversion failures
 for R_X86_64_NONE
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <2779114efd74a9dd9f1e78076e1b9e3a5273de73.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <2779114efd74a9dd9f1e78076e1b9e3a5273de73.1776916871.git.jpoimboe@kernel.org>
Date: Tue, 28 Apr 2026 14:42:55 +0200
Message-Id: <177738017547.11371.14673493009732344391.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=495; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=CcaEEf3raQ+8G3ikImRZLsiI8/I6/iYU3E/vFI6Tiik=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhswPq4NmNGvt4hSOW5HN5Vu3wdmjc1OQ0dwX8V62nYqMN
 VtO2/zpZPRnYWDkYLAUU2R5vddZznBKroFm9bu7MINYmUCmSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAU91TwMHQH6iynGmGjKpb6Mk9bgppMx2n6xvu0G2+Vu7uvOfg1rztm6KlJhk/OKM
 wW8Zlw/WnJ5j3BavUzQysOHtA44hVWVvwqY1vdFY2nb0Vsi7v/6rC+Ek32Gb/PVz2d1ffvS83c3
 s7nMQXfp9dwNk2c07K+ZuVIvM4/pzbUCjY8PVO5YY3u4Vk37AY7G2/UKYWFWTm8vibUV2XrVZb5
 OImrTKru78NTry6djYp2fsnFze/ceG2h5pWP6/NmLn2aJ9HYMfpHcmzXmXvOy9pyxT/+fQXPt/f
 17cVfjr9wfP9R4YG8bc34yrfSn/kf5T4RvU0Fx9DdkaTWKP5oWvrilcH660WlzlSN+X18p3qFR2
 Gt7JCAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: 6552B6A881
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 20.69
X-Spam-Level: ********************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	BAYES_SPAM(0.00)[41.56%];
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
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:44 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Objtool has some hacks which NOP out certain calls/jumps and replace
> their relocations with R_X86_64_NONE.  The klp-diff relocation
> extraction code will error out when trying to copy these relocations due
> to their negative addend, which would only makes sense for a PC-relative
> branch instruction.  Just ignore them.
> 
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

