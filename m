Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38513368AA
	for <live-patching@vger.kernel.org>; Thu, 13 Aug 2026 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590265; cv=none; b=gbvuXvftnM+FxDqX6mU/WDgEOsrySU2a9npIZjKHGIUKS3I7T6mhMMLsXZGanrGXVa5cIbmdsE9xM3zS/pkhdSENLRsq6CgzRgVmUOW3YRyxk0i8NgJS7+vw9U8nT5Nggl3kZNQjyLLrKKVTTrTbemlLzgS4R4IiuxBojbnjmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590265; c=relaxed/simple;
	bh=J00Sjx7KAsY8If/NG9jcw/AV+L7gZi7rsJmtk50sp6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1pBV728iZvtX/MEpZWmj5xiWdNWDkRhkgH/dyJ8HHSPLEfGhzbX5Sbpm41X7bNI0ObFtbZpUal9r7YvzIQMIJ3lZRrjetdmJxOiDj0fzQf62pjCzW8eJQ2UU+F0dhdvsYZ0R67QbXbsEvvH0w2ZwOaJQatp2nn4y6464uah9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbohsCiJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbohsCiJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cee9b74ee1so2190615ad.3
        for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 20:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786590263; x=1787195063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3jfauEuA8I9NEdAza+p/D2pA05h0a+d5X6Qms2w2aA=;
        b=XbohsCiJvlutmZKi4IiZ9mbQqFbP8sXT/fvjiUZ1rrqEXvqFgvHJS8nQ0GyFpdFHv0
         cbdVBiD0sC4RTTAfpVXAh7RCbEDtv9EWMsDSUAg7wwJWbihqrRGPjn6vuS1ijHqDhrHj
         4Mz5T2a4IT3rJ2MSLLVQDlHMt6nea3AhW5/z69Ldu0+uEQ5DrxvNsfZcfz/bxhWi5qqT
         i95uq8Q5sv1F6C14QLBPnYV5GntXB6zRSFaZ7S902XCimiWlS/Taw2ksbakuGQaD1NUr
         aEBZ6JqGqb2bQ/sgAjxwuA/yxhGLWfajZHIKuW72foMQ024nDwKHF2UgWt88eWrOBWje
         gpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786590263; x=1787195063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3jfauEuA8I9NEdAza+p/D2pA05h0a+d5X6Qms2w2aA=;
        b=ImB/FZ+/L7wpnAlwHVmyrO1m/WG22szHIlA+2KVIYPnTDKpPN+mmOZio0Aw2NUYRZH
         A1egzSlJne9KtND/E2WBkaN04aHT2ffRlxqUsmUG3C0flpY+EVspV57jq5nTGN4hqp19
         AIGy+oTgG1NzO22rBXejs9KuAbKhe1/a2hLLWFzNriybg6Xbby7KTR1UPCT17CYJ/Obw
         zxf4lhVzGOy89HuG0AbSQm7kxa6YucgguS537vzCjRaMEztMVaNpotV1WDipMPwz9DWr
         j4ULDCmjkudppXLKvKOuxPiEY6JxMi75kiDCJ0LafyhpABonyzKOp96ksom02sIUP2XA
         7zqA==
X-Gm-Message-State: AOJu0Yzcsp5il5Oto1dWPuhELSCfzIKHrPCD8hllchI3E6zsjFi6TE8z
	uHEtUKo8jxydo3NZ1K7M1wUvz+3wE3cS6BOZ6cNecnWXOFnVr5bJPgcgc5itK/8c
X-Gm-Gg: AR+sD12Bzonb5p/ub0jyDRxXK+0UYDOx1ZKtBBWebqFd6D+XtB7+J5E0zivS6vTn4PP
	3SMsGt0Q++H6/ma497fzqR5GCR2YsxLpVGci9G6rNma1CbTJqbsWLCgXeB+gSvLTq2i19/jbYO6
	JaiymN3qkkj4tv5i2Z7uQmnwbGOfTZ3/9E1Ir+7q4bkbA99IIYZDLtrfq9pwlbIu0kwja13luKM
	4Lce7mmntD2GWl83DR1wCns2EJSEzHAI6jxahrl1GwxdEk5gPeEN+ZTkTR7Q4lQBGPojx6pPK41
	7hsAY5ZST/qbQubtbv+xe9PP0XKO3+/vNWWRrXhVBeG8RukUZUzoHQSeoX7J6YZVraDPUqV9yVX
	X8aRJbUjT8nvk9AgJZ2Qmy5A0tx14Iru7n5rFBSm6OU/AA6S7fA9OoJUdXZ/RVmwomFPvs5ax3o
	PclAD2Xg1Au76hDCeX1+ADU2pBik1Wsb1cHd5267X5p6bHN5k3GW1jedRlbJqliXn6ag0GghFsw
	pI26z/SX0EI4c4C/vx1Mr5HmihcOybxZiUfOdX7kKkDiqpqpnZOvM1VM2E=
X-Received: by 2002:a17:903:1a43:b0:2d0:cc92:f7a7 with SMTP id d9443c01a7336-2d37e852f06mr32651245ad.13.1786590262997;
        Wed, 12 Aug 2026 20:04:22 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2200:5cce:f1e9:7eb6:cffe:ce35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c200cf3sm3173905ad.4.2026.08.12.20.04.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 20:04:22 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/2] livepatch: Fix several bugs found during replace set implementation
Date: Thu, 13 Aug 2026 11:04:06 +0800
Message-ID: <20260813030408.9761-1-laoar.shao@gmail.com>
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

Yafang Shao (2):
  livepatch: Fix wrong index in funcs cleanup error path
  livepatch: Fix UAF of unregistered patch kobjects

 include/linux/livepatch.h |  8 ++++++++
 kernel/livepatch/core.c   | 43 ++++++++++++++++++++++++++++++++++++++-
 scripts/livepatch/init.c  |  4 ++--
 3 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.52.0

