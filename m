Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B5441048;
	Tue, 28 Apr 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391826; cv=none; b=Sf+kXbhs26ymPxJEP+ZZAMTBQTY9vO+meSuq/mkGWspXk2Dbl1FtT0GvosWdpecnZQk/CiSvLbgPPVWCU2lwJ+7jzgg9Nc3SkJ1x86hxqdR7WKVzFqBPp4blP8NIG/kpNP27x80iTTuTVB07LgNK9ZlK5rF0yD8L3hZB2DbYdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391826; c=relaxed/simple;
	bh=IIZQQe80fo0Si1JwtHMDkfM2py8bX5Pngag0IU46ZsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqr1zoiSVWz303OtK8GBp4WiRwiolgoRLCfkDeWyWYJWjWe6ITEpyYck8Xak4POM7dXI0b+LPO6xtxshNsLLs7LYJIBfeEb73RXjMqsQueaRKJlGCQ98vUjzNzkJ0pzd3eNfXbQVDRtjmv2QI2yeMTcmyxzpVzK4cp9gtO66wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0oIMP7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0oIMP7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB886C2BCFB;
	Tue, 28 Apr 2026 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777391825;
	bh=IIZQQe80fo0Si1JwtHMDkfM2py8bX5Pngag0IU46ZsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0oIMP7Dr0Lzpqc+Tm0cpPG9S89k1AoNIVEmZLQLRJbg+GrtRncqQnwLo3E29+Xab
	 EQEz5fZhbEwwI4FytR/2p0zjsa652LY5gXtoX2fGbWffc5AfxCNNafD52tZIIpcMGc
	 GSVhctBTfzzam836lXxDh2+eRVRbibHQfPTqqt9uMOYDoD703a0HGIddGwcfTqKS0x
	 ZDWeO9e3s/d8GkwIkvhyYoC6T9/zU822V+GUXCejttrCsx4q+5hDcn2HTgC+Pc4dty
	 fqqCVJHcHSfXLZjF6A/9ROBmOmGjtjKtjZbDLd1o1l+q/Yo0XANc1yyRs8KpC2S0Jh
	 0kDtp+nuGXL1Q==
Date: Tue, 28 Apr 2026 08:57:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 18/48] klp-build: Fix hang on out-of-date .config
Message-ID: <5h664rns5es27okhx4upvisok5mvzwjfdcqlrpce5iie23fz55@n4n4vay7rhpe>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <1b3add71a35ff83fc9653c2c872b811cfd5629a3.1776916871.git.jpoimboe@kernel.org>
 <CAPhsuW7c44JzDX8Q6PgYAeigSFWTuEnuvgG88ABDdMNmPY6Oiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7c44JzDX8Q6PgYAeigSFWTuEnuvgG88ABDdMNmPY6Oiw@mail.gmail.com>

On Fri, Apr 24, 2026 at 02:51:54PM -0700, Song Liu wrote:
> On Wed, Apr 22, 2026 at 9:04 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > If .config is out of date with the kernel source, 'make syncconfig'
> > hangs while waiting for user input on new config options.  Detect the
> > mismatch and return an error.
> >
> > Fixes: 6f93f7b06810 ("livepatch/klp-build: Fix inconsistent kernel version")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  scripts/livepatch/klp-build | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> > index 0ad7e6631314..81b35fc10877 100755
> > --- a/scripts/livepatch/klp-build
> > +++ b/scripts/livepatch/klp-build
> > @@ -306,7 +306,12 @@ set_kernelversion() {
> >
> >         stash_file "$file"
> >
> > -       kernelrelease="$(cd "$SRC" && make syncconfig &>/dev/null && make -s kernelrelease)"
> > +       if [[ -n "$(make -s listnewconfig 2>/dev/null)" ]]; then
> > +               die ".config mismatch, check your .config or run 'make olddefconfig'"
> > +       fi
> > +       make syncconfig &>/dev/null || die "make syncconfig failed"
> > +
> > +       kernelrelease="$(cd "$SRC" && make -s kernelrelease)"
> 
> Do we really need cd "$SRC" here? If so, we need it before
> all the make commands, right?

Yeah, the "$SRC" thing is a half-hearted implementation throughout, with
the idea of eventually having the sourcedir outside of $PWD, and/or
building the object files in a separate directory.  That's confusing,
I'll just strip all that out for now.

-- 
Josh
