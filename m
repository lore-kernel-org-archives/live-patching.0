Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D8C433EF
	for <live-patching@archiver.kernel.org>; Fri, 22 Jul 2022 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiGVQ4h (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 22 Jul 2022 12:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGVQ4g (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 22 Jul 2022 12:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B292E9CC;
        Fri, 22 Jul 2022 09:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C55620AE;
        Fri, 22 Jul 2022 16:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2062CC341C7;
        Fri, 22 Jul 2022 16:56:34 +0000 (UTC)
Date:   Fri, 22 Jul 2022 12:56:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v5 bpf-next 0/4] ftrace: host klp and bpf trampoline
 together
Message-ID: <20220722125632.6b9d5ff6@gandalf.local.home>
In-Reply-To: <257B5D9A-7A52-4396-82F5-9895782952BC@fb.com>
References: <20220720002126.803253-1-song@kernel.org>
        <257B5D9A-7A52-4396-82F5-9895782952BC@fb.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 21 Jul 2022 22:59:30 +0000
Song Liu <songliubraving@fb.com> wrote:

> How does this version look to you? 

Looks good. Thanks Song!

For the first two patches:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
