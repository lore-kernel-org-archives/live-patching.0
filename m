Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521041;
	b=N4zLG+x7P5nRB+fChwEKePBYj+5V2BbfPWLHFJ4XATbzmb/1rgJ5J4ibfRMRBMvLB826
	 2TkUPaM29on/6soGCNPP+71my2mNpE+5RKTgf4TTbPr1fxWPIUwSNH+7zKLyDhLEcL6wQ
	 oUV/PBPyEBENcNjVkc6IJFhX0SZlic/mUVJdwXLBE2fY+BDGIbnXhc0nzCmP7tuGfZRoq
	 SXRbwNbXdeaqadmgvECfTejcB8IKe9QsXfcbuQeBkEqOi2uQIUQQRcp3bHYgFN9EXgBYk
	 2KM2BKYngChvNNQGBdJ2hVSlgPxxrAPuKZhzsAN9yDm+Wdi6h/SA+6bRPRvmU7Klqbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=OApFv+JTRWklrvgE3dh5H3kzXm8cpf7tKiKBdjrK9qk=;
	b=rrEDyiXvUIYmjNBHWFjL4v9MvUuujWRSO0+ZLRYMausBSP3NdshW36fejd80EQeFjnBY
	 JV/nMAigrRY0u1G63NEET3kLMkfAiQ9QQTB3TKt1smThBwqtj5shy00CSTtLOAqQysdql
	 Fy+f2YKxAqZkC9Tts8/ReyuKVqz6yUBzCLix5wqdk+Wax71TZhpB89hy6HPw7XYyvbID1
	 J4NQhqsuZDPo+b9GM0OVClqG+0w/Rhd5P72mLl5IXbe0kNh0+NuApQ95mifPgHWFNHney
	 DTgWpMiRHOg5jph25K+xYYoJm3g1f9qj+0ASJ6zeO/ikCOKjMkB4OCbxuChaeceQU6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="i5z/FryY";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090A3606A31C
	for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 22:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 090A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i5z/FryY
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb5375cd68so2593095ad.0
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 14:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794521040; x=1795125840; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OApFv+JTRWklrvgE3dh5H3kzXm8cpf7tKiKBdjrK9qk=;
        b=i5z/FryYinfyYzqyqeviHVNYmTVAzDoNJWWkomkHDyjfAGMv0DsG8PVtoasKXoqTAf
         T2F6o+QLAX69FFvTyZedumQumkbj1G8r+RsOgSkjpIh3jGkr1c2u/VmIlLpCz8320gtN
         ICPL04Pe2Wj7oyal7kHKdQ9rGXy+n9MIyOyvT7+LozBk+Fz1TuNl9NOS8CQeOds/fiaB
         SMQpWik2s4zngd/kayY264Vqr1vKC8APfPF1/WX7YayRuUELMNGZk3uNnhQ8hcVwgBgQ
         lIQNIjeo9m3cMz3MxeUX9LpHwLBMqiFBrj4lVxG0SVhOUWdvNsJ6kKvXich61HPbCP0H
         FNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521040; x=1795125840;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OApFv+JTRWklrvgE3dh5H3kzXm8cpf7tKiKBdjrK9qk=;
        b=tDVb0I8mWQcSzjL+dclezqYfY26cOkFqoR/8Uiog4Yq9uPjHdh2kmcxldx9m8Ryld4
         Tc1wiW9UEEwH2GkuEdUDQxuvD8ncLB4u5y90L+KvqV4Dmf1aADlY+aJfIbAurk7Tov+u
         je9eVQdYjduHOgvUZboHibdIfZuHjhMBeKaBS1ZowiEpdffEVBv/jMiwYV9D2BQVdT3O
         vVfcnRgxsUeR6kM97kPvtNzpARfdf0++Pppeu8oLPiaUNahRGUpNvSBQlAWvuBGZNK1l
         LQimI19M4ZAzwXbjIjkUP1UQH5xX4qMSZU2rq8kyIsAwAoCqainC8ChY0vi5ESMwFBi6
         meug==
X-Gm-Message-State: APuU4Z9S0d0FPAsn01/kJvi9dRP5tI8FXUGq+zk15LGekqGjD+6e05Ou
	RJZN1PuFvcJb0KDX08yBmktJYKYPu4DAusZyvE4oPnsdeuL+6RRhg54lYRnoOFkiYRyyVJxjExQ
	7XEr7QlY+5QU73HJoUEMHEbizbw==
X-Received: from plfh6.prod.google.com ([2002:a17:902:f546:b0:2ed:ab54:eb4f])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e84a:b0:2e9:7dda:bfc7 with SMTP id d9443c01a7336-2ee0dcd0647mr5450575ad.66.1794521039977;
 Thu, 12 Nov 2026 14:03:59 -0800 (PST)
Date: Thu, 12 Nov 2026 22:03:55 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261112220355.1952137-1-dylanbhatch@google.com>
Subject: [PATCH v2] klp-build: Allow passing options to make via '--'
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

Livepatch builds rely on reproducing the original kernel build
environment, including any make flags or command-line variables used
during the original build (such as 'CC=...', 'KBUILD_BUILD_TIMESTAMP=...',
or custom wrapper Makefiles via '-f').

While these options can already be passed through the MAKEFLAGS
environment variable, passing them directly on the command line is more
ergonomic.

Refactor the make invocations to use a common MAKE array and allow
passing arbitrary make options after '--' on the klp-build command line:

  klp-build [OPTIONS] PATCH_FILE(s) [-- MAKE_OPTIONS]

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
v1: https://lore.kernel.org/r/20261103233909.1364531-1-dylanbhatch@google.com

Changes in v2:
- Clarify in the commit message that this is an ergonomic alternative to
  MAKEFLAGS rather than new functionality (Josh Poimboeuf)

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
2.56.0.611.g1030f0b940-goog

