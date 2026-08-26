Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017512D1F1
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773826; cv=none; b=fFHLLkdxD6HEptivTVHLmaR9/vLspfkfrFD5bAsp3qoumNnpRbmh7XlmnHzdRJiN0RK9e4JLfaXsZAxCqUJ0Fc5Nx8wfzo6HmRQk8X9qG6uEUmuXm5PF+mpxbnPuAgKc6yx4bI0d8A3FkuXBp8dVQo635Mw8KFiyl3DuPbbEI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773826; c=relaxed/simple;
	bh=mQw88AaXmnhXzHokeWbOoXM8Fsooidi4oE7gFV6DNM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=uu7tmavUtBrtgbHkWSXY5NZw6Q6Cp2l7mt+UbBQF/vJ+Lr/TlVPcbfNBsl/NKvFKUwWlqJWvoA8ob/KIB6mQQWgA7gR/P3Zbt27kYkzWo+UgYRLjKffQC1rOoeaRGSMraZ8jVLbq8V6y49Ezj9gXbtGPqD3YtnlPnxN07TuM8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBbDGvWr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBbDGvWr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQPnx5hQuK3mw5cxbMCsY1FeKaXsAsViCj56CZeirQ8=;
	b=FBbDGvWra5pYR0yLfozktOOLlLk34V8hRB7OmkvKc5QFZES0IQODAHOTz0naqjOGzewN0f
	M5KKBvHRay0fiTKPWrJ4OdaJH6Zl8u5diKFjRZ+7ZEwL99dJSh1IhXgIdy4OCW6HNiJJ0V
	03TUOQW5amnGb3OITvmmMTYMC/nHBPU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-FAq8brFDPMOM_B2YiehVzA-1; Wed,
 26 Aug 2026 15:50:11 -0400
X-MC-Unique: FAq8brFDPMOM_B2YiehVzA-1
X-Mimecast-MFC-AGG-ID: FAq8brFDPMOM_B2YiehVzA_1787773809
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B86BA184BA9F;
	Wed, 26 Aug 2026 19:50:09 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE2F13000239;
	Wed, 26 Aug 2026 19:50:08 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 5/7] livepatch/klp-build: add basic out-of-tree module support
Date: Wed, 26 Aug 2026 15:49:58 -0400
Message-ID: <20260826195000.455905-6-joe.lawrence@redhat.com>
In-Reply-To: <20260826195000.455905-1-joe.lawrence@redhat.com>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

klp-build is currently limited to patching in-tree kernel modules.
Introduce a --oot-dir option to enable livepatch generation for basic
out-of-tree (OOT) modules.  This requires the associated kernel tree to
be fully built (Module.symvers must exist).

The OOT workflow is as follows:

  cd /path/to/built-kernel
  ./scripts/livepatch/klp-build --oot-dir /path/to/mymodule my-fix.patch

With this option, klp-build performs two builds (original and patched)
of the OOT module via `make M=...` instead of a full kernel rebuild.
The resulting objects are then processed and diffed to produce the final
livepatch .ko.

Note that --oot-dir drives the build via `make M=`, assuming a simple
Kbuild/Makefile layout.  This is suited for small test modules and bug
reproducers rather than full OOT drivers with complex build systems
(which should use --orig-dir/--patched-dir instead).

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 84 ++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..b60f5a5da31e 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -21,6 +21,7 @@ shopt -s lastpipe
 
 unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
 
+OOT_DIR=""
 REPLACE=1
 SHORT_CIRCUIT=0
 JOBS="$(getconf _NPROCESSORS_ONLN)"
@@ -137,6 +138,7 @@ Options:
 
 Advanced Options:
    -d, --debug			Show symbol/reloc cloning decisions
+       --oot-dir=<DIR>		Out-of-tree module source directory
    -S, --short-circuit=STEP	Start at build step (requires prior --keep-tmp)
 				   1|orig		Build original kernel (default)
 				   2|patched		Build patched kernel
@@ -160,7 +162,7 @@ process_args() {
 	local patch
 
 	short="hfj:o:vdS:T"
-	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	long="help,show-first-changed,jobs:,oot-dir:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
 
 	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -202,6 +204,10 @@ process_args() {
 				keep_tmp=1
 				shift
 				;;
+			--oot-dir)
+				OOT_DIR="$2"
+				shift 2
+				;;
 			-S | --short-circuit)
 				[[ ! -d "$TMP_DIR" ]] && die "--short-circuit requires preserved klp-tmp dir"
 				keep_tmp=1
@@ -364,11 +370,21 @@ check_unsupported_patches() {
 		get_patch_files "$patch" | mapfile -t files
 
 		for file in "${files[@]}"; do
+			# In and out-of-tree paths to reject
 			case "$file" in
-				lib/*|*/vdso/*|*/realmode/rm/*|*.S)
+				*.S)
 					die "${patch}: unsupported patch to $file"
 					;;
 			esac
+
+			# In-tree paths to reject
+			if [[ -z "$OOT_DIR" ]]; then
+				case "$file" in
+					lib/*|*/vdso/*|*/realmode/rm/*)
+						die "${patch}: unsupported patch to $file"
+						;;
+				esac
+			fi
 		done
 	done
 }
@@ -377,13 +393,14 @@ apply_patch() {
 	local patch="$1"
 	shift
 	local extra_args=("$@")
+	local patch_target="${OOT_DIR:-$PWD}"
 	local drift_regex="with fuzz|offset [0-9]+ line"
 	local output
 	local status
 
 	[[ ! -f "$patch" ]] && die "$patch doesn't exist"
 	status=0
-	output=$(patch -p1 --dry-run --no-backup-if-mismatch -r /dev/null "${extra_args[@]}" < "$patch" 2>&1) || status=$?
+	output=$(patch -d "$patch_target" -p1 --dry-run --no-backup-if-mismatch -r /dev/null "${extra_args[@]}" < "$patch" 2>&1) || status=$?
 	if [[ "$status" -ne 0 ]]; then
 		echo "$output" >&2
 		die "$patch did not apply"
@@ -398,9 +415,10 @@ apply_patch() {
 
 revert_patch() {
 	local patch="$1"
+	local patch_target="${OOT_DIR:-$PWD}"
 	local tmp=()
 
-	patch -p1 -R --force --no-backup-if-mismatch -r /dev/null &> /dev/null < "$patch" || true
+	patch -d "$patch_target" -p1 -R --force --no-backup-if-mismatch -r /dev/null &> /dev/null < "$patch" || true
 
 	for p in "${APPLIED_PATCHES[@]}"; do
 		[[ "$p" == "$patch" ]] && continue
@@ -436,10 +454,17 @@ validate_patches() {
 }
 
 do_init() {
-	# We're not yet smart enough to handle anything other than in-tree
-	# builds in pwd.
 	[[ ! "$PWD" -ef "$SCRIPT_DIR/../.." ]] && die "please run from the kernel root directory"
 
+	if [[ -n "$OOT_DIR" ]]; then
+		[[ -d "$OOT_DIR" ]] || die "module directory not found: $OOT_DIR"
+		OOT_DIR="$(realpath "$OOT_DIR")"
+		[[ -f "$OOT_DIR/Kbuild" || -f "$OOT_DIR/Makefile" ]] ||
+			die "no Kbuild or Makefile in $OOT_DIR"
+		[[ -f "$PWD/Module.symvers" ]] ||
+			die "kernel must be built first (no Module.symvers in $PWD)"
+	fi
+
 	if (( SHORT_CIRCUIT >= 2 )); then
 		[[ -f "$ORIG_DIR/.complete" ]] || die "-S $SHORT_CIRCUIT requires completed $ORIG_DIR"
 	fi
@@ -471,6 +496,7 @@ do_init() {
 refresh_patch() {
 	local patch="$1"
 	local tmpdir="$PATCH_TMP_DIR"
+	local patch_target="${OOT_DIR:-$PWD}"
 	local input_files=()
 	local output_files=()
 
@@ -483,11 +509,11 @@ refresh_patch() {
 	get_patch_output_files "$patch" | mapfile -t output_files
 
 	# Copy orig source files to 'a'
-	echo "${input_files[@]}" | xargs cp --parents --target-directory="$tmpdir/a"
+	( cd "$patch_target" && echo "${input_files[@]}" | xargs cp --parents --target-directory="$tmpdir/a" )
 
 	# Copy patched source files to 'b'
 	apply_patch "$patch" "--silent"
-	echo "${output_files[@]}" | xargs cp --parents --target-directory="$tmpdir/b"
+	( cd "$patch_target" && echo "${output_files[@]}" | xargs cp --parents --target-directory="$tmpdir/b" )
 	revert_patch "$patch"
 
 	# Diff 'a' and 'b' to make a clean patch
@@ -529,6 +555,7 @@ clean_kernel() {
 	cmd=("make")
 	cmd+=("--silent")
 	cmd+=("-j$JOBS")
+	[[ -n "$OOT_DIR" ]] && cmd+=("M=$OOT_DIR")
 	cmd+=("clean")
 
 	"${cmd[@]}"
@@ -567,7 +594,11 @@ build_kernel() {
 	fi
 	cmd+=("-j$JOBS")
 	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections")
-	cmd+=("vmlinux")
+	if [[ -z "$OOT_DIR" ]]; then
+		cmd+=("vmlinux")
+	else
+		cmd+=("M=$OOT_DIR")
+	fi
 	cmd+=("modules")
 
 	"${cmd[@]}"							\
@@ -579,13 +610,20 @@ build_kernel() {
 find_objects() {
 	local opts=("$@")
 
-	# Find root-level vmlinux.o and non-root-level .ko files,
-	# excluding klp-tmp/ and hidden directories.
-	find "$PWD" -mindepth 1 \
-		    \( -path "$TMP_DIR" -o -name ".*" -o -regex "$PWD/[^/][^/]*\.ko" \) -prune -o \
-		    -type f "${opts[@]}"				\
-		    \( -name "*.ko" -o -path "$PWD/vmlinux.o" \)	\
-		    -printf '%P\n'
+	if [[ -z "$OOT_DIR" ]]; then
+		# In-tree: find root-level vmlinux.o and non-root-level .ko files,
+		# excluding klp-tmp/ and hidden directories.
+		find "$PWD" -mindepth 1 \
+			    \( -path "$TMP_DIR" -o -name ".*" -o -regex "$PWD/[^/][^/]*\.ko" \) -prune -o \
+			    -type f "${opts[@]}"				\
+			    \( -name "*.ko" -o -path "$PWD/vmlinux.o" \)	\
+			    -printf '%P\n'
+	else
+		# OOT: find .ko at any depth under the module dir
+		find "$OOT_DIR" -path "$OOT_DIR/.git" -prune -o \
+			-type f "${opts[@]}" \
+			-name "*.ko" -printf '%P\n'
+	fi
 }
 
 # Copy all .o archives to $ORIG_DIR
@@ -597,10 +635,11 @@ copy_orig_objects() {
 
 	find_objects | mapfile -t files
 
+	local obj_root="${OOT_DIR:-$PWD}"
 	xtrace_save "copying original objects"
 	for _file in "${files[@]}"; do
 		local rel_file="${_file/.ko/.o}"
-		local file="$PWD/$rel_file"
+		local file="$obj_root/$rel_file"
 		local orig_file="$ORIG_DIR/$rel_file"
 		local orig_dir="$(dirname "$orig_file")"
 
@@ -633,10 +672,11 @@ copy_patched_objects() {
 
 	find_objects "${opts[@]}" | mapfile -t files
 
+	local obj_root="${OOT_DIR:-$PWD}"
 	xtrace_save "copying changed objects"
 	for _file in "${files[@]}"; do
 		local rel_file="${_file/.ko/.o}"
-		local file="$PWD/$rel_file"
+		local file="$obj_root/$rel_file"
 		local orig_file="$ORIG_DIR/$rel_file"
 		local patched_file="$PATCHED_DIR/$rel_file"
 		local patched_dir="$(dirname "$patched_file")"
@@ -717,6 +757,7 @@ diff_objects() {
 		cmd+=("klp")
 		cmd+=("diff")
 		(( ${#opts[@]} > 0 )) && cmd+=("${opts[@]}")
+		[[ -n "$OOT_DIR" ]] && cmd+=("--symvers" "$PWD/Module.symvers")
 		cmd+=("$orig_file")
 		cmd+=("$patched_file")
 		cmd+=("$out_file")
@@ -895,13 +936,16 @@ build_patch_module() {
 process_args "$@"
 do_init
 
+BUILD_TARGET="kernel"
+[[ -n "$OOT_DIR" ]] && BUILD_TARGET="module ${OOT_DIR##*/}"
+
 if (( SHORT_CIRCUIT <= 2 )); then
 	status "Validating patch(es)"
 	validate_patches
 fi
 
 if (( SHORT_CIRCUIT <= 1 )); then
-	status "Building original kernel"
+	status "Building original $BUILD_TARGET"
 	clean_kernel
 	build_kernel "original"
 	status "Copying original object files"
@@ -912,7 +956,7 @@ if (( SHORT_CIRCUIT <= 2 )); then
 	status "Fixing patch(es)"
 	fix_patches
 	apply_patches "--silent"
-	status "Building patched kernel"
+	status "Building patched $BUILD_TARGET"
 	build_kernel "patched"
 	revert_patches
 	status "Copying patched object files"
-- 
2.55.0

