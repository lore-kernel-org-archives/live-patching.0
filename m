Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF3492E53
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922678; cv=none; b=MCskGNCiuMAOQYXmJgiRikxDb4K7DEID9OIHYk8XcsmQ4gGSDFYFTraVQo4A16kaqgKbbfiN/NspXKBVX2wjMf0nMDnFouMOhQO8TM+d0AI3buMX0ZCXGltzHtcqW4AeyVwJnlQv7p0l9Bg2KdutZ7NBaRdbzOZOqrnMDjWhk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922678; c=relaxed/simple;
	bh=G5hLWHhf8LvsnHndXhBedINbBuB38jwU3BHbBXEnmnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y747Sx7CbeFA4oOlY+LdB0uAorimY/Tf778uuXFG8+MxCYF0LkW7iyLHqppDshzhbRZcOIc/a+qTXNopaa3LUaj9ML/xz1FY5Fv+40lIlf73zsdjiaJVKAUTfNVfZ7GMsMIfAKQensn97MkHywk1Y+F9vSi1Nia27KK+K+9ktZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8Bh8N94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8Bh8N94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AEF1F00A3A;
	Wed,  9 Sep 2026 02:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788922676;
	bh=+xo1IsczY7BZzp0rzFhToLZz2jVzzIRmrRGr34FDlsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8Bh8N94FHo0T2IYijDPg5uPTKxn2xtaQtWiLeCTu4puIAAfTIYNC4nhXlfhaRUVk
	 Wbvvxp0bFCFMTHrEUNrDW+idL43hlr8XGxAkGCMGLzbjIRnxLDGsRMYiMaSm3PVI4J
	 DsMDXWIMbUA/5ybtdGKQhkBihAf1A5b2VaZ7kWqPgi27pU1KqqJkiu4dTYLWhgyR5N
	 ySZQoD3ZWo/aezlRiOGDsopoI9VDT/7DnfNaqSFyTZoDwKpm2HLDIF2NLrKtn82+An
	 O71feDoLPcvekBN03Vm3yOU+IID1WUq7FbZtWJf9LvfusjTj/wW0m6/Zuz6fIm4m7C
	 krP0kw9v3bukw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/9] selftests/livepatch: Add state test for
 provides/obsoletes
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, song@kernel.org, pmladek@suse.com, mbenes@suse.cz, "Yafang
 Shao" <laoar.shao@gmail.com>, jikos@kernel.org, joe.lawrence@redhat.com
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260909024324.16002-9-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
 <20260909024324.16002-9-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 02:57:55 +0000
Message-Id: <20260909025756.19AEF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Unloading independent livepatches in FIFO order permanently alte=
rs the global `console_loglevel`.
- [Medium] Mutable module parameter 'state' causes a memory leak and failur=
e to restore kernel state if modified via sysfs after load.
- [Low] Missing sysfs value verification in test 'misc states, misc provide=
s'.
--

commit 253fd167cb01a1b8aeead3420135a4b275836ef3
Author: Yafang Shao <laoar.shao@gmail.com>
Subject: selftests/livepatch: Add state test for provides/obsoletes

This commit adds `provides` and `obsoletes` module parameters to
`test_klp_state` and `test_klp_state2` selftests. It introduces testing=20
coverage to ensure that reusing a state ID across different provides IDs=20
is rejected, while it is allowed when the new livepatch obsoletes the old=20
one.

> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh=
 b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> index c2fbac3d0e06f..8b7b5eded80c7 100755
> --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
[ ... ]
> @@ -213,4 +215,238 @@ livepatch: '$MOD_CMDLINE': unpatching complete
[ ... ]
> +# - load two livepatches with different provides ids (provides=3D1 and
> +#   provides=3D2) that modify different system states (state=3D1 and
> +#   state=3D2). Neither of them replaces the other, because their
> +#   provides ids differ (and the obsoletes lists are empty), so they
> +#   can coexist.
> +# - verify the provides sysfs value of both livepatches
> +# - disable and unload both livepatches
> +
> +start_test "misc states, misc provides"
> +
> +load_lp $MOD_STATE state=3D1 provides=3D1
> +load_lp $MOD_STATE2 state=3D2 provides=3D2
> +

[Severity: Low]
The test documentation states it will "verify the provides sysfs value of b=
oth
livepatches". Is this verification missing here before we disable and unload
them?

> +disable_lp $MOD_STATE
> +unload_lp $MOD_STATE
> +disable_lp $MOD_STATE2
> +unload_lp $MOD_STATE2

[Severity: Medium]
Does unloading these livepatches in FIFO order permanently alter the global
console_loglevel?

If MOD_STATE saves the original loglevel and sets it to 15, and then
MOD_STATE2 saves 15 and sets it to 15, wouldn't unloading MOD_STATE first
restore the original loglevel, only for unloading MOD_STATE2 to subsequently
overwrite it with 15? Should the teardown be LIFO to properly unwind the
loglevel changes?

> +
> +check_result "% insmod test_modules/$MOD_STATE.ko state=3D1 provides=3D1
[ ... ]
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_stat=
e.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> index 5c5872ff25665..1de63c2438d68 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> @@ -9,10 +9,25 @@
>  #include <linux/printk.h>
>  #include <linux/livepatch.h>
> =20
> -#define CONSOLE_LOGLEVEL_STATE 1
>  /* Version 1 does not support migration. */
>  #define CONSOLE_LOGLEVEL_STATE_VERSION 1
> =20
> +static unsigned int state =3D 1;
> +module_param(state, uint, 0644);

[Severity: Medium]
Could this mutable module parameter cause a memory leak and failure to rest=
ore
the kernel state if modified via sysfs after load?

Since the permissions are set to 0644, if root modifies the state parameter
while the livepatch is loaded, subsequent callbacks like free_loglevel_stat=
e()
using klp_get_state(&patch, state) will return NULL. Does this silently skip
cleanup (kfree) and state restoration during patch unload?

This same issue also applies to test_klp_state2.c.

> +MODULE_PARM_DESC(state, "console loglevel state (default=3D1)");
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909024324.1600=
2-1-laoar.shao@gmail.com?part=3D8
