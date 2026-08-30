Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E581AA8
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068962; cv=none; b=RF6mZA9vLLbwf5sGbBdR1LqBCHbCTK/Fbm/fdKUS+5SWuWmy+12fjnd+6IIYlcOVno5am9WQtNgaNJ/Jv22MwTg9s7SuaYQu5yaUbWutn1TERGrAPS7T5K6mxc1g3ALARAgoYEFsSJJsihN3oAh3Po+rMExV942sDQ1mkwrcDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068962; c=relaxed/simple;
	bh=TBL6uUTno2+/EWr34kbxXX3/c/BBQyL1HGM80pGdfQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOctY8vT0pbrEYNT0vFlvAg/DjhdYica0uwCLcgph1uakUBNXI6mRPgms8DlIV65D9d2segXjA0LJtPPkZSaaG7xN3C0dKJdmIIYvZ773w/YQ8tTWu5E0eq34C/ygrLCBIVy6xINblcljlvUl74MAEWezIHJb5ISu6d7DjnriRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ+EK3Tk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ+EK3Tk"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso118278a91.1
        for <live-patching@vger.kernel.org>; Sat, 29 Aug 2026 22:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788068960; x=1788673760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCGAUe49N3syR1l9mxHL2U7xi1wjaVz68NQpyrP2908=;
        b=YZ+EK3Tk73VnMmfo4eVIJCa4SILf/62OntNpUo4twy6koGC6fBQNqDX4jojHJNALUY
         nsKSS/H5nV6P0nQsvcpWp72gYG7dPUD2zESnZRka/Db5vSiA2mgqqKN20kK7t1xkvVqe
         Co9MBw3mNP4ayYM0xEXX+y+86wS/E9iEaTHz9Eb+9aOSDCU3XAGS9B5IP0/km45pXs5I
         XIxnCKoWeDCjlu1zpJ6eF03LOTBCt6ntBT745NtIhT5kE8/wkJRd8rnPy9jyQilYscGV
         k/RR8IeEJDPMg0lxNz9jGTmmTysSeH6M1IxpA0h8aun4ieXx68cJiP3llqB+Pc4na3xm
         aEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788068960; x=1788673760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCGAUe49N3syR1l9mxHL2U7xi1wjaVz68NQpyrP2908=;
        b=oi34uUwpyflzwXb+KqVF7L52SsEhdSTPYohjYHNsOonrEMpxkz2HqxsXvWN3yXqfHg
         1VkCSHcAfbStWSRgPnyn6fjGlrMF13JcDLz38aMePtDFCj/t2Qm/4/ZCMemcEJIoGKus
         F0EGpMW/BAJ3mjAzBCamBzOXSNrc3rdmH7KYZvxOECxO8AEMrht+9Oh13CRnviqal9d9
         +EdCMx1cjFkclY/075kTZlxzDiJ2oumlLQuzS4oLhrI7Q56URPyLK0Cm+o9iLHyLhFfu
         18UwRjhN+eo9uf9X9QM/hJgKluIbuYu7n9h5rW6SUc0lyyGZpMUgs6AO4vEM3LiY1Jpa
         g91g==
X-Gm-Message-State: AFuF++ltTaA3HObnTrkNhfY3bh9PJI/r0kRqST+KSFqiPeJTpSsK9yI+
	wKDPgNixXQmF8bC0UIA4sOzMIMhCXZGaAyhPYx80BVukHrQrEUdUVB9E
X-Gm-Gg: AYBFou0z2LPEmaxAeXwh/F8XnAj04Wu63/q/O3GQVCzVw9QtJuG8wWlE9iEWW8F9eTM
	Z7yANPAeoOVvixBhYBaHqNgmenjA7ntjCXQPhmOue4MhWK9/ABSE7peDgRhsKIavQ8nyZzDOasV
	88ErYR6QqMmdhcBr9Dm7TRNFFQb1wZ1yP+8r0mKdmUL1SIjHuXLawluRHMBEUNB3fOTr7SZN78P
	QNMMvb5Y78tI/ij1Zz2eC+PHGqGlSkLeUqIUVy/LUb+3ttKVFZOASscqBF7MUnunIGxgy6z2zUq
	M3k9bYLYbgMXutiAmHTdW0Ahui79fw600lnoQawRanZYjmK60+dMysGS/t5JyBNhnlKB2Z+YEyG
	ZhULbU+cLNUuQPq05vA2C7fB77YUmc9Cj9DY+uMtdohwwDzfM9ilXjp0kPiECMI4Pg+kEvvPO0k
	HY/MwxKrMM7KJwoXc04vpegDvwYlDSUw9oILH5eG5+r0cMsdAm+JP1OFIQpqEwCMtvy9ePOShF2
	GCGQry4F0+lYhoG5bL5rTrlj9gOJtmGRuxvHVA/lp/31mmsNTlqe3y36g==
X-Received: by 2002:a17:90b:4a42:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-396d0e7c071mr27039274a91.4.1788068960296;
        Sat, 29 Aug 2026 22:49:20 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2510:761:2de1:2bab:6d79:724b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc555b0sm9742569a91.13.2026.08.29.22.49.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:49:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 2/2] selftests/livepatch: filter debug messages in check_result()
Date: Sun, 30 Aug 2026 13:48:57 +0800
Message-ID: <20260830054857.64758-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260830054857.64758-1-laoar.shao@gmail.com>
References: <20260830054857.64758-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env(),
fill_kobj_path() and friends emit pr_debug() messages, and
CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
for every delayed kobject free.  All of these carry the "kobject:" prefix
via pr_fmt(), e.g.:

 # --- expected
 # +++ result
 # @@ -1,7 +1,13 @@
 #  % insmod test_modules/test_klp_livepatch.ko
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_add_internal: parent: 'module', set: 'module'
 # +kobject: 'holders' (000000002856f0ae): kobject_add_internal: parent: 'test_klp_livepatch', set: '<NULL>'
 # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_add_internal: parent: 'livepatch', set: '<NULL>'
 # +kobject: 'vmlinux' (000000007b8837e6): kobject_add_internal: parent: 'test_klp_livepatch', set: '<NULL>'
 #  livepatch: enabling patch 'test_klp_livepatch'
 #  livepatch: 'test_klp_livepatch': initializing patching transition
 #  livepatch: 'test_klp_livepatch': starting patching transition
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: path = '/module/test_klp_livepatch'
 #  livepatch: 'test_klp_livepatch': completing patching transition
 #  livepatch: 'test_klp_livepatch': patching complete
 #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
 # @@ -9,4 +15,17 @@ livepatch: 'test_klp_livepatch': initial
 #  livepatch: 'test_klp_livepatch': starting unpatching transition
 #  livepatch: 'test_klp_livepatch': completing unpatching transition
 #  livepatch: 'test_klp_livepatch': unpatching complete
 # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_release, parent 00000000f8785d63 (delayed 2000)
 # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_cleanup, parent 00000000f8785d63
 # +kobject: 'test_klp_livepatch' (00000000dcae1113): auto cleanup kobject_del
 # +kobject: 'test_klp_livepatch' (00000000dcae1113): calling ktype release
 # +kobject: 'test_klp_livepatch': free name
 #  % rmmod test_klp_livepatch
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_release, parent 0000000052e5c022 (delayed 3000)
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_cleanup, parent 0000000052e5c022
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup kobject_del
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup 'remove' event
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: path = '/module/test_klp_livepatch'
 # +kobject: 'test_klp_livepatch' (000000009dbf565e): calling ktype release
 # +kobject: 'test_klp_livepatch': free name
 #
 # ERROR: livepatch kselftest(s) failed
 not ok 1 selftests: livepatch: test-livepatch.sh # exit=1

The livepatch test modules' kobjects are named "test_klp_*", so these
lines match the check_result() grep for "test_klp" and leak into the
result.  The extra lines no longer match the expected output, so the
selftests fail when either debug config is enabled.

Filtering out every "kobject:" line also hides real WARN()s, e.g. the
one kobject_get() emits for an object whose refcount was not
initialized.  Filtering with "dmesg --level=..." is not enough either,
since the tests enable livepatch pr_debug() through dynamic_debug/control
and expect its messages.  Read the log with "dmesg --raw" and drop only
the debug-level messages without the "livepatch:" prefix, plus the
specific delayed-release info message.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
---
 tools/testing/selftests/livepatch/functions.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 30dc677b2f45..8352c8d509a5 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -306,9 +306,9 @@ function start_test {
 	# find new kernel messages since the test started.
 	local last_dmesg_msg="livepatch kselftest timestamp: $(date --rfc-3339=ns)"
 	log "$last_dmesg_msg"
-	loop_until 'dmesg | grep -q "$last_dmesg_msg"' ||
+	loop_until 'dmesg -r | grep -q "$last_dmesg_msg"' ||
 		die "buffer busy? can't find canary dmesg message: $last_dmesg_msg"
-	LAST_DMESG=$(dmesg | grep "$last_dmesg_msg")
+	LAST_DMESG=$(dmesg -r | grep "$last_dmesg_msg")
 
 	echo -n "TEST: $test ... "
 	log "===== TEST: $test ====="
@@ -321,12 +321,18 @@ function check_result {
 	local result
 
 	# Test results include any new dmesg entry since LAST_DMESG, then:
+	# - exclude debug messages except with "livepatch:" prefix
 	# - include lines matching keywords
 	# - exclude lines matching keywords
 	# - filter out dmesg timestamp prefixes
-	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
+	# - exclude the delayed kobject release messages when CONFIG_DEBUG_KOBJECT_RELEASE is on
+	result=$(dmesg -r | \
+		 awk -v last_dmesg="$LAST_DMESG" \
+		 'p { if ($0 !~ /^<7>/ || $0 ~ /livepatch:/) print; next } $0 == last_dmesg { p = 1 }' | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
+		 grep -v 'kobject: .*parent.*(delayed' | \
+		 sed 's/^<[0-9]*>//' | \
 		 sed 's/^\[[ 0-9.]*\] //' | \
 		 sed 's/^\[[ ]*[CT][0-9]*\] //')
 
-- 
2.52.0

