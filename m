Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06313438BA
	for <live-patching@vger.kernel.org>; Fri,  2 Oct 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942533; cv=none; b=nwxinRfhzSimxNSDfphtA21pbON5sIwbyQSzIZ6h0N4kDSxQ8DqgDilhvItlCvLupG2KeB5eYwFTTjexh1DdADbgCkM/68xFghUkIrYVYD0hBV1IiIYgH0xoAAJracEQOCm63mlDf/4BkGlRapHKJ/Ve2vSsuH/FyFmph1s3mzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942533; c=relaxed/simple;
	bh=i+RXRYsJ4SoLI0wPkScwobyAi+JhxkYQE5947/op2W4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=t9+tZ49b8srCUwmCjW16s68UxZ7eI3376mFI29BRxvFluncLSS0S8IMwbrbbzqLov7TA4XZ49nAzUorQ1dX6n4EW0xbvaLSlkJ4uliXRvocphP/0kBo0tsFvkXBW316o7slkfgJq/izvT63CsNfUwiN92LnBYRDRojTEGX1vtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIz2RGNZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=biOs47Go; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mx0A1rMR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2V/AuRh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIz2RGNZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="biOs47Go";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mx0A1rMR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2V/AuRh"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 739BE1FE3E;
	Fri,  2 Oct 2026 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790942525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqz/1xRpvXcGWsHWJkKa9wp8RdHl1LEIxA4dlTptaz0=;
	b=uIz2RGNZsFgeQH18zTyzFdrAXb4QLbau2N2eA50fRguBu03ms+NLf9igjWsE1F/wBSWSmi
	04at3XHqiUxO575rLSGR6IB1HyigVCFVGXlZA67CBhJZkNQyq4AgdthVn9PSe0GD1NM5cv
	+GLyrc6hpytoeq7dXbTy2KoyMwDlngU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790942525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqz/1xRpvXcGWsHWJkKa9wp8RdHl1LEIxA4dlTptaz0=;
	b=biOs47GozKYBNqHpsQTw2ARQ5ba6CE4ooc5zPbJXh78Nbfj0mkNQ/wXnyl5y8vFWB5w8jm
	nFtxz3+sMWiTDHCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mx0A1rMR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="i2V/AuRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790942521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqz/1xRpvXcGWsHWJkKa9wp8RdHl1LEIxA4dlTptaz0=;
	b=mx0A1rMRRuM8Pm2LVbTPDyPHaMo2gpwa3ot0HAS7K4stOixGC1HrPg/zi7kovcD071oH+A
	DXbemWcZKrwuQpgiT9Y0xAFG8JuOT6NDmO5OSzg2itg5ufrKKnxmFh53wHccC2X3U5PywA
	DEIrASwJHIrEZ8gy3NVyFgfqTo85pjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790942521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqz/1xRpvXcGWsHWJkKa9wp8RdHl1LEIxA4dlTptaz0=;
	b=i2V/AuRhHGL/4FhsDkh/IKQvaPf/lKl5Y9g845zuFtbgZ4fRJkO/oUpHGfzPwQnwDj1YmO
	p8oYzF06cOMboHDA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 2/9] selftests/livepatch: Adapt atomic replace
 tests to provides/obsoletes
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260930030323.14396-3-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-3-laoar.shao@gmail.com>
Date: Fri, 02 Oct 2026 14:01:58 +0200
Message-Id: <179094251817.135114.3494541780316431067.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=603; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=i+RXRYsJ4SoLI0wPkScwobyAi+JhxkYQE5947/op2W4=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBqv504ObRZys9M+aVe8Ibs2IOeE8R7tpRLpyy5v
 0b4Ia0qxRKJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCar+dOBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyyMyggAosUK4F2NQj+T9A/bo8JXFTf+9XAmoSm
 5k7DSe+FVKPKYq6k8lMHVW4TchQhcyW8kwHdZxU+jksPA/V/rY7Yus/qjZ0fjdk/lwZne7nmGGQ
 0hPtDwSf34FjvBHlQKKX7K88w/39c+/mpIhwbJA8quczhY70hF5gj26heYMreoMXwwN8+011DM6
 PfmGG4TY4W3aDL5VPSFv5X6mvaqMDjnYX0xUuguyN2W8wsQhwxmzm0go6ijw/VYYUkG/OhoFoF4
 KC3DX3wQzY2WKHl954k0U3xqU6IeqVTxwPOXuV01qWjgth70a51cnOgchYBUu5bkxclAsK9J917
 pCmrJmLdspQ==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Action: add header
X-Spamd-Result: default: False [18.35 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-2.94)[99.76%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	NEURAL_SPAM_SHORT(2.40)[0.800];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::12ef:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,localhost.localdomain:helo]
X-Spam-Score: 18.35
X-Spam-Level: ******************
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Queue-Id: 739BE1FE3E
X-Spam-Flag: YES
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam: Yes

On Wed, 30 Sep 2026 11:03:16 +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> The legacy "replace" field in struct klp_patch will be replaced by the
> provides/obsoletes mechanism. As a result, the atomic replace
> selftests fail to build against kernels that only support
> provides/obsoletes.
> 
> Adapt the selftests so that they build and run on both old and new
> kernels. On kernels without the legacy "replace" support, the
> replace-related test cases are skipped with a SKIP message instead
> of being run.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

