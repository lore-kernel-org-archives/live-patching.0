Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84829C433E0
	for <live-patching@archiver.kernel.org>; Wed,  3 Feb 2021 10:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E7164F58
	for <live-patching@archiver.kernel.org>; Wed,  3 Feb 2021 10:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhBCKug (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 3 Feb 2021 05:50:36 -0500
Received: from verein.lst.de ([213.95.11.211]:50554 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233587AbhBCKuf (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 3 Feb 2021 05:50:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3433A6736F; Wed,  3 Feb 2021 11:49:50 +0100 (CET)
Date:   Wed, 3 Feb 2021 11:49:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 02/13] drm: remove drm_fb_helper_modinit
Message-ID: <20210203104949.GA9909@lst.de>
References: <20210128181421.2279-1-hch@lst.de> <20210128181421.2279-3-hch@lst.de> <YBp8ShiKbQSPCcRx@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBp8ShiKbQSPCcRx@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, Feb 03, 2021 at 11:34:50AM +0100, Daniel Vetter wrote:
> On Thu, Jan 28, 2021 at 07:14:10PM +0100, Christoph Hellwig wrote:
> > drm_fb_helper_modinit has a lot of boilerplate for what is not very
> > simple functionality.  Just open code it in the only caller using
> > IS_ENABLED and IS_MODULE, and skip the find_module check as a
> > request_module is harmless if the module is already loaded (and not
> > other caller has this find_module check either).
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Hm I thought I've acked this one already somewhere for merging through
> your tree.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

The difference is that this new version loses the find_module entirely,
while the previous one replaced it with the module_loaded helper that
didn't make it to the second version of the series.
