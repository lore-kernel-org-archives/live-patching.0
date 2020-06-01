Return-Path: <SRS0=pVyr=7O=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B0BC433E1
	for <live-patching@archiver.kernel.org>; Mon,  1 Jun 2020 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140F420738
	for <live-patching@archiver.kernel.org>; Mon,  1 Jun 2020 11:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFAL15 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:27:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:53548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFAL15 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 1 Jun 2020 07:27:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8BDD1AC7D;
        Mon,  1 Jun 2020 11:27:57 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:27:55 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Yannick Cote <ycote@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 3/4] selftests/livepatch: more verification in
 test-klp-shadow-vars
In-Reply-To: <20200528134849.7890-4-ycote@redhat.com>
Message-ID: <alpine.LSU.2.21.2006011325170.2043@pobox.suse.cz>
References: <20200528134849.7890-1-ycote@redhat.com> <20200528134849.7890-4-ycote@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 28 May 2020, Yannick Cote wrote:

> This change makes the test feel more familiar with narrowing to a
> typical usage by operating on a number of identical structure instances
> and populating the same two new shadow variables symmetrically while
> keeping the same testing and verification criteria for the extra
> variables.

It changes the order of shadow vars allocation and freeing (now we 
allocate everything first, while previously the order was more 
complicated), but it does not matter, I think.

One nit below and I have to trust you with the output.
 
> Signed-off-by: Yannick Cote <ycote@redhat.com>
> ---
>  lib/livepatch/test_klp_shadow_vars.c          | 182 ++++++++----------
>  .../selftests/livepatch/test-shadow-vars.sh   |  85 +++++---
>  2 files changed, 135 insertions(+), 132 deletions(-)
> 
> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
> index ec2635cff974..195309e1edf3 100644
> --- a/lib/livepatch/test_klp_shadow_vars.c
> +++ b/lib/livepatch/test_klp_shadow_vars.c
> @@ -128,6 +128,11 @@ static int shadow_ctor(void *obj, void *shadow_data, void *ctor_data)
>  	return 0;
>  }
>  
> +/*
> + * With more than one item to free in the list, order is not determined and
> + * shadow_dtor will not be passed to shadow_free_all() which would make the
> + * test fail. (see pass 6)
> + */
>  static void shadow_dtor(void *obj, void *shadow_data)
>  {
>  	int **sv = shadow_data;
> @@ -136,6 +141,9 @@ static void shadow_dtor(void *obj, void *shadow_data)
>  		__func__, ptr_id(obj), ptr_id(sv));
>  }
>  
> +/* number of objects we simulate that need kpatch-patch shadow vars */

s/kpatch-patch// ?

Miroslav
