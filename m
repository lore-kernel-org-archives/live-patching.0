Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39606C433F5
	for <live-patching@archiver.kernel.org>; Thu,  3 Feb 2022 00:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242104AbiBCAUt (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 2 Feb 2022 19:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiBCAUs (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 2 Feb 2022 19:20:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBFCC061714;
        Wed,  2 Feb 2022 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OOrfViPvQd6vr9ujkWDbCGEeKRArHhUsuzeY4LNzfbM=; b=1IkokUMg1aa7gqNGqbkfZhNWiz
        Qq2ai47LiSPEzoQww1XPI7+Fr3CuAn2xpNlIopkuTHLHg9xLRCU8FwMkfAdVANtCfXb9gnBOademN
        UCfJpOjl0q7a0s7j6OtOJnfR4Fi6kaLiW016LWUx9wYm1wbGt/6almFI64eBtFiN4QBuAAsr9Ch89
        Pw+OSzd3Qg1IQJNVm2+kBlPkeha7iJajQgrJI0Vz307Vh+tFtUHcoJb5pFRk/hytQ+oq4y6kHOtjE
        /gOFC7/ilcQEwWaV8WImpcjHRXfxkZkVy15VWd1CI9V7nrUd/cfaFP0B+aVuXUCueQecS67VN3vhS
        /pkj5+GQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFPrd-00H9Oq-3Z; Thu, 03 Feb 2022 00:20:41 +0000
Date:   Wed, 2 Feb 2022 16:20:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
References: <20220130213214.1042497-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130213214.1042497-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Sun, Jan 30, 2022 at 09:32:01PM +0000, Aaron Tomlin wrote:
> Hi Luis,
> 
> As per your suggestion [1], this is an attempt to refactor and split
> optional code out of core module support code into separate components.
> This version is based on branch mcgrof/modules-next since a97ac8cb24a3/or
> modules-5.17-rc1. Please let me know your thoughts.
> 
> Changes since v1 [2]:

Thanks for all this work Aaron! Can you drop the RFC prefix,
rebase onto linus' latest tree (as he already merged my
modules-next, so his tree is more up to date), and submit again?

I'll then apply this to my modules-next, and then ask Christophe to
rebase on top of that.

Michal, you'd be up next if you want to go through modules-next.

Aaron, please Cc Christophe and Michal on your next respin.

Thanks!!

  Luis
