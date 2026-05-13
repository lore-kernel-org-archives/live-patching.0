Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B45A79B
	for <live-patching@vger.kernel.org>; Wed, 13 May 2026 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701637; cv=none; b=fn2tPYy560qS6zVncNGrsQ7F8Nuf/b5Gj83C1Ls7tSM0U+XE6ho4Z0bhc0/R87E9yu6HPNbSBIB/V1MzsrIvN4p+KjeqHplgjGk1R6yccPSOMbE+wd/9CDveZgnAdjP6ntFDWkfEoTCU/tkz6A2HU7HivsUE+4MAQDR8l9V34xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701637; c=relaxed/simple;
	bh=olxLeG15m6yoKvdWoiqtUfs7fiCBzHN3il0KbQxCdsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRkbny2QTHer1RQls6F1cpe+ejrBkfSWPzH+GG6/f17TurZXDjIL/g5BU+rZEloe8J7Xrslw1z6qBGrfX8lViJoNHs4yiaL05uRUohXosdTFiHlq5jpsw1p/1Zx9Uf/irS6BBt+X9N/02FGqKD6JtHKhsq1LSHO4H13Jhn78FJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/aosNIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/aosNIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104F3C19425;
	Wed, 13 May 2026 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701636;
	bh=olxLeG15m6yoKvdWoiqtUfs7fiCBzHN3il0KbQxCdsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/aosNIju48eowil4Ca6Be0i5Zk+axVVqXaDClGilEFzQisx9i8FU6bA+pzzhkboS
	 OsiyjfNZsRsdFf5XsDkxSXBxcdIZcREArL0FT9ZszEQ7qZqa39iek+FRvoAseXD4pI
	 +QN4tGxh05qQ7+5eyDj0FoHVjAbizojTqJ2Sv+q0wC/IdI9AilOkk75P0WB6EHz5cV
	 tWabR9Nr01xdeNEvo/vKuPDisoyFf8EZu+qtxsNOibw94nESZSBYzkhW2v37+VbLxY
	 erspNzjt6MrtcgTupH58sRe5PosHVhL2bX2uwL1OnnQx17hqTdpnjyV42VN7j0qiDi
	 LtIPdRIOvDU4w==
Date: Wed, 13 May 2026 12:47:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: Sashiko patch review for live-patching?
Message-ID: <ju3k5mp22u37l4m27xygqce2sh2nczwckvmk3exkldk5365csx@q53zbumzj33t>
References: <agSjM8dxgnV9QQaf@redhat.com>
 <CAPhsuW6CgBtEGAK+E0n7+tnLAWNPTEuvnAo0vtQsbMVBb6htFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6CgBtEGAK+E0n7+tnLAWNPTEuvnAo0vtQsbMVBb6htFw@mail.gmail.com>

On Wed, May 13, 2026 at 10:17:51AM -0700, Song Liu wrote:
> Hi Joe,
> 
> On Wed, May 13, 2026 at 9:13 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> >
> > Hello live-patching maintainers,
> >
> > I've noticed several references to the Sashiko (https://sashiko.dev/)
> > kernel review bot on this list and was wondering if there is interest in
> > adding live-patching to the mailing lists Sashiko tracks.
> 
> I think it is a great idea. AFAICT, these bots add a lot of values in the
> code reviews.

+1

> > Integration appears straightforward: we can submit an MR to add our
> > entry to sashiko-k8s.yaml and customize the bot's email behavior in
> > email_policy.toml.
> >
> > Full Sashiko Maintainer documentation is available here:
> > https://github.com/sashiko-dev/sashiko/blob/main/MAINTAINERS_GUIDE.md
> >
> > Personally, I would vote to set reply_to_author.  I don't have a strong
> > opinion on the other custom options, provided that the CC list is opt-in
> > rather than simply mirrored from the MAINTAINERS::LIVE PATCHING file.
> > Either way, I've found the Sashiko web interface very helpful in patch
> > review.
> 
> Given the relatively low volume of patches to the livepatch mail list, I
> think we can use reply_all. But if folks prefer reply_to_author instead,
> we sure can use the cc list.

I would vote reply_all.  The signal/noise ratio isn't perfect, but it's
high enough to be useful in many cases.  That way the
maintainers/reviewers are aware of any potential issues, and it avoids
duplicating review work and fragmenting conversations.

-- 
Josh
