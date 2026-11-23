Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448676;
	b=0+4BFp7Z519HPXUQLMxHNOQqL1yhJFG+cybgXUqyy+20Z9ZTojU1uXbGiGh030ziJZEb
	 GsOMHw3cR5Z3wQFmsLRrF18kP0VFlyooDH2pifRtFeTM0QE8KWIVkfQnNrpDkdv8AClDT
	 SIBOqXWjcBs8kuIb3v5KZzYIxlEhtfCpFzHXxeM4wIoY4+Im6qUnYTVWnTZUERRh5pu+d
	 4/Vd7ech5A3JqKdZOvGRaZcgqqHnsIGZ2gCYhXPQIL3yr8zZcSpLdPCHATghG87stQyq5
	 KLh+LJRrs93hCUMmRK+/N+BQJ6K3XVOLkC0dpg6A0uIcwpu2PzIg+P6xmrt9tQZE1QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gbIOWZ+5eubv2tOG0WAeL5khWfJEkRgTbTT2mcq6PeQ=;
	b=gSXe67gmqShcG5avkOGRmP9koP8CBMktzkuPZx/YQN3gXzYS3ZJX1ao2TjpXwHvFZT5D
	 JdWnosfABcCJ1qWZpb5wypqxuS9o79Qjx6PY8ThTA/MEN0qbXxA+cOxb/QQqfwch8KPnG
	 Z/qlty5CmZoK9s7yLZ7boSlt7Az6p889WZqt2m2/w4PMbdaJt4BRihS3AznX8dRICP7UR
	 BGpXTqHUxVMT8dtTulDE3sfYL7ZfTW83YAiTEa0ulRoKlAyipLqswzXPG8ZZUUw+d6cKp
	 IryS8ufqd0ep5vM83A+sQ3M1Pa5KwKQwpM0H49PQem5XGhBE9NiKd5gCiR10I7jB0oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBhlYYdW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D4606A31A;
	Mon, 23 Nov 2026 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBhlYYdW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6151C1F000C4;
	Mon, 23 Nov 2026 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448675;
	bh=gbIOWZ+5eubv2tOG0WAeL5khWfJEkRgTbTT2mcq6PeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBhlYYdW34Tx3qqpW2mz4TD2iDTpKL8ep3cja8W+bheqVOEHlBOmODgeTeKuAhLdm
	 Y/psMtOM8hzdjnwmps3rE1YvN/eXvWFTUCFdBO+1xanBLB2nn8AMK8/wvMH6DhXehs
	 Ni/Fw3gStc6OsbuMvnQmXS3G8w8C2p6/48D5FNQZZSQnDoft+ixT77Zjg1k4RYg+vA
	 lfpfgR1Q8ON++wcE1pHWiUvdRM+XvP/3+MdUiB7CtrtXgTqxb/k3vokl7hWxEBbCKl
	 6Rjj4ce6DBka0A+Jafv03p/Mk4mo3vFjHz77uoFGzi5y1SKRqfG72E3YbxDECP61wQ
	 rp8MCmPWyTC9w==
From: Sasha Levin <sashal@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] selftests/livepatch: clean the test modules without a kernel build directory
Date: Mon, 23 Nov 2026 10:44:33 -0500
Message-ID: <20261123154433.1188237-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <awQUD16CDFpCTxaQ@pathway.suse.cz>
References: <20261110161050.2451750-1-sashal@kernel.org> <20261110161050.2451750-3-sashal@kernel.org> <awQUD16CDFpCTxaQ@pathway.suse.cz>
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

On Mon, Nov 23, 2026 at 11:23:11AM +0100, Petr Mladek wrote:
> The two parameters "O=<kernel> KDIR=<kernel>" do not make much sense
> to me. The command starts compiling other selftests. I get:
>
> $> make -C tools/testing/selftests  O=<kernel> KDIR=<kernel> TARGETS=livepatch
> Makefile:4: *** Package alsa not found, please install alsa development package or add directory containing `alsa.pc` in PKG_CONFIG_PATH.  Stop.

Sorry, <kernel> was a placeholder for the kernel build directory. Pasted
as is, the shell takes "<kernel>" as redirections, so make gets an empty
O= and no TARGETS at all, and its output goes to a file named
"TARGETS=livepatch". If that's what happened, that file and an empty
"KDIR=" are now at the top of your tree.

> Are these parameters really used by the KernelCI?
> Could you please provide link to a build log?

Yes. This is from Saturday's x86_64 build of mainline:

  make --silent --keep-going --jobs=8 O=/tmp/kci/kernel_build \
       INSTALL_PATH=/tmp/kci/kernel_build/kselftest_install \
       KDIR=/tmp/kci/kernel_build ARCH=x86_64 SRCARCH=x86 \
       CROSS_COMPILE=x86_64-linux-gnu- -C tools/testing/selftests all

  https://files.kernelci.org/kbuild-gcc-14-x86-kselftest-6b01150f99c74e1a99a2a261/build.log.gz

> So, maybe just the sample command in the commit message is wrong.

Yes, it should have used a real path:

  make -C tools/testing/selftests O=/tmp/build KDIR=/tmp/build TARGETS=livepatch

Please keep O= and KDIR= in it, though. The paragraph is about modules
built for a kernel other than the running one, and that's how they get
built without this series.

--
Thanks,
Sasha
