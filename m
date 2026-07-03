Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680653655EA;
	Fri,  3 Jul 2026 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059291; cv=none; b=btgXT3CY8AVuJkSbFKrPnhQym8/gta1VjV5K6iY641lL4X3o0JHY42adTHhTUZqpGDDvYyQkywXJRT11te9/rsjpn2UZrQgjYmNmL2WzPIfZ5CyW22+YhcQugWqSESM1NVlvehybmND1fKJW41A180/VFVm+F0ycdVelw/mmZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059291; c=relaxed/simple;
	bh=PvwMaUW4Bhmw1g5dfJKPfAVS5JInTqp7iiYy8ZWASMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/x+7KQVLL4FdRbSoBCxO781IjpbXLEZ5dIcr4bLiBevH/Iz/k6hFvyDwLtV+iTJRPcVgbhvB1LrVmoD2gvwjddhu6aVUfIcwVRrCsQQk5UZY4ZJqAQFDHoNFjMBBJLCkIz/QYuIThX7nqKsD9dTMM+0LU1hbtvwmOlP3Mu3ScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTvzFun1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTvzFun1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246801F000E9;
	Fri,  3 Jul 2026 06:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059289;
	bh=KAOJyjNnpeYBSx4Tg1/BVABssxBZm7QmG3pOSwCDZkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MTvzFun1K591GJM4wnYNvOmQskcRyrpAbTcoanXq9zmzv9q9jBIR3KRJrS0zDcrGI
	 gWYKP7glOQZC4WJE0ZtIeU32neYDA5fXnlHLAsL1hVv1N0EUmbwnXHonoEXxKEq3kK
	 TlUtwpU5cc4KbvJtST0DYBJ/98HefsQsrg0jCSDNP7KEnnz71Mzt8Ww3uPc1fQca/z
	 IalkYCmGUF4FRA6l7nCmFJjbcWMzSHx9ZuTmLhEUhuavRrDkUVcunMXTivj2DM8lmJ
	 8VSn6ycIzu8X22Yy7cA//lglxYrdnhO3JmZYKYMnGmJ2DpSARN+SzpR6O5s11KuqrW
	 tweNLmdwd5JqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kbuild: unset sub_make_done before calling kselftest
 build system
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "Miroslav
 Benes" <mbenes@suse.cz>, =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>, shuah@kernel.org, "Zelin
 Deng" <zelin.deng@linux.alibaba.com>, linux-kbuild@vger.kernel.org, "Petr
 Mladek" <pmladek@suse.com>
In-Reply-To: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
References: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 06:14:48 +0000
Message-Id: <20260703061449.246801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete fix and inconsistent state: The patch correctly unset=
s `sub_make_done` for the `kselftest` targets to allow Kbuild command-line =
reevaluation when building external kernel modules. However, it fails to ap=
ply the same logic to the `tools/` and `tools/%` targets, introducing a dis=
crepancy between build entry points.
--

commit 06c418388d65deb3d8494a6e8e7071c0e709186b
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

kbuild: unset sub_make_done before calling kselftest build system

This commit unsets sub_make_done before invoking the kselftest build system=
 to
ensure Kbuild reevaluates command-line flags when building test modules. It
mirrors a previous fix done for scripts/install.sh.

> diff --git a/Makefile b/Makefile
> index b9c5792c79e01..f717a4dc96d6a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1591,10 +1591,10 @@ tools/%: FORCE
> =20
>  PHONY +=3D kselftest
>  kselftest: headers
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> +	$(Q)unset sub_make_done; $(MAKE) -C $(srctree)/tools/testing/selftests =
run_tests

[Severity: Medium]
Will make tools/selftests still fail after this change?

The tools/ and tools/% targets in Makefile delegate to the tools build
system, which can also trigger external kernel module builds (like bpf_test=
mod).

Because sub_make_done is not unset for these targets, invoking commands like
make tools/selftests or make tools/all will skip Kbuild's M=3D argument par=
sing.

Should sub_make_done also be unset in the tools/ and tools/% targets to mai=
ntain
consistency across the build entry points?

>  kselftest-%: headers FORCE
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> +	$(Q)unset sub_make_done; $(MAKE) -C $(srctree)/tools/testing/selftests =
$*
> =20
>  PHONY +=3D kselftest-merge
>  kselftest-merge:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-makefile-u=
nset-submake-done-v1-1-6899248f3d6a@linutronix.de?part=3D1
