Return-Path: <SRS0=jYRv=YA=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CB0C47404
	for <live-patching@archiver.kernel.org>; Mon,  7 Oct 2019 08:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E5020867
	for <live-patching@archiver.kernel.org>; Mon,  7 Oct 2019 08:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJGIRS (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:17:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727448AbfJGIRS (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 7 Oct 2019 04:17:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC998AE46;
        Mon,  7 Oct 2019 08:17:16 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/3] ftrace: Introduce PERMANENT ftrace_ops flag
Date:   Mon,  7 Oct 2019 10:17:11 +0200
Message-Id: <20191007081714.20259-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Livepatch uses ftrace for redirection to new patched functions. It is
thus directly affected by ftrace sysctl knobs such as ftrace_enabled.
Setting ftrace_enabled to 0 also disables all live patched functions. It
is not a problem per se, because only administrator can set sysctl
values, but it still may be surprising.

Introduce PERMANENT ftrace_ops flag to amend this. If the
FTRACE_OPS_FL_PERMANENT is set, the tracing of the function is not
disabled. Such ftrace_ops can still be unregistered in a standard way.

The patch set passes ftrace and livepatch kselftests.

Miroslav Benes (3):
  ftrace: Make test_rec_ops_needs_regs() generic
  ftrace: Introduce PERMANENT ftrace_ops flag
  livepatch: Use FTRACE_OPS_FL_PERMANENT

 Documentation/trace/ftrace-uses.rst |  6 ++++
 Documentation/trace/ftrace.rst      |  2 ++
 include/linux/ftrace.h              |  8 +++--
 kernel/livepatch/patch.c            |  3 +-
 kernel/trace/ftrace.c               | 47 ++++++++++++++++++++++++-----
 5 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.23.0

