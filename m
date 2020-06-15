Return-Path: <SRS0=lnEz=74=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4475EC433E3
	for <live-patching@archiver.kernel.org>; Mon, 15 Jun 2020 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A06F207DA
	for <live-patching@archiver.kernel.org>; Mon, 15 Jun 2020 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6OXDqke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgFOR2L (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:28:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39929 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731213AbgFOR2K (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592242089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eIUgaJlpBEsWcVjf7X49COP6pjWDszlj8zDwIDGR7u0=;
        b=d6OXDqkefjkpTOCrxO7KtkkfJkHvJpwmsYn2JLRjErDiJ4KOTvmjzAWRe+70dne4fWBz7P
        Gsd+QUQobpDP87BgtRy5WWPWjRW37YJx9K8EY0oHC/p25AJjyGFQZifWHSzhkdcmyaCuNi
        6m6nsBF5cBMrZ1Dpq8TnR5TjeAOsoSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-BW0iutSFMVyTL4pPy62K2g-1; Mon, 15 Jun 2020 13:27:59 -0400
X-MC-Unique: BW0iutSFMVyTL4pPy62K2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC303184D149;
        Mon, 15 Jun 2020 17:27:58 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE34E19C66;
        Mon, 15 Jun 2020 17:27:57 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/4] selftests/livepatch: small script cleanups
Date:   Mon, 15 Jun 2020 13:27:52 -0400
Message-Id: <20200615172756.12912-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

This is a small collection of tweaks for the shellscript side of the
livepatch tests.  If anyone else has a small cleanup (or even just a
suggestion for a low-hanging change) and would like to tack it onto the
set, let me know.

based-on: livepatching.git, for-5.9/selftests-cleanup
merge-thru: livepatching.git

v2:
- use consistent start_test messages from the original echoes [mbenes]
- move start_test invocations to just after their descriptions [mbenes]
- clean up $SAVED_DMSG on trap EXIT [pmladek]
- grep longer kernel taint line, avoid word-matching [mbenes, pmladek]
- add "===== TEST: $test =====" delimiter patch [pmladek]

Joe Lawrence (4):
  selftests/livepatch: Don't clear dmesg when running tests
  selftests/livepatch: use $(dmesg --notime) instead of manually
    filtering
  selftests/livepatch: refine dmesg 'taints' in dmesg comparison
  selftests/livepatch: add test delimiter to dmesg

 tools/testing/selftests/livepatch/README      | 16 +++---
 .../testing/selftests/livepatch/functions.sh  | 32 ++++++++++-
 .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
 .../selftests/livepatch/test-ftrace.sh        |  4 +-
 .../selftests/livepatch/test-livepatch.sh     | 12 +---
 .../selftests/livepatch/test-shadow-vars.sh   |  4 +-
 .../testing/selftests/livepatch/test-state.sh | 21 +++----
 7 files changed, 63 insertions(+), 81 deletions(-)

-- 
2.21.3

