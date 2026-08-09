Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF9355048
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268988; cv=none; b=hxyj7nbbaMeLThONFMpYHVrpH15aDQ1XxWSvCgXkgA/DECi9wv8qi8SIOuwU9Lwig0cjjyCjM1NdJs8xEiWT3EBn7cxAYe2id3xEArqehnt29NIxK2GE1r0RatZ91dhB86jQuXeJv9HBnYI/8Mds5Shffb5jMMDETeP5ednkPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268988; c=relaxed/simple;
	bh=eUZWWb0QMuDCLye8qDhxZoyQTPIFJZk5oIWEgc6YakE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YdN7K6H3R6mwdbXxjlh9dQf+rUWU0Gp8P4MDlxG9qyKbP0vBADQy3lZvQQsQaFkET4zcZ/uevs/UBjtdD8Y88nylupFA3cNEQIYVZ/yk9t8bkduc+XTH1vTZ090ol8JsWBCNwTILsm8JRnhAc/ADhjKLA9QwBxeJyZMICvd6E68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcEMnPKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcEMnPKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4501F000E9;
	Sun,  9 Aug 2026 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786268985;
	bh=WSJG/IVmOo6fRTksKKtfRVy516G/g5ir/mVVdAj5aHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AcEMnPKuMxrUIREeW3nAccxPvK+PLHEm/PDDgnBT7oc4vLCOpDJFr4spRPRpAjdde
	 1+HjP107laz++Cx/ZT4yzW0H2GD6U/mSQOoqNJPAGUK2gX9/yOhsXanYTHPtTLjNjH
	 N/lIJ3dijwO/wvBvfnjB3Hg1hbMozdxfel63K2Td5/sgMogITKOFCkEmMRiWG2MLja
	 8fIXnDuxChM2blZchgKtpLYxr9zvQzvf9smD3GxMmYQr9TWFHQ0B8dODv3PuKJIklS
	 ae7Z44XJver0gt63MLbL1qVrPkBixYJUmNJtMuJxARDnMRMwC++3mgGlW5BWGi1zBJ
	 BTjuyzUGnivCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] selftests: livepatch: Add test for function
 conflict across provides
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com, pmladek@suse.com, song@kernel.org, jikos@kernel.org
Cc: "Yafang Shao" <laoar.shao@gmail.com>, live-patching@vger.kernel.org
In-Reply-To: <20260809091954.22930-10-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
 <20260809091954.22930-10-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:49:44 +0000
Message-Id: <20260809094945.4B4501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Malformed livepatch module missing `old_name` causes a kernel pani=
c on load.

Pre-existing issues:
- [Medium] Race condition in sysfs polling causes flaky selftests.
--

--- Patch [9]: [PATCH v5 9/9] selftests: livepatch: Add test for function c=
onflict across provides ---
commit eaca609db12a6842c4e94debcf9d9ef5049826db
Author: Yafang Shao <laoar.shao@gmail.com>

selftests: livepatch: Add test for function conflict across provides
   =20
This commit adds a new test module test_klp_provides.c and three new test
scenarios to test-provides-obsoletes.sh. These tests verify the behavior
of livepatch function conflicts and replacement when using different
provides IDs with and without obsoletes.

> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh=
 b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> index 1b2c73bdd50b0..32885625401d1 100755
> --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
[ ... ]
> @@ -278,4 +279,123 @@ $MOD_STATE2: free_loglevel_state: freeing space for=
 the stored console_loglevel
>  livepatch: '$MOD_STATE2': unpatching complete
>  % rmmod $MOD_STATE2"
> =20
> +
> +# - load a livepatch with provides=3D1 that modifies meminfo_proc_show
> +# - try to load another livepatch with provides=3D2 that modifies the
> +#   same function. The second one must be rejected because livepatches
> +#   with different provides ids and no obsoletes must not modify
> +#   the same function.
> +# - disable and unload the remaining livepatch
> +
> +start_test "function conflict across provides"
> +
> +load_lp $MOD_ATOMIC provides=3D1
> +load_failing_mod $MOD_PROVIDES provides=3D2
> +
> +disable_lp $MOD_ATOMIC
> +unload_lp $MOD_ATOMIC
> +
> +check_result "% insmod test_modules/$MOD_ATOMIC.ko provides=3D1
> +livepatch: enabling patch '$MOD_ATOMIC'
> +livepatch: '$MOD_ATOMIC': initializing patching transition
> +livepatch: '$MOD_ATOMIC': starting patching transition
> +livepatch: '$MOD_ATOMIC': completing patching transition
> +livepatch: '$MOD_ATOMIC': patching complete
> +% insmod test_modules/$MOD_PROVIDES.ko provides=3D2
> +livepatch: Livepatch patch ($MOD_PROVIDES) is not compatible with the al=
ready installed livepatches.
> +insmod: ERROR: could not insert module test_modules/$MOD_PROVIDES.ko: In=
valid parameters
> +% echo 0 > $SYSFS_KLP_DIR/$MOD_ATOMIC/enabled
> +livepatch: '$MOD_ATOMIC': initializing unpatching transition
> +livepatch: '$MOD_ATOMIC': starting unpatching transition
> +livepatch: '$MOD_ATOMIC': completing unpatching transition
> +livepatch: '$MOD_ATOMIC': unpatching complete
> +% rmmod $MOD_ATOMIC"
> +
> +
> +# - load a livepatch with provides=3D1 that modifies meminfo_proc_show
> +# - load another livepatch with provides=3D1 that modifies the same
> +#   function. The second one loads successfully because livepatches
> +#   with the same provides id replace each other.
> +# - disable and unload the remaining livepatch
> +
> +start_test "function replace within same provides"
> +
> +load_lp $MOD_ATOMIC provides=3D1
> +load_lp $MOD_PROVIDES provides=3D1
> +
> +mods=3D($SYSFS_KLP_DIR/*)
> +nmods=3D${#mods[@]}
> +if [[ "$nmods" -ne 1 ]]; then

[Severity: Medium]
This is a pre-existing issue, but does this pattern cause a regression in t=
he
form of flaky selftests?

The script synchronously counts the directories in the sysfs path immediate=
ly
after a transition. However, the old patch's sysfs directory removal is
deferred to an asynchronous workqueue:

kernel/livepatch/core.c:klp_free_replaced_patches_async()

Because of this, the script may momentarily see 2 directories instead of 1
before the asynchronous cleanup completes.

> +	die "Expecting one module listed, found $nmods"
> +fi

[ ... ]

> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_prov=
ides.c b/tools/testing/selftests/livepatch/test_modules/test_klp_provides.c
> new file mode 100644
> index 0000000000000..9751a6f6c8518
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_provides.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
[ ... ]
> +static int test_klp_provides_init(void)
> +{
> +#ifdef KLP_HAS_REPLACE
> +	patch.replace =3D replace;
> +#else
> +	patch.provides =3D provides;
> +	if (nr_obsoletes > 0) {
> +		patch.obsoletes =3D obsoletes;
> +		patch.nr_obsoletes =3D nr_obsoletes;
> +	}
> +#endif
> +	return klp_enable_patch(&patch);

[Severity: High]
Does klp_enable_patch() introduce a regression where a malformed livepatch
module missing old_name causes a kernel panic on load?

If a livepatch module defines a klp_func with .old_name =3D NULL but provid=
es
.new_func, it bypasses the klp_for_each_func_static loop termination
condition.

Since klp_is_patch_compatible() executes before klp_init_patch():

kernel/livepatch/core.c:klp_enable_patch() {
    ...
    if (!klp_is_patch_compatible(patch)) {
    ...
    ret =3D klp_init_patch(patch);
    ...
}

klp_has_function_conflict() iterates over this malformed function, which th=
en
passes the malformed func to klp_find_func():

kernel/livepatch/state.c:klp_has_function_conflict() {
    ...
    if (klp_find_func(old_obj, func))
    ...
}

This then passes func->old_name to strcmp():

kernel/livepatch/core.c:klp_find_func() {
    ...
    if ((strcmp(obj_func->old_name, func->old_name) =3D=3D 0) &&
    ...
}

resulting in an immediate null pointer dereference.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809091954.2293=
0-1-laoar.shao@gmail.com?part=3D9
