Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14873CA487
	for <live-patching@vger.kernel.org>; Tue, 10 Mar 2026 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175090; cv=none; b=amxy1E0hdssefaxfmmcRW7l1Sfy3NC3YFkMYH6uBh3Uh1t/UJXwaaegE3v8vgx5BPIwzudzOaJufBvVLMZsAuwZZnyUmfRMpd9igEFf1I7C/xgFu7UUd2Zw9lhj1hM/dpVjaL60fHKnupzTmTsRqOhfki6UZMELPwfUkgz2O7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175090; c=relaxed/simple;
	bh=Sx4U/B2NDvT1bhukA4OmKkntlTw/1c6kVCKaNcvIO30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=lVQtaG/AP7gaaKpPgO2157kShsQoeiceUjBIJG6uWpMHLvQN9M3TJoOs6ia6NLXVcM9iLPBWiuzhR4QqyqP/8Rzb5rey85LHZCuPbd16qq7vEa7yYFZVBEeZ3+54VTNHMj/BHOcYyODqHuhNXVtTw6CY0ZpCPvB/ZPOGr9ERgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fz9H2Usg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz9H2Usg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773175088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmdyySuuyr7NQJo4C977bstZKzeHiO2fSoS6JSx3lAQ=;
	b=Fz9H2Usgd5nctBlpIm7lbE5ik8E+5YKoMZi8HwukbB5MPiLPkLOBPLzmaspJdYNPp4C5gG
	ZofBlHx+5EnyLWK3PIxU/pMtrzK6d5wJ1XgPgKew2zEAP3Q0I6sd4NEksilwrtiYcROoEn
	CeCZKBruIr8TYe/04rQk3qpOjErh+sM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-O4sxCjgEMCuSVPQ-ho07Ww-1; Tue,
 10 Mar 2026 16:38:05 -0400
X-MC-Unique: O4sxCjgEMCuSVPQ-ho07Ww-1
X-Mimecast-MFC-AGG-ID: O4sxCjgEMCuSVPQ-ho07Ww_1773175084
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FB621800344;
	Tue, 10 Mar 2026 20:38:04 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC1FF19560A6;
	Tue, 10 Mar 2026 20:38:02 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 05/12] livepatch/klp-build: add grep-override function
Date: Tue, 10 Mar 2026 16:37:44 -0400
Message-ID: <20260310203751.1479229-6-joe.lawrence@redhat.com>
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

Provide a custom grep() function to catch direct usage of the command.
Bare grep calls are generally incompatible with pipefail and
errexit behavior (where a failed match causes the script to exit).

Developers can still call grep via command grep if that behavior is
explicitly desired.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 564985a1588a..cf6c2bf694aa 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -56,6 +56,13 @@ grep0() {
 	command grep "$@" || true
 }
 
+# Because pipefail is enabled, the grep0 helper should be used instead of
+# grep, otherwise a failed match can propagate to an error.
+grep() {
+	echo "error: $SCRIPT: use grep0 or 'command grep' instead of bare grep" >&2
+	exit 1
+}
+
 status() {
 	echo "$*"
 }
-- 
2.53.0

