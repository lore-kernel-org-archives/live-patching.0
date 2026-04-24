Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ECF3BFE5D
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031677; cv=none; b=bT+aVytPsKWQAJklVjRFZjOIm1OlBZ6NsfsDcjFMoKy/AnuOLiCqmBD7gd8TN2LqpZ2klOJ4lk9zIa6rg+HELNsHHbYEz7LwpseIS23X1TKLtlSwPH335zsH8p4mU2r+4YN/qzTPYphTccTIid/KI30dRY2GGl1Af0OsGJeS2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031677; c=relaxed/simple;
	bh=I3spfxAbn8Qc/n8Y7P0OCtLcGcwLbOD5rMqNSM5XMdo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dJCBOPt1QzYWKoU4RAj5jBhiGPGStXmIsl9tguZ7FuYw4qFUD+CEeepS7cezG7Nv7bDy4ax/XOsbBaQo1veUDqeW+M/JM5U6bJAuHTebd/G9iPUGFbD7Q6AZbse1fIfzmAzlP/udsYTdFoYuumUZubtsiyzv0fakQV5b8/YnwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWiNAAtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eB4tt8T2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWiNAAtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eB4tt8T2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWiNAAtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eB4tt8T2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWiNAAtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eB4tt8T2"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id 456AC5BDA7;
	Fri, 24 Apr 2026 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777031674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0optL9BdP2MNBzcsSzMcjecA4qDijSbp8sn8L2pDRg=;
	b=MWiNAAtNpfyhsI6pPNUdkC+y7RRCNhF6CeGOB5SppB0MWm11C26FxH3ml4/U9zkMIt9ceQ
	Y2c6xI5nsOtk0I9EEhk6cJ1TYg59xYwEiY3lTDTB7Sq7MyX6ujBErvJtWkSNTUejw7CQaT
	sL8P10iGb57H32fFaUY7F6WBwsbewY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777031674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0optL9BdP2MNBzcsSzMcjecA4qDijSbp8sn8L2pDRg=;
	b=eB4tt8T2ENJ4n2zzJPcTkT2CcTuTAsKxJ27rfD5e2JB6y2ehfkF6imaVWfcocFU6tfng/L
	zxTHiA4D8NmJccDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MWiNAAtN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eB4tt8T2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777031674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0optL9BdP2MNBzcsSzMcjecA4qDijSbp8sn8L2pDRg=;
	b=MWiNAAtNpfyhsI6pPNUdkC+y7RRCNhF6CeGOB5SppB0MWm11C26FxH3ml4/U9zkMIt9ceQ
	Y2c6xI5nsOtk0I9EEhk6cJ1TYg59xYwEiY3lTDTB7Sq7MyX6ujBErvJtWkSNTUejw7CQaT
	sL8P10iGb57H32fFaUY7F6WBwsbewY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777031674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0optL9BdP2MNBzcsSzMcjecA4qDijSbp8sn8L2pDRg=;
	b=eB4tt8T2ENJ4n2zzJPcTkT2CcTuTAsKxJ27rfD5e2JB6y2ehfkF6imaVWfcocFU6tfng/L
	zxTHiA4D8NmJccDA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/48] objtool/klp: Don't correlate rodata symbols
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <602e405888ab38cd08de4375060b56db0965651d.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <602e405888ab38cd08de4375060b56db0965651d.1776916871.git.jpoimboe@kernel.org>
Date: Fri, 24 Apr 2026 13:54:31 +0200
Message-Id: <177703167198.234971.16690298062704654470.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=I3spfxAbn8Qc/n8Y7P0OCtLcGcwLbOD5rMqNSM5XMdo=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhszXkb/0KtPitjYo5uyfGXT4SHus4Mx/0wwnSHSandge6
 KQQ3CzRyejPwsDIwWAppsjyeq+znOGUXAPN6nd3YQaxMoFMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MApjrsNfs/0+i/VqXL5RJrP57a9/A2Z57K0f+7Hle/UfzEFFX153L/fI4NOteyTp4
 XddDS/iTKvvTYOvP7P9hn8tm0HeW803rebEpWNj+DmMWe4OIX/6V9z+e3m+zaaCfJE2Gl4yefss
 fbLf4HQ39mudGzi49Xy674aWd39m1JqNpf3k1bV3QpLp2qW63xf6Nnw9qtYt9P/4k1vl3udUpkm
 9xUTkOpzjnbGszO2Xwz23GYdZb21JhL+7oSl31ULfjDWqqffKb2VZWxRKr4vw8zzTauDPaWf/vO
 0XrtW3PW13rnmK42nFvAt1hb9u6hnxo+ohVPuHxf9EdfsmNi0K4+6Bfyhm95S5vEQ/62SWfPK9/
 kY0kEAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 456AC5BDA7
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 17.39
X-Spam-Level: *****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.39 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(3.00)[0.998];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:34 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index ea9ccf8c4ea9..f6597015b33b 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -374,6 +374,7 @@ static bool dont_correlate(struct symbol *sym)
>  	       is_uncorrelated_static_local(sym) ||
>  	       is_clang_tmp_label(sym) ||
>  	       is_string_sec(sym->sec) ||
> +	       is_rodata_sec(sym->sec) ||

Sashiko comments here [1] that the check is suddenly to broad and it
covers also global rodata symbols which might then be skipped in
klp_reloc_needed(). I think it has a point.

[1] https://sashiko.dev/#/patchset/cover.1776916871.git.jpoimboe%40kernel.org?part=6

-- 
Miroslav

