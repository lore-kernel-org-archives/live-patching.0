Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF453B95E9
	for <live-patching@vger.kernel.org>; Fri, 20 Mar 2026 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011890; cv=none; b=iQQKVDPm8WgLBuE0pN0RQ9Cae2/2pahA+tpsVb3NXeiGbZvW5cBskrGNKeqUefJkL6PtfGaOiWxT7hZ7x/eEvAS1rNN0zd2NL/asF0Oo570MFrWr09A2C51mk99Ckdr2MSKczgCHgPsGn6VpT/Hzphs/rY3KHJhCXxy+3PpF4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011890; c=relaxed/simple;
	bh=wQsr2umlLU276VV3WvanOk5fSVNqgitgbEt5rIqdfa4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bxWkq898vEkh8z7ULpZmjE/Y/dwH+wBa96MixfqG/H7QoWoDVRW7+jZmpK+WT2hpOX4nD2MPUcxl0lgFs054Vb9iQPh6erkfiILRcjYE/Niew9w8DAM5+GMyuJ49GqRaQiODODOpwXB1E9HTk8qBoXFFXRCpiGiSRSRiBakzVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGBeBfnl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0AkAKMaP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGBeBfnl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0AkAKMaP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGBeBfnl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0AkAKMaP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGBeBfnl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0AkAKMaP"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 568B64D278;
	Fri, 20 Mar 2026 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774011887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDjSu5Tct+GIYeydJ405G4J2yeJ17tc5K7qGs3ivx7g=;
	b=fGBeBfnlsu92RMl3f+YEjFr6qJXM9jqxbeu5QCTD/3LljKnLPIjxiLW7sVv+xL1JovSwWg
	bbnRlYaW23KS2h/1ewMx0nHHDXwQg271RqwHFg/svRnjRqqXSJE8z94U0fTO5Sf/KegdcZ
	CDVVGNwyiLs4t3mPa/JSRN5orqBRGtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774011887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDjSu5Tct+GIYeydJ405G4J2yeJ17tc5K7qGs3ivx7g=;
	b=0AkAKMaPsTETwATH3Kgmv06MfJDK3yDL6LWXmpnPHQQDgNB6OCf0r+Emag4j/6D4AXQMNn
	e96fStOfQzOki3Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774011887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDjSu5Tct+GIYeydJ405G4J2yeJ17tc5K7qGs3ivx7g=;
	b=fGBeBfnlsu92RMl3f+YEjFr6qJXM9jqxbeu5QCTD/3LljKnLPIjxiLW7sVv+xL1JovSwWg
	bbnRlYaW23KS2h/1ewMx0nHHDXwQg271RqwHFg/svRnjRqqXSJE8z94U0fTO5Sf/KegdcZ
	CDVVGNwyiLs4t3mPa/JSRN5orqBRGtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774011887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDjSu5Tct+GIYeydJ405G4J2yeJ17tc5K7qGs3ivx7g=;
	b=0AkAKMaPsTETwATH3Kgmv06MfJDK3yDL6LWXmpnPHQQDgNB6OCf0r+Emag4j/6D4AXQMNn
	e96fStOfQzOki3Aw==
Date: Fri, 20 Mar 2026 14:04:47 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] selftests: livepatch: functions.sh: Extend check
 for taint flag kernel message
In-Reply-To: <20260313-lp-tests-old-fixes-v1-8-71ac6dfb3253@suse.com>
Message-ID: <alpine.LSU.2.21.2603201404180.12616@pobox.suse.cz>
References: <20260313-lp-tests-old-fixes-v1-0-71ac6dfb3253@suse.com> <20260313-lp-tests-old-fixes-v1-8-71ac6dfb3253@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Fri, 13 Mar 2026, Marcos Paulo de Souza wrote:

> On SLE kernels there is a warning when a livepatch is disabled:
>   livepatch: attempt to disable live patch test_klp_livepatch, setting
>   NO_SUPPORT taint flag
> 
> Extend lightly the detection of messages when a livepatch is disabled
> to cover this case as well.

s/lightly/slightly/ ?

Miroslav
