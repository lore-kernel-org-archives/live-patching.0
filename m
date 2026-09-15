Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BC412BF1
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515354; cv=none; b=eYjAzlu+dwMvYjuj0rkBYUaaZFuapShb8OZbKAwjiHSlojpGW9Xoa6Ulb/BtMoLU415myVXYcKbSexxOf0XupEAGeON+IPe33SWft9wDc67glfQ+yIp4KOF23CpwsmWmRudRlfOuKIJAKqqFYN5+tOUj48hCefTp+clOnK9afXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515354; c=relaxed/simple;
	bh=DOe25ZFJdzYInPWcHjMUKO2pAMMoi0jghg186FqWm5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLj8+854Dgdc+YdGdBJuzA/7t9XOVnGH7WW+l1MxknuZL9rT7gU7dIc6sKOX1lc2fXMV30wKfxLD4M9ySsDmMN2vDZjg1g6FLNRb+Ka2l4b7J7j6aekculC+NuywNbWtkHkbchwY4J/CQfPoH2WdnyOfj/4JYhuliqGSYm4TUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfumb2D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfumb2D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2841F000FF;
	Tue, 15 Sep 2026 23:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515351;
	bh=f2XxGN0js6VKuJjZHjkHV40F5ZzsaI1nP6XMbB8MSnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfumb2D9UcGPasIWeeoXKMtW+UlWPHrfjCmhZgs/2U9Vc4XPPO8ynRY+0n1azSQ6z
	 nBedwZhNmN845Lr/qXJF3dNtEYlN4XHpwNptKtkFm3SY7GjyLIaTZmo2/8c4JWqulm
	 HMa/FMgsBgrU+smDFjYj4KBpLMRG0aHryByhYJ3HVMvVi+miNeRokxV0XtcqSh7+Xx
	 JUR+TVVYmOKPurrX657IbIcdX/OUHTRtG4n3ziEggEvpffwqh+4ULDEnWkglkBgvNS
	 1hDAOwCJH/DeOGmYjXEy9jDDlLtnFs7Ow2NnAWUMM4GP3qH8LiWgMRxQbPYxyS39Nr
	 et6KUEiEsKHrg==
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
Subject: [PATCH v4 09/58] objtool/klp: Document the klp test harness
Date: Tue, 15 Sep 2026 16:34:05 -0700
Message-ID: <20260915233454.2405019-10-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915233454.2405019-1-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two documents, for two different readers.

klp-test-design.txt is for someone deciding whether to trust the suite or
change it: what makes unit tests possible for a pipeline that normally
needs two kernel builds (objtool has no configuration-dependent logic, so a
test reproduces a configuration by reproducing its input), how tests are
selected per architecture, and what the outcome classification is for.

klp-write-tests.txt is the procedure for adding one, and is written to be
handed to someone -- or something -- with the instruction "follow this and
write a test for commit <sha>", or "port the case at <location> from
another harness".  It leads with the rule that matters: a test is not
finished until you have watched it fail with the code broken.  Then the
traps, each of which this suite has already fallen into -- a fixture the
compiler optimised away, a named char[] which never reaches the string path
because that keys on SHF_STRINGS, per-function sections hiding the movement
a test was about.

Some of this was previously written as comments in lib.sh.  That was the
wrong place: guidance on how to write a test is read once by an author,
while every comment in the harness is read by everyone who opens it.
Explanations of why the code is as it is stay where they were.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/Documentation/klp-test-design.txt | 272 ++++++++++++++++++
 .../objtool/Documentation/klp-write-tests.txt | 266 +++++++++++++++++
 2 files changed, 538 insertions(+)
 create mode 100644 tools/objtool/Documentation/klp-test-design.txt
 create mode 100644 tools/objtool/Documentation/klp-write-tests.txt

diff --git a/tools/objtool/Documentation/klp-test-design.txt b/tools/objtool/Documentation/klp-test-design.txt
new file mode 100644
index 000000000000..ec56bfbc2c93
--- /dev/null
+++ b/tools/objtool/Documentation/klp-test-design.txt
@@ -0,0 +1,272 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Design of the objtool klp test harness
+======================================
+
+tools/objtool/tests/ holds unit tests for the klp subcommands of
+objtool -- ``klp checksum``, ``klp diff``, ``klp post-link`` and
+``--klp-symids`` -- which together turn two builds of the kernel into a
+livepatch module.
+
+This document explains how the harness is built and why.  For the rules to
+follow when adding a test, see klp-write-tests.txt.
+
+
+TL;DR
+=====
+
+One run covers one compiler and one architecture; CI runs the combinations.
+Build objtool first -- it needs libelf and libxxhash -- and the same ARCH is
+used for both steps.
+
+Natively, with gcc::
+
+    make -C tools/objtool
+    make -C tools/objtool tests
+
+Natively, with clang -- LLVM=1 additionally selects the LLVM binutils::
+
+    CC=clang make -C tools/objtool tests
+    LLVM=1 make -C tools/objtool tests
+
+Cross, with gcc -- an arm64 host running the x86 tests::
+
+    ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- make -C tools/objtool
+    ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- make -C tools/objtool tests
+
+Cross, with clang.  It defaults to the host triple however it is invoked, so
+--target= is what makes it emit x86; OBJCOPY is needed because BFD's is
+usually built for the host's target alone::
+
+    ARCH=x86_64 make -C tools/objtool
+    ARCH=x86_64 CC="clang --target=x86_64-linux-gnu" OBJCOPY=llvm-objcopy \
+            make -C tools/objtool tests
+
+A run ends with a totals line; anything other than fail:0 is a real result::
+
+    # pass:48 fail:0 static-skip:1 probe-skip:0 xfail:0 xpass:0
+
+Useful extras::
+
+    tools/objtool/tests/run-tests.sh basic          # one test, by name
+    tools/objtool/tests/run-tests.sh --keep basic   # and keep what it built
+
+
+Why unit tests are possible at all
+==================================
+
+klp-build is a pipeline: build the kernel twice, checksum both, diff them,
+link the result.  Testing that end to end means two kernel builds per case,
+which is too slow to run often and too heavy to keep in the tree.
+
+Three properties make a much cheaper test possible.
+
+**objtool has no configuration-dependent logic.**  It never reads ``.config``.
+Every ``CONFIG_`` string in its source is a comment or one error message, and
+its only build-time conditionals are driven by host libraries and the target
+architecture.  Configuration reaches objtool through exactly two channels: the
+``objtool-args-$(CONFIG_*)`` lines in scripts/Makefile.lib, and the
+contents of the object handed to it.
+
+**The klp subcommands use none of the first channel.**  Of objtool's options
+they consult three -- ``checksum``, ``debug_checksum``, ``dryrun`` -- all from
+their own command line.  So klp behaviour varies with configuration *only*
+through the input object.
+
+**Therefore a test can reproduce any configuration's behaviour by reproducing
+its input.**  Compile a small freestanding fixture with the flags that
+configuration would have used, and objtool cannot tell the difference.  No
+kernel, no ``.config``, no object cache.
+
+The whole suite runs in a few seconds.
+
+
+Shape of a test
+===============
+
+Each test compiles one fixture twice -- once plain, once with ``-DPATCHED`` --
+runs ``klp checksum`` over both, diffs them, and asserts on properties of the
+output object::
+
+    . "$(dirname "$0")/../lib.sh"
+
+    setup
+    build_pair basic.c
+
+    assert_input_symbol changed
+    run_diff
+
+    assert_patched changed
+    assert_not_patched untouched
+
+    pass "changed function cloned, unchanged function left alone"
+
+Assertions check properties, never recorded output.  Codegen varies between
+compilers and versions, so a golden file would report churn rather than
+regressions.
+
+
+Layout
+======
+
+::
+
+    tools/objtool/tests/
+        lib.sh              the harness: everything a test may call
+        run-tests.sh        selects, runs and classifies
+        generic/
+            test-*.sh
+            fixtures/*.c
+        x86/
+            test-*.sh
+            fixtures/*.c
+
+Which architecture a test is for is expressed by where it lives.  The runner
+executes ``generic/`` plus the directory matching this architecture, so a test
+which cannot apply is not run rather than running in order to report that it
+did not.  There is no ``x86_only`` helper, and no lookup letting an
+architecture fixture shadow a generic one: an architecture-specific test
+carries its own fixtures.
+
+Compilers cannot be expressed the same way, because CI varies ``CC`` over the
+same tree.  A compiler requirement stays a declaration inside the test
+(``gcc_only``, ``clang_only``).
+
+
+The environment is established once
+===================================
+
+Sourcing lib.sh runs ``klp_preflight``, which checks that objtool
+exists and has klp support, that ``$CC`` works, that the binutils are present,
+and which architecture this is.  The answers are exported, so:
+
+* ``run-tests.sh`` sources lib.sh too, and therefore knows the
+  architecture before it chooses which tests to run;
+* each test inherits the answers rather than repeating the work;
+* a test run on its own establishes them for itself.
+
+Preflight answers only whether the suite can run at all.  A suite which cannot
+run must not exit 0 looking like one which passed, so a missing objtool fails
+the whole run with a TAP ``Bail out!`` rather than skipping each test in turn.
+What a *particular* compiler can do is a different question, left to the test
+which cares.
+
+
+Outcomes
+========
+
+Output is TAP.  The distinction the harness cares most about is between kinds
+of skip, because a skip is how a suite quietly stops testing anything:
+
+``declared``
+    The test said in advance it does not apply -- ``gcc_only`` on a clang run.
+    Expected indefinitely.
+
+``probe``
+    The construct did not turn up in the built object this time.  Weaker: one
+    which becomes permanent is a fixture that has stopped testing anything.
+
+``undeclared``
+    Counted as a **failure**.  A test which gives up for a reason it never
+    declared is a hole, not an outcome.
+
+``xfail``/``xpass`` come with them, so a known failure is reported rather than
+commented out, and one which starts passing says so instead of going quietly
+green.
+
+The runner classifies the TAP result line, not everything a test printed:
+objtool warns on stderr and that output is captured, so a stray line ahead of
+the result would otherwise leave the exit status to decide -- and an expected
+failure exits 0.
+
+A run ends with a totals line::
+
+    # pass:48 fail:0 static-skip:1 probe-skip:0 xfail:0 xpass:0
+
+and reports what it left out::
+
+    # not run: 5 tests in x86/ (this run is arm64)
+
+
+Working directories
+===================
+
+A run gets one directory; each test gets a subdirectory of it, mirroring the
+source layout::
+
+    /tmp/klp-tests.XXXXXXXX/
+        generic/test-basic/{orig.o,patched.o,out.o,Module.symvers,...}
+        x86/test-kcfi/...
+
+``--keep`` leaves it and reports the one path.  Otherwise each test removes its
+own directory and the runner ``rmdir``s the run's -- which fails if anything
+was left behind, so a test which dies without cleaning up is reported rather
+than silently leaking.
+
+
+Running
+=======
+
+::
+
+    make -C tools/objtool                 # needs libelf and libxxhash
+    make -C tools/objtool tests
+
+    CC=clang make -C tools/objtool tests  # the other toolchain
+    LLVM=1 make -C tools/objtool tests    # and its binutils too
+
+    tools/objtool/tests/run-tests.sh --keep basic   # one test, keep its objects
+
+A run covers one compiler and one architecture; CI runs the combinations.
+
+Cross-compiled runs
+-------------------
+
+objtool klp is built only where ARCH_HAS_KLP is set, which today means x86 --
+so an arm64 machine cannot run any of this natively.  It can run all of it
+cross, because objtool is a host tool that only reads and rewrites ELF, and
+the tests only compile fixtures and inspect the objects.  Nothing has to
+execute target code.
+
+::
+
+    ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- make -C tools/objtool
+    ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- make -C tools/objtool tests
+
+objtool itself stays a native binary: it is built with HOSTCC, not CC, so
+setting a cross compiler cannot produce one the host is unable to run.  ARCH
+selects both the objtool target and the directory of tests to run.
+
+clang needs telling, since it defaults to the host triple however it is
+invoked.  The fixtures include no kernel headers, so no sysroot is needed:
+
+::
+
+    ARCH=x86_64 CC="clang --target=x86_64-linux-gnu" \
+            OBJCOPY=llvm-objcopy make -C tools/objtool tests
+
+CROSS_COMPILE picks the binutils, and each can be overridden on its own.
+readelf reads any target and rarely needs overriding; BFD's objcopy is usually
+built for the host's alone, hence OBJCOPY=llvm-objcopy above, or install
+binutils-multiarch.
+
+Either readelf will do.  The assertions read readelf's output, and the two
+spell some of it differently -- GNU prints "OS [0xff20]" for SHN_LIVEPATCH
+where llvm-readelf prints "OS[0xff20]" -- so they accept both.
+
+Getting this wrong is easy and the harness refuses rather than producing a
+misleading result.  "CC=clang ARCH=x86_64" alone selects the x86 tests and
+then builds arm64 objects; preflight compiles a probe object, hands it to
+objtool, and stops the run if they disagree about the architecture, or if
+ARCH does not match what the compiler emits.
+
+
+What this does not cover
+========================
+
+These are unit tests for objtool's klp subcommands.  They do not build a
+kernel, do not run scripts/livepatch/klp-build, and do not load a
+livepatch.  Behaviour which only appears when the kernel applies a patch --
+the module loader refusing a relocation, late module patching ordering -- has
+to be tested by booting, and is out of scope here.
diff --git a/tools/objtool/Documentation/klp-write-tests.txt b/tools/objtool/Documentation/klp-write-tests.txt
new file mode 100644
index 000000000000..eb2cacaf5720
--- /dev/null
+++ b/tools/objtool/Documentation/klp-write-tests.txt
@@ -0,0 +1,266 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Writing a test for objtool's klp code
+=====================================
+
+Instructions for adding a test to tools/objtool/tests/.  Read
+klp-test-design.txt first if you need to know how the harness works; this
+document is the procedure and the rules.
+
+Two kinds of request bring you here:
+
+* *"write a test for commit <sha>"* -- a fix went in without one.
+* *"port the test at <location>, written against another harness"* -- a case
+  exists elsewhere and should live in tree.
+
+Both follow the same procedure.
+
+
+The one rule that matters
+=========================
+
+**A test is not finished until you have watched it fail.**
+
+Break the thing it guards -- revert the fix, or sabotage the exact line -- and
+confirm the test fails.  Then restore and confirm it passes.  A test that has
+never failed is not known to test anything, and this suite has produced
+several that passed against deliberately broken code:
+
+* an alternatives fixture whose empty entry pointed at its own end label rather
+  than the neighbour's replacement, so the bug it guarded made no difference;
+* a sympos fixture where symbol-table order and address order agreed, so
+  counting and reading the linked image gave the same answer;
+* a string fixture using a named ``char[]``, which never reached the
+  contents-hashing path because that keys on ``SHF_STRINGS``;
+* a static array the compiler proved constant, folded to zero, and emitted no
+  relocation for -- so the two builds were byte-identical.
+
+Every one looked correct.  Say in the commit message how you verified, and if
+you could not isolate the behaviour to a single line, **say that too** rather
+than implying otherwise.
+
+
+Procedure
+=========
+
+1. **Read the fix.**  What input reaches the broken line?  What is observable
+   in the output object when it misbehaves -- a missing section, a relocation
+   naming the wrong symbol, an unchanged checksum, a rejected build?  If
+   nothing is observable, stop and say so; see `When to give up`_.
+
+2. **Decide where it lives.**  ``generic/`` unless the fixture needs
+   architecture-specific assembly or the behaviour is architecture-specific,
+   in which case ``x86/`` (or a new directory named for the architecture).
+
+3. **Write the fixture** in the same directory's ``fixtures/``.  Reuse an
+   existing one if it already produces the shape; add a ``-D`` knob rather
+   than copying a fixture to change one line.
+
+4. **Write the test.**  Assert the *premise* before the result -- see
+   `State the premise`_.
+
+5. **Verify by breaking the code.**  Then restore.
+
+6. **Run the whole suite under both compilers**::
+
+       make -C tools/objtool tests
+       CC=clang make -C tools/objtool tests
+
+7. **Commit** the test and its fixture together, alone.  One test per commit.
+
+
+Writing the fixture
+===================
+
+Fixtures are freestanding C.  No kernel headers -- write out the kernel
+structure by hand if you need one, as the existing special-section fixtures do.
+
+Every fixture needs a ``.modinfo`` name, because klp diff reads the object's
+module name from it::
+
+    static const char __modinfo[]
+        __attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+Use ``MODNAME`` if the test needs to vary it.  Note that most fixtures hardcode
+``vmlinux``: passing ``-DMODNAME`` to one that does silently does nothing and
+the test quietly becomes a vmlinux test.
+
+The patched build is selected with ``-DPATCHED``.  For a fixture with several
+variants, gate each on both, so the original is always the baseline::
+
+    #if defined(PATCHED) && defined(WHICH_CALL)
+        r = callee_b(x);
+    #else
+        r = callee_a(x);
+    #endif
+
+and select one per build: ``build_pair foo.c -DWHICH_CALL``.  Without the
+``defined(PATCHED)`` the flag applies to *both* builds and nothing differs.
+
+Traps that have bitten before
+-----------------------------
+
+* **The compiler optimises your fixture away.**  A static never written is
+  proved constant, its reads folded, and no relocation emitted.  Add a writer
+  the compiler cannot see through.
+* **String literals versus named arrays.**  The contents-hashing path keys on
+  ``SHF_STRINGS``, which the compiler sets on the mergeable section a *literal*
+  lands in, not on a ``char[]`` given a section of its own.
+* **Per-function sections hide movement.**  With the default
+  ``-ffunction-sections`` every function sits at offset 0 of its own section,
+  so nothing ever moves.  A test about position needs
+  ``build_pair foo.c -fno-function-sections``.
+* **Special sections need boundaries.**  Either an entsize on the section or an
+  ``ANNOTATE_DATA_SPECIAL`` annotation, or klp diff reports "missing special
+  section entsize or annotations".  Their targets need real (global) symbols,
+  or it reports "failed to convert reloc sym".
+* **Prefer letting objtool generate what objtool generates.**
+  ``.static_call_sites``, ``.mcount_loc``, ``.ibt_endbr_seal`` and ORC come
+  from its check pass.  Call ``run_objtool_check --mcount`` and let it build
+  them; a hand-written copy tests your reading of the format, not the format.
+
+  Write one by hand only when the test needs a shape objtool will not produce,
+  and say so in the fixture.  generic/fixtures/static_call.c does: objtool
+  emits the site but not the ``ANNOTATE_DATA_SPECIAL`` that describes its
+  boundaries -- those come from the kernel's macros -- so a fixture which has
+  to vary whether the annotation is there writes both itself.
+
+
+Writing the test
+================
+
+Start from the shortest existing test, generic/test-basic.sh.
+
+State the premise
+-----------------
+
+A test which asserts only on the output passes when the compiler never emitted
+the construct in the first place, and reads as coverage it does not have.  Say
+what the input must contain::
+
+    assert_input_section __jump_table     # the fixture must produce it -> fail
+    require_input_section .kcfi_traps     # this compiler may not      -> skip
+
+Prefer ``assert_*``.  Reach for ``require_*`` only where absence genuinely
+depends on compiler version or flags, and follow it with something
+unconditional so the test can never be entirely vacuous.
+
+Where a test would otherwise duplicate a sibling, assert what makes it
+different.  ``test-jump-label-module-static-key`` checks that the key really is
+reached through its section symbol -- without that it is a second copy of
+``test-jump-label-module-key``.
+
+Assert both directions
+----------------------
+
+Check that the right thing happened *and* that the wrong thing did not.  A klp
+diff which clones everything is as wrong as one which clones nothing::
+
+    assert_patched changed
+    assert_not_patched untouched
+
+Skips
+-----
+
+* ``gcc_only``/``clang_only`` -- a settled fact about the compiler.  Declared,
+  so it reads as expected forever.
+* ``probe_skip`` -- this toolchain did not produce the construct.  Include what
+  to do about it if there is anything::
+
+      probe_skip "no matching clang/lld pair for a ThinLTO link; set THIN_CC and THIN_LD to one"
+
+* A bare ``skip`` is **counted as a failure**.  Never use it.
+
+Standing in for a kernel configuration
+--------------------------------------
+
+``FIXTURE_CFLAGS`` is what a fixture is built with.  Since objtool reads no
+``.config``, changing these flags is how a test covers a configuration without
+building a kernel.  Two ways:
+
+* trailing arguments to ``build_pair``/``build_one``, which win, and cover
+  anything expressible as a negation::
+
+      build_pair foo.c -fno-function-sections
+
+* otherwise assign ``FIXTURE_CFLAGS`` before building.
+
+Either way **say in a comment which kernel configuration the change stands in
+for**.  A flag with no stated motive is indistinguishable from a mistake.
+
+
+What the test's comment must say
+================================
+
+The comment at the top is the test's justification.  It should let a reader
+decide, without archaeology, whether a skip or a failure matters.  Include:
+
+* **what breaks** in the running kernel if the behaviour regresses -- not the
+  mechanism, the consequence;
+* **why it is not caught otherwise**, which is usually "nothing fails at build
+  time";
+* **the fix commit** it guards, if there is one;
+* **anything load-bearing about the fixture** that is not obvious, especially
+  anything you got wrong first.
+
+That last point is the one people skip.  If the fixture has to be built without
+per-function sections, or the static must not be named ``__warned``, or the key
+must be file-local -- write it down, or the next person will simplify it away.
+
+
+Porting a test from another harness
+===================================
+
+Read the original's *case*, not its code.  The other harness probably builds a
+real kernel module; here you write freestanding C.  A transliteration will
+usually test something else.
+
+* Work out which objtool behaviour the case exercises, then produce that shape
+  the cheapest way here.
+* Verify by breaking the code, exactly as for a new test -- a port is not
+  correct because the original was.
+* If the original names a fix commit, cite it.
+* Credit the source in the commit message with the trailers the original
+  carried, followed by your own.
+
+Sometimes the port shows the case is already covered, and sometimes it shows
+the case cannot be reproduced here.  Both are results; report them rather than
+committing something that passes vacuously.
+
+
+When to give up
+===============
+
+Some behaviour cannot be reached from a compiled fixture.  Say so, with what
+you tried, instead of committing a test that passes either way.  Examples that
+were genuinely abandoned:
+
+* a memory leak -- needs valgrind, not an assertion on ELF;
+* ``mkstemp`` with long paths, and other I/O edge cases;
+* a NULL dereference reachable only through a debug path;
+* changes made redundant by a fallback: removing the code changes no output
+  because something else already handles the case;
+* a fix whose code has since been rewritten, so there is nothing left to
+  revert.
+
+Also stop when the behaviour depends on something outside the fixture's
+control -- an ELF library's handling of empty sections, or a compiler version's
+naming of anonymous data.  A test which passes for you and skips for everyone
+else is worse than none.
+
+
+Checklist
+=========
+
+Before committing:
+
+* the test fails with the code broken, and passes with it fixed
+* the whole suite passes under **both** gcc and clang
+* the premise is asserted, not assumed
+* both directions are asserted where that applies
+* no bare ``skip``
+* the fixture is in the same directory as the test
+* the comment names the consequence, the fix commit, and anything load-bearing
+* the commit contains one test and its fixtures, and nothing else
+* the commit message says how you verified it
-- 
2.53.0-Meta

