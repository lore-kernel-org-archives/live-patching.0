Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021874;
	b=w+8TLRmr4tZIqEtZ4JLk2LWwiuOeUWUm78LLeorWlJBlnmzGModfxE3oJsSr6hEM/NMD
	 8gkeL2XkNCrwgHeorlOlfMtjkX/ni59iX+njSdmx9hv2w2xuAtlUX7QH69k7N/iDDRMw5
	 4xjCLZIpdX75Dqd722tbdlMV2QMNbiuLzLdKW/xUoyg5bdw+4Mfu2C5z9bEUjEm+zB1m5
	 UTj/n5nfsDgywDNXL4iT9KKVqGNF8yQM9NmUAiiy8a/Sjq1ZEKk1pJ8lB/TMMG7yvQ1wA
	 oET9Vxp4+XHaPsMefwKz3ZUguXfYHLebk3wN8m0CureRxd6waVgwSXgjFrRHsaV05gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0NEUYZq26o4Xkjy3jaiogMRlNrImZbcxBkDaRpeXytw=;
	b=ScLr3RnTJbDHun00soLrT2vNUUM0c+Fv86D7NA6vzur+LyzhxTpNBNcv5fnVouWmYSq1
	 I4xZssySVi43MfuyOyhHv72ADPMyzyieJgky3r0Tp9bmLWLn6xtfHqqeeDOM/jSsuAWuF
	 ITDcpP9joxK1gJkz1P7ycxRbf5/iYnTPHck2TnNezS6V8LE/ShCm1/YvuG56ICBxEYZyC
	 O9SJy+MzxdFFpJA1sLwk+3+hjNdHHbwR8li+oCONOkuxsqyF7QXNUA/WVr+Z8faejqgoo
	 VvXjZEdX9WKpRj3cenzb5GgV1eG/m6Gbvr35FLvunDsz3Ue30d/ezwcqKiKnpZtV5yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHe4VNCZ;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6219606A33E
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 13:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6219606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHe4VNCZ
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ea759cc9b6so10809685ad.3
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021873; x=1793626673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NEUYZq26o4Xkjy3jaiogMRlNrImZbcxBkDaRpeXytw=;
        b=IHe4VNCZIi0aMoZmMjTY+Ji3w6v8XDbepv+sHDW4FF2aknFU63r83+HlwXRMSzJCmG
         WzD3Va+/3RFcB6EwtR2mb08rkK/kIb+OOzGLDI4QbpfRCV/4PrP/LynPdOUKQHVCbvzc
         Qijmpl87zwlBdKn+j3Dn98HsHoH2yMdHv6PkehQiCEYjAHlDnBvKuhZqWTDQ6YwmGzL8
         GFa/5kAlI09rGCqJg9n3S2PS/7XeGf14MyjWuYfUQ0DFH+MtLNzCYVSWJxrfYjopsVv1
         q9pSk5BYxQba4UaFzjbi8sRAy7Iq3nj1K/HTPRqsQHjImiQe37msbrKikQxLK/CJs7Oe
         L61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021873; x=1793626673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0NEUYZq26o4Xkjy3jaiogMRlNrImZbcxBkDaRpeXytw=;
        b=qTl8RxT4AW+ovORhmD5wx+WJRSW85UQU7jVaNz9vX+e7Gz+aGRbFPYV2RByt52RdeW
         K4A+fH0bPMJnTFOrR87mPelvGlN1XE2/uzqu3e/vwrLlQL+F5XIN+E+OlSoKqHBZdz59
         dHCMfqJsl/YlbOAnX0wi8R43+1d5YtFUq1k/oBFNHdYq6aPCETsBQWu3GUH1wbuy7StO
         7M7Ly+9BAmPgTnRhbFi4xfoitPVmciDI10nbDFApdF1PYTw8qtn9fF1e5p4JdQnXfF/3
         ZhUsMAWRuwa8K5ueGCb+VD8cb/P1AbPjoA35v2eEBvB3Kg/ohQ3JgWwymQ3ZyyEn1oLG
         sC0g==
X-Gm-Message-State: AFq9FYKcZ7xN4gkrwKps4MTsnGr2OmU9mLlzmf2+1Ue1S/Kz9GvOyIHx
	8FGfbMcDf5+7dxZf3ZhpA1WotDD3aRtZzytz78cYUtp/bfsXUlwaAbXV
X-Gm-Gg: AYBFou1eFVlcLWnPM3oAngO74RFxikrx1C4npkrgYPh0+5SOrjJPgl7oLlX+ZdUXtGc
	dq3e+Wdj9X+8Je4dQ/zGmcZegq7tWmrArMXcVjd8eKAjxqCk+FzGj9vsRFxlDpR5uvfGVMdUjd1
	fcBgwr9//GfwbVQkF425CJoxB9DCqk46dyqGNKxDvd+HjZPazGn++t47k7y6kWkRow1n0CRfmNb
	SfOr1YtMdkobPsj4RNQPDAqkW4EWHmL/YFinxB75IPhNk/0VP2bxWmnjCx90h6C/6MtPAbzb7qJ
	aiVDj5YC0DnUjLF4Ph4QCvi36L/WYLIFZEkTIk7D2AK15C+Uc6V9V/chhQwthHYxiyzuNYqyDqe
	rwFFsbLfCEMBixy5FNxx9aGRamwAfROYF/hh+wiPP/2lwNMW+zxISb6Xvd0x+4AtbLgr3du3oyZ
	G+S/ZRxk7qe0yHXeHFqXKF/1IRITvpK3+6mOumsOMA2gjcDSYjW+8WqxsrDosaqr2eXoFe8RRH5
	KalPIkbQZfpcz2egyWIxPug1Q6Ts9XDrGuXEsZzWfBlMh6i4zHuUB6l12ivDZfXMKnk0796DNwl
	n3RzRmiYedzAiSpjuCTMlPP75Vd6By0KWjIKSw==
X-Received: by 2002:a17:903:26c4:b0:2e2:d09f:d770 with SMTP id d9443c01a7336-2ea9c7fe3bbmr62581695ad.26.1793021873016;
        Mon, 26 Oct 2026 06:37:53 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:484d:51ee:4f49:b5a8:aabd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a5cf0sm17447055ad.52.2026.10.26.06.37.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 06:37:52 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v13 8/9] selftests/livepatch: Add state test for provides/obsoletes
Date: Mon, 26 Oct 2026 21:36:50 +0800
Message-ID: <20261026133651.40061-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
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

Livepatches with different provides ids must not share the same state
id, unless the second livepatch replaces the first one via obsoletes.

Add provides/obsoletes module parameters to test_klp_state and
test_klp_state2, and cover both cases: reusing a state id across
different provides ids is rejected, while it is allowed when the new
livepatch obsoletes the old one.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
---
 .../selftests/livepatch/test-provides-obsoletes.sh | 239 +++++++++++++++++++++
 .../livepatch/test_modules/test_klp_state.c        |  34 ++-
 .../livepatch/test_modules/test_klp_state2.c       |  42 +++-
 3 files changed, 299 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index 78a644f..b92188f 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -6,6 +6,8 @@
 
 MOD_MEMINFO=test_klp_meminfo_lp
 MOD_CMDLINE=test_klp_cmdline_lp
+MOD_STATE=test_klp_state
+MOD_STATE2=test_klp_state2
 
 setup_config
 detect_provides_attr
@@ -226,4 +228,241 @@ livepatch: '$MOD_MEMINFO': completing unpatching transition
 livepatch: '$MOD_MEMINFO': unpatching complete
 % rmmod $MOD_MEMINFO"
 
+
+# - load a livepatch with provides=1 that registers state ID 1
+# - try to load another livepatch with provides=1 that reuses the same
+#   state ID. The second one will replace the first one.
+# - disable and unload the remaining livepatch
+
+start_test "same state, same provides"
+
+load_lp $MOD_STATE state=1 provides=1
+load_lp $MOD_STATE2 state=1 provides=1
+
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE2'
+livepatch: '$MOD_STATE2': initializing patching transition
+$MOD_STATE2: pre_patch_callback: vmlinux
+$MOD_STATE2: allocate_loglevel_state: space to store console_loglevel already allocated
+livepatch: '$MOD_STATE2': starting patching transition
+livepatch: '$MOD_STATE2': completing patching transition
+$MOD_STATE2: post_patch_callback: vmlinux
+$MOD_STATE2: fix_console_loglevel: taking over the console_loglevel change
+livepatch: '$MOD_STATE2': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE2/enabled
+livepatch: '$MOD_STATE2': initializing unpatching transition
+$MOD_STATE2: pre_unpatch_callback: vmlinux
+$MOD_STATE2: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE2': starting unpatching transition
+livepatch: '$MOD_STATE2': completing unpatching transition
+$MOD_STATE2: post_unpatch_callback: vmlinux
+$MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE2': unpatching complete
+% rmmod $MOD_STATE2
+% rmmod $MOD_STATE"
+
+
+# - load a livepatch with provides=1 that registers state ID 1
+# - try to load another livepatch with provides=2 that reuses the same
+#   state ID. The second one must be rejected because livepatches with
+#   different provides ids must not share the same state id.
+# - disable and unload the remaining livepatch
+
+start_test "same state, misc provides"
+
+load_lp $MOD_STATE state=1 provides=1
+load_failing_mod $MOD_STATE2 state=1 provides=2
+
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=1 provides=2
+livepatch: Livepatch patch ($MOD_STATE2) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_STATE2.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE/enabled
+livepatch: '$MOD_STATE': initializing unpatching transition
+$MOD_STATE: pre_unpatch_callback: vmlinux
+$MOD_STATE: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE': starting unpatching transition
+livepatch: '$MOD_STATE': completing unpatching transition
+$MOD_STATE: post_unpatch_callback: vmlinux
+$MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE': unpatching complete
+% rmmod $MOD_STATE"
+
+
+# Take over system state change by a patch that obsoletes the old one.
+# Although the provides IDs are different, the second patch's obsoletes
+# list includes the first patch's provides ID, so it can replace the
+# first patch and reuse the same state ID.
+
+start_test "same states, replaced by obsoletes"
+
+load_lp $MOD_STATE state=1 provides=1
+load_lp $MOD_STATE2 state=1 provides=2 obsoletes=1
+unload_lp $MOD_STATE
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=1 provides=2 obsoletes=1
+livepatch: enabling patch '$MOD_STATE2'
+livepatch: '$MOD_STATE2': initializing patching transition
+$MOD_STATE2: pre_patch_callback: vmlinux
+$MOD_STATE2: allocate_loglevel_state: space to store console_loglevel already allocated
+livepatch: '$MOD_STATE2': starting patching transition
+livepatch: '$MOD_STATE2': completing patching transition
+$MOD_STATE2: post_patch_callback: vmlinux
+$MOD_STATE2: fix_console_loglevel: taking over the console_loglevel change
+livepatch: '$MOD_STATE2': patching complete
+% rmmod $MOD_STATE
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE2/enabled
+livepatch: '$MOD_STATE2': initializing unpatching transition
+$MOD_STATE2: pre_unpatch_callback: vmlinux
+$MOD_STATE2: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE2': starting unpatching transition
+livepatch: '$MOD_STATE2': completing unpatching transition
+$MOD_STATE2: post_unpatch_callback: vmlinux
+$MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE2': unpatching complete
+% rmmod $MOD_STATE2"
+
+
+# - load a livepatch that modifies system state (state=1) with
+#   provides=1, then another livepatch with the same provides id=1 that declares
+#   a different system state (state=2)
+# - the second livepatch would replace the first one due to the same
+#   provides id, but it does not handle the system state modified by
+#   the first one, therefore it is rejected as incompatible and the
+#   insmod must fail.
+# - verify the first livepatch is still alive, then disable and
+#   unload it.
+
+start_test "misc states, same provides"
+load_lp $MOD_STATE state=1 provides=1
+load_failing_mod $MOD_STATE2 state=2 provides=1
+
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=2 provides=1
+livepatch: Livepatch patch ($MOD_STATE2) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_STATE2.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE/enabled
+livepatch: '$MOD_STATE': initializing unpatching transition
+$MOD_STATE: pre_unpatch_callback: vmlinux
+$MOD_STATE: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE': starting unpatching transition
+livepatch: '$MOD_STATE': completing unpatching transition
+$MOD_STATE: post_unpatch_callback: vmlinux
+$MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE': unpatching complete
+% rmmod $MOD_STATE"
+
+
+# - load two livepatches with different provides ids (provides=1 and
+#   provides=2) that modify different system states (state=1 and
+#   state=2). Neither of them replaces the other, because their
+#   provides ids differ (and the obsoletes lists are empty), so they
+#   can coexist.
+# - verify the provides sysfs value of both livepatches
+# - disable and unload both livepatches
+
+start_test "misc states, misc provides"
+
+load_lp $MOD_STATE state=1 provides=1
+load_lp $MOD_STATE2 state=2 provides=2
+
+check_sysfs_value "$MOD_STATE" "provides" "1"
+check_sysfs_value "$MOD_STATE2" "provides" "2"
+
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=2 provides=2
+livepatch: enabling patch '$MOD_STATE2'
+livepatch: '$MOD_STATE2': initializing patching transition
+$MOD_STATE2: pre_patch_callback: vmlinux
+$MOD_STATE2: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE2': starting patching transition
+livepatch: '$MOD_STATE2': completing patching transition
+$MOD_STATE2: post_patch_callback: vmlinux
+$MOD_STATE2: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE2': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE2/enabled
+livepatch: '$MOD_STATE2': initializing unpatching transition
+$MOD_STATE2: pre_unpatch_callback: vmlinux
+$MOD_STATE2: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE2': starting unpatching transition
+livepatch: '$MOD_STATE2': completing unpatching transition
+$MOD_STATE2: post_unpatch_callback: vmlinux
+$MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE2': unpatching complete
+% rmmod $MOD_STATE2
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE/enabled
+livepatch: '$MOD_STATE': initializing unpatching transition
+$MOD_STATE: pre_unpatch_callback: vmlinux
+$MOD_STATE: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE': starting unpatching transition
+livepatch: '$MOD_STATE': completing unpatching transition
+$MOD_STATE: post_unpatch_callback: vmlinux
+$MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE': unpatching complete
+% rmmod $MOD_STATE"
+
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index f53eead..16b3dfa 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -9,10 +9,25 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
-#define CONSOLE_LOGLEVEL_STATE 1
 /* Version 1 does not support migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 1
 
+static unsigned int state = 1;
+module_param(state, uint, 0444);
+MODULE_PARM_DESC(state, "console loglevel state (default=1)");
+
+#ifdef CONFIG_KLP_HAS_PROVIDES
+static unsigned int provides;
+module_param(provides, uint, 0444);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0444);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
+#endif
+
 static const char *const module_state[] = {
 	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
@@ -35,7 +50,7 @@ static int allocate_loglevel_state(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return -EINVAL;
 
@@ -52,7 +67,7 @@ static void fix_console_loglevel(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -65,7 +80,7 @@ static void restore_console_loglevel(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -77,7 +92,7 @@ static void free_loglevel_state(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -133,7 +148,6 @@ static void post_unpatch_callback(struct klp_object *obj)
 
 static struct klp_state states[] = {
 	{
-		.id = CONSOLE_LOGLEVEL_STATE,
 		.version = CONSOLE_LOGLEVEL_STATE_VERSION,
 	}, { }
 };
@@ -151,6 +165,14 @@ static void post_unpatch_callback(struct klp_object *obj)
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
+#endif
+	states[0].id = state;
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index 5f07fe1..b9772a3 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -9,10 +9,25 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
-#define CONSOLE_LOGLEVEL_STATE 1
 /* Version 2 supports migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 2
 
+static unsigned int state = 1;
+module_param(state, uint, 0444);
+MODULE_PARM_DESC(state, "console loglevel state (default=1)");
+
+#ifdef CONFIG_KLP_HAS_PROVIDES
+static unsigned int provides;
+module_param(provides, uint, 0444);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0444);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
+#endif
+
 static const char *const module_state[] = {
 	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
@@ -35,14 +50,14 @@ static int allocate_loglevel_state(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: space to store console_loglevel already allocated\n",
 		__func__);
 		return 0;
 	}
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return -EINVAL;
 
@@ -59,11 +74,11 @@ static void fix_console_loglevel(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: taking over the console_loglevel change\n",
 		__func__);
@@ -80,14 +95,14 @@ static void restore_console_loglevel(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: passing the console_loglevel change back to the old livepatch\n",
 		__func__);
 		return;
 	}
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -99,14 +114,14 @@ static void free_loglevel_state(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: keeping space to store console_loglevel\n",
 		__func__);
 		return;
 	}
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -162,7 +177,6 @@ static void post_unpatch_callback(struct klp_object *obj)
 
 static struct klp_state states[] = {
 	{
-		.id = CONSOLE_LOGLEVEL_STATE,
 		.version = CONSOLE_LOGLEVEL_STATE_VERSION,
 	}, { }
 };
@@ -180,6 +194,14 @@ static void post_unpatch_callback(struct klp_object *obj)
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
+#endif
+	states[0].id = state;
 	return klp_enable_patch(&patch);
 }
 
-- 
1.8.3.1

