Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76936D9E7
	for <live-patching@vger.kernel.org>; Sat, 26 Sep 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790401945; cv=none; b=uwWGF/PkN9zxPpZbbnxrkZfm8Wa3bdaWqH2qYKM2nd1vJV5k9P1QgTyrFPWIwXOSnb6otbztfvydfL9ln2m6WtUQ2ulEYy/iR/1LarhMw4pnzyvpqJ++zd1K9fvJnkNcSRpUMZXA4INEaP4DIjWxIMsdLlzjxz+7b1xZwio5cDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790401945; c=relaxed/simple;
	bh=PD5T1mJ4TC0TVm1RxQrbom3pNxxAP8R2ctFS1nTpdeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjh9fBVxEBlfa01cWb8rXToATcH6aV2IuEB9H0rXC3YN/+bepI7SRKsGLlFHLdmbiU9tVvrw5MMHiRJS51tGqLzxsdShZJ1ewnatVnLsMwddGldy8RY7X2mJXfHdAP/3CYF0cP0mv837qippujzh9sq0xW7hjKwOjJbz9Ighclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRWN6Zaw; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRWN6Zaw"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2db1ca069c8so7183885ad.3
        for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 22:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790401943; x=1791006743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RvQqqAbnkRm22RnnlVacu/Ubqr6ZGt7BcP9/MOCk8r0=;
        b=iRWN6Zaw1TKvCSNgFw/yDddR2Is6z5pzRvRbq6ItStYXj+q/ZYrPdpbN1sxTFSWMHC
         IVrDy20+/CoPVOcOTFjfQhCef0fgwyp07p8tEyCPIfR/NydM9EnRqUB/UKqL2f5BkNhE
         qFjjvm84z9LY8xM4EJQnLGJo5AVRTQZ3P+TKLt9R9U2Z9ysaHOveygo+vlyRh56ER4xN
         6wSj55UDfqFlQ3MEIyIMY7JjYofvZ9IIgoKAM+6yy+rrZtBTaygNocI6ycMs/hcHtAzZ
         0lFPNJowUtfhceeZ53pqEWt1xWerQX/EoTdptmrBrFY7J0WSkd6YP1DkoLMnmzZ4NSEU
         S6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790401943; x=1791006743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvQqqAbnkRm22RnnlVacu/Ubqr6ZGt7BcP9/MOCk8r0=;
        b=WFyqf9hO8A3I7QbIF6XjhNNJf6Xc/5GeuNjdHKwgAMxxblYvfbYWEhrASE12km8Ost
         vU1z+mrDMsXI3UtSI8Y7pjOf0uj/3kXkyqp1sgCyTK54CExfX1O4w+f4laMmGRAVid08
         jYb3vBVTVmsvQTHXDp7T5Tq9/0LJnmErTaF8AzL8+YuZdqm9NAT8FORLl/rbeYUQilSY
         To+HUDOXTfFHPC8+drfvtFRm8fvhOqwchAylfdsMhSFBXvsn2u+xP0DHMAUnva0qkma4
         mzUEbs6EDID3K3D/TKoUyuBEDrZHAvvw3547+IP/l9LeZboClTnA2dUIfsOqOoxEmcm5
         9QlQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8uMYl+9pzw+VThn2K7KAoh3guV1BM8pJwMLITYkrs5Sc+3ayohD1FwCc63+sSv95fL+CBCU0Si83STjNB@vger.kernel.org
X-Gm-Message-State: AFuF++lTcy6lN1IcrsmYToENXyhS/4X4+CNGxv3U1bN66AWpZCO3Nspa
	aJs16HCD9gXV3IFbgq4Cd55Um3HwAm6nnclpuLeIRS+1h60lHPSnTa7C
X-Gm-Gg: AYBFou3h1uMmS46VhEy/4iVEDhM2YWuS/YKVHe7+Ib1ISUBh0+jJS58/zSNlKk51Ejy
	XRL1vwcKs2pKF2+x+ro3nJjkl6cmuv+cOIUttTLGwKdwW3JURN+0Qz5McMQEz0t+e2RnNzK6MaI
	xmz84fhIMlK2kW6U5tqGWUe2hJT6EckoeS/Q1foiW6MacZ7LdMb3/NWTF1mcdpO8eFsN7JzVn6V
	1wOG5Ye2K18jrbk3hY/MzPV8OLnj66Z1Efy4Wn+ueNubzNXW/J903Pxedj+ZhDE27EPR0OE3reS
	CLqRtJaye6oSqR9/Y688Jb0/EY7HGdyQ8oJ/mb2rAAOw0nLta1ixYvwtuz0Xl89JnL23vaDYSQA
	vcVAmi45OvHnvBeoSgR0CUA3ZMbILUagICXngVWbvYYfBl++BM7Ea96n+RA5SRRJhj7ANYdVuL6
	plPtWI7EnzMMDQuPdDAdS4fZB169g607WqB2Xd5EYHSvE1GpkWId+kS27c/Mpnf+f6KuBKROIMB
	li/fYFj4CSPADAiprx9rfI1l2OVlxfyfuvlnufRTUWKeCFe9APAulVm4b5rRPKP8qCK/IPSF0nU
	a9H0pL9jMxYQMumLOBEFVMooN1qxUCSOUtQcrJuapJVMv9+5JZIh2/EbBUQ=
X-Received: by 2002:a17:902:c40b:b0:2df:84e0:902f with SMTP id d9443c01a7336-2df84e098a5mr51534895ad.9.1790401943012;
        Fri, 25 Sep 2026 22:52:23 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142969esm19107415ad.45.2026.09.25.22.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 22:52:22 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org
Subject: [PATCH] MAINTAINERS: name the livepatching for-next branch
Date: Sat, 26 Sep 2026 13:52:19 +0800
Message-ID: <20260926055219.3678061-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entry for LIVE PATCHING names livepatching/livepatching without a
branch.  The repository's HEAD points to branch master, which mainline
already contains.  linux-next merges the for-next branch of this
repository (Next/Trees).  Name that branch in the entry.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..e603835e4744 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15160,7 +15160,7 @@ M:	Petr Mladek <pmladek@suse.com>
 R:	Joe Lawrence <joe.lawrence@redhat.com>
 L:	live-patching@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-next
 F:	Documentation/ABI/testing/sysfs-kernel-livepatch
 F:	Documentation/livepatch/
 F:	arch/powerpc/include/asm/livepatch.h

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

