Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678128;
	b=V16jleTgFBoX3iIHJMsjc9GgaXnt/ZRYm5W7y5RBnszfvM7r+0iXK/+i8HGY5kTlBqAZ
	 PkqKZ2RQpfOHYCuJUtC/kYyB/mQrkSs7aE2E7xHR8QxUMTT5yjDl3l1FvyuH4sHkFV0MW
	 qEWZTxu2TWe0TPJIL9OhLhrv27D6CCLoaeXLdf00BLz7I1qRkdhUsg5B4mHU7FnjuMc/L
	 gr+2jYNs7jCwXeLmVXB/4BLu2UYfcQSMVT5HW5X3ehj3kznTnpp7ngrHGo3BszqrDPwDj
	 gzrVjm+PqOQbd75bPokedQzwAC3n7jjdV30JeMQTKqdogICj4YhwLwLrOE4qJMAAecA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=METJgUWTWcnOb2elGJk6Moe2jqeiarxjcpi8RUUfpFI=;
	b=x/zOPHpq4Vksr1/WPW4C1MfoW+MoAzgGrLmGoANN0M08qxLbBbEoBDhnji2nmqHPBorJ
	 X+hPVdgcudH7xOhgDTTHt1muW+8Ogd3+DGRcghEtQ7eSIEw7Zf2O2LMTmP+wSElyNi64D
	 tzmAKS0gj+osp0zKt5PLmUDKGd1FJb+HtnKtjJt7qiiJ/G2IaEoCaXSfmuJssn5UCiml0
	 eAPPgf4jVuAHc2udyptZxENGDJiq/7/DSDsLl19W0QozcWGum4P4AsrstkYCNZM5B5VFc
	 7BR4wWY6Q4pI1QQmkc9YGxo93P6TjPlFOIzh6i9qN6Z0OTA8jt67lcTwt5Ste0pLbCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QXV0pYAu;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AE606A339
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 07:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10AE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QXV0pYAu
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso3372802a91.2
        for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 23:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795678127; x=1796282927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=METJgUWTWcnOb2elGJk6Moe2jqeiarxjcpi8RUUfpFI=;
        b=QXV0pYAuSzP+aTEMZEfFjKGJmUpnCcSJW61IV7dDyY6np2JCpEps5Ge7KkQCPUlfqN
         fU3m86r0IAiZPt/5rmXAuYDmrXBbBe9za1JsfbrYIC+45RNNYGGUfrpZ9G+iomLmYD4i
         hwn1YXEDSVjOkelQgF0ij1pmbZjtat2eB4KwIcQ34Tll1WgqEp0+NpmVE+ft7D1IDrK0
         lg/pZ2xF7kHPl3CLCKZWHcYpIVKV7Ab2d+gXGR/eYGoLZ7DhGaiWGVOwHotet96oJNlx
         aRk7JDTxUbUZrzyBYiKGK/Kpg5Edw5Pl51QZgVPdLzCgKvn91s6VsxmYmANwEsfCwPuq
         4yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795678127; x=1796282927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=METJgUWTWcnOb2elGJk6Moe2jqeiarxjcpi8RUUfpFI=;
        b=o5+uD7QhIrMteXRgHeXHfJZl4NsdnMFXNQDRHkKsckoRkzq3ba9X64/Xa+yTx1ytzG
         o10NoHJN2IW2ZBiA+Ys8fvCNFFktiAw8uM/10PjrFE2e5U8KLjMPbcBqf4LAIA3LLnSS
         2/MbtgWqAzIxGvCQ8/YF0DeRhRRRcONzTIs3VLgvnKu80S/XUwBJjAwTSmXQPhQb8Lgt
         PahPt7kEt7Fy2HZ/gQW0KUPawODyWrXwbU5j2a/hH20kBBYzgIsUmM1ewF7CfinWoBe4
         rEfI6+XQt5E97O/ajtr6UZYUhqmxTgL/7usetexxFHoa35XK1bhbVocnVhg+7quMlwBs
         fKKw==
X-Gm-Message-State: APuU4Z8XEutRFsXaD5m77UOCuocJsNNrYDA159+v7ieYelQLDpoEbiUZ
	4ZLXS+l6DQPUrNLIhMCsVm7N32AQ20CwKj5AJfbdrg0mYvf5lcU+8WjW
X-Gm-Gg: AZFdTZdtug/ST7ByO9LV6aovcCnpTbp4vccOqM4xr11RUQSm9MrBVnJwOu5EGFkoLVx
	EJsienzW/065P+z2bpz3/OdGIuRcqwWUPyy0oaUvnLy1FXcKYCozMxwyNna5yZv1b2uDfrVcmDl
	yUfyMxtrO761+7aiaagUW074al6t99GOgPk2Z3DCX0CxbG59kzOuQjA7wGMkV6iHw0nu9ohZzWQ
	zuNdIy091atXAIZT7/pXIAPS+G93hb5fbZf9QfH1fHQZSUnwCGGudsWyV2GutxroYJs23IJKKrZ
	wbOP9sNvX44suwTwXFwGphbbmyuiLJRmVsyucCmbA63GVjJWIkhXqPBANAOpqZv6E6H7ObtU8uG
	9/58eYTb+z/A8y/2Naaw4djushGpMOhepriUYcr8fk70AVnNV+tXDgbU8R5JBX/or8+/7h3PdeX
	qUgTy2LTfgEb4GWcYfZyKJ+oIJtXUkO5Ya4g+b66VtGRFHIarHIO0v78JSDGcFXabhIzKj+khDS
	7o3xOJTBYsQxOvdwYiI0SLtI0NDi97IsMDniX/RSfcxgMLMGldj+kaR4hWeYNrPfeLi57S+Jufv
	lD7pmecpUtDwpSwSpiJLoQFpwnFiTsPOXjlZx35yz38Ms4znkTm5eJ/ZksMb3owAuJ4o2PjHKe/
	DRGbl6OcbUwcDUQf6In9cchBsvis/v6/i0eaag210Nfs=
X-Received: by 2002:a17:90b:5109:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3b41c953f98mr20801256a91.49.1795678127110;
        Wed, 25 Nov 2026 23:28:47 -0800 (PST)
Received: from localhost.localdomain ([240e:46d:2300:827:b108:4552:5e9:4319])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm14772112a91.0.2026.11.25.23.28.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 23:28:46 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/2] livepatch: Reduce tasklist_lock contention
Date: Thu, 26 Nov 2026 15:28:27 +0800
Message-ID: <20261126072829.97792-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch #1 fixes a pre-existing issue on PREEMPT_RT, which patch #2 relies on
Patch #2 reduces the lock contention in the livepatch transition

Changes:

v2->v3:
- fixes a pre-existing issue on RT (sashiko-bot)

v2: https://lore.kernel.org/live-patching/20261123024119.16154-1-laoar.shao@gmail.com/

v1->v2:
- improve further by skipping the second pass if the first pass fail
  (Josh)
- fix race between klp_try_complete_transition() and
  klp_copy_process() (sashiko-bot)

v1: https://lore.kernel.org/live-patching/20261117130848.65142-1-laoar.shao@gmail.com/

Yafang Shao (2):
  livepatch: Protect the per-CPU stack buffer in klp_check_stack()
  livepatch: Avoid blocking tasklist_lock too long

 kernel/livepatch/transition.c | 74 ++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 15 deletions(-)

-- 
2.52.0

