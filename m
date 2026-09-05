Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2727CCE0
	for <live-patching@vger.kernel.org>; Sat,  5 Sep 2026 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788598490; cv=none; b=dscEp2fZeUnVTDX3X3ZFrnJwy9HhqSw+cqi5CSQJtPukUzdD7n8bNqOwBIlWeSU47B2KuOWc3Zb7Kgl2dEVoKLBiZNghX8cQ1f+Ifgtx1EijhcoPkjE65HOwcBPaSm7yuevjLK0NynDMKytkWRvuzzA4eL47IiTsiLtYTC+Vvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788598490; c=relaxed/simple;
	bh=AzS8kxUPhvFUTkrXrorT2U2YAmKfAWnJ+Ks1vmHgAIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=REmzwFBhQr6/hgLrblYebnvOr3uiFwVUfSHgyw9ljqQ2ReUL7rfaQjuyfwQyzzkBEVv2aC9as+RVVBuIPg8WRvG2xPbUdnYJpSS5Ne0sWWutszeZfzna7pAj5RSrVPEwuX7WyB4uPJFwmUP6wKZYAETFcSyCltxKaWLlW0BSLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/p36OVu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/p36OVu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482ea739de2so1211146f8f.0
        for <live-patching@vger.kernel.org>; Sat, 05 Sep 2026 01:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788598484; x=1789203284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MFhwSRfGah5Spb5nDUFBQpIZn8bFCwRbrb5DbdOXQJA=;
        b=l/p36OVu+xiKsejefLefKTGPHfql2WSJPT7d9Cdmb0s8nWSX32ieJAT1VfSrSiAmUt
         4C1lhpVPBZXnFKXLsiluqU1ebA40KaQJizEsCock5aHTsVmbGeKN5uyLEGJq+e1/B5bp
         TwIXum8FRQ8Lq0xnhYJV4NYiqXGygyOCB2eUvEwTIuEWOpGiZVUAaLGBz1vTOolHSkzk
         gl1rmp/fH6dLS9vlhckQmr8fHKx3hvqXoaIK0WaA+YPXpVEK5poytxTvhuI07dqFBjP0
         leIP/fGcloQOhSxB1C7K/S8C/BpfaERXepdGPk+XgMBbao6HAO6cvNPmXVKHzUk70huT
         xBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788598484; x=1789203284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFhwSRfGah5Spb5nDUFBQpIZn8bFCwRbrb5DbdOXQJA=;
        b=f0XRO00v+nYaBSALHaGXTsd3TRA0r+epM4UyctxkfiEmKQBVIp3+wT+MP90YL0/288
         D5S0IeUzz/EiZpUVtOway5C1+VscuuMwa0Jah7dOGegYDEBqacy1x/S29seb8t8TW5l1
         O9b4bxSREZpIUfZQVU93Won1vskAjZ93X+2wEW7cASOzM/x0nej9T3opQd/6Gx2obKFu
         kFFeBntmPnTh6Fi9vlt5R0uOEH2dw/v4bjVCROwqEekWABarQ/NehqKatw0tu0rWStLx
         eFYPiRcwy6Wn3uTtdCXEo/9Ts51l8U7qJG6upDp2lV6FRIgO8gGdQRxSEhByT+sXLpbK
         mHOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO+dWY6PyO3CuzLsjYhJ4+zoW+matDe/Uv+nEkwYpf+COBzXfdH4skhTHLfcF0tfivvubag2bCMUwJW/hD@vger.kernel.org
X-Gm-Message-State: AFuF++kp6q2+1oU0ogHXjiuR6A1SUSVXkSOumTL+9yGGq0ZMedUpQ38l
	rp2EBd6Q5zgWTOaIEVg2g4nA2viyA+85+LlgELrPWgu2rAMtA6xvdN0kOQKvsh/j
X-Gm-Gg: AYBFou2QEXrximnTwgLZXsr42u9jAx7M8DD8jk07u0fu5ZdQG+Azi4TvInH61Yltfxp
	KUqHw6lawCZffgxIOHXBuW+td51cQZr5i2g2qxdl+RTzgas9M8/sTbR1Bb/U2DhFvLHFdWANK8I
	CcSpYOySSbFsnE96m+9Wg505p0MW6GlSLKRm4acGdmkfdt5IuXFoQQJD7RnjoSgaB7aq7L/hdj+
	n2+e0+NtcR9VW3C77BjgcUaXPPWrarYAACuPDxgdtqmV7FUB+OEIB6+OUXvHplFyDYCrfrYEb93
	lnhk69bTLc8L4Dl9ksyNijlq1r4qEEoGDY7rTarVBOfL8zpmMBmX9fFXkTvwcbyz8gAzygXQm0Q
	rJFzTMHHiYR/iCNPGP4MIsm/LATKu0htlRu9fEoqx7FkxiSvY6H36Anw876TZRfT511Jh8zJgRO
	sTnJaLuNRSTIRMxV0wxxQ7xnADMvHP3bxHGxPygfku0HYfGJwQWSwhPewM2BJ9r+nMZMFZL8lsd
	o/2u8dOvbvJWWcB5e5cD5QarAiGGrsrgSbi9gZWhSSjbRqKXG+npsJQwA5oRzbeboe7FAD9nlK+
	tmya49hYiFXdN0VGCafgokL0V4k9ErevM16m1QGijCQLS+WhL05QOAvUG4KDecS1+BQ=
X-Received: by 2002:a05:6000:186b:b0:485:8c16:a35b with SMTP id ffacd0b85a97d-4858c16a72bmr10150423f8f.51.1788598484139;
        Sat, 05 Sep 2026 01:54:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm9407165f8f.3.2026.09.05.01.54.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 01:54:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: livepatch: Point klp_callbacks kernel-doc at livepatch_external.h
Date: Sat,  5 Sep 2026 10:54:38 +0200
Message-Id: <20260905085438.40349-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

api.rst asks include/linux/livepatch.h for struct klp_callbacks.
Commit dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for
diffing object files") moved the structure and its kernel-doc comment
to include/linux/livepatch_external.h. Since then the Object Types
section renders the other four structures but not klp_callbacks.

Add a directive for the new header.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/livepatch/api.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/livepatch/api.rst b/Documentation/livepatch/api.rst
index 78944b63d74b..2a98c517da9d 100644
--- a/Documentation/livepatch/api.rst
+++ b/Documentation/livepatch/api.rst
@@ -27,4 +27,7 @@ Object Types
 ============
 
 .. kernel-doc:: include/linux/livepatch.h
-   :identifiers: klp_patch klp_object klp_func klp_callbacks klp_state
+   :identifiers: klp_patch klp_object klp_func klp_state
+
+.. kernel-doc:: include/linux/livepatch_external.h
+   :identifiers: klp_callbacks
-- 
2.53.0

