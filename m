Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D63CA487
	for <live-patching@vger.kernel.org>; Tue, 10 Mar 2026 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175092; cv=none; b=i/MwjKOA8sdm0FnNA9N48wPFi0hXxi4TNOA9Ei6jMejXaGzrYe6Xnf9ucMd04PrmUAvGlPG3QDS4WyrK2uEJglX2H7ytq4w/sS5vm+/uFQJRgcUiSitT2how4iYz2/rYUg+Mtm1yBbeyKytdC6aEQww2asUQTaLNh3PdgBFi6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175092; c=relaxed/simple;
	bh=S+c4SoKezlKoZDhYMS4kVyinJEeQ9YGB67R7YpERPU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Rf7S0P4dY09xcvTQpFWAyPjWeuBxoEF2i9UFBMUBEFL6iaHIKnm4i6z9BzY2Y9cxL2vQ6RfZ+edDKnCdpPRjNz/VtewwvetpDB3jSAEN0/gSom3H10cSnIhDXRGI99DInQ/8w6kVL80Bql1zjzNqEdDv7X2mnTsUsKW2/sCuorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QU05itr0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QU05itr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773175090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUqCp2CN1uJSshzUDfPGA0cVEB6mXS1prfC5ObPVNNM=;
	b=QU05itr0ABPvaJsTEDF9Y5cS0GX6hv5nssFXCO6aCmPE1YdGbnFFdax2NPmwKu1TpsmaTX
	SAe5BCPdtM1MBdGbuZgolQE7hojJ88WpLZDJGYsOIWBUxBSMlkwgAzyktjLHTQAoEC6L/U
	Djz+WILWGbtJ+ienoUDVvS/44AKqQqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-ep9jftDwPM2uoLNUZ10rOw-1; Tue,
 10 Mar 2026 16:38:07 -0400
X-MC-Unique: ep9jftDwPM2uoLNUZ10rOw-1
X-Mimecast-MFC-AGG-ID: ep9jftDwPM2uoLNUZ10rOw_1773175086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D77E1195608D;
	Tue, 10 Mar 2026 20:38:05 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6600319560A6;
	Tue, 10 Mar 2026 20:38:04 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 06/12] livepatch/klp-build: add Makefile with check target
Date: Tue, 10 Mar 2026 16:37:45 -0400
Message-ID: <20260310203751.1479229-7-joe.lawrence@redhat.com>
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

Add a standalone Makefile with a 'check' target that runs static code
analysis (shellcheck) on the klp-build script(s).  This is intended
strictly as a development aid.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/Makefile | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 scripts/livepatch/Makefile

diff --git a/scripts/livepatch/Makefile b/scripts/livepatch/Makefile
new file mode 100644
index 000000000000..17b590213740
--- /dev/null
+++ b/scripts/livepatch/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+# Standalone Makefile for developer tooling (not part of kbuild).
+
+SHELLCHECK := $(shell which shellcheck 2> /dev/null)
+
+SRCS := \
+  klp-build
+
+.DEFAULT_GOAL := help
+.PHONY: help
+help:
+	@echo "  check      - Run shellcheck on $(SRCS)"
+	@echo "  help       - Show this help message"
+
+.PHONY: check
+check:
+ifndef SHELLCHECK
+	$(error shellcheck is not installed. Please install it to run checks)
+endif
+	@$(SHELLCHECK) $(SHELLCHECK_OPTIONS) $(SRCS)
-- 
2.53.0

