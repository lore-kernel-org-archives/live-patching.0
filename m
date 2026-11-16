Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834269;
	b=DJUy4p4M5YwTPs/ox4OAqB3zZds+qVU2CTEjwebgyDDPzzPjX7um0D3fa72UAUsv65QH
	 git12GudfA/Bw+wgom+uj3h46VflwK5s8XhWmi2DJh8srxoZ6VxLn5tlmqsMv1fjuHHb0
	 vjDB7fjMVIOiwNc0kBMG08nk+c6Gs8Flfx7Wkkj9189XUWS0+8hKV7Fh/fggCMqimVhE+
	 2Aj1fUibZuTjaZ4SGCcSewavmzvFgFkAvYJbhwVFZb1FHVh2ARPRKyt3f5ON4DUiCVReV
	 LdIa+5YECgza04jXZGR3Rmsrfv+EMTqNbEvdfJ+aWsfbTxURSzJ98DKATV/kSAbvOAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nTPi7Ru4NRNzHw8PUzJFCbOCbh1K/Q9FPBOjIPU4g/E=;
	b=K1SQRDrF83bj7eJ+JZ81Jm54To9wOTeYZcLlLuu+mg4EfjYtFxr1lfTS3RTTMXF6+ZMg
	 hgGvK5xSCcIr+Bv30bc0vwIv3habjGhthy+5f2jkod47bbSkv1UMQ5rx5cVXtLbwFYE50
	 dhCfstxwmOqU/Tm+nChqozqHB9xAjvss7FDxBvLUU8fzsXseqERTSraBAr98Rg5Q8Q/ZB
	 qwXDBJCUc6zKXgn90R10hYrlL/UYSNJK3GRZCKfxZkUDg0IVHb1YNGPT7tjoFV+319mhi
	 PmhwUO44Yuj5ms6R9llq7a6cA+75/PRdt59++Nl08GX7BzO8Sc5MgXTr+2ztQm/T3CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3auiimn;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3E606A31C
	for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 13:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3auiimn
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ede7cb02daso31195765ad.1
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 05:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794834268; x=1795439068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTPi7Ru4NRNzHw8PUzJFCbOCbh1K/Q9FPBOjIPU4g/E=;
        b=Z3auiimne2vvXBaT3t01xWogjFunGHTf5yxwDyHS4I7xhNFMqEn+tTgu8lM33Qn/RJ
         g2ciUXWXDPWwwusG6l8kcjgHOHDSa2h6+dq+X5a8z2vvKtMAMcCvs0QjBeTibfhNH8vT
         ynRXS7esmWMvt3YfqDgJmkwYojWvzfnHVckNYNS01VPCkzDjf6uWPYe4EiKeHSnGmb3r
         CVisHl86IiIbZKjBwif+Lu8DFTCYaz0ZFeYh5Wz0HlY6raKJQXXdPkUa9Atr/hzkC9Pv
         SRYKmxJIu70K9BIaCc3bC+qJ2kPmWxJ93Nh1BFTnVxAHVL7O5KnSt9Ied/NbAjw+f+f9
         wojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794834268; x=1795439068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTPi7Ru4NRNzHw8PUzJFCbOCbh1K/Q9FPBOjIPU4g/E=;
        b=nE26FI1RNqLOXzVsSkXhwMmwPu4Hy+Z2nSFKMwU/t6enoWpt9kAqZ3hFwdMYxBw9+g
         RCLQNrfFd0drGO+e+gFW1uDMa6iw0ILMFdOQaEjfbe62/AVaIFB32/9nqX711ju4mwY6
         Ei5BUwx6C6CtRmsWrxNSS3vXnk6jaYQXBbBFiF4Clnl1vxECeLSbeFOXAt2Sy396U2nc
         Pb0oE7eNcDbFw1XqGVw2IhcRtFioSSibCzVK+ACeZQc590x6c5OR+2CW/5lIn7acB1T8
         Nnn2KEovAOjLHko0rFr2X1I7wE43c7vsyPNqLcVJGfSBh1guSS7p2fYJxRJULQiNxRnM
         9W0g==
X-Gm-Message-State: APuU4Z9Fzo7wKt6ILbtjQ1+F7KCV2RXEoNDgT2aJ70obY09sfcLFfUmf
	teYIbkKWWGHtPFIf5OQgUOqbFkJr2ahTQg8T8ACeHfuMLQ2XvFpOvFsx
X-Gm-Gg: AYBFou04jOsEWT7KG1B118b3m+Vo43P2CwNCZii26C5N+uB8F4sP0PBJ3LqEdlJTDtc
	gKNNb55yjgP6HFvBE9+pTJEPoMTU89S5MYhj/06biGJsVoiN30j9r9494McoWMHnfy+9YjYNLSa
	cNmKwR+btrC8XQjTgEgWnvk50aDYh00/peYCqpzWNstQ03K3mOu/WJcMI+rJaGfpH15/iPkAMl+
	TX2olSeYYpASfYAAYKao7IRnXPLSYHmHXuvbtsiOPJub04uZ9fzss8SszqegLYdbS3IP2n7Y12F
	EZu+xMCNrN+tB8wUfoexDOyMLMkedbcjwHzm6r1CaHNZRU9SBJcI3Ctkw2N0DurLlwWLs5lObye
	TrKHxFHHVcl8fMO8H0eVBH5+5LULXaR1iPxZtepdi2js54y6292rGhY7IW4nXBZSwPCyFG5owTt
	1IFzzyg8d2g7Qt4dP6EHR82P8xBGamLxXdKXc/KUL2NAOE/5/J3oyntQ+njeEM83+TEvIAnm42Y
	eWfKojNuxa5BSen1necLqgtwRiOVPAVeRMGG7GSgV7C8KwJlYflsgEIPfje2lhziJnxj1KFgXUb
	BBfgI7LSfx5vRK/wwXZ9fjgjFEBi2f1mBeJCmZj3plKIyBWBNHpIkUsN60KHqkvDc3FVyilR9PD
	Tvx3HF5YZ5w==
X-Received: by 2002:a17:902:c401:b0:2cf:7db9:e13e with SMTP id d9443c01a7336-2ee0d9fce78mr75198135ad.3.1794834267970;
        Mon, 16 Nov 2026 05:04:27 -0800 (PST)
Received: from yafangs-Air ([240e:46d:2500:560:dd34:9c87:2e89:5183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee17e14e5dsm35268845ad.4.2026.11.16.05.04.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 05:04:27 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/2] livepatch: reject nop flag set by a patch
Date: Mon, 16 Nov 2026 21:04:01 +0800
Message-ID: <20261116130402.76743-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116130402.76743-1-laoar.shao@gmail.com>
References: <20261116130402.76743-1-laoar.shao@gmail.com>
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

A patch module can incorrectly set .nop = true in its own struct
klp_func:

  static struct klp_func funcs[] = {
      {
          .old_name = "cmdline_proc_show",
	      .nop = true,
      },
      { }
      };

.nop is internal to livepatch: it is set only by klp_alloc_func_nop(),
for functions that the patch does not replace.  When the patch module is
removed, klp_kobj_release_func() trusts the flag and hands any func that
has it set to klp_free_func_nop():

  klp_kobj_release_func
  + if (func->nop)
        klp_free_func_nop(func);

For a func that was never allocated by klp_alloc_func_nop(), the free
operates on memory that livepatch does not own, and the kernel warns:

[  679.530851] ------------[ cut here ]------------
[  679.530853] WARNING: mm/slub.c:6855 at free_large_kmalloc+0xc0/0xe0, CPU#55: kworker/55:1/794
[  679.531695] Modules linked in: test_klp_nop_bad(OK) vfat fat intel_rapl_msr intel_rapl_common kvm_amd ccp iTCO_wdt kvm virtio_gpu virtio_dma_buf drm_shmem_helper i2c_i801 drm_client_lib i2c_mux irqbypass i2c_smbus drm_kms_helper pcspkr lpc_ich virtio_balloon input_leds sch_fq_codel drm fuse xfs ahci libahci virtio_net aesni_intel gf128mul net_failover libata virtio_rng virtio_blk virtio_console failover serio_raw sunrpc dm_mirror dm_region_hash dm_log dm_mod qemu_fw_cfg
[  679.533370] CPU: 55 UID: 0 PID: 794 Comm: kworker/55:1 Kdump: loaded Tainted: G           O  K     7.4.0-rc1+ #270 PREEMPT(full)
[  679.533841] Tainted: [O]=OOT_MODULE, [K]=LIVEPATCH
[  679.534047] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-5.el9 11/05/2023
[  679.534320] Workqueue: events klp_transition_work_fn
[  679.534530] RIP: 0010:free_large_kmalloc+0xc0/0xe0
[  679.534729] Code: ed 80 3d d4 23 d8 01 00 ba 00 f0 ff ff 75 9d 48 c7 c7 62 a7 94 b3 89 55 ec c6 05 bc 23 d8 01 01 e8 b5 8e cf ff 8b 55 ec eb 82 <0f> 0b 48 c7 c6 49 a7 94 b3 4c 89 e7 e8 1f 41 fa ff 48 83 c4 08 41
[  679.535478] RSP: 0018:ff7be23881c47cb0 EFLAGS: 00010202
[  679.535697] RAX: 00000000000000ff RBX: ffffffffc0e50280 RCX: 0000000000000001
[  679.535999] RDX: 0000000000000000 RSI: ffffffffc0e53054 RDI: ffb8a30e57d794c0
[  679.536287] RBP: ff7be23881c47cc8 R08: ff3c2d170ff94e58 R09: ff3c2d17008b7210
[  679.536574] R10: ff7be23881c47c98 R11: ff7be23881c47ca0 R12: ffb8a30e57d794c0
[  679.536865] R13: ffb8a30e57d794c0 R14: ffffffffc0e50138 R15: ffffffffc0e50260
[  679.537163] FS:  0000000000000000(0000) GS:ff3c2d3649d15000(0000) knlGS:0000000000000000
[  679.537490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  679.537723] CR2: 000055eb5f6a5158 CR3: 00000015e9020004 CR4: 0000000000771ef0
[  679.538023] PKRU: 55555554
[  679.538139] Call Trace:
[  679.538249]  <TASK>
[  679.538348]  kfree+0x171/0x3a0
[  679.538483]  ? srso_alias_return_thunk+0x5/0xfbef5
[  679.538681]  ? kernfs_put.part.0+0xcf/0x150
[  679.538869]  klp_kobj_release_func+0x35/0x60
[  679.539061]  kobject_cleanup+0x44/0x1b0
[  679.539236]  kobject_put+0x40/0x70
[  679.539383]  __klp_free_objects+0xaa/0x160
[  679.539556]  klp_free_patch_async+0x52/0x80
[  679.539730]  klp_try_complete_transition+0x2dc/0x310
[  679.539941]  klp_transition_work_fn+0x24/0x40
[  679.540131]  process_one_work+0x1db/0x410
[  679.540306]  worker_thread+0x1bc/0x330
[  679.540466]  kthread+0xfd/0x140
[  679.540603]  ? __pfx_worker_thread+0x10/0x10
[  679.540783]  ? __pfx_kthread+0x10/0x10
[  679.540947]  ret_from_fork+0x178/0x250
[  679.541115]  ? __pfx_kthread+0x10/0x10
[  679.541273]  ret_from_fork_asm+0x1a/0x30
[  679.541445]  </TASK>
[  679.541542] ---[ end trace 0000000000000000 ]---
[  679.541738] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15f5e53
[  679.541744] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  679.541747] raw: 0017ffffc0000000 ffb8a30e57d794c8 ffb8a30e57d794c8 0000000000000000
[  679.541749] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[  679.541750] page dumped because: Not a kmalloc allocation
[  679.541756] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15f5e50
[  679.541758] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  679.541759] raw: 0017ffffc0000000 ffb8a30e57d79408 ffb8a30e57d79408 0000000000000000
[  679.541760] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[  679.541761] page dumped because: Not a kmalloc allocation

A simple reproducer:

  #include <linux/module.h>
  #include <linux/kernel.h>
  #include <linux/livepatch.h>

  static struct klp_func funcs[] = {
          {
                  .old_name = "cmdline_proc_show",
                  .nop = true,
          },
          { }
  };

  static struct klp_object objs[] = {
          { .funcs = funcs, },
          { }
  };

  static struct klp_patch patch = {
          .mod = THIS_MODULE,
          .objs = objs,
  };

  static int test_klp_nop_bad_init(void)
  {
          return klp_enable_patch(&patch);
  }

  static void test_klp_nop_bad_exit(void)
  {
  }

  module_init(test_klp_nop_bad_init);
  module_exit(test_klp_nop_bad_exit);

  MODULE_LICENSE("GPL");
  MODULE_DESCRIPTION("livepatch reproducer: patch-supplied nop");
  MODULE_INFO(livepatch, "Y");

Fix this by rejecting such patches at initialization time, so a patch can
no longer reach klp_kobj_release_func() with a bogus .nop.

After this fix, the result is:

[   47.563594] livepatch: test_klp_nop_bad: func 'cmdline_proc_show' must not set the internal nop flag

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/livepatch.h | 1 +
 kernel/livepatch/core.c   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 5f74f79c22b4..76ba613830a6 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -37,6 +37,7 @@
  * @old_size:	size of the old function
  * @new_size:	size of the new function
  * @nop:        temporary patch to use the original code again; dyn. allocated
+ *              internal only, must not be set by a patch
  * @patched:	the func has been added to the klp_ops list
  * @transition:	the func is currently being applied or reverted
  *
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 517fe427ff92..ba09894eec2c 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1113,6 +1113,11 @@ static int klp_check_patch(struct klp_patch *patch)
 		klp_for_each_func_static(obj, func) {
 			if (!func->old_name)
 				return -EINVAL;
+			if (func->nop) {
+				pr_err("%s: func '%s' must not set the internal nop flag\n",
+					patch->mod->name, func->old_name);
+				return -EINVAL;
+			}
 		}
 	}
 	return 0;
-- 
2.52.0

