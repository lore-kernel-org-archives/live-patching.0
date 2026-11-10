Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327053;
	b=YcJognZbm7WlwOHiBs5vREzPJMk2IS4nyu+nd2a9mZunS46xtmTsq1TUvxJGjCy83Ith
	 volLMj6ahnelV5hm5VsYkIQL3osIoAC1SMGVof5qQpBep4qhFQki4XcPzH8xqQjgDj8Ui
	 d73SwCY30ZaJB1F4LPE0guXU4KXZKmwvZeCovdQ+G12eh2qWHSut+jjdgLklfD8mv0M3+
	 ptwY7WfiQf3c05FQpQI4Nu7FlEOCg0EKfFTHQZsvuHv7tqBJKWTC1gMX4+cBpfPTh68Zl
	 QfNCjYd+P90YTmtvo3uK41Dqcq6MqucS71RGlFf/03dIuVrZ/vvmZ33k358Gm/ROjSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CV+mdHAL7N59uyblFwGXb2Ju9QjUsdjoyJ/L6DhW424=;
	b=1EHAjAIhCzUcKrmB6Bh7l6BBOwtw2RutWj2odNnUUGQ7zSJmWNFEkcDPTCgBdcIZSWo8
	 epXnR/xxPI8fpjn3EJfbTRveoNEaCLzwwudXK2NZv1wqD7vVA2yKpIKph/eqUZ82hluyh
	 s9fBOwv5liLDh6P+AMUnUHj00VPjprqXk3S08m9BYewvBQkV55REqijVq2N3S9YZZToPo
	 lvKb1lFN1/DxQUd64fCBy/qvDCGlnzDJZUdOPMPKjfCDmpzCG2yhZAmzgnY4ornf3+NmU
	 hLJX54xOtnD02RoGJCmoP9U/BXCm0qgX3u4svFrMhn92/UDPrd2z7ktetS7OkhSAUgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/lRLRhg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1807606A32D;
	Tue, 10 Nov 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/lRLRhg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648031F0089F;
	Tue, 10 Nov 2026 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327052;
	bh=CV+mdHAL7N59uyblFwGXb2Ju9QjUsdjoyJ/L6DhW424=;
	h=From:To:Cc:Subject:Date;
	b=d/lRLRhgeBayI/cg9IkKvRv8xdtlAymCkkbQFq8Z93CB1WDUKdgZM3R4yVtMCpI45
	 xuPNK0Svja993reg4+rZ7tVhXvY9rkDFPxKHK83QhBpGxmttjqtR6yueZ0bXxmtUE7
	 eELYvPAwOzfy/m6ItQXNE6N4nlw1l2iv9PbbFmASgfbeYWic3Nz1BNpS1tKODCztdj
	 6cpLsrk4bSgqU/SN7zd26urJ9BhqDqbBSDKO94N9A/bJzX4xOUpDpeuydG9EiqasXa
	 zpz+qentgI2Jr5vmA5K0A1X/MbGxP67nCFtxgGnkY+xQJmj3QaAk7FjAv0Lxp031Wz
	 OZJHmdsHcGd5Q==
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
Subject: [PATCH v4 0/4] selftests/livepatch: build and run the tests outside the running kernel
Date: Tue, 10 Nov 2026 11:10:46 -0500
Message-ID: <20261110161050.2451750-1-sashal@kernel.org>
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

The livepatch selftests build their test modules against the running
kernel and skip every test without its devel files, so they do not
work when built for one kernel and run on another, as CI systems do.
In KernelCI, 36 of 69 kselftest builds of mainline fail to compile the
modules because the kernel lacks CONFIG_LIVEPATCH, and where the
modules do build, the installed tests skip themselves.

- Patch 1 skips the modules and tests when livepatch is not enabled.
- Patch 2 lets "make clean" remove the modules without a kernel build
  directory.
- Patch 3 builds the modules against the kernel in O= or KBUILD_OUTPUT.
- Patch 4 runs the tests with the installed modules, without the devel
  files.

Tested on x86_64 against kernels built with O= and in place, a kernel
without livepatch and the Debian headers. The modules build and clean
in every case, and the installed tests pass 8/8 in a VM without devel
files, where they were all skipped before.

Changes since v3:
- Split into four patches, rewrote the commit messages and added
  comments. (Petr)
- Moved the CONFIG_LIVEPATCH check into test_modules/Makefile, which
  drops the extra clean target (Petr), and read it from
  include/config/auto.conf.
- Patch 4 still skips when neither the modules nor KDIR are available.
  (Petr)

v3: https://lore.kernel.org/all/20261103222706.1642224-1-sashal@kernel.org/

Sasha Levin (4):
  selftests/livepatch: skip the tests on kernels without livepatch
  selftests/livepatch: clean the test modules without a kernel build
    directory
  selftests/livepatch: build the test modules against the kernel in O=
  selftests/livepatch: run the tests with prebuilt test modules

 tools/testing/selftests/livepatch/Makefile    | 26 +++++++++++++++++
 .../testing/selftests/livepatch/functions.sh  | 13 ++++++---
 .../selftests/livepatch/test_modules/Makefile | 29 ++++++++++++++-----
 3 files changed, 57 insertions(+), 11 deletions(-)


base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.53.0

