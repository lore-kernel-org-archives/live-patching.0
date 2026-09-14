Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A333A9DA
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367169; cv=none; b=mxhxqYh7pKJ9X39Kx7Y/lw4kSw7JwDSVxouqYxGs633RP2ooeLmJdhCiuiQasyvdhg7QyEjS9/NGZLRsNOLPUwZouc2CG+UE+if4vM02HjMqLCkvTaO57aSBV82iiA5//xv6+9VIf2YfcoA5HifFFwckFRXgoY+7390tsTWt4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367169; c=relaxed/simple;
	bh=yZumVnBiDhXIacX5agFjfk+88Byrw4aVzdkM3ckW4iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+zzFs1EZpfSKsW1WSktemPoxXEIbuSjaP18nkF0QW17BbJg7HipkAcZu9Aqz5xQfhrakC0cfGc0bNa4wg+hlb8QuHdVeuPGCuQrB+tLhTPjYSzvD7C2aJACXJndJKc+YIAVSu/7g9AWBQimtrvVfi6Iw8NrdRIzTuyq+DFY/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZIn3LCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZIn3LCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D5D1F000FF;
	Mon, 14 Sep 2026 06:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367167;
	bh=79ZpUCwlkyYnS4hvAuZrCMYKvlsHjjWFxx7RLUG5oDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZIn3LCaJhrO9jrz8utGXUTMwxqL31Zg0kPEv6nX/lEMLKqPDuw7PRqOThoHwCFa9
	 xcnfgLhbB7oU7KrKX3C32f5XjyWmR7xHYUKtRTYnFy6vqyL3vQ4xpXknDPV7Ph8wIx
	 RButh5trkbc/04RgcadNMgyjpiXNJ+JyVRA66JrEEYZ0iT4gu3J5fooW5/kJT4ogd4
	 wHvBwn8AGJkMelG5at6jRhpXcOwh83XeGmEb41Cm17Dx8f3NX55Fl6ePiYZCf5EDVX
	 RoXQvMwdnfmt4rs3EOuMCYAm6aR7w4nfW92qZVxQf20NfCZUWUzQVhl2MC6IcTHW2w
	 uc8eGub1qLN2A==
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
Subject: [PATCH v2 07/58] objtool/klp: Give each run one working directory, one per test inside it
Date: Sun, 13 Sep 2026 23:24:23 -0700
Message-ID: <20260914062514.926997-8-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914062514.926997-1-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
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
index 40fe74082158..7b8b5b2f0c92 100644
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

