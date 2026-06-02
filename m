Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A0202997
	for <live-patching@vger.kernel.org>; Tue,  2 Jun 2026 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404346; cv=none; b=MBiC2kwe5vkvJlyJGfF/i6eJfZ4Q59JJHnKRfSnmYdRBAWdd+wd48Cd11TavkYGfDwVKhBzE3J5UacuK/66J3vA54Qg3T99IB5xwmzXlDWGUMbIMHNHjH49nQhY1jg0FGG2EgBpBuRaW1FXbkjoCeQVNKuqf4P40xnu1i3SOJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404346; c=relaxed/simple;
	bh=Sld+qUyKjabJ0waQJgZNH1xr6cbEUSm4u2piF2phkvw=;
	h=Cc:Message-Id:Mime-Version:Content-Type:From:Subject:Date:To; b=pkF023UAZsrx0Vvox9qmgn7qFUfFki3o+wIShnGcGAGNCjd8mFZ7zXEHmWpm9wRHXnkRwN3hYI8wnZX1xWD0qpENt675Asanyv4zKEHzwsPWfDC5Ut0XCnrgBbaDTlVFY9pflEzIo4HaJRMBeGab0Tf+DcuYVD2WruqbhUNlerc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eMiPIhdZ; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eMiPIhdZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780404333; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Db0pcyHB9iqs3Kuiw/HVa/1tfeH0BZGlXBcrSVMEodg=;
 b=eMiPIhdZ6mSX7p8D28/OjBkR2fs7zepSFTVdLvprVhPRMey7C01dOD0dRsC/fC3yueMB2F
 DUmz4D7HBquLyK1xOlo+nI5TmxjIQxLd3Wkf17sCYZ2tdjw9Q/BeZtEN52CauxULSYwgvq
 T+y7hRH7/GcPiW1iwUPsx8NWjbNdyhKSFJ2fmzCgP4T8fror8XuEgSqfg2CYjYpkqyyJBN
 hpEAEbTq4mPOLW0lHzELEtOEcId1o1jPqhIUbj1xPKKTARYaMqbTb3mPG1dWRSfGNI5Jj0
 f/LDJTdMke/E34zPkg+QccYnC9RBDcdeF9RqfjBzvMeYnhtX7zS6YYZ/5+JHAA==
X-Mailer: git-send-email 2.20.1
Cc: <joe.lawrence@redhat.com>, <shuah@kernel.org>, 
	<live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260602124509.365996-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH] selftests/livepatch: fix resource leak in test_klp_syscall init error path
Date: Tue,  2 Jun 2026 20:45:09 +0800
To: <jpoimboe@kernel.org>, <jikos@kernel.org>, <mbenes@suse.cz>, 
	<pmladek@suse.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+26a1ed06b+334e0a+vger.kernel.org+qirui.001@bytedance.com>

In livepatch_init(), if klp_enable_patch() fails, the previously
created kobject and sysfs file are never cleaned up, causing a
resource leak. Capture the return value and add proper cleanup
on the error path.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 .../selftests/livepatch/test_modules/test_klp_syscall.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
index 0630ffd9d9a1..d631acae48b9 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
@@ -109,7 +109,12 @@ static int livepatch_init(void)
 	 */
 	npids = npids_pending;
 
-	return klp_enable_patch(&patch);
+	ret = klp_enable_patch(&patch);
+	if (ret) {
+		sysfs_remove_file(klp_kobj, &klp_attr.attr);
+		kobject_put(klp_kobj);
+	}
+	return ret;
 }
 
 static void livepatch_exit(void)
-- 
2.20.1
