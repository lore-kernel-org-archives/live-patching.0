Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223951;
	b=IzaoWX4/xxM0jjxURhrBOpifqbr2Z+IRIULgS3phKXy8iNAP9HyF0aK+2ZAg2+Lhoqqx
	 ZL+ceUVXCcfQjmI62G3XgtPr63ioXrX2q5+yZ2mhdSyTdTNUU5dpDaZl/6tSuAnYC51jM
	 DWxMFDVwHJDiMTcI5LEbRKua/HrExn11lCQ+FKmTgyp4e+57qvW8wK3y4Gxt+RhN6Puf0
	 cTs9kkq/SFkOu0p79+tSC3xz0Nhx0Xte9gIQVeg/w6BrdXRpv9xoXk1a7qiPNIzn2ikmg
	 dBONSjIhn3jSqhzBxAJ+hAd2B6X7UQW6TeAAvHu0qFkqbc0srafWg1piHf8x7d+rQIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ADyQaIQcOcR054rICyguSMY/899jINQs83CdsbuUEAk=;
	b=t+uN5N3iScjKwm6SYlbDbjPYOxawM0s9S/dxvjKswhxSEJXR7ZCSzF6u45CxOQmEF+Ns
	 8QwSmQduhydiPDo2F9nQYYaYRVrf/VFzzCLBqtOYOeTo+RdPr7fmVwvb1ObSRd7KVriqm
	 wN//sU7HLrtqUZJfyb3YkJFLIww0tgnGFFeitx/bRFrJXmzW9kIbIsK+gx+USnRLKqtJg
	 XeDYyL5Mt+FiCILHYRGBjqpOEWPxKe9xz+8TdUHMWOStNV7HUT8X7+NizH4Uu8ZNVPE5s
	 jJCC3eq8wO7WkUC4L3sVvWUgMJiQ8wfGpM3QwUrCh0Qvx3JGq9dXqqgRKFFCS/nN4lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCJMUblm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F9606A32C;
	Wed, 28 Oct 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCJMUblm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982AB1F031E3;
	Wed, 28 Oct 2026 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223950;
	bh=ADyQaIQcOcR054rICyguSMY/899jINQs83CdsbuUEAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCJMUblmLAIsQ17zPfFm3jI4/B+4DbqDpPAaDdA+MriLATTvQAMMX9p65+I/jV1vY
	 pFjpUWy/GLc8EpbZ7r1D6yTGm9IRC5G7XPsD511+J9Eo2LLbYxrxmARlJRT3JW3MrK
	 t1080fcSfDvXvstAAgyZS4CBg5LTxl26OHNKyXCcKfiZDjRzUnrYk1DxJtMUZZ9cqS
	 9K8pk2qKTS4svw95oqum9N8SKYHIT5R1pxVi5hOGY9RYn2dqnS+mcvPalKkG78SoA3
	 k8gJPNh5/ocHMOw6TbAuylgGxEZjZqaHdHSJIGajn/s45XibwZsJ/kf6h+Y8pUyVH9
	 I+O6a+stT5JNw==
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
Subject: [PATCH v2 02/12] klp-build: Process the patches before building the original kernel
Date: Wed, 28 Oct 2026 14:45:24 -0700
Message-ID: <20261028214534.1919398-3-song@kernel.org>
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

klp-build validates the patches before building the original kernel,
but only combines them and adds #line directives after the build, which
applies and reverts them a second time.  Nothing in the second step
needs the original build, but the errors it finds, like patches with no
net effect, only show up after a full kernel build.

Do both in one step, before the build.  process_patches() checks for
patches to unsupported files, then applies the patches in order, which
also catches patches that don't apply and warns about those which apply
with fuzz, and combines them.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 scripts/livepatch/klp-build | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index a0bfc40093f9..28c3bf6b6418 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -395,11 +395,10 @@ revert_patch() {
 }
 
 apply_patches() {
-	local extra_args=("$@")
 	local patch
 
 	for patch in "${PATCHES[@]}"; do
-		apply_patch "$patch" "${extra_args[@]}"
+		apply_patch "$patch"
 	done
 }
 
@@ -413,12 +412,6 @@ revert_patches() {
 	APPLIED_PATCHES=()
 }
 
-validate_patches() {
-	check_unsupported_patches
-	apply_patches
-	revert_patches
-}
-
 do_init() {
 	# We're not yet smart enough to handle anything other than in-tree
 	# builds in pwd.
@@ -478,7 +471,7 @@ combine_patches() {
 	# Diff the orig source files against the patched ones in place to make a
 	# clean patch.  Use /dev/null for created and deleted files.
 	: > "$outfile"
-	apply_patches "--silent"
+	apply_patches
 	for file in "${files[@]}"; do
 		local old="$tmpdir/$file"
 		local new="$file"
@@ -504,12 +497,13 @@ combine_patches() {
 	revert_patches
 }
 
-# Combine the patches into $COMBINED_PATCH, and fix its lines so as not to
-# affect the __LINE__ macro for otherwise unchanged functions further down the
-# file.
+# Validate the patches, combine them into $COMBINED_PATCH, and fix its lines so
+# as not to affect the __LINE__ macro for otherwise unchanged functions further
+# down the file.
 process_patches() {
 	local tmp_patch="$TMP_DIR/tmp.patch"
 
+	check_unsupported_patches
 	combine_patches "$tmp_patch"
 	[[ ! -s "$tmp_patch" ]] && die "no changes detected"
 
@@ -889,8 +883,8 @@ process_args "$@"
 do_init
 
 if (( SHORT_CIRCUIT <= 2 )); then
-	status "Validating patch(es)"
-	validate_patches
+	status "Processing patch(es)"
+	process_patches
 fi
 
 if (( SHORT_CIRCUIT <= 1 )); then
@@ -902,8 +896,6 @@ if (( SHORT_CIRCUIT <= 1 )); then
 fi
 
 if (( SHORT_CIRCUIT <= 2 )); then
-	status "Processing patch(es)"
-	process_patches
 	apply_patch "$COMBINED_PATCH" "--silent"
 	status "Building patched kernel"
 	build_kernel "patched"
-- 
2.53.0-Meta

