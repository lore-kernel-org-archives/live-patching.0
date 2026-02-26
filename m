Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D25378D80
	for <live-patching@vger.kernel.org>; Thu, 26 Feb 2026 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108067; cv=none; b=aoTvipEYjyaKD+gPJgF2Vl3Ik3NrpnAj5zZ0UdOrLzBXGyc999qEb9Snha9/H0H6SVIi6cCKd2x43tNB1oLcRUS6lwhH4hJjmthaHmr+JY18hzxOIgeKTGWy1vmtZZi+ZQ8r+IKsKfUEPAt6QSIQIs3moOGSlmzHEYSB3lUh/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108067; c=relaxed/simple;
	bh=7ogsa26yKudYcLKfbMjbhk13Uda61RjKITqe6prTqIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RIsUmwPZdwSU451wE2QDA3Lxo+SLFf0kxeOgAmrdjw/JFrqw5ty+YMBEt1g4rCRR7zgbjxpWewfrVt+NWLoMIeoyRnR0I3NzOFExjSPxFozHHGiWBjvH3T5sC/JX9ECscVDlr993im+FN42AEkvMg4dKSpIj/sHWhaOsZBmZwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYkuLW2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMommW4i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYkuLW2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMommW4i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYkuLW2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMommW4i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYkuLW2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMommW4i"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D86B4D25D;
	Thu, 26 Feb 2026 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772108063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnY2lo5WAaSImxtwRmk4V1XqUgC4ObS3JGv0QNWzaxs=;
	b=GYkuLW2SOZN0O/JISW8hlmNhY9tnaX+lVQCnyciMdWq14aJejF77ys3CUTheXyJUhfGolm
	plqEjs6JP4WQ90wIF/dzHw9gVHJXnnh3EZ+lyKqnqT+pcCsHdi2yg8i6yxR2eAlvqcIzCH
	vomqHtn1kiTFSOn9nS2N6dCLav7EHPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772108063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnY2lo5WAaSImxtwRmk4V1XqUgC4ObS3JGv0QNWzaxs=;
	b=QMommW4i+Ir0eyGUof9Vns3DDfXDqCETckeMFPn+znsLL8dHF2zZfxvhrKBViqgKwVrmT6
	YKESz6C1qcyqukDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772108063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnY2lo5WAaSImxtwRmk4V1XqUgC4ObS3JGv0QNWzaxs=;
	b=GYkuLW2SOZN0O/JISW8hlmNhY9tnaX+lVQCnyciMdWq14aJejF77ys3CUTheXyJUhfGolm
	plqEjs6JP4WQ90wIF/dzHw9gVHJXnnh3EZ+lyKqnqT+pcCsHdi2yg8i6yxR2eAlvqcIzCH
	vomqHtn1kiTFSOn9nS2N6dCLav7EHPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772108063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnY2lo5WAaSImxtwRmk4V1XqUgC4ObS3JGv0QNWzaxs=;
	b=QMommW4i+Ir0eyGUof9Vns3DDfXDqCETckeMFPn+znsLL8dHF2zZfxvhrKBViqgKwVrmT6
	YKESz6C1qcyqukDw==
Date: Thu, 26 Feb 2026 13:14:23 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: livepatch: test-ftrace: livepatch a traced
 function
In-Reply-To: <20260220-lp-test-trace-v1-1-4b6703cd01a6@suse.com>
Message-ID: <alpine.LSU.2.21.2602261313340.5739@pobox.suse.cz>
References: <20260220-lp-test-trace-v1-0-4b6703cd01a6@suse.com> <20260220-lp-test-trace-v1-1-4b6703cd01a6@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi,

On Fri, 20 Feb 2026, Marcos Paulo de Souza wrote:

> This is basically the inverse case of commit 474eecc882ae
> ("selftests: livepatch: test if ftrace can trace a livepatched function")
> but ensuring that livepatch would work on a traced function.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

with the typo fix that Joe mentioned

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
