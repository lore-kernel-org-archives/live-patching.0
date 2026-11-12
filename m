Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464062;
	b=fmxua8qn0iKFh6co43+FsALsURWTcA8BCOA6/P/tVbK3TDudYKoHNYFbYN0VPNkbBVsX
	 tIZJ+4jvhULBICZBDpXPgZ90/w0bFyDwr7d/Ly1hTKKMCUiXyrlkqE+5XncQ15vqI9YAK
	 TSj/5gjhj+Uo/CEIYvkxQxh4PQx0uAX3fuFu11rtvv84fykBOymfhuvgRyjGjSm7NiG2/
	 ytn69SArSgH9fjbCitmM4Oh2WgBR/FoxmWb7+gkWBaWnAuGhqk6kZs1cj4S0pFBoC8Xt0
	 Ae13vgXPtYl+j2co2eIsgtXQMJHsGsA6RFsK0ejTw+vdlVC7ta4VkdXliIq4PEdPGeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464062;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=42caTyeysH8sabCw4NydQnC8/2Oh00ZPSDRLHDvJBxs=;
	b=yuzNnFHcocC28hxH4MP0bo22AnpJGGoFHZ7ZHSx/27CbyoUj7R766Xc+gBrGVp5xTzJD
	 H+wRvcms7DTruF6fSwxz0CVHI6R78lQxbE3VGtcJG+apjcamwZl5yLPYqifnKJGN7t07F
	 mH8844mDlx+yKsXGrWMLzjgU1pruEwrzuBVUr1mZrjcab7lR9RYAM5/nMky7A3CGQ3I7H
	 FxAEdzyz8247V+WejOQpMSQK/vYNjnzt3X3HEh4CizbZV3MpRkDMCK4uT+gTv+fc6Dc2e
	 6cUhp5l4aJkGbYtDGqx0My7tH2y+PCawTwYLCukpYZcTEvRNwdEbWGq6O/HRjzc0+6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXpAjy7N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111B606A31C;
	Thu, 12 Nov 2026 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXpAjy7N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2D01F00A05;
	Thu, 12 Nov 2026 06:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794464061;
	bh=42caTyeysH8sabCw4NydQnC8/2Oh00ZPSDRLHDvJBxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MXpAjy7N1me0fW9Dgu+mVF03jqlGXiRosmryu74xuatXiqwle3uJWqMuDWVc0sU8B
	 bzatjE5F7a+4LiT9z4bIaGtni/0wPWYf6M1kC9Kz003y0ZCnJjGeNHaqzizGEqThJd
	 hu//dDyms2t8GQ+IKkJSP6V7ssCAngrfK+/BXl3rVS+1fTALEBuDA+4wt32HoxDPe1
	 EW1XjQhkJTSKtJnC3kCtr316IUUfB7ZJHzEttJjetqahHqVtzpyM1oMgdnRQP7FZLD
	 zOdolM7BoMJPGjfzdJZI0ki9ekGMH7qev/3/Hy9foNUclEPpBlv9tKIOuYzuB5dEuo
	 VCcBDj1z1ftPA==
Date: Wed, 11 Nov 2026 22:14:19 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] klp-build: Allow passing options to make via '--'
Message-ID: <avVYkcbr6ah9IzYX@jpoimboe>
References: <20261103233909.1364531-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103233909.1364531-1-dylanbhatch@google.com>

On Tue, Nov 03, 2026 at 11:39:09PM +0000, Dylan Hatch wrote:
> Livepatch builds rely on reproducing the original kernel build
> environment. Currently, klp-build invokes bare 'make', which drops any
> command-line variables or flags used during the original build (such as
> 'LLVM=1', 'CC=...', 'KBUILD_BUILD_TIMESTAMP=...', or custom wrapper
> Makefiles via '-f').
> 
> Refactor the make invocations to use a common MAKE array and allow
> passing arbitrary make options after '--' on the klp-build command line:
> 
>   klp-build [OPTIONS] PATCH_FILE(s) [-- MAKE_OPTIONS]
> 
> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

Does this enable anything that's not already possible via setting those
variables in the environment (or MAKEFLAGS), e.g.:

  LLVM=1 klp-build

?

-- 
Josh
