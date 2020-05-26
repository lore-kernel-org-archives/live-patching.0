Return-Path: <SRS0=p8yD=7I=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91ACC433E0
	for <live-patching@archiver.kernel.org>; Tue, 26 May 2020 16:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F71D20721
	for <live-patching@archiver.kernel.org>; Tue, 26 May 2020 16:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgEZQju (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 26 May 2020 12:39:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgEZQju (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 26 May 2020 12:39:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FAADAD18;
        Tue, 26 May 2020 16:39:51 +0000 (UTC)
Date:   Tue, 26 May 2020 18:39:47 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mjambor@suse.cz,
        mliska@suse.cz, pmladek@suse.cz, live-patching@vger.kernel.org
Subject: Re: linux-next: Tree for May 21 (objtool warnings)
In-Reply-To: <20200526140113.ppjywpx7uir3vrlj@treble>
Message-ID: <alpine.LSU.2.21.2005261809480.22611@pobox.suse.cz>
References: <20200522001209.07c19400@canb.auug.org.au> <22332d9b-5e9f-5474-adac-9b3e39861aee@infradead.org> <alpine.LSU.2.21.2005251101030.24984@pobox.suse.cz> <alpine.LSU.2.21.2005251303430.24984@pobox.suse.cz> <20200526140113.ppjywpx7uir3vrlj@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, 26 May 2020, Josh Poimboeuf wrote:

> On Mon, May 25, 2020 at 01:07:27PM +0200, Miroslav Benes wrote:
> > > I'll try to find out which optimization does this, because it is a 
> > > slightly different scenario than hiding __noreturn from the callees. 
> > > Probably -fno-ipa-pure-const again.
> > 
> > And it is indeed -fno-ipa-pure-const again.
> 
> It still seems odd to me that GCC's dead end detection seems to break
> with -fno-ipa-pure-const.  Do you know if these issues can be fixed on
> the GCC side?

It is odd. I asked Martin and Martin about that yesterday (CCed). It could 
be possible to enable just noreturn propagation for -flive-patching if I 
understood correctly. The attribute would need to be preserved in a 
patched function then, but that should be manageable.

Marking functions as __noreturn is one thing (I think it is useful on its 
own as mentioned in the older thread about -flive-patching), but 
__always_inline solution in this case is really arbitrary. I don't like 
this neverending "battle" with compilers much, so it would be nice to have 
some kind of generic solution (and I currently have no idea about that). 
Of course, declaring -flive-patching a failed experiment is an option if 
there is not a better way to deal with a dead end detection either in GCC 
or in objtool. I would not like it, but you're right that if there are 
more and more problems like this appearing, we'll have to deal with 
maintainers all over the place and ask them to maintain odd fixes just for 
the sake of -flive-patching. I don't know what the current numbers are 
though. We'd have to approach the problem of GCC optimizations from a 
different angle. Petr CCed (we talked about it yesterday as well).

But first, let's try to find a way with -flive-patching.

Reduced test case follows (courtesty of Martin Liska):

$ cat open.i
int global;

void
break_deleg_wait()
{
  asm(".byte 15, 0x0b");
  __builtin_unreachable();
}

void chmod_common_delegated_inode(int arg)
{
retry_deleg:
  if (arg)
    break_deleg_wait(global);
  else
    return;
  goto retry_deleg;
}

$ gcc open.i -c -Os -fno-omit-frame-pointer -fno-ipa-pure-const && ./tools/objtool/objtool check open.o
open.o: warning: objtool: chmod_common_delegated_inode()+0x18: unreachable instruction

$ gcc open.i -c -Os -fno-omit-frame-pointer && ./tools/objtool/objtool check open.o
[OK]
---

So it is a similar problem. There is no noreturn attribute anywhere 
(nothing to propagate from a caller to a callee). Here, the information 
about an unreachable code is not propagated to the caller 
(chmod_common_delegated_inode()).

Martins, would it be possible to extend -flive-patching to deal with this?

Miroslav
