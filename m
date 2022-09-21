Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F849C32771
	for <live-patching@archiver.kernel.org>; Wed, 21 Sep 2022 07:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiIUHrY (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 21 Sep 2022 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIUHrX (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 21 Sep 2022 03:47:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4B4BA50;
        Wed, 21 Sep 2022 00:47:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BC28E21B45;
        Wed, 21 Sep 2022 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663746440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0LpMwaXgxEj7wk9RzEw+fXk3x7jM/Vb6fabo6sFq0Q=;
        b=lINNFfRIPix+gNIzai6sl4eX8DpcMEzL/BQpi6qEvoE4s6WfB4N6v2l0t/hu7Xw+asay6n
        eZHrcOv6TLGSkHgx5Y6xi2jnQeEu8wQXj0pl5P003wE7iYJVqG+1TMZls+Ks0wf2irLzHr
        5SVNw6vArSMkCrff0/QLUyQmKpVvKVk=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 91E772C141;
        Wed, 21 Sep 2022 07:47:20 +0000 (UTC)
Date:   Wed, 21 Sep 2022 09:47:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v4 1/8] scripts/kallsyms: rename build_initial_tok_table()
Message-ID: <YyrBhRfiBe0tEb9d@alley>
References: <20220920071317.1787-1-thunder.leizhen@huawei.com>
 <20220920071317.1787-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920071317.1787-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue 2022-09-20 15:13:10, Zhen Lei wrote:
> Except for the function build_initial_tok_table(), no token abbreviation
> is used elsewhere.
> 
> $ cat scripts/kallsyms.c | grep tok | wc -l
> 33
> $ cat scripts/kallsyms.c | grep token | wc -l
> 31
> 
> Here, it would be clearer to use the full name.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
