Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834274;
	b=EOFcTsfgV6lO5gvfzhxapzpudWS3FLlO+oyHMnhG+hpixHevpUTZTqMueWr1uBTUqqql
	 IAKKJqEafuwIYLMtE7mPbnknRXZWmh6kYbp1RW6D/Kz9sQszBTDRJgXpfXp8YeTFKhivp
	 4JM/Cngep4qY7Rh64FxJ0S2OWUYi6+bl4R5CnnJ8bc4Jf+CaRznmsSsVi+6WygHKPTu5y
	 wjgG4/SKmkT8fu14NoKeNXanFyRsWHiWKT/LZqHPSjKzXjjTQ8Un7QhV2JOHvNkd2IHz7
	 mrlg2gSOeQ623LQw8hWTlGwFQB+4/bR6TmmboA/0sD+ilpOb4PYDf46G1/b0dfEGzLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nwBAGjVgtviJS9WYaqjmwaMkJybRUqtyOX2Ypf/4BNk=;
	b=ipOEdvDFWV5A1TnHXDEU2FESUz/XuHF+gL0A99Mar/MiDMJO4U2f3j+cN/TTLCpdmSe7
	 AtUjlrdkgupllit+AjZcMLJ+2EusEZYqMO/LzmvleIABzd4+YBezBtEQF3hfhCAJP0R5h
	 aTIXCwCw0CwN6cFQgnW9vcMCjg6JYK64OCxCB20hFi6ieyzoXoixE8HUnW3MZPXTYGtcm
	 oCsiVKDXF3pn5vvY1ju0IMTkavQhqq19bpUS+wrCVa1RVM7Or1OaGPBx4vUmEUh3Yk2wA
	 9kVlTZWHoxYl6fWi4R4UHgpNjg97BamoIphLv6/CGpJO4bdqYhkqPjXVMEf8w8SYJcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IBpRNHaq;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BB606A329
	for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 13:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544BB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IBpRNHaq
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso40888845ad.2
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 05:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794834273; x=1795439073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwBAGjVgtviJS9WYaqjmwaMkJybRUqtyOX2Ypf/4BNk=;
        b=IBpRNHaqjSN+vVY9FN010e3k9/ASkVgzu1RQ25deQI01ZPPuXRKfEaMemyKdhVe/Fw
         kKi5/YdWXpzOg7tbn/cQioBboL+eUbAtWd6ZFBkcgs1iQ8Aqyi34BJCebpNFYRjv27c6
         daJP2+znVZmmjRx2fLbhmIvx1KCH+lXso5oqb7eHiWBudmxv7i+cg+Pfp5W7JROY4v+z
         6UXILQTq5H1Fihg9lWaqWe6JcxgvKZWoGGroqS0RA4z58dJol5qzzqgyW7DG0P/SHnYf
         hpswa5pljXnO6wEwtZ/sLK48IADwR/eyWC/JBFl+dfdOrPS7gN3tFO1UpT7CxaFOnBSF
         fRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794834273; x=1795439073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwBAGjVgtviJS9WYaqjmwaMkJybRUqtyOX2Ypf/4BNk=;
        b=dvd2gjQzGWKs32T1lg2kg+jK4Za2LqszQfSOWR0t1P/cP6LIGjKbfxfIRN5imyQrsX
         m8Q4+qveOv6jMdJb9i8wr0qoN+krhPIOrwE6HXWUW/xwbiQcls88ZcFGfgMri7VlmtXZ
         lcrAJeFMuLrBacGEtat33WVnVqTFaQO1REmDO9DpSqYidloPD0vVNonjRinBGtiQ9g99
         7uohgZWX5Jmctek5A0fDyIFQ/NQEEmc/ZTjnqtWlJcNCSZZ/LwbnsPkVZQ0MvbdLtxeH
         DLl9bHCDm9qnTxYmLfpz48j+3X9deh48Ft73/lp63PpKo1uH1qRfLxRya85yQ6MwqnGw
         KiJw==
X-Gm-Message-State: APuU4Z9PEihAgdphof9guAo4hus7R7cD5iULb4rS6xsXvr2AaAbEnWY4
	yi/9Q/NL9HwI9D8Ag4RcpfTpUah1sghADY/eiEmI5lvZVxkw63MJKx24UBMAszrPqck=
X-Gm-Gg: AZFdTZcV6qiU1FKOga+c/4xJ+CXQVIn/AGaZqH6VEIqdxPjcDuesiCQcmoOPN/AtpCu
	j5ZVV9y8VPAXXN8GvVM9q9uYyeKBxE+dwbXJhAtycT+SLmCog/25u0C/dyFg9Y37EYnYZl8S731
	cIAVppx5Bmy2p5VSsjJdT6l7G59JCQ+4vah8ZzyKh9IPMiVjJ1BmPRO4wFQGgnK5uZIVB9HcET/
	QysDrZ9JZPeIrADWf6Eu6IlaO/0iDQkjcN03n5OiJlRYuxiS07/NyuZNH0ATPGZzGhv9jmlhv/0
	w4cUpJs0qKxiR/Xm6ZanRd0ihW1qnbG9FPeHhYXjEErSbULCVVYgGSjGQ/PiP36AUig6t2c0ksI
	9SBAMiP7UWpTpktx3X+Yl8anaBGNIqoZHQ21pCOdZ1jUHH4RneUAiDID17DrYDt0HPEgGcGCq+F
	lGAU+N8Y3VRZomKN7mm++IIVjBg07S3EtboE7T+5FdKuSrX1e9/BtgxyNKg+j5IoZ05WBGkPpIN
	rqhM53qt27t0Z22G61ihnTG2A1RJPV3bYB41ITlfSuYLtLQQdR0WOlA47QrF867ovio4UDZk7FI
	xB+IlP9cgqYztO8v96w+EtYv5hWVZQ/7Ml48xt7WygPpyMSCz2OP4jli12w4vraZ2UVEzicnHTi
	J5qCwQK3UUQ==
X-Received: by 2002:a17:903:2ac7:b0:2e9:970c:2c2 with SMTP id d9443c01a7336-2ee0de68a89mr111499885ad.48.1794834273327;
        Mon, 16 Nov 2026 05:04:33 -0800 (PST)
Received: from yafangs-Air ([240e:46d:2500:560:dd34:9c87:2e89:5183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee17e14e5dsm35268845ad.4.2026.11.16.05.04.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 05:04:32 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/2] livepatch: reject dynamic flag set by a patch
Date: Mon, 16 Nov 2026 21:04:02 +0800
Message-ID: <20261116130402.76743-3-laoar.shao@gmail.com>
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

A patch module may set the internal "dynamic" flag on its own klp_object:

        static struct klp_object objs[] = {
                { .funcs = funcs, .dynamic = true, },
                { }
        };

klp_check_patch() does not validate it. klp_kobj_release_object() however
uses the flag to decide whether the object was allocated by the core:

  klp_kobj_release_object
  + if (obj->dynamic)
        klp_free_object_dynamic(obj);

For a klp_object that was never allocated by klp_alloc_object_dynamic(),
the free operates on memory that livepatch does not own, and the kernel
warns:

[   51.132051] test_klp_obj_dynamic: loading out-of-tree module taints kernel.
[   51.132057] test_klp_obj_dynamic: tainting kernel with TAINT_LIVEPATCH
[   51.136303] livepatch: symbol 'this_symbol_does_not_exist' not found in symbol table
[   51.136352] ------------[ cut here ]------------
[   51.136354] WARNING: mm/slub.c:6855 at free_large_kmalloc+0xc0/0xe0, CPU#21: insmod/2189
[   51.137260] Modules linked in: test_klp_obj_dynamic(OK+) vfat fat intel_rapl_msr intel_rapl_common kvm_amd ccp iTCO_wdt virtio_gpu kvm virtio_dma_buf drm_shmem_helper i2c_i801 drm_client_lib i2c_mux irqbypass drm_kms_helper i2c_smbus pcspkr virtio_balloon lpc_ich input_leds sch_fq_codel drm fuse xfs ahci libahci virtio_net aesni_intel net_failover gf128mul libata virtio_rng virtio_blk virtio_console failover serio_raw sunrpc dm_mirror dm_region_hash dm_log dm_mod qemu_fw_cfg
[   51.138982] CPU: 21 UID: 0 PID: 2189 Comm: insmod Kdump: loaded Tainted: G           O  K     7.4.0-rc1+ #271 PREEMPT(full)
[   51.139431] Tainted: [O]=OOT_MODULE, [K]=LIVEPATCH
[   51.139636] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-5.el9 11/05/2023
[   51.139928] RIP: 0010:free_large_kmalloc+0xc0/0xe0
[   51.140129] Code: ed 80 3d 94 23 d8 01 00 ba 00 f0 ff ff 75 9d 48 c7 c7 c2 a7 94 97 89 55 ec c6 05 7c 23 d8 01 01 e8 75 8e cf ff 8b 55 ec eb 82 <0f> 0b 48 c7 c6 a9 a7 94 97 4c 89 e7 e8 1f 41 fa ff 48 83 c4 08 41
[   51.140888] RSP: 0018:ff5331d9031c3aa0 EFLAGS: 00010202
[   51.141105] RAX: 00000000000000ff RBX: ffffffffc0bfb138 RCX: 000000000000000a
[   51.141397] RDX: 0000000000000000 RSI: ffffffffc0bfb100 RDI: ffa280331686fec0
[   51.141707] RBP: ff5331d9031c3ab8 R08: ff22d0898472eaa0 R09: ff22d089808b7210
[   51.141999] R10: ff5331d9031c3a88 R11: ff5331d9031c3a90 R12: ffa280331686fec0
[   51.142288] R13: ffa280331686fec0 R14: ffffffffc0bfb050 R15: ffffffffc0bfb118
[   51.142584] FS:  00007f55e9bed740(0000) GS:ff22d0a8e5495000(0000) knlGS:0000000000000000
[   51.142925] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.143161] CR2: 00005611a26eee48 CR3: 00000001021db005 CR4: 0000000000771ef0
[   51.143450] PKRU: 55555554
[   51.143572] Call Trace:
[   51.143693]  <TASK>
[   51.143792]  kfree+0x171/0x3a0
[   51.143927]  ? srso_alias_return_thunk+0x5/0xfbef5
[   51.144128]  ? kernfs_put.part.0+0xcf/0x150
[   51.144314]  klp_kobj_release_object+0x3e/0x60
[   51.144511]  kobject_cleanup+0x44/0x1b0
[   51.144700]  kobject_put+0x40/0x70
[   51.144848]  __klp_free_objects+0x114/0x160
[   51.145028]  klp_enable_patch.part.0+0x29e/0x4f0
[   51.145227]  klp_enable_patch+0xb4/0xf0
[   51.145390]  ? __pfx_init_module+0x10/0x10 [test_klp_obj_dynamic]
[   51.145645]  test_klp_obj_dynamic_init+0x15/0x20 [test_klp_obj_dynamic]
[   51.145929]  do_one_initcall+0x45/0x300
[   51.146092]  ? do_init_module+0x28/0x2a0
[   51.146262]  do_init_module+0x6a/0x2a0
[   51.146422]  load_module+0x861/0x980
[   51.146581]  ? srso_alias_return_thunk+0x5/0xfbef5
[   51.146794]  ? kernel_read_file+0x23c/0x2c0
[   51.146976]  init_module_from_file+0xdf/0x100
[   51.147163]  idempotent_init_module+0x170/0x270
[   51.147355]  __x64_sys_finit_module+0x73/0xf0
[   51.147544]  x64_sys_call+0x2043/0x21d0
[   51.147723]  do_syscall_64+0x97/0x460
[   51.147884]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   51.148095] RIP: 0033:0x7f55e93089fd
[   51.148250] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d eb 23 0f 00 f7 d8 64 89 01 48
[   51.149005] RSP: 002b:00007ffcb754a8f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   51.149313] RAX: ffffffffffffffda RBX: 00005611a26ec7d0 RCX: 00007f55e93089fd
[   51.149608] RDX: 0000000000000000 RSI: 000056117e373962 RDI: 0000000000000003
[   51.149912] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   51.150202] R10: 0000000000000003 R11: 0000000000000246 R12: 000056117e373962
[   51.150493] R13: 00005611a26ec770 R14: 000056117e372550 R15: 00005611a26ec8f0
[   51.150801]  </TASK>
[   51.150900] ---[ end trace 0000000000000000 ]---
[   51.151101] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15a1bfb
[   51.151107] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   51.151111] raw: 0017ffffc0000000 ffa280331686fec8 ffa280331686fec8 0000000000000000
[   51.151113] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   51.151113] page dumped because: Not a kmalloc allocation

A simple reproducer:

  #include <linux/module.h>
  #include <linux/kernel.h>
  #include <linux/livepatch.h>

  static void dummy_new_func(void)
  {
  }

  static struct klp_func funcs[] = {
          {
                  .old_name = "this_symbol_does_not_exist",
                  .new_func = dummy_new_func,
          },
          { }
  };

  static struct klp_object objs[] = {
          {
                  .funcs = funcs,
                  .dynamic = true,
          },
          { }
  };

  static struct klp_patch patch = {
          .mod = THIS_MODULE,
          .objs = objs,
  };

  static int test_klp_obj_dynamic_init(void)
  {
          return klp_enable_patch(&patch);
  }

  static void test_klp_obj_dynamic_exit(void)
  {
  }

  module_init(test_klp_obj_dynamic_init);
  module_exit(test_klp_obj_dynamic_exit);

  MODULE_LICENSE("GPL");
  MODULE_DESCRIPTION("livepatch reproducer: object dynamic flag");
  MODULE_INFO(livepatch, "Y");

Fix this by rejecting such patches at initialization time, so a patch can
no longer reach klp_free_object_dynamic() with a bogus .dynamic.

After this fix, the result is:

[   60.029559] test_klp_obj_dynamic: loading out-of-tree module taints kernel.
[   60.029565] test_klp_obj_dynamic: tainting kernel with TAINT_LIVEPATCH
[   60.034073] livepatch: test_klp_obj_dynamic: object vmlinux must not set the internal dynamic flag

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/livepatch.h | 1 +
 kernel/livepatch/core.c   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 76ba613830a6..859466f08d95 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -93,6 +93,7 @@ struct klp_func {
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
  * @dynamic:    temporary object for nop functions; dynamically allocated
+ *              internal only, must not be set by a patch
  * @patched:	the object's funcs have been added to the klp_ops list
  */
 struct klp_object {
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index ba09894eec2c..162f4cc6e2c0 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1110,6 +1110,13 @@ static int klp_check_patch(struct klp_patch *patch)
 	klp_for_each_object_static(patch, obj) {
 		if (!obj->funcs)
 			return -EINVAL;
+		if (obj->dynamic) {
+			pr_err("%s: object %s must not set the internal dynamic flag\n",
+				patch->mod->name,
+				klp_is_module(obj) ? obj->name : "vmlinux");
+			return -EINVAL;
+		}
+
 		klp_for_each_func_static(obj, func) {
 			if (!func->old_name)
 				return -EINVAL;
-- 
2.52.0

