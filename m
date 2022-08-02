Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC6C19F2D
	for <live-patching@archiver.kernel.org>; Tue,  2 Aug 2022 13:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiHBNsM (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 2 Aug 2022 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBNsL (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 2 Aug 2022 09:48:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7C18E13;
        Tue,  2 Aug 2022 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=04o2rImNVbolTLXJKFYFmmfTqVuwY00lF/8/aeJQr3Y=; b=atH8fMSGKhwHi31reNblCnsOj4
        CPRAEnye3aX3IE9izMWeSQ5PsiYPDzTy61k5Pylp6FzzsWr0FB+rFhw5NsQrLSC2DHIbY6aKJcrEV
        6drwB1hcGIADQhQBcVCY5Usyfl84FJk2AkjMDmWTuzy0bXcmPKim2nGzAWfjK/1RLRwfSQ3qxKXv3
        e2VhUSw8QHkXZRC7/3B6Wn5lJNvi1nVUs7/MopFrGwDhqQYbIJ8dPn9Tu0Hz9nQPnSLAbl6xV/B+F
        m2ttNt8K21Q88Epxbhcq+VMlvCJJQEQp8GXXjLQdb3zm7/QDmJKD0SFNK29YnPr+R7XWILPiYdu6C
        +tJZf/6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIsFh-00EcLn-Ob; Tue, 02 Aug 2022 13:48:05 +0000
Date:   Tue, 2 Aug 2022 06:48:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/31] Rust support
Message-ID: <YukrFS9NIMSP/I/Q@infradead.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <YukYByl76DKqa+iD@casper.infradead.org>
 <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Miguel,

handwaiving and pointing to git trees is not how Linux development
works.  Please make sure all the patches go to the relevant lists
and maintainers first, and actually do have ACKs.
