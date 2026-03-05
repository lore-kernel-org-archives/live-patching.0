Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCC26E706
	for <live-patching@vger.kernel.org>; Thu,  5 Mar 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772741334; cv=none; b=UI9uqV1jQAcmVN0oYPd6KPiEWVpqqcMIvia1YfgZQn1qlu7HlDjVAqCrSdrKK1JUxa6hY/zdYvwOA7G99PjJndXj2KII2/WZMT/gbcwMprYVLKBy1cjkVrE3XYO+vgGHTWk1QGjYKJk3wXf54Va4B1TK7jUg5vJHTica5keJVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772741334; c=relaxed/simple;
	bh=CgWbcuHLxuRjJlJxb2pOeyHNoqbk0xdg/pA6My05RRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5lRPk+OJmjrzdUT3FKT1menoPyKAqbua6HlurC+GIdCxr3rJ5cWlhj4W9EfIQAqc6KToTtomsxr5plwBc1L4vb6d38bYMUlYJRjY9QVg8Mui9tUwCT8BXGtNZu6j5KnFxfJTDP79ERKJQRDXc/jH+GW5W3cxYKqLBYpsuyGhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKV/8del; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKV/8del"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2236C116C6;
	Thu,  5 Mar 2026 20:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772741333;
	bh=CgWbcuHLxuRjJlJxb2pOeyHNoqbk0xdg/pA6My05RRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKV/8delmsh2NCjEVBmar6Hk4d1CAaoO9guLwFV6esNF5TyYd/IZ4XhiIXNvEBFRh
	 t9B5TJb1JKT2AFa1i35OuDSeDZAyHgGyXFCefdoW/WmTtk2yCZT6FoYgT0NEWVwSB9
	 2Rv4XAYOw2AJ5QiSF6wbUCKOapWJP0hMqTf7tGg4sHNFXWtD6yBPOtQswRD1F2xZQr
	 tP97N9/NYu7bP3EzWE8ubbngSUDN8NMe6XHcbcAPf1Ae+hPUUkqCl/No1NrkQ8TOYu
	 XxKWVr+kU00tch4vWjxd25ZqaqVvFBmPhdw/LXNcVWS+9LwD9AbvmmyBNTMBbL5e5W
	 2wSZsplLnWSaw==
Date: Thu, 5 Mar 2026 12:08:51 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 11/13] livepatch/klp-build: add terminal color output
Message-ID: <fholfhe6ygw5ucgkpy5dgak7elmahhcxbf5zyu66njtl2bnvo3@lvggixxy4avo>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
 <20260217160645.3434685-12-joe.lawrence@redhat.com>
 <7lykwpkqigzixza3xqhg7yqfhydcdim6dmzf2e5lembxjim6zb@z6y5n6qpb4xs>
 <oetssfso7zbcsleiapmqwfiwqcobu3ghsf26ubxbqnkild7dve@hpa3e45rgtp7>
 <aaZGXPbyH3QmrcQs@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaZGXPbyH3QmrcQs@redhat.com>

On Mon, Mar 02, 2026 at 09:24:28PM -0500, Joe Lawrence wrote:
> On Mon, Feb 23, 2026 at 01:32:09PM -0800, Josh Poimboeuf wrote:
> > On Mon, Feb 23, 2026 at 01:28:45PM -0800, Josh Poimboeuf wrote:
> > > On Tue, Feb 17, 2026 at 11:06:42AM -0500, Joe Lawrence wrote:
> > > > Improve the readability of klp-build output by implementing a basic
> > > > color scheme.  When the standard output and error are connected to a
> > > > terminal, highlight status messages in bold, warnings in yellow, and
> > > > errors in red.
> > > > 
> > > > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > > > ---
> > > >  scripts/livepatch/klp-build | 15 ++++++++++++---
> > > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> > > > index 80703ec4d775..fd104ace29e6 100755
> > > > --- a/scripts/livepatch/klp-build
> > > > +++ b/scripts/livepatch/klp-build
> > > > @@ -52,6 +52,15 @@ PATCH_TMP_DIR="$TMP_DIR/tmp"
> > > >  
> > > >  KLP_DIFF_LOG="$DIFF_DIR/diff.log"
> > > >  
> > > > +# Terminal output colors
> > > > +read -r COLOR_RESET COLOR_BOLD COLOR_ERROR COLOR_WARN <<< ""
> > > > +if [[ -t 1 && -t 2 ]]; then
> > > > +	COLOR_RESET="\033[0m"
> > > > +	COLOR_BOLD="\033[1m"
> > > > +	COLOR_ERROR="\033[0;31m"
> > > > +	COLOR_WARN="\033[0;33m"
> > > > +fi
> > > > +
> > > >  grep0() {
> > > >  	# shellcheck disable=SC2317
> > > >  	command grep "$@" || true
> > > > @@ -65,15 +74,15 @@ grep() {
> > > >  }
> > > >  
> > > >  status() {
> > > > -	echo "$*"
> > > > +	echo -e "${COLOR_BOLD}$*${COLOR_RESET}"
> > > >  }
> > > >  
> > > >  warn() {
> > > > -	echo "error: $SCRIPT: $*" >&2
> > > > +	echo -e "${COLOR_WARN}warn${COLOR_RESET}: $SCRIPT: $*" >&2
> > > 
> > > Shouldn't this reset the colors *after* printing out the whole message?
> > > 
> 
> Colorizing the "warn:" and "error:" was intended to look similar to gcc
> color output.  I can easily highlight the entire message if you prefer.

I guess I was confused because a) the commit log made it sound like the
entire warning is in color and b) the status messages are also for the
entire message.

I don't know if I have a preference either way, but at least the commit
log should make the intended behavior more clear.

-- 
Josh
