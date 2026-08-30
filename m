Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5881AA8
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068952; cv=none; b=PsH5u9z9tmnTGCHDaVPkNKnS3zG5UAXUdOxWO6GkW5vJzU9147DeJ8JKWKN6V+1ZjrKI6tW9smHb2+YTli0dZNGwaJEBS9BziO3CuxDnl0S42Su6s4RXAgxkJSb2BK0WUHGAzW6iGAqEomw/43pjcZYsUSEIl3waE6R+tA8YhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068952; c=relaxed/simple;
	bh=FXBLSpksIirhSRXV903wcB0It4hQXCDFxk8fOpN+DlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2qPQaPvQv0++oYkCfqCnpzK+0q7VnTxZMwg4q+LNbHiHvkYmkmAVu8jTLFWcdY6xo7ItOcJQqUt+kFSFG3S/iNoMguUCsGW9jScP7mQCLeH3sbINn56VWBNjXAc8nCsgJE0nxg0X4jX95e3pIIo7WohUj+T5GwHHFaonZpADXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEo7Dp+H; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEo7Dp+H"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2372140a91.1
        for <live-patching@vger.kernel.org>; Sat, 29 Aug 2026 22:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788068951; x=1788673751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVZWfP8Be5WH503CB2oNRLs56H17Q2WRpSeogD8c8MY=;
        b=pEo7Dp+HD8Rzc/yW/0ja9xQthodZe4wK+LSmgnDi4Wo5aUiQTqAyZJxs0vcFQC1TLE
         SEiXCV1PfgA3zriFsB1MFk0eR4mGs+T7THZclZ7IUeKVFZFVydCrjWBqfYcdmI8u5c7C
         e7eFfWCM9t8+nmNhGGL2GmPDhENls6xP6qXN2aOw4OL0B78fy4cjcI4jLR9Rwy/lHm76
         xakdtfY1OZn5Ol6Y/zhxtEN4b5udt942KTsF4jHjQ9FLdF+lr3IpLn74Y//ICK/+R5La
         w+p6dqTmsSUGFk1zSCSnEKx+9RYYaGE5i6jukTbtqW0ngg0QvnJqffuUGow0OttHEwZ1
         FEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788068951; x=1788673751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVZWfP8Be5WH503CB2oNRLs56H17Q2WRpSeogD8c8MY=;
        b=EpNN6ciLCVIgO97QOdyR9f2bETGpUguoB0W8jAzlhf4Mx0Ve+OSU7fZljUslbyNM0R
         Ht6OYXtt6GEFtLn9JDnO55HpqLsaYR2+JsJj2WbIEtfoMe2myDHg6RZlvFfqEi7scJLD
         zVEVpKr/mPmuHaBYJ0ghzCepthWM+yE3wA1ZGKQBb73PsfaA4qojZZxBrisFGS3XZ0C/
         P7OEj1onONdPIhuqgTW8mS5nIOq5whY8/ghWKzLuFX7na9kpz+zm4hudrGK+mY/R33w9
         KnfEvJkGbuy4HgExc1+URqJOWfeLTtw4YXHYY75vj0zaZW5eDpJH/m7xSXJ/4rZawb0d
         JcEg==
X-Gm-Message-State: AFuF++mgHbbX+ymfeQbE4zgVeHZ4F0PpAidMEv4KBoDagW+0AA5r2z1K
	G+CbMn/k5U85CIY2qUhKPT0yp1dG/HyQLL1fQhje+FsUzolO/WVaV22F
X-Gm-Gg: AYBFou3DkrhTdopQS+wi1kxKFJume4QjajPtf/aCIyS08Ky+vRItaIsohTD4Jq9Rgzf
	qeLm1gNidJHZWE2asaQbsgvvkX5j85Pycen0Qc73LCwfw9NiSRBa1+NgSSQ52VuJQy70L38iIeF
	+5TT1kuYBRdVJVg6wahEeZiuPt5UVAoy7zbSlCoQhAlBvAMyz5gp3MzTo7MPvPAsAwd5XS0AZM6
	q/PUOBoc0mSqjv5EMeuEwsWPm/jxjK88WAr5oP0w9OO52+TcPvvhCAE/V6SS/c6qBd4WqCIvixu
	unrcCB3LxgpK6WZbMI9uC9fjEqK/GgCuMDkfYjXvIvZeDO8e3Wd3eXqslrABaTvhGFgsgQDMHiA
	XVzKEGCP6GZW0bt1zAvMNE0Yc8aGMrMrufzJP6qaVgsEtQYDcKUGtOyp2JIwnENHbywzr+/ECEg
	jZ7MkZM/jIR9TfIvKHB/wFhY4u3yuXipAsXcrZtO7EgymwLTW7ETmQomLNhvyla1/LGrHmLV+IN
	4rkEjUF/vla9yAe1GwOuSFJFDep0XMQxs82Tp5DzyWy00qplbEoEHoqiZhS7MNJEOt2zw==
X-Received: by 2002:a17:90b:5405:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-396d0de4c19mr28089442a91.6.1788068950535;
        Sat, 29 Aug 2026 22:49:10 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2510:761:2de1:2bab:6d79:724b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc555b0sm9742569a91.13.2026.08.29.22.49.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:49:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 0/2] livepatch: Fix issues around CONFIG_DEBUG_KOBJECT_RELEASE
Date: Sun, 30 Aug 2026 13:48:55 +0800
Message-ID: <20260830054857.64758-1-laoar.shao@gmail.com>
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
v3->v4:
- use "dmesg -r" instead of "dmesg --raw" (Joe)

v3: https://lore.kernel.org/live-patching/20260821031648.48195-1-laoar.shao@gmail.com/

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

