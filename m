Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714541;
	b=KXXsStNdkk9UGl7U/dyiLjTfNSLpOyC8I0OLKG3FWbuOD5pvfw+oLH9BcftvDcWByuVN
	 FMyGK0OZIXqNbOgYQhzluDbcQJAAxQBf7p4VLnCdMgY+79qZcdGBz7n0IcFK8GVBRDq1M
	 i3tsiuMhiEpFDllw0HDAVZljh6pLGe+pvynanqAabx3NXlBYiDM75t+O0TGbNbSnhaiIx
	 cSSxknG/KxvLtJaiO9L6qcaRB9xLmc9r4Mw7KaFoPHwDnwbVeE5gq+NXhoKShHqJUPrnW
	 7aM8IM3CW+AVAJZ5m5jccOfA6bbssCdoyXQvYQptqzB98JQTuzuw/zcbh69GTEGJMwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rUFuv9Lcbz9KJrmISJFF1XzlsOChkRDcNjfTn3vqFHY=;
	b=oK6yhCttkZVyKcRqPoCtOm1mt1kgo0Z/9gNm62bINL23dnzuJcFlLZYALOSa/cBcGLz9
	 Mfxw+ZMcivuCVKnutcLM6/7eSU6V9QUXCeheOB7gp5icy9E/hzsccAADSKbQc1K5o/6j5
	 M6wPW+ClbEnDEWStuNMovFE8ZkYuaomlOnNcrCs9NrM6DCovcJyFOCk4HjtAO627j5ZXY
	 /b6xxBNs6rBIPjLtQXG1v5/rjb3eW86g/PkJ+Mw98pTF1votlQvoGuMiBra8kW4/l50Vv
	 mWkc11xWv9vy5UDAVCzKNEN6AnNbBxbPXa7RimyLQDOj/8p7Mds1VEu/3k9Kf7t/bcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sj3HOZa4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2777606A327;
	Tue,  3 Nov 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sj3HOZa4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C0C1F000C1;
	Tue,  3 Nov 2026 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714541;
	bh=rUFuv9Lcbz9KJrmISJFF1XzlsOChkRDcNjfTn3vqFHY=;
	h=From:To:Cc:Subject:Date;
	b=Sj3HOZa4mSkVHPVCIar7NYIjomOsx2xitQayxWUctEolyQozwodN7rWqEYVG4wzRB
	 OxMxSxLis5/Zu0C22WguL9zNaOO93THX4QIfs+76yWJiUKA2+4IDByIFpBlDrzYAS2
	 HSgiWvtdTM21pV4JkJgNf36MSm94NJngRMh65CgYapo6fn7gxNv8th+bbYFzXttINX
	 bPx68vtaqFeUndWbbtZne9ZAbNsTwm56MViWH41n0i3tVFXF7cens1FrEmcDJbFrnk
	 rCQuDHtSGd0Opkd400kIohNvdJbWGEO8Vmh2dljsM7DX7dHC7jBVyAgMcHWuLqu3Kd
	 OdC2+7pagwLsA==
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
Subject: [PATCH v2 0/2] selftests/livepatch: fix building and running outside the host kernel
Date: Tue,  3 Nov 2026 09:02:16 -0500
Message-ID: <20261103140218.17568-1-sashal@kernel.org>
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

Patch 1 is unchanged from v1. It picks KDIR from O or KBUILD_OUTPUT,
stops passing O and KBUILD_OUTPUT on to the module build, and skips the
modules for kernels without CONFIG_LIVEPATCH.

Patch 2 is new. Sashiko pointed out on v1 that has_kdir() skips the
tests on installed targets. That check predates this series, but it is
the run time half of the same problem, so patch 2 checks for the test
modules instead.

Tested on v7.4-rc1 with an x86_64 kernel with CONFIG_LIVEPATCH built in
an output directory. The modules build against it with

  make -C tools/testing/selftests O=... TARGETS=livepatch install

and the installed tree was run in a VM that has no build directory for
that kernel. Without patch 2 every test skips on the missing KDIR. With
it all 8 livepatch tests pass, and they skip cleanly when test_modules/
is missing.

Changes since v1:
- Add patch 2.
- Rebase on v7.4-rc1, no changes to patch 1.

v1: https://lore.kernel.org/all/20261014200154.1365200-1-sashal@kernel.org/

Sasha Levin (2):
  selftests/livepatch: build test modules against the selected kernel
  selftests/livepatch: skip based on the test modules instead of KDIR

 tools/testing/selftests/livepatch/Makefile    | 27 +++++++++++++++++++
 .../testing/selftests/livepatch/functions.sh  | 17 +++++-------
 .../selftests/livepatch/test_modules/Makefile |  6 +++--
 3 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.53.0

