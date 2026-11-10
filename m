Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340558;
	b=C5O0sSc0N4jHoBWXdcvk7sL8SJvbJ2sx6L/gs5nndQacEcBpbxrYkbCn1A9xh3zS70cA
	 mWKL0LOpTM4/jauPkDyc9CUOhYJuvRX6Upj4Tqzex5yNMLsFKM2Iyri12vca/lm5wz6mx
	 O+xUZC9w2pMXFUN6UE2Gie3NnJoUHRWukm0fm/AQ6N3vMGAJOp7RxXWuYke5yzvsKHTkk
	 C7ZjvxZvo2PskRZRcYTxvYqLPNAkm/6bhtI/FE/2wRLfwi9stccMAWoyutZyHbR/sT1wb
	 58n8diHznxkL0dEIyhaNZGw7EUsS29cMjrVrGiDCU/E5C9CqgF0m6Gu4WuqUZi+a54Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340558;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gdC4CUeQDUVnIicgDNaY6kPlV8f88uzB3vuy6ghKnKw=;
	b=iq6eNzXdzFUFSLOzhpZdG4CjY2Gy/Hd+67fSIWLSBI4/o6S+NcTK3dINRmpOmDInfIN9
	 6AFG47N4N6duRrsyHxsWgSLoFJOKqNe+/Y+vBeEsPrlPGKL7mHL3R2O5IzYfwkGL9OH1d
	 0vk92DHzwsoCZN9DaB6vEnVm9tDdqXHoRTTeyt34HUfx1WqKLkpLj0MECCdTXYYbOk2UA
	 kb7MxESRKQST96zy9SNa51g0aJe5EEGWD3JkMLObbFsh107f23d8MLrvquN7JRtNayF6S
	 lwxMTmemgfDwFOD4a53dkf2cWYCWzdHvPq2xZj7Rw1a88O7PwrGDajSVe2dANXotwOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NibLxCoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD025606A326;
	Tue, 10 Nov 2026 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NibLxCoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FF31F008A1;
	Tue, 10 Nov 2026 19:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340557;
	bh=gdC4CUeQDUVnIicgDNaY6kPlV8f88uzB3vuy6ghKnKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NibLxCoQrsM0Iz8OxmTP8VeifWTq/1UoE4kMUFtao/LrnHwU59I24JyyLXCoQk51S
	 oNGNXJoJA3OmMXEnOTgRW21MIv7LUzECfAtBhaqQlO86AhY0x8qJRWKfX4kDP+FnIr
	 oWlbkE3qxZJZZdtFXc2RiV5C4N+SK/MgCNYA488et9e6iVK7AMfDG1fMoEG3d2lhxp
	 yW1PpbpDKger3HIgEFtnd0n/b8bZbcB0+Zydj49rnOMa8sEFVTTBE99OQ8R6aDgXgO
	 NY/7YR9Nv2N9/QaXtqWVFnHNGL42+aBAopB6Ep/HDMWkoQ+mX72ApMokcfHVVmxCL8
	 +UfZ4c5+1GS+g==
Date: Tue, 10 Nov 2026 11:55:52 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] klp-build: Move patch processing to
 klp-prepare-patch
Message-ID: <avNz-_AbTGGlsP5o@jpoimboe>
References: <20261028214534.1919398-1-song@kernel.org>
 <20261028214534.1919398-4-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028214534.1919398-4-song@kernel.org>

On Wed, Oct 28, 2026 at 02:45:25PM -0700, Song Liu wrote:
> -apply_patches() {
> -	local patch
> -
> -	for patch in "${PATCHES[@]}"; do
> -		apply_patch "$patch"
> -	done
> -}
> -
>  revert_patches() {
>  	local patches=("${APPLIED_PATCHES[@]}")
>  

I think we can remove even more cruft:

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 4796b36b5cc8e..b93e1227b4c03 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -19,7 +19,7 @@ set -o nounset
 # This helps keep execution in pipes so pipefail+ERR trap can catch errors.
 shopt -s lastpipe
 
-unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
+unset DEBUG_CLONE DIFF_CHECKSUM PATCH_APPLIED SKIP_CLEANUP VERBOSE XTRACE
 
 REPLACE=1
 SHORT_CIRCUIT=0
@@ -110,7 +110,7 @@ restore_files() {
 
 cleanup() {
 	set +o nounset
-	revert_patches
+	revert_patch
 	restore_files
 	[[ "$KEEP_TMP" -eq 0 ]] && rm -rf "$TMP_DIR"
 	return 0
@@ -329,50 +329,14 @@ set_kernelversion() {
 }
 
 apply_patch() {
-	local patch="$1"
-	shift
-	local extra_args=("$@")
-	local drift_regex="with fuzz|offset [0-9]+ line"
-	local output
-	local status
-
-	[[ ! -f "$patch" ]] && die "$patch doesn't exist"
-	status=0
-	output=$(patch -p1 --dry-run --no-backup-if-mismatch -r /dev/null "${extra_args[@]}" < "$patch" 2>&1) || status=$?
-	if [[ "$status" -ne 0 ]]; then
-		echo "$output" >&2
-		die "$patch did not apply"
-	elif [[ "$output" =~ $drift_regex ]]; then
-		[[ -v VERBOSE ]] && echo "$output" >&2
-		warn "${patch} applied with fuzz"
-	fi
-
-	APPLIED_PATCHES+=("$patch")
-	patch -p1 --no-backup-if-mismatch -r /dev/null "${extra_args[@]}" --silent < "$patch"
+	PATCH_APPLIED=1
+	patch -p1 --no-backup-if-mismatch -r /dev/null --silent < "$COMBINED_PATCH"
 }
 
 revert_patch() {
-	local patch="$1"
-	local tmp=()
-
-	patch -p1 -R --force --no-backup-if-mismatch -r /dev/null &> /dev/null < "$patch" || true
-
-	for p in "${APPLIED_PATCHES[@]}"; do
-		[[ "$p" == "$patch" ]] && continue
-		tmp+=("$p")
-	done
-
-	APPLIED_PATCHES=("${tmp[@]}")
-}
-
-revert_patches() {
-	local patches=("${APPLIED_PATCHES[@]}")
-
-	for (( i=${#patches[@]}-1 ; i>=0 ; i-- )) ; do
-		revert_patch "${patches[$i]}"
-	done
-
-	APPLIED_PATCHES=()
+	[[ -v PATCH_APPLIED ]] || return 0
+	patch -p1 -R --force --no-backup-if-mismatch -r /dev/null &> /dev/null < "$COMBINED_PATCH" || true
+	unset PATCH_APPLIED
 }
 
 do_init() {
@@ -397,8 +361,6 @@ do_init() {
 	(( SHORT_CIRCUIT <= 1 )) && rm -rf "$TMP_DIR"
 	mkdir -p "$TMP_DIR"
 
-	APPLIED_PATCHES=()
-
 	[[ -x "$PREPARE_PATCH" ]] || die "can't find klp-prepare-patch"
 
 	validate_config
@@ -806,10 +768,10 @@ if (( SHORT_CIRCUIT <= 1 )); then
 fi
 
 if (( SHORT_CIRCUIT <= 2 )); then
-	apply_patch "$COMBINED_PATCH" "--silent"
+	apply_patch
 	status "Building patched kernel"
 	build_kernel "patched"
-	revert_patches
+	revert_patch
 	status "Copying patched object files"
 	copy_patched_objects
 fi

