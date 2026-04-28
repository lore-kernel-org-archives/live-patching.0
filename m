Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FD41C31E
	for <live-patching@vger.kernel.org>; Tue, 28 Apr 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380255; cv=none; b=qN6ej9m8n0aBmAnspzKUzCDb4c0fjZLiw1uKaOKKf+XZBaRvL7jm8wjaeqi0wCyNLASN3V2NiBiUQBGeFdzGON+INwoI358oiMJUYIBuozwFglP1Ao0uz339zw3WP0GqXPIqd7vd+yyOHQnvk7Vc6RL93hgaEMUYOJZtzarCqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380255; c=relaxed/simple;
	bh=M851tRMV/xqcCGzOe1deJBa3wdrYN/CyJu4FeeEuK6A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=W+YzykHKhoamVcxH11eSGUIftQ4OWZiCYVZbDkkCf6dGurjX0ubEXcaLcJ9YGxMBLMXrI7apfF7hVJmsd36B+rVWHXCGySFs6CE3tGKFUHTDPVAeZ1nLMfQIMoUvaVRNY4axMhaqC+1FM5K0AG4xtF7R3DuGvPw8GUGXemAu86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LD340ztM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ci2fG9EF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LD340ztM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ci2fG9EF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LD340ztM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ci2fG9EF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LD340ztM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ci2fG9EF"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 8F45F6A84E;
	Tue, 28 Apr 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+X3Kdg4mVNxAtvQ1gOYLsUUv+5UuOgrZKRVQxAdXtQ=;
	b=LD340ztMV09HBVZAz6vVRJ7xJOgc5ZoO22Ypgcy6vdaEaCRrRHm4nVcOfd1ISfYuO2b4E/
	bK3+AgYPA0gmZcgF9J7itCOTeoOoBMlDLfQBkTyeKYzwD+j1aFoZO9KeOGe2g1pCF0Yzn6
	KLukR1vuBknBg/z1/xr69YJCvJ0sGQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+X3Kdg4mVNxAtvQ1gOYLsUUv+5UuOgrZKRVQxAdXtQ=;
	b=Ci2fG9EFqS/IdYn+FpWYfrtvFkxY9fvucgbuFc5Jy8628M02ztAGRf67cVQARDc+JdlGEl
	DGK+zzNNdjCfyKBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LD340ztM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ci2fG9EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+X3Kdg4mVNxAtvQ1gOYLsUUv+5UuOgrZKRVQxAdXtQ=;
	b=LD340ztMV09HBVZAz6vVRJ7xJOgc5ZoO22Ypgcy6vdaEaCRrRHm4nVcOfd1ISfYuO2b4E/
	bK3+AgYPA0gmZcgF9J7itCOTeoOoBMlDLfQBkTyeKYzwD+j1aFoZO9KeOGe2g1pCF0Yzn6
	KLukR1vuBknBg/z1/xr69YJCvJ0sGQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+X3Kdg4mVNxAtvQ1gOYLsUUv+5UuOgrZKRVQxAdXtQ=;
	b=Ci2fG9EFqS/IdYn+FpWYfrtvFkxY9fvucgbuFc5Jy8628M02ztAGRf67cVQARDc+JdlGEl
	DGK+zzNNdjCfyKBg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 17/48] objtool: Fix reloc hash collision in
 find_reloc_by_dest_range()
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <09dab1995c4ba6ca29dd70b0a7472f1a2975fefd.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <09dab1995c4ba6ca29dd70b0a7472f1a2975fefd.1776916871.git.jpoimboe@kernel.org>
Date: Tue, 28 Apr 2026 14:42:55 +0200
Message-Id: <177738017548.11371.16572871519515726131.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=536; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=M851tRMV/xqcCGzOe1deJBa3wdrYN/CyJu4FeeEuK6A=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhswPq4NaezcUve1OMLlZPMG/0fxjRuaFtD/Mn2vUBFUv5
 7FXvRTvZPRnYWDkYLAUU2R5vddZznBKroFm9bu7MINYmUCmSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAU71+PwfDtjzepzqZ5Xt2JMVlvjQN2bRc9dyRIMNzJeHb5rFvqVvAuObV1eJbPt/
 czh2K/vR8kY/3G82TpxvuWP4py7FUrrvSdHOFVsgkm64I8Qf3xTczfQ50PmhR8aROb6L57i/ZR8
 9fMnYp+/JCPFDhBdcHB3E+M8W9whmlyxjknix4m2jfzrHz1Mvn0g5ThBMZY3pufDzAGWx9/7XCk
 VWqP85eMS+IvLCddenm02ZnZu2Q0p685o/lefUbYpHW7+/W73LLy+AMYLIqfTFd1KHRQ1w78XqH
 0LxUo3kzzkRnRZitMPLzlXzd/OrQAZu3G1z5fzL6/v7/9tvPGZNctPtd9794vNq51Fje48734JI
 LV18cAQA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [20.68 / 50.00];
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
	BAYES_SPAM(0.00)[27.80%];
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
X-Rspamd-Queue-Id: 8F45F6A84E
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 20.68
X-Spam-Level: ********************
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:45 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> In find_reloc_by_dest_range(), hash collisions can cause a high-offset
> relocation to appear when probing a low-offset hash bucket.
> 
> Only return early when the best match found so far genuinely belongs to
> the current bucket (its offset is within the bucket's stride range).
> Otherwise, continue scanning later buckets which may contain
> lower-offset matches.
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

