Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509125;
	b=FRhj2fHYb9lArPANNAqkJF3aLUijBACCmgYWIwu6IKydXSCuhbZqSUDmoXTi56XGPwig
	 zbfIwd8KK+jqawGZEFWM1KmK5beewsRSC1Z2IZiE9YqAHdn8/17m61c6P3QG+ak50cXz9
	 v31JV2il5wnYyEEU9u8J2kqJklB3JNloEoNFoq7hEiD3USsDb61enU+AU8zYbzGE8avrJ
	 P7I2IqN2iKAY85n1hfuUh7gPMJqZyJONX8+cPIof9Oc4tYeZazvL5RU4tBb2eBmJDjRXP
	 Sgu8SB+Dmu4fvox1NpCwdBaNG6XiL8ROfQIQEpyj1QbVy/wPcg44s5+34BzerKeVRtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509125;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=D7ccPnJrKI175b6VGgYIvgjoBXfn0b4AhnASajlohJI=;
	b=gzj2LmSap4uHSoIYS1yuoqwc9Gt+WnHhjwxsKuWjMF2qMY8XYUmSdZdTYiSbhjKyg3Ml
	 kX0+2bbWIJElmBtw4wWzecHfp3z6g1X42pVlvW6xj8v0T3CVGbCH53nC7+XhygjHpbFY5
	 oZnBkcjUpyxc3bNMfVtr0NXRecRKpbkPWebOJ9kaGLnfgLivKV692rkQasY47u56gGpk6
	 drq0VspMGSllsWPU7XcPplIL1mUWnkoSVon9agpwfw0D4BApek/H06mzC3Dll6U3VIlf6
	 QVB4h8IlHpWhvG0IbNzqdj8WS4TPhU4uRnr5ZoZEvN1vgc0gm6Uz2pZrqc8vEJhC3LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY7bCLpN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5E606A321;
	Thu, 12 Nov 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY7bCLpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31C21F000C4;
	Thu, 12 Nov 2026 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509125;
	bh=D7ccPnJrKI175b6VGgYIvgjoBXfn0b4AhnASajlohJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XY7bCLpNnG7oYe0yXJBjX9V3EURx+/BBXRYjPSGM6tHAmkrqXq63drYucjk7txL8K
	 i5uB261Mzd1u6FFRS1VxJVJUYZ6ffkPxJtCCCuzBXXCcz5EASPaqTfhXc0989Q9yW0
	 VoyKp+4qE9qQIDaNadac3GF3Il8ARIHIfAFSliWQ9lWdEc8ELsF12yfneqLJr6FRiN
	 6EjsCDa8EQgcZX1dzi9C31WuYLRIjUkbOOeqUkcAXBl7ERCkaCNQ9/HV9QCnKqSHkD
	 AxeaqKUMvcJ9pbRepBxGzpH0ZnUvXrbeTYMHpuZ2IU/5Dlp6pMgLMcgJJ5xRtyKwPT
	 LL0l3fonpXO7g==
Date: Thu, 12 Nov 2026 10:45:23 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] klp-build: Allow passing options to make via '--'
Message-ID: <avYIsWoMgZxDZsg1@jpoimboe>
References: <20261103233909.1364531-1-dylanbhatch@google.com>
 <avVYkcbr6ah9IzYX@jpoimboe>
 <CADBMgpzH8Ogwvr6ORx5PebB=0-2gLNXM96U9=jKa5+PwnapjAA@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBMgpzH8Ogwvr6ORx5PebB=0-2gLNXM96U9=jKa5+PwnapjAA@mail.gmail.com>

On Thu, Nov 12, 2026 at 10:24:49AM -0800, Dylan Hatch wrote:
> On Wed, Nov 11, 2026 at 10:14 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Tue, Nov 03, 2026 at 11:39:09PM +0000, Dylan Hatch wrote:
> > > Livepatch builds rely on reproducing the original kernel build
> > > environment. Currently, klp-build invokes bare 'make', which drops any
> > > command-line variables or flags used during the original build (such as
> > > 'LLVM=1', 'CC=...', 'KBUILD_BUILD_TIMESTAMP=...', or custom wrapper
> > > Makefiles via '-f').
> > >
> > > Refactor the make invocations to use a common MAKE array and allow
> > > passing arbitrary make options after '--' on the klp-build command line:
> > >
> > >   klp-build [OPTIONS] PATCH_FILE(s) [-- MAKE_OPTIONS]
> > >
> > > Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> >
> > Does this enable anything that's not already possible via setting those
> > variables in the environment (or MAKEFLAGS), e.g.:
> >
> >   LLVM=1 klp-build
> >
> > ?
> 
> Ah, I hadn't tried MAKEFLAGS, thanks for the pointer.
> 
> Since Makefiles override env vars by default I had some issues with
> our internal Makefile-based build tool, but trying with MAKEFLAGS it
> does seem to work. In which case, this patch doesn't really add any
> new optionality.
> 
> I would argue the [-- MAKE_OPTIONS] still has some value in that it
> makes for a slightly more intuitive command line interface, but that
> is just my subjective opinion.

Yeah, I'm not opposed to that, assuming we don't want to reserve [--]
for some other purpose.

At least the changelog should state that this isn't adding new
functionality, just creating a more ergonomic way to do it.

-- 
Josh
