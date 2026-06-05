Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B14279FD
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642272; cv=none; b=rdCaWvSDwgVkQuaxbuSSO58PobVcrq6UAIXdyOX6+qa8tYNXkp1RXgffxMF6eV3q44c8ZhLgbuXmxu6IBx79HOKx0Jywrpo+5pZ0Mi0oDIOJBa4BWhV4ujzLZ2wZkHIvreWLW6H3QKON6WTB31Jswc5qFdfBUZmeyshC60DDJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642272; c=relaxed/simple;
	bh=TfLsETz7Q6l0FsZne6CcwqKFbkV6sQbdJ3G/Uxbs0sc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dSlxoQWO8iuKf2f2f8rJN3JKb7ccGYveWXN11SBgO0eM9WCrGN4qVGNuVTYIU2HTwKnPJ1Q/VtQXuzaCeu28Wpdv/y5CF40/J38NeRdVjlfFI2pl5IjwzkHMDw4diOSfBcSgIrUV8kB+rj4a0/qtpnrrWOiGxqK6F9WTPZSjcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqbLhYbX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCZPDZRv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqbLhYbX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCZPDZRv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqbLhYbX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCZPDZRv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqbLhYbX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCZPDZRv"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9F40275828;
	Fri,  5 Jun 2026 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780642266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSJgsdoPb53WKlxUb4Ar+zQAj0t57KFWBUIGPp5tZ/4=;
	b=cqbLhYbXqQ5DmSgOueZ40o4uwiC4l/F9yChE0ijzilkPc/NZ/8h52m+nyNo8Z927hNC/nD
	h6uzKXUMPL2BLimxcA5vZYv8vWHupqNuhJrPtnMUdXjgiwj5AWdsmgTIs6A6COYS3G0Zlb
	iMXt4baTpTkOZvgu3gj+t71ooYaDVvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780642266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSJgsdoPb53WKlxUb4Ar+zQAj0t57KFWBUIGPp5tZ/4=;
	b=OCZPDZRvWlmxIPniJy+nNqaoe+0kcLrgcasJ8Go1l+GIVhUVnBeOC0znbu9O78tPyCl0QS
	8G9lsmxfaw4MinDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cqbLhYbX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OCZPDZRv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780642266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSJgsdoPb53WKlxUb4Ar+zQAj0t57KFWBUIGPp5tZ/4=;
	b=cqbLhYbXqQ5DmSgOueZ40o4uwiC4l/F9yChE0ijzilkPc/NZ/8h52m+nyNo8Z927hNC/nD
	h6uzKXUMPL2BLimxcA5vZYv8vWHupqNuhJrPtnMUdXjgiwj5AWdsmgTIs6A6COYS3G0Zlb
	iMXt4baTpTkOZvgu3gj+t71ooYaDVvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780642266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSJgsdoPb53WKlxUb4Ar+zQAj0t57KFWBUIGPp5tZ/4=;
	b=OCZPDZRvWlmxIPniJy+nNqaoe+0kcLrgcasJ8Go1l+GIVhUVnBeOC0znbu9O78tPyCl0QS
	8G9lsmxfaw4MinDA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] selftests/livepatch: fix resource leak in
 test_klp_syscall init error path
From: Miroslav Benes <mbenes@suse.cz>
To: Rui Qi <qirui.001@bytedance.com>
Cc: mbenes@suse.cz, jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
 joe.lawrence@redhat.com, shuah@kernel.org, live-patching@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260604083208.1071428-1-qirui.001@bytedance.com>
References: <20260602124509.365996-1-qirui.001@bytedance.com>
 <20260604083208.1071428-1-qirui.001@bytedance.com>
Date: Fri, 05 Jun 2026 08:51:03 +0200
Message-Id: <178064226303.69035.586790401674446574.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=364; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=TfLsETz7Q6l0FsZne6CcwqKFbkV6sQbdJ3G/Uxbs0sc=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhiylwutFJk+tdz8/ZSHzif3Y9Uiuw3eeqVoE/jow/6Cq9
 OfYr0syOhn9WRgYORgsxRRZXu91ljOckmugWf3uLswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6BgxcHEKwFRfkuZg2Lwm+ZaJBffnP2v8LO9N+h9Tn/fCrmVrzr0cr89CPzZZ8R6te5nxd6N
 szckECZe/fIuNdTjfsa9tOv7QRb+nbumjA82eov+cwjYlPbUXmHBo0QLHPk4Hzyl/A1ljJH49Ev
 635b/Wwv2GMo3BmmJrPSQTzTxlwuvu7t3boZgpLzv56JXrnee3r2K8Ws0XkZ5nslqcw8666LSD9
 6XSdsZGd/fmH/yTVlw9skWPwb7+steOOx08/w8e4n+U3JQcbLBP9pe7W5LKhHrxhKrIWjUZmX2H
 5wYuDQ4N/z/9myl/0ePD5aIvFLTevc6/vJTt4ImEU1cUNromvVKV6MywMWrade33FvvUlWeLZoX
 cjUkFAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: *****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.64 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(2.99)[0.998];
	BAYES_HAM(-2.75)[98.90%];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 9F40275828
X-Spam-Score: 17.64
X-Spam: Yes

On 2026-06-04 16:32 +0800, Rui Qi wrote:
> In livepatch_init(), if klp_enable_patch() fails, the previously
> created kobject and sysfs file are never cleaned up, causing a
> resource leak. Capture the return value and add proper cleanup
> on the error path.
> 
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

