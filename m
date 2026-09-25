Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA442D77B
	for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326488; cv=none; b=l1iQVEPoxY6RkejMZge2Xc+aNvXCLN2MElxdEgkToOJLR1SQgy1KbRGwod4/RYDbtX7b09dqDWgkye2GFKYq9OMw6RPmo31ir2cuaSbVkIsTTQD7rkjAgE0p/9A6D6KGB73kWkFFVyKd2IO0w0VR07U8E8gZ/4GhvYa0b89zrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326488; c=relaxed/simple;
	bh=RcMJbkbN4OBce4JQu0d+OIqaQ2+rUM1tpdoevOduKQI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cDj+7FhnQedJROzgMG4bNRo7b3eQX+1sg3d1ZMgvGaNcgUMmgipuPxhfQLEZIF2ZyR3pGftsy5d0dCquBAAta0/BHLyEv0bPxIfjfr7aUSUYUdmT4tqg9dJsupgFwUl9OA5Uud5ri4GUB7SFgLc6nu83JdOH4XYHavGU4iNsOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C6Ik3sKt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1nI2z/E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIMTu46g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EDXsz4K5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C6Ik3sKt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1nI2z/E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIMTu46g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EDXsz4K5"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4607121B82;
	Fri, 25 Sep 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790326478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fPyBdOdOfvpg0S5pk8LvXmZZHOz7d9yhl/6yxU2ip8=;
	b=C6Ik3sKtA30zI0/7na5GniwKev2nm7G5w4fVvjF3LLYsUQ1ZSsf9ypPqmm3dDVEI5krCy4
	r6yjtv/CpJdWxmLcs9u/PTWI9F1onLJUj1TN9/pMbbiqibhFEtFUV8g9+XOhziXpMycEnB
	RIwkERF4+ByVH+UXjZ5NHBuhR7n16ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790326478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fPyBdOdOfvpg0S5pk8LvXmZZHOz7d9yhl/6yxU2ip8=;
	b=W1nI2z/EbXJQZ8Fyw7XY7qCf99hLVDEaj1vl1VJEHlaHXeXz0bgEQpvdgzlIXoDohDdEve
	98JRRfD8v7owr8Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CIMTu46g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EDXsz4K5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790326474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fPyBdOdOfvpg0S5pk8LvXmZZHOz7d9yhl/6yxU2ip8=;
	b=CIMTu46gHenbl70HXVzOKFT/d0TqFSJLjaDE2Sc7hcxpuAQcAkAoLrpLh3l1sejCt75jTh
	Lno0Rzc1jewnjJyqiWb9A59qZTkGqZRfcFpcKsXgzEYF1ormnJf5EDcCLYum6V7dGFRojT
	05FVBnpWeKBCLhomDapLvUC6BgVtTdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790326474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fPyBdOdOfvpg0S5pk8LvXmZZHOz7d9yhl/6yxU2ip8=;
	b=EDXsz4K5V2OIvcrN0Fv3tnvUQKSpcy9qZYSiorr3giXOg+U0i0HnenPL6u+IUalzhVsbVt
	4lZ13zSyhzZmcUDg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 1/9] selftests/livepatch: Clarify test module file
 names
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260913024228.72317-2-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
 <20260913024228.72317-2-laoar.shao@gmail.com>
Date: Fri, 25 Sep 2026 10:54:32 +0200
Message-Id: <179032647206.68715.5136041049939809999.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=249; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=RcMJbkbN4OBce4JQu0d+OIqaQ2+rUM1tpdoevOduKQI=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBqtjbJl/wjJ9kaPa7UvLiT/uUKrjed7vjiiODIf
 57sdvFJmf2JAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCarY2yRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGywkWAf/QgV8JJE/AKs6bkhWk4BC39Qsh0NihxK
 I9NE2CyfQzf35yexASH9tGRgVg5aiJRXsFoFaEldcb8iixn90fTxSaZ9ClPrSm2eYgB+1vB79En
 Gr5tJKN+wgOY2n0w+53BdvIJVVJ2SitDyoK5lPuuIS3NrxEEJ+/k3591Y/GvYtq9oGai7qehJj9
 Mt8k6jS4YSwERAmNmjuGVDuSf3lfLFfXOzWCrpnPUTJ41lEO5HIo2fhMMisK9sbG6wJ0ykwVBV+
 ydSIl8lUVFpyckc3bMM9BHvRpaDwphAgtiek/aIknLkr2ovpIeypf0h46vhaieL1sVmt4JP1EPx
 cia7mILq42w==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 4607121B82
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 16.66
X-Spam-Level: ****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.66 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-2.98)[99.92%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.75)[0.252];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spam: Yes

On Sun, 13 Sep 2026 10:42:20 +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> Rename the test module files to be more descriptive of what they
> actually test, as suggested by Petr.

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

