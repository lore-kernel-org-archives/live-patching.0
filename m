Return-Path: <SRS0=7oZY=EE=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A047AC55178
	for <live-patching@archiver.kernel.org>; Thu, 29 Oct 2020 10:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524BE21582
	for <live-patching@archiver.kernel.org>; Thu, 29 Oct 2020 10:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgJ2KEu (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:04:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgJ2KEu (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 29 Oct 2020 06:04:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B12EAB0E;
        Thu, 29 Oct 2020 10:04:48 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:04:48 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH] Documentation: livepatch: document reliable stacktrace
In-Reply-To: <20201023153527.36346-1-mark.rutland@arm.com>
Message-ID: <alpine.LSU.2.21.2010291104330.1688@pobox.suse.cz>
References: <20201023153527.36346-1-mark.rutland@arm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi,

On Fri, 23 Oct 2020, Mark Rutland wrote:

> Add documentation for reliable stacktrace. This is intended to describe
> the semantics and to be an aid for implementing architecture support for
> HAVE_RELIABLE_STACKTRACE.

thanks a lot for doing the work!

> Unwinding is a subtle area, and architectures vary greatly in both
> implementation and the set of concerns that affect them, so I've tried
> to avoid making this too specific to any given architecture. I've used
> examples from both x86_64 and arm64 to explain corner cases in more
> detail, but I've tried to keep the descriptions sufficient for those who
> are unfamiliar with the particular architecture.

Yes, I think it is a good approach. We can always add more details later, 
but it would probably cause more confusion for those unfamiliar.

> I've tried to give rationale for all the recommendations/requirements,
> since that makes it easier to spot nearby issues, or when a check
> happens to catch a few things at once. I believe what I have written is
> sound, but as some of this was reverse-engineered I may have missed
> things worth noting.
> 
> I've made a few assumptions about preferred behaviour, notably:
> 
> * If you can reliably unwind through exceptions, you should (as x86_64
>   does).

Yes, it does. I think (and Josh will correct me if I am wrong here), that 
even at the beginning the intention was to improve the reliability of 
unwinding in general. Both x86_64 and s390x are the case. _reliable() 
interface only takes an advantage of that. As you pointed out in the 
document, unwinding through exceptions is not necessary. It can be 
reported as unreliable and we can deal with that later. But it is always 
better to do it if possible.

powerpc is an exception to the approach, because it implements its 
_reliable() API from the scratch.

> * It's fine to omit ftrace_return_to_handler and other return
>   trampolines so long as these are not subject to patching and the
>   original return address is reported. Most architectures do this for
>   ftrace_return_handler, but not other return trampolines.

Yes. Patching a trampoline is not something I can imagine, so that should 
not be a problem. But one never knows and we may run into a problem here 
easily. I don't remember if we even audited all the trampolines. And new 
ones are introduced all the time.

> * For cases where link register unreliability could result in duplicate
>   entries in the trace or an inverted trace, I've assumed this should be
>   treated as unreliable. This specific case shouldn't matter to
>   livepatching, but I assume that that we want a reliable trace to have
>   the correct order.

Agreed.

Thanks
Miroslav
