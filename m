Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68576391849
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032261; cv=none; b=VLh8tsLhS2/LTTyCB8nncl2tRjbvWfTrV5EA96PUrwBHErRG179z+mJLOSsbrwrw9lNSj96SMjMxu4Cq0Nz6HqDuaq7NXq3jK4EBe/FrHPBM3AtC7ypK21jmL0G825NhnuHSY9wMk5MfK9s3XSmdcXIXweP5e7eU9LvtT+S2QNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032261; c=relaxed/simple;
	bh=/2TrRCbnpqrhhlc7yLkT0NyzcYCExfdeGZi15oDXy94=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UqAkjonh7b9lt+pN9eb8xscvV9N3NGTW8mgghnlHYMx1jJS2uvBlvtBURR1A3LtAiGKHI+U4SBo1oI1xk5K3U4yr1nUbjwAhAJDSOfyGEdrQ7DvAAP5aEyUviLD5reHNVRpkTGXk/Bh7nTGRYk4svibawHjPUyJ3XTBl0HdXPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aaMHT1ie; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WLZJXdgh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aaMHT1ie; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WLZJXdgh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aaMHT1ie";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WLZJXdgh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aaMHT1ie";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WLZJXdgh"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out1.suse.de (Postfix) with ESMTP id 665DF6A8AC;
	Fri, 24 Apr 2026 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777032258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6/9pvzUEGjOOjb0UBhUCTI0UUSNqy0CBbTLm3nW6eI=;
	b=aaMHT1iesn8zj7wgvoi+FzyYhDDyo5gNdEWO4MBC5oFvYSA+BzXaLjf+4H5yKm3tPqqGVm
	Es9QjQfqgAXX/ceTnQYDVM0HBywaeOsEyKQNXlAo34Th3ke+eVISnmaTrXrISp7+X9sGl/
	v8pCyAEO0B2DnFRbMun6tAydHUsYcos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777032258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6/9pvzUEGjOOjb0UBhUCTI0UUSNqy0CBbTLm3nW6eI=;
	b=WLZJXdgh71eGrH8mZ+WrArvPoc6mBJTqh9PPj2QV+XO4X3EYRmtE1uyKunm2kjFrlo+WhU
	ESO700vdGML/jXCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aaMHT1ie;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WLZJXdgh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777032258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6/9pvzUEGjOOjb0UBhUCTI0UUSNqy0CBbTLm3nW6eI=;
	b=aaMHT1iesn8zj7wgvoi+FzyYhDDyo5gNdEWO4MBC5oFvYSA+BzXaLjf+4H5yKm3tPqqGVm
	Es9QjQfqgAXX/ceTnQYDVM0HBywaeOsEyKQNXlAo34Th3ke+eVISnmaTrXrISp7+X9sGl/
	v8pCyAEO0B2DnFRbMun6tAydHUsYcos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777032258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6/9pvzUEGjOOjb0UBhUCTI0UUSNqy0CBbTLm3nW6eI=;
	b=WLZJXdgh71eGrH8mZ+WrArvPoc6mBJTqh9PPj2QV+XO4X3EYRmtE1uyKunm2kjFrlo+WhU
	ESO700vdGML/jXCg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/48] objtool/klp: Don't correlate absolute symbols
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <1dc8b127ff0b1252e53bb7e6130ed46c60f57c25.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <1dc8b127ff0b1252e53bb7e6130ed46c60f57c25.1776916871.git.jpoimboe@kernel.org>
Date: Fri, 24 Apr 2026 14:04:16 +0200
Message-Id: <177703225621.234971.2260628226152702366.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=587; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=/2TrRCbnpqrhhlc7yLkT0NyzcYCExfdeGZi15oDXy94=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhszXMU7yeQemvFm3w2ea7f8zehccj74sXpf/Tu3ZhueLd
 pyzsWzR72T0Z2Fg5GCwFFNkeb3XWc5wSq6BZvW7uzCDWJlApkiLNDAAAQsDX25iXqmRjpGeqbah
 niGQoWPEwMUpAFMtcIv9r+DcL4pfdV/+KxRlav1R8eZf8aY27i/8Pwu3OZhWLD/l8aau3eOPdH4
 P037PCWa8sdb351xTj/z06/3tOGWdtduXdPBu8GPsNTS8dXMhe/zznBVdehm/Fr/+mzvBhV3k88
 ROsZdRYRvdZpl2ThVXc4kwqH3BszMtOVbHNn7h8Rv7tt/nvV6dz7B2x85D8jwu3LaCwV+ks54Kf
 xLet2GVekzbU19DO3/rVUdXu05e5hO9ZfEku5yIw+tDCp9dX9HGyNGiW3H/RjInT86NaVkGJa8T
 tqm/sOpze14iaBwbdHe+x9qTy3YZyr/Y+8N+WUfXxTKJSjnbx0p9GtKK2Vf+mmx8Ytq7KHfulf8
 fWU+dBgA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Queue-Id: 665DF6A8AC
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 18.00
X-Spam-Level: ******************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [18.00 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	BAYES_HAM(-2.39)[97.18%];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:35 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Some arch/x86/crypto/*.S files define local .set/.equ constants that get
> duplicated in vmlinux.o.  This causes klp-diff to fail with "Multiple
> correlation candidates" errors since it can't uniquely match these
> between orig and patched builds.
> 
> Skip ABS symbols in dont_correlate().  They're purely compile-time
> assembly constants that are never referenced by relocations, so they
> don't need correlation.
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

