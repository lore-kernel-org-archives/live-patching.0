Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719DF36CDE3
	for <live-patching@vger.kernel.org>; Mon, 23 Feb 2026 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882332; cv=none; b=oXrlXqsXek8K5K3EHaG1zIIy+lzOfkv2b2atF4MVo5Db4IkZeNnlsTtva3MbdN0iA2c5832ql/pFY8ssacreHNnNtho3ImOHDngcyM44TjGgEYQvwqEG3/pO2gAyKfwZQoenRMqWmZU0vrtUlvJTnkTzE6y85MdoutOcK+we5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882332; c=relaxed/simple;
	bh=Q9BmQ+EEAtNFmGKno5/ZywermgmltXznMKRaijNLyH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STne4FVNsh4li2i7sB1cZqJFsLCz3KFHOyYtRELciJW2pIaeiO4Roh/mHlphu/Pmm/1R6tduBW43jkseSS4ziRomDxWyX33R0wyZIHuV6IvUKLpTfrWlhWFSlKwlBAaP2tErrF5bt3iFzmG5UTTpb9D2HC55MiNGR6Aua+3XWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0wMnVxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0wMnVxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A83C116C6;
	Mon, 23 Feb 2026 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771882332;
	bh=Q9BmQ+EEAtNFmGKno5/ZywermgmltXznMKRaijNLyH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0wMnVxkFZ18ekClMjQDDWe0tx9EPrMd5yYO0tlGkOFbrVXpGBvbQMfza/2UGlaSp
	 bF2ooZ1TiocM5fzgZHyPLUFuZCnYBJa3VT67J9OPf9F1eH9wECJ0PILHNbnahCu+TM
	 yVB/AgS44H6xXcKrRVWRz19Z8+j/w3VARlnQvRubgdKBwac+QzgnQiS/WK8cQTeI+Y
	 D0kacscpOYagdFBY1xdog4z75tJdEL4fk0rkbH+gy2L4aXuOMnbijS2iERMRBSmbQh
	 vDqNRMQhw8sfa85TqcvrJyD1AodvgrFMRyL7vs/lJUdBF29zvTXOfZuT1eBGBsDRfM
	 cOWfAHCXaXUuQ==
Date: Mon, 23 Feb 2026 13:32:09 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 11/13] livepatch/klp-build: add terminal color output
Message-ID: <oetssfso7zbcsleiapmqwfiwqcobu3ghsf26ubxbqnkild7dve@hpa3e45rgtp7>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
 <20260217160645.3434685-12-joe.lawrence@redhat.com>
 <7lykwpkqigzixza3xqhg7yqfhydcdim6dmzf2e5lembxjim6zb@z6y5n6qpb4xs>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7lykwpkqigzixza3xqhg7yqfhydcdim6dmzf2e5lembxjim6zb@z6y5n6qpb4xs>

On Mon, Feb 23, 2026 at 01:28:45PM -0800, Josh Poimboeuf wrote:
> On Tue, Feb 17, 2026 at 11:06:42AM -0500, Joe Lawrence wrote:
> > Improve the readability of klp-build output by implementing a basic
> > color scheme.  When the standard output and error are connected to a
> > terminal, highlight status messages in bold, warnings in yellow, and
> > errors in red.
> > 
> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > ---
> >  scripts/livepatch/klp-build | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> > index 80703ec4d775..fd104ace29e6 100755
> > --- a/scripts/livepatch/klp-build
> > +++ b/scripts/livepatch/klp-build
> > @@ -52,6 +52,15 @@ PATCH_TMP_DIR="$TMP_DIR/tmp"
> >  
> >  KLP_DIFF_LOG="$DIFF_DIR/diff.log"
> >  
> > +# Terminal output colors
> > +read -r COLOR_RESET COLOR_BOLD COLOR_ERROR COLOR_WARN <<< ""
> > +if [[ -t 1 && -t 2 ]]; then
> > +	COLOR_RESET="\033[0m"
> > +	COLOR_BOLD="\033[1m"
> > +	COLOR_ERROR="\033[0;31m"
> > +	COLOR_WARN="\033[0;33m"
> > +fi
> > +
> >  grep0() {
> >  	# shellcheck disable=SC2317
> >  	command grep "$@" || true
> > @@ -65,15 +74,15 @@ grep() {
> >  }
> >  
> >  status() {
> > -	echo "$*"
> > +	echo -e "${COLOR_BOLD}$*${COLOR_RESET}"
> >  }
> >  
> >  warn() {
> > -	echo "error: $SCRIPT: $*" >&2
> > +	echo -e "${COLOR_WARN}warn${COLOR_RESET}: $SCRIPT: $*" >&2
> 
> Shouldn't this reset the colors *after* printing out the whole message?
> 
> Also, while it does make sense for warn() to print "warn:" rather than
> "error:", note its called by trap_err(), which should print the latter.

also I think s/warn:/warning:/ is better.

-- 
Josh
