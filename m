Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BD36D4FD
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344429; cv=none; b=UyQMnGJVXZxTxy3EgjG2WPyj5fn/oMl2/8nwT2JCpwVyiV6nB0DEhWfw96Xptpw2FYJSVNBD7dkCeLfXkm3lpX7nhWo+1kyIwmhCkPNrmrkOng7Mq87jGKrLj+GhkV0G6o4zKIdf+2IMf3ZKbL0I6OgQKXyA2G8FkX1lr1skwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344429; c=relaxed/simple;
	bh=rjA95X9wRpjAtY1GfKWBdoN5y5cgwOiYl1gq+DqXpPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=NTR7CAeqkKcu99/KgxnRVgZ9n9anMVLFSS1ekN6SC8Aq7OIoM4pPW0Q3BGMyWxbpLo77oKhtUzfW9YMg2+FHkxcul2/h7ufPiWDVFZm4UhRaigIcIgM7HE/LcV8wi419bcFG46k1RNVpOKdeR9+hMVBL5a3dpTXk6KG7DWE7X4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7ateKbo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7ateKbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771344427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vI/bpsWRPlSFSPRmxF455zlo8x08DsIus2PLYbbKZqc=;
	b=f7ateKbo+J5BxgipMX/Jlm+vk8hzqBg37QYrW1xek/QI/J/g4CtlU0Ak75KmpDCt1lMuYQ
	MICAKBRoqvsgHpbIU61dgTUs0DidUfEhpGQEy6EoUElQbhqwUAC7oM9DzFE517bwaZPSNW
	o0UmODlj1sJB27WglWWWNWi9++WtJNg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-MYOio7iNOqKEtVl4OYR_uw-1; Tue,
 17 Feb 2026 11:07:05 -0500
X-MC-Unique: MYOio7iNOqKEtVl4OYR_uw-1
X-Mimecast-MFC-AGG-ID: MYOio7iNOqKEtVl4OYR_uw_1771344424
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56A2418001FB;
	Tue, 17 Feb 2026 16:07:04 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C3F830001A5;
	Tue, 17 Feb 2026 16:07:02 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 09/13] livepatch/klp-build: fix version mismatch when short-circuiting
Date: Tue, 17 Feb 2026 11:06:40 -0500
Message-ID: <20260217160645.3434685-10-joe.lawrence@redhat.com>
In-Reply-To: <20260217160645.3434685-1-joe.lawrence@redhat.com>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The klp-build script overrides the kernel's setlocalversion script to
freeze the version string.  This prevents the build system from appending
"+" or "-dirty" suffixes between original and patched kernel builds.

However, a version mismatch may still occur when running successive
klp-build commands using the short-circuit option (-S 2):

- Initial Run (-T): The real setlocalversion runs once.  It is then
  replaced by a fixed-string copy.  On exit, the original script is
  restored.
- Subsequent Runs (-S 2): The tree contains the original setlocalversion
  script again.  When set_kernelversion() is called, it may generate a
  different version string because the tree state has changed (e.g.,
  include/config/auto.conf now exists).  This causes patched kernel
  builds to use a version string that differs from the original.

Fix this by restoring the saved override when SHORT_CIRCUIT >= 2.  This
ensures that subsequent patched builds reuse the localversion from the
initial klp-build run.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 60c7635e65c1..6d3adadfc394 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -291,17 +291,26 @@ set_module_name() {
 
 # Hardcode the value printed by the localversion script to prevent patch
 # application from appending it with '+' due to a dirty working tree.
+# When short-circuiting at step 2 or later, restore the saved override from
+# a prior run instead of recomputing (avoids version mismatch with orig objects).
 set_kernelversion() {
 	local file="$SRC/scripts/setlocalversion"
 	local localversion
 
 	stash_file "$file"
+	if (( SHORT_CIRCUIT >= 2 )); then
+		[[ ! -f "$TMP_DIR/setlocalversion.override" ]] && \
+			die "previous setlocalversion.override not found"
+		cp -f "$TMP_DIR/setlocalversion.override" "$SRC/scripts/setlocalversion"
+		return 0
+	fi
 
 	localversion="$(cd "$SRC" && make --no-print-directory kernelversion)"
 	localversion="$(cd "$SRC" && KERNELVERSION="$localversion" ./scripts/setlocalversion)"
 	[[ -z "$localversion" ]] && die "setlocalversion failed"
 
 	sed -i "2i echo $localversion; exit 0" scripts/setlocalversion
+	cp -f "$SRC/scripts/setlocalversion" "$TMP_DIR/setlocalversion.override"
 }
 
 get_patch_input_files() {
-- 
2.53.0

