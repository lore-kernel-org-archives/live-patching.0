Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062002D46B3
	for <live-patching@vger.kernel.org>; Thu, 29 Jan 2026 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710116; cv=none; b=iVRBCTPP8Ys6mLPlK0bfViXlRh2u35L8crhaVxxbtc3uI8VvdM94q8/TVsS4dA5928rFv/sBZrzTS4t3yAW/ahjOW7w+Epc2NRXGhg3SHYsSpcxgVVqpJq+zbFLfuI3fp6/j6bUv7I9K0obERjlTDa8oZtjSFJ8otd8X8gS3TtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710116; c=relaxed/simple;
	bh=SS57QMHe5f9qhlh7BPrZYji0zRw10WiOjNiRT6n2CUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIWeR/JBZeWtS0Qy+i2eQmod1Tiz2bh3QZNb3fXIzEj4RSLOWJZ8sL6GGx3+VJFlGBpEx1YSDdIZQI1IgeRe5axJoaM8suwVDeslVg4w4i9i8eyS90er1RIjyjvcqgdrcZ/nnDJDyzNS4abo0wg07v4VGWX7hRbUNBcBmxCRyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPg9jM3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPg9jM3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C1FC4CEF7;
	Thu, 29 Jan 2026 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769710115;
	bh=SS57QMHe5f9qhlh7BPrZYji0zRw10WiOjNiRT6n2CUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPg9jM3cv+sxC4V0Tr9SNCTKpoXmixZ+wPOzIJBKrI87mlH01nsS9L8cN/vEOImkk
	 ueN2tIsACaJPcl8bTyWyiO8O8ABiL/AHeZwFRctKhmUErQyq4voSflL5j1gQdHcPej
	 x8/F084vsD42aOfgHPwqE5VY3m6De91NiCZzcfqMqiCfTun+F5b5/rrcwVicQx2JRV
	 uf+PQ8RPS5aa67+Yu/q7kqbYmY8aeb5Of4c+LB6qgA9jsP/EgFZtqKeK4C4ci4ZYtx
	 RL4vlzl7rxx4dKRzIbOjy338NYIwPhWoGaPVysiMTnHZ3h8Yn7Mcqb2cTVFi+ZlIDH
	 N8ZWLjWHmq4Sg==
Date: Thu, 29 Jan 2026 10:08:33 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, kernel-team@meta.com, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com
Subject: Re: [PATCH] klp-build: Support clang/llvm built kernel
Message-ID: <mt6sjhz5ydcxnp5jqlq3il4th65zevwrw4ihsnkcnuln6czvul@ljlgziem2eqs>
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

Indeed, I had tested by exporting LLVM=1, but this is better...  Thanks!

-- 
Josh
