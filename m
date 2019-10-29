Return-Path: <SRS0=rLOU=YW=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E4FCA9EC4
	for <live-patching@archiver.kernel.org>; Tue, 29 Oct 2019 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D9C208E3
	for <live-patching@archiver.kernel.org>; Tue, 29 Oct 2019 14:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbfJ2OjR (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:39:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388885AbfJ2OjI (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 29 Oct 2019 10:39:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CB12B29A;
        Tue, 29 Oct 2019 14:39:06 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, jpoimboe@redhat.com,
        joe.lawrence@redhat.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jikos@kernel.org, pmladek@suse.com, nstange@suse.de,
        live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 0/3] s390/livepatch: Implement reliable stack tracing for the consistency model
Date:   Tue, 29 Oct 2019 15:39:01 +0100
Message-Id: <20191029143904.24051-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The livepatch consistency model requires reliable stack tracing
architecture support in order to work properly. In order to achieve
this, two main issues have to be solved. First, reliable and consistent
call chain backtracing has to be ensured. Second, the unwinder needs to
be able to detect stack corruptions and return errors.

The former should be guaranteed (see 3/3 for details), the latter is
implemented by the patch set (mainly 3/3).

It passes livepatch kselftests (with timeout disabled, see
https://lore.kernel.org/live-patching/20191025115041.23186-1-mbenes@suse.cz/)
and tests from https://github.com/lpechacek/qa_test_klp.

Changes since v1 and questions follow:
- rebased on top of v5.4-rc5. It also meant rebasing on top of
  ARCH_STACKWALK, which made the outcome nicer and addressed some of
  Joe's remarks.
- sp alignment is checked in both _start and _next_frame cases
- ftrace_graph_ret_addr() calling cleanup

- I tried to use the existing infrastructure as much as possible with
  one exception. I kept unwind_next_frame_reliable() next to the
  ordinary unwind_next_frame(). I did not come up with a nice solution
  how to integrate it. The reliable unwinding is executed on a task
  stack only, which leads to a nice simplification. My integration
  attempts only obfuscated the existing unwind_next_frame() which is
  already not easy to read. Ideas are definitely welcome.

- although not nice (Josh mentioned it in his review), I kept checking
  for kretprobe_trampoline in the main loop. It could go into _start and
  _next_frame callbacks, but more changes would be required (changing a
  function return type, ordinary unwinding does not need it). So I did
  not think it was worth it. I could change it in v3, of course.

Miroslav Benes (3):
  s390/unwind: drop unnecessary code around calling
    ftrace_graph_ret_addr()
  s390/unwind: prepare the unwinding interface for reliable stack traces
  s390/livepatch: Implement reliable stack tracing for the consistency
    model

 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/stacktrace.h |  3 +-
 arch/s390/include/asm/unwind.h     | 15 +++---
 arch/s390/kernel/dumpstack.c       | 16 +++++-
 arch/s390/kernel/perf_event.c      |  2 +-
 arch/s390/kernel/stacktrace.c      | 48 +++++++++++++++++-
 arch/s390/kernel/unwind_bc.c       | 79 ++++++++++++++++++++++++------
 arch/s390/oprofile/init.c          |  2 +-
 8 files changed, 139 insertions(+), 27 deletions(-)

-- 
2.23.0

