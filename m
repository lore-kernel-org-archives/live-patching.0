Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0C4A9D5B
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152256; cv=none; b=Qj1f5REZWHi/1Q6O66V1rbqKgCm2DM5RlLGOTcdaZeU2NtEAwiyoFJIVHKFJDpo7/jevjkuDhwm5BWUoc24wcBGsBpPi9ZvGimmX0RIFGGUv5CVkS0E7g47uOm0+YhHSJ3+YrZGhq4JW2tTSlQ7ga5tvNNyoeV2PofNddSgokuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152256; c=relaxed/simple;
	bh=O//iJO/pj9jLWGQpqeIOjY9556UnF8jNFD2yyJih8VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVnV29tP1Q3CzFTTnhxy9zBIIlEnuwp2bNWvwZ/52yfGvT24gBDMH2wntouHukikMVsP9OwWp4+SYeXFw6GXSZjw3xfmsUZ/lFWgcYFTB+w8/WhaoI2VA+ugfun0UlFc+CKdFVrfLv+IZvjzfcQITutJudnUsVAPLWG3t7tTUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8nUj+4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8nUj+4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210771F00893;
	Fri, 11 Sep 2026 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152253;
	bh=IJtC5RdKBpJGUzCeRwZ/cantI7ThDsynLsakNhS3mxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8nUj+4LNu7KdIMSC4c6y5B4C51aL0VkLOAAmtdCkc/ZK/zCLL5YX62JPpHPAmZpA
	 w3VP+NVlqY5aygEMwVDOMw3o8BIJFDertnRviYxcvtpWM98WYXQHfnqIcvhb0Jd5Lq
	 FoeTWZdmYo1PDqn2uBr7+X7Jxi6T1SAqiZwC2/S6e4qu7hWJUuW/QIfxibYvB3vgpf
	 aB8mTRfGHGMzRmUxT0J+AkK9PgEjoDhMq3ZSh88y7eXEoKqkkv21Mp6dRfnMY7YE3U
	 gg+9Xx33Xt962Dac1t2W8F2UWMjD9fMx/Z86nlKoqRtYY/6hySgAuPPdBMqg60C+95
	 C3KY9fQSbPB3g==
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
Subject: [PATCH 07/58] objtool/klp: Give each run one working directory, one per test inside it
Date: Fri, 11 Sep 2026 11:42:14 -0700
Message-ID: <20260911184305.1457308-8-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each test made its own mktemp directory, so a run scattered them through
/tmp among everything else using the same names, and there was no way to
inspect what a failing test built -- the objects are gone the moment it
exits, which is right every time but the one that matters.

Give the run one directory and each test a subdirectory of it, named for
the test and nested the way the source is:

  /tmp/klp-tests.3zC6oyfd/
    generic/test-basic/{orig.o,patched.o,out.o,Module.symvers,...}
    x86/test-kcfi/...

--keep then reports one path instead of forty, and removing it is one
command.  A test run by hand still falls back to a temp directory of its
own, and still says where that went.

Detecting a leak comes free.  Cleanup is now "remove each test's directory,
then rmdir the run's", and the rmdir fails if anything is left -- so a test
which dies without running its own cleanup is reported rather than quietly
leaving something behind.

preflight names the directory the tests build under, since mktemp honours
TMPDIR and a run in a container is otherwise silent about where its work
went.  The runner says what to do only when it is relevant: on a failure
without --keep, that the option exists; with it, how many directories are
waiting.  Usage text is not read while something is broken.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/tests/lib.sh       | 23 ++++++++++++++++++-----
 tools/objtool/tests/run-tests.sh | 26 ++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index a4d126e6c9cb..08788510e722 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -120,6 +120,7 @@ klp_preflight()
 #   objtool   $OBJTOOL (klp: yes)
 #   compiler  $cc_version
 #   arch      $KLP_TEST_ARCH$([ "$arch" = "$host" ] || echo "  (host $host, cross)")
+#   tmpdir    ${TMPDIR:-/tmp}  (each test builds in a fresh directory here)
 EOF
 }
 
@@ -179,15 +180,27 @@ xpass()
 	exit 1
 }
 
-cleanup() { [ -n "$workdir" ] && rm -rf "$workdir"; }
+cleanup()
+{
+	[ -n "$workdir" ] || return 0
+
+	if [ -n "${KLP_TEST_KEEP:-}" ]; then
+		[ -n "${KLP_TEST_WORKDIR:-}" ] || echo "# kept $workdir"
+		return 0
+	fi
+
+	rm -rf "$workdir"
+}
 
 # setup [exported symbol...]
 setup()
 {
-	# The environment was checked once when this file was sourced, so there
-	# is nothing to verify here: objtool exists at the resolved path, has
-	# klp support, and $CC works.
-	workdir="$(mktemp -d)" || fail "mktemp failed"
+	if [ -n "${KLP_TEST_WORKDIR:-}" ]; then
+		workdir="$KLP_TEST_WORKDIR"
+		mkdir -p "$workdir" || fail "cannot create $workdir"
+	else
+		workdir="$(mktemp -d)" || fail "mktemp failed"
+	fi
 	trap cleanup EXIT
 
 	export_syms "$@"
diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-tests.sh
index 6b937fc7f5bd..e6f1ac1b5d0d 100755
--- a/tools/objtool/tests/run-tests.sh
+++ b/tools/objtool/tests/run-tests.sh
@@ -23,13 +23,17 @@ export LC_ALL=C
 usage()
 {
 	cat <<EOF
-usage: $(basename "$0") [test...]
+usage: $(basename "$0") [-k|--keep] [test...]
 
 Run the objtool klp tests for this architecture: everything in generic/, plus
 everything in the directory named for it.  With no arguments, runs all of them.
 A test may be named with or without its "test-" prefix and ".sh" suffix, and is
 looked for in both directories.
 
+Options:
+    -k, --keep    do not delete each test's working directory; print its path,
+                  so the objects a failing test built can be looked at
+
 Environment:
     OBJTOOL       objtool binary to test (default ../objtool)
     CC            compiler used to build fixtures (default gcc)
@@ -45,6 +49,7 @@ cd "$(dirname "$0")" || exit 1
 while [ $# -gt 0 ]; do
 	case "$1" in
 	-h|--help)	usage ;;
+	-k|--keep)	export KLP_TEST_KEEP=1; shift ;;
 	--)		shift; break ;;
 	-*)		echo "unknown option: $1" >&2; usage 1 ;;
 	*)		break ;;
@@ -98,12 +103,18 @@ else
 	done
 fi
 
+# One directory for the whole run, one per test inside it, mirroring the
+# source layout.  A run then leaves a single thing behind instead of 39
+# scattered among everything else using mktemp.
+rundir="$(mktemp -d "${TMPDIR:-/tmp}/klp-tests.XXXXXXXX")" ||
+	{ echo "Bail out! cannot create a working directory" >&2; exit 1; }
+
 echo "1..${#tests[@]}"
 
 pass=0 fail=0 static_skip=0 probe_skip=0 xfail=0 xpass=0
 
 for t in "${tests[@]}"; do
-	out="$(./"$t" 2>&1)"
+	out="$(KLP_TEST_WORKDIR="$rundir/${t%.sh}" ./"$t" 2>&1)"
 	rc=$?
 
 	# A test prints one result line, but it is not necessarily the only
@@ -156,4 +167,15 @@ done
 echo "# pass:$pass fail:$fail static-skip:$static_skip" \
      "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
 
+# A failure is the one time the objects matter, and by default they are
+# already gone.  Say so then rather than in the usage text nobody reads while
+# something is broken.
+if [ -n "${KLP_TEST_KEEP:-}" ]; then
+	echo "# working directories kept in $rundir -- inspect, then rm -rf it"
+elif ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
+	echo "# $rundir was not empty; a test did not clean up after itself"
+elif [ "$fail" != 0 ] || [ "$xpass" != 0 ]; then
+	echo "# re-run with --keep to hold on to what a failing test built"
+fi
+
 [ "$fail" = 0 ] && [ "$xpass" = 0 ]
-- 
2.53.0-Meta

