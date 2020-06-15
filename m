Return-Path: <SRS0=lnEz=74=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A3C433E7
	for <live-patching@archiver.kernel.org>; Mon, 15 Jun 2020 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A76208A9
	for <live-patching@archiver.kernel.org>; Mon, 15 Jun 2020 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFfWiljD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgFOR2M (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:28:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57314 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729967AbgFOR2H (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592242086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDYd5mUdjgScnsnMuq70DAzpJt/WeKbHjzW7zJWYAes=;
        b=fFfWiljDQZbp+hEwTtYedDDQtH4xxUhpCt5/HCRVsLRKcYBs54FgwEQw9Y1RNzKGDpis18
        reb0GKLvI4QIXibnkSsKmf5JZ/Anl0wPVbzHrprO/9SVMc4FSh3kcP+Bmky5Rlk+lEOT6C
        2fafLY79cVVPbpzIA+RvNvPE3dhf6u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-mHKY17zYNs2TniF4H1symw-1; Mon, 15 Jun 2020 13:28:03 -0400
X-MC-Unique: mHKY17zYNs2TniF4H1symw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416B610059B3;
        Mon, 15 Jun 2020 17:28:02 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A4A19C66;
        Mon, 15 Jun 2020 17:28:01 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/4] selftests/livepatch: add test delimiter to dmesg
Date:   Mon, 15 Jun 2020 13:27:56 -0400
Message-Id: <20200615172756.12912-5-joe.lawrence@redhat.com>
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Make it bit easier to parse the kernel logs during the selftests by
adding a "===== TEST: $test =====" delimiter when each individual test
begins.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index cb8a6df8c73a..d2b831cc710e 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -264,6 +264,7 @@ function start_test {
 
 	save_dmesg
 	echo -n "TEST: $test ... "
+	log "===== TEST: $test ====="
 }
 
 # check_result() - verify dmesg output
-- 
2.21.3

