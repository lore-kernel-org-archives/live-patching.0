Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D593C433E6
	for <live-patching@archiver.kernel.org>; Thu, 28 Jan 2021 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41F264DED
	for <live-patching@archiver.kernel.org>; Thu, 28 Jan 2021 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhA1QXh (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:23:37 -0500
Received: from verein.lst.de ([213.95.11.211]:57990 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhA1QX0 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 28 Jan 2021 11:23:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52BE468AFE; Thu, 28 Jan 2021 17:22:41 +0100 (CET)
Date:   Thu, 28 Jan 2021 17:22:40 +0100
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
Subject: Re: [PATCH 03/13] livepatch: refactor klp_init_object
Message-ID: <20210128162240.GA3417@lst.de>
References: <20210121074959.313333-1-hch@lst.de> <20210121074959.313333-4-hch@lst.de> <YBFjbbuQ7sn4T7yT@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBFjbbuQ7sn4T7yT@alley>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, Jan 27, 2021 at 01:58:21PM +0100, Petr Mladek wrote:
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -54,9 +54,6 @@ static void klp_find_object_module(struct klp_object *obj)
> >  {
> >  	struct module *mod;
> >  
> > -	if (!klp_is_module(obj))
> > -		return;
> > -
> 
> We need to either update the function description or keep this check.
> 
> I prefer to keep the check. The function does the right thing also
> for the object "vmlinux". Also the livepatch code includes many
> similar paranoid checks that makes the code less error prone
> against any further changes.

Well, the check is in the caller now where we have a conditional for
it.  So I'd be tempted to either update the comment, or just drop the
patch.
