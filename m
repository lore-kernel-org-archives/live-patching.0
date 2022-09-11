Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D71ECAAD3
	for <live-patching@archiver.kernel.org>; Sun, 11 Sep 2022 15:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIKP1H (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Sun, 11 Sep 2022 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIKP1F (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Sun, 11 Sep 2022 11:27:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2521F602;
        Sun, 11 Sep 2022 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dA4KVJ9n+xFH+aRdTmGiWAtvnpKz/8BixrIpwCUxjkc=; b=OG6BVIJB3q4yCM/NV+izRXyJ0q
        99gfi9l91m0kKaaSLo2cgsOK8Z5HjaKHAYH1h/5TTrdLQwPzb7H3iOZHTUSQEAf23oiUFiLc2e4aP
        NnrSBGBfcAiCUYl6BMaN9BeaGaV0Ihx2lwfguVQ6OLR/dECX+C5xicUpuPz1y5VKZATM90hHHyXxS
        qLRYbz90DMY+9MEPiGsU/vKcdgNBG87EOhGBxQ8Qwmna9GtL7PVEGEkcpz8nyzlu3ywVU267V0mu7
        Uv+pZBF8a2hKkIgV0jita7HVD8Q6/qhWJKn6WhHQ7vlKWMVgIeuG/kWID7ROjFI7Lw3tBtqrZ5cKD
        QFKs5rbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXOqj-00Bbqh-3b; Sun, 11 Sep 2022 15:26:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 831F030008D;
        Sun, 11 Sep 2022 17:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CEEE2B16575A; Sun, 11 Sep 2022 17:26:18 +0200 (CEST)
Date:   Sun, 11 Sep 2022 17:26:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-toolchains@vger.kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, "Jose E. Marchesi" <jemarch@gnu.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] Objtool toolchain proposal:
 -fannotate-{jump-table,noreturn}
Message-ID: <Yx3+GpHakZZYLM1N@hirez.programming.kicks-ass.net>
References: <20220909180704.jwwed4zhwvin7uyi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909180704.jwwed4zhwvin7uyi@treble>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Sep 09, 2022 at 11:07:04AM -0700, Josh Poimboeuf wrote:
> Alternatives
> ------------
> 
> Another idea which has been floated in the past is for objtool to read
> DWARF (or .eh_frame) to help it figure out the control flow.  That
> hasn't been tried yet, but would be considerably more difficult and
> fragile IMO.

I though Ard played around with that a bit on ARM64. And yes, given that
most toolchains consider DWARF itself best-effort, I'm not holding my
breath there.

On top of that, building a kernel with DWARFs on is just so much
slower..
