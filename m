Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66313A6B76;
	Fri, 18 Sep 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740436; cv=none; b=G9W5VPFr/K9gZ3oeAPu0tjmx30+p+5c3j41Siy3B5TiMl9k/JBoqKJMEAfwKpndBqy3jZSZaiAfhTG3qSXdy79APqJ7W9IuPVL0a3+fb485PuOwicjP1aYXHhLxm8UP/KCxXd/Ii6ET9Zf9TlA+Z6TChIyKbMF1b/TxXl1KPXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740436; c=relaxed/simple;
	bh=7ftfJ35NGlRXJzVZ3pfVfIxNnDIyUOA04LAEOup48KM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lyV5Rz3cfgDmMgUTyUPWQWOOl4GRCrorlb7AB+P8VLa+hkEpJcaAxqbu+SJWedKnmKRT+4UCQzxMzuLk8AdrjVNXcLhx9E3zvGgDD1AiSuOjbYWFPaLhMwwsgkUPx5Tv4anz4MaLYGjSrTLudk8bKUflkQB7C/2q+B/6x9H2fKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z6uGXoXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hc2/miI0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xc+fcn7B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqlVyVKy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z6uGXoXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hc2/miI0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xc+fcn7B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqlVyVKy"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id 352641F7A1;
	Fri, 18 Sep 2026 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789740428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E69d7nhGV5QZI0C8RE6mUZJ93wzlQ4dx8b560Z5NLek=;
	b=Z6uGXoXXeigPWrlTfa1V+dRnomIq0bN2wedF2n6xruwZwerYvCQNhGN+Tx1dylZ+Cs8JqW
	t3cep0K0B+5Yg1Se6skMjLXXIKlGTiM2M8+9vF6SHNquWjmgYJXd5iqiKdBPit1n4PsK5j
	kkIbDNmFweo1aFEWCOCdIk5OdBpOCZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789740428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E69d7nhGV5QZI0C8RE6mUZJ93wzlQ4dx8b560Z5NLek=;
	b=hc2/miI0yyYP+4v2GHdSXDzM3+YKhRiYflcBtKIUqpVkyupPx2bLX6GBgC4Oa5smcviz7J
	vl6zcy4+g05VmWCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xc+fcn7B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lqlVyVKy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789740424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E69d7nhGV5QZI0C8RE6mUZJ93wzlQ4dx8b560Z5NLek=;
	b=xc+fcn7B9bC96iGhinpSJy9LFw20m6bAxN7EU8HoFnjwY7II141mC7Nz8qI9jpAHbv5LTb
	6GtP2WCTBJMqBDLJBi/RGyrO8PCDqnN/9iUxwwH8Fxyf4TXuU9iRz0bL77SD+Ou1s7R/5H
	H7obmvxN40dW732YVLYiuYk/BE2N4FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789740424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E69d7nhGV5QZI0C8RE6mUZJ93wzlQ4dx8b560Z5NLek=;
	b=lqlVyVKyZOA2yqxLEAp0t7isVhTqn342NlzL+x5QlquR7bKRKikCvObN2wV72Ozr1xC7t0
	jVw/d9Wa3jGzePAQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 5/5] livepatch: Clean up klp_init_object_loaded()
 when fails
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, 
 joe.lawrence@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org, 
 shuah@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org, 
 sashiko-bot@kernel.org
In-Reply-To: <20260908120325.299649-6-pmladek@suse.com>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-6-pmladek@suse.com>
Date: Fri, 18 Sep 2026 16:07:02 +0200
Message-Id: <178974042237.131521.4110571603714459657.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=621; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=7ftfJ35NGlRXJzVZ3pfVfIxNnDIyUOA04LAEOup48KM=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqy1rh1OtTGuNoZmvK/FGH2mCXOt3C9xbdukwOuvlkQke
 K/Xuna0k9GfhYGRg8FSTJHl9V5nOcMpuQaa1e/uwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjhEDF6cATPV/bfa/ogFvQwv+3756v4g50NFcoN2o8MCXb+wv7BfPZvmXvy5zSt0Evvo5Ksb
 XC8RVz+0N7114p/yGf9I0kwMCXHkHHk1yaF8V+jin8Gd8U9MbryjOKe8tX056YnzifPOxk+eSXu
 /6tufp7iqWfTo+Bodus/x227s9bOK1XKbdfUqvfNNa76pvltt6yz7A7c970Zuh5ezyt3VqvfQ/7
 aruYf94wOZWvP+v4uPF9ToJgkWb3kvI/JV/3HJFQDzJdJ603eNHrPriJgzSHY+8zld+/a8s+f3t
 1hm1E9XaYn99+8QkKhw+pemj/4J/J/vEOwMcFsTEiXZeXvh65mmNw6senf2c+OGwhgrHwtqgkGd
 5ge99AA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 352641F7A1
X-Spamd-Result: default: False [15.25 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.86)[0.287];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,redhat.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: +++++++++++++++
X-Spam-Flag: YES
X-Spam-Score: 15.25
X-Spam: Yes

On Tue, 08 Sep 2026 14:03:25 +0200, Petr Mladek <pmladek@suse.com> wrote:
> When loading a module, klp_module_coming() updates all enabled patches.
> If an error occurs, klp_cleanup_module_patches_limited() cleans up fully
> processed patches, but skips the patch that failed midway.
> 
> The current code is a bit messy. The changes done by
> klp_init_object_loaded() should get cleared by klp_free_object_loaded().
> But this function also clears obj->mod which is set by
> klp_module_coming(). And relocations are cleared separately.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

