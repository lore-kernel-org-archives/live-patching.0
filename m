Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427736C0CF
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344426; cv=none; b=OwVhOg7oI+lUxzvo0ZXaasOVzMaWAKkYxDn40MRHNfmcyHh5LVuHxAQOMCg6UkqhMUplKvMVyAUomKze12F2+3aW6D889n/snSaRPfZs+l/qN37HoM6GTDo6PB7QctGSbuIE4x5EbVkFAGNvPyiMsxJ1X+zmznKpEBNPzU3bcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344426; c=relaxed/simple;
	bh=pp/d5srECeLmmVmMQve+aZ/N/V6SIb/G+QRkNzWzkaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=tZS8vzSyuVI+pjV1Yrt0P4RWKJjE8KN1+8iYqT+OEiNmSEZV3f2sVuxN24YXQuqh0mqACbWVWVjD+rw+TM/MpAd9JINwzS7QqqPNCVO27+6oAiaXe03P9nuaGgVb2431BVV6xITYaAspFovPvTmu/Fwd8k3yBTHbp/9KkJxZMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNRMkEEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNRMkEEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771344424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJMHxekbovP+FtN64ndBWG9eAxCU/FqkeZf7o31tHAs=;
	b=GNRMkEEnW1fT/DZkS5UzUTURKJjGsjLe8ddqQDvlZOKsPIYYlTnK1DWevIHr7/Yk+Pw3xk
	VeCu9OkG2Ftz8+RcRDY3Kb/LPSEDoUww5RIEnnu2QyNY3tUV06dytUt45oCQDy1wNWqG/M
	X+svDm4I/w/+58jr0lCMPx5hcQU/240=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-V2D9TEkEMb-AY2yE0GkUPw-1; Tue,
 17 Feb 2026 11:06:59 -0500
X-MC-Unique: V2D9TEkEMb-AY2yE0GkUPw-1
X-Mimecast-MFC-AGG-ID: V2D9TEkEMb-AY2yE0GkUPw_1771344418
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 049581955EB7;
	Tue, 17 Feb 2026 16:06:58 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAD5B30001A5;
	Tue, 17 Feb 2026 16:06:56 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 05/13] livepatch/klp-build: add grep-override function
Date: Tue, 17 Feb 2026 11:06:36 -0500
Message-ID: <20260217160645.3434685-6-joe.lawrence@redhat.com>
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

Provide a custom grep() function to catch direct usage of the command.
Bare grep calls are generally incompatible with pipefail and
errexit behavior (where a failed match causes the script to exit).

Developers can still call grep via command grep if that behavior is
explicitly desired.

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

