Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8D3AA9D1
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773825; cv=none; b=SFPQYHlo7mgpfaLnw/YvjFHMBZbTG+H3Jbat+/XhQ0C28XXUlVIZNZWy9Ls29fvJpcmVmOBCvhWvyaPBjVV7fohC3Ms9f258+BqJ8Fe+WRduYtjk+5DFlr2ueB/cUimd0UbB8BCn1Qh8Hoeg8mreh11+KJtHgCOB4SV6BefM4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773825; c=relaxed/simple;
	bh=55fQY2rJMMZPq06fjwVNxkluNrQ8owT/nK4USVDFeRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=KXmuqQmPiCgM0TA1YdHlqeyKjXUG8Drp02FVqa9qimDApapE9SpBobcGV8ThdV5Zh/uuzkhVcABjS5MGkxJd2kay9b4ZOEi6rfvHB+GvQwzcBjOJGf1uR20VRf33oxpTqYZR7zalUBhQcMn/FKCAhC9Cy48xMox7OZb+uMYiyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAzy338Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAzy338Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vq+q+4VI16FbdxhtAm2z4pJmmTvdV3JyAVtTBEwFyJw=;
	b=ZAzy338YrquVSB/avikTUVdOT/I9By7SCnATFeWvEzNVEO2BnjI2vRMJI3U3jq8GXasFKD
	xnNmhhS15B3lHLacRQv7NkHEyopJtI5/+6LVUzTOeewBpjtgmLvlw6ViCookIjNykr/mZS
	IeEiflgv5Dc2ZXqc/MA9X63MFu0UCLY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-9eI0khK6Nu2IgJjRYkWe9A-1; Wed,
 26 Aug 2026 15:50:12 -0400
X-MC-Unique: 9eI0khK6Nu2IgJjRYkWe9A-1
X-Mimecast-MFC-AGG-ID: 9eI0khK6Nu2IgJjRYkWe9A_1787773811
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EE411955E7E;
	Wed, 26 Aug 2026 19:50:11 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2BB630002E9;
	Wed, 26 Aug 2026 19:50:09 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 6/7] livepatch/klp-build: add pre-built object support for advanced OOT workflows
Date: Wed, 26 Aug 2026 15:49:59 -0400
Message-ID: <20260826195000.455905-7-joe.lawrence@redhat.com>
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

Most real-world out-of-tree drivers use complicated, non-standard build
systems (DKMS, cmake, autoconf, proprietary toolchains) that cannot be
driven by klp-build's internal build stages.  Rather than attempting to
accommodate every third-party build system, let the user handle the
build process and supply the object pairs directly.

Enhance klp-build with --orig-dir and --patched-dir options that accept
directories of pre-built .o files.  The user is responsible for building
original and patched objects externally.  The only hard requirement is
that both builds use -ffunction-sections and -fdata-sections so that
objtool can identify changed functions at the object level.

From there, klp-build performs its binary comparison, symbol extraction,
and livepatch module assembly pipeline used for in-tree patches, only
with the build steps factored out.  External symbol ownership is
determined from the target kernel's Module.symvers (--symvers,
defaulting to $PWD/Module.symvers).

The new options are mutually exclusive with --oot-dir (which drives the
build itself) and --short-circuit (which is specific to the standard
build pipeline).

The workflow is as follows:

  # 1. Build OOT objects with -ffunction-sections and -fdata-sections
  mkdir -p /tmp/orig && cp $OOT/my_module.o /tmp/orig/

  # 2. (Optional) leverage the kernel's fix-patch-lines script to "undo"
  #    the effects of line number shift by the patch
  $KDIR/scripts/livepatch/fix-patch-lines $OOT/fix-overflow.patch \
      | recountdiff > /tmp/fixed.patch

  # 3. Apply patch, rebuild
  mkdir -p /tmp/patched && cp $OOT/my_module.o /tmp/patched/

  # 4. Generate the livepatch
  cd $KDIR
  ./scripts/livepatch/klp-build \
      --orig-dir /tmp/orig \
      --patched-dir /tmp/patched \
      --symvers $KDIR/Module.symvers \
      -o livepatch-my_module.ko

NOTE: klp-build does not verify that user-supplied objects were built
against the correct kernel headers or with compatible compiler options.
The resulting livepatch module is only as correct as the inputs
provided.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 110 +++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 8 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b60f5a5da31e..e118f133e923 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -22,6 +22,9 @@ shopt -s lastpipe
 unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
 
 OOT_DIR=""
+USER_ORIG_DIR=""
+USER_PATCHED_DIR=""
+SYMVERS_PATH=""
 REPLACE=1
 SHORT_CIRCUIT=0
 JOBS="$(getconf _NPROCESSORS_ONLN)"
@@ -127,6 +130,7 @@ trap trap_err ERR
 __usage() {
 	cat <<EOF
 Usage: $SCRIPT [OPTIONS] PATCH_FILE(s)
+       $SCRIPT --orig-dir=<DIR> --patched-dir=<DIR> [OPTIONS]
 Generate a livepatch module.
 
 Options:
@@ -139,6 +143,9 @@ Options:
 Advanced Options:
    -d, --debug			Show symbol/reloc cloning decisions
        --oot-dir=<DIR>		Out-of-tree module source directory
+       --orig-dir=<DIR>		Directory of pre-built original .o files
+       --patched-dir=<DIR>	Directory of pre-built patched .o files
+       --symvers=<FILE>		Path to Module.symvers [default: \$PWD/Module.symvers]
    -S, --short-circuit=STEP	Start at build step (requires prior --keep-tmp)
 				   1|orig		Build original kernel (default)
 				   2|patched		Build patched kernel
@@ -162,7 +169,7 @@ process_args() {
 	local patch
 
 	short="hfj:o:vdS:T"
-	long="help,show-first-changed,jobs:,oot-dir:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	long="help,show-first-changed,jobs:,oot-dir:,orig-dir:,patched-dir:,symvers:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
 
 	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -208,6 +215,18 @@ process_args() {
 				OOT_DIR="$2"
 				shift 2
 				;;
+			--orig-dir)
+				USER_ORIG_DIR="$2"
+				shift 2
+				;;
+			--patched-dir)
+				USER_PATCHED_DIR="$2"
+				shift 2
+				;;
+			--symvers)
+				SYMVERS_PATH="$2"
+				shift 2
+				;;
 			-S | --short-circuit)
 				[[ ! -d "$TMP_DIR" ]] && die "--short-circuit requires preserved klp-tmp dir"
 				keep_tmp=1
@@ -236,7 +255,18 @@ process_args() {
 		esac
 	done
 
-	if [[ $# -eq 0 ]] && (( SHORT_CIRCUIT <= 2 )); then
+	if [[ -n "$USER_ORIG_DIR" || -n "$USER_PATCHED_DIR" ]]; then
+		[[ -n "$USER_ORIG_DIR" && -n "$USER_PATCHED_DIR" ]] ||
+			die "--orig-dir and --patched-dir must both be specified"
+		[[ -v NAME ]] ||
+			die "--orig-dir/--patched-dir requires -o <output.ko>"
+		[[ -n "$OOT_DIR" ]] &&
+			die "--orig-dir/--patched-dir and --oot-dir are mutually exclusive"
+		(( SHORT_CIRCUIT > 0 )) &&
+			die "--short-circuit is not used with --orig-dir/--patched-dir"
+		[[ $# -gt 0 ]] &&
+			die "patch files are not used with --orig-dir/--patched-dir"
+	elif [[ $# -eq 0 ]] && (( SHORT_CIRCUIT <= 2 )); then
 		usage
 		exit 1
 	fi
@@ -456,7 +486,19 @@ validate_patches() {
 do_init() {
 	[[ ! "$PWD" -ef "$SCRIPT_DIR/../.." ]] && die "please run from the kernel root directory"
 
-	if [[ -n "$OOT_DIR" ]]; then
+	if [[ -n "$USER_ORIG_DIR" ]]; then
+		[[ -d "$USER_ORIG_DIR" ]] || die "directory not found: $USER_ORIG_DIR"
+		[[ -d "$USER_PATCHED_DIR" ]] || die "directory not found: $USER_PATCHED_DIR"
+		USER_ORIG_DIR="$(realpath "$USER_ORIG_DIR")"
+		USER_PATCHED_DIR="$(realpath "$USER_PATCHED_DIR")"
+		if [[ -n "$SYMVERS_PATH" ]]; then
+			SYMVERS_PATH="$(realpath "$SYMVERS_PATH")"
+			[[ -f "$SYMVERS_PATH" ]] || die "Module.symvers not found: $SYMVERS_PATH"
+		else
+			[[ -f "$PWD/Module.symvers" ]] ||
+				die "no Module.symvers in $PWD; use --symvers to specify"
+		fi
+	elif [[ -n "$OOT_DIR" ]]; then
 		[[ -d "$OOT_DIR" ]] || die "module directory not found: $OOT_DIR"
 		OOT_DIR="$(realpath "$OOT_DIR")"
 		[[ -f "$OOT_DIR/Kbuild" || -f "$OOT_DIR/Makefile" ]] ||
@@ -482,14 +524,19 @@ do_init() {
 	(( SHORT_CIRCUIT <= 1 )) && rm -rf "$TMP_DIR"
 	mkdir -p "$TMP_DIR"
 
+	validate_config
+	set_module_name
+	set_kernelversion
+
+	# Pre-built OOT init complete
+	if [[ -n "$USER_ORIG_DIR" ]]; then
+		return 0
+	fi
+
 	APPLIED_PATCHES=()
 
 	[[ -x "$FIX_PATCH_LINES" ]] || die "can't find fix-patch-lines"
 	command -v recountdiff &>/dev/null || die "recountdiff not found (install patchutils)"
-
-	validate_config
-	set_module_name
-	set_kernelversion
 }
 
 # Refresh the patch hunk headers, specifically the line numbers and counts.
@@ -757,7 +804,11 @@ diff_objects() {
 		cmd+=("klp")
 		cmd+=("diff")
 		(( ${#opts[@]} > 0 )) && cmd+=("${opts[@]}")
-		[[ -n "$OOT_DIR" ]] && cmd+=("--symvers" "$PWD/Module.symvers")
+		if [[ -n "$SYMVERS_PATH" ]]; then
+			cmd+=("--symvers" "$SYMVERS_PATH")
+		elif [[ -n "$OOT_DIR" || -n "$USER_ORIG_DIR" ]]; then
+			cmd+=("--symvers" "$PWD/Module.symvers")
+		fi
 		cmd+=("$orig_file")
 		cmd+=("$patched_file")
 		cmd+=("$out_file")
@@ -931,11 +982,54 @@ build_patch_module() {
 }
 
 
+setup_oot() {
+	local files=()
+	local rel
+
+	mkdir -p "$ORIG_DIR" "$PATCHED_DIR"
+
+	find "$USER_ORIG_DIR" -type f -name "*.o" -printf '%P\n' | mapfile -t files
+	[[ ${#files[@]} -gt 0 ]] || die "no .o files found in $USER_ORIG_DIR"
+	for rel in "${files[@]}"; do
+		[[ -f "$USER_PATCHED_DIR/$rel" ]] ||
+			die "$rel found in orig dir but missing from patched dir"
+		mkdir -p "$ORIG_DIR/$(dirname "$rel")"
+		mkdir -p "$PATCHED_DIR/$(dirname "$rel")"
+		cp -f "$USER_ORIG_DIR/$rel" "$ORIG_DIR/$rel"
+		cp -f "$USER_PATCHED_DIR/$rel" "$PATCHED_DIR/$rel"
+	done
+
+	touch "$ORIG_DIR/.complete"
+	touch "$PATCHED_DIR/.complete"
+}
+
+
 ################################################################################
 
 process_args "$@"
 do_init
 
+# User provided OOT original and patched object files can jump straight
+# to checksum + diff + build steps
+if [[ -n "$USER_ORIG_DIR" ]]; then
+	status "Setting up OOT objects"
+	setup_oot
+
+	status "Generating original checksums"
+	generate_checksums "$ORIG_DIR" "$ORIG_CSUM_DIR" "$PATCHED_DIR"
+	status "Generating patched checksums"
+	generate_checksums "$PATCHED_DIR" "$PATCHED_CSUM_DIR"
+
+	status "Diffing objects"
+	diff_objects
+
+	status "Building patch module: $OUTFILE"
+	build_patch_module
+
+	status "SUCCESS"
+	exit 0
+fi
+
 BUILD_TARGET="kernel"
 [[ -n "$OOT_DIR" ]] && BUILD_TARGET="module ${OOT_DIR##*/}"
 
-- 
2.55.0

