Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16A4B04B6;
	Sun, 16 Aug 2026 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786905971; cv=none; b=pmxfKdrOJFBXRrswW2fnRPgHyCsOzOws3aKZf2ccgDzFqe+UtR0YArRYG1PQDMv7NA1BHYo2uNyehFF3hRRoashf1gO9PRA0fvFa/fJvrQ8S2pwfGaGdtIjZF8ZQ7oQSc4oFKBs6QAk+xq5GyhVUtJklD6vbNt8r5IabWOX8Rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786905971; c=relaxed/simple;
	bh=z97u4P6fMg4WYWCj2E9yLrZuOWX5EPMreMcpkl6Fd64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdkIZO/BcmmFz2vxlEE0gLTcfYusVKgdXJksHetCn2or/VPWy1v0xlcqSRNfQwCfehw8QfTJqLbHO8KAqPNelk0j//QjoDAX+L/NYNG2b7wG6EV9EFoAdNgNYPKnTph+kq+iImarIiCQdpORRPR2p5fsOmhCVAVqLHSY8wsQjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw7BTpZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw7BTpZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BD11F000E9;
	Sun, 16 Aug 2026 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786905969;
	bh=PcoLOjKDDmtqunMNkfYSl4zpIl64RrwdwteFQlSWVFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zw7BTpZmuiy+my5vtssZbG0M38DjXtf6TC3kamgJyxovcW6Gw9UrhvmEDLapVZ2Th
	 O/Iv8DatLXwk/Q23uSqloyfwHpcylEeylj17Dwedp24cLhjqUGEX+iTXVrR927URi/
	 YYySQ9hbmqgb174wGyQD+XnaxWY/FbqB7eeKdLeZ4b1S26ki+egjIxkfJfosbmHS4F
	 inpAPonbupAdpp01TfVe2vpxwq7pvBL1gySNCuZqpVy+4WpjK74qYD3z8TaWCQqWzr
	 Ggb442NWOLgFkSDoWkj3n0QteNXmp9QohLKmFB5oduX5KKw28DiB8doLEMBAz9NSjI
	 BjQ7Mr31Rp+AQ==
Date: Sun, 16 Aug 2026 11:46:07 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 02/12] arm64/module: Fix BTI exceptions caused by omitted
 landing pads in Clang 21
Message-ID: <aoIEVL0M2QPNIOO3@jpoimboe>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
 <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>
 <aoGFxycNrA0p-H4T@willie-the-truck>
 <6c7153d7-67d1-46ce-afb0-688fca871c66@app.fastmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c7153d7-67d1-46ce-afb0-688fca871c66@app.fastmail.com>

On Sun, Aug 16, 2026 at 04:49:59PM +0300, Ard Biesheuvel wrote:
> On Sun, 16 Aug 2026, at 12:41, Will Deacon wrote:
> > Overall, it seems to me like there are three cases we need to consider
> > for re-enabling BTI in the kernel:
> >
> > 1. A cross-section call that spans beyond the 128M range and therefore
> >    needs a veneer. I think the static linker should resolve this, probably
> >    by emitting a second veneer with the landing pad. Do we know if LLD
> >    gets this right?
> >
> 
> There are two variants here:
> 
> A cross-section call .init.text to .text that spans beyond the 128M range:
> 
> 1a. inside vmlinux, which should be dealt with by the linker, but which might
> be unreliable in practice due to the lack of BTI annotations in asm files,
> missing exec permissions on ELF sections etc. This is addressed by this series,
> but is only an issue for unusually large kernel images (e.g., allyesconfig).

Right, and if we don't care about the >128MB kernel case (I have no idea
if anybody actually uses that big of a kernel?), then we can basically
just drop patches 3-11 in favor of a simple linker assertion (similar to
patches 5 and 6) which just *always* triggers a build error on a large
kernel + BTI + !COMPILE_TEST.

-- 
Josh
