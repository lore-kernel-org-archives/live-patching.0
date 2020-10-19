Return-Path: <SRS0=yNLB=D2=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C7AC43457
	for <live-patching@archiver.kernel.org>; Mon, 19 Oct 2020 23:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC0D2223C
	for <live-patching@archiver.kernel.org>; Mon, 19 Oct 2020 23:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtvQ/iZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbgJSXmH (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726995AbgJSXmH (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 19 Oct 2020 19:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603150926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy5Toxs0EKUklsBebnq/S505L/qncNcBB4kBuZErIU4=;
        b=BtvQ/iZFzzBuImHx+OBCtwvnzG6jFOCbUcGVTNJPk7Dq/CLiycqHQyPfX+A3ZKW3TOV2GS
        tXsegDwCF4e6m+oS2teeAMUTKqY4tm3YLU/U3C9PYIes4BTkdpnTRLp/6U8ZrfkT2ddlOB
        af8qs0L/Z26x+L8jZE4IAAmZ7h/ezTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-eEQdHWqWM7OJlXKeoomt-g-1; Mon, 19 Oct 2020 19:42:02 -0400
X-MC-Unique: eEQdHWqWM7OJlXKeoomt-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1C3E1895806;
        Mon, 19 Oct 2020 23:42:00 +0000 (UTC)
Received: from treble (ovpn-112-186.rdu2.redhat.com [10.10.112.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C6501002C03;
        Mon, 19 Oct 2020 23:41:58 +0000 (UTC)
Date:   Mon, 19 Oct 2020 18:41:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] arm64: Implement reliable stack trace
Message-ID: <20201019234155.q26jkm22fhnnztiw@treble>
References: <20201012172605.10715-1-broonie@kernel.org>
 <alpine.LSU.2.21.2010151533490.14094@pobox.suse.cz>
 <20201015141612.GC50416@C02TD0UTHF1T.local>
 <20201015154951.GD4390@sirena.org.uk>
 <20201015212931.mh4a5jt7pxqlzxsg@treble>
 <20201016121534.GC5274@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016121534.GC5274@sirena.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Oct 16, 2020 at 01:15:34PM +0100, Mark Brown wrote:
> 
> Yes, exactly - just copying the existing implementations and hoping that
> it's sensible/relevant and covers everything that's needed.  It's not
> entirely clear what a reliable stacktrace is expected to do that a
> normal stacktrace doesn't do beyond returning an error code.

While in the end there may not be much of a difference between normal
and reliable stacktraces beyond returning an error code, it still
requires beefing up the unwinder's error detection abilities.

> > > The searching for a defined thread entry point for example isn't
> > > entirely visible in the implementations.
> 
> > For now I'll speak only of x86, because I don't quite remember how
> > powerpc does it.
> 
> > For thread entry points, aka the "end" of the stack:
> 
> > - For ORC, the end of the stack is either pt_regs, or -- when unwinding
> >   from kthreads, idle tasks, or irqs/exceptions in entry code --
> >   UNWIND_HINT_EMPTY (found by the unwinder's check for orc->end.
> 
> >   [ Admittedly the implementation needs to be cleaned up a bit.  EMPTY
> >     is too broad and needs to be split into UNDEFINED and ENTRY. ]
> 
> > - For frame pointers, by convention, the end of the stack for all tasks
> >   is a defined stack offset: end of stack page - sizeof(pt_regs).
> 
> > And yes, all that needs to be documented.
> 
> Ah, I'd have interpreted "defined thread entry point" as meaning
> expecting to find specific functions appering at the end of the stack
> rather than meaning positively identifying the end of the stack - for
> arm64 we use a NULL frame pointer to indicate this in all situations.
> In that case that's one bit that is already clear.

I think a NULL frame pointer isn't going to be robust enough.  For
example NULL could easily be introduced by a corrupt stack, or by asm
frame pointer misuse.

-- 
Josh

