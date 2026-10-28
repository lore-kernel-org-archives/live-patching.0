Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223946;
	b=1JxopRyaHKp39ark2UbODralVB4WTgsFmVgJ2lmWCLYe/TBk87T3fSKZSokvp03Twss0
	 UEbKhRwVnkOavo7LLaPr4EY7yTqoDw+ECoD6V9zcYTcxVedIPXojksGXoWMIYbPjPrHDR
	 nUgX29eqftHqfr0R1+g4UGKgozlDUW9NPPhu3JPqLBvOK8zbtChd76h7+JRmvxs3ZF8aH
	 4pUNgWRx0YPX0UI1ROLO0+7W7OMvWwN4Clhie0er+kmGMfrLbViKlZOOKn98o+4R8c9h+
	 NFP2sggrtzBlKn2y4lYmrXG95hR8IyfNQtC0/E7MuMbIs3fOW8qVg3uk+ARJnbT2nRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6GToEjftXbxvyrbPZoYZfrJVlzg5mD3U4+9lqA0Do0c=;
	b=QIdvi6ap0UhG/vY0dvnxXglw+EXgagJ9C+oM8EKUFkoijI+8AdpaMh+SGiWU4c7WCfaq
	 XpQRegQcYkbJ1/lQiMTlTDjLR/oGLZkZdBugONvh/KGCdejkPeyVj9BeLXX3t68xlXvPi
	 yLN/9YLHOZym8A8ZzcX6+bYIsdCDAjhPla843cLpdNz+zR+M+IubMUiMsvAZ+AS6ksYrw
	 w6D4Ph5i5YsQy6IHHVqeicN+Br1XNcN1xOZ1yVkkul1zNqwcPX3U17jvIl15veVeEzYY8
	 H4lo8dC5d9grVFxgszNtG8LM8i+MqeORWCsPaimUmAz/W6097PX4e/WUTYNbUfntZLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lx7AVlUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48371606A325;
	Wed, 28 Oct 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lx7AVlUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76811F031E3;
	Wed, 28 Oct 2026 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223945;
	bh=6GToEjftXbxvyrbPZoYZfrJVlzg5mD3U4+9lqA0Do0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lx7AVlUf2b9Q5c9PyAu33KTSSv3xFhnoeq7ak2PrGw62pOshq+V1k6WY6i0KPhJHs
	 ZgYHYmZw6KydqDPi9uZFdKIjYzsmW8/Sg22PQH4/rqeYLe+k6H+jJ40zQyLRZ9YeDz
	 YQzDxYPSA3uHHGxQUnmfPUJE0GTfgCUJzbVz+hCDt+LSQNoAdrd9go6mhtffz+ESUW
	 RplwfMbH+8wDWIshWR7/qKM0HbQjIxQIjMLTGpjpM5XSNwOpEUODN9SvjZ2lXY6b0+
	 BhKtQ+bvgZuSW8m3QNqrVq5dHnk69WOkU/84eFQtE6T9jwMHlyBH6dWhMshG4109vY
	 F2W6IA7A08A1w==
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
Subject: [PATCH v2 01/12] klp-build: Fix dependent patches in a series
Date: Wed, 28 Oct 2026 14:45:23 -0700
Message-ID: <20261028214534.1919398-2-song@kernel.org>
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
on that.  If the patches have no net effect, fail with "no changes
detected" instead of building the patched kernel for nothing.

The combined patch gets its own variable, $COMBINED_PATCH, instead of
replacing the patches in $PATCHES, and fix_patches() becomes
process_patches(), as it no longer fixes the patches it is given.  The
intermediate patch without #line directives is left in klp-tmp for
debugging.  get_patch_files() is now the only user of
get_patch_input_files() and get_patch_output_files(), so fold them into
it.

Fixes: 24ebfcd65a87 ("livepatch/klp-build: Introduce klp-build script for generating livepatch modules")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 scripts/livepatch/klp-build | 121 +++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 64 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..a0bfc40093f9 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -47,6 +47,7 @@ KMOD_DIR="$TMP_DIR/5-kmod"
 STASH_DIR="$TMP_DIR/stash"
 TIMESTAMP="$TMP_DIR/timestamp"
 PATCH_TMP_DIR="$TMP_DIR/tmp"
+COMBINED_PATCH="$TMP_DIR/combined.patch"
 
 KLP_DIFF_LOG="$DIFF_DIR/diff.log"
 
@@ -328,33 +329,16 @@ set_kernelversion() {
 	sed -i "2i echo $kernelrelease; exit 0" scripts/setlocalversion
 }
 
-get_patch_input_files() {
-	local patch="$1"
-
-	grep0 -E '^--- ' "$patch"				\
-		| grep0 -v -e '/dev/null' -e '1969-12-31' -e '1970-01-01' \
-		| gawk '{print $2}'				\
-		| sed 's|^[^/]*/||'				\
-		| sort -u
-}
-
-get_patch_output_files() {
+get_patch_files() {
 	local patch="$1"
 
-	grep0 -E '^\+\+\+ ' "$patch"				\
+	grep0 -E '^(---|\+\+\+) ' "$patch"				\
 		| grep0 -v -e '/dev/null' -e '1969-12-31' -e '1970-01-01' \
 		| gawk '{print $2}'				\
 		| sed 's|^[^/]*/||'				\
 		| sort -u
 }
 
-get_patch_files() {
-	local patch="$1"
-
-	{ get_patch_input_files "$patch"; get_patch_output_files "$patch"; } \
-		| sort -u
-}
-
 check_unsupported_patches() {
 	local patch
 
@@ -467,60 +451,69 @@ do_init() {
 	set_kernelversion
 }
 
-# Refresh the patch hunk headers, specifically the line numbers and counts.
-refresh_patch() {
-	local patch="$1"
+# Combine the patches into a single patch against the original source.  The
+# patches may depend on each other, so they can't be diffed individually.
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
+		diff -up --label "$old_label" --label "$new_label" "$old" "$new" \
+			>> "$outfile" || status=$?
+		if (( status > 1 )); then
+			die "diff failed for $file"
+		fi
+	done
+	revert_patches
 }
 
-# Copy the patches to a temporary directory, fix their lines so as not to
+# Combine the patches into $COMBINED_PATCH, and fix its lines so as not to
 # affect the __LINE__ macro for otherwise unchanged functions further down the
-# file, and update $PATCHES to point to the fixed patches.
-fix_patches() {
-	local idx
-	local i
-
-	rm -f "$TMP_DIR"/*.patch
-
-	idx=0001
-	for i in "${!PATCHES[@]}"; do
-		local old_patch="${PATCHES[$i]}"
-		local tmp_patch="$TMP_DIR/tmp.patch"
-		local patch="${PATCHES[$i]}"
-		local new_patch
+# file.
+process_patches() {
+	local tmp_patch="$TMP_DIR/tmp.patch"
 
-		new_patch="$TMP_DIR/$idx-fixed-$(basename "$patch")"
+	combine_patches "$tmp_patch"
+	[[ ! -s "$tmp_patch" ]] && die "no changes detected"
 
-		cp -f "$old_patch" "$tmp_patch"
-		refresh_patch "$tmp_patch"
-		"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$new_patch"
-
-		PATCHES[i]="$new_patch"
-
-		rm -f "$tmp_patch"
-		idx=$(printf "%04d" $(( 10#$idx + 1 )))
-	done
+	"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$COMBINED_PATCH"
 }
 
 clean_kernel() {
@@ -909,9 +902,9 @@ if (( SHORT_CIRCUIT <= 1 )); then
 fi
 
 if (( SHORT_CIRCUIT <= 2 )); then
-	status "Fixing patch(es)"
-	fix_patches
-	apply_patches "--silent"
+	status "Processing patch(es)"
+	process_patches
+	apply_patch "$COMBINED_PATCH" "--silent"
 	status "Building patched kernel"
 	build_kernel "patched"
 	revert_patches
-- 
2.53.0-Meta

