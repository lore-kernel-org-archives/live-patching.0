Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC03F104C
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877515; cv=none; b=jps7vG2Tmav2JaU1shFDvJe/tlppYtykYUQdheI6d8p2/nx3zMRJd5kAmkHGmOZShE4aNWcgvc8JPiS/wMWei5JvZ7y7KMrgxeOJCo0AIeVm02afrKlvrEbASeaEgYG8lwfjqhOyh9ubVTbFK7BHaNzlyuTQd2WVFPDXJCe2F84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877515; c=relaxed/simple;
	bh=vfUxM49D7eOOobIxOcOICptSQE1k1HaQpGdx3L2Cvg8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=PSDwEtVOWMpRMUpfCwE+fcPhaW0xeTX/4QIXm6XRt20aUzHcv+lgKZ6i5yPqEU3DfSgI9Ky0KTOI/ugCyMoQLX+X+Mkx/7LrrVxHJbHDTZVRYCEKRrja84hdKJKv05cWSTIxuEFeVEd03IaKHg7emNbpXpMnLjcJs0qJkJFcxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxkF2PHv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pSR4LyMb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ho28wH6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PpUpIV27; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxkF2PHv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pSR4LyMb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ho28wH6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PpUpIV27"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id BD7061F843;
	Tue,  8 Sep 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788877496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph0yr7vRO2TNMr38q6ZGMh5FyP314NuYsVOQxeqb3cc=;
	b=hxkF2PHvitdSqz/SAYGj0S4j5MOh9q/PmwAi1OJ1JAIvWkoePOwZjvbKNKom7PSOTIVMMD
	pcsjvYpSL6qI7lZNwQmBkdU36cj3C4oJmJQX/plZIRzZmNKTKw11hwzYRKYtK0BtD2IxuY
	rnFdc8GBDAxl77XRNCtDu4uTU4v6gD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788877496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph0yr7vRO2TNMr38q6ZGMh5FyP314NuYsVOQxeqb3cc=;
	b=pSR4LyMbH2ib1Nktq/kurP35J6Ql3AFM6t+P04hJNZQ0uDIedPMj3H+WmKePmrw7bTeelA
	eC09xMZTEORHULBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2ho28wH6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PpUpIV27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788877492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph0yr7vRO2TNMr38q6ZGMh5FyP314NuYsVOQxeqb3cc=;
	b=2ho28wH6r3LhA5OmcJIZI3mtZbPD2a99wltqNDqKZhPKiwuBbEe0wTnSB7WoQJWAoCqshX
	1r6u/suunDvE5xxYNI+3JyyY1IJ/xBxYKGFO2lNtjyDgtw5L+lCdQb0baHpWVcBlL7/kqz
	Qpw3cVUIOKNHXUvfDV4MOhFrRPWAXF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788877492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph0yr7vRO2TNMr38q6ZGMh5FyP314NuYsVOQxeqb3cc=;
	b=PpUpIV27K+hcNY/P90nj7HMBR6Xg3OZnRjEMb+NTZUEotbRby/sdRoFpjEDctHjctzhd3I
	sf0yRkoOxnCBxFCg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 for-next 1/8] livepatch: Make klp_find_func() non
 static
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260825114641.80452-2-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-2-laoar.shao@gmail.com>
Date: Tue, 08 Sep 2026 16:24:50 +0200
Message-Id: <178887749066.24106.16124933766549867985.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=359; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=vfUxM49D7eOOobIxOcOICptSQE1k1HaQpGdx3L2Cvg8=;
 b=kA0DAAgBgX1r3ESrGywByyZiAGqgGrSiBBHqMbZBjFRgXH6UP69J3MP7kd7FREPYJcCQXmqM1
 YkBTwQAAQgAORYhBOu9Qx4xlG0wKXvu3YF9a9xEqxssBQJqoBq0GxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjEyLDIsMgAKCRCBfWvcRKsbLCeKB/48ZgAoyMPM4vfEEx5wruwWfSDD+FK0JIKPQf+80J6
 zUViZI7fHAq1JZIrsgQH7S2KQmvjThOvPsDYAZgiZ0vH8UNXTJ+0UyLVw2enAw5FVXVE/WdYdw0
 wGpVBa3ZDZGkxNd+7+vc47KA1OJlvyN7mez0nKwSx221EJE17VwgDfSrmij6pBEtZHXY9b2AYtF
 zsatZeRI/zI94zCflMaq2854qaC2yEb8tvsGAWp/4Wk72huWeOl+xbhC5cLJqZa8HcC4glZvTG3
 tLYK2v08m7feRnY6OQbXXrgKApMO+xnJ9Cz6+QjcrFlNXYxDaBR8nUExdToClfDnImVGNp+5SA9 p
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: BD7061F843
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 16.68
X-Spam-Level: ****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.68 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-2.98)[99.92%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.77)[0.258];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	TO_DN_SOME(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:2b::1244:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:dkim,suse.cz:email]
X-Spam: Yes

On Tue, 25 Aug 2026 19:46:34 +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> Make klp_find_func() non static to allow its use in other source files
> by an upcoming patch.
> 
> While at it, rename the parameter @old_func to @func to better reflect
> its generic purpose.
> 
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

