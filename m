Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143A3CA487
	for <live-patching@vger.kernel.org>; Tue, 10 Mar 2026 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175097; cv=none; b=nCzFwMhbj1FtQbbNKNhy3uqlNhwOFRKyoZ2me2+9gKlwmNOK2e86lYLXgZ/nhgf9m7utcuxZJ8duoBT9wnMhb6YB0ckhBum8Zj7NS1kPLUWMjwkQc2PYCREyD9dypT2Wkb4k0wAMlmHfNwwU/VaMOI+af3EuG5JXj5a4VOaT6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175097; c=relaxed/simple;
	bh=QQ2fwq4lBAmbrwcBC8jptzFkJV9t3psUTv33R6+wgfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ciVd9xbkj87BRcurTLgtvjqOX0cjyiQRUa98lFTk3I1iiVbt401tzZN80xJD/c4NAhyrdYEgqg/bbosQwksDyeiEWCJhm4OuCM4OrrXjvXPR5KgUGVLpwj/mEGiTKfV9HS98kloxJpLKz1pMU+TMR6qJOvI1n8mJlw/5CwLfV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMyAVbhO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMyAVbhO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773175095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjCIN/azMEvTV9V44oEUDGxr4gmcM10BkklrAB7gRyc=;
	b=cMyAVbhOSAy9mP0tAAQi+QuwUzttSoZGGcSpuv3QOKc0mFSfNjqNgSNx01+hnpEQjzeYcN
	mMoVoM/+xuMDQm2fibwFGjebSS6o3JuBHclCeGvISe30dUaRmyiTn449q661lJMmeJDx1b
	1UkzCIzuHleknQnxojMrpPwz6tZ/PF4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-vM1SZwLnO5ur_MT4T_MbJw-1; Tue,
 10 Mar 2026 16:38:12 -0400
X-MC-Unique: vM1SZwLnO5ur_MT4T_MbJw-1
X-Mimecast-MFC-AGG-ID: vM1SZwLnO5ur_MT4T_MbJw_1773175091
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A2D01800359;
	Tue, 10 Mar 2026 20:38:11 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B81B319560A6;
	Tue, 10 Mar 2026 20:38:09 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 09/12] livepatch/klp-build: Fix inconsistent kernel version
Date: Tue, 10 Mar 2026 16:37:48 -0400
Message-ID: <20260310203751.1479229-10-joe.lawrence@redhat.com>
In-Reply-To: <20260310203751.1479229-1-joe.lawrence@redhat.com>
References: <20260310203751.1479229-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Josh Poimboeuf <jpoimboe@kernel.org>

If .config hasn't been synced with auto.conf, any recent changes to
CONFIG_LOCALVERSION* may not get reflected in the kernel version name.

Use "make syncconfig" to force them to sync, and "make -s kernelrelease"
to get the version instead of having to construct it manually.

Fixes: 24ebfcd65a87 ("livepatch/klp-build: Introduce klp-build script for generating livepatch modules")
Closes: https://lore.kernel.org/20260217160645.3434685-10-joe.lawrence@redhat.com
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com> [add -s to make kernelrelease]
---
 scripts/livepatch/klp-build | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 60c7635e65c1..7f4041a0eefb 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -293,15 +293,14 @@ set_module_name() {
 # application from appending it with '+' due to a dirty working tree.
 set_kernelversion() {
 	local file="$SRC/scripts/setlocalversion"
-	local localversion
+	local kernelrelease
 
 	stash_file "$file"
 
-	localversion="$(cd "$SRC" && make --no-print-directory kernelversion)"
-	localversion="$(cd "$SRC" && KERNELVERSION="$localversion" ./scripts/setlocalversion)"
-	[[ -z "$localversion" ]] && die "setlocalversion failed"
+	kernelrelease="$(cd "$SRC" && make syncconfig &>/dev/null && make -s kernelrelease)"
+	[[ -z "$kernelrelease" ]] && die "failed to get kernel version"
 
-	sed -i "2i echo $localversion; exit 0" scripts/setlocalversion
+	sed -i "2i echo $kernelrelease; exit 0" scripts/setlocalversion
 }
 
 get_patch_input_files() {
-- 
2.53.0

