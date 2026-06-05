Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9205325704
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667060; cv=none; b=eUsoKs73uPf1U2ce/YPB3O1L6yiPL52OoxEZQeKDuhdlIXpYz9N6+jNYclXyCT+TmdrZFRCk1ZmQKitOstAoa6K7J/o4GYiw7Y+fmZ2WT43J2gNtRUD4buSDIBMhJvogTvY0mVGJvM9pQAdSy62tYjQbE0Phh/IY3GzlaZRrPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667060; c=relaxed/simple;
	bh=fjf1uQejVeOJ9fn7LjyfkZZCewgephLotbm/g892LTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMm/U161h4S2Y3f8JSbiHoSpz+AGFUN6U+0auGvaH0hLuUyY7ZMwfhPOeGF7/q6a0fJDaqyW5gEqy1S3ASpOJAg4ipJKtTDpFL3aDgeHNfBhgyRDYOT/BcG/t4Uq254Sqao5+3dtx1sM0g7shBD28To7lRZp0jxMhldlWGuIp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gu4TpXc+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gu4TpXc+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso21239215e9.2
        for <live-patching@vger.kernel.org>; Fri, 05 Jun 2026 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780667056; x=1781271856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdsfWOnLuuY9elhMzfIfrh1St5S/FY4B3lK+KDhQ7jU=;
        b=gu4TpXc+Rn/qccRJB+wAYY/J8RdHyO/xnlpbuyXLYNwTqD09D4M2ROJ0puNIoakD8V
         I/v/wFHPXJluRLH0NnzlZvOtm8TKnxfadYz1lXqsYlDMwMh9Eo9lW6Qi2CpmpqDFLh6T
         Xdwx43nb6XHiE7t11TUE1k+gwB0MgWY8WcPvxjmxpSUIpUauauxdzlDmRpkMeX5wE5gJ
         PsHhEMdLjVpO/S3cQ6wUmNWf6yo3eBjQMSk1bimo8+AWebf5bIOSY0NxEszK4X8/663q
         tpXsUzXZqaOxM9fc3M6+54o3aCeHJ9571zUl4THnoMdBxzSq+Uyqn+G+50NCzPeO2H85
         Pspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667056; x=1781271856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdsfWOnLuuY9elhMzfIfrh1St5S/FY4B3lK+KDhQ7jU=;
        b=a90nmBMF1Vlw3S1tdpjrBxJW09E4tw27lG/P7hzNFQGvBnObw/XUlsrlR8n7dneSF2
         3k18SjdmC551vywwL809zMVfQYg93g6tXx20rXJLuZaA4Vrpgk1RHYRI/xyaAEL8zObE
         zHSx6jGsIJVPQIiXExEjVm5b64/afNWU0SZ06n2WLgk6ThtdRDzyyXdLBTws/lR9aWu0
         XOWy/cCahXyhLrvRe0vwPZLw1SYASoIIbXIksfZ3a9EA4Q/v264XuRt81d+UwWBhWMys
         Aytkiph7GUuRw0WE0tlrVrV2nDsIcB5j7G+UmhVQdjNyO9BE9F2+K0a5/dh+WrxL8DAg
         YARg==
X-Forwarded-Encrypted: i=1; AFNElJ/C2mKyPCLE77xSl6R7VXpjDehStrAWxpzat0KGuGpiXZjzPLWBjK4agKer9CZWPdJEkILeKN4PpZZmzAIt@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6/Cc7BhXLSEmKxmeQ+hC9jIlifqBD8yIWHefJv1JytSTnSYZ
	WJ+zfALv1T7dVXy6Dff32Rg1uiSF6DkkAu7FFkOv8k9lPXj2rdVfPbaUGJOZ0NCcg04=
X-Gm-Gg: Acq92OHf4fHUd5goPo13lDdApwZEYVNdMXPEcjA+QZS6VtnHMyESzVqyNCe+udJcnlE
	ozcPx8Bg0Y8XHEIn0OakpUjZUwqIcYZhstsufYw4hp0YJe5kt4UVWCuyRdFJ/OV/Z2E2fWFRROl
	vtcmdA8JHPD28YdjxUjDhoMFSC1bkNMxPZ6akcR1y8xTPthgDgmUJFFeIo9lS9s2bN4runYmXjk
	MkgDjYhGOKpcNK9mbYxhSd4bs/pqG9gXJP87G8JqWBoLa9L6CjGFI1OXJF86Uvcqz8XQKyXmctn
	dtCxcaOyiNCnNFsUwzn+95iNJGgEf6jI/BA97MngxY34R6D235yp0rbXkthSXgih77k1kXHk3si
	ov85q7qab6BkFiUzyB03ZuCt0J0PZp0MgE86HNaNL8EjMvgFLfr1QQ+Il4RHSCAdC8FE7a7Lhat
	xpnlAuPq+sVsbAjelb+XJBwgx6khbL9gFeH1He
X-Received: by 2002:a05:600c:828f:b0:490:b3fe:9732 with SMTP id 5b1f17b1804b1-490c25dd6aamr54022405e9.16.1780667056226;
        Fri, 05 Jun 2026 06:44:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm63158325e9.1.2026.06.05.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 06:44:15 -0700 (PDT)
Date: Fri, 5 Jun 2026 15:44:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: sashiko-reviews@lists.linux.dev, Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: livepatch: Introduce _remove_mod function
Message-ID: <aiLSraCKXmqYExqA@pathway.suse.cz>
References: <20260524-livepatch-unload-on-fail-v1-1-7465de7f741d@suse.com>
 <20260524235906.267EF1F000E9@smtp.kernel.org>
 <d329f22e75fd01f2250490e4cba87f064a726f52.camel@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d329f22e75fd01f2250490e4cba87f064a726f52.camel@suse.com>

On Mon 2026-05-25 08:49:10, Marcos Paulo de Souza wrote:
> On Sun, 2026-05-24 at 23:59 +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> > - [Medium] `_remove_mod` uses `die()` which will terminate the script
> > during cleanup operations.
> > --
> > 
> > commit 7b1591f4e5c3b351136e7fe2821eb2e15ae59ad0
> > Author: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > selftests: livepatch: Introduce _remove_mod function
> > 
> > This commit introduces the _remove_mod internal function to remove a
> > loaded
> > module, intended to be used during cleanup when a testcase fails. It
> > also
> > refactors unload_mod to use this new helper function.
> > 
> > > diff --git a/tools/testing/selftests/livepatch/functions.sh
> > > b/tools/testing/selftests/livepatch/functions.sh
> > > index 2bc50271729c6..3ec0b7962fc5c 100644
> > > --- a/tools/testing/selftests/livepatch/functions.sh
> > > +++ b/tools/testing/selftests/livepatch/functions.sh
> > 
> > [ ... ]
> > 
> > > @@ -241,9 +241,10 @@ function load_failing_mod() {
> > >  	log "$ret"
> > >  }
> > >  
> > > -# unload_mod(modname) - unload a kernel module
> > > +# _remove_mod(modname) - Internal function to remove a loaded
> > > module.
> > > +#                        Use unload_mod() instead, which also
> > > updates TEST_MODS tracking.
> > >  #	modname - module name to unload
> > > -function unload_mod() {
> > > +function _remove_mod() {
> > >  	local mod="$1"
> > >  
> > >  	# Wait for module reference count to clear ...
> > > @@ -261,6 +262,14 @@ function unload_mod() {
> > >  		die "failed to unload module $mod (/sys/module)"
> > 
> > [Severity: Medium]
> > The commit message notes this function will be used to remove loaded
> > modules
> > when a testcase fails. If used in a cleanup path (such as a bash EXIT
> > trap),
> > will calling die() here terminate the script prematurely?
> > 
> > If a module fails to unload (for example, if its refcount doesn't
> > drop),
> > die() executes exit 1. Inside a trap, this aborts the rest of the
> > cleanup process. This could skip unloading any remaining modules and
> > prevent final cleanup operations like pop_config() from running,
> > potentially
> > leaving kernel tracing persistently enabled and polluting the system
> > state
> > for subsequent tests.
> 
> The system is already polluted when a testcase fails nowadays, since a
> module is kept loaded either way, making the next tests to fail if they
> also try to lead the same modules.
> 
> The current approach is trying to make it more reliable.

I believe that Sashiko suggested that the clean up path should not
use "die" or "exit" when something fails. It should try to continue
with the next cleanup task.

I remember that we even used the following in rpm post install scripts:

    command || true

It is useful when the script does several independent actions
and we would like to process as many of them as possible.

For example, in our case, if one module can't be unloaded
then we might still try to remove other modules and
call pop_config.

So, we should somehow distinguish when some code paths are
called in the script and when in the clean up part.

I would export some variable in the cleanup() function and
check it in the called code paths, for example:

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 9c98bbb8b725..eebc7f193d98 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -62,7 +62,9 @@ function has_kdir() {
 function die() {
 	log "ERROR: $1"
 	echo "ERROR: $1" >&2
-	exit 1
+	if [ -z "$in_klp_cleanup" ] ; then
+	    exit 1
+	fi
 }
 
 function push_config() {
@@ -128,6 +130,8 @@ function set_ftrace_enabled() {
 }
 
 function cleanup() {
+	export in_klp_cleanup=1
+
 	# Remove leftover modules in reverse order to handle dependencies
 	for mod_item in "${TEST_MODS[@]}"; do
 		if is_livepatch_mod "$mod_item"; then


Finally, I think how to split the changes into patches.

I think that the above changes which add "in_klp_cleanup" might be a
separate patch,

But the original 1st patch looked weird. It did split _remove_mod()
and talked about TEST_MODS tracking but the tracking was added in
2nd patch. I would prefer to split the function and add the tracking
in the same patch so that it is obvious why it is split and what
is the difference.

Best Regards,
Petr
