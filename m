Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD1547074;
	Wed, 30 Sep 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768187; cv=none; b=apvvynE2iBr6G16Os98jmhJNTy6W2Xq0WMHKuloBnnotfpkmfee39kj2Uu1xHsj+kaYtbIdKBdzGIzSq7mk26vPN7uLHv3Fn3DfkeytajCxhaVAJjmPUzIHpNfz2+GrnebX0GeuBE1qDAm0XBW/tWyGvPcVhOPqjMELx1FbncMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768187; c=relaxed/simple;
	bh=eD3UrVEJ/InsO5zG2b0dqaZLLo+AuDllHCgfqBRmefc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n4y7aqXEc5/5Mri92tFp9nGzXjAjUFw+5Xg2eVv7uhnPBIhfgNGOTw0dtftDvopBgNp+o8eRKukwYyNBDn4dAQjiYs2gLw+nr4dKdddLmE90qYhaER2FJ0ZZv4ujBkkyxk6WuXmilw/IyKyKvAhG6uy/AV0j8gpUy/QOWPs6AQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BslPv0IO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBrbCFPf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OhBxNw/7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=smTNPSFW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BslPv0IO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBrbCFPf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OhBxNw/7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="smTNPSFW"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93D9D21D6B;
	Wed, 30 Sep 2026 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790768179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5i4ONXkhpz7A0A0NaQG8iopNgWLX30H3FyGxtE4wBA=;
	b=BslPv0IOXd9tQLRf5J6JNj9c14QGZttd3oE+qRS2jLMgrc0oRBdLjHJpNq5FZm55wP/fot
	fI/INIQznOH7DKCebcwa8n14CMv1j1uaUK7+//Gff+gXW3/3+ROEOUtP36q4YU6+7/Tu2M
	FZDWI5lWcKY69Czn+sk5xBicpn0h+JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790768179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5i4ONXkhpz7A0A0NaQG8iopNgWLX30H3FyGxtE4wBA=;
	b=yBrbCFPf3+H4NgyfsO6RaGR25aO8oP7iHXXWPktj4TtSTFnHTikKUW3XuzdC4ekqhLsSKk
	RN1oG004n+SgZiDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790768175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5i4ONXkhpz7A0A0NaQG8iopNgWLX30H3FyGxtE4wBA=;
	b=OhBxNw/7V33JGc+ixjJ3/hkXdd8CcNwgjxUzUXCokWOZ2TTzrWUMn6fFpgyZt2F10/B8Gn
	YYk+qDZtX6ZEXoTdAzysvbOQ49DGdw9i78Dw1g3B0uw8dlP3HgkkX7ZfZwyE2mRtBDEvu6
	3zegxdML7BSEBVZyEUsVPYMhvjlpV3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790768175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5i4ONXkhpz7A0A0NaQG8iopNgWLX30H3FyGxtE4wBA=;
	b=smTNPSFWrJSfOfUHLiTbwSLc7DUkNWI9bzEp8R+9UojSjFLoX0trXpt4rz5TOuwzqH7xqh
	3cQvrxSW8OgEU2Cg==
Date: Wed, 30 Sep 2026 13:36:15 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Dmitry Malkin <dma@nebius.com>
cc: "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [PATCH] klp-build: Add an option to set the livepatch module
 version
In-Reply-To: <AM9P190MB1666E0A06E9F75E93BF960C9DB8B2@AM9P190MB1666.EURP190.PROD.OUTLOOK.COM>
Message-ID: <alpine.LSU.2.21.2609301334470.17217@pobox.suse.cz>
References: <AM9P190MB1666E0A06E9F75E93BF960C9DB8B2@AM9P190MB1666.EURP190.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.965];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebius.com:email,pobox.suse.cz:helo,pobox.suse.cz:mid]
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, 30 Sep 2026, Dmitry Malkin wrote:

> Livepatch modules generated by klp-build do not contain MODULE_VERSION
> metadata. Add --module-version to identify a livepatch release
> independently of its module name.
> 
> Append MODULE_VERSION() to the temporary copy of init.c when the option
> is supplied. Restrict the accepted characters so the value can be
> embedded safely in a C string literal. Leave the source template and
> default build behavior unchanged.
> 
> For example:
> 
> $ scripts/livepatch/klp-build --module-version=1.2.3 fix.patch
> 
> The version can be read from the resulting module file without loading it:
> 
> $ modinfo -F version livepatch-fix.ko
> 
> The version is descriptive module metadata; it does not control
> livepatch replacement or compatibility.
> 
> Signed-off-by: Dmitry Malkin <dma@nebius.com>

thank you for the patch but MODULE_VERSION() is being removed from the 
kernel [1]. build-id should be sufficient.

Miroslav

[1] https://lore.kernel.org/lkml/20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org/
