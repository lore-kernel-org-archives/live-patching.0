Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9D32142B
	for <live-patching@vger.kernel.org>; Fri, 20 Feb 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596764; cv=none; b=qTMh6XJSG6spERDXtsay1CyC+PFMHuVKTKohuHH+glH29Vbw9DF0k1QWj9g026T6ieBYlBk4A2VdO71+noZZYX04pqBKTIgPXg+WKLeAYAHLQ4+jgyN2xNcaLQwxjt+5ILh6MYkiAiXuu/ibZ/tu5lUJtiI7gHlAM3me9BXil6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596764; c=relaxed/simple;
	bh=9L6wxGCadbxUhTie+eAuGuRz5qNGBDvi0VvXep9oOjc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OH3Hr8sYxtJzp1q6bIZcyku4+5icufdyZtYmSQ2WcQzFvRyS2xCcLUbh24qkc6HtKJnFD59slbv+A7tchDK60ES1H73GbzIOUJwRdVwHBWKS38e0YNS5V7zgZlzAixCPA8bup5dSdZdjvKbn7Lh63A1myj4gPX8jSC+UmNfPBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZZRCVxCO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZZRCVxCO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-437711e9195so1447791f8f.1
        for <live-patching@vger.kernel.org>; Fri, 20 Feb 2026 06:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771596761; x=1772201561; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfTuj8g2UgQxEXdNT1+VKRRf/DRCiRDZzw2oCkYzdwg=;
        b=ZZRCVxCO365TXoSGCi8YciZwccblxA9mPiRpJ+d8FVSkr7vXIn62Y+6iQC/qCAdIUw
         qeb3FKxgb9JuYh/R9O7eXW8zxuBOZhlZBusvrUMKFUw6z7S/qTT92wf9OL/t4k9/KBkn
         QIIc6ZJxlSxsDrHG296HOsobU4UMdtma6O2lYvapnmHkkW7gDapPRSBgqT0q9oELdrIR
         hJp3XKP1+jXRXwVWOJcpt+ITiTWaVdRYx6lVg3h2o7IcNIPBVnPa+oqPB9pH+fTG4iLb
         U8X00IG+udgwuT5RBxpX/x8anqSXkWowPdXyz5k0INZZw490Dw/GAjFceXpDhjOhOPIx
         4Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771596761; x=1772201561;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfTuj8g2UgQxEXdNT1+VKRRf/DRCiRDZzw2oCkYzdwg=;
        b=M7LccekWu7tZbI5BXattpOhY2utF4Mh/Gf0wwnlxT9mUnp0nOYTbPeZzs+j9Z6nrI/
         /OUdGGoXTLzK7tcvZEXRC/NjMP01R38PlErjriIle7kuDXlAK7zUKIIp1chQVYCsjZlA
         JUhzMDm4raN3vzapcEjmKoLbrvqDkrrpunNlDJHKtcetvkpbSTZi3Nt8xmJlK3oowhoM
         mp/rPok+byi8FN8f9XMxRoydV2Yljm4OhC15QjzKeuZ5f4tjhQobDzVpY4WDYF0U4DA2
         VSYUD+u0O4hEZzSmKvRVoOvAZT1Q1JxXSv3oN8Fm/JqkL8a1Lj9nhDz8mQLPyrAk3MZa
         8sNA==
X-Gm-Message-State: AOJu0Yz4g+ObCiVoPvezb0O4bSV3vAD8B8agLwMbrKzy5401zvF0zkZS
	bET/5pfWdDyRFDsMNzjBqTZ9IQtwWYCRyZqX87W3N/YI4CiG9IgjrK4kd8DHK/5ZcBU=
X-Gm-Gg: AZuq6aLUR8pxM54h2R1O72xH9Sg/wIRBUL70SJHTPNNu6GPsffaT6Jm90E+DkrxwCGt
	Vu2r0FUic39OpiJP6yb2ZJD7siMVAmeTQf8+m/x06JRGL+vIq9lYVvvW7uWxn6wYimemu9+8cA5
	ua/0bgYkm0+0etHmO/6RvtNDPJXGwXY35M/CjkQDLB7qEkwYIcGIXGpH6ImSsCg5rWdrtLW1888
	6TA1OtiRC9aIXkkG+IuAwC2jlRHzigC4zuNTczEtIiaFWilzZAXyLza+BCPO2nskXAAfhqwghnY
	S/cEbarxXkW2BhffqXFzqWAemqseNXYLsq8zWpAvDdDijnUx9eh+T0ps3nisHxlzDgp5ljUQobF
	mbNuKQRwz5vk9hVBhQh93+YW8eJH9wefWxbOpMOV0KG7qblVzkW73cgbzq2EJ4W9ru8/ehHwdOR
	sbhzkzqcVBACo7+4iY7obl
X-Received: by 2002:a05:6000:230c:b0:436:233c:c7bb with SMTP id ffacd0b85a97d-4396f194541mr9740f8f.27.1771596761095;
        Fri, 20 Feb 2026 06:12:41 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:822:3100:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b2d1sm60119173f8f.4.2026.02.20.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:12:40 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/2] kselftests: livepatch: One new test and one fix for
 older bash
Date: Fri, 20 Feb 2026 11:12:32 -0300
Message-Id: <20260220-lp-test-trace-v1-0-4b6703cd01a6@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANBrmGkC/x3MMQqAMAxA0auUzAZihIpeRRyqphoQLW0RQby7x
 fEN/z+QJKok6M0DUS5Neh4FdWVg3tyxCupSDExsiZlwD5glZczRzYJtM7G31HaWHJQmRPF6/79
 hfN8P01c4XV8AAAA=
X-Change-ID: 20260220-lp-test-trace-73b2f607960a
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771596757; l=815;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9L6wxGCadbxUhTie+eAuGuRz5qNGBDvi0VvXep9oOjc=;
 b=it4M8N3MS/lrT/ELZETBTZqzVRbzjurdQRvKYSXMIizrOXUzJQ7UezRKnzFPsWRtLD1H4s5j+
 sJ9RnTSvF7zAxEGTIU7LDSOmk2w0m/W9UDGAN0l9BsOu5c/HAWq3glW
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

I found the bash issue when running this new test on a SLE12-SP5. There
are still other issues that would need to be addressed, but with this
change, test-ftrace.sh can run on SLE12-SP5 withou issues.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (2):
      selftests: livepatch: test-ftrace: livepatch a traced function
      selftests: livepatch: functions.sh: Workaround heredoc on older bash

 tools/testing/selftests/livepatch/functions.sh   |  6 ++--
 tools/testing/selftests/livepatch/test-ftrace.sh | 36 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)
---
base-commit: 6d6ad32e22f028c525d5df471c5522616e645a6b
change-id: 20260220-lp-test-trace-73b2f607960a

Best regards,
--  
Marcos Paulo de Souza <mpdesouza@suse.com>

