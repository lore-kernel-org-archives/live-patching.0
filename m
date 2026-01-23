Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AC86329;
	Fri, 23 Jan 2026 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190604; cv=none; b=TB7VRs3TL3U3o2k4kh8/jw+PiZs3e0cVj0nuLr7MWsuYNYab6bnet/h19dgFsBPcQGzCM6mwA5u/+gCdV1AGO36sN+Sv8+1xKiifscgtLR4NY1nMmiKNa0NxhMe7JYHkHokGvmwUj9raxsOUCQ9R3LJrfOavVoq7iSKfx4D/5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190604; c=relaxed/simple;
	bh=QR+gFgj7mXHGYDTqe/WjnMp/eyjf+BLKshDboxU3pRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/h8HHmN/UwOGVA0LBRHvl4tSrdFnkczqbXkY27KFj4Wjz8C4S/UeK5g3Qm/a6YsPsnTFpbEabfhhB1Xy0hoUGr1bS7p0aojAEE+3eAFobsqRTT7emlbRIu+TTjiwQYNADk1Ki2FBIcU3egJbJzlSnw7W5XjPmVl2pz0M8SAxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir37Fktn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir37Fktn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147E9C19421;
	Fri, 23 Jan 2026 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190604;
	bh=QR+gFgj7mXHGYDTqe/WjnMp/eyjf+BLKshDboxU3pRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ir37FktnhxF/m7o/FYai63DbeO0lUeHvCrWuMbeXDvrFrtO4Nfma4YCuJVE5qG4Bi
	 fWxzhxHuC35/YmxttjA+JJfgMYE4srBNyeNkmFPi5jK4IDQA+hlKUzfVuhltAuN82/
	 kI6SkT6CF69JDRzpxBtCos+DozGeO0p9bgdlky3j6slcSU9br2hQHoy5RXPkAgFEu4
	 9ABAeoFiCCTw9hLZEO+RXc6BnskJEbL0M231bTWrOtC+N2eIN2Y9NpI1BLxRDS72Aj
	 mhW6HX6IyCTyqRqvYNVqX51EqQuSTThSKP4mlJ5aTTr1QX9LasqbTbFm/1+CYNd7kI
	 p/GwORaQ6XjAQ==
Date: Fri, 23 Jan 2026 09:50:02 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Peter Zijlstra <peterz@infradead.org>, live-patching@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Improve handling of the __klp_{objects,funcs}
 sections in modules
Message-ID: <uiodnd33mmm5xkd2czcfatqjen2wehfyfrwjoj3ysvhha2medv@cnft7tc7qo7n>
References: <20260123102825.3521961-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123102825.3521961-1-petr.pavlu@suse.com>

On Fri, Jan 23, 2026 at 11:26:55AM +0100, Petr Pavlu wrote:
> Changes since v2 [1]:
> - Generalize the helper function that locates __klp_objects in a module
>   to allow it to find any data in other sections as well.
> 
> Changes since v1 [2]:
> - Generalize the helper function that locates __klp_objects in a module
>   to allow it to find objects in other sections as well.
> 
> [1] https://lore.kernel.org/linux-modules/20260121082842.3050453-1-petr.pavlu@suse.com/
> [2] https://lore.kernel.org/linux-modules/20260114123056.2045816-1-petr.pavlu@suse.com/
> 
> Petr Pavlu (2):
>   livepatch: Fix having __klp_objects relics in non-livepatch modules
>   livepatch: Free klp_{object,func}_ext data after initialization

Thanks!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
