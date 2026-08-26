Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B73B47E9
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773824; cv=none; b=M6/hdoTT3R2nRvF/9wnFFUokeuLptSrWcD0yMBLDFWTgluSxzjCbmqz4QnyQrYRwGTr0OnCmAFbFlokOhNSYPPIVZgQKTuTnKHoyM0Nh+eLnszo7Xhusm4M5DZ0A/LDBrl4sN1tzKX4WVWTfxiCGP0d6f/EAsHNfeDX5ibdVzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773824; c=relaxed/simple;
	bh=egcaC7Qy9TyHnXRTL3XBiAPQoAaUfAzjbPexYxEhOP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=c9v9jBEFA0o21wj7M0rQafAaviyJ+jNC86hQFcXeSfva2sFbUHg9QeWgBM6IG8hMpZtdGkytKLuzYK0KTUlvCmURvsFaLr1yQyEZVOZkwLPEFBMX/PS7u0+ZxD0p45yYc7u2J+W8NMXQqRdxZTatEmgIgFOyhv3EoOKvoV4fZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUihFogm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUihFogm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFzI3ZpVGHiLJT/v5kJe39PVg9kQJRef0MJoKjC+ewY=;
	b=bUihFogm/ykPmuSjIo5mGby5itkp9CXsS1FkWNoCilW7q7tjsfzgg1nUpVqp2+R7vdpXKy
	FyHyjPBi+CNVPz+HU+TUWwsvYOwCsJtQv9oYQ021L0yJdq6Y8+PYLXt7y7zO8L3eTwse1/
	zjL5fsyJSfK6wXEdc09TggtuRAl2E7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-ykV6kq8dOm243Gh8Ccf9zQ-1; Wed,
 26 Aug 2026 15:50:13 -0400
X-MC-Unique: ykV6kq8dOm243Gh8Ccf9zQ-1
X-Mimecast-MFC-AGG-ID: ykV6kq8dOm243Gh8Ccf9zQ_1787773812
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65127195605C;
	Wed, 26 Aug 2026 19:50:12 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 585893000239;
	Wed, 26 Aug 2026 19:50:11 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 7/7] livepatch/klp-build: add validation for user-supplied OOT objects
Date: Wed, 26 Aug 2026 15:50:00 -0400
Message-ID: <20260826195000.455905-8-joe.lawrence@redhat.com>
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

With the --orig-dir and --patched-dir options, the user performs the
respective original and patched builds manually.  Therefore it is
important to sanity check the supplied objects to the best of our
ability before entering the diff/extraction pipeline.

Add check_oot_object() and check_oot_objects() to verify:

- Each orig/ object has a matching patched/ counterpart
- At least one .text.<func> section is present, implying
  -ffunction-sections compiler flag was used
- Matching compiler versions

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 47 ++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index e118f133e923..fc5d968fe235 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -982,17 +982,58 @@ build_patch_module() {
 }
 
 
+check_oot_object() {
+	local file="$1"
+
+	readelf -S "$file" 2>/dev/null | command grep -q '\.text\.' ||
+		die "$file: no .text.<func> sections found; was -ffunction-sections used?"
+}
+
+check_oot_objects() {
+	local orig_dir="$1"
+	local patched_dir="$2"
+	local -a files
+	local rel
+
+	command -v readelf &>/dev/null ||
+		die "readelf not found (required for OOT object validation)"
+
+	find "$orig_dir" -type f -name "*.o" -printf '%P\n' | mapfile -t files
+	[[ ${#files[@]} -gt 0 ]] || die "no .o files found in $orig_dir"
+
+	for rel in "${files[@]}"; do
+		[[ -f "$patched_dir/$rel" ]] ||
+			die "$rel found in orig dir but missing from patched dir"
+
+		check_oot_object "$orig_dir/$rel"
+		check_oot_object "$patched_dir/$rel"
+
+		local orig_cc patched_cc
+		orig_cc="$(readelf -p .comment "$orig_dir/$rel" 2>/dev/null | sed -n 's/.*\] *//p' | head -1)"
+		patched_cc="$(readelf -p .comment "$patched_dir/$rel" 2>/dev/null | sed -n 's/.*\] *//p' | head -1)"
+		if [[ -n "$orig_cc" && -n "$patched_cc" && "$orig_cc" != "$patched_cc" ]]; then
+			warn "$rel: compiler mismatch between orig and patched"
+			warn "  orig:    $orig_cc"
+			warn "  patched: $patched_cc"
+		fi
+	done
+
+	find "$patched_dir" -type f -name "*.o" -printf '%P\n' | while read -r rel; do
+		[[ -f "$orig_dir/$rel" ]] ||
+			warn "$rel found in patched dir but missing from orig dir"
+	done
+}
+
 setup_oot() {
 	local files=()
 	local rel
 
+	check_oot_objects "$USER_ORIG_DIR" "$USER_PATCHED_DIR"
+
 	mkdir -p "$ORIG_DIR" "$PATCHED_DIR"
 
 	find "$USER_ORIG_DIR" -type f -name "*.o" -printf '%P\n' | mapfile -t files
-	[[ ${#files[@]} -gt 0 ]] || die "no .o files found in $USER_ORIG_DIR"
 	for rel in "${files[@]}"; do
-		[[ -f "$USER_PATCHED_DIR/$rel" ]] ||
-			die "$rel found in orig dir but missing from patched dir"
 		mkdir -p "$ORIG_DIR/$(dirname "$rel")"
 		mkdir -p "$PATCHED_DIR/$(dirname "$rel")"
 		cp -f "$USER_ORIG_DIR/$rel" "$ORIG_DIR/$rel"
-- 
2.55.0

