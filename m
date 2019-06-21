Return-Path: <SRS0=yIww=UU=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC5C43613
	for <live-patching@archiver.kernel.org>; Fri, 21 Jun 2019 11:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6202084E
	for <live-patching@archiver.kernel.org>; Fri, 21 Jun 2019 11:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFUL2A (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:28:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfFUL2A (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 21 Jun 2019 07:28:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D351FAF8A;
        Fri, 21 Jun 2019 11:27:58 +0000 (UTC)
Date:   Fri, 21 Jun 2019 13:27:58 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/5] livepatch: Allow to distinguish different version of
 system state changes
In-Reply-To: <20190611135627.15556-4-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1906211326140.5415@pobox.suse.cz>
References: <20190611135627.15556-1-pmladek@suse.com> <20190611135627.15556-4-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

> +/* Check if the patch is able to deal with the given system state. */
> +static bool klp_is_state_compatible(struct klp_patch *patch,
> +                                 struct klp_state *state)
> +{
> +     struct klp_state *new_state;
> +
> +     new_state = klp_get_state(patch, state->id);
> +
> +     if (new_state)
> +             return new_state->version < state->version ? false : true;

return new_state->version >= state->version;

?

> +     /* Cumulative livepatch must handle all already modified states. 
*/
> +     return patch->replace ? false : true;

return !patch->replace;

?

> + * Check if the new livepatch will not break the existing system states.
> + * Cumulative patches must handle all already modified states.
> + * Non-cumulative patches can touch already modified states.
> + */
> +bool klp_is_patch_compatible(struct klp_patch *patch)

make C=1 kernel/livepatch/state.o

kernel/livepatch/state.c:107:6: warning: symbol 'klp_is_patch_compatible' was not declared. Should it be static?

#include "state.h" in state.c would solve it.

Miroslav
