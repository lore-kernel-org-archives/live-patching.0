Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A0C433E0
	for <live-patching@archiver.kernel.org>; Thu,  4 Feb 2021 10:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1456364DF4
	for <live-patching@archiver.kernel.org>; Thu,  4 Feb 2021 10:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhBDKpl (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:45:41 -0500
Received: from ozlabs.org ([203.11.71.1]:48873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231387AbhBDKpi (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 4 Feb 2021 05:45:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DWZtr4RvTz9sXV;
        Thu,  4 Feb 2021 21:44:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1612435496;
        bh=7gUDiKUJsUlnyL1hzNVaMIZFOrtzUH+RnQewMgPBJXA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aeithg5XbYtGR3+3M0J2fWWh+BH4YzO0m/tpovXY4JTNI34gGy0ZFPKzi6lAxzbdt
         p4lAuxnwJYSnrDXZnLVdsh8F0iA2jhQ4lDRw7p1Ocl/U6Q0wMnDs23z3/QrU4Q+lno
         vB6Wm/ETnQGaQPRkmOAk+Cg4eN2q25qRCTLtm9IPEiw22Jg7kttOdCnyq2xIB3d3Mu
         W6uJuZIKbssUj6v53+5imSR9JR3l28/X1jC6TANDAQeGIAHjg+1q4qg9hrQPw8eQ5U
         eF+le40oSyflT3D2CclEO5XCqDqyoXIurBtwcjRAc2Wf+Tc0nSes3mnm+UAEcPnkf7
         5fFb3xrUGnKIQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 01/13] powerpc/powernv: remove get_cxl_module
In-Reply-To: <20210202121334.1361503-2-hch@lst.de>
References: <20210202121334.1361503-1-hch@lst.de>
 <20210202121334.1361503-2-hch@lst.de>
Date:   Thu, 04 Feb 2021 21:44:51 +1100
Message-ID: <87h7msp0ws.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> The static inline get_cxl_module function is entirely unused since commit
> 8bf6b91a5125a ("Revert "powerpc/powernv: Add support for the cxl kernel
> api on the real phb"), so remove it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-cxl.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
