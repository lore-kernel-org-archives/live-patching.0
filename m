Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF34E50D2
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584250; cv=none; b=hfjiV/nFKwpqkQiSrTbrk24+pLCRTcwLheViawYeLSnNi53YLn6U0ihiQhzK79qXIK0zsJ9wFkDbb2mIqoS978wFUzk89k0olbBaGjOCPfVvwuJFD4BSFM4/5amBEGAAs4n/CfbeuP9Gn/vejkQ/Rul/7hXDAEhWN+scD1ZwgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584250; c=relaxed/simple;
	bh=sh2FzyLRfZmwDGOAvIV0+D6tt6tynA0jK1Bohp1vppg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtZWhqT30KnKjIl/rPwal3W4CVBhu2GNe+Gu0HQc+y0eG0BcHRkNLxySutz2Iu/Dr9BeQ5bEUTEE9GSDwWW2sZfGDQyJvN/8AeC0P2pK7gaTyHgK/Ki0Z1jnsko++1IVsk3diU66DdUXh9ZLHv/aisR395ATfzWCEEyqortS+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfvCTTRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfvCTTRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F306B1F00899;
	Wed, 16 Sep 2026 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584237;
	bh=kJFRnpPZoD+jJ486cdH8J+0jVx3ry2ZR6vGoVikWzUI=;
	h=From:To:Cc:Subject:Date;
	b=EfvCTTRT2St20ucZ8dRXeFiSHd6Q8zJ0MsQEzk8jXQXOwBSw65nQaTKUp1y+Hkev2
	 WD+bS4u7C0Fdnbpp34KUBzpFmX2msYF1irRCpupy+vnFskH0La28/tpHN6FmzPSug9
	 PHoKPXy8BdnZYQQYsPd0LDxmn7YCoO1G1fW96SyThQJ7qWqXhqGHBzgloSvbccNXe5
	 D/QMj76P5MzzljcHvePaexv5yUJpOsUtGvr9kkip/YURCYaJ76/wyAjC9AdzymCznv
	 aLF38oQDgjjSS96Tq5cACtMhVYPH3PIJOU+NdfV6IlGB2E8cWZldocju/HG2HcOua9
	 AjqvveTRcX3Kg==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	puranjay@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 00/58] Unit test framework for klp-build toolchain
Date: Wed, 16 Sep 2026 11:42:53 -0700
Message-ID: <20260916184351.2720310-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the unit test part of a test framework for the klp-build toolchain.
The other part of the test framework will be some integration tests,
similar to an earlier propose [1].

This is joint work by Puranjay Mohan, Joe Lawrence, and myself (Song Liu).
Note that, while only two patches here are under Joe's authorship, his
contribution to this set is much bigger than the number represents. A lot
of these tests are based on Joe's earlier work in this area [2].

As the Assisted-by tags show, a lot of the work here is done with assists
of AI. We actually designed the framework to so that we expect AI to write
these tests in the future. AI also contributed in the design of the test
framework. However, we (human) carefully reviewed the test framework. Also,
this cover letter is 100% written by a human being (Song Liu).

Here are some key design choices we made for this unit tests framework:

1. We do not need different unit test here for different kernel CONFIG_*
   options. Instead, the tests cover different CONFIG_* options by passing
   different arguments to the compiler and objtool.

2. The test is NOT designed to be backward compatible. Similar to objtool
   itself, the unit tests are delivered with the kernel tree. The user of
   these tests should test the objtool with the unit tests in the same
   branch. Once this test framework lands, future changes and fixes to the
   objtool klp command should land with unit tests that cover the changes.

3. It is possible to run these tests on a different architecture with
   proper cross compilers. However, for automated CI, we are planning to
   focus on native tests. Please refer to "Future work" section below for
   more information about the CI.

4. AI will help write tests. We found AI is very cable to write good tests.
   tools/objtool/Documentation/klp-write-tests.txt is added for AI to read,
   so that AI can write tests for this test framework.

Future work
1. The integration test simiar to [1]. Unlike the unit tests, the
   integration tests will need separate runs to cover different kernel
   CONFIG_* combinations.

2. CI. The plan is to build a lore => patchwork => GitHub CI framework.
   This is the model used by subsystems such as netdev, bpf, and risc-v.
   We also have some ideas on "who will pay for the CI" issue, but I would
   rather not promise anything yet.

3. More tests.

Thanks,
Song

[1] https://lore.kernel.org/live-patching/20260226005436.379303-9-song@kernel.org/
[2] https://github.com/joe-lawrence/klp-build-unit-tests


Changes v4 => v5:
1. Yet more fixes based on Sashiko reviews.

v4: https://lore.kernel.org/live-patching/20260915233454.2405019-1-song@kernel.org/

Changes v3 => v4:
1. Fix yet more issues reported by Sashiko.

v3: https://lore.kernel.org/live-patching/20260914230355.3422996-1-song@kernel.org/

Changes v2 => v3:
1. Fix more issues reported by Sashiko.

v2: https://lore.kernel.org/live-patching/20260914062514.926997-1-song@kernel.org/

Changes v1 => v2:
1. Fix issues reported by Sashiko.

v1: https://lore.kernel.org/live-patching/20260911184305.1457308-1-song@kernel.org/


Joe Lawrence (2):
  objtool: Keep failing test workdirs by default
  objtool: Forward toolchain variables to the klp test runner

Puranjay Mohan (16):
  objtool: Add test harness for the klp subcommands
  objtool/klp: Add test for rejecting changed data
  objtool/klp: Add test for newly introduced data
  objtool/klp: Add test for newly introduced functions
  objtool/klp: Add test for static local correlation
  objtool/klp: Add test for cold function halves
  objtool/klp: Add test for special section extraction
  objtool/klp: Add test for selective special section extraction
  objtool/klp: Add test for jump table key relocations
  objtool/klp: Add test for rejecting module-owned static branch keys
  objtool/klp: Add test for rejecting module-owned static call keys
  objtool/klp: Add test for symids in discarded sections
  objtool/klp: Add test for rejecting references to init code/data
  objtool/klp: Add test for correlation across ThinLTO name mangling
  objtool/klp: Add test for objects without .modinfo
  objtool/klp: Add test for unchecksummed input

Song Liu (40):
  objtool/klp: Check the klp test environment once, before any test
  objtool/klp: Group the klp tests by architecture
  objtool/klp: Classify klp test outcomes
  objtool/klp: Build klp test fixtures through the harness
  objtool/klp: Grow the klp test harness vocabulary
  objtool/klp: Give each run one working directory, one per test inside
    it
  objtool/klp: Run the klp tests under set -u
  objtool/klp: Document the klp test harness
  objtool/klp: Add klp diff and post-link regression tests
  objtool/klp: Add test for klp reloc section naming in module objects
  objtool/klp: Add test for vmlinux relocs in a patched module
  objtool/klp: Add test for Module.symvers path normalization
  objtool/klp: Add test for the contents of the klp_funcs list
  objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES references
  objtool/klp: Add test for new references to exported symbols
  objtool/klp: Add test for empty x86 alternative replacements
  objtool/klp: Add test for recorded checksum values
  objtool/klp: Add test for position-independent checksums
  objtool/klp: Add test for sympos in module objects
  objtool/klp: Add test for sympos resolved against a linked vmlinux
  objtool/klp: Add test for static locals which must not be correlated
  objtool/klp: Add test for __bug_table, __ex_table and __mcount_loc
    extraction
  objtool/klp: Add test for kCFI prefix symbols and traps
  objtool/klp: Add test for symbols whose linkage the patch changes
  objtool/klp: Test rejection of a file-local static branch key
  objtool/klp: Test a hand-built livepatch module's static call keys
  objtool/klp: Test text annotations on alternative replacements
  objtool/klp: Add test for data object checksums
  objtool/klp: Add test for symbols with no checksum entry of their own
  objtool/klp: Add test for a static branch introduced by the patch
  objtool/klp: Add test for tracepoint and pr_debug static branch keys
  objtool/klp: Add test for a static call introduced by the patch
  objtool/klp: Add test for instruction operand checksums
  objtool/klp: Add test for alternative replacement code in checksums
  objtool/klp: Add test for the alignment of cloned data sections
  objtool/klp: Add test for a patch which strips a data annotation
  objtool/klp: Add test for absolute and __ADDRESSABLE symbols
  objtool/klp: Add test for UBSAN metadata in an unchanged function
  objtool/klp: Add test for Clang switch jump tables
  objtool/klp: Add test for ThinLTO symbols sharing a demangled name

 .../objtool/Documentation/klp-test-design.txt | 286 ++++++
 .../objtool/Documentation/klp-write-tests.txt | 266 +++++
 tools/objtool/Makefile                        |  15 +-
 .../generic/fixtures/abs_and_addressable.c    |  44 +
 tools/objtool/tests/generic/fixtures/basic.c  |  20 +
 .../tests/generic/fixtures/changed_data.c     |  16 +
 .../tests/generic/fixtures/checksum_data.c    | 116 +++
 .../tests/generic/fixtures/checksum_insn.c    |  78 ++
 .../generic/fixtures/checksum_position.c      |  42 +
 .../tests/generic/fixtures/checksum_skip.c    |  47 +
 .../tests/generic/fixtures/cold_function.c    |  21 +
 .../tests/generic/fixtures/cross_module.c     |  25 +
 .../tests/generic/fixtures/data_alignment.c   |  29 +
 .../tests/generic/fixtures/function_removal.c |  25 +
 .../tests/generic/fixtures/init_reference.c   |  17 +
 .../tests/generic/fixtures/jump_label.c       |  76 ++
 .../tests/generic/fixtures/klp_funcs.c        |  31 +
 .../tests/generic/fixtures/local_to_global.c  |  34 +
 .../objtool/tests/generic/fixtures/new_data.c |  23 +
 .../tests/generic/fixtures/new_export_ref.c   |  35 +
 .../tests/generic/fixtures/new_function.c     |  21 +
 .../tests/generic/fixtures/no_modinfo.c       |  11 +
 .../tests/generic/fixtures/special_section.c  |  24 +
 .../generic/fixtures/special_section_shared.c |  31 +
 .../tests/generic/fixtures/static_call.c      |  59 ++
 .../tests/generic/fixtures/static_local.c     |  17 +
 .../fixtures/static_local_uncorrelated.c      |  41 +
 .../tests/generic/fixtures/switch_rodata.c    |  31 +
 .../tests/generic/fixtures/symid_discarded.c  |  25 +
 .../tests/generic/fixtures/sympos_dup.c       |  32 +
 .../tests/generic/fixtures/sympos_vmlinux.c   |  40 +
 .../generic/fixtures/thinlto_ambiguity.c      |  57 ++
 .../tests/generic/fixtures/thinlto_local.c    |  39 +
 .../tests/generic/fixtures/ubsan_noise.c      |  49 +
 .../tests/generic/test-abs-and-addressable.sh |  50 +
 tools/objtool/tests/generic/test-basic.sh     |  17 +
 .../tests/generic/test-changed-data.sh        |  18 +
 .../tests/generic/test-checksum-data.sh       |  61 ++
 .../tests/generic/test-checksum-debug.sh      |  49 +
 .../tests/generic/test-checksum-insn.sh       |  49 +
 .../tests/generic/test-checksum-position.sh   |  50 +
 .../tests/generic/test-checksum-skip.sh       |  81 ++
 .../tests/generic/test-checksum-value.sh      |  37 +
 .../tests/generic/test-cold-function.sh       |  39 +
 .../tests/generic/test-data-alignment.sh      |  40 +
 .../generic/test-export-symbol-for-modules.sh |  39 +
 .../tests/generic/test-function-removal.sh    |  34 +
 .../tests/generic/test-init-reference.sh      |  29 +
 .../generic/test-jump-label-exempt-keys.sh    |  51 +
 .../tests/generic/test-jump-label-key.sh      |  44 +
 .../generic/test-jump-label-module-key.sh     |  22 +
 .../test-jump-label-module-static-key.sh      |  45 +
 .../tests/generic/test-jump-label-new-key.sh  |  51 +
 .../tests/generic/test-klp-funcs-content.sh   |  45 +
 .../generic/test-local-to-global-flip.sh      |  63 ++
 .../tests/generic/test-local-vs-export.sh     |  32 +
 .../tests/generic/test-missing-checksum.sh    |  18 +
 .../tests/generic/test-missing-modinfo.sh     |  16 +
 .../tests/generic/test-modname-normalize.sh   |  26 +
 .../tests/generic/test-module-object.sh       |  31 +
 .../generic/test-module-vmlinux-reloc.sh      |  40 +
 tools/objtool/tests/generic/test-new-data.sh  |  27 +
 .../tests/generic/test-new-export-ref.sh      |  46 +
 .../tests/generic/test-new-function.sh        |  16 +
 tools/objtool/tests/generic/test-post-link.sh |  42 +
 .../generic/test-special-section-shared.sh    |  26 +
 .../tests/generic/test-special-section.sh     |  20 +
 .../test-static-call-annotate-stripped.sh     |  42 +
 .../generic/test-static-call-module-key.sh    |  36 +
 .../tests/generic/test-static-call-new.sh     |  45 +
 .../generic/test-static-local-uncorrelated.sh |  41 +
 .../tests/generic/test-static-local.sh        |  24 +
 .../tests/generic/test-switch-rodata.sh       |  53 +
 .../tests/generic/test-symid-discarded.sh     |  44 +
 .../tests/generic/test-sympos-vmlinux.sh      |  57 ++
 tools/objtool/tests/generic/test-sympos.sh    |  51 +
 .../tests/generic/test-symvers-parse-error.sh |  23 +
 .../tests/generic/test-thinlto-ambiguity.sh   |  77 ++
 .../tests/generic/test-thinlto-local.sh       |  48 +
 .../objtool/tests/generic/test-ubsan-noise.sh |  48 +
 tools/objtool/tests/lib.sh                    | 911 ++++++++++++++++++
 tools/objtool/tests/run-tests.sh              | 239 +++++
 .../objtool/tests/x86/fixtures/alt_annotate.c |  57 ++
 .../objtool/tests/x86/fixtures/checksum_alt.c |  66 ++
 .../tests/x86/fixtures/empty_alternative.c    |  77 ++
 tools/objtool/tests/x86/fixtures/kcfi.c       |  39 +
 .../tests/x86/fixtures/special_sections.c     |  77 ++
 .../tests/x86/fixtures/static_call_no_key.c   |  32 +
 .../objtool/tests/x86/test-alt-annotation.sh  |  38 +
 tools/objtool/tests/x86/test-checksum-alt.sh  |  45 +
 .../tests/x86/test-empty-alternative.sh       |  31 +
 tools/objtool/tests/x86/test-kcfi.sh          |  39 +
 .../tests/x86/test-manual-klp-static-call.sh  |  40 +
 .../tests/x86/test-special-sections.sh        |  42 +
 94 files changed, 5298 insertions(+), 1 deletion(-)
 create mode 100644 tools/objtool/Documentation/klp-test-design.txt
 create mode 100644 tools/objtool/Documentation/klp-write-tests.txt
 create mode 100644 tools/objtool/tests/generic/fixtures/abs_and_addressable.c
 create mode 100644 tools/objtool/tests/generic/fixtures/basic.c
 create mode 100644 tools/objtool/tests/generic/fixtures/changed_data.c
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_data.c
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_insn.c
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_position.c
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_skip.c
 create mode 100644 tools/objtool/tests/generic/fixtures/cold_function.c
 create mode 100644 tools/objtool/tests/generic/fixtures/cross_module.c
 create mode 100644 tools/objtool/tests/generic/fixtures/data_alignment.c
 create mode 100644 tools/objtool/tests/generic/fixtures/function_removal.c
 create mode 100644 tools/objtool/tests/generic/fixtures/init_reference.c
 create mode 100644 tools/objtool/tests/generic/fixtures/jump_label.c
 create mode 100644 tools/objtool/tests/generic/fixtures/klp_funcs.c
 create mode 100644 tools/objtool/tests/generic/fixtures/local_to_global.c
 create mode 100644 tools/objtool/tests/generic/fixtures/new_data.c
 create mode 100644 tools/objtool/tests/generic/fixtures/new_export_ref.c
 create mode 100644 tools/objtool/tests/generic/fixtures/new_function.c
 create mode 100644 tools/objtool/tests/generic/fixtures/no_modinfo.c
 create mode 100644 tools/objtool/tests/generic/fixtures/special_section.c
 create mode 100644 tools/objtool/tests/generic/fixtures/special_section_shared.c
 create mode 100644 tools/objtool/tests/generic/fixtures/static_call.c
 create mode 100644 tools/objtool/tests/generic/fixtures/static_local.c
 create mode 100644 tools/objtool/tests/generic/fixtures/static_local_uncorrelated.c
 create mode 100644 tools/objtool/tests/generic/fixtures/switch_rodata.c
 create mode 100644 tools/objtool/tests/generic/fixtures/symid_discarded.c
 create mode 100644 tools/objtool/tests/generic/fixtures/sympos_dup.c
 create mode 100644 tools/objtool/tests/generic/fixtures/sympos_vmlinux.c
 create mode 100644 tools/objtool/tests/generic/fixtures/thinlto_ambiguity.c
 create mode 100644 tools/objtool/tests/generic/fixtures/thinlto_local.c
 create mode 100644 tools/objtool/tests/generic/fixtures/ubsan_noise.c
 create mode 100755 tools/objtool/tests/generic/test-abs-and-addressable.sh
 create mode 100755 tools/objtool/tests/generic/test-basic.sh
 create mode 100755 tools/objtool/tests/generic/test-changed-data.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-data.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-debug.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-insn.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-position.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-skip.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-value.sh
 create mode 100755 tools/objtool/tests/generic/test-cold-function.sh
 create mode 100755 tools/objtool/tests/generic/test-data-alignment.sh
 create mode 100755 tools/objtool/tests/generic/test-export-symbol-for-modules.sh
 create mode 100755 tools/objtool/tests/generic/test-function-removal.sh
 create mode 100755 tools/objtool/tests/generic/test-init-reference.sh
 create mode 100755 tools/objtool/tests/generic/test-jump-label-exempt-keys.sh
 create mode 100755 tools/objtool/tests/generic/test-jump-label-key.sh
 create mode 100755 tools/objtool/tests/generic/test-jump-label-module-key.sh
 create mode 100755 tools/objtool/tests/generic/test-jump-label-module-static-key.sh
 create mode 100755 tools/objtool/tests/generic/test-jump-label-new-key.sh
 create mode 100755 tools/objtool/tests/generic/test-klp-funcs-content.sh
 create mode 100755 tools/objtool/tests/generic/test-local-to-global-flip.sh
 create mode 100755 tools/objtool/tests/generic/test-local-vs-export.sh
 create mode 100755 tools/objtool/tests/generic/test-missing-checksum.sh
 create mode 100755 tools/objtool/tests/generic/test-missing-modinfo.sh
 create mode 100755 tools/objtool/tests/generic/test-modname-normalize.sh
 create mode 100755 tools/objtool/tests/generic/test-module-object.sh
 create mode 100755 tools/objtool/tests/generic/test-module-vmlinux-reloc.sh
 create mode 100755 tools/objtool/tests/generic/test-new-data.sh
 create mode 100755 tools/objtool/tests/generic/test-new-export-ref.sh
 create mode 100755 tools/objtool/tests/generic/test-new-function.sh
 create mode 100755 tools/objtool/tests/generic/test-post-link.sh
 create mode 100755 tools/objtool/tests/generic/test-special-section-shared.sh
 create mode 100755 tools/objtool/tests/generic/test-special-section.sh
 create mode 100755 tools/objtool/tests/generic/test-static-call-annotate-stripped.sh
 create mode 100755 tools/objtool/tests/generic/test-static-call-module-key.sh
 create mode 100755 tools/objtool/tests/generic/test-static-call-new.sh
 create mode 100755 tools/objtool/tests/generic/test-static-local-uncorrelated.sh
 create mode 100755 tools/objtool/tests/generic/test-static-local.sh
 create mode 100755 tools/objtool/tests/generic/test-switch-rodata.sh
 create mode 100755 tools/objtool/tests/generic/test-symid-discarded.sh
 create mode 100755 tools/objtool/tests/generic/test-sympos-vmlinux.sh
 create mode 100755 tools/objtool/tests/generic/test-sympos.sh
 create mode 100755 tools/objtool/tests/generic/test-symvers-parse-error.sh
 create mode 100755 tools/objtool/tests/generic/test-thinlto-ambiguity.sh
 create mode 100755 tools/objtool/tests/generic/test-thinlto-local.sh
 create mode 100755 tools/objtool/tests/generic/test-ubsan-noise.sh
 create mode 100644 tools/objtool/tests/lib.sh
 create mode 100755 tools/objtool/tests/run-tests.sh
 create mode 100644 tools/objtool/tests/x86/fixtures/alt_annotate.c
 create mode 100644 tools/objtool/tests/x86/fixtures/checksum_alt.c
 create mode 100644 tools/objtool/tests/x86/fixtures/empty_alternative.c
 create mode 100644 tools/objtool/tests/x86/fixtures/kcfi.c
 create mode 100644 tools/objtool/tests/x86/fixtures/special_sections.c
 create mode 100644 tools/objtool/tests/x86/fixtures/static_call_no_key.c
 create mode 100755 tools/objtool/tests/x86/test-alt-annotation.sh
 create mode 100755 tools/objtool/tests/x86/test-checksum-alt.sh
 create mode 100755 tools/objtool/tests/x86/test-empty-alternative.sh
 create mode 100755 tools/objtool/tests/x86/test-kcfi.sh
 create mode 100755 tools/objtool/tests/x86/test-manual-klp-static-call.sh
 create mode 100755 tools/objtool/tests/x86/test-special-sections.sh

--
2.53.0-Meta
