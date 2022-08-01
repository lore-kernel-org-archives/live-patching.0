Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0889BC19F2C
	for <live-patching@archiver.kernel.org>; Mon,  1 Aug 2022 10:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiHAKbM (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiHAKbA (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 1 Aug 2022 06:31:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64BA10A7;
        Mon,  1 Aug 2022 03:30:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7039A6128C;
        Mon,  1 Aug 2022 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659349858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KFL/UZ2cSRuWnTmKjPcSAQqZJi6ts+dtgNTvnKokhY=;
        b=hTgQkyrBVd2yveUuNgnQQTeHUO9OLojSTWe4JMzxSce6GiEtexMAG3OkIxidd10S9whg2E
        4ODhaIRRE4voNbbfB6R+0owqLoySs4D+bN8T2O8QVlJhLb554tijnlHgjbDNcPTXwLABrk
        FG3fNXEnscV+vL7QQry6o/qFMj7BgYY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E23D2C141;
        Mon,  1 Aug 2022 10:30:58 +0000 (UTC)
Date:   Mon, 1 Aug 2022 12:30:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Song Liu <song@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        live-patching@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3] livepatch: Clear relocation targets on a module
 removal
Message-ID: <YuerYVD+C3XVzDAi@alley>
References: <20220721175147.214642-1-song@kernel.org>
 <20220726233302.zwloxsammnu7clu4@treble>
 <CAPhsuW7tmRt=yx1+i62HPRJJ4Gp8xB_3XvpVxUC=SyGv6iCBEQ@mail.gmail.com>
 <CAPhsuW4F8f9GLHF9C54oWyFiyJ0eT5HOwfhmoxSJ3HeRr8zCSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4F8f9GLHF9C54oWyFiyJ0eT5HOwfhmoxSJ3HeRr8zCSw@mail.gmail.com>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Sat 2022-07-30 15:32:58, Song Liu wrote:
> On Tue, Jul 26, 2022 at 8:54 PM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, Jul 26, 2022 at 4:33 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >
> > > On Thu, Jul 21, 2022 at 10:51:47AM -0700, Song Liu wrote:
> > > > From: Miroslav Benes <mbenes@suse.cz>
> > > >
> > > > Josh reported a bug:
> > > >
> > > >   When the object to be patched is a module, and that module is
> > > >   rmmod'ed and reloaded, it fails to load with:
> > > >
> > > >   module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 2, loc 00000000ba0302e9, val ffffffffa03e293c
> > > >   livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
> > > >   livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'
> > > >
> > > >   The livepatch module has a relocation which references a symbol
> > > >   in the _previous_ loading of nfsd. When apply_relocate_add()
> > > >   tries to replace the old relocation with a new one, it sees that
> > > >   the previous one is nonzero and it errors out.
> > > >
> > > >   On ppc64le, we have a similar issue:
> > > >
> > > >   module_64: livepatch_nfsd: Expected nop after call, got e8410018 at e_show+0x60/0x548 [livepatch_nfsd]
> > > >   livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
> > > >   livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'
> > > >
> > > 2) We can't only fix x86, powerpc also needs a fix.
> >
> > I have very little experience with powerpc. Would someone be willing to
> > help with powerpc part of this?
> 
> I guess folks are all busy. Any suggestions on how to test powerpc changes?

You might also send the patch and just mention that you were not able
to test it on powerpc. There are people with access to powerpc that
might check it.

Another question is how to actually test it. I wonder how you do
it for x86.

Finally, also s390 supports livepatching. I guess that the problem is
there as well. Is is straightforward to write the revert code, please?

Best Regards,
Petr
