Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0B2652A2
	for <live-patching@vger.kernel.org>; Thu,  5 Feb 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308712; cv=none; b=fM+99tCLLGk/4fMnsTWBkiYroA4E9kpgSI2I2suomVPFpY2Tj0pVlnyl4yO4iNoqrb6Cs2OEGLGVVN+b9Fhv/DrBSugXjGS/OX579QH9jCGwK+wkYQRpDLryyeoMQvugoV/y0L9zJbhx9S16utnA7xNBeTdCl/mANKkITviFQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308712; c=relaxed/simple;
	bh=gLaZz11/FyeA3cFwAdAA6peghHQdxNDZA/jbw4yGyqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/6Gw/RpDE5WlEB8KFrA0/Uqwl+9TXGJUt63w9ilUZ7iufx8G9gOEdZlt9Ipx2kfKKaIw/J3I7XApnNsvheohZ3WWUj+VV2xwBaRqGfM/tQXS9LZRbaWA6KLdQRN9+BcgTAVPd92FYvJbZ5pe2rP/5TrWXN9f/sb/tBY+OugZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBAaVVrv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBAaVVrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A48C4CEF7;
	Thu,  5 Feb 2026 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770308712;
	bh=gLaZz11/FyeA3cFwAdAA6peghHQdxNDZA/jbw4yGyqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBAaVVrvp5/z88kbCZXn0MJ9DaoDd/KdwacNdqyBeQSQTQXnYCF4A/SK+zO2jOA6A
	 23KfEUfpBZ9T3arfPyv0KuUnA0KsLT0mYn2Uj7wjJD5hSs+9YorGznMwAzGOq3iu9A
	 fFYILPD3WEuc8s65oTbwjSu3SQZP/fDmPx08pG+1CCpCJFpNG5s7I0+V3HXDiR7g2w
	 bTwRR+FF2fIFNxz3V8jPMzZKWUurC6HqwXeZjdxN9PyEy29Hnn9BC8u6vxvhLnE8UF
	 Xrh4OprNvm2bse0jqYyb66Jzubt7pCxfV3/j+qkgY8/74ppDqJ1BbRId2oKmK+cNKv
	 4Z/H4LZjZ9pnQ==
Date: Thu, 5 Feb 2026 08:25:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, kernel-team@meta.com, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com
Subject: Re: [PATCH] klp-build: Support clang/llvm built kernel
Message-ID: <gqqr3ulqbhecvev36ry7nlra3fysgltlpiv2lzsil7ewrwy7qx@dlp77z56npqc>
References: <20260129170321.700854-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129170321.700854-1-song@kernel.org>

On Thu, Jan 29, 2026 at 09:03:21AM -0800, Song Liu wrote:
> When the kernel is built with clang/llvm, it is expected to run make
> with "make LLVM=1 ...". The same is needed when building livepatches.
> 
> Use CONFIG_CC_IS_CLANG as the flag to detect kernel built with
> clang/llvm, and add LLVM=1 to make commands from klp-build
> 
> Signed-off-by: Song Liu <song@kernel.org>

Peter informed me that "LLVM=" has different syntaxes:

  LLVM=1
  LLVM=-22
  LLVM=/opt/llvm/

Debian has parallel llvm (and gcc) toolchains, and suffixes them with
-$ver.

So we dropped this patch for now.  "export LLVM=1" still works.  Not
sure if you have any other ideas?

At the very least we should probably check that LLVM=<whatever> and/or
CC=clang are set appropriately before doing a CONFIG_CC_IS_CLANG build,
and error out if not.

-- 
Josh
