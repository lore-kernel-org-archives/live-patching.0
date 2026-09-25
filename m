Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87B49CF5B
	for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341070; cv=none; b=s9JeLX+Zqbei0hqztq9rdUzOn4bnZSwPwJwPtZcHoNa/5nBpsW5axRdAwrl7ALYyFj+Uy90X7W/vBDGzDaDmPB0hta6IFFvIsAvBl3U3dU+K/fEgBtOc10018BbbRHrKUVdCZL/4orRIBf7Q/xb1i+RZTB6F/BmyxTOagz55yfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341070; c=relaxed/simple;
	bh=6DekkV3C/5LLVicOAGI+PggCc5ILfa9d2ielb8J+5gM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZRLtQ1O9hBMbVenvOOWRxZSVKDo4pacRkhAnh0/k53DhKNk30ECQ+KO1qTg4hPmJlM0KKF3UNkZnybVu2pfPclyG/ztfd7X8ihNil6JXFSLm2bMThKKHqScoPyg4h+khzZzJEzvFQ90R8CGvJNurdLaWsTCA9Qv/FVAvf4ZdwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cRnXL9us; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jF7DaZyW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7CMjviY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FoYBcCgg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cRnXL9us";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jF7DaZyW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7CMjviY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FoYBcCgg"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 37F591FF19;
	Fri, 25 Sep 2026 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790341061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdWv4W1bo9eDgc6EnfGMuKNc5KmD2YdstcGZk3m55lw=;
	b=cRnXL9usbUxWDuCRQPvT970vvOrjuB8qF+bUfGBYAY8gZsfJx25igUvohu5kTNh5i/K05e
	YoM3+GUusnguH8DOcQUIfd1jBu3IqOn8AI2892NF3KJqzS8KWy+oX6FuFCYlIDMmr04z3H
	Q24+BdaP6B29WnUQ/TXf3faw8mLqZ/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790341061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdWv4W1bo9eDgc6EnfGMuKNc5KmD2YdstcGZk3m55lw=;
	b=jF7DaZyWZE2QDdS+TIBkLz5wFGbwl+UwuuaCsUAVMmdtpBHY58CK2b92Z+Jehaw1HkFHl4
	lk6G/3yS+I1Pc+CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h7CMjviY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FoYBcCgg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790341057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdWv4W1bo9eDgc6EnfGMuKNc5KmD2YdstcGZk3m55lw=;
	b=h7CMjviY3dldexdfYvu5zkobcCsv1ga5ZJ+Xwd6UlnaB2MIVjhTXafX/3y96iJspl9irGf
	4TcUBdwOto6YwBw0pxrwTtWp7jOoQzf8gDpg5NVAITHLaZmXN3FOugDa7l2JGwr2kBBb8s
	DI5Uoam7WfCjYbMT+JIFGexZBH7YUOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790341057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdWv4W1bo9eDgc6EnfGMuKNc5KmD2YdstcGZk3m55lw=;
	b=FoYBcCgguFlCcozIIJMGVcLSv/p+sfTe1e/wQrr6bjjbvVDLIWaZX4oZ/4Kg0vhV478bHh
	Ml3Bl16E0SNdTuCw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 7/9] selftests/livepatch: Add provides/obsoletes
 test scenarios
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260913024228.72317-8-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
 <20260913024228.72317-8-laoar.shao@gmail.com>
Date: Fri, 25 Sep 2026 14:57:35 +0200
Message-Id: <179034105515.68715.14204526729868200872.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=6DekkV3C/5LLVicOAGI+PggCc5ILfa9d2ielb8J+5gM=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqxt+QeTJXfIT+yfwXZZTzrW5PNLpuwbeU7zJbYF/23/U
 jovZdeFTkZ/FgZGDgZLMUWW13ud5Qyn5BpoVr+7CzOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYMXJwCMNXMkex/ONx6ffM+hL0MmmTb+uKdVtiPB68jFq01+Zm9/u7Je8eTHr1a80v8xZd
 8M67VcwXO7PhxLu2l9pV5cY4h5q7l80Lc1972WX3g+CPGsFmWs+SqBWJO655cF9N2yC/enF+9ds
 GtP7bVkwM5Usvd63hOezKV2074ck008GTe0TnVZ1035r1y9dmb+IZnyR23fy6xrf6LVf/27Tuk/
 dO8RunC77DryxVWnNfmlfLd8Cu1XHviz/75E/Iv3UiuFLb5b7t1na66mRj3z21R6THsfr+Lfy5c
 uMXEqNZYZ+P5akeZuRJC8Qc/WIVyCJv2x4kXrD+2SDVqsd+lJ/kTpf+18VRN2h6ZpTGnxvdHzPU
 dT+xeAgA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Level: ****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 37F591FF19
X-Spamd-Result: default: False [16.62 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.73)[0.245];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	GREYLIST(0.00)[pass,meta];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Spamd-Bar: ++++++++++++++++
X-Spam-Flag: YES
X-Spam-Score: 16.62
X-Spam: Yes

> [ ... 175 lines skipped ... ]
> +# - load two livepatches with different provides ids that modify
> +#   different functions and verify that they coexist
> +# - in particular, verify that provides=0 does NOT replace a patch
> +#   with a different provides id
> +# - unload both livepatches
> +
> +start_test "provides 0 coexists with provides 1"
> +
> +load_lp $MOD_CMDLINE provides=0
> +load_lp $MOD_MEMINFO provides=1
> +
> +disable_lp $MOD_CMDLINE
> +unload_lp $MOD_CMDLINE
> +disable_lp $MOD_MEMINFO
> +unload_lp $MOD_MEMINFO
> +
> +check_result "% insmod test_modules/$MOD_CMDLINE.ko provides=0
> +livepatch: enabling patch '$MOD_CMDLINE'
> +livepatch: '$MOD_CMDLINE': initializing patching transition
> +livepatch: '$MOD_CMDLINE': starting patching transition
> +livepatch: '$MOD_CMDLINE': completing patching transition
> +livepatch: '$MOD_CMDLINE': patching complete
> +% insmod test_modules/$MOD_MEMINFO.ko provides=1
> +livepatch: enabling patch '$MOD_MEMINFO'
> +livepatch: '$MOD_MEMINFO': initializing patching transition
> +livepatch: '$MOD_MEMINFO': starting patching transition
> +livepatch: '$MOD_MEMINFO': completing patching transition
> +livepatch: '$MOD_MEMINFO': patching complete
> +% echo 0 > $SYSFS_KLP_DIR/$MOD_CMDLINE/enabled
> +livepatch: '$MOD_CMDLINE': initializing unpatching transition
> +livepatch: '$MOD_CMDLINE': starting unpatching transition
> +livepatch: '$MOD_CMDLINE': completing unpatching transition
> +livepatch: '$MOD_CMDLINE': unpatching complete
> +% rmmod $MOD_CMDLINE
> +% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
> +livepatch: '$MOD_MEMINFO': initializing unpatching transition
> +livepatch: '$MOD_MEMINFO': starting unpatching transition
> +livepatch: '$MOD_MEMINFO': completing unpatching transition
> +livepatch: '$MOD_MEMINFO': unpatching complete
> +% rmmod $MOD_MEMINFO"

The verification step is missing. The following unloading steps kind of
verify it but it is not the same.

-- 
Miroslav

