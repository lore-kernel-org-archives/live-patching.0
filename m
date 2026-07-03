Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAE30E0D5;
	Fri,  3 Jul 2026 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783106783; cv=none; b=dOjRvtYNG0wttcu0eLlr0xp9dC5Lw8K//3XeevRi+ntQiIgTqRaJ1RVTGqWrshti9Tw+eMYVlcAWJZV4C5jnWuCcFCBLP5AnZ8hlC6HMyrXilECjCfDAnDV0QA8XyelQxBx6ishKkr2TxcZYELtOddcr3MJr//vuRrkFir6MZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783106783; c=relaxed/simple;
	bh=vUBLtEQosFUvLLWRnh1ekRucrHyIhERB8VpuLqSoZXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IigTlV1AtbGp/NiWFBpEaKHg8rIJogJ3wmzpZF2b6TxZeSuR4AumTzn1hwXrqSXKugvRu3j5024D856QHAIeguaG+8zRjun98jM4xAH1/9WDQV6TeNBTbA45ednu7wwQStvDFJdfcjcMQCk2O0U9fvcQz+La4FkgWWxK8LgXf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUPKlPeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUPKlPeG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 59E0B1F000E9;
	Fri,  3 Jul 2026 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783106781;
	bh=QvTI58QiC2TuqyjxFhnNcEQHA14b/JGfC7JQWcOKCHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PUPKlPeGZJ4YFSigsyPRrVVwSVkIgkIxuAXekGyjJKwVkvDkENbFrK1srabmrnIL9
	 XWKiCQcp9qix3kxN3Xsd6yBqtnuSScDbFFV1gaucDeJEovmhQdFvR8VEqAB24aV7ba
	 GTFmKN8NvWWMJwn3vcVrAf3yz2kz/Nqoh2mD76Wh2YXBvyG+//02BPhDBVwyJ82AZ6
	 fpNqCQFbbkjIxPVYB6pk1cyxeRbjJmVHWyICuHZWImt3Kn4gkz89GlXjedlZJkS/Y0
	 kALKxy0G2MYDoWlzLgKn5RbgD7W4nx7DrhFlswp5l64qf8DFzTeATsVoNJ9eFQ5R2T
	 mQQgKPIQs4m6w==
Date: Fri, 3 Jul 2026 21:25:30 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
	live-patching@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: Re: [PATCH] kbuild: unset sub_make_done before calling kselftest
 build system
Message-ID: <akgMqqdj3aLWoZPO@levanger>
Mail-Followup-To: Petr Mladek <pmladek@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
	live-patching@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Zelin Deng <zelin.deng@linux.alibaba.com>
References: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
 <akdx6xWTuv5Ga0YY@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akdx6xWTuv5Ga0YY@pathway.suse.cz>

On Fri, Jul 03, 2026 at 10:25:15AM +0200, Petr Mladek wrote:
[...]
> 
> PS: I could take this via livepatching tree. But feel free to take it
>     via kbuild tree. I am going to wait few days until the discussion
>     settles down.

Yes, take it via livepatching tree, thanks!

Kind regards,
Nicolas
