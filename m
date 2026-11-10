Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327059;
	b=OavfBQmDnven9Ee69Dy3GFBTlsr8J9eZYbDeS5gKF1fgEq4XT8owNp4hGByBnmfIp4FX
	 474gpuS7/3p/kDlXTUYlnCr0NQI8CUIaD8fkwh2MrIU5t7jUI/5yxBJoM05SwlAKB2fT7
	 Y1Pa9TZqBa5TEOfm9roHK23Ilm07uibzghaMRgNar/oOJU7AkHmeQnSHfyeoIsBwNZiah
	 zk0tg0zLfyGcX0f/yqBxTLdlKw1L2ODiMKUgEGAqKJwsV+c7qmbcURqcoroqEdZZ4QgpR
	 u2T/FlPy3uA6pT5o9006gbgs9eU/2Ql0w+Xhg9T2UUEWbtkFoVWDqA9JB/6o93fNh4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AInHf90morvpMUaE46oqpoBtv/4XBNiYa6yW94Kaa3s=;
	b=qE45s/N610zLbR5JrlXGWX5DQKBV0mWxnOT8fD2WqGX5eAeadGS6+JBEgpH5GXpSWkFb
	 xlu6iE0oXXgPtvLy5UHXceHJkN8GxCt5KgGg7RVyVguvHdtOkgOVHXSf/xe6qcFQBejlP
	 5tXD2oHchi/zycBWVfPaGcMafvWRplzon2EgNpgVj0sLEUQVtZc60rjHk96kLQAqdcQRY
	 wOF19zQOuE8AXK7tSaDdRdP5xX5g6msF/gkaP169MfUmSIZ9u0XB5OrKD9FW5rOoEdzI/
	 TOy38dsJGindZpPlHMn4HGnYdwXs4JBB+22zF+yohXc56tndTDM8gEnGGLWO4ihmIvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2+pu6uY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6C60A6F7F;
	Tue, 10 Nov 2026 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2+pu6uY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD30D1F008A6;
	Tue, 10 Nov 2026 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327059;
	bh=AInHf90morvpMUaE46oqpoBtv/4XBNiYa6yW94Kaa3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2+pu6uYFzsbGdUmLrXYMxR72TJz+jfs7BImWUp4J8lL1FNOzrGPuixnc8JUN3wiP
	 uiv0RcN9sMk3QFxj1XUm76/zEm0z+H/AreKts7PW/n3Hd8GDGANFTPzE1/pKFvhgG4
	 KayAnPQKduLvRmROl6UbkSHna9gNlwUisVZG4ZYFBLLhWxgAtcSqQfeyBIpOhB7yDd
	 eu+995gcKMqgz6NGBYUqdjoDuidmPRqOP+ElVPVeK9cphb7StfG9RU/mmbaCeXuAJi
	 Tibp5nqxd5m9vWLPDqFqkwFptRfMnjQfUGbVW9UonmRX7viSb7nHJGXKq0tuhl/wbj
	 T6npLU7IcdweQ==
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
Subject: [PATCH v4 4/4] selftests/livepatch: run the tests with prebuilt test modules
Date: Tue, 10 Nov 2026 11:10:50 -0500
Message-ID: <20261110161050.2451750-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161050.2451750-1-sashal@kernel.org>
References: <20261110161050.2451750-1-sashal@kernel.org>
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

The tests are skipped unless the machine running them has a kernel
build directory, in $KDIR or /lib/modules/$(uname -r)/build. They do
not need one when the test modules were built with the selftests,
because the scripts load the modules from test_modules/.

As a result the tests are skipped on a machine running an installed
selftests tree without the kernel devel files, for example one
installed with

  make O=/tmp/kselftest TARGETS=livepatch kselftest-install

although the modules are there.

Run the tests when the test modules are available, so that they can
run without the kernel devel files. Without the modules, keep skipping
the tests when there is no kernel build directory to build them with.

Fixes: 54ee3526796f ("selftests: livepatch: Avoid running the tests if kernel-devel is missing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/livepatch/functions.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 8b26b70f92d8c..eebd36b0e0eaf 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -44,14 +44,18 @@ function is_root() {
 	fi
 }
 
-# Check if we can compile the modules before loading them
-function has_kdir() {
+# Check that the test modules were built, or that we can compile them
+function has_test_modules() {
+	if compgen -G "test_modules/*.ko" > /dev/null; then
+		return
+	fi
+
 	if [ -z "$KDIR" ]; then
 		KDIR="/lib/modules/$(uname -r)/build"
 	fi
 
 	if [ ! -d "$KDIR" ]; then
-		echo "skip all tests: KDIR ($KDIR) not available to compile modules."
+		echo "skip all tests: test modules are not available and KDIR ($KDIR) is not available to compile them."
 		exit $ksft_skip
 	fi
 }
@@ -151,7 +155,7 @@ function cleanup() {
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

