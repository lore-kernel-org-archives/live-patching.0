Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC6276041
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282231; cv=none; b=DLRs84C+cT2uDiw835wODfIToqVW1f9c90mEbtWMn5RA/PuM5xTHihG9Ssik1CSc2Hp8BfYfiTnzXitBxV6o6j3WJmAUl6edbDjJGEgCgIIwKo+r4Y0K1kRm+iQjigLqxYHqKWbZGSazpjr4GnICwyD0YeyaBLXfHQzawv0FVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282231; c=relaxed/simple;
	bh=FLESvOGmkpQtMDp6LiILAqqDlJbD6IWAlv/XLAgTCRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPrYhriCq74nacrgHHcWwTZZ8F5p++blP2n/UZ5KynhBdNKCAtnuyfxkiRt4zzKT8Dk4FXIFjGnI8BqPLpKi+EunjJvL+XdGQudoNnR2kK0RV8pokdInz/WTtnyHuCJjzheNFGdtnHrib/jbatzAfnQA1obsNnCMIvOQMMmnr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfMvOoc6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfMvOoc6"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso455234a12.1
        for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282226; x=1787887026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w2KRkGzx+wUHA95SG64aSXZgUP19cNjyj2g5tU3/uNY=;
        b=PfMvOoc6RlVbJErlqn97Z6lDlGyc1cO0SC61zqrSK/VYHP8YDEsK8rEqJbh7Npx4dH
         XX1IXsdJGCSSz1q5jqDJli1nkx4UB4jjHML8mCL9CK0XBSv08dJzm2WOLystdCmdejRM
         caFZQgnC+LtvMEKEpXioBRdotAxytLG7DtaFjKTm5d2AzZquhf0lEphDAWsgkFgn/lpJ
         hF049UzQk4Mou43j7jbB8J2TNpzoUHJ7TF/CMSzJBv+3Xs8W6+5OJn3CEd99aAypn6lZ
         Pbtys9+L3nv8PHmOY1pobG7WgRi408BHcGLF5Ykgh5WIg0exmtw6NqLGurXsPOQ7lDot
         75hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282226; x=1787887026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w2KRkGzx+wUHA95SG64aSXZgUP19cNjyj2g5tU3/uNY=;
        b=LKC7s4qxuUbPxd75Qwb1RqVW6Ud9uUvgII6jDJ0SWSVm/oSawwyU5S0RvKd739hTuM
         K27JwCTI2fbGVpRpLf9eYl2Stro6eJKsvoN7l5ZngBWfBiN0umE4Oq7ToWur5xZdikZ2
         MBMp4RXUYSUXybpra7vYqbibA9krULRNQ9INXo4HV/hIaHGck59vXkhDkTNc3cqdJj3r
         1lAjBWIYHQlDagI+t8bEbWZN1o/HN2EWRI8yQyFB6mVmJGN0RK0GLCVVHixrFLiR4+Xh
         3nxqOQbKElnGtDH+jlsG+BV34hMPiaB7IOcUrE1EKF27C1OBUZo6bz3ZJZIDgyt8+6tY
         ko2Q==
X-Gm-Message-State: AOJu0Ywg5PldBMaikLZWN1S+2vM+Sgf4RamG9upjhziNBfTd6lCjX0L4
	QWo6v6CMhskk80l5ii1zEnjlV4RWQQef/OZkt1625kfHsf12LOsaGpp7koy1qcvE
X-Gm-Gg: AR+sD10QOf/Uf9ZTpk4HTpXghvyU31RrYzM5yC4sSwd4KNMmhQRK4W4/A+jNvn7+EMd
	0lRoq31YjLi8hk5tNtIJfXctW5ClHYolm4CGorlJLhaechqTHc0ncnoE/ovBnvdPQSVRTQJcKYY
	kj5vCp+qrHCQLLqLrxxNX24UGmk5DpSVpZXIqjwcqerhYUowTVinJJNjlmex4yXtvg7NYe52Ynr
	qndWTJWodmu03cAI32yjBTnZ9O0dUf6/h8cuROQqbYWMJoo1FJ6lJ8hOjfQxAtCv21ygNoSZjgv
	CK9Jln/Rf12DC67q4ecagDqkcMr/b0uYWklYRjnAVPH0H6jJkGt3I0RjcE9CRdXHZBrwNPjI7mY
	2kBIkp1bEfOvKRUy7HcIuEMwP0lJM5bwO4lcwJBOaPB3VyVpeR3zhtLInCbmmkFEHdz9K4cPLT7
	set+02gICcdZanK8aV3toPKPMTYUF8ZBBUoU/Bou0r2tGvDKYBhLAL4mXVXVKkXQa+mTVCNoQ3I
	Z5kNxVwvDWEXwH6WQnkPfOiZpFTF5kLxqJ71aUKZyaA0dPf0BmY0j6f
X-Received: by 2002:a05:6a20:3d94:b0:3b3:26aa:5455 with SMTP id adf61e73a8af0-3cd300f9e23mr5950451637.13.1787282225636;
        Thu, 20 Aug 2026 20:17:05 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:1d00:6f7:10c9:b208:aa96:517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15543ec0fsm2346460a12.9.2026.08.20.20.17.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 20:17:05 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/2] livepatch: Fix issues around CONFIG_DEBUG_KOBJECT_RELEASE
Date: Fri, 21 Aug 2026 11:16:46 +0800
Message-ID: <20260821031648.48195-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fixes were found while implementing the replace set series [0].
They are independent of that series and can be applied separately.

Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com [0]

Changes:
v2->v3: 
- rename the subject
- include the selftests patch
- exclude the klp-build patch
- use kobj->kref instead of introducing extra counter (Petr)

v2:
https://lore.kernel.org/live-patching/20260816090442.18128-1-laoar.shao@gmail.com/
https://lore.kernel.org/live-patching/20260818054629.69246-1-laoar.shao@gmail.com/

v1->v2:
- minor improvements and acked-by (Song)
- fix issues reported by sashiko

v1: https://lore.kernel.org/live-patching/20260813030408.9761-1-laoar.shao@gmail.com/

Yafang Shao (2):
  livepatch: Fix UAF of unregistered patch kobjects
  selftests/livepatch: filter debug messages in check_result()

 include/linux/livepatch.h                      |  4 ++++
 kernel/livepatch/core.c                        | 10 ++++++++++
 tools/testing/selftests/livepatch/functions.sh | 12 +++++++++---
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.52.0

