Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C1C25B0D
	for <live-patching@archiver.kernel.org>; Tue, 16 Aug 2022 00:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348265AbiHPAeP (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 15 Aug 2022 20:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiHPAcw (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 15 Aug 2022 20:32:52 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 13:37:00 PDT
Received: from out.bound.email (out.bound.email [141.193.244.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374F9186EB4;
        Mon, 15 Aug 2022 13:37:00 -0700 (PDT)
Received: from mail.sventech.com (localhost [127.0.0.1])
        by out.bound.email (Postfix) with ESMTP id 1F2328A03AB;
        Mon, 15 Aug 2022 13:29:47 -0700 (PDT)
Received: by mail.sventech.com (Postfix, from userid 1000)
        id 059F816006D1; Mon, 15 Aug 2022 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
        s=default; t=1660595387;
        bh=a9t+6RNGLlnq/PvQKr+rFvGqP5Pb1q0DuTGheD0/zTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYkfrHqepJQerEQIuDq4P7SEZV1DMCF+s+4mksMat5gFAN6UQimvgkVfBAuSiBBu0
         u6mfqSMhuSCfVskrsMzd1XYGAbR870sR4R0FL/q80uFnXAhtkeNF59EqdFqYhg11iD
         vqectqARZvf5DdIn1v6tyA0PApviOBu05QkbYJzU=
Date:   Mon, 15 Aug 2022 13:29:46 -0700
From:   Johannes Erdfelt <johannes@erdfelt.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, live-patching@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: ftrace regression with CONFIG_UNWINDER_FRAME_POINTER
Message-ID: <20220815202946.GF3948@sventech.com>
References: <20220815195828.GE3948@sventech.com>
 <20220815160646.0dca7227@gandalf.local.home>
 <YvqpnfM9ZdRO6oXa@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvqpnfM9ZdRO6oXa@zn.tnic>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon, Aug 15, 2022, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Aug 15, 2022 at 04:06:46PM -0400, Steven Rostedt wrote:
> > On Mon, 15 Aug 2022 12:58:28 -0700
> > Johannes Erdfelt <johannes@erdfelt.com> wrote:
> > 
> > > I recently ran across an oops with ftrace when using the frame pointer
> > > unwinder. It does not affect Linus' tree (tested 6.0-rc1), but it does
> > > affect 5.15.60 and 5.10.136 (at least, have not tested other kernels).
> > > 
> > > It appears to be related to the recently merged retbleed mitigations,
> > 
> > If you believe this, then Cc those that are involved with those
> > mitigations, which I did.
> 
> Sounds like this one:
> 
> https://lore.kernel.org/all/Yu2H%2FRdg%2FU4bHWaY@quatroqueijos/

Ahh, I missed this in my search to see if this was posted already.

The patch in that post appears to solve the oops I'm seeing (at least
on top of 5.15.60).

JE

