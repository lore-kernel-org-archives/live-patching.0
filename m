Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729B3655EA;
	Fri,  3 Jul 2026 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058665; cv=none; b=iD9fhnzLIK7yBDNyHmWNxxFhTIUKqSc9KlyyRH8477dPMNO2PGjTsT8stS+YqOtO+XlgxEyB4LR963npgoI4jpIn6uSK7NgIBPp4Etn5wyLXf5lSd5GaP07+2R/m3iFVUY/8A3mzl5TkdrG8jdAdltnifnwLJOo0zvbtQSNOhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058665; c=relaxed/simple;
	bh=0xv7uP9Oaijvxl1OZ7odzKCoFJhpt++ekmtViYEMvv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k9Nwx0K/zss6i2+5Klpc3/ZONKth85N+S4r1E4TpKGqYjHidPnu1DgSOQ+VASw1LGO7RMSnZ2DJaQnr/oVOqEWb7MN6JlbfUQ5y22sn1NWJUE7U1K8m9AUA91ogQlKsfCYZ+kOyGWfY4lX/4HDFlchtGu8IaQv/jkYzZ9E8M4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZdXxfLXn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HTNUD6EB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZdXxfLXn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HTNUD6EB"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783058661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rj3q4njGKF+XfKqAgwZeMSjHfycU6n05olq8I7af1q8=;
	b=ZdXxfLXnI4zn/WxPN2fkvhgjZTvTV/3WHJMyNI7h5Kwj/kLDR8ZvhqtM1d9EIqVQ8o2zWj
	xTOaIUvbiYoutNKzIOutoaJDty83Fgs8G+w0UqYdZ4XPzGx+m2nWuBHuRy75BGN33xK05p
	aHILt4/VwpuSXYwzuCluYMOsFljivJf0UsKFEcg8fdXcQVHFswQWw1TlKNJT+iqTnmbz5N
	4jgpZpvxzuxbpEeMSo+YrsC+Q1yGmDQtHoJFkwpw7jmXwCG+lW8OOowS/SZ5Leyq+YhCyL
	HAgN6DUIZ/2uJ5iaTdzw755byVRIMhS9rRPQ02UOOTBz1vQ9Bl0BUa4kaxmYLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783058661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rj3q4njGKF+XfKqAgwZeMSjHfycU6n05olq8I7af1q8=;
	b=HTNUD6EBuhPwDD4noLZOrJYSsHTD1oqZktHi9MIg+uoJ4WI0vQzE9Fe/cRFQ8i3dCiuNs2
	GGHiPxSmCd8vHSDw==
Date: Fri, 03 Jul 2026 08:04:08 +0200
Subject: [PATCH] kbuild: unset sub_make_done before calling kselftest build
 system
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywrCMBAAf6XsuQtJxAb9Fekhj1UXNZGsESHk3
 017nGGYBkKFSeA8NSj0ZeGcBuh5gnB36UbIcTAYZRZllcGXe9CVn4Q1CX1Qqt8MxpwIgw/Knw7
 2uGgL4/AuI/3t98va+x8OBuv+bQAAAA==
X-Change-ID: 20260702-makefile-unset-submake-done-cbc0b9375617
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 live-patching@vger.kernel.org, shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, Zelin Deng <zelin.deng@linux.alibaba.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783058655; l=1536;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0xv7uP9Oaijvxl1OZ7odzKCoFJhpt++ekmtViYEMvv0=;
 b=5bGET+Pivq1os2f+IEA0g9q5IHSwh81+wA/fca9SS8z/ObGDCWiZmxRCL9RjjW7Wvmct+ZKHH
 mg+uGzaek4PAx0OjOJCgWvIHl/YxpYbhdgwMRGYh8RQLXIUKIOaJZga
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The kselftest build system may recourse back into kbuild when building
test modules. In that case kbuild needs to parse the new flags passed
from the command line, instead of using the ones inherited from the
kbuild invocation.

Force that command line reevaluation.

The same was done for scripts/install.sh in commit 14ccc638b02f9ec
("kbuild: cancel sub_make_done for the install target to fix DKMS")

Reported-by: Zelin Deng <zelin.deng@linux.alibaba.com>
Closes: https://lore.kernel.org/all/20260525083721.27857-1-zelin.deng@linux.alibaba.com/
Fixes: c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b9c5792c79e0..f717a4dc96d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1591,10 +1591,10 @@ tools/%: FORCE
 
 PHONY += kselftest
 kselftest: headers
-	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
+	$(Q)unset sub_make_done; $(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
 kselftest-%: headers FORCE
-	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
+	$(Q)unset sub_make_done; $(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
 kselftest-merge:

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-makefile-unset-submake-done-cbc0b9375617

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

