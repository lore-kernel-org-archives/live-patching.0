Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749154;
	b=JUXCdaxJ/pdO+nxXmtejusr1KgKzilJnGyW3dTrNZiHRYmiNTcOb+aN1IS7jgLXwPw5S
	 Y0GUnJJDUD+pgbfbEi5QwkrvX549u7h/JU0Ln+sCoXF16R+FU+aK76iaQNxpwI4dycGNJ
	 AieLfkh47NoRbwPOGJzgr2o45fmP3GALVsQswyfHwwSPwM+kImQtnzLXpy7yaG8iT8ZWT
	 jnLRT7YJTmeNKwJR5edTy3T0pVVPLinhDmN2EO5yPZM4F6ypZfly2ReUoNf1Pn2B7OfAa
	 JS94iconPkXh4S3/FsYnfD/6WZZB4P49oNFwht0Ye3fFce521O+RdQOtMPrR9AX34CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=YbWFhMkYlOVKSadJOHDDc5Xn/bx8C+ho8xxQr4Ng2Kw=;
	b=hsTnEWsK34zmYx2IfhxoK/DOfJpIhw+mV4wUVVUpDwMKCG9gzaY41XkK53NkdkauuUrT
	 /8fsdM7Ckf2B6OOtMa7c5BW9171GuLEWDy/i7/bIIwHb7/MjpxLlUhOdvDTF9BC6z/l8c
	 ckF23OdGU1SItb8KJdUENTo+oTqvG69CoSMwqwhXMQRDglgQvnWuC5vaubgft5YM3Yh31
	 xl+EittaHnM4JNRNkq53n7ZvvMjt/MMTR68ovY8dIFDP/I8IKckGSklHaGhF+sQPwRx/U
	 K/EChvjAlNkResHg+06d/I7ftaJi8F6+oYFHqQvDP7jb/qINnu1GTiAyXS8YJC0T2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fsb5teVe;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A683606A31B
	for <live-patching@vger.kernel.org>; Tue,  3 Nov 2026 23:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A683606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fsb5teVe
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a065e2933fso243130b3a.3
        for <live-patching@vger.kernel.org>; Tue, 03 Nov 2026 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749153; x=1794353953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YbWFhMkYlOVKSadJOHDDc5Xn/bx8C+ho8xxQr4Ng2Kw=;
        b=fsb5teVe9x0BDx4iCcMxA+63LChtRHF7TcSB1Sf+4unuqJkqjDOOSsaD4AEieOWEZL
         m9VU6FPBFXvL8j3DocHlBhLVFQDQAZVp//EWLnZQcs4LRaAl8TbMtZkLuFIC0MrjB7hC
         Y/sUqqPd76DTbCxWuqulBLxwvv5C+BJL+kahaFwalwNl+0jrBKEcvo+tHnBI49fvsD+z
         igW3Zk+ucbId3qDAFjCQP4GJAB0p08UW2ibKisSRtA1FPXw6H21QKUyHDAQQzJT8FNFx
         K44emYuaqf7AyLigm5qtZjQhoISF99lERSXEFjzTw1oeG4CKtqUYkxpfXyCTvBUcFNoR
         zuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749153; x=1794353953;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbWFhMkYlOVKSadJOHDDc5Xn/bx8C+ho8xxQr4Ng2Kw=;
        b=L8KFPQ/3vyos/e/CVv9BRku0DlTRBsQDHCQksDgjoEaovmUjtpJwz1DQFCrXCguNha
         N2wMo6n8WtWwznIfx6EdgVMvrvU+kKFMwe9LrZ1N/09BCsvPcSPQpsOat5i+MKljWvgC
         nqmdJ4Iv4hkxNA3xfO5a4qjm0TFHEtA3VjcivS0jkeWqZca/PaESqqON+VO75aNjZ5D+
         csIoLKxR/4D/REynGELlhwCxw2sOqFDzGKFEOFrTvvPuMjGVKiKzni6JTSWxb+Z/8zdz
         nqxZgky//pSoP7nUnT5mb+vMe9yWnPFvZFSiV7Lf2+X37b+m1Y4+SjmpPS48QHa5QUmt
         Burg==
X-Gm-Message-State: APuU4Z9bV7JSo4or9oLyjFRxlQmRWZpbTbIRUTjt0ScSZzK2wEZWV/rW
	XFfEXvp5tMIqGkldw37hMxj0HJSUmrblXMt6E25CtHTUhJ/zd6rmlmqfWtEdyMfWQQds/dyqQJB
	srZZyAXoxZtxvezUtWeT22vWdeQ==
X-Received: from pfbhx5.prod.google.com ([2002:a05:6a00:8985:b0:89f:4790:689a])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:e11:b0:882:359f:ef17 with SMTP id d2e1a72fcca58-8a9bb7a0b64mr12641184b3a.12.1793749152517;
 Tue, 03 Nov 2026 15:39:12 -0800 (PST)
Date: Tue,  3 Nov 2026 23:39:09 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103233909.1364531-1-dylanbhatch@google.com>
Subject: [PATCH] klp-build: Allow passing options to make via '--'
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

Livepatch builds rely on reproducing the original kernel build
environment. Currently, klp-build invokes bare 'make', which drops any
command-line variables or flags used during the original build (such as
'LLVM=1', 'CC=...', 'KBUILD_BUILD_TIMESTAMP=...', or custom wrapper
Makefiles via '-f').

Refactor the make invocations to use a common MAKE array and allow
passing arbitrary make options after '--' on the klp-build command line:

  klp-build [OPTIONS] PATCH_FILE(s) [-- MAKE_OPTIONS]

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 scripts/livepatch/klp-build | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f67..1fd405d43ef43 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -125,7 +125,7 @@ trap trap_err ERR
 
 __usage() {
 	cat <<EOF
-Usage: $SCRIPT [OPTIONS] PATCH_FILE(s)
+Usage: $SCRIPT [OPTIONS] PATCH_FILE(s) [-- MAKE_OPTIONS]
 Generate a livepatch module.
 
 Options:
@@ -158,11 +158,23 @@ process_args() {
 	local long
 	local args
 	local patch
+	local klp_args=()
+	local make_args=()
+
+	while [[ $# -gt 0 ]]; do
+		if [[ "$1" == "--" ]]; then
+			shift
+			make_args=("$@")
+			break
+		fi
+		klp_args+=("$1")
+		shift
+	done
 
 	short="hfj:o:vdS:T"
 	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
 
-	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
+	args=$(getopt --options "$short" --longoptions "$long" -- "${klp_args[@]}") || {
 		echo; usage; exit
 	}
 	eval set -- "$args"
@@ -237,6 +249,7 @@ process_args() {
 
 	KEEP_TMP="$keep_tmp"
 	PATCHES=("$@")
+	MAKE=("make" "${make_args[@]}")
 
 	for patch in "${PATCHES[@]}"; do
 		[[ -f "$patch" ]] || die "$patch doesn't exist"
@@ -317,12 +330,12 @@ set_kernelversion() {
 
 	stash_file "$file"
 
-	if [[ -n "$(make -s listnewconfig 2>/dev/null)" ]]; then
+	if [[ -n "$("${MAKE[@]}" -s listnewconfig 2>/dev/null)" ]]; then
 		die ".config mismatch, check your .config or run 'make olddefconfig'"
 	fi
-	make syncconfig &>/dev/null || die "make syncconfig failed"
+	"${MAKE[@]}" syncconfig &>/dev/null || die "make syncconfig failed"
 
-	kernelrelease="$(make -s kernelrelease)"
+	kernelrelease="$("${MAKE[@]}" -s kernelrelease)"
 	[[ -z "$kernelrelease" ]] && die "failed to get kernel version"
 
 	sed -i "2i echo $kernelrelease; exit 0" scripts/setlocalversion
@@ -526,7 +539,7 @@ fix_patches() {
 clean_kernel() {
 	local cmd=()
 
-	cmd=("make")
+	cmd=("${MAKE[@]}")
 	cmd+=("--silent")
 	cmd+=("-j$JOBS")
 	cmd+=("clean")
@@ -539,7 +552,7 @@ build_kernel() {
 	local log="$TMP_DIR/build.log"
 	local cmd=()
 
-	cmd=("make")
+	cmd=("${MAKE[@]}")
 
 	# When a patch to a kernel module references a newly created unexported
 	# symbol which lives in vmlinux or another kernel module, the patched
@@ -859,7 +872,7 @@ build_patch_module() {
 	cflags+=("-fdata-sections")
 	[[ $REPLACE -eq 0 ]] && cflags+=("-DKLP_NO_REPLACE")
 
-	cmd=("make")
+	cmd=("${MAKE[@]}")
 	if [[ -v VERBOSE ]]; then
 		cmd+=("V=1")
 	else
-- 
2.56.0.385.gac671c819a-goog

