Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879525771;
	Sat, 17 Oct 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196699; cv=none; b=Hn55tMmO5R+COeQwMtJZAD7nYdf2CeU6KUljeHkzW0DEppAlqwRYEbnhFBecU9rYJ1ljqXSEuNGa+K/SJGdsIHr+kJ5VWFMdzi10un5Y+VJtJcF41i/Aa2ttydiZpDIP6VehP37IIxTAT85MI7ii5f36H1W0g7Z16DOZwWtYCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196699; c=relaxed/simple;
	bh=3vfeq/JkZ7fYsFRYRVojlCX8mopw8Y40INBqtVi0xlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxhRmtsMQqBhrYJufoQXmVGpwjyVURXi71ZpiyBOZiFSdKg1fW2Xcea9taw2D7FZCHzf2wY+ekS6yfH5JN0dNHzeizchXIU73Bk6wWctzDY5bbZu0aA4PSBLlJkYa/VaXEvBnjbyEa6J8KwBXLKtopnii53aqsCY0IoDS4y3cBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNPsy1P5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNPsy1P5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68A31F000C4;
	Sat, 17 Oct 2026 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196697;
	bh=SRw4dp84YdrbxX8jeX80QvpaQavYFpGJmXFcbAy2BU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jNPsy1P5RXJzmDPomD38HLnBVYffvlueFNBO7ckRLRgzeR9GaOJUxXg9LmZJ7a7Iq
	 0FKNXN97yjsMfVnZHBN8+jXKvEnd0LkPGXiyk/JKLOwL2BXJzS0S5xXjFPbErUwl5B
	 1PJCGNsS4+Zwf3yLdHS66sQFBt9Yxj3WKMttrRLa6NYZ6HKyoqqbh9b8HuSy2M7/lE
	 HP87L5pc4IlWdWq6gqwb1PXonqP1+tDIEmqq9hCIA3mBnV5aB7htag72TKcuHea30i
	 R43gmWdkBaq6QSLTbjO5NAySadL7zpn+scXmqxE1M9hLg2Hf4Eo/n5UGloChtvhWUM
	 muueOniCiaGiw==
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
Subject: [PATCH 02/11] klp-build: Add --patch-only option
Date: Fri, 16 Oct 2026 17:24:32 -0700
Message-ID: <20261017002441.716615-3-song@kernel.org>
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

klp-build fixes the input patches before building the patched kernel:
it combines them into a single patch against the original source and
adds #line directives, so that unchanged functions further down a
patched file keep their __LINE__ values.  This only happens after the
original kernel has been built, so seeing the result, or testing this
step, takes a full kernel build and --keep-tmp.

Add a --patch-only option which validates and fixes the patches, prints
the fixed patch to stdout, and exits without building.  It skips the
.config checks and the kernel version setup, which only matter for
building, so the tree it runs in doesn't need to be configured.  It
uses a private tmp dir rather than klp-tmp, which may hold a previous
build that a later --short-circuit run wants to reuse.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 scripts/livepatch/klp-build | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 6cdc36e97c21..295fad62d7b8 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -19,7 +19,7 @@ set -o nounset
 # This helps keep execution in pipes so pipefail+ERR trap can catch errors.
 shopt -s lastpipe
 
-unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
+unset DEBUG_CLONE DIFF_CHECKSUM PATCH_ONLY SKIP_CLEANUP VERBOSE XTRACE
 
 REPLACE=1
 SHORT_CIRCUIT=0
@@ -137,6 +137,7 @@ Options:
 
 Advanced Options:
    -d, --debug			Show symbol/reloc cloning decisions
+       --patch-only		Print the fixed patch(es) and exit without building
    -S, --short-circuit=STEP	Start at build step (requires prior --keep-tmp)
 				   1|orig		Build original kernel (default)
 				   2|patched		Build patched kernel
@@ -160,7 +161,7 @@ process_args() {
 	local patch
 
 	short="hfj:o:vdS:T"
-	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,patch-only,short-circuit:,keep-tmp"
 
 	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -202,6 +203,10 @@ process_args() {
 				keep_tmp=1
 				shift
 				;;
+			--patch-only)
+				PATCH_ONLY=1
+				shift
+				;;
 			-S | --short-circuit)
 				[[ ! -d "$TMP_DIR" ]] && die "--short-circuit requires preserved klp-tmp dir"
 				keep_tmp=1
@@ -238,6 +243,15 @@ process_args() {
 	KEEP_TMP="$keep_tmp"
 	PATCHES=("$@")
 
+	if [[ -v PATCH_ONLY ]]; then
+		(( SHORT_CIRCUIT > 0 )) && die "--patch-only can't be used with --short-circuit"
+
+		# Leave klp-tmp alone, it may hold a previous build
+		TMP_DIR="$(mktemp -d)"
+		PATCH_TMP_DIR="$TMP_DIR/tmp"
+		KEEP_TMP=0
+	fi
+
 	for patch in "${PATCHES[@]}"; do
 		[[ -f "$patch" ]] || die "$patch doesn't exist"
 	done
@@ -462,6 +476,9 @@ do_init() {
 	[[ -x "$FIX_PATCH_LINES" ]] || die "can't find fix-patch-lines"
 	command -v recountdiff &>/dev/null || die "recountdiff not found (install patchutils)"
 
+	# The rest is only needed for building
+	[[ -v PATCH_ONLY ]] && return 0
+
 	validate_config
 	set_module_name
 	set_kernelversion
@@ -910,6 +927,13 @@ build_patch_module() {
 process_args "$@"
 do_init
 
+if [[ -v PATCH_ONLY ]]; then
+	validate_patches
+	fix_patches
+	cat "${PATCHES[@]}"
+	exit 0
+fi
+
 if (( SHORT_CIRCUIT <= 2 )); then
 	status "Validating patch(es)"
 	validate_patches
-- 
2.53.0-Meta

