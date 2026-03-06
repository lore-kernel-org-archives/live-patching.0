Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC6211A05;
	Fri,  6 Mar 2026 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830633; cv=none; b=AV3A7nn5ThssaxDAsJeJJzPqCDgwLyDcBFG8mk5wMrTiGpTqOLICWvSjYfaAjv+jAtn6noNTPNSkrzTPxhCwoFg1XMJz5p6Ac92ZCI+88mlFBeB9YhxzkpeJn7JqtqjUJUxMlBGDBl53mo0iQzSYYC3mBL77vNwJq/YIRFa5xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830633; c=relaxed/simple;
	bh=RdjI2Ia0Uxf2HWNUJAXBFhqIKRg+Kl4I9cmmtTpdTF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzhQP0BeCeKMUVIDGWKKdPqAfy4qRWQRX1E+5IeQ2vd7KzatCVG7rN9GoOFDVYxIn8/jeMptOWGw2ifE45NgOaqCyMErqDr30763d3OQCGYk4oo/dGRv5vurDlyFfF8avNyNeP6IlKgQOhfI28nR/a27BeyVPw3KjGEup79qf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYSNBfxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYSNBfxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84300C4CEF7;
	Fri,  6 Mar 2026 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772830633;
	bh=RdjI2Ia0Uxf2HWNUJAXBFhqIKRg+Kl4I9cmmtTpdTF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYSNBfxoH8hypowOvtfJ43Xi397OLTCnjCh/2optjUmG9DTBbHi7vaqvN5oUoxTBP
	 F6meOglPuVHKVKfAHNDRldYITUW6mveSkaHKxDouT5hBVRWWhKex8C9GCGldrS5q6P
	 xJjwz2+J0HDX4ksUqwdVmkbBiLjpISPB/Hx37u3QgfJbE3vwUeLKceIMo6YjVon8sz
	 EohYViFWCB63XeLamG7KV/+I5jbLUlWn04CmYYdtddqsO/saXKTIsEc1VSeB3j06yU
	 AIaL2+AiErukLu7/kYCzOZzT0Bp1DpZiTRndPy4pF5PYmvvBaNv+zs5hYBLjGfbloc
	 7meFZpnl/4shQ==
Date: Fri, 6 Mar 2026 12:57:10 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org, 
	kernel-team@fb.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Song Liu <song@kernel.org>
Subject: Re: [PATCH kbuild] kbuild: Allow to reduce the number of suffixes
 for clang thin-lto build
Message-ID: <lmj53l5djuipucmuxwr563n6ty7hobduzg4vvy4pjnw4yz5t56@he3wiioegzhy>
References: <20260306034325.3605301-1-yonghong.song@linux.dev>
 <pat2b5nibiik6nua6ls7cu7eqy5qgrugo4gnel32bz6vpcrmz3@f7ynsbvnxcaj>
 <f1afe1e8-0dfd-47b0-8ca4-f09d4fda13eb@linux.dev>
 <bt7t2452h27o7bf27f7ljs2xhn7venhvslynq3a77jbtwi7hqk@cgobhbhi5y2r>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bt7t2452h27o7bf27f7ljs2xhn7venhvslynq3a77jbtwi7hqk@cgobhbhi5y2r>

On Fri, Mar 06, 2026 at 12:55:02PM -0800, Josh Poimboeuf wrote:
> On Fri, Mar 06, 2026 at 11:40:21AM -0800, Yonghong Song wrote:
> > > Thanks!  Would there be any downsides to enabling this feature
> > > unconditionally in the kernel when the compiler supports it?
> > 
> > The only downside is for the following case:
> > 
> > C   file: static function foo()
> > Asm file: global function foo()
> > 
> > The thin-lto will collect all C files and with the above llvm patch,
> > the static function foo() may be promoted to global function foo()
> > if there is no other pre-existing global function foo() in all C files.
> > 
> > In such cases, there will be a conflict since
> > there are two global function foo() (one from C file, another from Asm file).
> > In such cases, the build will fail.
> > 
> > How do you think we could hit such issues in linux kernel?
> > Maybe should have default no for the new config?
> > 
> > I think the chance should be very low. The following is a grab for x86
> > for global symbols in asm code:
> > 
> > [~/work/others/linux/arch/x86 (master)]$ egrep -r globl
> 
> There are actually quite a bit more than that, see SYM_CODE_START:
> 
>   $ git grep 'SYM_CODE_START(' |wc -l
>   169
> 
> But still, I agree the chance of a conflict would be very low.  And
> global assembly functions tend to be rather uniquely named.
> 
> > Maybe we could collect all global symbols in asm codes before lld,
> > and then we add an option in lld to feed those global symbols (with a file?),
> > then we can be sure there won't be any conflict?
> 
> That wouldn't be worth the effort in my opinion.
> 
> I think we should just unconditionally enable
> -always-rename-promoted-locals=false when it's available.  While that
> will implicitly enforce that global asm functions be uniquely named
> across the tree, I don't see that as a problem.  In the rare case of a
> conflict, we can just rename the function.

BTW, reading this again I realize that this would affect not only global
asm *functions*, but also global asm *data*.  But asm global data is
quite rare and also tends to be uniquely named, so my conclusion is the
same.

-- 
Josh
