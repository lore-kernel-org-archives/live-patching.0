Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928CD368958
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282244; cv=none; b=G5Ub+S0vKeGZ0zN6F86BqhvtJlVCOf9+0Y68qId49vGAQ+12Wn3IMgiOGpcwgdws7+tmsC9/jhpM5cDmat7MTBHrifZSyIQMHTdNTIN+w1hLDd6IzCNZfRmIsHdLAhHB5Q9yo50mnwPhgv1+jKZzasw5AYFDvtjxm84iT07iVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282244; c=relaxed/simple;
	bh=q/4H6uGffvPVVefyDclh3u/K8Nwr/XtNtm9R5vqP8e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEUsu9kHq4bJ0jNcVQ7Hp8Y+agG2u7p8TZG/HR9t5Xz1ZTRlhDP4sNaeIhSCUIzV55Jb8Q2CJFKQi3QmwMTrxIzq2LOyTvh+2MMA9UBZEbVogiot9oHdBgnON5IKRJpNSgWEO7CVWfJIGcuAdwu5I5O0fO6EXpfeSAmuPw75p04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aw+IDOPR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw+IDOPR"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca88130e09aso333740a12.3
        for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282233; x=1787887033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PS8tjL+As4/D3DYZpIAO928Ih0zUtI4LhobKI1PXLTA=;
        b=Aw+IDOPRanzzhw/56Xqsn0NUltiTNpC1V2RT2rvO0wZsiZ0X4o0Owkv4Ax9Nfgs1bU
         AWSLv7cqpIpkaU6dFpZfWmznx4b40b4t+A8sOdLeu8gh8Wx9/dl4U17sPDF0GjGxiBwT
         pZNt56F1zcRpuzvPgbbTm9LnNTR1HmheotNwH9H6M2ngpvyn6B9FHN1TPU0u8Z5YAAuV
         OUkMdTkzYzyNx7mSOlFGu1V8l6eAA8ymxr79K5e24/8hzQ4KzwIX6m7RP2DVw4w/q7z8
         /8rwTVw4kVeApaDYpKRcFsmP1KcG+mswZqX6uOxQkcEo3r7cx2NvE068W5JaFgHN77PG
         DwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282233; x=1787887033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PS8tjL+As4/D3DYZpIAO928Ih0zUtI4LhobKI1PXLTA=;
        b=SkV9E6GFBimgDx09igEcIFqkZxgiT5UU+f5o8vC42MgbJ60VvabLafylNnx02c7Ezt
         f961Wy5FX/YzxEJlRa9dXgoB4MkIfMGRuf9PtPv9L6LQHspBY+lDrNudzli1KsMLmAPX
         svVdKpA5qpFqhokVqYC+cZWBzXk4c2zJa74sJ+QpbV/BXmffov4vkI2+HNlUfngXL5jj
         ZbidasiXfTIjOruQOsp4x3Ej8A8C8JPImIdZoRID6f5Xh130myzzqjDbroE+GAyxoCb8
         oGBUBKOELTjk1sV8/DOLKJ9WTc6/snqJ9dWHVsohWxb/F/mchAiT8nI8bbBsrOqEmEBu
         d8YA==
X-Gm-Message-State: AOJu0Ywna144zHJKeLONsibFo/aAy5fUIoPKz1JwPH4y5B3Y0FQt+w0q
	RxGxx6EqQBjLz8W80+l3Cow7i2YAhX7Izw67T+rgf5l2U2kqVkKtgeXc0Gu9j6yL
X-Gm-Gg: AR+sD118G5EB61FR0aVPJAC6VJ8PLLqlbWpfhYoCF0jec5u63B0nhZiDr6VudM1ZfCD
	hh/nhesj4WBoEHk3dSfD9oj4rRLIdF6jZu9m61xFutmZXDftke5wfWYhsVSJ84706R9QX+H78m3
	U6pgZikLS3o+AQCLZleLWzkwup/JqRZF+wsnSYzSfeU93FC7hwZzuX+pmQD9Ifp7U6vQJssc0u/
	QtvAjTknuAIsVPtnFxWvlebukhuJkp/QdpeQLTTGtQs+xK2+77j1z3cBBP/8yuS5s7MidgQ9abM
	pjL6kRaSCoN8K2GTDfzX7G8mRxZa1gwobyo+xiIPQEPwnsDaSsuxDj7RgxzzfgD1dS6Tfog9ECf
	oATMwh9bO2fN8Hr4jAXhl4RY+6w4lxt05CYOSis4CC7yTKT9289ve3YEmtH14VxihlV6nKRy7j0
	EkXM2gV9FVgKNElwrb3EktsoNwWYBFPWRmUHtU/reMir/C4ceq2nXdHF78etk0QKc++MD/yPgPL
	mRgehpn1BMEloYpzHu5PyCNxl/Pwu9CqrGYMBruGRQUWDp44IHSo/rs
X-Received: by 2002:a05:6a21:6010:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cd3009ca00mr5839718637.10.1787282232764;
        Thu, 20 Aug 2026 20:17:12 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:1d00:6f7:10c9:b208:aa96:517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15543ec0fsm2346460a12.9.2026.08.20.20.17.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 20:17:12 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/2] selftests/livepatch: filter debug messages in check_result()
Date: Fri, 21 Aug 2026 11:16:48 +0800
Message-ID: <20260821031648.48195-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260821031648.48195-1-laoar.shao@gmail.com>
References: <20260821031648.48195-1-laoar.shao@gmail.com>
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
---
 tools/testing/selftests/livepatch/functions.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 30dc677b2f45..1eba371f9d4d 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -306,9 +306,9 @@ function start_test {
 	# find new kernel messages since the test started.
 	local last_dmesg_msg="livepatch kselftest timestamp: $(date --rfc-3339=ns)"
 	log "$last_dmesg_msg"
-	loop_until 'dmesg | grep -q "$last_dmesg_msg"' ||
+	loop_until 'dmesg --raw | grep -q "$last_dmesg_msg"' ||
 		die "buffer busy? can't find canary dmesg message: $last_dmesg_msg"
-	LAST_DMESG=$(dmesg | grep "$last_dmesg_msg")
+	LAST_DMESG=$(dmesg --raw | grep "$last_dmesg_msg")
 
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
+	result=$(dmesg --raw | \
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

