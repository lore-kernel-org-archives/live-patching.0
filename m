Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406725771;
	Sat, 17 Oct 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196694; cv=none; b=eSH1Ujg1seuiuLe9WDGvEbjyuznvwW/I2JkUi1t99bwAMNnQ6ZQQqYuCf9ZkwzvEHt3EKBnZPyxpV2nBVnTG2MpYxSPzQsVSJKA3YkZdlGcwjT+auJK60nQ3schpiKMlLVXTRU2In/Mu4ATtcPDzQGhgHLKH+Q8+0uKJi0qNjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196694; c=relaxed/simple;
	bh=cXh+xs+HdDqOv3n+nvKj9KF/7Eodt7vi6enImy4iu8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0d0eVxETujm7UM6ZsxTTCWyfgHUN4lc0/aGRN38t1VkDqmI58LYaJW5WW5dtioiX8SNAKObU9jhpCz6mydTig4pANQ/xlCS3m6noWyfYIlIC1hMtlhOlBiqM0UNg/2t1TB0eiO0R3BTA3K4bdGMdP9+TcxiiKTzPqXkyYRZB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShFbYJe0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShFbYJe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C801F000C4;
	Sat, 17 Oct 2026 00:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196692;
	bh=4kP6GL7vpods1gzmZkHEB5I4pZqTfwlpnmQ6t1byPqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShFbYJe0+tGCe0Mta2Aa9wdA3ZOw9MdjNGzW8H3NnQadPapVgKDltB6tqHaTbjcU2
	 QkFID+cogTSbOmQN14hAL68C4ZwCjybdDQ/Z12qaLtTkvqmaBCNGEch9brwFnDvLDx
	 L5++IIJQlMCjtLMwMXFwwIEbyKkx4kGmSjT4Wo9/KbP8cSuRAlBuPEaVIYzKdmOw3U
	 ltsDNcrABfFPdxT7fLyGTuyJ7x4vl2bmD9Mvh68JD22kDs/KLUDTnhg7nzH9F/Ods0
	 AUM/a3bCf9eQoVles9kpmiFR/kGW8ZyV+SkfTvU0krojMPswRDxv85CXj3q202/6xv
	 y/XN2N7GxVmUw==
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
Subject: [PATCH 01/11] klp-build: Fix dependent patches in a series
Date: Fri, 16 Oct 2026 17:24:31 -0700
Message-ID: <20261017002441.716615-2-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017002441.716615-1-song@kernel.org>
References: <20261017002441.716615-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix_patches() refreshes each patch on its own against the original
source: it applies the patch, copies the patched files, and reverts it.
If a later patch in the series depends on an earlier one, it doesn't
apply to the original source, and klp-build fails even though
validate_patches(), which applies the patches in order, accepted the
series:

  $ ./scripts/livepatch/klp-build 0001-dummy.patch 0002-Revert-dummy.patch
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Reversed (or previously applied) patch detected!  Assume -R? [n]
  Apply anyway? [n]
  1 out of 1 hunk ignored
  error: klp-build: .../klp-tmp/tmp.patch did not apply

Refreshing each patch on top of the previous ones wouldn't work either.
fix-patch-lines adds #line directives to each fixed patch, so the next
patch's context wouldn't match.  The #line numbers in later patches
would also refer to the intermediate source rather than the original
source, which defeats the purpose of preserving __LINE__.

Instead, apply all the patches in order and diff the result against the
original source to get a single combined patch, then run fix-patch-lines
on that.  If the patches have no net effect, fail early with "no changes
detected" instead of building the patched kernel for nothing.

Fixes: 24ebfcd65a87 ("livepatch/klp-build: Introduce klp-build script for generating livepatch modules")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 scripts/livepatch/klp-build | 93 +++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..6cdc36e97c21 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -467,60 +467,75 @@ do_init() {
 	set_kernelversion
 }
 
-# Refresh the patch hunk headers, specifically the line numbers and counts.
-refresh_patch() {
-	local patch="$1"
+# Combine the patches into a single patch against the original source, with
+# refreshed hunk headers.  The patches may depend on each other, so they can't
+# be refreshed individually.
+combine_patches() {
+	local outfile="$1"
 	local tmpdir="$PATCH_TMP_DIR"
-	local input_files=()
-	local output_files=()
+	local files=()
+	local patch
+	local file
 
 	rm -rf "$tmpdir"
-	mkdir -p "$tmpdir/a"
-	mkdir -p "$tmpdir/b"
+	mkdir -p "$tmpdir"
 
-	# Get all source files affected by the patch
-	get_patch_input_files "$patch" | mapfile -t input_files
-	get_patch_output_files "$patch" | mapfile -t output_files
+	# Get all source files affected by the patches
+	for patch in "${PATCHES[@]}"; do
+		get_patch_files "$patch"
+	done | sort -u | mapfile -t files
 
-	# Copy orig source files to 'a'
-	echo "${input_files[@]}" | xargs cp --parents --target-directory="$tmpdir/a"
+	# Copy orig source files to $tmpdir
+	for file in "${files[@]}"; do
+		if [[ -e "$file" ]]; then
+			cp --parents "$file" "$tmpdir"
+		fi
+	done
 
-	# Copy patched source files to 'b'
-	apply_patch "$patch" "--silent"
-	echo "${output_files[@]}" | xargs cp --parents --target-directory="$tmpdir/b"
-	revert_patch "$patch"
+	# Diff the orig source files against the patched ones in place to make a
+	# clean patch.  Use /dev/null for created and deleted files.
+	: > "$outfile"
+	apply_patches "--silent"
+	for file in "${files[@]}"; do
+		local old="$tmpdir/$file"
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
 
-	# Diff 'a' and 'b' to make a clean patch
-	( cd "$tmpdir" && diff -Nupr a b > "$patch" ) || true
+		diff -up --label "$old_label" --label "$new_label" "$old" "$new" >> "$outfile" || status=$?
+		if (( status > 1 )); then
+			die "diff failed for $file"
+		fi
+	done
+	revert_patches
 }
 
-# Copy the patches to a temporary directory, fix their lines so as not to
-# affect the __LINE__ macro for otherwise unchanged functions further down the
-# file, and update $PATCHES to point to the fixed patches.
+# Combine the patches into a single patch, fix its lines so as not to affect
+# the __LINE__ macro for otherwise unchanged functions further down the file,
+# and update $PATCHES to point to the fixed patch.
 fix_patches() {
-	local idx
-	local i
+	local tmp_patch="$TMP_DIR/tmp.patch"
+	local new_patch="$TMP_DIR/fixed.patch"
 
 	rm -f "$TMP_DIR"/*.patch
 
-	idx=0001
-	for i in "${!PATCHES[@]}"; do
-		local old_patch="${PATCHES[$i]}"
-		local tmp_patch="$TMP_DIR/tmp.patch"
-		local patch="${PATCHES[$i]}"
-		local new_patch
-
-		new_patch="$TMP_DIR/$idx-fixed-$(basename "$patch")"
+	combine_patches "$tmp_patch"
+	[[ ! -s "$tmp_patch" ]] && die "no changes detected"
 
-		cp -f "$old_patch" "$tmp_patch"
-		refresh_patch "$tmp_patch"
-		"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$new_patch"
+	"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$new_patch"
+	PATCHES=("$new_patch")
 
-		PATCHES[i]="$new_patch"
-
-		rm -f "$tmp_patch"
-		idx=$(printf "%04d" $(( 10#$idx + 1 )))
-	done
+	rm -f "$tmp_patch"
 }
 
 clean_kernel() {
-- 
2.53.0-Meta

