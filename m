Return-Path: <SRS0=pVyr=7O=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F7C433E1
	for <live-patching@archiver.kernel.org>; Mon,  1 Jun 2020 11:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C88C207DF
	for <live-patching@archiver.kernel.org>; Mon,  1 Jun 2020 11:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFALjh (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:39:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALjh (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 1 Jun 2020 07:39:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16313AEDE;
        Mon,  1 Jun 2020 11:39:38 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:39:35 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Yannick Cote <ycote@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 3/4] selftests/livepatch: more verification in
 test-klp-shadow-vars
In-Reply-To: <20200528134849.7890-4-ycote@redhat.com>
Message-ID: <alpine.LSU.2.21.2006011337560.2043@pobox.suse.cz>
References: <20200528134849.7890-1-ycote@redhat.com> <20200528134849.7890-4-ycote@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Noticed one more thing nevertheless...

> +	/* pass 6: free all the <objs[*], SV_ID2> svar pairs too. */
> +	shadow_free_all(SV_ID2, NULL);		/* 'int' pairs */
> +	for (i = 0; i < NUM_OBJS; i++) {
> +		sv = shadow_get(&objs[i], SV_ID2);
> +		if (!sv)
> +			pr_info("  shadow_get() got expected NULL result\n");
> +	}

I think that shadow_get() should be removed from the message to make it 
consistent with the rest.

Miroslav
