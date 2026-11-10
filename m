Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327056;
	b=YypW3o+ZnndQTexWmAs9uUZKMQIVyLDAuK9j8NjK112rHi2EyS7Pk06ifOUgA9LArEAB
	 rTmK9AbgdlPhJDDJLpMLRbX2akIVXzk6j28xKIFtxd56i/r8s8NIofOi+YcOaCIvcRqJY
	 QeNXSf9MPuY4BDxuTMWJnYcgMZEK60wTPvrz2YJAWvY6VZ+EArdd4VcNtzrgRmLNp/6sc
	 ABWUuAI1Q9DRrU/V7w5nYbTl2Qx9LCcarOICAvwyo4WB6YTwWeRbuMgbBNGniYtRerRk2
	 KPKFYc26xdxKyzK7FgbFUGZxmPTa3aiBtjW+3VOIF02273BrESQj69Ybi7iL7/oYK7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cD6EstMsPhe7VWF8sbmk9VuB7UraTEV78jy7xsSZcYQ=;
	b=opSvYyddAUSGo3vm9E/SlWYbVZOwr4PoUmTMEvB5j+tAaBTwrqWLPpJHUu1jqUXtrhah
	 dI9htFaN5BnWpbLnKT1qk6ZmmzSB5w9b7b1jyLBx8pKYgj/80nptCyjw/VgmKYhwzv8MP
	 t8X5G6WlM6k1MF/JteifljhrEWSP78x4cInUcljsI86AOlMePMulQMKsTALu7p5227XUI
	 5FGcH5HzDqgWYPogEaUCh4TgE+RMQuzAjR59X2umxpSYrmSRvDZ7XHkdox33Bn+ftSxzt
	 HOhj3ZyNgIweyHJqyhIqkwUCwDY7EDty6fp4UN5TD2CpRUX3mEppjNI6kqDABiT4fJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CD4oVR0G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038460A382A;
	Tue, 10 Nov 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CD4oVR0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5521F008A1;
	Tue, 10 Nov 2026 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327055;
	bh=cD6EstMsPhe7VWF8sbmk9VuB7UraTEV78jy7xsSZcYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CD4oVR0GMgFk5RjWZD0Kc1//P3K8OMYpcMOx9nkLyVOxQU9a4C3qmF0XWBjES1Zsh
	 RIK3s3A7pvAXo5/nt2EfNc8VbOU48D6PtNPCSTJB2lVjSe0q3G5SK2bq82k41W55do
	 aSyUMMuH6qJ3t10ffn3sFJaZoJktEQjMIc8IvmiQGn+/vW/4S0hJNOwlmJLhNO9iUn
	 GhCiCzrIwK30wwMm4qYkspOqGdatMMPQpDDuvU9qUjEmaAML5WPojO/B/We8M9KA2n
	 DGs5e80DWsGA2nfEISdepASU1MUb/OJsfJWINzENku6h2B7fdaOVY+LGlAUBPC6xfN
	 NY65IqWtAhqPw==
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
Subject: [PATCH v4 2/4] selftests/livepatch: clean the test modules without a kernel build directory
Date: Tue, 10 Nov 2026 11:10:48 -0500
Message-ID: <20261110161050.2451750-3-sashal@kernel.org>
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

"make clean" removes the test modules only when KDIR exists, and KDIR
defaults to the build directory of the running kernel. Modules built
for another kernel are therefore left in the source tree by a plain
"make clean" on a machine without the running kernel's devel files,
for example after building them as KernelCI does:

  make -C tools/testing/selftests O=<kernel> KDIR=<kernel> TARGETS=livepatch
  make -C tools/testing/selftests TARGETS=livepatch clean

Removing external modules does not need a configured kernel. Clean
them through the kernel source tree that contains the selftests, and
do not pass on O= or KBUILD_OUTPUT, which the kernel Makefile would
take as its build directory.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/livepatch/test_modules/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index eddfb420db320..01eaf2e1755c9 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -32,8 +32,11 @@ ifdef BUILD_TEST_MODS
 	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
 endif
 
-# Ensure that KDIR exists, otherwise skip the clean target
+# Cleaning external modules needs no configured kernel, so clean them
+# through the kernel source tree that contains this directory. The kernel
+# Makefile would take an O= or KBUILD_OUTPUT passed on from the selftests
+# build as its build directory, so drop them.
+clean: MAKEOVERRIDES := $(filter-out O=% KBUILD_OUTPUT=%,$(MAKEOVERRIDES))
 clean:
-ifneq ("$(wildcard $(KDIR))", "")
-	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
-endif
+	$(Q)env -u KBUILD_OUTPUT $(MAKE) -C $(TESTMODS_DIR)/../../../../.. \
+		clean KBUILD_EXTMOD=$(TESTMODS_DIR)
-- 
2.53.0

