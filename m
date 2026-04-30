Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E537F728
	for <live-patching@vger.kernel.org>; Thu, 30 Apr 2026 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532421; cv=none; b=lYHwCk78oF6IHDkF3V9/rOH+k6LpMIhZ9OVuSIlxMXz7N0LRMpgJBtDf8NHhp/yRGL16lGv8W2kaYGEyheBOA20gGdq4UeNyaNPixG5oqJA5gIx/OyPVwqK6fcmwRjRycMbwrTnDs5CkNoFy+RRcldvDCoFUMiXe0PJCvW8B5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532421; c=relaxed/simple;
	bh=1416RacLOY2ZunciL21irCnMwShXPbRMKYkS8+ZA2LA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UyguJGYjciux6XGksqJpCIU7BHAFRQaX9NxQ9YTL/MP28myJPPS3JZKoEuQFy3cNVi/d73/AGgTVJyzSs0D3g2b8yn1cKcv/4LeN1AHwLyFmFDfkGXx3dpKn/g1yCRm8MsjrWLNyCN/4J79uWRzw9btag4nr0rdQuGhjADHPjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwSig6pv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=125DWTrp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwSig6pv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=125DWTrp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwSig6pv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="125DWTrp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwSig6pv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="125DWTrp"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A17C6A801;
	Thu, 30 Apr 2026 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777532406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bG1JzXc8uLumDm/Y/MLYy9kolwLUU8oUV+gs/Ml1Kms=;
	b=CwSig6pvck036SzvHnBNADMs6b5zcaWIWUahUjq4gAwC7AFV5h+4y51KiMROiac6Mx8IA7
	gGEpLJw7udW/nOrU5M/3Vo1EvfQXTl/Oe1kE45vvTho9AGH+gNaR8tmqx2Q/xLmZbxdiAz
	hHsOcMS63qTgTiQz5e9ydVOP8e5HUCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777532406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bG1JzXc8uLumDm/Y/MLYy9kolwLUU8oUV+gs/Ml1Kms=;
	b=125DWTrpKwBe+atvxhPT7VlWZ88s+Bgc+ZSxbOH1SqrxsoRwDOqFq26vJUTJpNKkHh/yWS
	XPNOVXSXoCYnpBDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777532406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bG1JzXc8uLumDm/Y/MLYy9kolwLUU8oUV+gs/Ml1Kms=;
	b=CwSig6pvck036SzvHnBNADMs6b5zcaWIWUahUjq4gAwC7AFV5h+4y51KiMROiac6Mx8IA7
	gGEpLJw7udW/nOrU5M/3Vo1EvfQXTl/Oe1kE45vvTho9AGH+gNaR8tmqx2Q/xLmZbxdiAz
	hHsOcMS63qTgTiQz5e9ydVOP8e5HUCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777532406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bG1JzXc8uLumDm/Y/MLYy9kolwLUU8oUV+gs/Ml1Kms=;
	b=125DWTrpKwBe+atvxhPT7VlWZ88s+Bgc+ZSxbOH1SqrxsoRwDOqFq26vJUTJpNKkHh/yWS
	XPNOVXSXoCYnpBDw==
Date: Thu, 30 Apr 2026 09:00:06 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
    Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 22/48] klp-build: Suppress excessive fuzz output by
 default
In-Reply-To: <58c5ac9ae38760beb06e5ddddb742ea54f922371.1776916871.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2604300859070.29589@pobox.suse.cz>
References: <cover.1776916871.git.jpoimboe@kernel.org> <58c5ac9ae38760beb06e5ddddb742ea54f922371.1776916871.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-4.18 / 50.00];
	BAYES_HAM(-2.88)[99.49%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.972];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.18
X-Spam-Level: 

On Wed, 22 Apr 2026, Josh Poimboeuf wrote:

> When a patch applies with fuzz, the detailed output from the patch tool
> can be very noisy, especially for big patches.
> 
> Suppress the fuzz details by default, while keeping the "applied with
> fuzz" warning.  The noise can be restored with '--verbose'.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

---
Miroslav
