Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794374;
	b=Cb2mgnBO76pEx5jTQ/JZDMl93iPhkW+9mIkxFsq2g6fiGgFVb76K9VZOT9l+TZJkUyMU
	 /vPHcZ/vI8omodyO0kbqskTEbM3ntHFaShdrLjdzMl+lu9Hh2G0x2us/Ls73QO2qkM6pa
	 0ie9zxRJIZymWMt8qXXA98iaWkk2pmtEdixxQUGqNKAAMHzvUvVoTAXONtPCEYXSs+WJf
	 Kq2zWIeIgeLZRfIXRH1SFZTDKiXlnzfTSkSHmwZSXLg12qY/UxUOVMmTW1cyGDn1P5WSo
	 mZu8SXt4xbFTNarq+qa99MTILq6vm7U7Gj8ZDxKJmknx/sig0T/vtYxpnz3McGncDSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794374;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=1dNu4Ow+gPHmz8H6gpWXjsTHC0bswslMWU4lnoYD5r0=;
	b=voJ48yJL4XY2dWFTqA9I83cwowOQjipkxKLdiFk0pgQMt9qAxW/P+ezSX2LNY4vVbCD9
	 4zdwEjy4OiMGXFdZQ8EcRg56ENqtAfGqH5cdbfzoG/eJDaHLJBhgoVvcG3J+mREca5muf
	 Ycm8Q3QRwVMOut/kuDSGucKdwilp1dD6JFKangiHoKLkLVrNH8IaDdCWEKS1aji3KbjH+
	 gMCgVbG31FuyuojlBqlM+AeOZWU+zWrYG6D25itByrBSWunUvW67UApdDe6L5zo4ylnX1
	 DP2HXpN2Oy/KO5COEG9y8UpU1Bhg32MQEPS05h5yjR6R7QunR9yf/t5WcLAssT0CG9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZYhgVTp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF22606A323;
	Fri, 23 Oct 2026 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZYhgVTp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CF61F01828;
	Fri, 23 Oct 2026 22:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792794373;
	bh=1dNu4Ow+gPHmz8H6gpWXjsTHC0bswslMWU4lnoYD5r0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=KZYhgVTpYOQF7fGOWQLUZzEtSvrF00LeXFSbkyBBVeca0bprFjq+HgF9NsFPe5Z0R
	 BT8t3WNf/dHtW/paTsmp4S3ZLnD0Pj4l+49S0BAyRCUsOJXSP8VlVpy+qaikqhVgeR
	 bjsqJVdCsHoxGP75nSH+1ecs6VNLeEIHEe0wctsGqNBnvk5lpYCSfAlGQ4pJG30GmI
	 q/v56ygZzQ3nwM4eiUlcd+SzWeSFqGpp4FbL+zpQ/hF9hxQXfxusjjMR0uFem+49rR
	 JXhscfh3ZIxNzgSBVFtJbuXMFJ6w5N9zoMgC5Tox+sltjjEnwwIPg84d1RhEv5AGnW
	 8BAgUlcVfk2gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE642391B158;
	Fri, 23 Oct 2026 22:26:13 +0000 (UTC)
Subject: Re: [GIT PULL] livepatching for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <atoXC68mgjNhxhJj@pathway.suse.cz>
References: <atoXC68mgjNhxhJj@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <atoXC68mgjNhxhJj@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.4
X-PR-Tracked-Commit-Id: cc53a1e0981bf296479d10fd646f73e28ed5fccd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1e818b239dd11397f9a379b84a7a4985e8afdfe
Message-Id: <179279437222.1300063.9452802501524132161.pr-tracker-bot@kernel.org>
Date: Fri, 23 Oct 2026 22:26:12 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 22 Oct 2026 16:00:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1e818b239dd11397f9a379b84a7a4985e8afdfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
