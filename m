Return-Path: <SRS0=hm6k=YS=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE2DCA9EA0
	for <live-patching@archiver.kernel.org>; Fri, 25 Oct 2019 06:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849E42070B
	for <live-patching@archiver.kernel.org>; Fri, 25 Oct 2019 06:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405369AbfJYGpB (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:45:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:44716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733071AbfJYGpA (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 25 Oct 2019 02:45:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94316AD26;
        Fri, 25 Oct 2019 06:44:58 +0000 (UTC)
Date:   Fri, 25 Oct 2019 08:44:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191025064456.6jjrngm4m3mspaxw@pathway.suse.cz>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191023114835.GT1817@hirez.programming.kicks-ass.net>
 <20191023170025.f34g3vxaqr4f5gqh@treble>
 <20191024131634.GC4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024131634.GC4131@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu 2019-10-24 15:16:34, Peter Zijlstra wrote:
> On Wed, Oct 23, 2019 at 12:00:25PM -0500, Josh Poimboeuf wrote:
> 
> > > This then raises a number of questions:
> > > 
> > >  1) why is that RELA (that obviously does not depend on any module)
> > >     applied so late?
> > 
> > Good question.  The 'pv_ops' symbol is exported by the core kernel, so I
> > can't see any reason why we'd need to apply that rela late.  In theory,
> > kpatch-build isn't supposed to convert that to a klp rela.  Maybe
> > something went wrong in the patch creation code.
> > 
> > I'm also questioning why we even need to apply the parainstructions
> > section late.  Maybe we can remove that apply_paravirt() call
> > altogether, along with .klp.arch.parainstruction sections.

Hmm, the original bug report against livepatching was actually about
paravirt ops, see below.


> > I'll need to look into it...
> 
> Right, that really should be able to run early. Esp. after commit
> 
>   11e86dc7f274 ("x86/paravirt: Detect over-sized patching bugs in paravirt_patch_call()")
> 
> paravirt patching is unconditional. We _never_ run with the indirect
> call except very early boot, but modules should have them patched way
> before their init section runs.
> 
> We rely on this for spectre-v2 and friends.

Livepatching has the same requirement. The module code has to be fully
livepatched before the module gets actually used. It means before
mod->init() is called and before the module is moved into
MODULE_STATE_LIVE state.


> > >  3) Is there ever a possible module-dependent RELA to a paravirt /
> > >     alternative site?
> > 
> > Good question...
> 
> > > Then for 3) we only have alternatives left, and I _think_ it unlikely to
> > > be the case, but I'll have to have a hard look at that.
> > 
> > I'm not sure about alternatives, but maybe we can enforce such
> > limitations with tooling and/or kernel checks.
> 
> Right, so on IRC you implied you might have some additional details on
> how alternatives were affected; did you manage to dig that up?

I am not sure what Josh had in mind. But the problem with livepatches,
paravort ops, and alternatives was described in the related patchset, see
https://lkml.kernel.org/r/1471481911-5003-1-git-send-email-jeyu@redhat.com

The original bug report is
https://lkml.kernel.org/r/20160329120518.GA21252@canonical.com

Best Regards,
Petr
