Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492847FB1C;
	Mon, 14 Sep 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415760; cv=none; b=gj8aIb8Y96hLFFJGvuOj0/paSXKlRSD9fzK7BOORr2zft4SdJbYwt6A7QjbW3ihAGltKzi48bifFrU1MGUCjXlUyYiRX8l8zHSmikRw5QiBQwdfwYXggKuvLtd4z/pAfxQNxO9gLAOpJChudo19EK37tuEqwpZ6N7vP1ei4u8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415760; c=relaxed/simple;
	bh=e9cyYIx1SSiY1QqfENk7IAjubYdiB9lSrDyppNfPr10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay78uApuFWFZivYWZ0F1vxtdnONr6tc1pTgVFKZ0LMeWvYZzUTEPuwOmtyvB18tH4kULApKy4GeMb78kHECYZBP9CTUKAyhk3Sewws5BiFzr2ADFbInTq4GBj8AG1JdgR/xwDO0Y6lgq8boHvLcaULVvaOp64WxY/E6zw9H4cXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt0Qchuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt0Qchuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C071F00893;
	Mon, 14 Sep 2026 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789415758;
	bh=3nOavNcgJHeCM+sFQDM1RISxIzblWm9N/B8XER02QDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lt0QchuwIgLqMGWqbkUNvk/FdQi+P8KAdeNf0ExZhIOWdyOy7TLY6SZrI/X33sImG
	 yaJeQk1a3zfG1VzzfuhWGGc7AGN7sopkxClw/UZHn8nEdMEz+p0R3j7qjJXasPFvSI
	 YtnS95T0NTBNsU1sZYDqRh9KpLWmeT3QIxspOlwdowga0OQ4lcnGeRxGAi2alDF+uM
	 ravmn1pypsKThDxjWogyOV5GKgzJSN1im7/Exzw9U5JWVppoj91MfqSuo59bCvHCm8
	 Q7l5kLQM/CWfSv4+/u9s4Yn1vGqe62N/0Jui+Wddp+Al17V3/AtQ/siQWx4oL3h9ZF
	 ustqJy/u8UN9w==
Date: Mon, 14 Sep 2026 12:55:56 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, song@kernel.org, jikos@kernel.org, 
	pmladek@suse.com, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool/klp: Fix missed changes to same-named symbol
 references
Message-ID: <aqhQl64XvK0V2aJT@jpoimboe>
References: <20260910085218.66565-1-luolongjuna@gmail.com>
 <aqc5Q4_9bHpAI4jh@jpoimboe>
 <CAKL4jwV8ZxAzkZ-0LWP9jzWvfw5-EKFS7LPKiibp5McY4Yubng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKL4jwV8ZxAzkZ-0LWP9jzWvfw5-EKFS7LPKiibp5McY4Yubng@mail.gmail.com>

On Mon, Sep 14, 2026 at 08:12:33PM +0800, Longjun Luo wrote:
> Hi Josh,
> 
> > These seem like unusual edge cases, is this problem theoretical or was
> > it a real-world bug?
> 
> These are constructed reproducers, not production failures. We have
> been working on userspace livepatching, including symbol correlation
> under LTO. I built and tested these cases while comparing klp-build
> and kpatch-build.
> 
> > If the .patch upgrades a function from static to global then the
> > function no longer has a FILE associated with it.  Then with the above,
> > all callers to that function would be marked as changed.  And note that
> > LTO does a lot of that, so static-to-global and global-to-static changes
> > are common between orig and patched objects.
> 
> I confirmed locally that kernel LTO can change a function's binding
> without changing its name.
> 
> For context, in our userspace ThinLTO tests, promoted locals usually
> acquired a .llvm.<hash> suffix. The kernel's ThinLTO build uses
> -always-rename-promoted-locals=false when supported by the toolchain,
> so promotion need not add that suffix.
> 
> I agree that this FILE-based checksum change is too restrictive.
> Please drop this patch.
> 
> You are right that patch authors need to verify the changed-function
> list. However, in these cases the current checksums do not distinguish
> the old and new targets, and no diagnostic points to the missed change.
> That could make a resulting problem difficult and time-consuming to
> diagnose. Would it be useful to document these cases as a known
> limitation?

Yes, and in fact we need a "patch author guide" for humans/LLMs to read
when using klp-build, as there are pitfalls to watch out for.

Something similar to what kpatch has...

  https://github.com/dynup/kpatch/blob/master/doc/patch-author-guide.md

in case anybody wants to try porting that over.

-- 
Josh
