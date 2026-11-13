Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594844;
	b=DOJDbLIjeKTZTGV+TlTzXZpYSHSO3asHBRnRYcjFYIoQ39cBWyaEE648KOzj/5uljGyK
	 oxPbWJXcTNZJNI8i/+zeVFILizRTaucvqephQwesevO6HPbw4lVPE37fdP7/LiF18dIXJ
	 u3k+isNviBsW9fxnbM7yfBTXVVZsCb/kiEjdHWq9/rUncCjIXX43HH7vECe6CYo0/gslv
	 wxwiir6ABpExSa2QPA7ECAl7KquWPLDb4CfRzBMhqVW46OiruGdWoTS12gA+aK/bByqZH
	 r8FTMpWr3rR16nYumV99aPTmZuAV/M85TCXT0TOMy6Gb/nKJgN1oEGZFZ3g6qibwO2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594844;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oaQhh+OUaneKvMweWF8ZyU1MwloL7jZ9x7ji0DPo+Wk=;
	b=ttyBvps+2WENR7Ap/svmxmaRPnAM37VikmccmQ3DASLdKJw/77YoUgCL4fBOjDF/ehXL
	 lAYAqZmkT0Arpl1SYOkqEes+tjhSbsZnlzpvXtCQicpfV5cGwHRdGzJaObJcLpVGkvTYY
	 6tH9VBmuI8hv95Cablg9dJIuXjfC3drqqzB0crmPHN8//8gUSxxI0kCF/WFYe3iMNI37y
	 vtlA8JNilq08C22kMaJYrTVzUdbd7bH+q5tmitxgxyql3bihnI5RfnlIXJx/DZ10gLlvG
	 5Oy5IhzZ+yP1uivjHCOKMTGdj6KmAax/DNx8NLtPz8H1xDDgS31PrrgJv26bz+nTNQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZ1086Fz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7019606A327;
	Fri, 13 Nov 2026 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZ1086Fz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495A91F000C4;
	Fri, 13 Nov 2026 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794594844;
	bh=oaQhh+OUaneKvMweWF8ZyU1MwloL7jZ9x7ji0DPo+Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZZ1086FzH91iVXWyrIQAbmA+4VKgd6hgeP9KgDIq7htPi8caWMneXeYCkHLDQvad0
	 80nHSaspgyKpRo3U9nAUKlcSOj/lKSebNswKERvqronWsKpZrm5p97IVcgjwlrpAHS
	 CCjZzeH9P9aLLLYphv/mOffu0Gs/k2IZEcNNMiOGEOiPH1l0Zp7vMAqcM0iSeVKDym
	 ioml1YtyaWhwZSmSxXICwOW6lvcEzmv3UtHuyMbQRiSOm2c+PBgbHCuHcSV4lSbQC5
	 fv2phVOLaUTmYQQsFQ0rfbIvD6q51ruFBoNBkJD2fOV8kYm7ImqcOUaWjtAi4h9B4w
	 14mL7QvN3GjKQ==
Date: Fri, 13 Nov 2026 10:34:01 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/11] objtool/klp: DWARF-based cross-build symbol
 correlation
Message-ID: <avdWz3m2YJnlGgnS@jpoimboe>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <avZ9Ku61M8z-2axF@jpoimboe>
 <CAKL4jwXA4OBVLFGAP4DWw6i9d5bneU=Ur=D58FnrssOt7ygm6A@mail.gmail.com>
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
In-Reply-To: <CAKL4jwXA4OBVLFGAP4DWw6i9d5bneU=Ur=D58FnrssOt7ygm6A@mail.gmail.com>

On Fri, Nov 13, 2026 at 11:58:31AM +0800, Longjun Luo wrote:
> I understand the concern about readability. Since English is not my
> native language, I drafted the content myself and used AI to help with
> the English writing before reviewing and sending it out. I'll keep the
> information density in mind going forward.
> 
> Just to clarify the background: this design comes from my practical work
> on userspace livepatch, and v1/v2 were meant to present the two
> layers of that design as a whole. While dealing with LTO in practice, I
> ran into many recurring correlation issues, so I tried to abstract and
> model the problem systematically rather than hunting for corner cases,
> and I brought that modeling process into this review.
> 
> As noted in the RFC, this patchset is intended to validate the
> feasibility of the approach. I wanted feedback on the overall design
> before deciding whether to take it further.
> 
> Thanks for taking the time to review and share your thoughts.

Thanks, that makes sense, but for upstreaming I think we will need to
take a more iterative approach, even if it ends up causing some
intermediate patches to be obsoleted by later ones.

-- 
Josh
