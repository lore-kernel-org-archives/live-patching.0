Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1A22A4E9;
	Thu, 17 Sep 2026 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604577; cv=none; b=cG3DrFyEnYy+DLFpznCDKiY2s1YR6ZqbaWPMf1zcEqKLvZZCtNX0Hlosdfw0vOKSBqDj0krgrZHzqc/dH5MnzWay4O6qysuZ5eNgltamGq6TlxkxSQOm4JU46pQ8yFXbXqDXkYUlzYxwcxUbLa95e3siXd3+n8zVHhYSGYH3IdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604577; c=relaxed/simple;
	bh=C9PYq9PQBjBdKaCs+e2QlFTsA1DXK8tPiZZXOrsZu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGuOE86SIsTGYJBViRUI+eLDn2nNEpYVjCqqKqbRApz4yDkIZ/j9kGEfsF2qzF8FFlPWmlMhvf59GVSVHKmH+CSnnRsz1M2KogBnOOtKlC7/cIm16sEr4B/MWkmfG+y9oVT67hmrQl82gSq1tiYidnNZzOQc7MUw4ponhvxQISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8j4gA72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8j4gA72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F4B1F000FF;
	Thu, 17 Sep 2026 00:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604575;
	bh=jZ6IyY0QCB5158qI3wrX8EFtNkuoCaSeVB9/6rOQNXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E8j4gA721pNb+LKg6+IkCCgWdKHd9j69vqPnFthRgLmMYG/pcu+CNPHeTr8/R/q9l
	 vo6NWVicruhmv1RR4Rq8yA0jiqjGKjpS6JxyM6VgvYQLqP6lOOPB3XtaRWQKGg9a9m
	 5scV0qeitLw4UOYP6DWfYsPt9fSQtvSjNYL1wkrLekqBLYn3RYtSX0SWJpm92qsA4N
	 OhQKzyhQMcCyfoJ5hGok5fGB65jW7lfHpRZi/2SSORYouCpcrR/VKuCypOrpHWL63r
	 GGHSonAXD+ILuQ0qDkrEUMobnldoGcHhrEuM/ZtQTGu1MkiQPXqNJyknCJq8dMgN6e
	 B6fkee/UiAg9A==
Date: Wed, 16 Sep 2026 17:22:53 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, live-patching@vger.kernel.org, 
	puranjay@kernel.org, jikos@kernel.org, kernel-team@meta.com, mbenes@suse.cz, 
	joe.lawrence@redhat.com, peterz@infradead.org, pmladek@suse.com
Subject: Re: [PATCH v5 36/58] objtool/klp: Add test for position-independent
 checksums
Message-ID: <aqsytM8dJ36FqPwG@jpoimboe>
References: <20260916184351.2720310-1-song@kernel.org>
 <20260916184351.2720310-37-song@kernel.org>
 <20260916190111.0E2BB1F000FF@smtp.kernel.org>
 <CAPhsuW4zYr+nP=YMQvxmL7mOjqErZh3u43dJ==QZMNQV99+g9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW4zYr+nP=YMQvxmL7mOjqErZh3u43dJ==QZMNQV99+g9Q@mail.gmail.com>

On Wed, Sep 16, 2026 at 02:43:23PM -0700, Song Liu wrote:
> Good catch here. We missed these comments/messages.
> 
> Josh,
> 
> Would you mind folding the following change in while applying the patches,
> so that I don't have to spam the list again?

Sure.  It was whitespace damaged but I figured it out :-)

-- 
Josh
