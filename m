Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736D40DFCA;
	Thu, 19 Mar 2026 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893609; cv=none; b=oiZUjznBKYw5yn2Do0Mw3TVzKz/TNrYVVFVi0gD7cbm5Yc+RC3JzSA6SOXOLWbtUA1OZ1CvDCE4T9uQDy6yH0IP9R2eyjE7PkXy6IZQmynZG2POJ0estuf2l/f6VLZSDcE2uTUUuRG977e7fJ/CzgLvj2P2QYap6fACfBVI6jac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893609; c=relaxed/simple;
	bh=Vl02CNpdjoEsmufTyLMcaK5uWzOZoAztEvYnENBOPSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVkoxoY5YJppH9CqSpSN0M7b6iwynjJy8pdK40Ds/5xMiQbuZKWZZ/JzAbiy+s1yL7zHhbOpKGt6HKf2LU63k95d5SHfOoQQF+Q4L1nthSCfum5NzCdlS3hK4Pc1+BQo7N/ONJMV4zEa2o7qNNKnvMsE1RXW+uQvPb0Nzno+MSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb/5PmZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb/5PmZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7CAC19425;
	Thu, 19 Mar 2026 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773893609;
	bh=Vl02CNpdjoEsmufTyLMcaK5uWzOZoAztEvYnENBOPSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb/5PmZodgxaD3Wf7HkiIgGqUiihlp+AWi3cBI8kKg2S9kouJXXI+BU88wW3oYFiG
	 IEfSJwq2HwBZJkQ0oDaX3aofG0XLbEs3UgEk8ntyNNOb9UgCVoxQvK/G4j29xQ972n
	 U4KyYM5OIn71R1YZpqV3knvK1jB24PsO0q7qaWGs+locOdFPsKbrXMiMhwO4jCGSe5
	 aovReIH5wt2HbdeYVQJR7D0rLsiGC/lGlM/CxyD2XMXjCjbJctmgawnoIO1DY2K7PQ
	 n7FJG1mMtfBfoPkWu+jhXdTgKKB4342sj5rkjxw1ATxPvFw3hnT82NZPhji7U1Z5Ud
	 tSDUpliRnsTyw==
Date: Wed, 18 Mar 2026 21:13:27 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 00/12] objtool/arm64: Port klp-build to arm64
Message-ID: <ufevsyquxrz3lxsvg2oj3lzfh4nfzc7ttcn6nlpv2asvhent4m@jirpk7jq4nwd>
References: <cover.1773787568.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1773787568.git.jpoimboe@kernel.org>

On Tue, Mar 17, 2026 at 03:51:00PM -0700, Josh Poimboeuf wrote:
> v2:
> - patches 1-2 were merged, rebase on tip/master
> - improve commit message for "objtool: Extricate checksum calculation from validate_branch()"
> - add review tags
> 
> v1: https://lore.kernel.org/cover.1772681234.git.jpoimboe@kernel.org
> 
> Port objtool and the klp-build tooling (for building livepatch modules)
> to arm64.
> 
> Note this doesn't bring all the objtool bells and whistles to arm64, nor
> any of the CFG reverse engineering.  This only adds the bare minimum
> needed for 'objtool --checksum'.
> 
> And note that objtool still doesn't get enabled at all for normal arm64
> kernel builds, so this doesn't affect any users other than those running
> klp-build directly.

The Sashiko AI thing found some bugs, so it might be wise to hold off on
any review or testing of this until I get v3 out.

-- 
Josh
