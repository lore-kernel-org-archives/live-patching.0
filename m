Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531425;
	b=R8DIY74mUtxUGCUSAA6y90URiUiEX5l0eVPVOWjfFjbuJUyg+G2WJxc6i7nzkgmUoLAc
	 5qsT8Yvcjvx9HnuhAeLPoaWsbIqzkeWAy6Hgm/DYSbvPRNU4uniGDQrZBuX9OQBP5P4Rb
	 cubJlj5JPFYO75tl9Tl3xfDbGZq8W1zr3Q+OMEQmwmN8B8yjcwNFq1rTmU1sMCHLPHHpH
	 fyY90P7uYdeC+IeZDk+3Xx6qXG8CJmh+aFby9b38xYTdmBRzwxFbYMm+eMXocRQFEtvdF
	 Psc9MdWRNYjAPMLZMrtGVASBKsQx0kIicSnErdYrOrFsX3w0B7hawbXDq2Qq6tiCroQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Roe4BMBeedZNSI4l8eJ0dPrl1wLnKmzYGDF5Bf3TQRM=;
	b=ALfmRXZujSwOyvPah6Us/Ym9ZguvqshRmBV/DNQsAyqGvc0x7tyW8p70ybPBAI+dkJIC
	 VKG3ld3KXAGSXXe+9DiLl+WIGHoqlue23PxDDVvu6xJJCt0B2jJFPJ8SRNt2yd418IWbH
	 61qoVmtEtlKJ3RrzILNS2GkNbOQFBb57Jh7TpEeGL1iULH41frd6EiezhPrylaXt1pgtV
	 8YgHbYHsMak6R9FFx0L5F4G8wbuWdYeKs1Xaohte+Wgw7qTIWMcMa6TcsDdfZftsnOcVV
	 wdKrNZez7g2+szNFW0vHlz6SjLsOV/tN1xH6SoD1oB5gdIsx7OVhP455jp/59kjBIfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/BzBwap";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234C606A326;
	Tue, 20 Oct 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/BzBwap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0394F1F000CA;
	Tue, 20 Oct 2026 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531424;
	bh=Roe4BMBeedZNSI4l8eJ0dPrl1wLnKmzYGDF5Bf3TQRM=;
	h=From:To:Cc:Subject:Date;
	b=V/BzBwapxKGVKBCAdo6Qkjv+RI8S7suahbqbpA5pzIq8ewxw+V3hlt1JvZ0i0tc2G
	 aRhRAkkMAjV+szWZleiO8rBlE/gio6kJ5aOwjhTYjeG67FdFXbXfpKaClytxqQWCUy
	 NzVLKD748Oj3hDe/OFXjFnQd3K2IlPtD1LNtq1G8LTWpBnGrZqRS/XU7xrizAWrS5n
	 h4aTvq8bPHHJfXtT/zBRR4txEhSyyJfCS3R4wwX2bpddgvlpo9wk1bqjbDDaCjRBae
	 G9ln47XMqW43huss8YBLD1BQubEhF+Q0qpHDWC6X6JsnRntQJKrYxz7d04SrUxmHg7
	 eBhtslznEndHA==
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
Subject: [PATCH] klp-build: Reuse the target kernel randstruct seed
Date: Tue, 20 Oct 2026 14:23:41 -0700
Message-ID: <20261020212341.706367-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
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

CONFIG_RANDSTRUCT randomizes struct layouts based on a seed which kbuild
generates from /dev/urandom.  A livepatch has to observe the same layouts
as the kernel it is loaded into, but klp-build runs 'make clean', after
which kbuild generates a new seed, and the resulting module can't be
loaded:

  module livepatch_foo: .gnu.linkonce.this_module
  section size must match the kernel's built struct module size at run time

struct module had grown 64 bytes of padding relative to the running
kernel (0x540 vs 0x500).  Every other randomized struct the patch touches
would be read at the wrong offsets too, so this is not just a loader nit.

Reuse the seed of the kernel being patched, taken from --randstruct-seed
or from scripts/basic/randstruct.seed in the tree, and refuse to build
when CONFIG_RANDSTRUCT is on and no valid seed is available.  A wrong
module is worse than no module.

Pin scripts/gen-randstruct-seed.sh rather than the generated seed file:
clean_kernel() removes scripts/basic/.randstruct.seed.cmd, so kbuild's
if_changed finds no saved command and regenerates the seed no matter what
the file already holds.  The generator is stashed, so it is restored on
exit like scripts/setlocalversion.

Read the seed before set_kernelversion(), but pin the generator after it.
set_kernelversion() runs 'make listnewconfig' and 'make syncconfig', which
build scripts/basic as well, so after a 'make clean' they would replace
the seed before the default seed file is read.  But if the generator is
already modified when 'make kernelrelease' runs, setlocalversion appends
"-dirty" to the kernel release and the module's vermagic no longer
matches the target kernel.

The Clang and GCC plugin implementations both derive their layouts only
from scripts/basic/randstruct.seed, so pinning the seed covers
CONFIG_GCC_PLUGIN_RANDSTRUCT too.  Drop the check that rejected it.  The
plugin requires a 64 character seed, which is what gen-randstruct-seed.sh
writes, so validate exactly that format.

An explicit option is needed rather than deriving the path from
uname -r, because the build host is usually not running the kernel being
patched.

Signed-off-by: Song Liu <song@kernel.org>
---
 scripts/livepatch/klp-build | 61 ++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..fd336f685a84 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -19,7 +19,7 @@ set -o nounset
 # This helps keep execution in pipes so pipefail+ERR trap can catch errors.
 shopt -s lastpipe
 
-unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
+unset DEBUG_CLONE DIFF_CHECKSUM RANDSTRUCT_SEED RANDSTRUCT_SEED_FILE SKIP_CLEANUP VERBOSE XTRACE
 
 REPLACE=1
 SHORT_CIRCUIT=0
@@ -133,6 +133,8 @@ Options:
    -j, --jobs=<jobs>		Build jobs to run simultaneously [default: $JOBS]
    -o, --output=<file.ko>	Output file [default: livepatch-<patch-name>.ko]
        --no-replace		Disable livepatch atomic replace
+       --randstruct-seed=<file>	Randstruct seed of the target kernel
+                                [default: scripts/basic/randstruct.seed]
    -v, --verbose		Pass V=1 to kernel/module builds
 
 Advanced Options:
@@ -160,7 +162,7 @@ process_args() {
 	local patch
 
 	short="hfj:o:vdS:T"
-	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	long="help,show-first-changed,jobs:,output:,no-replace,randstruct-seed:,verbose,debug,short-circuit:,keep-tmp"
 
 	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -193,6 +195,11 @@ process_args() {
 				REPLACE=0
 				shift
 				;;
+			--randstruct-seed)
+				[[ -r "$2" ]] || die "can't read randstruct seed file '$2'"
+				RANDSTRUCT_SEED_FILE="$2"
+				shift 2
+				;;
 			-v | --verbose)
 				VERBOSE=1
 				shift
@@ -268,9 +275,6 @@ validate_config() {
 	[[ -v CONFIG_GCC_PLUGIN_LATENT_ENTROPY ]] &&	\
 		die "kernel option 'CONFIG_GCC_PLUGIN_LATENT_ENTROPY' not supported"
 
-	[[ -v CONFIG_GCC_PLUGIN_RANDSTRUCT ]] &&	\
-		die "kernel option 'CONFIG_GCC_PLUGIN_RANDSTRUCT' not supported"
-
 	[[ -v CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ]] &&		\
 		die "kernel option 'CONFIG_LD_DEAD_CODE_DATA_ELIMINATION' not supported"
 
@@ -328,6 +332,51 @@ set_kernelversion() {
 	sed -i "2i echo $kernelrelease; exit 0" scripts/setlocalversion
 }
 
+# CONFIG_RANDSTRUCT randomizes struct layouts based on a seed which kbuild
+# generates from /dev/urandom.  A livepatch has to observe the same layouts as
+# the kernel it gets loaded into, so reuse that kernel's seed.  Otherwise the
+# module loader rejects the module ("...this_module section size must match
+# the kernel's built struct module size at run time"), and any randomized
+# struct the patch touches would be accessed at the wrong offsets.
+#
+# This must run before set_kernelversion(), whose 'make syncconfig' also
+# builds scripts/basic.  After a 'make clean' that would replace the seed
+# before the default seed file gets read.
+read_randstruct_seed() {
+	local seed_file
+
+	[[ -v CONFIG_RANDSTRUCT ]] || return 0
+
+	if [[ -v RANDSTRUCT_SEED_FILE ]]; then
+		seed_file="$RANDSTRUCT_SEED_FILE"
+	else
+		seed_file="$PWD/scripts/basic/randstruct.seed"
+		[[ -r "$seed_file" ]] ||				\
+			die "CONFIG_RANDSTRUCT is enabled but there's no $seed_file; pass --randstruct-seed with the seed used to build the kernel"
+	fi
+
+	RANDSTRUCT_SEED="$(< "$seed_file")"
+	[[ "$RANDSTRUCT_SEED" =~ ^[0-9a-f]{64}$ ]] ||			\
+		die "malformed randstruct seed in $seed_file"
+}
+
+# Pin the generator rather than the seed file: clean_kernel() removes
+# scripts/basic/.randstruct.seed.cmd, so if_changed sees no saved command and
+# regenerates the seed no matter what the file already holds.
+#
+# This must run after set_kernelversion(), otherwise setlocalversion sees the
+# modified generator and appends "-dirty" to the kernel release.
+set_randstruct_seed() {
+	local gen="$PWD/scripts/gen-randstruct-seed.sh"
+
+	[[ -v RANDSTRUCT_SEED ]] || return 0
+
+	stash_file "$gen"
+	sed -i "s|^SEED=.*|SEED=$RANDSTRUCT_SEED|" "$gen"
+	command grep -q "^SEED=$RANDSTRUCT_SEED$" "$gen" ||		\
+		die "failed to pin randstruct seed"
+}
+
 get_patch_input_files() {
 	local patch="$1"
 
@@ -464,7 +513,9 @@ do_init() {
 
 	validate_config
 	set_module_name
+	read_randstruct_seed
 	set_kernelversion
+	set_randstruct_seed
 }
 
 # Refresh the patch hunk headers, specifically the line numbers and counts.
-- 
2.53.0-Meta

