Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2255388E55
	for <live-patching@vger.kernel.org>; Fri, 19 Jun 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873565; cv=none; b=EGSMAkwMycXcam5fg+VsYkIMY3uKogtf51IWo6SYaX9kC5ws0qRB5Qt1+gS+iCAmefPEajYO54LDCW9VPugztBAgbS6AClZETRb1tXWLP0zhEW7ZX41Mf6wpAF2Kgzy43zysJPUtBosEkylb2QgiIlfG58lnQ7BtFSTQvdrtKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873565; c=relaxed/simple;
	bh=gS344rqBaOfPtMyJsIU+dq4Kf5tEDY+PnQYW8VOmWQ8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gLPMvZKFQHR4h85ts0Q+H6rwBp8shctfr4RECEafGueGdIzOjT5bOyZU7h5zg3PgCRT9eY75Wbs0kXJfzqbLbbiYYkzhL3YskFo1phnPbTjQ8O8Ezaah0sgDkSCnx7PlJG9OCVbZOX1suktuf8syNllRVzPkG53AIO1enHrZb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tDVGQWQO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gBVKFEfq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tDVGQWQO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gBVKFEfq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDVGQWQO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gBVKFEfq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDVGQWQO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gBVKFEfq"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6C61B75D6E;
	Fri, 19 Jun 2026 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781873555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10MybaT8uhwU4FwKD/1Am9bdRifrNZCBHaBCJsY2cfw=;
	b=tDVGQWQOA8kKFACOY+RjR2OiLqt3mxh+SwNdq+LPD2Cwr6AvdJPw1IHHiqEyNhrMzqQjmW
	kGdjJrFZb5oHyttXzE+xkCgp5pTHRliH96RCCed0nH2j7amccJvmUM+ekgMyoL8bfEabz+
	lV0MwpC1eVZerLMn8i6LYYGe2pPSlrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781873555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10MybaT8uhwU4FwKD/1Am9bdRifrNZCBHaBCJsY2cfw=;
	b=gBVKFEfqAeKBWijNpzZIDTjDjHHRzkivruNesExmWmHb1NX+H2czjZm4Imxjo8S8Z0ab+o
	vU7tDN2ae+sqX0CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tDVGQWQO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gBVKFEfq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781873555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10MybaT8uhwU4FwKD/1Am9bdRifrNZCBHaBCJsY2cfw=;
	b=tDVGQWQOA8kKFACOY+RjR2OiLqt3mxh+SwNdq+LPD2Cwr6AvdJPw1IHHiqEyNhrMzqQjmW
	kGdjJrFZb5oHyttXzE+xkCgp5pTHRliH96RCCed0nH2j7amccJvmUM+ekgMyoL8bfEabz+
	lV0MwpC1eVZerLMn8i6LYYGe2pPSlrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781873555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10MybaT8uhwU4FwKD/1Am9bdRifrNZCBHaBCJsY2cfw=;
	b=gBVKFEfqAeKBWijNpzZIDTjDjHHRzkivruNesExmWmHb1NX+H2czjZm4Imxjo8S8Z0ab+o
	vU7tDN2ae+sqX0CQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/4] selftests: livepatch: Add information about
 minimum kernel support
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 marcos@mpdesouza.com
In-Reply-To: <aiLn4slwOcpXhDhn@pathway.suse.cz>
References: <20260524-livepatch-unload-on-fail-v1-0-7465de7f741d@suse.com>
 <20260524-livepatch-unload-on-fail-v1-4-7465de7f741d@suse.com>
 <aiLn4slwOcpXhDhn@pathway.suse.cz>
Date: Fri, 19 Jun 2026 14:52:30 +0200
Message-Id: <178187355038.95039.14074541772688700998.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=gS344rqBaOfPtMyJsIU+dq4Kf5tEDY+PnQYW8VOmWQ8=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhixT6z6mCe/eJ/rO56ssFn4YuaWGIVySe/350lXfSn5FO
 DH9qs3sZPRnYWDkYLAUU2R5vddZznBKroFm9bu7MINYmUCmSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAU53CxsHQx6UzK3pVmIKcQwPHvmf7Z8ZPtDy4t0TOof6OoU/4xbi4Z6m78n/w5f0
 U3rHNU0VxpkucvcXEyCLG6dwn5K7+PRFyeGLFodMv//5eJqL3RHRFxjKrSqZYtoORUbL/J96TYH
 9869+ziP1v39SvshXZfvFC4OwnM85J9scEbFh2a/Fd+dCV5dLXE63zDkVvPHh0/55lUZZ57Ts7E
 j+kzDoQdj3z68tzF8KzvKJm1q/UfnXgxybeI5GyHw6Ib6nN3HUxWfzfp6AID5FdHIZff2ptDTH6
 If/I6MH8daUPTudEh7Izdhxhmt7T/11+6YSl245aqKhGTsmb+MVu0hqZvxzMHTwMyqfllvNUm+t
 4futsAwA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: *****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.29 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.90)[0.966];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 6C61B75D6E
X-Spam-Score: 17.29
X-Spam: Yes

On 2026-06-05 17:14:42+02:00, Petr Mladek wrote:
> On Sun 2026-05-24 20:50:33, Marcos Paulo de Souza wrote:
> 
> > The current livepatch selftests are compatible with kernel 4.12, so add
> > a note about it for future developers willing to contribute with new
> > tests.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  tools/testing/selftests/livepatch/README | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
> > index d2035dd64a2b..293f4730b927 100644
> > --- a/tools/testing/selftests/livepatch/README
> > +++ b/tools/testing/selftests/livepatch/README
> > @@ -54,3 +54,6 @@ check_result().  The latter function greps the kernel's ring buffer for
> >  those strings for result comparison.  Other utility functions include
> >  general module loading and livepatch loading helpers (waiting for patch
> >  transitions, sysfs entries, etc.)
> > +
> > +All new tests and test modules MUST be compatible with kernel version 4.12 and
> > +later, including current upstream kernels.
> 
> I do not have a good feeling about this. One thing is to accept fixes/workarounds
> for the backward compatibility. But forcing contributors to keep the
> compatibility might be too demanding.

I agree. This patch should be dropped. I think that the first two of the
series make sense on their own since the cleanup is a reasonable thing
to do in general. The third one is in "why not" area. But this one is
wrong. Sashiko summed it up well.

> I might be wrong. But I think that you would need a pretty old
> userspace to run 4.12 kernel. And most people could not get it easily.
> 
> Honestly, I though more about this effort and I am not sure how
> complicated it would be in the long term.
> 
> I know about two pending patchsets which are breaking the backward
> compatibility:
> 
>   + Better integration of callbacks and shadow variables with the states API [1]
>   + Introduce replace set support [2]
> 
> Especially the 1st one is a pain. It is 19th patches and most of them
> are fixing/reworking the selftests. I think that it was the reason
> why nobody reviewed it yet. And it might be even worse if we wanted
> to make it backward compatible.

I would not be too bothered about it. If keeping the backward
compatibility is difficult, it could be put aside. This patch set is not
that complicated and I think that it can be sold like reasonable changes
on their own.


