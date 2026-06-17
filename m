Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5682348C6D;
	Wed, 17 Jun 2026 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723698; cv=none; b=ZI/ttrd7Jycy13SRmqIQU3ThG1x5wFsKZqrxRYEQmaRWcCXMmzb+fBb8GB3FIlOzRlz33TkwdpktsHVbuGoT8QakRmnjUqMMJXQo8G94XDmBmqttnrsTUZ9Pgj+zFoHUK1CdDq/9lhfa5VHWgBvjw9GryMnntUkWJa0M0e6/leM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723698; c=relaxed/simple;
	bh=iSIU3Rhdcpcaug3F7bTTucRUJbAvVoWAqpEDgILf9g4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ALli1UHOm1/1a/YVqyQszSHjWTayhF3KVqjL6gUY9wuIZqQ9i1a3MuErGwC/gE1XW5FJ+1QZf2xTtl5CdjUCXK6hu9S2YlRVKsSgyBJsXpVM23sHzygtdjPUM9nx93vzfGPMW75ort3PGW0K8MrUQP7QkJfgpT1cBO5FbnNJt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7rTBxH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7rTBxH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609981F000E9;
	Wed, 17 Jun 2026 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723695;
	bh=wv/zrbEnvThrJ+2/Sjd9iloqj9N3jCKnCfQMaXk6rjg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=F7rTBxH7REJz89hwbdhQCU93ZgXZuWLt7L1LRw9mWY4IQuBpSCjZvC99KOZIKCmQm
	 ioLi86k2Uj62YJyYAnHHUVa44LRJIJ6IG7lIH8OVAcSesuDtOliVKeuklf0X9VY3Zn
	 pGH0A/eKIpM0FKhnSlNazSGZm3fXfr1DjycL4Axsg/oa+NeeYJUP5gqd7zMaWOYouo
	 W8WS+Yc5GflkshI8cD4MBlYcu6hnfWqR0mSkJDD949S619Mi3qJgw1wK+QAG/nBX+v
	 yoKHnEox2I3P8XXLFRDp5QuUeyn6CjpvUdRgyqfeXSAASY7G0xRgWQQYlBp7NcwgXj
	 J/xgpNb16uNOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939593931008;
	Wed, 17 Jun 2026 19:14:50 +0000 (UTC)
Subject: Re: [GIT PULL] livepatching for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajFtUxjbisYnAHSz@pathway.suse.cz>
References: <ajFtUxjbisYnAHSz@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajFtUxjbisYnAHSz@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.2
X-PR-Tracked-Commit-Id: 7203abb3f8bd61e021cce076dafdda7bcfd9f2c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0839c8963b7b28d25350bd5ea69bacde794124ab
Message-Id: <178172368927.1775335.10019553212559684831.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:14:49 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jun 2026 17:35:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0839c8963b7b28d25350bd5ea69bacde794124ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
