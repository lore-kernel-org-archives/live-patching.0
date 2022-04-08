Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E69C433EF
	for <live-patching@archiver.kernel.org>; Fri,  8 Apr 2022 17:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiDHSAV (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiDHSAU (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 8 Apr 2022 14:00:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32FB2149671;
        Fri,  8 Apr 2022 10:58:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B1431042;
        Fri,  8 Apr 2022 10:58:15 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC193F5A1;
        Fri,  8 Apr 2022 10:58:13 -0700 (PDT)
Date:   Fri, 8 Apr 2022 18:58:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     broonie@kernel.org, jpoimboe@redhat.com, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 06/11] arm64: Use stack_trace_consume_fn and rename
 args to unwind()
Message-ID: <YlB3sL0ExhWPPhay@lakrids>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220117145608.6781-1-madvenka@linux.microsoft.com>
 <20220117145608.6781-7-madvenka@linux.microsoft.com>
 <YgutJKqYe8ss8LLd@FVFF77S0Q05N>
 <845e4589-97d9-5371-3a0e-f6e05919f32d@linux.microsoft.com>
 <YlBKUtLN5+wpuyLi@lakrids>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlBKUtLN5+wpuyLi@lakrids>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Apr 08, 2022 at 03:44:34PM +0100, Mark Rutland wrote:
> On Mon, Mar 07, 2022 at 10:51:38AM -0600, Madhavan T. Venkataraman wrote:
> > Hey Mark Rutland, Mark Brown,
> > 
> > Could you please review the rest of the patches in the series when you can?
> 
> Sorry, I was expecting a new version with some of my comments
> addressed, in case that had effects on subsequent patches.
> 
> > Also, many of the patches have received a Reviewed-By from you both.
> > So, after I send the next version out, can we upstream those ones?
> 
> I would very much like to upstream the ones I have given a Reviewed-by.
> 
> Given those were conditional on some adjustments (e.g. actually filling
> out comments), do you mind if I pick those into a series now?

FWIW, I've picked up the set I'm trivially happy with, rebased that on
v5.18-rc1, and put that on a branch with a couple of other cleanups:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/stacktrace/cleanups

I'll send that out on Monday if there are no objections.

Thanks,
Mark.
