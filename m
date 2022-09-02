Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947AFC6FA82
	for <live-patching@archiver.kernel.org>; Fri,  2 Sep 2022 20:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIBUw3 convert rfc822-to-8bit (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 2 Sep 2022 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIBUw3 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 2 Sep 2022 16:52:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5FD4BD4
        for <live-patching@vger.kernel.org>; Fri,  2 Sep 2022 13:52:28 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282JNaJa017156
        for <live-patching@vger.kernel.org>; Fri, 2 Sep 2022 13:52:27 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jbcj7v49t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <live-patching@vger.kernel.org>; Fri, 02 Sep 2022 13:52:27 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 13:52:26 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 8620EC63D68A; Fri,  2 Sep 2022 13:52:14 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <jikos@kernel.org>, <mbenes@suse.cz>,
        <pmladek@suse.com>, <joe.lawrence@redhat.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 0/2] add sysfs entry "patched" for each klp_object
Date:   Fri, 2 Sep 2022 13:52:06 -0700
Message-ID: <20220902205208.3117798-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1vHcrwnRxsEEcseVjrZDYT4ALHZVzR0M
X-Proofpoint-GUID: 1vHcrwnRxsEEcseVjrZDYT4ALHZVzR0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_05,2022-08-31_03,2022-06-22_01
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

I was debugging an issue that a livepatch appears to be attached, but
actually not. It turns out that there is a mismatch in module name
(abc-xyz vs. abc_xyz), klp_find_object_module failed to find the module.
Add a sysfs entry for each klp_object, so that it is easier to debug
such issues.

Changes v2 => v3:
1. Improve selftest. (Petr Mladek and Joe Lawrence)

Changes v1 => v2:
1. Add selftest. (Petr Mladek)
2. Update documentation. (Petr Mladek)
3. Use sysfs_emit. (Petr Mladek)

Song Liu (2):
  livepatch: add sysfs entry "patched" for each klp_object
  selftests/livepatch: add sysfs test

 .../ABI/testing/sysfs-kernel-livepatch        |  8 ++
 kernel/livepatch/core.c                       | 18 ++++
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../testing/selftests/livepatch/functions.sh  | 34 ++++++++
 .../testing/selftests/livepatch/test-sysfs.sh | 86 +++++++++++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test-sysfs.sh

--
2.30.2
