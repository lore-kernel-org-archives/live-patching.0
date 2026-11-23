Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401612;
	b=TmEd167jIxc9xGovfHTaN5UvwW0m52b9J4XbAnLUDzIP0PjiHh4Ig1tgxiPbXRHfgxGv
	 lAtGTw8ZQP5hnGXyP4S3q6czK8CcjoKawv/Mup2ARRcb28FSFQnP3AdHNQZ1XJ8MsycDA
	 CsbLBzX8YyWWqUUKZvpCvGsyYpaJATASkRUfR7J8fFOXZLhhD8ANc2CKyrMugcwZm3YGt
	 tJvfOhtj7CeqCIrPCFHdDKvOrTz3RP3izcm1jx3kpTyzPxSn0xZBWxciO9TL+3HQd1vpp
	 4JsXuaMQS0tOi3zjkYC8xIkwU7y6LG8DOUYVewdRt+HjEjWMd2b0st05vfk2XMFaTbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7hzraDdDmqQRSuiOTFkFi214VeIL7IKeSTeSMhbaq8o=;
	b=BF2i5nxIaoF7JQ/CP3RykI+ASyS0ep8ZjhzlF3mHWTjVvSQpqzaa1YHG2hQL3qvxYKCK
	 Kokbrwyhavrz6QCaR5NUg2rS0dnE7I8OQ7NKOn61Qgl6uUSSH+rEPz2qTu8oZKLYfjunb
	 MMAgw/RPpotOv6VTnxECR6/NGEVRumC/NzEz+hokeUkt1LZJfVAkWZjnUI14vGql0lxrx
	 W+v0tEytRamJ1oInSNRj+2xrSWvWfJ8xkFcXNrzFKvVBbJ+NIcD+HUyHoBP0QY2Cicddz
	 tY8Gd7q97dbd+CPUAomhdkhL3OGfqkleSvPDx+VH/Juu6npBg326I0rgKVlF7NA5reg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JKYJIE/+";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B42606A31A
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 02:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JKYJIE/+
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2efddf749e5so15365425ad.1
        for <live-patching@vger.kernel.org>; Sun, 22 Nov 2026 18:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795401611; x=1796006411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hzraDdDmqQRSuiOTFkFi214VeIL7IKeSTeSMhbaq8o=;
        b=JKYJIE/+x14O34Aos83XZ6MOH4oZRFlm2FYsS4WajtVtmPEvQfvmBdwZw9Kzs1Ad0J
         js2ly+aTqDtY2xrFtMxfWc6MFZ6mdnwGpqzgT6gEB0mGtOmC9Zyzg+uwNqz4FNIB/KD+
         lDf+da0Qwl2VP68VhvGIRCzAHwLLbvue4mpcBnc0q2S8VnQ89DvOUNeIeqtpJ1BJZfKz
         O34JkaMuNNquCAz1KZPE31I4bsb8/RhuCl3reTb81ljmoO0WixrBq62g07YhfyBSuA+x
         SfH8oaHHdTfhceXgtz+TDBL9sUxWi7Pk11QKL/1wXqNxPKes3RTaVTQCEyHePKk7XKV6
         JG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795401611; x=1796006411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hzraDdDmqQRSuiOTFkFi214VeIL7IKeSTeSMhbaq8o=;
        b=EqLuFIr2iafzSukDrENUzIV+OFET3vRwxo6NpsgusQKRhTTDu8aKKQry/FMeZm/sjg
         LtDGqt7WUUs5sQpB3Qfolc3zEffxXRQUIBUwIcIJLfTGHKx8ERQ4T8X0H/keHGYjwdlt
         3bfT2v/lKR0yaXkDywJ+yYvzpHxmYPMP35KRhtnbshfzO+3cQrirWv07llQZkYeSHGiz
         j2KUH9vBqnFfz/pTiJ7Zsrlr04g5rEwgaP4flA+ur6KXiHcpy/oxi45pYi8ltynAijJ7
         9OzNIraWhzza2X1PTThhLWTF5ZoXZ6zQvkgjK++ICCle5xcxDPVSLafeRgBWhvzsJI0N
         9lMg==
X-Gm-Message-State: APuU4Z+cWBW15tjMq5mzlI6umrGhVmv3qi6DZfY6Fy2VSCOMDLBnCSSb
	u6EVQV8NiykZ8ukhyuiF/s25V7z1UugdGN+jAPWjcf7aw+yk1T/26Fy1pXHEUsfFRdE=
X-Gm-Gg: AZFdTZe3maJ5v1GMNcobn5oGb8XN3ONJwiZ8waD2ihcSQnprw93TAIvkajr28/7CAea
	DwPuFTvzcDsGUh6HjnuSw6TUsXK2bgfE2AVIu+7FkRTiUqGofS8+1mEz/qNLd6n3CeeIaDiR/vw
	qsfCtDmuyeccNlg8piXQwAw9HDlqckpJHMFExAyv41uyQYRigDc//Oo5pgmbFjxfISsRP1JlhvH
	Clr1d0IRMm2M9yx9wrxX7fcPtZ6Ct7casVMoOiWA85aCGaEGUWb6GYz3zWMbw1CCSs3hiTMOCe9
	6tvVWNuGXD/tVwLdl3qliLQ7HvFTzsD9ep168Be9LiOGSTL2zrePd348DkiBZ5VtG91JtrNmoV5
	qHG4arkQtA8RuV3QGbYY/hCuSO+NSKlobBDuXb9fmfrJdhdFPzkR09lOSF1EHMfs0CmNdjql1uL
	9NcddY6vSK9/96foa5gPKGBC9Ph2ljG7jaOCvgegGnMI+AjGrGx4dgS6iWAsWLoXy/iotLQzyiB
	4cSoNseBuyiNgvBX5Fv7LRe4uhkMILTpfnURZfwNrFsEr2Rrxc/RDaH/GV8ojUcj1c+m+BG90DN
	bCyeTuJZ7lWQsg7Pk6Xl1lWE7X+FBO0pR8L9tSELsXvqGd82YBvk1TXwIXATswLpIgn3nhKBT5I
	eIzyC1wcaiUgC9Pl4qTX0XB0=
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b41c96151cmr6657246a91.38.1795401611080;
        Sun, 22 Nov 2026 18:40:11 -0800 (PST)
Received: from localhost.localdomain ([240e:46c:1b00:720:54e4:b505:2937:4e95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7f4899sm5917286a91.4.2026.11.22.18.40.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 18:40:10 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] livepatch: clear internal flags at init
Date: Mon, 23 Nov 2026 10:40:00 +0800
Message-ID: <20261123024000.15130-1-laoar.shao@gmail.com>
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

func->nop and obj->dynamic are internal flags. However, a patch module can
set them in its static initializer and nothing validates that. The release
path uses them to decide whether kfree() has to be called, so with such a
patch the kernel ends up calling kfree() on memory it does not own.

Explicitly clear these flags during init to avoid that.

Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/core.c | 2 ++
 1 file changed, 2 insertions(+)

---

v1->v2: clear these flag at init and simply the commit log (Miroslav)

v1: https://lore.kernel.org/live-patching/20261116130402.76743-1-laoar.shao@gmail.com/

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 517fe427ff92..98a81ec203dc 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -952,6 +952,7 @@ static void klp_init_func_early(struct klp_object *obj,
 	kobject_get(&obj->kobj);
 	list_add_tail(&func->node, &obj->func_list);
 	func->obj = obj;
+	func->nop = false;
 }
 
 static void klp_init_object_early(struct klp_patch *patch,
@@ -962,6 +963,7 @@ static void klp_init_object_early(struct klp_patch *patch,
 	kobject_get(&patch->kobj);
 	list_add_tail(&obj->node, &patch->obj_list);
 	obj->patch = patch;
+	obj->dynamic = false;
 }
 
 static void klp_init_patch_early(struct klp_patch *patch)
-- 
2.52.0

