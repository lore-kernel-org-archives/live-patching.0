Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40085368953
	for <live-patching@vger.kernel.org>; Tue, 10 Mar 2026 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175089; cv=none; b=Ktvs0QlvEMs0mqlbFm2uGEOwRnpJz6Z992C+Lhw2k3MJHQ9lpeZcHCz5i4JuZAWdoPSycAPAbwBOBktP55bOoXq37iUArwRDQfcduxxn6sKSqUL4GZNMyAXhxmtYFRAdywMyVDPYkeW8LCoUHqsi1CLZCw39/ZSUMJVUkd2bdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175089; c=relaxed/simple;
	bh=7fF3M5YFeUGGhbu2T6quOuzHb9yJX3NYs/c5SdQ2Rg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=R6hEm6HnPho0dcWSSgaJd8RS2ORJvRwRTMbzgaWPx0k7F91zZkJguwSpwrNSspsvHI/FK61F06Q6zJeDhP0KkE2Kal0a4B6T3Wldwc9GYTOU9/GtT7Ixu3I+eLO3dtG23SgehL9kA64Sm+ao1LvoFkGjZTQogfds8a0WWhnWEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isG2sgYy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isG2sgYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773175087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTnXD/Kf1mAXNPGAB8rXnKa9lcIQYCqQRMji/6sCDhI=;
	b=isG2sgYyqkvLpjK4paUT1WYIYOj0xEqc/Qco7xL0lE5f0fRIT6aD74hoJwXR3JH9pfsewy
	AYx6f8tER3+DkeH//YHm7jKiWzDwl1qxQHT7sdhxPC5zYBG8XFyZx9imRwQVSxpY/CRlKH
	/BPDsXNqh210n8nbCXv1AasG1WoiZWA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-h7Jk75RBOQeE5rkRDVEUuA-1; Tue,
 10 Mar 2026 16:38:03 -0400
X-MC-Unique: h7Jk75RBOQeE5rkRDVEUuA-1
X-Mimecast-MFC-AGG-ID: h7Jk75RBOQeE5rkRDVEUuA_1773175082
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91E271956080;
	Tue, 10 Mar 2026 20:38:02 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7610019560A6;
	Tue, 10 Mar 2026 20:38:01 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 04/12] livepatch/klp-build: switch to GNU patch and recountdiff
Date: Tue, 10 Mar 2026 16:37:43 -0400
Message-ID: <20260310203751.1479229-5-joe.lawrence@redhat.com>
In-Reply-To: <20260310203751.1479229-1-joe.lawrence@redhat.com>
References: <20260310203751.1479229-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The klp-build script is currently very strict with input patches,
requiring them to apply cleanly via `git apply --recount`.  This
prevents the use of patches with minor contextual fuzz relative to the
target kernel sources.

To allow users to reuse a patch across similar kernel streams, switch to
using GNU patch and patchutils for intermediate patch manipulation.
Update the logic for applying, reverting, and regenerating patches:

- Use 'patch -p1' for better handling of context fuzz.
- Use 'recountdiff' to update line counts after FIX_PATCH_LINES.
- Drop git_refresh() and related git-specific logic.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 59 ++++++++-----------------------------
 1 file changed, 13 insertions(+), 46 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 94ed3b4a91d8..564985a1588a 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -95,7 +95,7 @@ restore_files() {
 
 cleanup() {
 	set +o nounset
-	revert_patches "--recount"
+	revert_patches
 	restore_files
 	[[ "$KEEP_TMP" -eq 0 ]] && rm -rf "$TMP_DIR"
 	return 0
@@ -282,7 +282,7 @@ set_module_name() {
 }
 
 # Hardcode the value printed by the localversion script to prevent patch
-# application from appending it with '+' due to a dirty git working tree.
+# application from appending it with '+' due to a dirty working tree.
 set_kernelversion() {
 	local file="$SRC/scripts/setlocalversion"
 	local localversion
@@ -300,8 +300,8 @@ get_patch_input_files() {
 	local patch="$1"
 
 	grep0 -E '^--- ' "$patch"				\
+		| grep0 -v -e '/dev/null' -e '1969-12-31' -e '1970-01-01' \
 		| gawk '{print $2}'				\
-		| grep0 -v '^/dev/null$'			\
 		| sed 's|^[^/]*/||'				\
 		| sort -u
 }
@@ -310,8 +310,8 @@ get_patch_output_files() {
 	local patch="$1"
 
 	grep0 -E '^\+\+\+ ' "$patch"				\
+		| grep0 -v -e '/dev/null' -e '1969-12-31' -e '1970-01-01' \
 		| gawk '{print $2}'				\
-		| grep0 -v '^/dev/null$'			\
 		| sed 's|^[^/]*/||'				\
 		| sort -u
 }
@@ -323,21 +323,6 @@ get_patch_files() {
 		| sort -u
 }
 
-# Make sure git re-stats the changed files
-git_refresh() {
-	local patch="$1"
-	local files=()
-
-	[[ ! -e "$SRC/.git" ]] && return
-
-	get_patch_input_files "$patch" | mapfile -t files
-
-	(
-		cd "$SRC"
-		git update-index -q --refresh -- "${files[@]}"
-	)
-}
-
 check_unsupported_patches() {
 	local patch
 
@@ -358,36 +343,19 @@ check_unsupported_patches() {
 
 apply_patch() {
 	local patch="$1"
-	shift
-	local extra_args=("$@")
 
 	[[ ! -f "$patch" ]] && die "$patch doesn't exist"
-
-	(
-		cd "$SRC"
-
-		# The sed strips the version signature from 'git format-patch',
-		# otherwise 'git apply --recount' warns.
-		sed -n '/^-- /q;p' "$patch" |
-			git apply "${extra_args[@]}"
-	)
+	patch -d "$SRC" -p1 --dry-run --silent --no-backup-if-mismatch -r /dev/null < "$patch"
+	patch -d "$SRC" -p1 --silent --no-backup-if-mismatch -r /dev/null < "$patch"
 
 	APPLIED_PATCHES+=("$patch")
 }
 
 revert_patch() {
 	local patch="$1"
-	shift
-	local extra_args=("$@")
 	local tmp=()
 
-	(
-		cd "$SRC"
-
-		sed -n '/^-- /q;p' "$patch" |
-			git apply --reverse "${extra_args[@]}"
-	)
-	git_refresh "$patch"
+	patch -d "$SRC" -p1 -R --silent --no-backup-if-mismatch -r /dev/null < "$patch"
 
 	for p in "${APPLIED_PATCHES[@]}"; do
 		[[ "$p" == "$patch" ]] && continue
@@ -406,11 +374,10 @@ apply_patches() {
 }
 
 revert_patches() {
-	local extra_args=("$@")
 	local patches=("${APPLIED_PATCHES[@]}")
 
 	for (( i=${#patches[@]}-1 ; i>=0 ; i-- )) ; do
-		revert_patch "${patches[$i]}" "${extra_args[@]}"
+		revert_patch "${patches[$i]}"
 	done
 
 	APPLIED_PATCHES=()
@@ -434,6 +401,7 @@ do_init() {
 	APPLIED_PATCHES=()
 
 	[[ -x "$FIX_PATCH_LINES" ]] || die "can't find fix-patch-lines"
+	command -v recountdiff &>/dev/null || die "recountdiff not found (install patchutils)"
 
 	validate_config
 	set_module_name
@@ -459,12 +427,12 @@ refresh_patch() {
 	( cd "$SRC" && echo "${input_files[@]}" | xargs cp --parents --target-directory="$tmpdir/a" )
 
 	# Copy patched source files to 'b'
-	apply_patch "$patch" --recount
+	apply_patch "$patch"
 	( cd "$SRC" && echo "${output_files[@]}" | xargs cp --parents --target-directory="$tmpdir/b" )
-	revert_patch "$patch" --recount
+	revert_patch "$patch"
 
 	# Diff 'a' and 'b' to make a clean patch
-	( cd "$tmpdir" && git diff --no-index --no-prefix a b > "$patch" ) || true
+	( cd "$tmpdir" && diff -Nupr a b > "$patch" ) || true
 }
 
 # Copy the patches to a temporary directory, fix their lines so as not to
@@ -487,8 +455,7 @@ fix_patches() {
 
 		cp -f "$old_patch" "$tmp_patch"
 		refresh_patch "$tmp_patch"
-		"$FIX_PATCH_LINES" "$tmp_patch" > "$new_patch"
-		refresh_patch "$new_patch"
+		"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$new_patch"
 
 		PATCHES[i]="$new_patch"
 
-- 
2.53.0

