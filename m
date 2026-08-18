Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C71331EB1
	for <live-patching@vger.kernel.org>; Tue, 18 Aug 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032014; cv=none; b=BYHBY9+3JrMskvCssdK+bElM/UrbYGPV9Qdivv3SEzPFktL0Z/guF+MMHPgMoJ3DH0kexzeJ9YKMr5LDrh21lN14Hn86ppyJEuS6J7jyQDHyHSl3v1u4bGzgHQbGG8bQjNxiKQ0NSi4ChByQPNHma4cktwg31OTLRPY9/18XRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032014; c=relaxed/simple;
	bh=Ic4vcavd991EWodWP6ilgQOeU2lnKez3NhJuurx6/xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lY0b6o6Z4GRtwkOYm8oFwn7h3raTzPo5rI+hJ+1CrKLPKnX27Q06qg9PMlIkwn3dfafh5jOsPgeyifXB1ejJoOO6FvhVOtXC08hgM0tA9LEEzfcsu16m6EwijJo72l5Jp8/XcPno9j2GA6k4ewAyioWPUSBKLtNz7774DPDNjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvHEU8v0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvHEU8v0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab973140bso64254205ad.3
        for <live-patching@vger.kernel.org>; Mon, 17 Aug 2026 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787032013; x=1787636813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I8tDVQkXHDAWsSkxyjLOxGSjyYS6rhJWWmpCs5k6tw4=;
        b=WvHEU8v0LD7wzBoOe6bYXd9sCZwaQpbRsuXJI3qeRaSEMR37BtNyTYQm81WKHWJFZR
         kTfi9MhuYhUrh8PW7Ds1hs+YxITFsIhsMQS+B+CDsRC+t55DBDi5ofs9IrntstIOF/Rq
         Rvt26UuXBWIDv9DqgA8eAPSm2BvlWoHtNGRZVG0XUP9qr6p+vibzMVHFAk9D4GyFKrUX
         ikSJuBxbYkSTjcQ8rhjBVVNlvRTayL9CS6PEEpkbbFxuH6/12FMc+gKuKWwEWbz8ssUO
         mJHYJ3Q9xr1H0s9k4bZeb4wH8ADm6zHYbrXwK9kauhVeB00mOuPkL5uJtUNk2q//mi41
         fvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032013; x=1787636813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8tDVQkXHDAWsSkxyjLOxGSjyYS6rhJWWmpCs5k6tw4=;
        b=FrQI3NW8BwrTbZhe2HwCFy4zLNTh8mX/ZSaAROUmj6+wYxfWNmw3gudmAmfwnEUkcl
         hnkGnFRU7h48h8YlkePZEJ234YBi/cKGHT9WGrFtNkmXaZaYJp5mQ1rNidXrnJYLEkXw
         pBk8C+O2C1toi4DzTlFc6AIZdioX6AKK0pZcMaJEdmk02e4VfAXQNgQw0Kf4KjNpSvaD
         710pMRGtaUmN8wsPlbKbLpD50F5+v1rHkW3LOjfJPMcfqTO7OJdIw2X+lpobzQ/qxmIv
         Hjtc1EiIvNql+SB4MvMe9CiR9GhIeVsqfICIfFO8lpytUlCj/RbgcrhDozZ5Fn/QQe/z
         vOEQ==
X-Gm-Message-State: AOJu0YxKieBHYwx9JkjzUKaYETP1i8wCVtrZFYUY/ZXr/juRIeGvfexn
	OgmNdSAaUrFIqxsvmiwusoeU7opa5HR+YhaA3VltGlvbk9zcc5/S0FOE
X-Gm-Gg: AR+sD10xBu6JWwTJj4nmiOCMwjFVPFv4cdQs/AYBqHFxj4k5s5fvLMVKdSWMaOpF4cm
	OiFsPCMIah743Z6v8rNNZjcgCEZQWuzPOPH0V6vRT0Q8HYui/H0sF3EckOf+5VGfRmlmGGyBwEo
	tHsSLW1/cfuzfFY4I6+ajPzyX/BnUuDNTAsWh+2RculnaiyIeGuG/DIPz1Dl8x9bsu9J5VISNuV
	pTTFKC+Wn2hXhSXvCeTovba3ji19mhSD9Ub/nX21vTvvb/nhNvd/4hmHGxpqJAvr1KxHC1fzAmQ
	7XAwcTz0uKfBjP+2Ru8Im+theMpE8MfHiu9+DhE0QYPaLmioVNebCZP3+AvQJjR2kP6v11ze5sI
	M9zKDNr8UkbD2coMg5qWxQh0Er5cIj55N6TsZNlVPV4BOHXxCzZFJoJ0ODK46Lj5hqi8du6KMeV
	ZPem9kz1yZBIj2GY7GRFhL3Sfv1fq0MtVF1QqlHIX2dwzazi7t1wmdmg4eoQkiz5/A98hHh2tLc
	VtumepZjjvUbD0a37Oe+USMCmK4uDuaeAtdS/tAlD8s+A==
X-Received: by 2002:a17:902:fd8f:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d3b086d3f8mr342483215ad.7.1787032012380;
        Mon, 17 Aug 2026 22:46:52 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:1d00:3a03:190c:5e44:c783:ef9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb51951bsm12906985ad.29.2026.08.17.22.46.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 22:46:52 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] selftests: livepatch: filter kobject debug messages in check_result()
Date: Tue, 18 Aug 2026 13:46:29 +0800
Message-ID: <20260818054629.69246-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env(),
fill_kobj_path() and friends emit pr_debug() messages, and
CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
for every delayed kobject free.  All of these carry the "kobject:"
prefix via pr_fmt(), e.g.:

  kobject: 'test_klp_livepatch' (ffff...): kobject_release, parent ... (delayed N)
  kobject: 'test_klp_livepatch' (ffff...): kobject_add_internal: parent: 'module', set: 'module'

The livepatch test modules' kobjects are named "test_klp_*", so these
lines match the check_result() grep for "test_klp" and leak into the
result.  The extra lines no longer match the expected output, so the
selftests fail when either debug config is enabled.

Filter out the "kobject:" lines from the result and note in the README
that both configs are safe to keep enabled.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/livepatch/README       | 3 +++
 tools/testing/selftests/livepatch/functions.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
index d2035dd64a2b..d03461bd45bb 100644
--- a/tools/testing/selftests/livepatch/README
+++ b/tools/testing/selftests/livepatch/README
@@ -15,6 +15,9 @@ Config
 
 Set CONFIG_LIVEPATCH=y option and it's prerequisites.
 
+Note: CONFIG_DEBUG_KOBJECT and CONFIG_DEBUG_KOBJECT_RELEASE emit "kobject:"
+debug messages to the kernel log.  The tests filter these out, so they are safe
+to keep enabled.
 
 Building the tests
 ------------------
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 17810521d069..3dae2ad20f1e 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -327,6 +327,7 @@ function check_result {
 	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
+		 grep -v 'kobject:' | \
 		 sed 's/^\[[ 0-9.]*\] //' | \
 		 sed 's/^\[[ ]*[CT][0-9]*\] //')
 
-- 
2.52.0

