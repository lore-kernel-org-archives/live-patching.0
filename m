Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680402;
	b=u/BHRatXlZJWKFShPZYiS/n+hvMnnQUzNo1d0qWHg4LbWwpUzD/5F6Veqx9yyV7/Kq02
	 Nw+ZiXnU5BLE8yNhtm9Q+V/mFC/ZFdtedhDIqp6JmNxYmIEOMWqt09gDaolGDHf+N66y8
	 lyMnJbL5LLiOkurB1Si87fsJqaxD1gdEIV6t+Ghf2iccC9V05F85KtNf3uBntF+ANYdtx
	 wHIp0N7nsITB5OQ+lSvarPWzPm+FVRgIrlormtr4GR2fOKy/AnCUSPWC/WbcQDAI3lXac
	 /Mr3oofBWr1ir4cuou4jnTkOhpGPubYTYHKGB8iJsn3HERUbW51h3uqxy0pck3R+1Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680402;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=7ADqUF/G0BzfJ4u3IvNkMgP7t5IbdAIydEjER9S8fK4=;
	b=Ee8B9amPaDxtbz6PA6WDTZCgbLbRhX9clywZfg5sKQWvRq8lrWskoEVQ946x3P4aSNjv
	 pQVN7axXKQ+Etrrw8x0uHbUFQGRfo5zDheKTgvipIeZkc/n0qoj1Yg9rWf/z9BlrsIKB7
	 0ZgUjvP8oDxAtjqZUs4AkzRtBw364iHr9qllBM8VjtPfKYSQNxLRQMisvkUZiev3OpFtu
	 fG3SlvI7PS8wDHvk7PNbvdcrMw7IvdZOR8Z//iCfvmcMCp7ejvVY68M+6fyrYZB8brtyX
	 LfnTogFX0fDy2UfpMACOZf4Ftan/Xx55g95YlWMweksVPAkDPobE8yb5+jBaNItBdRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eag2GFP7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162E606A325
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 14:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B162E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eag2GFP7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792680400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ADqUF/G0BzfJ4u3IvNkMgP7t5IbdAIydEjER9S8fK4=;
	b=Eag2GFP7eiVdoJNhmMFjhRXhXDwZBngL2siPVtA3O6yXKt4YSyxudPb1W0NWGOaSKBVySR
	VhJo6aeaM22p5OcOiMiL64lvUUCKvHTN9I6L4CjKgelXkp1OR/x6m7DqMNe+jeoFJ3EC23
	DHu8BQWsuKMRXJNTnedGSh0J1Ig2ZBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-Jz1zXo3NPByvfm0uwtPsJw-1; Thu,
 22 Oct 2026 10:46:36 -0400
X-MC-Unique: Jz1zXo3NPByvfm0uwtPsJw-1
X-Mimecast-MFC-AGG-ID: Jz1zXo3NPByvfm0uwtPsJw_1792680395
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 746B21954B0F;
	Thu, 22 Oct 2026 14:46:34 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 016E418001CA;
	Thu, 22 Oct 2026 14:46:32 +0000 (UTC)
Date: Thu, 22 Oct 2026 10:46:30 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/3] objtool/klp: Build test fixtures with ftrace
Message-ID: <atohxvOb9MAxkhsg@redhat.com>
References: <20261022122544.125305-1-puranjay@kernel.org>
 <20261022122544.125305-2-puranjay@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022122544.125305-2-puranjay@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 22, 2026 at 05:25:36AM -0700, Puranjay Mohan wrote:
> Livepatch depends on ftrace, so the kernel klp-build operates on always
> has __mcount_loc, but the test fixtures are built without it.
> 
> On x86, build them with -pg -mfentry and generate __mcount_loc like the
> kernel does: with -mrecord-mcount -mnop-mcount if the compiler supports
> it (FTRACE_MCOUNT_USE_CC), otherwise with objtool --mcount --mnop
> (FTRACE_MCOUNT_USE_OBJTOOL).
> 
> test-checksum-alt ran objtool --mcount only to get insn->alts, which
> "klp checksum" builds by itself, and that now warns about the existing
> __mcount_loc.  Remove it.
> 
> test-special-sections can now check the real __mcount_loc instead of a
> hand-written one.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  .../objtool/Documentation/klp-write-tests.txt |  9 ++--
>  .../tests/generic/test-thinlto-ambiguity.sh   |  3 +-
>  .../tests/generic/test-thinlto-local.sh       |  5 ++-
>  tools/objtool/tests/lib.sh                    | 42 +++++++++++++++++--
>  tools/objtool/tests/x86/test-checksum-alt.sh  |  4 --
>  .../tests/x86/test-special-sections.sh        | 23 ++++++----
>  6 files changed, 64 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/objtool/Documentation/klp-write-tests.txt b/tools/objtool/Documentation/klp-write-tests.txt
> index eb2cacaf57207..7cc2148083cc2 100644
> --- a/tools/objtool/Documentation/klp-write-tests.txt
> +++ b/tools/objtool/Documentation/klp-write-tests.txt
> @@ -116,9 +116,12 @@ Traps that have bitten before
>    section entsize or annotations".  Their targets need real (global) symbols,
>    or it reports "failed to convert reloc sym".
>  * **Prefer letting objtool generate what objtool generates.**
> -  ``.static_call_sites``, ``.mcount_loc``, ``.ibt_endbr_seal`` and ORC come
> -  from its check pass.  Call ``run_objtool_check --mcount`` and let it build
> -  them; a hand-written copy tests your reading of the format, not the format.
> +  ``.static_call_sites``, ``.ibt_endbr_seal`` and ORC come from its check
> +  pass.  Call ``run_objtool_check`` with the option for what you need and let
> +  it build them; a hand-written copy tests your reading of the format, not the
> +  format.
> +* **Fixtures are built with ftrace.**  Objects not built with ``build_one``
> +  need ``$FTRACE_CFLAGS`` and ``record_mcount`` too.
>  
>    Write one by hand only when the test needs a shape objtool will not produce,
>    and say so in the fixture.  generic/fixtures/static_call.c does: objtool
> diff --git a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
> index 34f4f3a58e201..73740c804d54f 100755
> --- a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
> +++ b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
> @@ -38,12 +38,13 @@ build_thinlto()		# $1 output object, $2 extra flags
>  {
>  	local t
>  	for t in "" -DTU_B -DTU_C; do
> -		$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections \
> +		$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $FTRACE_CFLAGS \
>  			$2 $t -c "$FIXTURES_DIR/thinlto_ambiguity.c" \
>  			-o "$workdir/tu$t.o" 2>/dev/null || return 1
>  	done
>  	"$THIN_LD" -r "$workdir/tu.o" "$workdir/tu-DTU_B.o" "$workdir/tu-DTU_C.o" \
>  		-o "$1" 2>/dev/null || return 1
> +	record_mcount "$1"
>  }
>  
>  build_thinlto "$workdir/orig.o" "" ||
> diff --git a/tools/objtool/tests/generic/test-thinlto-local.sh b/tools/objtool/tests/generic/test-thinlto-local.sh
> index a266263676ed5..090c6df75ad64 100755
> --- a/tools/objtool/tests/generic/test-thinlto-local.sh
> +++ b/tools/objtool/tests/generic/test-thinlto-local.sh
> @@ -15,11 +15,12 @@ find_thinlto_toolchain ||
>  
>  build_thinlto()		# $1 output object, $2 extra flags
>  {
> -	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 \
> +	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $FTRACE_CFLAGS $2 \
>  		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_a.o" 2>/dev/null || return 1
> -	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 -DTU_B \
> +	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $FTRACE_CFLAGS $2 -DTU_B \
>  		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_b.o" 2>/dev/null || return 1
>  	"$THIN_LD" -r "$workdir/tu_a.o" "$workdir/tu_b.o" -o "$1" 2>/dev/null || return 1
> +	record_mcount "$1"
>  }
>  
>  build_thinlto "$workdir/orig.o" "" ||
> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 4da168d0ddca3..d07eb07d15611 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
> @@ -41,7 +41,7 @@ OBJTOOL="${OBJTOOL:-$TESTS_DIR/../objtool}"
>  #
>  klp_preflight()
>  {
> -	local tmp tool cc_version arch host cc_arch
> +	local tmp tool cc_version arch host cc_arch mcount=
>  
>  	bail() { echo "Bail out! $*" >&2; exit 1; }
>  
> @@ -99,6 +99,16 @@ klp_preflight()
>  	*AArch64*)		cc_arch=arm64 ;;
>  	*)			cc_arch= ;;
>  	esac
> +
> +	# Same test as FTRACE_MCOUNT_USE_CC.
> +	if [ "$cc_arch" = x86 ]; then
> +		if $CC -pg -mfentry -mrecord-mcount -mnop-mcount -c \
> +			-o "$tmp/probe.o" "$tmp/probe.c" 2>/dev/null; then
> +			mcount=cc
> +		else
> +			mcount=objtool
> +		fi
> +	fi
>  	rm -rf "$tmp"
>  
>  	# Normalize to the kernel's SRCARCH.
> @@ -119,8 +129,9 @@ klp_preflight()
>  		     "the $arch tests would run against the wrong architecture"
>  
>  	KLP_TEST_ARCH="$arch"
> +	KLP_TEST_MCOUNT="$mcount"
>  	KLP_TEST_PREFLIGHT=done
> -	export OBJTOOL CC KLP_TEST_ARCH KLP_TEST_PREFLIGHT
> +	export OBJTOOL CC KLP_TEST_ARCH KLP_TEST_MCOUNT KLP_TEST_PREFLIGHT
>  
>  	cc_version="$($CC --version 2>/dev/null | head -1)"
>  	cat <<EOF
> @@ -128,6 +139,7 @@ klp_preflight()
>  #   objtool   $OBJTOOL (klp: yes)
>  #   compiler  $cc_version
>  #   arch      $KLP_TEST_ARCH$([ "$arch" = "$host" ] || echo "  (host $host, cross)")
> +#   mcount    ${KLP_TEST_MCOUNT:-n/a}
>  #   tmpdir    ${TMPDIR:-/tmp}  (each test builds in a fresh directory here)
>  EOF
>  }
> @@ -153,6 +165,16 @@ EOF
>  FIXTURE_CFLAGS="-O2 -ffunction-sections -fdata-sections -fno-common \
>  		-fno-asynchronous-unwind-tables"
>  
> +# Build with ftrace, which livepatch depends on.  Objects not built with
> +# build_one() need FTRACE_CFLAGS and record_mcount() too.
> +FTRACE_CFLAGS=
> +if [ "$KLP_TEST_ARCH" = x86 ]; then
> +	FTRACE_CFLAGS="-pg -mfentry"
> +	[ "$KLP_TEST_MCOUNT" = cc ] &&
> +		FTRACE_CFLAGS="$FTRACE_CFLAGS -mrecord-mcount -mnop-mcount"
> +fi
> +FIXTURE_CFLAGS="$FIXTURE_CFLAGS $FTRACE_CFLAGS"
> +
>  test_name="$(basename "$0" .sh)"
>  workdir=
>  
> @@ -343,6 +365,20 @@ build_one()
>  
>  	$CC -c $FIXTURE_CFLAGS "$@" -o "$out" "$fixture" 2>"$workdir/cc.log" ||
>  		fail "$(basename "$fixture") does not build: $(tail -1 "$workdir/cc.log")"
> +
> +	record_mcount "$out"
> +}
> +
> +# record_mcount <object>
> +#
> +# FTRACE_MCOUNT_USE_OBJTOOL.  CONFIG_KLP_BUILD always runs objtool with --link.
> +record_mcount()
> +{
> +	[ "$KLP_TEST_MCOUNT" = objtool ] || return 0
> +
> +	"$OBJTOOL" --mcount --mnop --link "$1" 2>"$workdir/objtool.log" ||
> +		fail "objtool --mcount failed on $(basename "$1"):" \
> +		     "$(tail -1 "$workdir/objtool.log")"
>  }
>  
>  # build_pair <fixture.c> [cflags...]
> @@ -365,7 +401,7 @@ build_pair()
>  # Run objtool's ordinary check pass over the pair, as the kernel build does.
>  #
>  # Some of what klp diff consumes is produced by this pass rather than by the
> -# compiler: .static_call_sites, .mcount_loc, .ibt_endbr_seal, ORC.
> +# compiler: .static_call_sites, .ibt_endbr_seal, ORC.
>  #
>  # Only module objects see it before klp-build -- with CONFIG_KLP_BUILD the
>  # per-object pass is deferred, so built-in objects reach klp diff exactly as
> diff --git a/tools/objtool/tests/x86/test-checksum-alt.sh b/tools/objtool/tests/x86/test-checksum-alt.sh
> index 74ebfca2b3ff3..eb9864c4bf825 100755
> --- a/tools/objtool/tests/x86/test-checksum-alt.sh
> +++ b/tools/objtool/tests/x86/test-checksum-alt.sh
> @@ -16,9 +16,6 @@
>  # the feature bit, so the failure looks like a machine-specific bug rather than
>  # a missing patch.
>  #
> -# insn->alts exists only after objtool's check pass, so the pair goes through
> -# that first -- the compiler emits none of this structure itself.
> -#
>  # Covers the same ground as corpus/x86_64/checksum-alt-group,
>  # checksum-alt-no-group and checksum-alt-recursion-guard in Joe Lawrence's
>  # klp-build unit test corpus.
> @@ -31,7 +28,6 @@ check()
>  {
>  	build_pair checksum_alt.c "-D$1"
>  	assert_input_section .altinstructions
> -	run_objtool_check --mcount
>  	run_checksum
>  
>  	assert_checksum_differs target
> diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/objtool/tests/x86/test-special-sections.sh
> index 8dfaa4fc9a360..b05d43cdc8aa4 100755
> --- a/tools/objtool/tests/x86/test-special-sections.sh
> +++ b/tools/objtool/tests/x86/test-special-sections.sh
> @@ -15,26 +15,31 @@
>  
>  
>  # section, entry size, relocations per entry
> -for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; do
> +for spec in "__bug_table 12 1" "__ex_table 12 2"; do
>  	set -- $spec
> -	sec=$1
>  
>  	# A fresh workdir per section: run_diff caches its checksums.
>  	setup
>  	build_pair special_sections.c \
>  		-DSPECIAL_SEC="\"$1\"" -DSPECIAL_ENTSIZE="$2" -DSPECIAL_RELOCS="$3"
>  
> -	assert_input_section "$sec"
> +	# __mcount_loc comes from FTRACE_CFLAGS, not from the fixture.
> +	for sec in "$1" __mcount_loc; do
> +		assert_input_section "$sec"
> +	done
>  	run_diff
>  
> -	# Extracted, and pointing at the function that was patched.
> -	assert_section "$sec"
> -	assert_reloc_sym "$sec" target
>  	assert_patched target
> -
> -	# Nothing belonging to the function that was not.
>  	assert_not_patched other
> -	assert_no_reloc_sym "$sec" other
> +
> +	for sec in "$1" __mcount_loc; do
> +		# Extracted, and pointing at the function that was patched.
> +		assert_section "$sec"
> +		assert_reloc_sym "$sec" target
> +
> +		# Nothing belonging to the function that was not.
> +		assert_no_reloc_sym "$sec" other
> +	done

Nitpick: it looks a little odd that the __mcount_loc special case was
pushed inside the greater section loop (bug-tables, ex-table) so it runs
twice AFAICT.  Would it be clearer to just pull this out as its own
block?

--
Joe

