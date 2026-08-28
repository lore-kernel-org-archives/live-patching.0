Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93822FF641
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877064; cv=none; b=DyRukG0K0/a9lEy1AnlKWhiH6p4S6V2EZu67uDVj27LmRnrypSUBSS37D50IeCib10Q3U3x/xAVTnLHJkslpU1vvL34PQuRzeRMHtUodH45fAi9jBMg+gWZN/j2QHMjOasDMDK5/NdlCm9Xi4Sq6M2UJI4b6w5rbTJkM15YKL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877064; c=relaxed/simple;
	bh=oA8sAaa/jH2R/w3faL78TjLNauUiN5YfoM8pTI6SLG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDOtFYdjHgPkbQjbbDTlAcTjMcrunTqVuZGw2SpHj641ogRXWkIGBPrftHTychEqsX3RLg1jfPTicNfPc4Nea1oUbIVlhhX4xLVKHEAYg8rbHLavApskoWsDYmrO0kunByI+oqcg7HTFf1kYlU/XjSkuJMQ7GTT8cBxEV36/Y8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ5hXzKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ5hXzKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BB01F000E9;
	Fri, 28 Aug 2026 00:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787877063;
	bh=unJCwCv6aT4wKksfMJXQ6zefLmTy/GHaDQqqj5GJg90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZ5hXzKRVIBRe3FVsHcEdGg2M5rtOwLeIMaQMu+7Smy0IMuPcGz52SVey207ks4h0
	 bPYnMUi95JBqYKWmQngO+aAaYdlgz0YtAQ9e1C8ve8euxjmi13iJlMzcMUGpnoxw0z
	 9TcpVC/bYKKX8gOWMAq2SuGJCXcX4q2CjmDQV4XrQeK0JNm+x2S7xEa5sff+Ec4a9b
	 cPZmrH3o8UG0pRsq58/wcISxgwQm9ZlX+chRgKBcSVgWLltWTIA3YZd9a70ECYtTVQ
	 +Vr5dV41CCQzd2fCw7sAsBcQ6BzSaCSu38rRWOYSXhXfscmxXipTLqSNHtObsM0o4O
	 D9ph5cO5bB//w==
Date: Thu, 27 Aug 2026 17:31:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 5/8] selftests/livepatch: Adapt atomic
 replace tests to provides/obsoletes
Message-ID: <apDWrUoBBc5RLjK6@jpoimboe>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-6-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-6-laoar.shao@gmail.com>

On Tue, Aug 25, 2026 at 07:46:38PM +0800, Yafang Shao wrote:
> The legacy "replace" field in struct klp_patch was replaced by the
> provides/obsoletes mechanism. As a result, the atomic replace
> selftests fail to build against kernels that only support
> provides/obsoletes.

Then wouldn't the test failure be working as designed?

-- 
Josh
