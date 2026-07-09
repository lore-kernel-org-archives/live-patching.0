Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246932BE03B;
	Thu,  9 Jul 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603293; cv=none; b=gCEmnUGwtm0hFWs4MkW7ifyohuVTe5Jgv1KjH63e2cP+9rvjuWgj6lI3p+7/PkCZJwMNe+MwcghRnoo0qpnJtq7LhS9xkPnESZVUwRUBF3FxxmqIH7cl+RL6JwopFoH1OyOyM6tljSqNU8edRXuslafa3yV5KNPs2FtHiwtU3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603293; c=relaxed/simple;
	bh=xaKUCAB0WTbjM/EIu1+mEKZq624rHW8NkbLsI88gSxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaJZCd4w5GkhwIzJ5rMETlHvuZjUvLisyXOIBGHIHR3m0DDlCUCaOE3Ame64O9SpVaVSmjmKyL8qgmbSiEESuJQJ8/NFhqJ9QWuwFe2KA+q9WUV0bnrySRwiSkaOrVHzagpEFqWkv5vbUko7/YVehIdqGu9tcn7HwIUQt0q37IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BwZJKYr+; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BwZJKYr+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783603279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZTMZOseQABETX94dSN5QTo6IogqS7uJz7MvnyKnz3k=;
	b=BwZJKYr+0I3fgRIqFwcYOJfj3JoV5pGqNQ3QLtKjuUKsRhSznhLH87WmYc5xiEFBwbeE2C
	PAgHQNd/1RLHmeuGzsbdb24lg6UjA/nZ0CQc/utrOinK3/+HgZi4vJkN2o2YsYEqk/mpT8
	4ZoYvDbatIHFw2zK49l9Ls96iqStmFI=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org
Cc: jpoimboe@kernel.org,
	joe.lawrence@redhat.com,
	wangyuli@aosc.io,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	kernel@xen0n.name,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v3 00/12] LoongArch: Add livepatch build (KLP) support
Date: Thu,  9 Jul 2026 21:21:03 +0800
Message-ID: <20260709132103.16433-1-dongtai.guo@linux.dev>
In-Reply-To: <CAAhV-H4cr9xBkM-SEUHXm9t0yQ=r3B9pkNdmUDftP00hvVsZrQ@mail.gmail.com>
References: <CAAhV-H4cr9xBkM-SEUHXm9t0yQ=r3B9pkNdmUDftP00hvVsZrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Huacai,

Thank you for raising this -- I take the concern seriously, and I'd like
to lay out the full history so everyone is working from the same facts.

> 2. ... Wang Yuli had already alerted you in your v1. At that point, you
> had two options: a) abandon your own patches ... or b) thank Wang Yuli
> for the reminder and assistance, then seek to collaborate on
> development. However, you did neither

I did take option (b). Wang Yuli's v1 messages were code review, and I
thanked him on-list and folded every point into v2:

  https://lore.kernel.org/all/20260608103302.340456-1-dongtai.guo@linux.dev/

  "Thanks for the review -- all three points are addressed in v2. ...
   You were right that this had not been properly exercised before ..."

His "awM is dangerous, see how x86 did" comment in particular led
directly to the ANNOTATE_DATA_SPECIAL rework that is in the series now.
The review made these patches better and I'm grateful for it.

> 1. Wang Yuli released his version first; re-releasing it without any
> prior communication is simply rude.

On priority: this series is not a fork of Wang Yuli's. I have been
carrying LoongArch livepatch tooling since kpatch, which is klp-build's
predecessor (same maintainer, later folded into the kernel). My kpatch
LoongArch support was posted on 2024-12-05 and merged 2026-01-12:

  https://github.com/dynup/kpatch/pull/1427

developed over several review rounds with Joe Lawrence. When Josh
announced the kpatch -> klp-build transition, he listed the LoongArch
port as coming from me:

  https://github.com/dynup/kpatch/issues/1498
  ("loongarch ... shared by @georgejguo below, coming soon")

So this klp-build series is the continuation of my own earlier work,
not a takeover of someone else's.

On scope: Wang Yuli's own suggestion in v1 was to use his patch to
replace "these two patches" -- i.e. the basic arch-enablement piece.
This series is the objtool/klp-diff and build-tooling integration
(12 patches), including four fixes Joe found by running the full
klp-build flow end to end. The overlap is just the arch-enablement part.

> does that mean Wang Yuli can now throw yours in the trash when he
> releases his v2?

I don't see this as anyone's to throw away -- it's shared work toward
the same goal, and I'd much rather converge than duplicate. Concretely:
I'm happy to fold the overlapping arch-enablement patch in with Wang
Yuli as author (or Co-developed-by), and to work with him on the rest.

Wang Yuli, if you're up for it, let's coordinate -- I can take the
objtool/klp-diff pieces and we land one clean series together.

Thanks,
George
