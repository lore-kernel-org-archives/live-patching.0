Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3815490BE9;
	Sat, 17 Oct 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247870; cv=none; b=qdsMgyj6GYKsoSC3utNnDUj/9HFynefMaJQAaJNuRVKA9DLtIVChb4xehi397SWXIpfAC/Z4p4Z8914gDBotgmZqsz4saheDRQ7PzKGEDgeBipZga6fdGJQRnNYJOkUnMrlJhKUHFgHOTTcTnDuAHLDZVhefEFNbVojZtD8WTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247870; c=relaxed/simple;
	bh=ZrYHPIZCYyGGSWwkvGjKuL3ZPw06s8Yq5vHdPV3Iews=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNHxZRDCm2Zi/pEIWN/APpySdeOVVamOITV44Puf0EgERjVXfqY/HeH1M0hT7iCCXhtFGzUcE7VHdEaqkCcpRURhAzuyuvWg3aNe++sapilKE7LTXbNa1A3ieYYb8TB1GU0gAxIoQPcDF5r+8u6ZsDxfK4gnXQOPaOlH4zpXX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUucexSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUucexSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EDA1F000C4;
	Sat, 17 Oct 2026 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247869;
	bh=MQ8J4x1kAPgaO0Zvom1oyzDZ4z6A8asV7Zm9GAhDF8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUucexSaqXmp+GIlTk+8oGOzkl1dAl5G/NKObWYRaKzC8rYbbBJIJppnbar+TaMF1
	 nnLbJBay13gR/7/toVupI5WP5r3+tJb6HUmQyhENQRqQ9AVmf7D8SzAgk4oeHchvS9
	 6yGNiyTdvlz2Qi2G+EDdkCbKb0TMgk9GXG+flhgx7gHB81rg8kLn3BcGVf+r+OpsM3
	 IU7MEK/HfAxxze8qJ6hnC/sLi9cG+xTlOWqtfQ30i1iSBji5yYeq0nVvnRYNIXwqc1
	 Z/QZHQGzlhcV+JOgnbNhASA1JYcJOlp16eDNoSBi0NOzKI8cGzLwl4OUUovKEY0VFF
	 z8Xz6EPz2luBw==
From: Sasha Levin <sashal@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: build test modules against the selected kernel
Date: Sat, 17 Oct 2026 10:37:45 -0400
Message-ID: <20261017143745.2601801-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-171842@kernel.org>
References: <20261014200154.1365200-1-sashal@kernel.org> <sashiko-outbox-171842@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 08:12:26PM +0000, sashiko-bot@kernel.org wrote:
>> +modules clean: MAKEOVERRIDES := $(filter-out O=% KBUILD_OUTPUT=%,$(MAKEOVERRIDES))
>
>[Severity: Medium]
>Will this target-specific assignment of MAKEOVERRIDES be ignored by GNU Make?
>
>GNU Make does not support target-specific assignments for special variables
>like MAKEOVERRIDES and MAKEFLAGS. As a result, the global O= and
>KBUILD_OUTPUT= overrides will still be passed to the sub-make via MAKEFLAGS.

It is not ignored. MAKEFLAGS holds a reference to $(MAKEOVERRIDES), so
the sub-make started from these recipes gets the filtered value.

I checked with make 4.4.1, running the livepatch Makefile with O= and
KBUILD_OUTPUT= on the command line and a KDIR whose Makefile prints what
it receives. Without this patch both arrive as command line variables.
With it, neither is in MAKEFLAGS, KBUILD_OUTPUT is unset, and O is only
in the environment, which the kernel Makefile ignores since it uses O
only when its origin is "command line".

>Is the call to has_kdir inside setup_config still appropriate here?
>
>When running tests via the kselftest_install workflow on a target system
>without a kernel build tree, has_kdir fails and unconditionally skips the
>tests.

This patch does not change that. setup_config has called has_kdir since
54ee3526796f ("selftests: livepatch: Avoid running the tests if kernel-devel is missing"),
and this patch only adds the livepatch availability check in front of it.

-- 
Thanks,
Sasha
