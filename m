Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AA7C05027
	for <live-patching@archiver.kernel.org>; Thu, 26 Jan 2023 09:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbjAZJgn (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjAZJgI (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 26 Jan 2023 04:36:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800053CE38;
        Thu, 26 Jan 2023 01:36:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 147DE21E73;
        Thu, 26 Jan 2023 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674725763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yFqWFYQYUk3yK1YfDXYbqFhJNdWd1WcTWR/liQbB7ys=;
        b=nOYZatxBrP32EKVhvlZGjGpOLXPtC6ue9r6LR3sVv8MY+l8M+vYYsiy1ASevRplX0LS2Xz
        dyUb50ZWaqkDjrw2uPJngtbvxS6q5PX4tRv8YM2m71g3VjOa0dyFaKhXa5w8/u1o7xTOjB
        WoMWIql9I1L10zZeqQFLBcnC7Qzct2w=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA5CA2C141;
        Thu, 26 Jan 2023 09:36:02 +0000 (UTC)
Date:   Thu, 26 Jan 2023 10:36:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nicolai Stange <nstange@suse.de>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jpoimboe@redhat.com, joe.lawrence@redhat.com
Subject: Re: [PATCH v2 4/4] livepatch/shadow: Add garbage collection of
 shadow variables
Message-ID: <Y9JJgGY5sWq+1+mn@alley>
References: <20221026194122.11761-1-mpdesouza@suse.com>
 <20221026194122.11761-5-mpdesouza@suse.com>
 <20221104010327.wa256pos75dczt4x@treble>
 <Y2TooogxxLTIkBcj@alley>
 <878rkhyhhv.fsf@linux.fritz.box>
 <Y24cGpeO8UHeiKGl@alley>
 <20221113185138.oob2o3sevbgud5vs@treble>
 <Y8a4ZQ0sm5AOnY7R@alley>
 <20230125232248.inewq5tlpwfk3rny@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125232248.inewq5tlpwfk3rny@treble>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed 2023-01-25 15:22:48, Josh Poimboeuf wrote:
> On Tue, Jan 17, 2023 at 04:01:57PM +0100, Petr Mladek wrote:
> > IMHO, this is the reason why we should make it per-object.
> > 
> > If the shadow variable was used by a livepatched module and we remove
> > this module then the shadow variables would get unmaintained. It would
> > results in the problem described in this paragraph.
> 
> Yes, that makes sense.  Ok, I'm convinced.

Thanks!

> BTW, this is yet another unfortunate consequence of our decision many
> years ago to break the module dependency between a livepatch module and
> the modules it patches.  We already have a lot of technical debt as a
> result of that decision and it continues to pile up.
> 
> In that vein see also Song's and my recent patches to fix module
> re-patching.

Yeah. Just for record, I have played with splitting the livepatch module
some years ago. It was quite tricky. The main problem was loading all
the needed livepatch modules and synchronizing their load with the
livepatched modules.

Few more details were mentioned in
https://lore.kernel.org/r/Ytp+u2mGPk5+7Tvf@alley

Best Regards,
Petr
