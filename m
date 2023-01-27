Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2AAC38142
	for <live-patching@archiver.kernel.org>; Fri, 27 Jan 2023 10:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjA0KxG (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 27 Jan 2023 05:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjA0Kw5 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 27 Jan 2023 05:52:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EBB1DBA0;
        Fri, 27 Jan 2023 02:52:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FB4D1F37F;
        Fri, 27 Jan 2023 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674816775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AXCCYnmxwOyOER7P1F8fCZpYH5el3jxHyuaQXX3BiM=;
        b=E1vUaDmnnquL6tixLsA8iXaSUI2yeCRlIgu94pxA9KQ+7a2hwklVFxoYC7kLs9BcLl0tml
        E1xrtcRYprgOKxiZ3mahCI0hbmRoze8mrhIhOyyeGH3wlQEAC6M2ZWfCJjrk69ZXgw7SwN
        Ad/oAlHRYiid1atoVtnt/l9CgJIO0kY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFBBF2C141;
        Fri, 27 Jan 2023 10:52:54 +0000 (UTC)
Date:   Fri, 27 Jan 2023 11:52:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 16/35] Documentation: livepatch: correct spelling
Message-ID: <Y9OtBm7qKccs3tbY@alley>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-17-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127064005.1558-17-rdunlap@infradead.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu 2023-01-26 22:39:46, Randy Dunlap wrote:
> Correct spelling problems for Documentation/livepatch/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
