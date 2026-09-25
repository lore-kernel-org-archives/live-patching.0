Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FAA3F8231
	for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326497; cv=none; b=T5SakeKTj8oZ8TBSD+3ALwMU78MpvM58ofdpJbCTe9hFFEAOlvQjPAHztx3HaECjxtUcz43g82MDZ/DVc48T3gCvX9dKET4+mFJG1JkyC4aL/Me5oaiDJRTWCGzvhJU09CP4m7zouGl/0e+elrd5yieLrn4J/H/HMOPPi73RmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326497; c=relaxed/simple;
	bh=Tujb+hrEZjfqIFexwFimY55X/+OoV/zuFUcmKHm8RoE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=I+D7xw5n0fNGoowIdzkLGrk/dkAKTJzPZSGpHGKg+8hdxvEOQREuKA4Zx4KAn64oONyW5QsfNFadnIuWE7PjiWJo6GdtTNq2iH4WCwAgFVD6D7/CHxi+CbcF8a79DkBLNCuX7kQD5UMYUvL8PCueSUPxJCV8hvlHeA03DZ1GSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iCIsotKY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3x3Na/2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VXkRxVYX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h2HVJTyo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iCIsotKY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3x3Na/2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VXkRxVYX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h2HVJTyo"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id DDEDD21A57;
	Fri, 25 Sep 2026 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790326487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsdwLugTPlbOOOJiYjOKcTY6e9JdqtXWxq8x/sXf2cA=;
	b=iCIsotKY73FuT1UEbh20J8rDM1Mp75p0wYg4Ub7ATvsc5/tOk562NM9e5Z6uUjhbMqA1do
	MjhhO1bCtbpWiy+WwU7vmwotab/+SkENet8R+jF4MrfHvuwdiPiH83Mg8rE1KEmt2D6yJA
	h3d5fwXaYXMGtRk0SDL0NpnOwzJ2b0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790326487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsdwLugTPlbOOOJiYjOKcTY6e9JdqtXWxq8x/sXf2cA=;
	b=W3x3Na/2EGVLCv4t5hR2h7jJNnuljHDgyoJGwibrL0Uc/mcwc1ks5l+fSQcOgxT3dkQ3TC
	3NHSuMRPYb+lcBCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VXkRxVYX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h2HVJTyo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790326482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsdwLugTPlbOOOJiYjOKcTY6e9JdqtXWxq8x/sXf2cA=;
	b=VXkRxVYXS9eqx5VNjppv1/i3QKrzYQVoFVUvLk6sBDqmIfGfKM68sxKjCxVYsefEkieswv
	55P3LkdXXXpTQDQ/L0fje1N0IIo57TjPp3Jpe+7JkdhkhlG2xLSvAbSHXWQSr1eV273eRN
	kcuOjCPE4k87M65tUODfL84smvQ2MmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790326482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsdwLugTPlbOOOJiYjOKcTY6e9JdqtXWxq8x/sXf2cA=;
	b=h2HVJTyo7jBhnLsof/Lzsf3nAptVYrNUmKlLUltiA3b03ktGjLVSSNkd7eEr5dvF8nOM5e
	z+K30NtXkk3hA0CA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 2/9] selftests/livepatch: Adapt atomic replace tests
 to provides/obsoletes
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260913024228.72317-3-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
 <20260913024228.72317-3-laoar.shao@gmail.com>
Date: Fri, 25 Sep 2026 10:54:32 +0200
Message-Id: <179032647206.68715.855492643431181079.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9626; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=Tujb+hrEZjfqIFexwFimY55X/+OoV/zuFUcmKHm8RoE=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqxtZif7WTQW8Xg/Fv9slR0XN+PkMS6hp+8do9gMJ5/Zb
 yWoEfKuk9GfhYGRg8FSTJHl9V5nOcMpuQaa1e/uwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjhEDF6cATPVJDw6Gldc+VSUtuZ16Ydvb9Tv6vT5Y293oaclNsdIr9z56Wne6zVtuQZUa18W
 +bMwSmn8Uz7Zo++/weKIc/POwz5ar15meHVx/humQ5jTfY7v/tk0yP3TwasCf+zMfZG5JzT1cb3
 anwFH20mTbk35sj+SPtrQZly9itr1w87SE0tlJdWJ88w2efl2+fsL8qE/8+QuXZyrVr4z6Fc758
 It4WskHi7ez9jPP3rL4/M8HYS8WBv05Htp4UMh8H6t3/KGlh+4f/Sy+3UtXfwVXU/yChWnm39L2
 2yktjQk/FS/1R6DFhcd9Y82fVbnXS6/sqvVebnimKaK8I7bst9ft4l3R7ye0BDI6s8YvKuFY3DV
 BlUuOGwA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: DDEDD21A57
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 17.40
X-Spam-Level: *****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.40 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	NEURAL_SPAM_SHORT(1.51)[0.503];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Spam: Yes

> The legacy "replace" field in struct klp_patch will be replaced by the
> provides/obsoletes mechanism. As a result, the atomic replace
> selftests fail to build against kernels that only support
> provides/obsoletes.
> 
> Adapt the selftests so that they build and run on both old and new
> kernels.  On kernels without the legacy "replace" support, the
> replace-related test cases are skipped with a SKIP message instead
> of being run.
> 
> The provides/obsoletes based selftests will be added later after the
> provides/obsoletes are substituted.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  .../testing/selftests/livepatch/functions.sh  |  30 ++++++
>  .../selftests/livepatch/test-callbacks.sh     |  43 +++++---
>  .../selftests/livepatch/test-livepatch.sh     | 102 ++++++++++--------
>  .../test_modules/test_klp_callbacks_demo2.c   |  16 +++
>  .../test_modules/test_klp_meminfo_lp.c        |  16 +++
>  .../livepatch/test_modules/test_klp_state.c   |   7 ++
>  .../livepatch/test_modules/test_klp_state2.c  |   7 ++
>  7 files changed, 162 insertions(+), 59 deletions(-)
>
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index a65b7b1ac8ad..1d5d8ee890a6 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -328,6 +328,15 @@ function start_test {
>  	log "===== TEST: $test ====="
>  }
>  
> +function skip_test {
> +	local test="$1"
> +	local reason="$2"
> +
> +	echo -n "TEST: $test ... "
> +	echo "SKIP ($reason)"
> +	log "===== TEST: $test SKIPPED: $reason ====="
> +}

We also have skip() in functions.sh which exits a test script
immediately (and is used for detecting necessary prerequisites for
testing). skip_test() is used in conditionals and just prints useful
output. I think that we need a better naming which would distinguish
between the two. I would not mind renaming skip() to skip_exit() and
using skip() for the above but I am not good in naming.

>  # check_result() - verify dmesg output
>  #	TODO - better filter, out of order msgs, etc?
>  function check_result {
> @@ -365,6 +374,27 @@ function does_sysfs_exist() {
>  	[[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
>  }
>  
> +# detect_provides_attr() - detect whether the running kernel supports the
> +# livepatch "provides" attribute and set HAS_PROVIDES_ATTR accordingly.
> +# The provides/obsoletes based tests are only run when HAS_PROVIDES_ATTR
> +# is set.
> +function detect_provides_attr() {
> +	HAS_PROVIDES_ATTR=0
> +
> +	if [[ -r /proc/config.gz ]] &&
> +	   zgrep -q "CONFIG_KLP_HAS_PROVIDES=y" /proc/config.gz 2>/dev/null; then
> +		HAS_PROVIDES_ATTR=1
> +		return 0
> +	fi
> +
> +	load_lp test_klp_cmdline_lp
> +	if does_sysfs_exist test_klp_cmdline_lp "provides"; then
> +		HAS_PROVIDES_ATTR=1
> +	fi
> +	disable_lp test_klp_cmdline_lp
> +	unload_lp test_klp_cmdline_lp
> +}

Why is there does_sysfs_exist() fallback? I mean, we use that currently
for exactly this purpose. My understanding is that
CONFIG_KLP_HAS_PROVIDES is also used elsewhere in the code so using it
here makes some sense, but do we need both?

Also, would it be a good idea to move CONFIG_KLP_HAS_PROVIDES definition
to this patch with "def_bool n" and just change it later when it is
actually implemented? It might make the whole thing more consistent.

>  # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs
>  # path permissions
>  #	modname - livepatch module creating the sysfs interface
> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> index 2a03deb26a12..346248f3488b 100755
> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> @@ -10,6 +10,7 @@ MOD_TARGET=test_klp_callbacks_mod
>  MOD_TARGET_BUSY=test_klp_callbacks_busy
>  
>  setup_config
> +detect_provides_attr
>  
>  
>  # Test a combination of loading a kernel module and a livepatch that
> @@ -458,16 +459,17 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
>  #   execute as each patch progresses through its (un)patching
>  #   transition.
>  
> -start_test "multiple livepatches"
> +function test_multiple_livepatches() {
> +	start_test "multiple livepatches"
>  
> -load_lp $MOD_LIVEPATCH
> -load_lp $MOD_LIVEPATCH2
> -disable_lp $MOD_LIVEPATCH2
> -disable_lp $MOD_LIVEPATCH
> -unload_lp $MOD_LIVEPATCH2
> -unload_lp $MOD_LIVEPATCH
> +	load_lp $MOD_LIVEPATCH
> +	load_lp $MOD_LIVEPATCH2
> +	disable_lp $MOD_LIVEPATCH2
> +	disable_lp $MOD_LIVEPATCH
> +	unload_lp $MOD_LIVEPATCH2
> +	unload_lp $MOD_LIVEPATCH
>  
> -check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> +	check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -499,6 +501,7 @@ $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH': unpatching complete
>  % rmmod $MOD_LIVEPATCH2
>  % rmmod $MOD_LIVEPATCH"
> +}
>  
>  
>  # Load multiple livepatches, but the second as an 'atomic-replace'
> @@ -515,15 +518,16 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>  # - Once the atomic replace module is loaded, only its pre and post
>  #   unpatch callbacks are executed.
>  
> -start_test "atomic replace"
> +function test_atomic_replace() {
> +	start_test "atomic replace"
>  
> -load_lp $MOD_LIVEPATCH
> -load_lp $MOD_LIVEPATCH2 replace=1
> -disable_lp $MOD_LIVEPATCH2
> -unload_lp $MOD_LIVEPATCH2
> -unload_lp $MOD_LIVEPATCH
> +	load_lp $MOD_LIVEPATCH
> +	load_lp $MOD_LIVEPATCH2 replace=1
> +	disable_lp $MOD_LIVEPATCH2
> +	unload_lp $MOD_LIVEPATCH2
> +	unload_lp $MOD_LIVEPATCH
>  
> -check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> +	check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -548,6 +552,15 @@ $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH2': unpatching complete
>  % rmmod $MOD_LIVEPATCH2
>  % rmmod $MOD_LIVEPATCH"
> +}
>  
>  
> +if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
> +	test_multiple_livepatches
> +	test_atomic_replace
> +else
> +	skip_test "multiple livepatches" "legacy replace attribute not present"
> +	skip_test "atomic replace" "legacy replace attribute not present"
> +fi

Wrapping into functions is not used later anywhere if I am not missing
something. Nothing really important but my preference would be to just
wrap the existing test code with HAS_PROVIDES_ATTR if where appropriate
and be done with it.

if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
	start_test "multiple livepatches"
	load_lp $MOD_LIVEPATCH
	load_lp $MOD_LIVEPATCH2
	...
else
	skip_test "multiple livepatches" "legacy replace attribute not present"
fi

and similarly for "atomic replace" test.

What do you think?

[...]

> +if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
> +	test_multiple_livepatches
> +	test_atomic_replace_livepatch
> +else
> +	skip_test "multiple livepatches" "legacy replace attribute not present"
> +	skip_test "atomic replace livepatch" "legacy replace attribute not present"
> +fi

Same here. 
  
>  # - load a target module that provides /proc/test_klp_mod_target with
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> index 5417573e80af..de4eabd4b924 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> @@ -7,9 +7,16 @@
>  #include <linux/kernel.h>
>  #include <linux/livepatch.h>
>  
> +#ifndef CONFIG_KLP_HAS_PROVIDES
>  static int replace;
>  module_param(replace, int, 0644);
>  MODULE_PARM_DESC(replace, "replace (default=0)");
> +#else
> +/*
> + * TODO: Add provides/obsoletes module parameters for the
> + * provides/obsoletes based tests (to be added later).
> + */
> +#endif
>  
>  static const char *const module_state[] = {
>  	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
> @@ -72,12 +79,21 @@ static struct klp_object objs[] = {
>  static struct klp_patch patch = {
>  	.mod = THIS_MODULE,
>  	.objs = objs,
> +#ifndef CONFIG_KLP_HAS_PROVIDES
>  	/* set .replace in the init function below for demo purposes */
> +#endif
>  };
>  
>  static int test_klp_callbacks_demo2_init(void)
>  {
> +#ifndef CONFIG_KLP_HAS_PROVIDES
>  	patch.replace = replace;
> +#else
> +	/*
> +	 * TODO: Set provides/obsoletes from the module parameters
> +	 * for the provides/obsoletes based tests (to be added later).
> +	 */
> +#endif
>  	return klp_enable_patch(&patch);
>  }

A nit, but since you change #ifndef to #ifdef later, my preference would
be to use #ifdef here right away.

#ifdef CONFIG_KLP_HAS_PROVIDES
	/*
	 * TODO: Set provides/obsoletes from the module parameters
	 * for the provides/obsoletes based tests (to be added later).
	 */
#else
	patch.replace = replace;
#endif

After all you prepare the code for a new feature. What do you think?

Similarly elsewhere.

-- 
Miroslav

