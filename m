Return-Path: <SRS0=q7KC=45=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C27C10DCE
	for <live-patching@archiver.kernel.org>; Thu, 12 Mar 2020 14:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224EA2067C
	for <live-patching@archiver.kernel.org>; Thu, 12 Mar 2020 14:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCLOUL (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:20:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCLOUL (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 12 Mar 2020 10:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1AEAB2F8;
        Thu, 12 Mar 2020 14:20:09 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jslaby@suse.cz, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/2] x86/xen: Make idle tasks reliable
Date:   Thu, 12 Mar 2020 15:20:05 +0100
Message-Id: <20200312142007.11488-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The unwinder reports idle tasks' stack on XEN PV as unreliable which
complicates things for at least live patching. The two patches in the
series try to amend that by using similar approach as non-XEN x86 does.

However, I did not come up with a nice solution for secondary CPUs idle
tasks. The patch just shows the idea what should be done but it is an
ugly hack. Ideas are more than welcome.

Miroslav Benes (2):
  x86/xen: Make the boot CPU idle task reliable
  x86/xen: Make the secondary CPU idle tasks reliable

 arch/x86/xen/smp_pv.c   |  3 ++-
 arch/x86/xen/xen-head.S | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.25.1

