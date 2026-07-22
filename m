Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3D1C01
	for <live-patching@vger.kernel.org>; Wed, 22 Jul 2026 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699177; cv=none; b=jqCaea+IkyJNiGFlV3vEFDTqqqcMNAa/DiOVpO2T90WEPrTnVC60fexDmD9UTyOPxCeCJOaP4VKjAfzJSKLs5t3Qd0jm9LyXjP6O8Xaj5cFW8m2/13BGjhZsQysZyA37yH19BHvbLUedt4d7xHnTD1kJDq1bQBibdVmGi+m1WVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699177; c=relaxed/simple;
	bh=YWy8PyJleVGrfMZJHukRmcBrWBWZcGzFSqS4LXB3bt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/X/I7uO3XuS4SERWVmgtqQZRuIwC5buiomgKGovFs+82mSGZXSW2dfNjZ+xl6cUhuBpvNnAybfQ8BRi+dTW/AijnW43E6yorUNWLZasjuALsM8UJtdhOOir3XqeKsoQ3lox3D4mdl7pLBya4kFgOCwevcu0xXiwkI5/URCOItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJrxzRwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJrxzRwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3CC1F000E9;
	Wed, 22 Jul 2026 05:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784699176;
	bh=T3PlQm5kKmiL5FP3sPdgJjLa8XWv+uzHVtF786vsS8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JJrxzRwaQ6u6sKtijk8pB8s8tyVnofuo1kbbtXlGLtBrsYItnvLCbNXSlQKmBstWi
	 5yrw9lwYuLsotZpDrdoiBz0uSFgkMfnuHhpmjtOY+re9942lUUlbOrBItnZusuR565
	 FU14+L36qUzvhQSnZifWoCQ2xZIjttzEOYYaKiOLR1lThM1cdDoHTqDiRRNAhrOdBZ
	 Es/3Q/NPvEdZIoAtdkejJH4xssbuYalr90UEkJhh/roC5rrX9oY3wgWOE+/250mwfh
	 kPCIGS5oosz6GMR4iKnhUJswokrYwxX/L9Niz09bbuPX/bDle5RVTzIEpNRgN4i/nt
	 kPMfwVWY/pO1Q==
Date: Tue, 21 Jul 2026 22:46:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Ben Procknow <bprockno@redhat.com>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>
Subject: Re: [PATCH 0/1] Mitigate klp-build data sympos bug
Message-ID: <ini7aoz6vvowmu5dvxoxpi6l4ednsov6omjcoffmuod3d2iaof@vflcrwqktqsl>
References: <20260710153042.3156788-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710153042.3156788-1-joe.lawrence@redhat.com>

On Fri, Jul 10, 2026 at 11:30:41AM -0400, Joe Lawrence wrote:
> Hi Josh,
> 
> This is an upstream reproducer of a downstream bug report from Ben.  He
> encountered a sympos bug on rhel-10 with the same pwq_cache variable.
> Here I distilled it down to minimal (upstream) reproducer config and
> patch.
> 
> From what I can tell, function symbols already have a "HACK" disclaimer
> around their workaround -- the attached patch tries to extend the same
> idea to data symbols.  It may not have 100% coverage, and it's certainly
> brittle as it assumes ordering as per the linker script.  But the idea
> is to band-aid the problem until a more robust fix is ready.
> 
> The comment in find_sympos() suggests leveraging the checksum mechanism
> as a better fix, but perhaps we could also pass the vmlinux file through
> and read the ordering from the post-linked object?  I can work on that
> for a v2, but in the meantime do you think this bandaid would be
> sufficient for at least downstream use?

As far as downstream goes, if you're 100% sure that you've got all the
different sections covered and in the right order for the right arch for
the right kernel version, then yeah I suppose extending the HACK could
work.

Though I suspect the proper fix won't be too hard.  So rather than
propagate my original hack even further, we should probably just fix it
properly.

I'm not sure about my original idea to replace sympos with checksums, as
there can be duplicate checksums.  But as you alluded to, I do think we
could have some special section(s) created by the main objtool run for
vmlinux.o/vmlinux which could be used by klp-diff to disambiguate and
set the sympos accordingly.  Let me know if you'd like me to work up
some patches for that.

-- 
Josh
