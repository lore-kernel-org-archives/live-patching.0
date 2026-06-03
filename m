Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2144611EE
	for <live-patching@vger.kernel.org>; Wed,  3 Jun 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492187; cv=none; b=gfRZB/vADe2wX/fg0WID+tHQmUMyhRM5WbfYgnQAxpFXvMGqhXHjGysyqriPIhcgEV1rx+4NdsTlp+pfeIPqM9sqGGYZPBxlcOZgLZyZ4KfxxVqLnypNr0ABrmhfCKOnMiWghocAEv9p8U/LYesR0I+I2wVldvRi+xnRfHtZJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492187; c=relaxed/simple;
	bh=obYxKfMdRgtW8BEH4IjaawQvf3rPgPG9+RmoM6JlSQs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=V5qJoK5rxJxDp+fmQOBb28a7TQyUlgP+xIkyINwlfXZk+VZVZSl765idHH6FKe7+TUV53jiwxRXcC1nBQ6FhNUI0/FZFH81W4xFf8vrsSa8vs4gBX4mzxLvCnhUUf1yRWNNcj+87P87YzmKOZ9J2e+fjBnI1GoSaJI4ySadJwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvalLuIr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBmU6Mkp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m9ZlgGdF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9XfewCk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvalLuIr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBmU6Mkp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m9ZlgGdF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9XfewCk"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 74A4F6A96D;
	Wed,  3 Jun 2026 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780492183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk7etxi20eTchK/Hm1eqIXIhNDaRqEyTR3r1YTY1oPU=;
	b=CvalLuIrGezgaDjhUr6LsbyskttrxdfEiENKmDg3TSmcthtg4WuPH178YG+XCLgraGAB0r
	vZfRvcWEMzt/fXF/P1uIZ2elF+Yj3Zqki54mKLeDSgh8w4+C1YtWLLjG6gC7IDR+RaQNo2
	NiFChaOIe2MPA9LwogcCNM9KggORr84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780492183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk7etxi20eTchK/Hm1eqIXIhNDaRqEyTR3r1YTY1oPU=;
	b=CBmU6MkpCnfMzXYEslK6qgW3Mgwc6xh6PXOlINJOG9/PHBZzi5obJ7Zt3WnkvKRJXbmfSp
	ThCieRryvgVo0/Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m9ZlgGdF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v9XfewCk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780492182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk7etxi20eTchK/Hm1eqIXIhNDaRqEyTR3r1YTY1oPU=;
	b=m9ZlgGdFiAHgNbplRLh3dw9sPUrbMiDLNVmpLQPPvnkLPXphCpY8mVA8nNxp6o00OHaOQm
	Ss8M0xSnEwPAcyiXPDhQbOmalke9B/UBQgQTZtXiCZhpw1O4MYts2xRzTAetXpMfg8JC3Q
	98VwU9ceuPJqZSDSP+NxMokVfJvzXqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780492182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk7etxi20eTchK/Hm1eqIXIhNDaRqEyTR3r1YTY1oPU=;
	b=v9XfewCkE1/Xh3J/AJ9y9y5C9yaoSJOoJPyzR9NcraX9GZFw1F+hI3cWVFlObxgUU1QtVu
	nqdWs+6OQAeaSBAw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] selftests/livepatch: fix resource leak in
 test_klp_syscall init error path
From: Miroslav Benes <mbenes@suse.cz>
To: Rui Qi <qirui.001@bytedance.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, shuah@kernel.org, live-patching@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260602124509.365996-1-qirui.001@bytedance.com>
References: <20260602124509.365996-1-qirui.001@bytedance.com>
Date: Wed, 03 Jun 2026 15:09:37 +0200
Message-Id: <178049217756.69035.11980890855635035855.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=obYxKfMdRgtW8BEH4IjaawQvf3rPgPG9+RmoM6JlSQs=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhiwF9Ukn534rmr03sOfo5vUVB/+1GZx3jXz29EfaayPTD
 b+XML7438noz8LAyMFgKabI8nqvs5zhlFwDzep3d2EGsTKBTJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUMgQ8eIgYtTAKZ6aTb7//Lt8Wp//3MUhHRuk9zJbi1llyj7ISXma5+s7rwEi8sKNq1LO7bwXSx
 fE3k4Wst+vwvbxlNH8ls+Wn9nyzz9z23yQ73Ec4asQk/57uy7OUtwyUzvDrErLa5Cv4sFg8z5NL
 3fWbZ+/ZR5RPntXoOQY8ziJ4QtDzSaKtp/m6Rm78ZgcF4n353hW9J29vRFCnzTzP5xPPqwydbof
 Lb/KZ5l36YHCP/J+Cs2obpityCTb4PD5fMSa4P0FC4dc9r+p82oqZXblHnFww/P5jyaszq64fTT
 XsaTaXxrlBTimsqzPyZ+inv93nnCcqYvC6on2x8wuTfzhb2q0/3z7CsK3mpOZmPZEr5/5vF7FdN
 fL1vGAgA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 74A4F6A96D
X-Spam-Flag: YES
X-Spam-Score: 17.36
X-Spam-Level: *****************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.36 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(2.97)[0.989];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.cz:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,suse.cz:dkim,localhost.localdomain:helo]
X-Spam: Yes

On Tue, 02 Jun 2026 20:45:09 +0800, Rui Qi <qirui.001@bytedance.com> wrote:
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> index 0630ffd9d9a1..d631acae48b9 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> @@ -109,7 +109,12 @@ static int livepatch_init(void)
>  	 */
>  	npids = npids_pending;
>  
> -	return klp_enable_patch(&patch);
> +	ret = klp_enable_patch(&patch);
> +	if (ret) {
> +		sysfs_remove_file(klp_kobj, &klp_attr.attr);
> +		kobject_put(klp_kobj);
> +	}
> +	return ret;

Is sysfs_remove_file() needed? I think that kobject_put() should remove
it automatically since the object is bound to sysfs.

-- 
Miroslav

