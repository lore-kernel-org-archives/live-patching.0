Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14733F58D
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922568; cv=none; b=O9Fv18ka554BCeW0wDFdsm4+w5zj3zIHt04Sg7t8sVWH9rGRVJ3BR5e/cFeeoCk5I/7fMYwUbIxm610c9Nv0DKxrvwWFgBMaBQgSJTb0uSXbWkUButUd/wKatSXkBPISzH25zShM/buF15KTRQFqoEQEiGy5cyJJ+RekKdtYDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922568; c=relaxed/simple;
	bh=hIjRyHD517Hw+9XoBFmlda8tXyjh5EB5HQFbZwHlhH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qj/sEPQvw2BEb/BeZnrz/VTJaImoY7E766S9PbBdpw1/SCIVttzC7kC5SVvS9LrrJsOAR+CvxAnIvCTwRiokUcWvNuPUUhUwGhM/qu2BveHxgcS3G3R4q6lUqrZBWF8KlJJDp3EcBKiC5NH5H4TUwkUx8Bpfq58n8tYouXK9Axg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1aPRMmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1aPRMmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C2C1F00A3A;
	Wed,  9 Sep 2026 02:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788922564;
	bh=WWbqW2bBJ07LPECFpXbV06Z9xCoPYyEE6oigsRq8F4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1aPRMmmv1YZXqUMHR1zsLKTlqpSqqMwRCN8Jb9Fs6ngiGXBWGTmf+g3qk29ZFUUo
	 eEcCTCNeYwnN8x7+KnWgO0xiaObNxU/5JmxgTBQwumxg8cgKgUyPpSDR7MoRqAc46Z
	 /tSCcF1VNjPb8F0AiaelqjT/6cIzRwVAeTzJnoZWwBAnuBqeu+k5EIJEYVB/54Y8tj
	 CwfyIc8WXiXOqzBDTCw0PsP2/qi+mJ+qbTbY5TVlq4kZzIO9Wa3frpORKZ1PGbNtKD
	 VIf3WSq4NkvuiUf8yENlib0TsqfPtehgmfF7qVyLMbBKBvtHp906C813Rw1pthmXe5
	 Rg9ITNSsg+68Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 9/9] selftests/livepatch: Add function test for
 provides/obsoletes
Reply-To: sashiko-reviews@lists.linux.dev
To: song@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, mbenes@suse.cz, "Yafang
 Shao" <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260909024324.16002-10-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
 <20260909024324.16002-10-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 02:56:03 +0000
Message-Id: <20260909025604.14C2C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test fails to verify its own claim that a function is functi=
onally unpatched after an atomic replacement.
--

commit abfccb0026870ac46d37d3802586498b0874cba2
Author: Yafang Shao <laoar.shao@gmail.com>

selftests/livepatch: Add function test for provides/obsoletes

This commit adds selftest scenarios for livepatches using the provides
and obsoletes features to ensure patches with different provides IDs do
not modify the same function. It verifies replacement and coexistence
behaviors for different function combinations. Tests are skipped on legacy
kernels.

> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh=
 b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
[ ... ]
> +# - after the replacement /proc/meminfo is no longer patched, while
> +#   /proc/cmdline is patched
> +# - unload the replacing livepatch, then the replaced one
> +
> +start_test "different functions, atomic replace works (nops)"
> +
> +load_lp $MOD_MEMINFO provides=3D1
> +
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +load_lp $MOD_CMDLINE provides=3D1
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +
> +disable_lp $MOD_CMDLINE

[Severity: Medium]
The test documentation explicitly claims that after the replacement,
/proc/meminfo is no longer patched while /proc/cmdline is patched.
However, only /proc/cmdline is checked during this sequence.

Should there be an additional step to grep /proc/meminfo and verify it
is functionally unpatched before disabling the livepatch? If the atomic
replace logic had a flaw that accidentally left /proc/meminfo patched,
it appears this verification would be missed and the test would still pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909024324.1600=
2-1-laoar.shao@gmail.com?part=3D9
