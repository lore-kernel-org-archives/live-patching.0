Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C2C433E6
	for <live-patching@archiver.kernel.org>; Mon,  1 Feb 2021 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D0A64E95
	for <live-patching@archiver.kernel.org>; Mon,  1 Feb 2021 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBALsg (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:48:36 -0500
Received: from verein.lst.de ([213.95.11.211]:40827 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhBALsd (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 1 Feb 2021 06:48:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD5826736F; Mon,  1 Feb 2021 12:47:49 +0100 (CET)
Date:   Mon, 1 Feb 2021 12:47:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 05/13] kallsyms: refactor
 {,module_}kallsyms_on_each_symbol
Message-ID: <20210201114749.GB19696@lst.de>
References: <20210128181421.2279-1-hch@lst.de> <20210128181421.2279-6-hch@lst.de> <YBPYyEvesLMrRtZM@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBPYyEvesLMrRtZM@alley>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Jan 29, 2021 at 10:43:36AM +0100, Petr Mladek wrote:
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -164,12 +164,8 @@ static int klp_find_object_symbol(const char *objname, const char *name,
> >  		.pos = sympos,
> >  	};
> >  
> > -	mutex_lock(&module_mutex);
> > -	if (objname)
> > +	if (objname || !kallsyms_on_each_symbol(klp_find_callback, &args))
> >  		module_kallsyms_on_each_symbol(klp_find_callback, &args);
> > -	else
> > -		kallsyms_on_each_symbol(klp_find_callback, &args);
> > -	mutex_unlock(&module_mutex);
> 
> This change is not needed. (objname == NULL) means that we are
> interested only in symbols in "vmlinux".
> 
> module_kallsyms_on_each_symbol(klp_find_callback, &args)
> will always fail when objname == NULL.

I just tried to keep the old behavior.  I can respin it with your
recommended change noting the change in behavior, though.
