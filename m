Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53166248F57
	for <live-patching@vger.kernel.org>; Mon, 20 Jul 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559433; cv=none; b=MhHfiWf3nzjEPF7je14yyp8MWQ003f6jYxUzZBPHOspEHiP2muk3XcgxJsKmny35dvtjUkIoCG4Z9CvCAWFxaIoBFpVM4fKPYZs96CwEFXGoNe8bBkhzcCZcXxgwUCL8OIs4jBaDdtok+K7MP46dA9n86t91ZM3fdYh7Hj36F18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559433; c=relaxed/simple;
	bh=egl8fX5OclETTq24pA+U2aiOMSf6mmQQrI+WM1/F3wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=JxKdxECdgcjMi5PBRbpYS17WNcRhe2i6QVr+zfRpxBPK1V0j283+yQL3mSOjSNS5Tx1lhSpa9D7eKMLSLaqqMU7nh0iY/g6IckEIJuA+V4vQIEMiHnLxHlu+jPHjJ0HVOLjGNWfC6b+FbpAcIRBzTbdTFn6C3PUm91HcP7+yPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFzjk4R2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFzjk4R2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784559431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HskUD9j9yX3UrdJZ5NicVzuDTYqDkLxcB5+ew8B8OvM=;
	b=NFzjk4R2XipuoP/LFVet7Y/mG+xsD3dxVOtwTVHIaaPjlkAj3fmlB+lJewKz6/QNG9BhEm
	z0PvvYRBhrwQfVQqFSP+JCRy7yRLJVvQfJh7fJDVyHSREmK6+XbZFTKpidm2ybBe7rN+e6
	HsLsZzEYYOstqNfFuq35/c6+AuOPK1w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-t0q3QaPhPgqV0KwCGseizQ-1; Mon,
 20 Jul 2026 10:57:05 -0400
X-MC-Unique: t0q3QaPhPgqV0KwCGseizQ-1
X-Mimecast-MFC-AGG-ID: t0q3QaPhPgqV0KwCGseizQ_1784559424
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 391FF18045D4;
	Mon, 20 Jul 2026 14:57:04 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1312830001BE;
	Mon, 20 Jul 2026 14:57:02 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 2/4] objtool/klp: allow new references to module exports
Date: Mon, 20 Jul 2026 10:56:56 -0400
Message-ID: <20260720145658.1103243-3-joe.lawrence@redhat.com>
In-Reply-To: <20260720145658.1103243-1-joe.lawrence@redhat.com>
References: <20260720145658.1103243-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

klp_reloc_needed() returns true for module exports to support
late-module patching.  However, clone_reloc_klp() unconditionally
rejects symbols without a twin (i.e., new references added by the
patch), even when the symbol is a known export from Module.symvers.

Relax the check: allow new references to exported symbols by only
erroring on !twin when there is no export.  The export metadata from
Module.symvers provides sufficient context to emit the klp-relocation
without a twin.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/klp-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index c5cc54ee562e..e14d1f32126d 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1528,7 +1528,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	unsigned long sympos;
 	s64 str_addend;
 
-	if (!patched_sym->twin) {
+	if (!patched_sym->twin && !export) {
 		ERROR("unexpected klp reloc for new symbol %s", patched_sym->name);
 		return -1;
 	}
-- 
2.54.0

