Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC842DCF55
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773821; cv=none; b=V6l96JzNH+ibv704QWYUU1bc+ZipTqsAqm3ejdh/hrIYm5MhXK8lMh2I9aKtgF6cerZfhG0DJ5r2GWLEQ6SOiX7vOi5S9aj7dCIwZ8VgI0aGaMo5C2Tsfl2JLLNgQykXBAl5bgJdu9ssqTIvo8P06OZG13w+3/81XmJf/MsGqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773821; c=relaxed/simple;
	bh=wOeswAh59reo9j5/CCSzVCvbol05qJJsBnwjMKw55Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Cd7BldfOVqHzN0Qsx6hl2fpt6CwTFSo2jD3GqFmAUwBQ7KfAhQInXGQWnqExZGEscfpYMFHR50NBTKyTlOf4jbXxpcH0gxEmzqzjnI8yF1kkhtHul7v4yHwUF6w/fHZS53GoKeDZT12FtRU2PpK7l2PJDZpzNtkHz9XL4GtNv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oc/C1qBQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc/C1qBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni9H5KcNm5UTYSMqPIokINPftGQdiEdiJLrvUrcD8Hw=;
	b=Oc/C1qBQ4XtcPHGSH5yP/g+/vz8W1xTF200I5fGTjpnI1f76o/IF8ub9lai+u/+kpAHYfS
	qqXzI/c06mooGeQ1nfkHsN62aWgVj64zTwg+7e8NC11R+a8QrkDh65iiUtUOSGVr4/JAlG
	obsB6Oal/4IrXGGZL44FYjFjkzNgZk0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-pC3AwNd0OS-jtPhebGsKVA-1; Wed,
 26 Aug 2026 15:50:09 -0400
X-MC-Unique: pC3AwNd0OS-jtPhebGsKVA-1
X-Mimecast-MFC-AGG-ID: pC3AwNd0OS-jtPhebGsKVA_1787773808
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74139184BABF;
	Wed, 26 Aug 2026 19:50:08 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69A9D30002ED;
	Wed, 26 Aug 2026 19:50:07 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 4/7] objtool: add target architecture to usage
Date: Wed, 26 Aug 2026 15:49:57 -0400
Message-ID: <20260826195000.455905-5-joe.lawrence@redhat.com>
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

Display the target architecture in the objtool usage string so that
users can identify which arch variant of objtool they are running.  This
is useful when cross-compiling and automated testing.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/Makefile        | 3 ++-
 tools/objtool/builtin-check.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index a4484fd22a96..c73c80af5ef3 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -61,7 +61,8 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/lib
 
 OBJTOOL_CFLAGS  := -std=gnu11 -fomit-frame-pointer -O2 -g $(WARNINGS)	\
-		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS)
+		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS) \
+		   -DOBJTOOL_TARGET_ARCH=$(SRCARCH)
 
 OBJTOOL_LDFLAGS := $(LIBSUBCMD) $(LIBELF_LIBS) $(LIBXXHASH_LIBS) $(HOSTLDFLAGS)
 
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 75b11dc85010..64651d90986f 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <sys/stat.h>
 #include <sys/sendfile.h>
+#include <linux/stringify.h>
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 #include <objtool/warn.h>
@@ -23,7 +24,7 @@ const char *objname;
 struct opts opts;
 
 static const char * const check_usage[] = {
-	"objtool <actions> [<options>] file.o",
+	"objtool <actions> [<options>] file-" __stringify(OBJTOOL_TARGET_ARCH) ".o",
 	NULL,
 };
 
-- 
2.55.0

