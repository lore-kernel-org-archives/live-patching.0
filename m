Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B303C4332F
	for <live-patching@archiver.kernel.org>; Fri,  9 Dec 2022 00:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLIAWU (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 8 Dec 2022 19:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIAWT (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 8 Dec 2022 19:22:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63FF92310;
        Thu,  8 Dec 2022 16:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ZjR+Vl1hcBujpMBxlKjQQPIWlNHLScCkpetoAeaF2M=; b=exbjf7j82t7oVPV96bEocY40JJ
        BtdYsgLkcvWd9xpaMM3gtzzSXyCPmNw4VYB+s0x9TCnXkJxg6G1yddqnZyONXkGMRVv2/z/1DD8z+
        iHVJhq1htjop2GRn0gtqCNh19/u//2bbc004nNMNq6p/myuw0gNCwd13EiQLX9u+wSX/mf0a6sasJ
        jT+8Z1W3WrhpaCXBmd/pf11drGf1AlkH5spdPoMIuQaLOkPEKAkKlPHF1STFEBSCeSsa3cq1BvanO
        HC2Inf3f12R0ivOB0rhouK2gCJCLpBqdkU9UezpS8mRaizfVL1QvFohARM/YetxOKKMYDNhYEEz2M
        ARp8aJqA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3R9S-00GKtb-OH; Fri, 09 Dec 2022 00:22:06 +0000
Date:   Thu, 8 Dec 2022 16:22:06 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] livepatch: Call klp_match_callback() in
 klp_find_callback() to avoid code duplication
Message-ID: <Y5J/rtpFwf1kxBHl@bombadil.infradead.org>
References: <20221207032304.2017-1-thunder.leizhen@huawei.com>
 <CAPhsuW4xZ-d7Yk0VLcym4UfFwzo6yd190hVSsiwNdSEzz9xeKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4xZ-d7Yk0VLcym4UfFwzo6yd190hVSsiwNdSEzz9xeKA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, Dec 08, 2022 at 04:11:06PM -0800, Song Liu wrote:
> On Tue, Dec 6, 2022 at 7:25 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >
> > The implementation of function klp_match_callback() is identical to the
> > partial implementation of function klp_find_callback(). So call function
> > klp_match_callback() in function klp_find_callback() instead of the
> > duplicated code.
> >
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Acked-by: Song Liu <song@kernel.org>

Thanks, applied to modules-next given this depends on the kallsyms stuff there.
Pushed out.

  Luis
