Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744832;
	b=zRo2I7P92EXXHvg8SaVVlMMCzvN0Dls415xvAgPPOStLriT5a0wvaNUJK90pvXF9+hy1
	 nSVkN6CWIN3FFrIHMbcwaJzBqImUK6uxjTZ5CaewAKI9DEP//vj99xsJXwlkmzW0HoeW6
	 zwT3sppLDW2/oJsKPwDa1whAwacT6U7KY3FagtyCkJzuEfimkOAjnWA+VxHahybyIEjIC
	 qqSOqzn447lKJVTgWbRLVObJsPM6VjnCssYzAFehtQermn64BiAAD7C+JfE6GQnNmZQlx
	 VpeMdjVhU352qowRPRxG8Iv4nT3pXCmrW5IhZq50RX3sh2ZjRmJsNIfWONSbYCuCjJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/ci6k4oqs2nbzif7LoyW5jMqduAUL1OYo5QDwTnoE6U=;
	b=ZO32DU+JMnGMdPZWux0nFQnX3/q/ou3UB5qKr6kYvsG14humwbjc9Ia9bh1L30N3QZls
	 dRFQawIi0omJNWu/ZvCD6Xi5RxSGD+m6E6V3J7MZQh7JVyyGkGbmxOZdnhyp8fBgWhKD1
	 qCn/BiLNuBtZoqzY0mq9k7UgPGS68fvpdRl0mo+jJPjrxkKpEQ6qPcCuO4a6NtIpjAMY8
	 nnBjR3PczjdtBHDmpFViZjGdmvPvhnG2jicjll1hNX4kZnOl93yOf0W5TIYdsvEVwU/uc
	 ncJAy3qh/KJrm+vekqQbKnc894TM5Td0UnuSVzq9fdx+T6FlsTTz8gGDEJPRyPwg0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpWzzhRM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911E606A33D;
	Tue,  3 Nov 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpWzzhRM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F11F000C1;
	Tue,  3 Nov 2026 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744831;
	bh=/ci6k4oqs2nbzif7LoyW5jMqduAUL1OYo5QDwTnoE6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpWzzhRMe9ouT661sPi2E4GkWyV6XJHdZ28Tqb9ukfNRrl2Y1tuzlICwpCNwbCfla
	 q2JFOcIFcdMCBsgxBX4AXf6bXKsoWNGxoPwycISf1+tTIfpiDKqIhUn+QiN79qAljB
	 9F1wAqhKGgGX+tr126emyFK36KF0zOGHYGxEsXVqldP2R4O6Mqzfk8HHBK9geU7hOq
	 chrw1wp+IuQHAF1CDL+Tm+5EglSCWCL9zHWTCETpEuSlPCkIz0hUqFhRh+z7UeKBDE
	 fKj0jzbDbwkNqRl/ZNJjTiebSVqOlRDA45EzkaHJd95ro+2frsvbIfTRqS5WzHABRF
	 rQ3VKIKkV23aA==
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
Subject: [PATCH v3 2/2] selftests/livepatch: skip based on the test modules instead of KDIR
Date: Tue,  3 Nov 2026 17:27:06 -0500
Message-ID: <20261103222706.1642224-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103222706.1642224-1-sashal@kernel.org>
References: <20261103222706.1642224-1-sashal@kernel.org>
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

