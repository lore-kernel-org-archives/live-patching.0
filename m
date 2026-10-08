Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1B314B6E
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472768; cv=none; b=tDjsUcDxbVLSU3RUY+AF2sbWut4VOJo+kB+EyGo6rzwwhBTdk4GGPfJeQBmUc14/lrhhbKK2FJPBu8ImXrjNxlHPUDBRt/VMkEg0SR0BavMzIXV8H1bNI59RDejBJHE46pJL+kPkJSWt/HiN3e0dYJmGk4h/ueFFnFhi5/9pnHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472768; c=relaxed/simple;
	bh=P6E6IWnwQQoaEUsp20amE1QvxK3zeNUtfNg1Q9xsDfk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=cdPxmsIEWeOHeehKXYpGh6kCqX+bA6eQpuXJm6nhIFAJerW2/bIghWuziK3jTua14V/7T2t2qIQQO1FO/PY5nozdtqOHZYxfkPRxkoNCDA6lCcmsHFleITpTXirj6cyNthxEKFTn7HgG9rKKQO+WcwoWx9QEz6PtkGFIMREMIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HivWVxff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HivWVxff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04E1F00893;
	Thu,  8 Oct 2026 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791472766;
	bh=tCmiGTZEa2zwPcCu43UNeHILu+2DgzWreqbGLYWg+vQ=;
	h=Date:From:To:cc:Subject;
	b=HivWVxffLogTwoUPuRfmYJ6eeEif+T2T4mKdFwIHtlS7URGymw8uZVDOipKyrU0Y+
	 htbEX9Sx+imrFFSdXnbTa6nlvbFqASJ3QbJSlEjvLXV806rwoiHxyPsnbvTqNM94K3
	 qJqzh0hPsV4Yz4JqlwYcyedRTz/YmldptaDSI4YiqL2+nKP/H1RV+N9A8WU22fOBBT
	 k1EuUHsLg41VorrUC0tIsWduwCPeNeqdmbn+WW4cbAi+4UOwDNwKyLppCe+nx9N7ib
	 ShERnoiFfglFit7jv1IojwbEZZQ4jmKNAKTBLoeW5It0IwMYRbpXFQq/kJMq9xUCC/
	 3w09Rxqra5E9Q==
Date: Thu, 8 Oct 2026 17:19:24 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org
Subject: [PATCH] livepatch: remove myself from MAINTAINERS
Message-ID: <6pq4rr41-0p23-2oq5-o750-0259410q9680@xreary.bet>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Jiri Kosina <jkosina@suse.com>

As discussed at LPC 2026 with Josh -- I am not an active kernel 
livepatching maintainer any more, so let's properly reflect that.

Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47946f1c507b..7e448a10f0ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15156,7 +15156,6 @@ N:	litex
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
-M:	Jiri Kosina <jikos@kernel.org>
 M:	Miroslav Benes <mbenes@suse.cz>
 M:	Petr Mladek <pmladek@suse.com>
 R:	Joe Lawrence <joe.lawrence@redhat.com>
-- 
2.51.0
