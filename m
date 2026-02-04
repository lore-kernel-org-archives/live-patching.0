Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9922237A4F
	for <live-patching@vger.kernel.org>; Wed,  4 Feb 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173523; cv=none; b=e7S8l7bhubw34GtsUc7miTWaTdATXq4BymR7JTuwk4fTacKbtv4++f+G8wPWZrfcZhahuRv6ApFhmhbTm3C1uTFLX1nTJgfVQGVkK6Wgg+XCSuSj/cLGEeDfo24qBLHg4c9zr4cvH/zezALjf6vZbLwVc7kawu/oJ7+a1i+nu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173523; c=relaxed/simple;
	bh=j8nWueKpESUV/jyZcKVdHQSsmsIADQA5FU/S6TUafrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Va2hAx05rPKmgmUNwYQfEt4AOnDXRn4hcLbXBmcq/iWidnYjaV4Ya58qcbggweZihM2wpmEmNr8O3WiNjmdL1Q4hkVdEdUAkueMwjMF5cOU3vPwdOALeQ5suucNuS6Ib6AWpqD5abuHQf2rS+qESbO81xMuJtUwWqAHjVktVLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/ZGpbX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/ZGpbX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770173520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3L3pQpFKR92JphKNK3PeXwBUaY45i5k6RYkuz4xv80w=;
	b=T/ZGpbX7PCcQRjQqRnCCeOJ7aHJc9oGiI6GuWj/N1fXPGkmMLXpOlo0VukeuDAn3IAc6ZB
	0YA7vKYRbfPUYkoVUZ71CIFlqXhAlPfvpTpVWD7xuGuS1YRTvNlqsKT96mD1ftfOflLaAm
	YIrPWoDazjpPLnNHd3voWZ46MfhVtZ4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-H_fJSYkNOnaZysbRzdiBiA-1; Tue,
 03 Feb 2026 21:51:55 -0500
X-MC-Unique: H_fJSYkNOnaZysbRzdiBiA-1
X-Mimecast-MFC-AGG-ID: H_fJSYkNOnaZysbRzdiBiA_1770173514
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3532F195606F;
	Wed,  4 Feb 2026 02:51:54 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFDA31801768;
	Wed,  4 Feb 2026 02:51:52 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 5/5] livepatch/klp-build: provide friendlier error messages
Date: Tue,  3 Feb 2026 21:51:40 -0500
Message-ID: <20260204025140.2023382-6-joe.lawrence@redhat.com>
In-Reply-To: <20260204025140.2023382-1-joe.lawrence@redhat.com>
References: <20260204025140.2023382-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Provide a little bit more context behind some of the klp-build failure
modes clarify which of the user-provided patches is unsupported,
doesn't apply, and which kernel build failed.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index df3a0fa031a6..f8ce456523fe 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -343,7 +343,7 @@ check_unsupported_patches() {
 		for file in "${files[@]}"; do
 			case "$file" in
 				lib/*|*.S)
-					die "unsupported patch to $file"
+					die "$patch unsupported patch to $file"
 					;;
 			esac
 		done
@@ -359,7 +359,7 @@ apply_patch() {
 		cd "$SRC"
 		# The sed strips the version signature from 'git format-patch'.
 		sed -n '/^-- /q;p' "$patch" | \
-			patch -p1 --no-backup-if-mismatch -r /dev/null
+			patch -p1 --no-backup-if-mismatch -r /dev/null || die "$patch doesn't apply"
 	)
 
 	APPLIED_PATCHES+=("$patch")
@@ -500,6 +500,7 @@ clean_kernel() {
 }
 
 build_kernel() {
+	local build="$1"
 	local log="$TMP_DIR/build.log"
 	local objtool_args=()
 	local cmd=()
@@ -538,7 +539,7 @@ build_kernel() {
 		"${cmd[@]}"							\
 			1> >(tee -a "$log")					\
 			2> >(tee -a "$log" | grep0 -v "modpost.*undefined!" >&2)
-	)
+	) || die "$build kernel build failed"
 }
 
 find_objects() {
@@ -815,7 +816,7 @@ fi
 if (( SHORT_CIRCUIT <= 1 )); then
 	status "Building original kernel"
 	clean_kernel
-	build_kernel
+	build_kernel "original"
 	status "Copying original object files"
 	copy_orig_objects
 fi
@@ -825,7 +826,7 @@ if (( SHORT_CIRCUIT <= 2 )); then
 	fix_patches
 	apply_patches
 	status "Building patched kernel"
-	build_kernel
+	build_kernel "patched"
 	revert_patches
 	status "Copying patched object files"
 	copy_patched_objects
-- 
2.52.0

