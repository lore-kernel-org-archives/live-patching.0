Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14563D0927;
	Sun,  6 Sep 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728727; cv=none; b=mxbOBwNn+Cf+yyYyuq0MzB0fRKJJacJN4+K+eUd2rKke9PYd9O66DZAaPMAWnMDkm3HFe7TLmTeYKpwZihoINu12ivAZBKA8hQUizMuiWVtH8edSBAGYHacuD6ikewPRXMUli6am8UPbtc7ynqAB5MpI8TuS19fTNt8RUXhaBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728727; c=relaxed/simple;
	bh=FSidv/qNTf55M88IvPpS0rThvRv7ry/b6RfaUm3+67g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPHNBBLP90ejEll72msH8Yz5Y+/j3eDrRqVJJ9cgXSePMYR6x8uP4LmkzQ5Fy2jCctqAVwkKvK2cRDYe8NoOQkajgzOTpKR4MwL+nBLyTmZmfkhCVUvv34qC9U809yhTD/igICKvWnRJpNCkuGu3+nWQFIZ3faiXZo3Mhita9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=WWj/8cxJ; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WWj/8cxJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=7ZRDUXUsGwRN+ne0AawD7gejvXQP/E6c8+m2m5pqP/k=; b=WWj/8cxJJ6gg
	zT8Sua57Iv8xcjGv1dLDbgktgfP1aZLlEyIqnAyYL6mEpirC0uWnSGtTRT0ypEM7SRg0ZgmXSP/Qw
	oH0UPR4T9BXr/hCkPpueyOPQpsOlFaCLlJ62FntB1Ez+wz5xf1youiRhFgVv8nXQ+Q97No8spph+a
	BDpvxP59tVKRgGEd6SIm0cHdOB6O40k4O1986I8p6OyLbsJPlefZMLBF8o1Z8TjGLdPrn4QTOnio3
	XHa0tGIU+RdhpCoucfRZRp26Wps/QM0ODxbbbdWFP1JEUxw2qObVCYkIItXsoFpKAho2pdsqpHhsW
	44CmP303GIyK7330u/R/Rw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1x3Jlk-00G6jo-18;
	Sun, 06 Sep 2026 22:49:44 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: livepatch: do not require a kernel build tree to run
Date: Sun,  6 Sep 2026 23:49:28 +0300
Message-ID: <20260906204932.2343013-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_config() calls has_kdir(), which skips every livepatch test when
/lib/modules/$(uname -r)/build is missing. The tests do not compile
anything though, they insmod the pre-built modules from test_modules/,
so the check tests a proxy rather than the thing it cares about.

That proxy holds only for a source tree or a machine with kernel-devel
installed. A packaged testsuite ships the modules pre-built and runs on
machines with no kernel build tree at all, and there every single test
reports "ok ... # SKIP". A harness that looks for "not ok" then reports
the suite as passed, so the whole suite silently tests nothing.

Test for the modules instead. Missing modules still skip rather than
fail, which is what the KDIR check was there for, and the tests now run
wherever the modules are.

Fixes: 54ee3526796f ("selftests: livepatch: Avoid running the tests if kernel-devel is missing")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 tools/testing/selftests/livepatch/functions.sh | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index a65b7b1ac8ad..492955ca2fa0 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -44,14 +44,12 @@ function is_root() {
 	fi
 }
 
-# Check if we can compile the modules before loading them
-function has_kdir() {
-	if [ -z "$KDIR" ]; then
-		KDIR="/lib/modules/$(uname -r)/build"
-	fi
+# Check that the test modules are there before loading them
+function has_test_modules() {
+	local mods=(test_modules/*.ko)
 
-	if [ ! -d "$KDIR" ]; then
-		echo "skip all tests: KDIR ($KDIR) not available to compile modules."
+	if [ ! -e "${mods[0]}" ]; then
+		echo "skip all tests: test modules are not built, run make first" >&2
 		exit $ksft_skip
 	fi
 }
@@ -150,7 +148,7 @@ function cleanup() {
 #		 the ftrace_enabled sysctl.
 function setup_config() {
 	is_root
-	has_kdir
+	has_test_modules
 	push_config
 	set_dynamic_debug
 	set_ftrace_enabled 1
-- 
2.55.0

