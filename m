Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536302;
	b=qbt2KueAvphv05m5g8zORHo+Sp8tXPWRx8kbrxCAESf24j/95pgpxWjS8P+kRF7Bn2Aj
	 g447mQ3ufZW1zqA1RAKDnyJ2MkdHD0O7a7BdlTmSA3Kmsh3Q6+ivcJ6wnXWLMYY2fQV8C
	 MJc639hkBm53ePgStkD27HAMPLBBbpqrYvs+jLndawHQMD+u4UJbiBI/zMqmge1UtZukH
	 LxOBP8KaVdPRIIWKP6aNoOD0LfYGHANYKdw8Rqj6eyvRAEXAggco5O0QquR2awQZmTwiW
	 zGQj7fvoU2B9MiGcfhpjY4E+JN8DVgh+CF3yMOF0eYPSC+0A9s5bIgDGKhCXDXYNxHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6OlSBHhctcsMRzTeSPSqWrS73Z3AfX+m3Yn6eI6J9nw=;
	b=g2Mw8F6oLZ89V2krBD1mVZRzrj82inslGCWNZbKB8WGAUAB4P53NLfbMn6XobKNMUSg3
	 alCZE1F9+et74m+9tct3OF1I7jNn7+HPyE8gxg/afruKs69gZY+5Pin8Qc7Xt67IQYPQu
	 OtRdutGjOGxy2w+G7IIh0d3a/ziOqDhCuN3LoT6YXb1CY+w0K90u/FzcWY8n95bWrOjU1
	 g8L3GZKOd50TNa/KKOWneZIxdebRzYyHh7ukxUW6gd+a9PYaEewlQe+lUsvNSY0cIayvY
	 cCILhNo+XGW4UbXtj2vEPYpD3SCKrfSt73hlPTeGkRKrMjYgbSB1vT6qyAmkvBk/GpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIhwOYPl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CF606A31B
	for <live-patching@vger.kernel.org>; Tue, 20 Oct 2026 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIhwOYPl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BAE1F000C9;
	Tue, 20 Oct 2026 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792536301;
	bh=6OlSBHhctcsMRzTeSPSqWrS73Z3AfX+m3Yn6eI6J9nw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIhwOYPl6z/BX+ig3/RLt8RQnMENC+XtBzuVmaEvnGsvXjDpvp5gzQE9xkpRVClP1
	 K2IdVvcyL+TQCElISUGa+zV4CSmNuz2Y1cYjlmem+A+L4xZuSgkGqSsCIM4ekaauks
	 XOIWpPH/eR7xkla5oMZzQFPw6IJ+mH0mbLXvspsIZbqo/LH4MUPA5+OzOZgo1gjp9m
	 61ucQyAlKA6NYV2QKBLlVb5qdk22QTy4y5gnotPmi9J9rBdbO1beIHOezlUJVjjMb8
	 6sj/SsEbUdo1DYm2Gbe8LOvatV5tMxsUI6cafcUXP6FT1PwVofQxwj+IXr0KL2Q8Ne
	 IxnmWhr9zB0lQ==
Message-ID: <sashiko-outbox-179573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] klp-build: Reuse the target kernel randstruct seed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org
In-Reply-To: <20261020212341.706367-1-song@kernel.org>
References: <20261020212341.706367-1-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:45:00 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] klp-build: set_kernelversion() clobbers randstruct.seed before p=
inning
- [Medium] klp-build: set_randstruct_seed() mtime update forces full rebuil=
d on -S 2
--

commit 606c1a8e7c05ba3363ccb4c4faa0e0f6111aaeda
Author: Song Liu <song@kernel.org>

klp-build: Reuse the target kernel randstruct seed

This commit reuses the target kernel's randstruct seed in klp-build by
reading scripts/basic/randstruct.seed (or a file passed via
--randstruct-seed) before set_kernelversion() and pinning
scripts/gen-randstruct-seed.sh afterwards so that livepatch modules are
built with matching randomized struct layouts.

> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index b52a8489d9f67..fd336f685a841 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build

[ ... ]

> @@ -328,6 +332,51 @@ set_kernelversion() {
>  	sed -i "2i echo $kernelrelease; exit 0" scripts/setlocalversion
>  }
> =20
> +# CONFIG_RANDSTRUCT randomizes struct layouts based on a seed which kbui=
ld
> +# generates from /dev/urandom.  A livepatch has to observe the same layo=
uts as
> +# the kernel it gets loaded into, so reuse that kernel's seed.  Otherwis=
e the
> +# module loader rejects the module ("...this_module section size must ma=
tch
> +# the kernel's built struct module size at run time"), and any randomized
> +# struct the patch touches would be accessed at the wrong offsets.
> +#
> +# This must run before set_kernelversion(), whose 'make syncconfig' also
> +# builds scripts/basic.  After a 'make clean' that would replace the seed
> +# before the default seed file gets read.
> +read_randstruct_seed() {
> +	local seed_file
> +
> +	[[ -v CONFIG_RANDSTRUCT ]] || return 0
> +
> +	if [[ -v RANDSTRUCT_SEED_FILE ]]; then
> +		seed_file=3D"$RANDSTRUCT_SEED_FILE"
> +	else
> +		seed_file=3D"$PWD/scripts/basic/randstruct.seed"
> +		[[ -r "$seed_file" ]] ||				\
> +			die "CONFIG_RANDSTRUCT is enabled but there's no $seed_file; pass --r=
andstruct-seed with the seed used to build the kernel"
> +	fi
> +
> +	RANDSTRUCT_SEED=3D"$(< "$seed_file")"
> +	[[ "$RANDSTRUCT_SEED" =3D~ ^[0-9a-f]{64}$ ]] ||			\
> +		die "malformed randstruct seed in $seed_file"
> +}
> +
> +# Pin the generator rather than the seed file: clean_kernel() removes
> +# scripts/basic/.randstruct.seed.cmd, so if_changed sees no saved comman=
d and
> +# regenerates the seed no matter what the file already holds.
> +#
> +# This must run after set_kernelversion(), otherwise setlocalversion see=
s the
> +# modified generator and appends "-dirty" to the kernel release.
> +set_randstruct_seed() {
> +	local gen=3D"$PWD/scripts/gen-randstruct-seed.sh"
> +
> +	[[ -v RANDSTRUCT_SEED ]] || return 0
> +
> +	stash_file "$gen"
> +	sed -i "s|^SEED=3D.*|SEED=3D$RANDSTRUCT_SEED|" "$gen"
> +	command grep -q "^SEED=3D$RANDSTRUCT_SEED$" "$gen" ||		\
> +		die "failed to pin randstruct seed"
> +}

[Severity: Medium]
When running klp-build with --short-circuit=3D2 (-S 2 / -S patched) after an
initial -T run has built 1-orig and restored scripts/gen-randstruct-seed.sh
on exit via cleanup() -> restore_files(), set_randstruct_seed() runs sed -i
on scripts/gen-randstruct-seed.sh and updates its mtime to be newer than
scripts/basic/randstruct.seed from the 1-orig build.

In scripts/basic/Makefile:

    cmd_create_randstruct_seed =3D \
        $(CONFIG_SHELL) $(gen-randstruct-seed) \
            $@ $(objtree)/include/generated/randstruct_hash.h
    $(obj)/randstruct.seed: $(gen-randstruct-seed) FORCE
        $(call if_changed,create_randstruct_seed)

Because $(gen-randstruct-seed) has a newer mtime than $(obj)/randstruct.see=
d,
if_changed re-executes scripts/gen-randstruct-seed.sh and rewrites
include/generated/randstruct_hash.h (as well as triggering a rebuild of
randomize_layout_seed.h, randomize_layout_plugin.so, and
include/generated/gcc-plugins.h when CONFIG_GCC_PLUGIN_RANDSTRUCT is
enabled).

Since include/linux/compiler-version.h is force-included in every translati=
on
unit:

    #ifdef RANDSTRUCT
    #include <generated/randstruct_hash.h>
    #endif

wouldn't touching include/generated/randstruct_hash.h cause build_kernel
"patched" under -S 2 to recompile the entire kernel tree instead of only the
patched files?

> +
>  get_patch_input_files() {
>  	local patch=3D"$1"
> =20
> @@ -464,7 +513,9 @@ do_init() {
> =20
>  	validate_config
>  	set_module_name
> +	read_randstruct_seed
>  	set_kernelversion
> +	set_randstruct_seed
>  }

[Severity: Medium]
In do_init(), read_randstruct_seed() reads the seed before
set_kernelversion(), while set_randstruct_seed() pins
scripts/gen-randstruct-seed.sh only after set_kernelversion() finishes:

    set_kernelversion() {
        ...
        if [[ -n "$(make -s listnewconfig 2>/dev/null)" ]]; then
            die ".config mismatch, check your .config or run 'make olddefco=
nfig'"
        fi
        make syncconfig &>/dev/null || die "make syncconfig failed"

Both "make -s listnewconfig" and "make syncconfig" match the top-level
Makefile rule:

    %config: outputmakefile scripts_basic FORCE
        $(Q)$(MAKE) $(build)=3Dscripts/kconfig $@

When scripts/basic/.randstruct.seed.cmd is missing (for instance after "make
clean") or when scripts/gen-randstruct-seed.sh has a newer mtime than
scripts/basic/randstruct.seed (such as after a previous run where
stash_file() copied scripts/gen-randstruct-seed.sh with "cp -f" without
preserving timestamps and restore_files() moved it back on exit), building
scripts_basic in set_kernelversion() runs the unpinned
scripts/gen-randstruct-seed.sh. That overwrites scripts/basic/randstruct.se=
ed
and include/generated/randstruct_hash.h with a new random seed from
/dev/urandom.

Because set_randstruct_seed() only edits scripts/gen-randstruct-seed.sh
without stashing or restoring scripts/basic/randstruct.seed and
include/generated/randstruct_hash.h, can this overwrite cause two issues?

First, if klp-build exits before build_kernel() runs (for example, when
listnewconfig or syncconfig fails in set_kernelversion(), or when
validate_patches() fails before build_kernel()), cleanup() restores
scripts/gen-randstruct-seed.sh while leaving scripts/basic/randstruct.seed =
on
disk overwritten with the random seed. Subsequent runs relying on the defau=
lt
scripts/basic/randstruct.seed will then silently read that corrupted seed.

Second, when invoked with --short-circuit (-S 3, -S 4, or -S 5),
clean_kernel() and build_kernel() do not run, and build_patch_module() runs
an external module build ("make --directory=3D. M=3D$KMOD_DIR") which does =
not
build scripts_basic. Because the pinned scripts/gen-randstruct-seed.sh never
runs (and even under -S 2, if_changed can skip running it if
set_kernelversion() and set_randstruct_seed() execute within the same
filesystem timestamp tick), wouldn't the livepatch module be compiled using
the wrong seed left in scripts/basic/randstruct.seed and
include/generated/randstruct_hash.h?

> =20
>  # Refresh the patch hunk headers, specifically the line numbers and coun=
ts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020212341.7063=
67-1-song@kernel.org?part=3D1
