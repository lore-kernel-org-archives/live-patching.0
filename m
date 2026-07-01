Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98839478B;
	Wed,  1 Jul 2026 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886055; cv=none; b=TJG4P9TKGaJRo+iXd8TBG79t8/8E+YDTxZCxQom6Z292PJGrYQbO9ui9tlGWMn5uI73/v2AXdMqLsreWdvo6zBfkPy6ZUQBi8zQtYDpXb/+6IthBwIUg9Kfgoh4sDGpE7opMZsrCFh9bMYJuqhFQzEn/ynCHB6yStp1EJE8+U1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886055; c=relaxed/simple;
	bh=whJA/52kffShqPRaXTUn1O4/6xWR/2RcAcXsOX6Ps0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=taSHC8gJ811UqVbw5b4JykQppmlWei2MiMt4r70CGowBEDQkqimb4zr1rd9D8HRnaxN+IVLWmaXVQKw1Q1HPqPZuCIrZGhkpLYqdN8I3O2PYXDLSou7SGwSnBvGXTxeAPxJ8Nb8jaC4K3QWrAIr0uP0Yd7cPpJN55ZKf9bpWkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gEyM28sB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gEyM28sB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eg
	Ph4kXPM1CUfGOuTJsnADWlublJo2QXfQhccoY0ezo=; b=gEyM28sBxbOhpAJA6e
	CiDDIDcflASMZjYyuCBKhKVobXPBYgeTRYYfXvlgTMe8hlu9RUd7PvR0EmpQaUVe
	X7w3iqcvV7tDsE7Puc1EsniD3/HwHjF3UFzLITCxk88igvgMsomH0Bia58nvFiOA
	lWTBgG3CKeTp5st8Cuig3N9D0=
Received: from n37-115-038.byted.org (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXPv6DrkRqkQ50HA--.26S2;
	Wed, 01 Jul 2026 14:07:01 +0800 (CST)
From: Shihao Ren <rsh15355756202@163.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shihao Ren <rsh15355756202@163.com>
Subject: [PATCH] livepatch/klp-build: Fix wrong index in error cleanup loop
Date: Wed,  1 Jul 2026 14:06:55 +0800
Message-Id: <20260701060655.2343093-1-rsh15355756202@163.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXPv6DrkRqkQ50HA--.26S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xryfuw4rAF1rGrWkGw4fAFb_yoWDWrbEkF
	yDKr93G3y5tw48uwn3AF4kAry09r4fXa4Skrnag3y3Ar9Y9rZ8Wan7K3sIkF43WFW3AF9r
	Jr9FyrWUAF1FvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZMa03UUUUU==
X-CM-SenderInfo: 5uvkikytvvlkawsqjqqrwthudrp/xtbC6wV4hmpEroV4dwAA3a

In the funcs allocation failure path, the cleanup loop iterates with
'j' but frees objs[i].funcs, which uses the outer loop index 'i'
instead of the loop variable 'j'. As a result the just-failed (NULL)
entry is freed repeatedly, while the funcs buffers already allocated
for objs[0..i-1] are leaked.

Use objs[j].funcs so the previously allocated entries are correctly
released.

Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
Signed-off-by: Shihao Ren <rsh15355756202@163.com>
---
 scripts/livepatch/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index f14d8c8fb..16aff8f73 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -51,7 +51,7 @@ static int __init livepatch_mod_init(void)
 		if (!funcs) {
 			ret = -ENOMEM;
 			for (int j = 0; j < i; j++)
-				kfree(objs[i].funcs);
+				kfree(objs[j].funcs);
 			goto err_free_objs;
 		}
 
-- 
2.39.5

