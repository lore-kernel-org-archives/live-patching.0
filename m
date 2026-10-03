Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D539D6FD
	for <live-patching@vger.kernel.org>; Sat,  3 Oct 2026 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791065501; cv=none; b=GRT9kHD0uhmZerK1OkM86f9H9qgRzuE9dkwZMSQZFDdM1kb5W9IIINxDu68r+i8ud0bAPfKeEkVUesoSfZ+RNXCtV9ZabqD41qskZhBsyoV8R1mvZ9RBBSmD4DGHxvlWjpNkOH4gqZIi1E3dZ+F9HZzPJ4gQl7nEpfaJ6dfgugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791065501; c=relaxed/simple;
	bh=BFNitVV9JfN2acTqp2UvAzIMeNfDWZCzHoZd8SErY+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y7o37MvgDLUpFxZuw38bsETEzV9zFqCTU1cQ5RB62jb2AkJriQHe/z8YRndeM9WvzET18bpj3h5qupM+ZvZ0qLFeMik9BF3i2SXP1Zp4xIiYmiecEpn3F1IQvu1q50U1rT2pm414437c6QBnm6JkIdMVQ38fC63w4wyPb/qX5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COEbWPWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COEbWPWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B514E1F0089B;
	Sat,  3 Oct 2026 22:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791065499;
	bh=BFNitVV9JfN2acTqp2UvAzIMeNfDWZCzHoZd8SErY+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=COEbWPWnveOVzJnynok5rstRnwnUuRPR/BESh5XwpnQEdkde4V1IjWcn5Y6Hi1Z6c
	 XLyFMxV9kuul28qhcghoVLLy6Y594NASpPhp+nUdh0AIRQ9qMdFjhNr2LYucSO5eyo
	 fYMt6r8MEQUcc7kSVZYfbBf8LfMfe4LCZs9kxQlR/X7qjob2PbR8fXtTGbRihMoU94
	 zpBPxqA8g7LWwHDTWfUgqL6Se6Dr1uC5jwAg4XDrBR6EdH5qlWsKAyp7Z0ruIWDTPE
	 qs40yq6CNpLse5pWuDH4ucL7P2RfT3f+AGOUE2TyL9zPe+fNVm8ZhvurMf/Ln4jzBx
	 3KTTpJrTkTBxA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC] livepatch: Add integration tests for klp-build toolchain
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com
In-Reply-To: <20261003220433.1539629-1-song@kernel.org>
References: <20261003220433.1539629-1-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 22:11:38 +0000
Message-Id: <20261003221138.B514E1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] livepatch: use-after-free in klp_test_module_init() via dangling k=
lp_test_kobj pointer
- [Medium] livepatch: memory leak of klp_test_module_kobj on sysfs_create_g=
roup() failure
--

commit 440c68ecb776cce99d846849a24bfeacf1e70de3
Author: Song Liu <song@kernel.org>
Subject: livepatch: Add integration tests for klp-build toolchain

This commit adds integration tests for the klp-build toolchain, including
kernel side dummy code built into vmlinux and as a loadable module. It
provides sysfs interfaces to verify livepatches and exercises ThinLTO
suffix handling.

Link: https://lore.kernel.org/live-patching/20260226005436.379303-9-song@ke=
rnel.org/

[Severity: Medium]
In lib/livepatch/klp_test_module.c, inside klp_test_module_init() at line
95, the code returns the result of sysfs_create_group() directly. If this
function fails, does it bypass the cleanup for the recently created
klp_test_module_kobj? Should there be a call to
kobject_put(klp_test_module_kobj) on this error path to prevent a memory
leak?

[Severity: High]
In lib/livepatch/klp_test_vmlinux.c, inside klp_test_vmlinux_init() at
lines 105 and 126, there are error paths where klp_test_kobj is freed via
kobject_put(klp_test_kobj). However, the globally exported pointer
klp_test_kobj is not reset to NULL.

Since klp_test_vmlinux_init() is a late_initcall, an error here does not
halt the system boot. Later, when the klp_test_module is loaded,
klp_test_module_init() in lib/livepatch/klp_test_module.c at line 90
attempts to pass this dangling klp_test_kobj pointer to
kobject_create_and_add() as the parent.

Could this sequence trigger a use-after-free when the kobject core attempts
to access the freed parent's refcount? Should klp_test_kobj be explicitly
set to NULL on the error paths in klp_test_vmlinux_init(), and should
klp_test_module_init() check if klp_test_kobj is valid before using it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003220433.1539=
629-1-song@kernel.org?part=3D1
