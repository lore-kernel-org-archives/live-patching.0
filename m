Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714544;
	b=iWSO78MoUTnxRltbCZQ9hMiXJdO2hqGOHWK4q+ZjgeKNGzhK5i52XvNGhV6kd87Ig0K5
	 ompRpF9evgaLwnYqnwEt4/xEKUeIuON5VXJCsswFvqsp9I3Cn5Tdhic4DECUgHvPfrbON
	 QVI9OhJF529MQX6uz/ljRMpY/wST5T1K4MtffxuFx09eC6z1ocoQfeksUjROyPwbw//jI
	 waXpJO/H3n2Mo0fx7cq5EKb5XeCb6iqellHtBtI9L3dXlicXGpv42CcAGgfdSiwht2uvm
	 auL2gtd3L1rrCeTMwObGQH+wcuLDf1J4/V/JQ1VWZBudKOTi7WQuGRwd28oGwIusQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/ci6k4oqs2nbzif7LoyW5jMqduAUL1OYo5QDwTnoE6U=;
	b=YmLZ/Rt+Vb62hTfD6RKV6ptZTjLIdwDxv3AItp4YCW7+haZTa3YaCPK41L+om1+FORpS
	 33uIB4I9cHYgAVrhURkbhkfThcFfrkpvbOpF9PFlrDIO0n6WqOhoEGCddx4q1paQniUTc
	 UgMsa+cjqt9ZiKFeGaacpKD1VUEFiO/BZFmtm6sdHOu29atYLSCugO4dRySzOxZtUgBP/
	 G3TmsbKnvbLQ9UwSmvnczmfeujY1jmsDBcr8SqIiJYRl9+mvr5NV8tTpwM031x2T7J9e1
	 kRptY2SCP+BpkhebjBBy8DyLHGKGkBAzyYrVwyYOztmEgf58ZxyvBPMzE9QvRD1gFdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClcOSqOh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC1606D810;
	Tue,  3 Nov 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClcOSqOh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA8F1F00919;
	Tue,  3 Nov 2026 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714544;
	bh=/ci6k4oqs2nbzif7LoyW5jMqduAUL1OYo5QDwTnoE6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClcOSqOh/CnPKw1DMkG91z2imhABNwjhBfnoloDtaj7Cug8/HNTgrWmo0q0/NLRM0
	 jAQBjZQPvvERHlTJoaha8MziXTISd7ublVu3Axv8F4iBf/5mG5n4L4RSRXC9sKPM3B
	 J147+7K7A0X+pRUEOt4aTUxHuAkoPl/SpHj/WVEz3xwYpiCOik3M5ThafXIoNvtXRs
	 i+FLDmDdBBneLljLlj+p9/36DwN2IvmuS9689/gt9TbctHz/LFIVa1mWOJDGHIHV24
	 oUF5I164rW9nTudIjIBH/NQym/yCqTysWmFw6sYUTgXgGo3B8n/16mojf0AqAvjtZv
	 Xviiok/VRFJxg==
From: Sasha Levin <sashal@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/livepatch: skip based on the test modules instead of KDIR
Date: Tue,  3 Nov 2026 09:02:18 -0500
Message-ID: <20261103140218.17568-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103140218.17568-1-sashal@kernel.org>
References: <20261103140218.17568-1-sashal@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_config() skips every test when there is no kernel build directory
at $KDIR or /lib/modules/$(uname -r)/build. The test modules are built
together with the selftests and the scripts load them from
test_modules/, so nothing needs a build directory at run time. A
machine running an installed kselftest tree usually has none, and the
tests are skipped there although the modules were built and installed.

Check for the modules that __load_mod() loads instead, and remove
has_kdir(), which has no other users.

Fixes: 54ee3526796f ("selftests: livepatch: Avoid running the tests if kernel-devel is missing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/livepatch/functions.sh | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 8b26b70f92d8c..14fc9cade4de3 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -44,16 +44,10 @@ function is_root() {
 	fi
 }
 
-# Check if we can compile the modules before loading them
-function has_kdir() {
-	if [ -z "$KDIR" ]; then
-		KDIR="/lib/modules/$(uname -r)/build"
-	fi
-
-	if [ ! -d "$KDIR" ]; then
-		echo "skip all tests: KDIR ($KDIR) not available to compile modules."
-		exit $ksft_skip
-	fi
+# Check that the test modules were built before loading them
+function has_test_modules() {
+	compgen -G "test_modules/*.ko" > /dev/null ||
+		skip "test modules are not available"
 }
 
 # die(msg) - game over, man
@@ -151,7 +145,7 @@ function cleanup() {
 function setup_config() {
 	is_root
 	[[ -d "$SYSFS_KLP_DIR" ]] || skip "livepatch is not available"
-	has_kdir
+	has_test_modules
 	push_config
 	set_dynamic_debug
 	set_ftrace_enabled 1
-- 
2.53.0

