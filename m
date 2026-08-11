Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559893F6606;
	Tue, 11 Aug 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466507; cv=none; b=KHf2aOQl3BjRTTPQSGqV0Yub38QfmqozHGOT4eCYVAg27sFARdnPJAPC+dRLa6EyGZ49JPju2d6WUZTbSrXAafM6EDZzmOfNHTPR2Hb5ulsGtmuPRrSeKV8OFiCFXPMwIZUjpwhMGGCCnOHQjXreWAZcBcimxxQ+c40XR5Y9uQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466507; c=relaxed/simple;
	bh=b7LZUiOukhUEkLCOLNODeen4bbcURgZTEH9a3l7HzXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+U/tPOObwofrd23qIhYqPBC3cvNi0pLFM8cjo3KVAAJPjZ/x9xjFFZBHmeuE9VhoDTQ9sUkLjQ7IEb+YGHMJFGaiShAT3gYJDtAXXQYOkwCqN0/wMQTT6Uh0aZp+9PH+Z9M96KhJqeqSGGdcJkRkgSylVYlDdeB5Om/8pgcnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TynGOiim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TynGOiim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BBD1F00A3A;
	Tue, 11 Aug 2026 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786466506;
	bh=YH81zlJN3/rJuDofrliVkDipcnRN11lptQvHyY7qVzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TynGOiim67HmflH0eOxafnmJOVZNOLxeyjxnM3yKIbwVAQiCL2ldUTyGyrP6hRTsT
	 11GIiYBGK9Ro0dTUAIn8kJ1Gz7iUvhKVs+awQOt7Kim4WQjsDjx9QqiUqsoT6Mh++T
	 bbYwjhQD/awEtNadgboMF8VUBiNeg2DbI6Xj2sTf+F31hWTuQl47Cwy9MuYGFw0FwP
	 wFY1X694/IoHh5H9WVkxu8icbS0CQ0FJDg3W7KxvRdlVg0Q1syHVeyuskTfOSfnwDT
	 rkqZuJtMIAzVmy8BS9MS0FgIqWYlgANCf8dAiiqm1ZUTnnKkvc6BbdspMP55szbUVD
	 jn4PuNe3OyuvA==
Date: Tue, 11 Aug 2026 09:41:43 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Message-ID: <buq25tpmdjlvskzfvlit6swc6tsjuzbdnjfix4w6af6247zads@ka44wuolomci>
References: <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
 <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck>
 <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
 <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com>
 <answWdRpVQLtIzIj@willie-the-truck>
 <CAKwvOdkrxJ_9qjaBNQS+o=+_m_f3e9k6jMEmXB-S3+nXGoLV7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkrxJ_9qjaBNQS+o=+_m_f3e9k6jMEmXB-S3+nXGoLV7w@mail.gmail.com>

On Tue, Aug 11, 2026 at 09:27:28AM -0700, Nick Desaulniers wrote:
> On Tue, Aug 11, 2026 at 7:23 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Aug 11, 2026 at 03:18:17PM +0200, Ard Biesheuvel wrote:
> > >
> > > On Tue, 11 Aug 2026, at 14:02, Ard Biesheuvel wrote:
> > > > On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
> > > >> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers wrote:
> > > >
> > > >>> Sure, but let's replace this with a link to a bug report in llvm's
> > > >>> issue tracker?
> > > >>
> > > >> Yes, please! I can apply the patch once we have the bug number.
> > > >>
> > > >
> > > > I can look into that.
> > >
> > > https://github.com/llvm/llvm-project/issues/215547
> >
> > Thanks, Ard. I've ended up with the patch below.
> 
> What's the extent that HAVE_LIVEPATCH will be used?
> 
> Does this penalize kernels built with BTI in favor of HAVE_LIVEPATCH?
> 
> For example, with my Android hat on, if we have a kernel that's built
> with ARM64_BTI_KERNEL=y, and _dont_ use HAVE_LIVEPATCH, we're going to
> turn off BTI for a feature we're not using?  But maybe we _do_ intend
> to use HAVE_LIVEPATCH, and my assumption was wrong?

The problem isn't specific to livepatch, livepatch just makes it easier
to hit.

-- 
Josh
