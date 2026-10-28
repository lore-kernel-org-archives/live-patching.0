Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223956;
	b=xE3U2LQwmaNIWP9YQTaneFJzwFGg3CuV/jF83hJEmZc+KbD3gM4UhVy+dXcph7SE0jgF
	 r8GkTfqL/1blyRRSw33y5IUhLPmW5P9S1/3EuIIzAyUV4nNPshmiik0a0sh59d8n+W3DN
	 sb7L4QVvV59XIAN/Bq3DsMTWgsYbaMEgxrR/aoFu5usFdNpZ+nvKA9gnqYLu5WmW1mWl8
	 TBJHMhT0kTo6xUsXE0AbXIdvePKBJ2JS+xOtws5c/55c7xvEZTtZvyUjO4055DIrKj4YZ
	 YHO1CkOhf92K0DUeaWFJgX5EBAHQzmcnWoSO6EffkUWr1D6C6EPWrYFoJAAz/M+IU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223956;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YAbn4dvCu87n0aa1FEFyjcum/Lb2ReCuEuqZQps46ko=;
	b=Iw9ZZEXgTiF6fUgrpFYI9lL3gkIH1+fpx6YsLrw0FuSrCf0cOAEhwT+Kh/MxvxU0dm9q
	 +AJOB6qO7nmtTx7HK85hsHPebXrPzdD5XlWNAbI/Hs87POyy+VpVrkyAJ+itY60jyz3O/
	 Bh/KLf7ocvAIAVr7kDt8XwMckbUWN+FPNKP32r2AuxXELP0YQskFQn0ga27T1ezvbuTai
	 BXdVgRpaz3OiGMdJB3AHRzM+IpRlsLwy5I7nj9Y8A734yCHOUHG7EhD42PJVaa7BENMwD
	 1awkEXnJVB65geFbpZbn+sYIFm5Cw5xKTPb98G9s+smu1XrDD5UBf3swmJ6MdrwClmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GN/x7MyD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD436606A33F;
	Wed, 28 Oct 2026 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GN/x7MyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3491F01825;
	Wed, 28 Oct 2026 21:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223955;
	bh=YAbn4dvCu87n0aa1FEFyjcum/Lb2ReCuEuqZQps46ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GN/x7MyDx1UWoB89CZRp446w06wsQKNkoiQI9YXOE+EGxbw2jeOjujqTvD3DAEQHU
	 6aifxfwG/bt2GD+QgKEbxhyl7MviOkHsEswBwbiDRNBtm2rvXy7nfqpH7i8ADtsNnr
	 aKumfaMisaL27aIZpkyvaO/aoYoOhn+sQ07766j0g+SAz4GKxn3NXd+3gzXxj3glUh
	 UOr/wXhdDLNmHLyMY+bBydtDIMXCfbt4qEsj34M3twZEnMyRlW6oinCEerjlR866ii
	 pgg2WiD0QNHkeIfanBslW6T8EY8uxDVREKaMvbXP6CpusmWeXtEMMyeyrdlvoIw8Rs
	 huHyBsgmCG/yQ==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 03/12] klp-build: Move patch processing to klp-prepare-patch
Date: Wed, 28 Oct 2026 14:45:25 -0700
Message-ID: <20261028214534.1919398-4-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028214534.1919398-1-song@kernel.org>
References: <20261028214534.1919398-1-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp-build's patch processing doesn't need a kernel build, but the only
way to run it is through klp-build, which builds the kernel twice.  That
makes it hard to test.

Move it into a new script, klp-prepare-patch, so that tests can run it
directly.  It validates the patches, combines them into a single patch
against the source tree in the current directory, adds #line directives
and prints the result.  klp-build runs it and builds the patched kernel
with its output.

klp-prepare-patch doesn't need a configured kernel tree, and it uses its
own temporary directory, so it leaves klp-tmp alone.  The intermediate
patch without #line directives, which klp-build left in klp-tmp, now
goes away with that directory.

klp-build still applies and reverts the combined patch, so a little of
the patch handling is duplicated between the two scripts.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 scripts/livepatch/Makefile          |   3 +-
 scripts/livepatch/klp-build         | 106 +----------
 scripts/livepatch/klp-prepare-patch | 277 ++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+), 99 deletions(-)
 create mode 100755 scripts/livepatch/klp-prepare-patch

diff --git a/scripts/livepatch/Makefile b/scripts/livepatch/Makefile
index 17b590213740..d77ef3de7d9a 100644
--- a/scripts/livepatch/Makefile
+++ b/scripts/livepatch/Makefile
@@ -4,7 +4,8 @@
 SHELLCHECK := $(shell which shellcheck 2> /dev/null)
 
 SRCS := \
-  klp-build
+  klp-build \
+  klp-prepare-patch
 
 .DEFAULT_GOAL := help
 .PHONY: help
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 28c3bf6b6418..4796b36b5cc8 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -31,7 +31,7 @@ KEEP_TMP=1
 
 SCRIPT="$(basename "$0")"
 SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
-FIX_PATCH_LINES="$SCRIPT_DIR/fix-patch-lines"
+PREPARE_PATCH="$SCRIPT_DIR/klp-prepare-patch"
 
 OBJTOOL="$PWD/tools/objtool/objtool"
 CONFIG="$PWD/.config"
@@ -46,7 +46,6 @@ KMOD_DIR="$TMP_DIR/5-kmod"
 
 STASH_DIR="$TMP_DIR/stash"
 TIMESTAMP="$TMP_DIR/timestamp"
-PATCH_TMP_DIR="$TMP_DIR/tmp"
 COMBINED_PATCH="$TMP_DIR/combined.patch"
 
 KLP_DIFF_LOG="$DIFF_DIR/diff.log"
@@ -329,34 +328,6 @@ set_kernelversion() {
 	sed -i "2i echo $kernelrelease; exit 0" scripts/setlocalversion
 }
 
-get_patch_files() {
-	local patch="$1"
-
-	grep0 -E '^(---|\+\+\+) ' "$patch"				\
-		| grep0 -v -e '/dev/null' -e '1969-12-31' -e '1970-01-01' \
-		| gawk '{print $2}'				\
-		| sed 's|^[^/]*/||'				\
-		| sort -u
-}
-
-check_unsupported_patches() {
-	local patch
-
-	for patch in "${PATCHES[@]}"; do
-		local files=()
-
-		get_patch_files "$patch" | mapfile -t files
-
-		for file in "${files[@]}"; do
-			case "$file" in
-				lib/*|*/vdso/*|*/realmode/rm/*|*.S)
-					die "${patch}: unsupported patch to $file"
-					;;
-			esac
-		done
-	done
-}
-
 apply_patch() {
 	local patch="$1"
 	shift
@@ -394,14 +365,6 @@ revert_patch() {
 	APPLIED_PATCHES=("${tmp[@]}")
 }
 
-apply_patches() {
-	local patch
-
-	for patch in "${PATCHES[@]}"; do
-		apply_patch "$patch"
-	done
-}
-
 revert_patches() {
 	local patches=("${APPLIED_PATCHES[@]}")
 
@@ -436,78 +399,25 @@ do_init() {
 
 	APPLIED_PATCHES=()
 
-	[[ -x "$FIX_PATCH_LINES" ]] || die "can't find fix-patch-lines"
-	command -v recountdiff &>/dev/null || die "recountdiff not found (install patchutils)"
+	[[ -x "$PREPARE_PATCH" ]] || die "can't find klp-prepare-patch"
 
 	validate_config
 	set_module_name
 	set_kernelversion
 }
 
-# Combine the patches into a single patch against the original source.  The
-# patches may depend on each other, so they can't be diffed individually.
-combine_patches() {
-	local outfile="$1"
-	local tmpdir="$PATCH_TMP_DIR"
-	local files=()
-	local patch
-	local file
-
-	rm -rf "$tmpdir"
-	mkdir -p "$tmpdir"
-
-	# Get all source files affected by the patches
-	for patch in "${PATCHES[@]}"; do
-		get_patch_files "$patch"
-	done | sort -u | mapfile -t files
-
-	# Copy orig source files to $tmpdir
-	for file in "${files[@]}"; do
-		if [[ -e "$file" ]]; then
-			cp --parents "$file" "$tmpdir"
-		fi
-	done
-
-	# Diff the orig source files against the patched ones in place to make a
-	# clean patch.  Use /dev/null for created and deleted files.
-	: > "$outfile"
-	apply_patches
-	for file in "${files[@]}"; do
-		local old="$tmpdir/$file"
-		local new="$file"
-		local old_label="a/$file"
-		local new_label="b/$file"
-		local status=0
-
-		if [[ ! -e "$old" ]]; then
-			old=/dev/null
-			old_label=/dev/null
-		fi
-		if [[ ! -e "$new" ]]; then
-			new=/dev/null
-			new_label=/dev/null
-		fi
-
-		diff -up --label "$old_label" --label "$new_label" "$old" "$new" \
-			>> "$outfile" || status=$?
-		if (( status > 1 )); then
-			die "diff failed for $file"
-		fi
-	done
-	revert_patches
-}
-
 # Validate the patches, combine them into $COMBINED_PATCH, and fix its lines so
 # as not to affect the __LINE__ macro for otherwise unchanged functions further
 # down the file.
 process_patches() {
-	local tmp_patch="$TMP_DIR/tmp.patch"
+	local cmd=()
 
-	check_unsupported_patches
-	combine_patches "$tmp_patch"
-	[[ ! -s "$tmp_patch" ]] && die "no changes detected"
+	cmd=("$PREPARE_PATCH")
+	[[ -v VERBOSE ]] && cmd+=("--verbose")
+	cmd+=("--")
+	cmd+=("${PATCHES[@]}")
 
-	"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$COMBINED_PATCH"
+	"${cmd[@]}" > "$COMBINED_PATCH" || die "klp-prepare-patch failed"
 }
 
 clean_kernel() {
diff --git a/scripts/livepatch/klp-prepare-patch b/scripts/livepatch/klp-prepare-patch
new file mode 100755
index 000000000000..f6f8524f7088
--- /dev/null
+++ b/scripts/livepatch/klp-prepare-patch
@@ -0,0 +1,277 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Validate the patches given to klp-build and combine them into a single patch
+
+if (( BASH_VERSINFO[0]  < 4 || \
+     (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4) )); then
+	echo "error: this script requires bash 4.4+" >&2
+	exit 1
+fi
+
+set -o errtrace
+set -o pipefail
+set -o nounset
+
+# Allow doing 'cmd | mapfile -t array' instead of 'mapfile -t array < <(cmd)'.
+# This helps keep execution in pipes so pipefail+ERR trap can catch errors.
+shopt -s lastpipe
+
+unset TMP_DIR VERBOSE
+
+SCRIPT="$(basename "$0")"
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+FIX_PATCH_LINES="$SCRIPT_DIR/fix-patch-lines"
+
+APPLIED_PATCHES=()
+
+grep0() {
+	# shellcheck disable=SC2317
+	command grep "$@" || true
+}
+
+# Because pipefail is enabled, the grep0 helper should be used instead of
+# grep, otherwise a failed match can propagate to an error.
+grep() {
+	echo "error: $SCRIPT: use grep0 or 'command grep' instead of bare grep" >&2
+	exit 1
+}
+
+warn() {
+	echo "warning: $SCRIPT: $*" >&2
+}
+
+die() {
+	echo "error: $SCRIPT: $*" >&2
+	exit 1
+}
+
+cleanup() {
+	set +o nounset
+	revert_patches
+	[[ -v TMP_DIR ]] && rm -rf "$TMP_DIR"
+	return 0
+}
+
+trap_err() {
+	die "line ${BASH_LINENO[0]}: '$BASH_COMMAND'"
+}
+
+trap cleanup  EXIT INT TERM HUP
+trap trap_err ERR
+
+usage() {
+	cat <<EOF >&2
+Usage: $SCRIPT [OPTIONS] PATCH_FILE(s)
+Validate patches and combine them into a single patch for klp-build.
+
+The patches are applied in order to the source tree in the current directory,
+and reverted afterwards.  The combined patch is printed to stdout, with #line
+directives added so that the patch doesn't change the line numbers of the code
+after the changed lines.
+
+Options:
+   -v, --verbose		Show the details of patches which apply with fuzz
+
+EOF
+}
+
+process_args() {
+	local short
+	local long
+	local args
+	local patch
+
+	short="hv"
+	long="help,verbose"
+
+	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
+		echo; usage; exit 1
+	}
+	eval set -- "$args"
+
+	while true; do
+		case "$1" in
+			-h | --help)
+				usage
+				exit 0
+				;;
+			-v | --verbose)
+				VERBOSE=1
+				shift
+				;;
+			--)
+				shift
+				break
+				;;
+			*)
+				usage
+				exit 1
+				;;
+		esac
+	done
+
+	if [[ $# -eq 0 ]]; then
+		usage
+		exit 1
+	fi
+
+	PATCHES=("$@")
+
+	for patch in "${PATCHES[@]}"; do
+		[[ -f "$patch" ]] || die "$patch doesn't exist"
+	done
+}
+
+do_init() {
+	[[ -x "$FIX_PATCH_LINES" ]] || die "can't find fix-patch-lines"
+	command -v recountdiff &>/dev/null || die "recountdiff not found (install patchutils)"
+
+	TMP_DIR="$(mktemp -d)"
+}
+
+get_patch_files() {
+	local patch="$1"
+
+	grep0 -E '^(---|\+\+\+) ' "$patch"				\
+		| grep0 -v -e '/dev/null' -e '1969-12-31' -e '1970-01-01' \
+		| gawk '{print $2}'				\
+		| sed 's|^[^/]*/||'				\
+		| sort -u
+}
+
+check_unsupported_patches() {
+	local patch
+
+	for patch in "${PATCHES[@]}"; do
+		local files=()
+
+		get_patch_files "$patch" | mapfile -t files
+
+		for file in "${files[@]}"; do
+			case "$file" in
+				lib/*|*/vdso/*|*/realmode/rm/*|*.S)
+					die "${patch}: unsupported patch to $file"
+					;;
+			esac
+		done
+	done
+}
+
+apply_patch() {
+	local patch="$1"
+	local drift_regex="with fuzz|offset [0-9]+ line"
+	local output
+	local status
+
+	status=0
+	output=$(patch -p1 --dry-run --no-backup-if-mismatch -r /dev/null < "$patch" 2>&1) || status=$?
+	if [[ "$status" -ne 0 ]]; then
+		echo "$output" >&2
+		die "$patch did not apply"
+	elif [[ "$output" =~ $drift_regex ]]; then
+		[[ -v VERBOSE ]] && echo "$output" >&2
+		warn "${patch} applied with fuzz"
+	fi
+
+	APPLIED_PATCHES+=("$patch")
+	patch -p1 --no-backup-if-mismatch -r /dev/null --silent < "$patch"
+}
+
+revert_patch() {
+	local patch="$1"
+	local tmp=()
+
+	patch -p1 -R --force --no-backup-if-mismatch -r /dev/null &> /dev/null < "$patch" || true
+
+	for p in "${APPLIED_PATCHES[@]}"; do
+		[[ "$p" == "$patch" ]] && continue
+		tmp+=("$p")
+	done
+
+	APPLIED_PATCHES=("${tmp[@]}")
+}
+
+apply_patches() {
+	local patch
+
+	for patch in "${PATCHES[@]}"; do
+		apply_patch "$patch"
+	done
+}
+
+revert_patches() {
+	local patches=("${APPLIED_PATCHES[@]}")
+
+	for (( i=${#patches[@]}-1 ; i>=0 ; i-- )) ; do
+		revert_patch "${patches[$i]}"
+	done
+
+	APPLIED_PATCHES=()
+}
+
+# Combine the patches into a single patch against the original source.  The
+# patches may depend on each other, so they can't be diffed individually.
+combine_patches() {
+	local outfile="$1"
+	local orig_dir="$TMP_DIR/orig"
+	local files=()
+	local patch
+	local file
+
+	mkdir -p "$orig_dir"
+
+	# Get all source files affected by the patches
+	for patch in "${PATCHES[@]}"; do
+		get_patch_files "$patch"
+	done | sort -u | mapfile -t files
+
+	# Copy orig source files to $orig_dir
+	for file in "${files[@]}"; do
+		if [[ -e "$file" ]]; then
+			cp --parents "$file" "$orig_dir"
+		fi
+	done
+
+	# Diff the orig source files against the patched ones in place to make a
+	# clean patch.  Use /dev/null for created and deleted files.
+	: > "$outfile"
+	apply_patches
+	for file in "${files[@]}"; do
+		local old="$orig_dir/$file"
+		local new="$file"
+		local old_label="a/$file"
+		local new_label="b/$file"
+		local status=0
+
+		if [[ ! -e "$old" ]]; then
+			old=/dev/null
+			old_label=/dev/null
+		fi
+		if [[ ! -e "$new" ]]; then
+			new=/dev/null
+			new_label=/dev/null
+		fi
+
+		diff -up --label "$old_label" --label "$new_label" "$old" "$new" \
+			>> "$outfile" || status=$?
+		if (( status > 1 )); then
+			die "diff failed for $file"
+		fi
+	done
+	revert_patches
+}
+
+
+################################################################################
+
+process_args "$@"
+do_init
+
+check_unsupported_patches
+combine_patches "$TMP_DIR/combined.patch"
+[[ ! -s "$TMP_DIR/combined.patch" ]] && die "no changes detected"
+
+# Fix the patch lines so as not to affect the __LINE__ macro for otherwise
+# unchanged functions further down the file.
+"$FIX_PATCH_LINES" "$TMP_DIR/combined.patch" | recountdiff
-- 
2.53.0-Meta

