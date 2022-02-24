Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3731C433EF
	for <live-patching@archiver.kernel.org>; Thu, 24 Feb 2022 15:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiBXPSA (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiBXPRz (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 24 Feb 2022 10:17:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF957179;
        Thu, 24 Feb 2022 07:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65086B82695;
        Thu, 24 Feb 2022 15:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD497C340E9;
        Thu, 24 Feb 2022 15:17:20 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:17:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>
Subject: Re: [PATCH v2 02/13] tracing: Fix selftest config check for
 function graph start up test
Message-ID: <20220224101719.51eafc60@gandalf.local.home>
In-Reply-To: <9e62f80a-86b1-05d7-d5b7-a209b2c4f106@csgroup.eu>
References: <cover.1640017960.git.christophe.leroy@csgroup.eu>
        <bdc7e594e13b0891c1d61bc8d56c94b1890eaed7.1640017960.git.christophe.leroy@csgroup.eu>
        <74775d33-2e54-96ab-4546-57eb2c9e50e0@csgroup.eu>
        <20220224095316.67729e2b@gandalf.local.home>
        <9e62f80a-86b1-05d7-d5b7-a209b2c4f106@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 24 Feb 2022 15:13:12 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> > But I'm working on a series to send to Linus. I can pick this patch up, as
> > it touches just my code.
> >   
> 
> That would be great, thanks.

It's in my queue and running through my tests, which take 7 to 13 hours to
complete (depending on the changes).

-- Steve
