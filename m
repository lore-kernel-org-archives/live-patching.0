Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7990449EB7;
	Mon, 12 Oct 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788331; cv=none; b=YqUsJE2wCtM0f67xa2XTYhvVpzk20U/rGykWUsOjOo8lR99ccAkMVIxAZGvU4JppzGtR1yXSPwICL+y/jCThdw+MZIPoFbXZqJO0gC4FIi97h3zEKxezCdwIbPwaoHgdQeLp5lS8yoICB9gncnRp0SnpE8WSCL/QScPxmUCyHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788331; c=relaxed/simple;
	bh=iWEc9LUJVYrtb8AzLB6wkGOdS35+Oy+lGesquj/VR/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QfFp0+r1zbWY08YSWA2J/rHtEc+eyWH6yfPN4U8s6pYyrVr3PRua2GCUnzjNpV/v436hog3DZ9Im9B+fYXnk1jj4X/7JNiwo0VOePTFv1Ivy6B0MpfblkgQW+Fwry7DLKsU7D4Ep2IvcMv+NepSxx1yW/eY311mMm8gUhSEgtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yp6VXJBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ehC7b1ph; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yp6VXJBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ehC7b1ph; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yp6VXJBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ehC7b1ph";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yp6VXJBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ehC7b1ph"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA98F21E65;
	Mon, 12 Oct 2026 06:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791788316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDbbwh+r69WFtzL7zyZNyx3rxPQcgADimgGlCIDOY74=;
	b=yp6VXJBjyDuvyZCUJIktSE2Mk7JwjGZ6rpKvA4tQoX3Jrl13wHb9oukpSAKr1kn7uTqyKB
	m6/qHOaCA48pchexU+LDgS9zD6lS2leMC0dZ7MH2Q1HsXfFPWPUqrVhAfoflicxnGI4XB8
	5HfLFYUCoVsw0LBeysIg3bqsIeFAbR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791788316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDbbwh+r69WFtzL7zyZNyx3rxPQcgADimgGlCIDOY74=;
	b=ehC7b1phsXIgsPQyFmn9uMCAX+caJ+7N+ZuEKnzLVQBFJUjF4GVH1sxkQxRF9q7s4FOpDv
	MvgPPgwqtBr3aTBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791788316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDbbwh+r69WFtzL7zyZNyx3rxPQcgADimgGlCIDOY74=;
	b=yp6VXJBjyDuvyZCUJIktSE2Mk7JwjGZ6rpKvA4tQoX3Jrl13wHb9oukpSAKr1kn7uTqyKB
	m6/qHOaCA48pchexU+LDgS9zD6lS2leMC0dZ7MH2Q1HsXfFPWPUqrVhAfoflicxnGI4XB8
	5HfLFYUCoVsw0LBeysIg3bqsIeFAbR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791788316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDbbwh+r69WFtzL7zyZNyx3rxPQcgADimgGlCIDOY74=;
	b=ehC7b1phsXIgsPQyFmn9uMCAX+caJ+7N+ZuEKnzLVQBFJUjF4GVH1sxkQxRF9q7s4FOpDv
	MvgPPgwqtBr3aTBQ==
Date: Mon, 12 Oct 2026 08:58:36 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Song Liu <song@kernel.org>
Subject: Re: [PATCH] livepatch: Add Joe and Song as maintainers
In-Reply-To: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2610120858160.27149@pobox.suse.cz>
References: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, 10 Oct 2026, Josh Poimboeuf wrote:

> Joe and Song have both been key contributors to livepatch for several
> years.  They have graciously agreed to become maintainers; add them.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
