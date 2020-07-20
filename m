Return-Path: <SRS0=z05Q=A7=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0577C433E1
	for <live-patching@archiver.kernel.org>; Mon, 20 Jul 2020 11:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB03F22BF3
	for <live-patching@archiver.kernel.org>; Mon, 20 Jul 2020 11:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGTLGr (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:06:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbgGTLGr (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 20 Jul 2020 07:06:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B2408D76248D70AE5F11;
        Mon, 20 Jul 2020 19:06:44 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.63) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 19:06:42 +0800
Subject: Re: [PATCH 0/2] x86/unwind: A couple of fixes for newly forked tasks
To:     Josh Poimboeuf <jpoimboe@redhat.com>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <live-patching@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
References: <cover.1594994374.git.jpoimboe@redhat.com>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <88444749-84f5-1e80-3c97-cac3bf0a064c@huawei.com>
Date:   Mon, 20 Jul 2020 19:06:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <cover.1594994374.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.63]
X-CFilter-Loop: Reflected
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Tested-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

ÔÚ 2020/7/17 22:04, Josh Poimboeuf Ð´µÀ:
> A couple of reliable unwinder fixes for newly forked tasks, which were
> reported by Wang ShaoBo.
>
> Josh Poimboeuf (2):
>    x86/unwind/orc: Fix ORC for newly forked tasks
>    x86/stacktrace: Fix reliable check for empty user task stacks
>
>   arch/x86/kernel/stacktrace.c | 5 -----
>   arch/x86/kernel/unwind_orc.c | 8 ++++++--
>   2 files changed, 6 insertions(+), 7 deletions(-)
>

