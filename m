Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B8421896
	for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687007; cv=none; b=UeEGb01krVvmKZTLHRDWROe7/TJRAJ2aQkMCHfUUp9KdUz5/u2zhcgAVfIgpP/raD4O8u2tbYSowFUNgMTrP/13jfkjI8JdJWZRZHnJjXePeAxQq8Tk83+LBGCJS4MJ8Z3fO+GMVAh7qHSBAROleyP4zwtd5iZNYfECD7Z79FZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687007; c=relaxed/simple;
	bh=CLlY0SXqymrwyaHmBW5Ka5IYDtLy2pUM+vFm/Qo1PbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbxFncm6HdcDQk4RikX0VMDXS5AGNkoMn+5P0WlX/FJLWL7JFqC1zwbGrLzCUmQRy+Kp/UBiAT2rAsdfU4CpcGLAF6XlrWZU3E4gOxSLgpVmPhsO96rgmNt/+m85FJkrlfH0sUBI0TlZLMS4DaSYAgtoykU/xy+ztzWGNnDLV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vCjO+Fvn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vCjO+Fvn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vCjO+Fvn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vCjO+Fvn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C68E764DC;
	Fri, 10 Jul 2026 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783687004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywqN271g2PfpMPGQAbdO4P6kzY5wpKAB4xsITaSRfO0=;
	b=vCjO+FvnfUnKSfzt9WvHTX3zBqDtsCVCcIo2kibUl7zyxh77ZIyfpgrJQY7WvThANoBQkm
	MSXy9Lm1k82J67ZfXpaEhFIDExxntYi6jHTEt6O+3qqt772riTE3P4ZbYMfD/K6tAKlRnK
	lTY2GuqIGjYNtgvcEt5uSwbeqjlU9gE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vCjO+Fvn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783687004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywqN271g2PfpMPGQAbdO4P6kzY5wpKAB4xsITaSRfO0=;
	b=vCjO+FvnfUnKSfzt9WvHTX3zBqDtsCVCcIo2kibUl7zyxh77ZIyfpgrJQY7WvThANoBQkm
	MSXy9Lm1k82J67ZfXpaEhFIDExxntYi6jHTEt6O+3qqt772riTE3P4ZbYMfD/K6tAKlRnK
	lTY2GuqIGjYNtgvcEt5uSwbeqjlU9gE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22F08779BD;
	Fri, 10 Jul 2026 12:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id txkvCFznUGolWAAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Fri, 10 Jul 2026 12:36:44 +0000
Message-ID: <cfb0cfc8-9cb7-4226-8987-b141c68017de@suse.com>
Date: Fri, 10 Jul 2026 14:36:43 +0200
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] module/kallsyms: fix nextval for data symbol
 lookup
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Viktor Malik <vmalik@redhat.com>
References: <20260327110005.16499-1-stf_xl@wp.pl>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260327110005.16499-1-stf_xl@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[wp.pl];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_TO(0.00)[wp.pl];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3C68E764DC
X-Spam-Score: -4.51

On 3/27/26 12:00 PM, Stanislaw Gruszka wrote:
> The symbol lookup code assumes the queried address resides in either
> MOD_TEXT or MOD_INIT_TEXT. This breaks for addresses in other module
> memory regions (e.g. rodata or data), resulting in incorrect upper
> bounds and wrong symbol size.
> 
> Select the module memory region the address belongs to instead of
> hardcoding text sections. Also initialize the lower bound to the start
> of that region, as searching from address 0 is unnecessary.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

I've queued this first patch on modules-fixes.

-- 
Thanks,
Petr
