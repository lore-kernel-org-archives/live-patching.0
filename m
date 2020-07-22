Return-Path: <SRS0=8KIh=BB=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B53C433E1
	for <live-patching@archiver.kernel.org>; Wed, 22 Jul 2020 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFD3207DD
	for <live-patching@archiver.kernel.org>; Wed, 22 Jul 2020 14:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m6/oHRfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbgGVOj6 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732467AbgGVOj6 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 22 Jul 2020 10:39:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F293C0619DE
        for <live-patching@vger.kernel.org>; Wed, 22 Jul 2020 07:39:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so1353410pgc.13
        for <live-patching@vger.kernel.org>; Wed, 22 Jul 2020 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16Y8bWUyysyD6RX/r5XeFDtXgEqasoaIb5QlD/Fn9gY=;
        b=m6/oHRfM8k+Nz9zcIKR0qeNOD5tEEwDyDId3PTGUUDN4p9UGsI0fn00KoI9/QyQ1v8
         apM4heGRp20HL1suh7bRv/oYHQT+8FbwsOEUGzspMxDK5to8xMCVJ1IVeG4ELQ8PRnvM
         UVLan5R8bzs3XxdU33aX86W1aVtTlW0hiqd8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16Y8bWUyysyD6RX/r5XeFDtXgEqasoaIb5QlD/Fn9gY=;
        b=aiIXi3lQBTP2gezsZ5ozKmRpwiqigZZ/ongWLUCGbcMeyqBLcUgABXI9OscoKk0nNa
         H7tsLMdoqF6uC5/kpwNYD1BRd70FHz6R7VqS4pb/KddigG1TeSt8bmo1Xmxu41Mmm4kS
         0AFGje4qqtTQpnyvuQPBXWOS1XULMrO6/Quyq3WXMjW4ww2tEpKpEgG5WfMIfx238BdY
         az6QAz1e5btG6CgO3FzvZ3V6/g4yx4pBMQIZarNkMtdhqrCzeLH4vTLVW+IZQqMq8ACO
         6ReXZnOFRpTv8tjNcmNA0mUDz5s9SMDa05VcPt8Fa0r1UtuUbj/YbfhOuEmV8KWMajnJ
         Yl0w==
X-Gm-Message-State: AOAM530WmW+mIEabAsuaWnB0j7XCqw6gq4gNlmniITQAumo8DRTwQ5A9
        9QZMNSWny2DlYuElJIoqK17Usw==
X-Google-Smtp-Source: ABdhPJybf+F7pwNThVxNEaAxDjLaau/pl+1vyZd8ayI2jp7rUGVlHGz+ar7yf1UhbFootA15osR7TA==
X-Received: by 2002:aa7:9ac6:: with SMTP id x6mr3300pfp.326.1595428797861;
        Wed, 22 Jul 2020 07:39:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q17sm116352pfk.0.2020.07.22.07.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 07:39:56 -0700 (PDT)
Date:   Wed, 22 Jul 2020 07:39:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <202007220738.72F26D2480@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <alpine.LSU.2.21.2007221122110.10163@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2007221122110.10163@pobox.suse.cz>
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, Jul 22, 2020 at 11:27:30AM +0200, Miroslav Benes wrote:
> Let me CC live-patching ML, because from a quick glance this is something 
> which could impact live patching code. At least it invalidates assumptions 
> which "sympos" is based on.

In a quick skim, it looks like the symbol resolution is using
kallsyms_on_each_symbol(), so I think this is safe? What's a good
selftest for live-patching?

-- 
Kees Cook
