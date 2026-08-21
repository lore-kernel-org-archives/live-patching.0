Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0639EF0F;
	Fri, 21 Aug 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344022; cv=none; b=it3B6QtyUPKFcY5Rn5xZTT734DN0gY9V/m2UjnbnJAKBrSdx7xpDNNpfI6tGxNL1Wed7kRGlxccOwnL0mPMtb5rYAWVQI2szghSyRu9orYiqv6azvNYXYz39Yt+AdOl1Ez3V/2o4cuuCkk3J+sM2CLC5mOGFGextS1P5u5gn2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344022; c=relaxed/simple;
	bh=OK8V+CE6l0gbKmgXQUwuNQS+3cWnpscOIeElo9PDyNg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZzpZjPEXVvQtMKn5nODoSa5qidBDIclHmw3AhaflmJsRdpwIyFna1YcmHzcJlQG949hJ+b6NXT35RkA9dIzclzyGdaOaj1+2reoZmI5GzHLj1jxHCiZk1PdNfKxsxstCMyW23WJOUpKn0OT3hjHyNDoJiljiil8GZSLk7Y/vU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqjDL1sS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqjDL1sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDBE1F000E9;
	Fri, 21 Aug 2026 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787344021;
	bh=6RWUS2vcMjJ5MPSebllZ/xFYxQBAUya3yoYVSFTW1zg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CqjDL1sSk26AKM9puVeRpvUP23cakKTN2gasC4gbKnSYCyXT13pk3D2P/s6vbqPcC
	 cFMeIV9coaF6xB9PxxZ6Fa3EKNL7zZiyKh73fmbz1jY5cIPRmbZYmn+xOmp+XBbUX/
	 sZSsIMxYT5jpIdtvhezFhbnkrymmixfqO5ROZYrimYAjKlB3AQfjwkCTSTdR9LmULK
	 4ivhrS9R5rt7fgdmWPo0S5c+WkAG8F/ZOAoMQ2RgoctIWrt33XVyjPEU9MXuXdHg5O
	 vtDinwqnb8rd57Vy7QaJjWkLp9IDYrzdUgBZU1LNiIfQb2Bu88gVGAX+PYVU4NaHWb
	 60mca83otn0JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A7380CEC4;
	Fri, 21 Aug 2026 20:26:12 +0000 (UTC)
Subject: Re: [GIT PULL] livepatching for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aog43Saa86EsHfoX@pathway.suse.cz>
References: <aog43Saa86EsHfoX@pathway.suse.cz>
X-PR-Tracked-List-Id: <live-patching.vger.kernel.org>
X-PR-Tracked-Message-Id: <aog43Saa86EsHfoX@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.3
X-PR-Tracked-Commit-Id: e77f165d26f72c280654cff248f5106cb9a53951
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26260251022fbc2f248a3d747a9b2b961b18d2d8
Message-Id: <178734397067.1471056.11154798965382128885.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 20:26:10 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Aug 2026 13:39:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26260251022fbc2f248a3d747a9b2b961b18d2d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
