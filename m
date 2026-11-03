Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744829;
	b=UvB/UgB1J8KiDm6pXiGlmTFmDS23l2AgIckaLWvlZHln1TGx7SkHQh9jQKhGzd4L20Xb
	 +E6CcmC3w0/84NzO4qUwCpiNAtpsovq8innUx2eJplOmYBKo+FUscXjvRYI8vjWeXcZnA
	 NuoUCAiW0St0Lu2prD+lfzAIKFF9N0o2cTvO64qPLofiHjAhK9IcZqNsf/YRwBMSEK55t
	 VCmWxdmdoJj77a2SJlOKxKrWHBb+GodxqfOi8Fs9l2enMd5+hAykElmYJH0E4qiypMT0+
	 LMXYKh9Fle3NNgKxs6fmif+ndu1rjcIHOIoIsJSTg7tVoPMPMMlIfXc68xteGA6f26Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CX279Eb4tbMpKOIQlNE7fd8p5zbQeZ51F2VkoR5Ky6s=;
	b=a57nkC7dGZf2HJaZ1CK8mHZnyEtUENjaRXU+GVBM+BmESQeZlMOJCardWAEVgdM2BceU
	 MVFMiuAJf/yZpish/7B9JBjGwwlfR6JITUhtrMURElt4fZnTNj1yTn/1d3djSRWw2QlFy
	 y4VpSvHpHUt86gxiv3zcKYu4Wucjpr7RlRXzDQe0oSfjKQhIJvJgsB1iTva1od1DT54m2
	 lFcXDY4Hy4ZLn73vEwtiVhaJ3Oqa81ZQatDT5U6eO6BzZndX0XCAsOalZSQmEWH4pmhB7
	 QPd+YVx9LbNMusxQenlf3tcyXa7SEJlhGxngzijXkhhKWyNCfkaLg1Ij6QkMJmi1MfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiTOAc9Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE74606A31B;
	Tue,  3 Nov 2026 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiTOAc9Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858BC1F000C1;
	Tue,  3 Nov 2026 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744828;
	bh=CX279Eb4tbMpKOIQlNE7fd8p5zbQeZ51F2VkoR5Ky6s=;
	h=From:To:Cc:Subject:Date;
	b=hiTOAc9QiC8NEHTB+6maeLQHqivGXNc2o52KUZ7h4A2jDrZvTAHbrl+FB/5cEfEml
	 SZ2cFgQEltrBJlpFsPU4PX/miCLSi5o+9K/lqa4Y97I4zTVcNpbluLxxeYiIIwkWJc
	 /QQQa+6/Uhnwi82aRRTqA+iGwFgfmS7Lfv4E3WhRrdiQ14RTU4qcZ/C8F1BvW6vZ+1
	 bZwnj79+eIihBz3X3m9zjrVJYsdLhKy/LdQ6Y+BopsNwpYLoOVbUU2P/B+40k11Wp+
	 0o0HCj4ipuOACaVDID9sOAaRpu6SjkCc89d3uxW6j+DNvPt9Y0YZSt5j4xUGDjQrQL
	 ucj6GT9x5gb9A==
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
Subject: [PATCH v3 0/2] selftests/livepatch: fix building and running outside the host kernel
Date: Tue,  3 Nov 2026 17:27:04 -0500
Message-ID: <20261103222706.1642224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The livepatch test modules are built against the running host kernel
even when the selftests are built for a kernel in an output directory,
and the scripts skip every test on a machine without a kernel build
tree, even when the modules were built and installed with the
selftests.

Patch 1 picks KDIR from O or KBUILD_OUTPUT, stops passing O and
KBUILD_OUTPUT on to the module build, and skips the modules for kernels
without CONFIG_LIVEPATCH. Patch 2 makes the scripts check for the test
modules instead of a kernel build tree.

Tested on v7.4-rc1 with an x86_64 kernel with CONFIG_LIVEPATCH built in
an output directory. The modules build against it with relative and
absolute O and KDIR, through tools/testing/selftests and through the
kernel's kselftest targets, and clean removes them in all of those
cases, also after Module.symvers is gone. The installed tree was run in
a VM that has no build directory for that kernel: all 8 livepatch tests
pass, and they skip cleanly when test_modules/ is missing.

Changes since v2:
- Patch 1: clean test_modules through the kernel source tree that
  contains them, so that clean no longer skips them for a relative O, a
  missing Module.symvers or a missing /lib/modules/$(uname -r)/build,
  and pass a KDIR given on the command line on as an absolute path.
  Both found by Sashiko.
- Patch 2 is unchanged.

v2: https://lore.kernel.org/all/20261103140218.17568-1-sashal@kernel.org/
v1: https://lore.kernel.org/all/20261014200154.1365200-1-sashal@kernel.org/

Sasha Levin (2):
  selftests/livepatch: build test modules against the selected kernel
  selftests/livepatch: skip based on the test modules instead of KDIR

 tools/testing/selftests/livepatch/Makefile    | 28 +++++++++++++++++++
 .../testing/selftests/livepatch/functions.sh  | 17 ++++-------
 .../selftests/livepatch/test_modules/Makefile | 11 ++++----
 3 files changed, 40 insertions(+), 16 deletions(-)

-- 
2.53.0

