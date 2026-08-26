Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078C3B42F6
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773824; cv=none; b=DjO6ncI1yRw+D/f4BY4B/0DEMV8g0VIo9wHXyoDXs8JtOer1xOgkuVMAY5/6zPXMusQKnNBjhtdzci8GQH1zR9I0IwfaiJt7LG3kpvkDzchznzpVV2ORIs0SQfz9rBztL4TiX0y57N6ith2vZ/2B0YtS7UzqLFL90AVn98OARXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773824; c=relaxed/simple;
	bh=gT84oLqKneCx/xfIaDZMtPkvXkb6oh5jxYLs0pXmR4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=XGTxYddL5PWxwkEcivdxM1lXSTmXdXlRWjq1YYeF/0JLDAP7MlOIWXQ0ZT6eMORU+HVIO0cVMQe3Anca2oplOEBB8xia52n6gVi9I35pXw0jR9m3L90nkL8r37mWTk7O/+bPJmSQSq3gy17o/qj/vYDpGZTeL04OpmZablaZ8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3yH0fA8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3yH0fA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJKn8lNHbT6huHtgK5r3wA8kYcI0Pjq8AzZuZeImfdo=;
	b=I3yH0fA8F+SIZN199P031fCwAjDLRMG9b4M50LDhsvXFQQMAWlFChw66vDlRxSK2vy5xzu
	B4DXk1+9UShjYN0FbOURwBOyJXNotN0P7KED+QUjkc0Hk47Jrwna+BPc6T6N2TXp9UxpL5
	5uLdQhaLnJcb6KbHiH7WxzEEFsLt410=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-ZzMnLWoHMcGVvetPMy-O9A-1; Wed,
 26 Aug 2026 15:50:05 -0400
X-MC-Unique: ZzMnLWoHMcGVvetPMy-O9A-1
X-Mimecast-MFC-AGG-ID: ZzMnLWoHMcGVvetPMy-O9A_1787773804
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85F901955DDC;
	Wed, 26 Aug 2026 19:50:04 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C0EF3000239;
	Wed, 26 Aug 2026 19:50:03 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 1/7] objtool/klp: simplify read_exports file handling
Date: Wed, 26 Aug 2026 15:49:54 -0400
Message-ID: <20260826195000.455905-2-joe.lawrence@redhat.com>
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

Consolidate the Module.symvers handling in klp-diff's read_exports()
with a single error path.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/live-patching/20260514204741.1ECCAC2BCB3@smtp.kernel.org/
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/klp-diff.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 16681a76f13d..1726d17f31e5 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -124,16 +124,13 @@ static int read_exports(void)
 	file = fopen(symvers, "r");
 	if (!file) {
 		path = top_level_dir(symvers);
-		if (!path) {
-			ERROR("can't open '%s', \"objtool diff\" should be run from the kernel tree", symvers);
-			return -1;
-		}
-
-		file = fopen(path, "r");
-		if (!file) {
-			ERROR_GLIBC("fopen");
-			return -1;
-		}
+		if (path)
+			file = fopen(path, "r");
+	}
+	if (!file) {
+		ERROR("can't open '%s', \"objtool diff\" should be run from the kernel tree", symvers);
+		free(path);
+		return -1;
 	}
 
 	while (fgets(line, 1024, file)) {
-- 
2.55.0

