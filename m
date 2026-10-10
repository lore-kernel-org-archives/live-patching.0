Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED02D322E;
	Sat, 10 Oct 2026 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791664355; cv=none; b=DTWsthvmYOCMNRd0bmP2P9WPF98KCZ6NIrSkycivF9Dq5i8DRpt41W07hn22NZgNKdjqacPR8C7lvZb0m9S27RdMI14KN1sNNPtWGdSAPd1d1QNct+VJ8Mohh4e+zmeUduOh2vnyeBBZT7+V40x66Ao14zUXSbWvMfFrKxUW5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791664355; c=relaxed/simple;
	bh=nbQW9m1heLeiMpxuyQSXmcSWO1Z4dUwUJd9vkFE+BqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W98kUgu80yalSP2gNWpljMF29ze0Z/t2yOV7MA7q9VckO4T1C2G8hQRjeW5ZmP4k9XmFn7rrtXazhXUZCBwRJTK9B7FoBEAMkqKguvIf6N6u395cbaenPVjwnRfLLqXeUYwFnTjjVmtHvkbR1ma6ustih60Z+pB0Mrrm8ZvTUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb952LHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb952LHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A331F000FF;
	Sat, 10 Oct 2026 20:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791664353;
	bh=7ubqSi8mBtn7foUhC2Kozj+2F21zthro7kqJbXgRVMQ=;
	h=From:To:Cc:Subject:Date;
	b=Bb952LHSK+hXgJgJFaXYgEqkXHjKD4p5MeidaAdOaMP5tggOx37T08ZfIwKdnXtrj
	 K9ipMObVwhWRx3/hp/lEAGVRoFl7mdxQvvIjs3kWDxFFZpEXDsL7YsX9JyrGxcyMgS
	 4R4ZDR+iTRiiyN3wJuKF2U+fFscKa4mYVg0i33nnbZfKFNXocFH9aHeGG+BRq1MDXT
	 F4TsNxBwHp7Z1SU8Xa7sUswiLoG9xLy8XhCVPIlP8I9iIzDJ0oOLgnqxj5UTbEgoIs
	 8QSEcjenc52AP0UJ6rpOixmvncy1xBh2VSSjUv749H0hfSy1X5BHJXfo4pvPo/MpSO
	 43DlAiH17XDOA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: live-patching@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH] livepatch: Add Joe and Song as maintainers
Date: Sat, 10 Oct 2026 13:31:49 -0700
Message-ID: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joe and Song have both been key contributors to livepatch for several
years.  They have graciously agreed to become maintainers; add them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6f481e701292..269ea8b9d7c9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15074,7 +15074,8 @@ LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Miroslav Benes <mbenes@suse.cz>
 M:	Petr Mladek <pmladek@suse.com>
-R:	Joe Lawrence <joe.lawrence@redhat.com>
+M:	Joe Lawrence <joe.lawrence@redhat.com>
+M:	Song Liu <song@kernel.org>
 L:	live-patching@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
-- 
2.55.0

