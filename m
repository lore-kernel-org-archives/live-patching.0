Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5152BE32
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868932; cv=none; b=KkeuPMkz+B3L6HPMYIvf7HbE4b/yc1646LoqOjZtJ5qUcvUsCs7j4+xa21BtCYik8uC2ohTJRFlNBifmhEHLjZl52LZ/4rmc+IGYw/AJdobxcLJauT4wTCtmbXryiQ8xQ+bwMAdu9Nk2ljUf2kkZMXSfpu2SH9JfDvzKXmN9TkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868932; c=relaxed/simple;
	bh=+ea3yYnkWvkYggstAtARXqN3w6KyrKQX3QazvOPZjRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPgurLlCTYWRv6RcqGoc0VbEL+92ayGM6U35psp1cHoa1HPqRQQXpM8IvR2Il/FY2BpvTl8TLR9eUy3ajR8DpHTYdHgMvGrMsvhxw4SLv69HYp6edz1+1Jd3C4bf5/I9W9PRKZ7UpAiQoTEA9qFReYps2RgshwEQHQ9SV/zl5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5awR27W; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5awR27W"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356257so485389f8f.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 05:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788868928; x=1789473728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=487eRbWP9lyEU/S8kmCpSA9mRITwOfBc17qyoaa0o10=;
        b=E5awR27WEx8bPD1LeqecbkKIBOOPdU6nR3CA/iyv3T331T+nVkykyL3Hbd/wNbG64Z
         2yJ/kZd1/My5pp//AogqJlXLpp63gPCoVywO0QszjXlRPT+eCLBUUUAsIVmcuWvq3Hip
         1dVqlNY6YSc6frswjbtc5Xp+/lYS4TXcbAlbpL0cg48Xhxyva+4iE5VR24/q/rb2et0D
         1/d5NmKaeURV+0IqSXX+yRwZV1zIuhaoCKDk3w/OChIRAxzkRwFu1Xvxl7H1SIx0Z8JJ
         VqolXPmqqwssVsoZY2WGiFpcbYxgn/WyZH0BXQg/AukVeh9hspJKKbeJRf8oi+kSCt6n
         GnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788868928; x=1789473728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=487eRbWP9lyEU/S8kmCpSA9mRITwOfBc17qyoaa0o10=;
        b=U62oXdgXreLp3lIzpLOt/737e3cj4B9S70wFOhVYpBbd+d8qnHFAGL1W72StlpEufH
         sdDI+eyD6tPDoR5ORt1XxovYBLks5oIP/2xbGi2yMflAWtzNV4iJpyFDrq73rldAAgWH
         ryRa4GLxzPsP2nLxAwwd/QtNUIVDkLoRZIsuoRY2YzTToe12Kps/LA5Uwizf4LUT4rae
         RdvKWEM984dhLSk1Oz4YIYcWv9v0TKllmj76kTlyZ1syf6v9PseeLBuglcCjo7doKjQv
         /UDLLKWTZubv3Qn4joNxsMAuAzffgpHOt0F+KsnuK8QbYFI6yADbIGMsbqs2U9ULKe9l
         14uA==
X-Forwarded-Encrypted: i=1; AKwUvByVXQt9ZjGCWytursdwoeQCFjmLvUENzbPq5FXdm05nK7Ogoa1bNTN3ZU8Q3gP8ByKIDmrJCgXVB5vmII9t@vger.kernel.org
X-Gm-Message-State: AFuF++kUu5hZNh36NBuIODLAZPKIO5IHa+Z4HKGq3Dw55LjYDTsdkA17
	naAH8Tlg5fdoN3RYB+14tD6OwLVXZhWPdHOWrBmqHaNKz1qTVhsiZQg+yTaBDaJqPzW+fTV7clm
	s1ho5m0Y=
X-Gm-Gg: AYBFou1EDM5H9qZ1KSj/GSX6TrffEaYAmQ8JxhGRNYxekWb3yLR89lWbVH7n4oXvCU8
	iEQsgDzaRhc2hXyhER/aNWDqB180FOxmzU2OazbBT6QqgOuNvgqpPU2O5GoZS5kfDbVNADrGp1E
	4W8vUY3Mpd3ait/jKYE8iStklD/VHcxBB7BUR21noJIBOUOr4n0vPxGZ7DcHrIlGzn/mtnXqfOR
	wBKVLrNVohL+mG8+WPE4BkpRRPZE9GL6LPvN1A9QNh2z3qZr6IxSeugYIXf87la/YPRFaXaWfAb
	yxYg+2tXyOl/LAiMBRsJDNSlLk/1Pw/+f/Z+1nmcpS9PREm2MyIRb3bV21v82zqYgymAtp2k8GO
	WU0xQxckVivyXsTE9sacFqGp6ZuUT4//upsMH8495b+/wQ245U9cEFhyTOVPYXSUNQELoAaLGux
	H60+6rVK+aCh7M7abgdhwemdUnwcqW/LVg85Ec2NrwYukAFUztB4w=
X-Received: by 2002:adf:e944:0:b0:485:8ea0:da8c with SMTP id ffacd0b85a97d-485a242f46cmr5662930f8f.16.1788868928335;
        Tue, 08 Sep 2026 05:02:08 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm33929719f8f.36.2026.09.08.05.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:02:07 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	shuah@kernel.org,
	song@kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/5] livepatch: Fail object initialization on duplicate patched function
Date: Tue,  8 Sep 2026 14:01:44 +0200
Message-ID: <20260908120149.299352-1-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the patch failing object initialization when it patches
the same underlying function twice through two aliased symbols
(functions sharing one address) in the same object.

Changes against [v3]:

  + Add selftest for livepatching aliased symbols [Song, Harry]

  + Only partially revert relocations when failing inside
    klp_apply_object_relocs() [Sashiko]

  + Cleanup changes made by klp_init_object_loaded() for failing
    patch on another failures in klp_module_coming() [Sashiko]

Changes against [v2]:

  + Clarify comments and the commit message [Miroslav]

  + Cleanup when klp_init_object_loaded() fails [Sashiko]


[v2] https://lore.kernel.org/r/20260823060734.58443-1-x90613@gmail.com
[v3] https://lore.kernel.org/r/20260830173343.52759-1-x90613@gmail.com


Harry Hsu (2):
  livepatch: Fail object initialization on duplicate patched function
  selftests/livepatch: Test rejection of aliased symbols in one object

Petr Mladek (3):
  livepatch: Move code for updating livepatch object relocations
  livepatch: Clear relocations when klp_apply_object_relocs() fails
  livepatch: Clean up klp_init_object_loaded() when fails

 kernel/livepatch/core.c                       | 137 ++++++++++++------
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../testing/selftests/livepatch/test-alias.sh |  81 +++++++++++
 .../selftests/livepatch/test_modules/Makefile |   4 +-
 .../test_modules/test_klp_alias_patch.c       |  62 ++++++++
 .../test_modules/test_klp_alias_target.c      |  48 ++++++
 6 files changed, 285 insertions(+), 50 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-alias.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_patch.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_target.c

-- 
2.55.0

