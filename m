Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F219184
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789264432; cv=none; b=WO9UIx4I4rL570cdtCUmtM2A2Otasl5jLEbUiQ5UdNhlTwYVo1QwPWC7gXIA5RUXdrIsma0QJ3wMnrv+Toex11ymCUmWP1o3+tcVvys04XAv/UCrPZ2L64+wvLN3beE3sKFjuvpV2lVu4ezzX2hvD9lxiUDlM5koulOIlMLCv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789264432; c=relaxed/simple;
	bh=qIXM+k1Ot2VA0GgzdQJRAHeAyBkmr2w7EqsmJNkydhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwkVsejNm6DXlu+1hF7B2KSTLKK7QE7J7wzE3RoECIzjLAsxm0z4H84kmSG2Io4HlBDjhKQeNbNJbMO1VauOd9USHfLYKdT2wezMecUiNhm9Zyo+0Nypz8fklNAv32tdmyYm91j1ZOh0lqwYkn5p02pNRl9m73DgU5aeMIpyf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLMfI6i4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLMfI6i4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D011F000FF;
	Sun, 13 Sep 2026 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789264431;
	bh=BXAyHO5MQrV6G5GKidDC5100bep6B1s6rvwTg5OCZMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TLMfI6i4tQXl0J7YhViZeMFPBTNlQWtNiVmm8WY4znRpm66/xs3QS8buUzhcTtE5K
	 CQ7FdRhhMacG3VBZZAKopRMuRdFu7nEpy8reO7ucPryueObX5jxYoyZHotx7vaNw8o
	 1g3CEn44xH/wWoCVo2z54aMosJ31P21dnJKVkYO2zGYPgzF6tsOgQONu2hl1l9kuqL
	 WVc5VJSU1bGJqZuYbBbOe3s6EfFnkuScCja4xwrdtnrniWxil5d1LNRUpJXDfyMF8v
	 EUi/vs7X0cMphhfpMYvT5zawpZgqF0HBil5CIotU1PBvYhvJfSpHsOloQQqxLbEGvO
	 S4V43l0LRZlCw==
Date: Sat, 12 Sep 2026 18:53:46 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, peterz@infradead.org, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, puranjay@kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 00/58] Unit test framework for klp-build toolchain
Message-ID: <aqYAzefDqLFDALLg@jpoimboe>
References: <20260911184305.1457308-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>

On Fri, Sep 11, 2026 at 11:42:07AM -0700, Song Liu wrote:
> This is the unit test part of a test framework for the klp-build toolchain.
> The other part of the test framework will be some integration tests,
> similar to an earlier propose [1].
> 
> This is joint work by Puranjay Mohan, Joe Lawrence, and myself (Song Liu).
> Note that, while only two patches here are under Joe's authorship, his
> contribution to this set is much bigger than the number represents. A lot
> of these tests are based on Joe's earlier work in this area [2].
> 
> As the Assisted-by tags show, a lot of the work here is done with assists
> of AI. We actually designed the framework to so that we expect AI to write
> these tests in the future. AI also contributed in the design of the test
> framework. However, we (human) carefully reviewed the test framework. Also,
> this cover letter is 100% written by a human being (Song Liu).
> 
> Here are some key design choices we made for this unit tests framework:
> 
> 1. We do not need different unit test here for different kernel CONFIG_*
>    options. Instead, the tests cover different CONFIG_* options by passing
>    different arguments to the compiler and objtool.
> 
> 2. The test is NOT designed to be backward compatible. Similar to objtool
>    itself, the unit tests are delivered with the kernel tree. The user of
>    these tests should test the objtool with the unit tests in the same
>    branch. Once this test framework lands, future changes and fixes to the
>    objtool klp command should land with unit tests that cover the changes.
> 
> 3. It is possible to run these tests on a different architecture with
>    proper cross compilers. However, for automated CI, we are planning to
>    focus on native tests. Please refer to "Future work" section below for
>    more information about the CI.
> 
> 4. AI will help write tests. We found AI is very cable to write good tests.
>    tools/objtool/Documentation/klp-write-tests.txt is added for AI to read,
>    so that AI can write tests for this test framework.
> 
> Future work
> 1. The integration test simiar to [1]. Unlike the unit tests, the
>    integration tests will need separate runs to cover different kernel
>    CONFIG_* combinations.
> 
> 2. CI. The plan is to build a lore => patchwork => GitHub CI framework.
>    This is the model used by subsystems such as netdev, bpf, and risc-v.
>    We also have some ideas on "who will pay for the CI" issue, but I would
>    rather not promise anything yet.
> 
> 3. More tests.
> 
> Thanks,
> Song
> 
> 
> [1] https://lore.kernel.org/live-patching/20260226005436.379303-9-song@kernel.org/
> [2] https://github.com/joe-lawrence/klp-build-unit-tests

Thank y'all for doing this, this is really nice, and very much needed!

I would like to merge these soon, once the sashiko comments are
addressed.

-- 
Josh
