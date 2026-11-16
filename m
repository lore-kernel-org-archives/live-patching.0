Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834264;
	b=nIy9H4hrHVgHasxyLuhyjAjUYXY8pAGHPEz1Tc4I8PwC5qvbp/iF/gAQJvJxKYmwf+E+
	 D3ESYlkrvPXlsvU51DmBmmrGWcb56dAJxCuIbBEuyrA0UupGUa6NzJg3UAZ6BacZTxE7+
	 0UZP0wZTWNgglz+7KyH8arvEfVIfNKifD2e1iPqjjB8zBNHrBTGx4D4byVWtdJw2HwiuZ
	 lzX5aBPSTIjYDxu9t6haJirFJYMNJqFz14yU7WwOhg4j2sSDUupU6E7sGSbYeFXYxElCa
	 nozI1J1S8CcX1DhB0m/tJaEPrAhy6Qr9Voaq7W7Pn16uAo+NntLGVy2Tjy5OjFXhZ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ygkuWFtIpPh0HKMRFHa6AGawwsdy+SQ9VjrhwKb+oIc=;
	b=zAhhokjc2/IaGNveg3BdMjrROQ5gapTUqS1R4ZR2DLnEGSJY5RpVR5exIJqfhGCGZLGz
	 ceWIiqhxtKyMEWvqrc/DW5ivhj2yvukoAxRpY89dhMjrQaKMjoYQWnyHEGdwXKtN4M1bp
	 dAXeJ/MHVvZK+vfVJNLrCSedgNieJ4jrw9e0E4lQivXyikSO3opgg4f0y6dh4fCDySkg8
	 g7EOQfjJqvjpwCBOrMHiNeQw0UUDQrRtv0aVS8PI8QiLt+qAxLceJ5ccojaNAPWQWnlPU
	 DOSAAYbZSSTq2LoTph6bV8KL8LwC9ntUvghNqoRcoh0aWJIwwemfKXQurJbSsqf9CxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAYYrQg+;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0C606A31C
	for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 13:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F0C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAYYrQg+
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9e53d011eso31373835ad.1
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 05:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794834264; x=1795439064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ygkuWFtIpPh0HKMRFHa6AGawwsdy+SQ9VjrhwKb+oIc=;
        b=XAYYrQg+AUCMSw8F9CZ+hL/hZiQ3zbGfxnqEgtBzpCMl6PTeXh39kYwbH4Rbntup47
         FrjATOycoUM0O7h7lQEIAHRkLmIaGhWrfXA8Lxt3CUP3A1UKdfvR5v5uHVEpGU8wkmyM
         FsW6dDvIc74dYatxKUnpFLbS6NDfN1FvfjIdF6sQP+8XBNU584uHpK9PuLYFkS941XlC
         v94EPwBnZbA0sxJRKFZpu93KQ/yP504oB5g8w8diZuh+XhD4i/50x2COqBBw19TtdYDj
         bLMKF4vlas0dpU52maNZ3MzvD5gv9k1PyMfk7q9h+CQxnIpvtFOWQIlORaB0ujMkaIo4
         0+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794834264; x=1795439064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ygkuWFtIpPh0HKMRFHa6AGawwsdy+SQ9VjrhwKb+oIc=;
        b=iLLP02CU52ypyh/G+i+2n33zt5DtjJ0Q/jWYjKIeH+2Mop0pv+b5c2nE9nb9RTzQmg
         tY0unRAtRZG1zUMOfAx7kOr1AQI7VNW0rERJis56INtD6giJn5AnK01pXmRGAhAEvUvL
         BD2/amKmemlf0sEPPMIow/GRRwxUWf+VFRu46TQGD/3MTvmwRPmbjIT/i9KDyZeFZiJd
         ytAnN1mI7Mf9vQjFlRGd5EE9dv/ODIXanjBDgnn/JPls46rSILcqfXKMf/nGWbR8UYSn
         vSbPwnUGRTN/ln6Pf+AJD0IAADrP+COavkmZ9yhPTSUmqA3xBceA1poA1JQpzK4rJBSP
         yn/w==
X-Gm-Message-State: APuU4Z+93R0BTvtITufW4yH8mesuA1UsBxY51pO10NfCV5GxyvWUYqtv
	qXwTL4JBf1d8qBLbWZB8yp9naQTGd/dlOEsFoOlqo38VCcf2y5W+sZbc
X-Gm-Gg: AZFdTZf5RMB8ylAauuBTHx65/8XGao7SqzL/U8rBKDD4fZRJOBZRYlnVW4hNtmJXlzP
	JnGeiWO0Dr7nPGNQBGwFXPeSNNk5Z5c2GLt/cgQw26KSWd+uy/YsYwwJkU7wrfAOmwUBwMT+VGV
	NQNOiebE3aQ69lcElvFlzL02EG7QtekMSblCdZwNClZu6M1ZK76Gh6HqJxQ7rHFlrFM0+N8512Y
	Dv+41pfq3m6FnbIpVMiCNrzGiVi/nKynNexQOD5DANgkZEyxzhh3OMlw6HyTP5Lcyksgr/oeX38
	/JWMLf6kn/Aeo3gB4k1PA6oMp3HniXteGEusq1RlYeLr3QmFxKt2iXwMl938nvSNs7KtP2HAXeQ
	Rxr3B0mAP+rLkufIfeUKvfOXU5S6Fj7iNMuPPa9GFOz0udhBPA1ZQMGtX4Cgd0ak7KiXFBBVAO/
	LA8dj5G9TW7mns0K474nvfq/e0KpiEZGs5uyebtA+KUW9y9rr2Acc7zCpMAecNd4I7v8Q6r9qll
	ii9G+s0sm5FHOb+wGBDrnoTtLR5ZPf8+W7B1IyUCULbQxWaj4Ry9IfC54gZwqVvZAGztYu6Tnhz
	XUxrHNbHPN95ydw8BxjKfS5euF1bkWGE5mg91ga3CRJT9nYlluqvmH9JIsgrxlPksb4XYUt7h0o
	7uuD1JvFoBA==
X-Received: by 2002:a17:902:c406:b0:2ed:1cf0:4cda with SMTP id d9443c01a7336-2ee0d662924mr99921085ad.8.1794834263410;
        Mon, 16 Nov 2026 05:04:23 -0800 (PST)
Received: from yafangs-Air ([240e:46d:2500:560:dd34:9c87:2e89:5183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee17e14e5dsm35268845ad.4.2026.11.16.05.04.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 05:04:22 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/2] livepatch: reject internal flags set by a patch
Date: Mon, 16 Nov 2026 21:04:00 +0800
Message-ID: <20261116130402.76743-1-laoar.shao@gmail.com>
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

While upgrading an atomic-replace livepatch, an application in a k8s
environment reported high latency spikes.  While writing a reproducer
for it on a test server, I unintentionally set the .nop flag for a
function in the patch, which triggered the issue described in #1. I then
checked for other similar issues and found the one in #2.

These small fixes can be sent independently of the latency spike I am
trying to resolve.

Yafang Shao (2):
  livepatch: reject nop flag set by a patch
  livepatch: reject dynamic flag set by a patch

 include/linux/livepatch.h |  2 ++
 kernel/livepatch/core.c   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.52.0

