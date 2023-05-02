Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB0DC77B7E
	for <live-patching@archiver.kernel.org>; Tue,  2 May 2023 17:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEBR4f (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 2 May 2023 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBR4f (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 2 May 2023 13:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67781A7
        for <live-patching@vger.kernel.org>; Tue,  2 May 2023 10:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 510FA61782
        for <live-patching@vger.kernel.org>; Tue,  2 May 2023 17:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EDBC433EF;
        Tue,  2 May 2023 17:56:32 +0000 (UTC)
Date:   Tue, 2 May 2023 13:56:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <song@kernel.org>
Cc:     live-patching@vger.kernel.org
Subject: Re: Question about inline, notrace, and livepatch
Message-ID: <20230502135630.580a98ea@gandalf.local.home>
In-Reply-To: <CAPhsuW58LYU8iRCjoeChCyQ_7gqZvp6_U-fJr2Crf6gOniA51g@mail.gmail.com>
References: <CAPhsuW58LYU8iRCjoeChCyQ_7gqZvp6_U-fJr2Crf6gOniA51g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, 2 May 2023 10:40:28 -0700
Song Liu <song@kernel.org> wrote:

> We hit the following hiccup a couple times in the past few months:
> 
> A function is marked as "inline", but the compiler decided not to inline it.
> Since "inline" implies "notrace" since [1], this function doesn't have
> fentry/mcount. When we built livepatch for this function, kpatch-build
> failed with:
> 
>    xxx.o: function yyy has no fentry/mcount call, unable to patch
> 
> This is not a deal breaker, as we can usually modify the patch to work
> around it. But I wonder whether we still need "inline" to imply "notrace".
> Can we remove this to make livepatch a little easier?

The history behind this is that there were cases that functions that were
inlined, were in critical paths that could cause crashes if they were
traced. In testing they never triggered because the developer's compiler
inlined them. Then on someone else's machine, the compiler decided not to
inline the function and the system crashed. It was hell to debug because I
was not able to reproduce the issue, as my compiler would always keep the
function inlined!

But a lot has changed since then. I've implemented the
"ftrace_test_recursion_trylock()" that catches pretty much all recursive
bugs (and can ever report when they happen). So I may be open to removing
the "notrace" from "inline".

-- Steve
