Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7F2FF675
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427056; cv=none; b=m+JI6Ii4PIJeE/FKzq/f314W3Xm0TQmMrGCwlFR+SQhoreOS3Zg1f0G7Iou6GM1BNveW0GU5tfweSNnf2ZIVXy6hGlmXuNgkhoJrCkUvbg1cu6nIKHjTlBcGIkC43EW3bwFKeQxCz9XadURSMo0FKlq0amjrCkvlNoaVl27ArHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427056; c=relaxed/simple;
	bh=wi/Ai2q21/f+K6g2SYxK4nhouOmaIOh7lBVShfD5ccw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXqxiRW5PJaDPcAOhJ0uECGh+xTzql33B5U/w2UkVu//6BibkO+sZVpEUCuIeCSnGRIJGFWYMN5CazGfFlYH+E/xPI4WreevOcRJCdGIwexsvlGimjVyySHDdT0qru9he4D44bSJO56cu0f0uMFEyf0SIYizPCyltRdrkqxB7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkRzkchG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkRzkchG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4907D1F000FF;
	Mon, 14 Sep 2026 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427055;
	bh=5jcMeWvFD8zfZC+am+0zFQpmH1ENEDvZqVhpI05ONh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RkRzkchGwrvIhtK+5mGtu1t7CKX3kMQa3UYwNsqNcwvR020eXK1e6K3dCZSwWwZW0
	 ncsCK8Ro+Nlt+Em9JhLDcSSdkDbMUaZ40+0HGTkAhIaHfhgfvdYprX37CCQ/tsXE1M
	 +M8+x1ODYugN8UCLhfh5QRwAYL4C8oP4N6QzMXr/AaEdkRVzXY7wDl9s9lYBoqAzSQ
	 p8R27z204PB+BeomhLuGEk4Tjxw7QlL+DAMbv5SCiCIdk7qhwcpYZN74Sr26w5T5PG
	 biOxolZHa/yDv1rChgH3bt66/gtxdblK+RrwiQbFN6v4SwLldrDOHpjJSqK3kPppXq
	 gsOr1zS/eIRFQ==
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
Subject: [PATCH v3 03/58] objtool/klp: Group the klp tests by architecture
Date: Mon, 14 Sep 2026 16:03:00 -0700
Message-ID: <20260914230355.3422996-4-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230355.3422996-1-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Which architecture a test is for is expressed by where it lives: tests are
in generic/ or in a directory named for their architecture, each carrying
its own fixtures, and the runner executes generic/ plus the one that
matches.  A test which cannot apply here is then not run at all, rather
than running in order to announce that it did not.

Layout does this better than a declaration would.  There is no x86_only(),
and no lookup letting a fixtures/<arch>/ file shadow a generic one of the
same name -- an arch-specific test simply carries its own fixtures.

Compilers cannot work the same way: CI varies CC over the same tree, so a
compiler requirement stays a declaration in the test.

What a run leaves out is reported once:

  # not run: 5 tests in x86/ (this run is arm64)

Silence would have been cheaper and wrong.  A run covering less than the
tree holds must not look like a run that covered all of it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/{ => generic}/fixtures/basic.c      |  0
 .../objtool/tests/{ => generic}/test-basic.sh |  2 +-
 tools/objtool/tests/lib.sh                    | 27 ++++++++++++--
 tools/objtool/tests/run-tests.sh              | 36 ++++++++++++++++---
 4 files changed, 56 insertions(+), 9 deletions(-)
 rename tools/objtool/tests/{ => generic}/fixtures/basic.c (100%)
 rename tools/objtool/tests/{ => generic}/test-basic.sh (91%)

diff --git a/tools/objtool/tests/fixtures/basic.c b/tools/objtool/tests/generic/fixtures/basic.c
similarity index 100%
rename from tools/objtool/tests/fixtures/basic.c
rename to tools/objtool/tests/generic/fixtures/basic.c
diff --git a/tools/objtool/tests/test-basic.sh b/tools/objtool/tests/generic/test-basic.sh
similarity index 91%
rename from tools/objtool/tests/test-basic.sh
rename to tools/objtool/tests/generic/test-basic.sh
index 6b769962399a..562edfbc8646 100755
--- a/tools/objtool/tests/test-basic.sh
+++ b/tools/objtool/tests/generic/test-basic.sh
@@ -3,7 +3,7 @@
 #
 # Only functions whose code changed get cloned into the patch.
 
-. "$(dirname "$0")/lib.sh"
+. "$(dirname "$0")/../lib.sh"
 
 setup
 build_pair basic.c
diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 97b484ac5dc3..e6bc5307d44c 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -9,7 +9,10 @@
 # of regressions.
 
 TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
-FIXTURES_DIR="$TESTS_DIR/fixtures"
+
+# Tests live in generic/ or in an architecture directory beside it, and each
+# carries its own fixtures.
+FIXTURES_DIR="$(cd "$(dirname "$0")/fixtures" 2>/dev/null && pwd)"
 
 # The kernel's convention: CROSS_COMPILE is the one knob, with per-tool
 # overrides for what it does not cover.  objtool itself is always a host binary
@@ -36,7 +39,7 @@ OBJTOOL="${OBJTOOL:-$TESTS_DIR/../objtool}"
 #
 klp_preflight()
 {
-	local tmp tool cc_version host cc_arch
+	local tmp tool cc_version arch host cc_arch
 
 	bail() { echo "Bail out! $*" >&2; exit 1; }
 
@@ -92,8 +95,26 @@ klp_preflight()
 	esac
 	rm -rf "$tmp"
 
+	# Normalize to the kernel's SRCARCH.
+	case "${ARCH:-$(uname -m)}" in
+	x86_64|i?86)	arch=x86 ;;
+	aarch64*)	arch=arm64 ;;
+	*)		arch="${ARCH:-$(uname -m)}" ;;
+	esac
+
+	case "$(uname -m)" in
+	x86_64|i?86)	host=x86 ;;
+	aarch64*)	host=arm64 ;;
+	*)		host="$(uname -m)" ;;
+	esac
+
+	[ -z "$cc_arch" ] || [ "$cc_arch" = "$arch" ] ||
+		bail "ARCH says $arch but '$CC' builds $cc_arch objects;" \
+		     "the $arch tests would run against the wrong architecture"
+
+	KLP_TEST_ARCH="$arch"
 	KLP_TEST_PREFLIGHT=done
-	export OBJTOOL CC KLP_TEST_PREFLIGHT
+	export OBJTOOL CC KLP_TEST_ARCH KLP_TEST_PREFLIGHT
 
 	cc_version="$($CC --version 2>/dev/null | head -1)"
 	cat <<EOF
diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-tests.sh
index f6a3e1b7677e..48728a98d995 100755
--- a/tools/objtool/tests/run-tests.sh
+++ b/tools/objtool/tests/run-tests.sh
@@ -3,6 +3,11 @@
 #
 # Run the objtool klp tests.  Each test-*.sh prints one TAP result line.
 #
+# Tests live in generic/ and in a directory per architecture.  A run executes
+# generic/ plus the one matching this architecture, so a test which cannot
+# apply here is not run rather than reporting a skip; what was left out is
+# reported once, as a comment, so differing coverage is still visible.
+#
 # The harness checks the environment once up front and fails the run if the
 # suite cannot execute, rather than letting every test skip and exit 0.
 
@@ -10,13 +15,34 @@ set -u
 
 cd "$(dirname "$0")" || exit 1
 
-tests=( test-*.sh )
-[ "${tests[0]}" = "test-*.sh" ] && { echo "1..0 # SKIP no tests found"; exit 0; }
-
-# Sourcing the harness runs its preflight, and exports what it found so the
-# tests inherit it rather than working it out again.
+# Sourcing the harness runs its preflight, which decides which architecture
+# this run is for -- so the test list cannot be built before it has, and the
+# tests inherit the answers rather than working them out again.
 . ./lib.sh
 
+dirs=( generic )
+[ -d "$KLP_TEST_ARCH" ] && dirs+=( "$KLP_TEST_ARCH" )
+
+tests=()
+for d in "${dirs[@]}"; do
+	for t in "$d"/test-*.sh; do
+		[ -f "$t" ] && tests+=( "$t" )
+	done
+done
+[ "${#tests[@]}" -gt 0 ] || { echo "1..0 # SKIP no tests found"; exit 0; }
+
+# Tests for another architecture are absent from this run entirely.  Say how
+# many, so a run which covers less than the tree holds does not look like one
+# that covers all of it.
+for d in */; do
+	d="${d%/}"
+	case "$d" in generic|"$KLP_TEST_ARCH") continue ;; esac
+	n=$(ls "$d"/test-*.sh 2>/dev/null | wc -l)
+	[ "$n" -gt 0 ] || continue
+	echo "# not run: $n test$( [ "$n" = 1 ] || echo s ) in $d/" \
+	     "(this run is $KLP_TEST_ARCH)"
+done
+
 echo "1..${#tests[@]}"
 
 rc=0
-- 
2.53.0-Meta

