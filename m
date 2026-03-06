Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C83115AF
	for <live-patching@vger.kernel.org>; Fri,  6 Mar 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813367; cv=none; b=u0CKxsT1iMlvx46rjDeHbWu/O9ljkZmn78hwIc8NIjDOzFHkijPEK1tzmNrq/8VQMWxcnR4+mA8dFCTT2tmyR+7fYC/kaTOINGAiecd44pqJEFCm08EenkwJLu9E0qGw/AJLzl7012tMK3602KB/ZuDakz6sAvjFOwba/IXXqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813367; c=relaxed/simple;
	bh=jkJMgauDX1t19dAN3PhNCeHQj3PQivjP8ilh4ArcwfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC824O650Clq76Sb9s5szDEQSLeup4RS+D00wpc6IaEl5or5K90Z4gT+c324SRToURtOcubXrSGlLMsHMOaiaS6iifMnWiPIh2PH5dfJIz4MlI5ME9zYe/UuCAVlTLHkGF1QN6jOeDAua99Ixv46hvPemBOoQqsHPB8MKFasC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5/i+Yro; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5/i+Yro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F417CC4CEF7;
	Fri,  6 Mar 2026 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772813367;
	bh=jkJMgauDX1t19dAN3PhNCeHQj3PQivjP8ilh4ArcwfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5/i+YrotTWDUZo4o2gHMgDzg28xIvoKCXP8F4eIlDOjU3Jajm2vnlC9G+xlD2XRt
	 RhvLonJvIfZjsz1Ekwlnxc0MgLY/jT5PhduK5aheSyEmcto7k+RDJ1BhaCJymp/h5P
	 cVf9qCN2KK2rDH15Eydxko2cghQ7p0A3ajLGqVlVV480wPk0+j9htsxG0ANceRoOJH
	 B6sMkTcM6inY7+xMIt89bDph53bTrc1uLr/cAKmkAUrrMJEV3PIGlnvbTz0xzcBZQR
	 mR3KYbPmTRZykhmBuEPjhXCf5CNM6m8FGWkuoUSxZsqy8VI4x5vFFZgNtgVOE4256b
	 i9pzVNCKFfAEA==
Date: Fri, 6 Mar 2026 08:09:25 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH v4 0/7] objtool/klp: klp-build LTO support
Message-ID: <kgfsbith6oibrvgytcnncg2zyrxfa6wc3ltpqulyrk2633oetp@wrkqqifhesxn>
References: <20260305231531.3847295-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305231531.3847295-1-song@kernel.org>

On Thu, Mar 05, 2026 at 03:15:24PM -0800, Song Liu wrote:
> Add support for LTO in klp-build toolchain. The key changes are to the
> symbol correlation logic.Basically, we want to:
> 
> 1. Match symbols with differerent .llvm.<hash> suffixes, e.g., foo.llvm.123
>    to foo.llvm.456.
> 2. Match local symbols with promoted global symbols, e.g., local foo
>    with global foo.llvm.123.
> 
> 1/7 and 2/7 are small cleanup/fix for existing code.
> 3/7 through 7/7 contains the core logic changes to correlate_symbols().
> 
> Changes v3 => v4:
> 1. Minor fixes in patches 1, 3, 7.
> 2. Only keep patches 1-7 for now, as there is ongoing discussion about the
>    test infrastructure.
> 
> Changes v2 => v3:
> 1. Fix a bug in global => local correlations (patch 7/8).
> 2. Remove a WARN().
> 3. Some empty line changes.
> 
> Changes v1 => v2:
> 1. Error out on ambiguous .llvm.<hash>
> 
> Song Liu (7):
>   objtool/klp: Remove redundant strcmp() in correlate_symbols()
>   objtool/klp: Remove trailing '_' in demangle_name()
>   objtool/klp: Use sym->demangled_name for symbol_name hash
>   objtool/klp: Also demangle global objects
>   objtool/klp: Remove .llvm suffix in demangle_name()
>   objtool/klp: Match symbols based on demangled_name for global
>     variables
>   objtool/klp: Correlate locals to globals
> 
>  tools/objtool/elf.c                 | 95 ++++++++++++++++++++++-------
>  tools/objtool/include/objtool/elf.h |  3 +
>  tools/objtool/klp-diff.c            | 89 ++++++++++++++++++++++++++-
>  3 files changed, 165 insertions(+), 22 deletions(-)

Thanks!  I will go ahead and queue these up.

-- 
Josh
