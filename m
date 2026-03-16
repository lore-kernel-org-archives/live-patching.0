Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FF3DBD60;
	Mon, 16 Mar 2026 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688531; cv=none; b=FZgeIOFri3eO1ZAOQPiscQjXhZiOGpl935rGn4BhBhiDzCpvnIOKipShaJMzNo67J/NCArKni9hDyaSnkKOzORTKt492MGAz+icZrM8Yvf5eBAonCasbHqmhTLUFKHXbMnxvipC/vttsUrhfMBW01Q3qelTJa7wVEyJYYbBWGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688531; c=relaxed/simple;
	bh=8Xrt7tVqPzJTL2IdyswvMZ2hYvzOD/82Zlg0vgQjhus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRsqZyMt15KUQzAhEpAnpiXdhKT75tJajOSEK/sGIQdVxwO7VtnBaOIJ2uLUkAefBfz++2ETHED0Z9byIe/wBqU74o4+NIXrYPq4WYRwLiwJAlnyOpyhhZTkGdW1Smc9woGG4IKCrag3wu72Op4Ph/LjfD6F/Bf/5kFZOt6NwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEAcfQqk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEAcfQqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E44C19421;
	Mon, 16 Mar 2026 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688531;
	bh=8Xrt7tVqPzJTL2IdyswvMZ2hYvzOD/82Zlg0vgQjhus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEAcfQqkUNP7PTtEPOfPAmDzWZY+CEl+lOzezRk74cf3r+aAllQXMYju3Lgmks4PT
	 f90C1QqyQxRpytNtrbSPtMOlUhLj/PNE6mb6iLrRvb+TOvRphLedoUD0tZdAfyc60D
	 bKoeDYxxJoI9q9ENaKnkg7mhfKJ9886cNISAzSa4k6Xk++gvwmoSnDbO6bsiDvgACk
	 2qFYzBZXNlKbbcK/tpz4deOYGX5f2CGcQWeqlOWxL7JHwyRr2hFhHEH/OeBaqQ/xSA
	 WAo9YK3vrgqWtB5jredQFPz5PvsUQHWvM6ufJQgC0WhR4vkTBoVvLSYg+ecTc8YQ0/
	 kJ0VQ83KgcKdA==
Date: Mon, 16 Mar 2026 12:15:28 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 14/14] klp-build: Support cross-compilation
Message-ID: <xzezfjfb5uttvmg2divzk3toym3qqvkh5c4w2enamsrku342m3@bogfmdj65wql>
References: <cover.1772681234.git.jpoimboe@kernel.org>
 <697c09ca0a8ffd545aa875e507502f62ad983419.1772681234.git.jpoimboe@kernel.org>
 <CAPhsuW6Cyw_z+9sWt5G1XOp94z8BbwNmsoVE9=iM8WQfkuNDBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6Cyw_z+9sWt5G1XOp94z8BbwNmsoVE9=iM8WQfkuNDBA@mail.gmail.com>

On Wed, Mar 11, 2026 at 04:18:40PM -0700, Song Liu wrote:
> On Wed, Mar 4, 2026 at 7:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > Add support for cross-compilation.  The user must export ARCH, and
> > either CROSS_COMPILE or LLVM.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  scripts/livepatch/klp-build | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> > index 809e198a561d..b6c057e2120f 100755
> > --- a/scripts/livepatch/klp-build
> > +++ b/scripts/livepatch/klp-build
> > @@ -404,6 +404,14 @@ validate_patches() {
> >         revert_patches
> >  }
> >
> > +cross_compile_init() {
> > +       if [[ -v LLVM ]]; then
> > +               OBJCOPY=llvm-objcopy
> > +       else
> > +               OBJCOPY="${CROSS_COMPILE:-}objcopy"
> > +       fi
> > +}
> 
> Shall we show a specific warning if
>   - ARCH is set; and
>   - ARCH is not the same as (uname -m); and
>   - neither LLVM nor CROSS_COMPILE is set.

Yeah, I think that would be a good idea.  Will do that for v2.

-- 
Josh
