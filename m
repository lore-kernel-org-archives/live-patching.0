Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E0ECAAA1
	for <live-patching@archiver.kernel.org>; Fri,  2 Sep 2022 20:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIBUwc convert rfc822-to-8bit (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 2 Sep 2022 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIBUwb (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 2 Sep 2022 16:52:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E9FCA3A
        for <live-patching@vger.kernel.org>; Fri,  2 Sep 2022 13:52:30 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282JNpCb013672
        for <live-patching@vger.kernel.org>; Fri, 2 Sep 2022 13:52:30 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jbcjnm4p1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <live-patching@vger.kernel.org>; Fri, 02 Sep 2022 13:52:29 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 13:52:27 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 0BAC5C63D6A5; Fri,  2 Sep 2022 13:52:16 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <jikos@kernel.org>, <mbenes@suse.cz>,
        <pmladek@suse.com>, <joe.lawrence@redhat.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 1/2] livepatch: add sysfs entry "patched" for each klp_object
Date:   Fri, 2 Sep 2022 13:52:07 -0700
Message-ID: <20220902205208.3117798-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902205208.3117798-1-song@kernel.org>
References: <20220902205208.3117798-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LnIDGszZOWDpe5khXND2ISOBQeSn7Wl7
X-Proofpoint-GUID: LnIDGszZOWDpe5khXND2ISOBQeSn7Wl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_05,2022-08-31_03,2022-06-22_01
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Add per klp_object sysfs entry "patched". It makes it easier to debug
typos in the module name.

Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
---
I was debugging an issue that a livepatch appears to be attached, but
actually not. It turns out that there is a mismatch in module name
(abc-xyz vs. abc_xyz), klp_find_object_module failed to find the module.
---
 .../ABI/testing/sysfs-kernel-livepatch         |  8 ++++++++
 kernel/livepatch/core.c                        | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index bea7bd5a1d5f..ebe39a3cea39 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -55,6 +55,14 @@ Description:
 		The object directory contains subdirectories for each function
 		that is patched within the object.
 
+What:		/sys/kernel/livepatch/<patch>/<object>/patched
+Date:		August 2022
+KernelVersion:	6.0.0
+Contact:	live-patching@vger.kernel.org
+Description:
+		An attribute which indicates whether the object is currently
+		patched.
+
 What:		/sys/kernel/livepatch/<patch>/<object>/<function,sympos>
 Date:		Nov 2014
 KernelVersion:	3.19.0
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bc475e62279d..67eb9f9168f3 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -325,6 +325,7 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
  * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/force
  * /sys/kernel/livepatch/<patch>/<object>
+ * /sys/kernel/livepatch/<patch>/<object>/patched
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
  */
 static int __klp_disable_patch(struct klp_patch *patch);
@@ -431,6 +432,22 @@ static struct attribute *klp_patch_attrs[] = {
 };
 ATTRIBUTE_GROUPS(klp_patch);
 
+static ssize_t patched_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	struct klp_object *obj;
+
+	obj = container_of(kobj, struct klp_object, kobj);
+	return sysfs_emit(buf, "%d\n", obj->patched);
+}
+
+static struct kobj_attribute patched_kobj_attr = __ATTR_RO(patched);
+static struct attribute *klp_object_attrs[] = {
+	&patched_kobj_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(klp_object);
+
 static void klp_free_object_dynamic(struct klp_object *obj)
 {
 	kfree(obj->name);
@@ -576,6 +593,7 @@ static void klp_kobj_release_object(struct kobject *kobj)
 static struct kobj_type klp_ktype_object = {
 	.release = klp_kobj_release_object,
 	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = klp_object_groups,
 };
 
 static void klp_kobj_release_func(struct kobject *kobj)
-- 
2.30.2

