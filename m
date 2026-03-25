Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F482351C3D
	for <live-patching@vger.kernel.org>; Wed, 25 Mar 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428332; cv=none; b=aipss61wBP0ePAUSSMfQA93E5cFDKzA9UPsfVPx/j00l39Jsw3lK0f8zXXIOZOHrUJzKStTPL3k/tEUj1v2R3BO51eAPCxdj5H9KFjoowbruAKQ+Svqr8VAyJTp/tHj8SwmEU1QRpgDLeCHZg91hLv1XtOztFc9MWgvSVG2uQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428332; c=relaxed/simple;
	bh=QhXaExc/Bt3yphvMLVsbtwHlIuU9rXPjUDRmYorr7dA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kn0fbGpgB5w6CJ+80ylRkKftU8CABjhX37yVMSJ9B2HaRhkp2oJ0aAEWpDIbPaiO0UISfxX9/c6+R05FVyWA5CVn6C3CVTRddvEa4mxZ/Nu6mU0RTun+ZSOh5UIZRC7EiT5H6E2oFQ+4s8KDd/EKyKUqO7GVq6NYe5P4tuRGdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXiulUZR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z4PEeV0z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXiulUZR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z4PEeV0z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXiulUZR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z4PEeV0z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXiulUZR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z4PEeV0z"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2F3875BD65;
	Wed, 25 Mar 2026 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774428323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FjS4CJNhWWiVr0cmpqhTyZSn3AUOzUvlMZSKv9MKwE=;
	b=pXiulUZRJadcp0blD3G1CUD1+YaiQ0cpKYtyymyYuDGthAE/CwTsh53+6roEZUR/jFXwvN
	71MmoE8SB6HzAGLydNLlSBAv+1GLyj+uqBSeSBv1lxwdqjMLuGXjmaD612VONePUwYDWE5
	2jiYclxOydl+zYkhh3LU4oFy56k3aBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774428323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FjS4CJNhWWiVr0cmpqhTyZSn3AUOzUvlMZSKv9MKwE=;
	b=z4PEeV0zB5Rt8lcC2FcOX6Evq7FV8ckwQ5U7RyBgWOiAWdz8r5QQ2nVB1LIl1BrOp2wEOf
	2XaBfplHGBNC0EBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pXiulUZR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z4PEeV0z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774428323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FjS4CJNhWWiVr0cmpqhTyZSn3AUOzUvlMZSKv9MKwE=;
	b=pXiulUZRJadcp0blD3G1CUD1+YaiQ0cpKYtyymyYuDGthAE/CwTsh53+6roEZUR/jFXwvN
	71MmoE8SB6HzAGLydNLlSBAv+1GLyj+uqBSeSBv1lxwdqjMLuGXjmaD612VONePUwYDWE5
	2jiYclxOydl+zYkhh3LU4oFy56k3aBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774428323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FjS4CJNhWWiVr0cmpqhTyZSn3AUOzUvlMZSKv9MKwE=;
	b=z4PEeV0zB5Rt8lcC2FcOX6Evq7FV8ckwQ5U7RyBgWOiAWdz8r5QQ2nVB1LIl1BrOp2wEOf
	2XaBfplHGBNC0EBA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] selftests/livepatch: add test for module function
 patching
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Pablo Hugen <phugen@redhat.com>, 
 live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jpoimboe@kernel.org, jikos@kernel.org, 
 pmladek@suse.com, shuah@kernel.org
In-Reply-To: <acKje1XMQMQQYBIL@redhat.com>
References: <20260320201135.1203992-1-phugen@redhat.com>
 <177436214729.62466.7977538958560300344.b4-review@b4>
 <acKje1XMQMQQYBIL@redhat.com>
Date: Wed, 25 Mar 2026 09:45:22 +0100
Message-Id: <177442832293.70541.15179138173140080388.b4-reply@b4>
X-Mailer: b4 0.15.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.38 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(2.99)[0.997];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.0];
	RCVD_COUNT_ZERO(0.00)[0];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,localhost.localdomain:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 2F3875BD65
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 17.38
X-Spam-Level: *****************
X-Spam: Yes

> > A nit but is 'noinline' keyword needed here? proc_create_single() below
> > takes a function pointer so hopefully test_klp_mod_target_show() stays
> > even without it?
> 
> No strong preference either way.  I won't fault a livepatch developer
> for being paranoid w/respect to the compiler :D

True :)

Either way

Acked-by: Miroslav Benes <mbenes@suse.cz>

