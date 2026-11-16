Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834784;
	b=axPgU+8ddXeCohbe5h4jVdff6PdBq7nMitXgrGlGhKAA6pYiHpq/kNbgXJi0jy/q5ddL
	 IZ8HbNs2HwqhVi5BNQdp76CijIVNdydBuE3MwpZB7hP6NZqIwak5vlHv7iyMFKFtvo78w
	 BHW/ePR48yQ2rnamqdCWgQ+ef/vMGAWYcylPLq0+2hl5BzyDk1ntyljCh3HxzDKYVpxHE
	 jBst0fZCB5gjQMZrpXLT9TJ9ji8HqlErZPuMOnJaMb61f70RovXIMXBtsUuHK3N3glyPz
	 ufXyvQ+uvkgoJWd6EhqDtT/OfMWg58ZgRIXspl+7TP89e2wfAJeucZR414uwWCuFohg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qCI6FvuNrkpXbvzUt1acIazH41lwGlJfqfP7L4U/i+M=;
	b=dIhURlfUf1afgzXrTHOvA4iD9PxXp/r60Jz0zvnNZkpk1Gu2B1Nz8QosvvOIry1pqPlx
	 XNmFiOQwcs5WJVdXlA5HteZy3dX+JD5xVsB4O2pxsxkjsgH2Cya8+xgtyA5dwbIMukwLY
	 CwghjLpp+Ar246pY6ftbSqzv8CzYe0UwelVE8/9IvwdyOiI8HZbug9hrMEX8qPlImOIjo
	 9ZzhrjRhhPrEJrVFweu7De0P9+DXCLLSsp/3VBCpq/J5K0YKZKupqhg8LBHPBYQqijNLo
	 S462y/hHFRjMkjBXmgaDSf2XKF9EjittpMXSA56egPlJWWOdiQeYcViikdcs8jhb2sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGViWIhB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FF606A338
	for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGViWIhB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105571F000C8;
	Mon, 16 Nov 2026 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794834784;
	bh=qCI6FvuNrkpXbvzUt1acIazH41lwGlJfqfP7L4U/i+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGViWIhBVdRu6rKb8egXXLRbFhBSzfCtIBnHrWTklzEXQUt/AkqGyHaoX71BDKJdw
	 H3Lsz6fXkPDz4s+R8vj/x79MW14x+yO4ULga/V2KtaLEeYqhixVsYiMcgcbaXlXPEL
	 RckHPLOKOP7gLcVP9LQ/4SMZQlqobuLfDQPozXcLMDDYD5eG0iuYbtdHvvwHu9s8W7
	 4BzZwtOUeJTjZw3jgoFQUjGAxEYeMbadlc7VC03Td+QbG/3sqX3N1CvbD8e36uV6i4
	 U/NjW1mXsYdXCB1U/40CBkggt7oIy5ET5hN2CqoolnWtK0eqva2fjEaLilCA+1GJZR
	 6vzauU9ERxqGg==
Message-ID: <sashiko-outbox-217052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] livepatch: reject nop flag set by a patch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20261116130402.76743-2-laoar.shao@gmail.com>
References: <20261116130402.76743-1-laoar.shao@gmail.com>
 <20261116130402.76743-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:13:03 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] livepatch: missing Fixes trailer for klp_check_patch() nop check
--

commit c7daf731e7df689ca282b8fa4f4b36f2e21c4907
Author: Yafang Shao <laoar.shao@gmail.com>

> livepatch: reject nop flag set by a patch
>
> A patch module can incorrectly set .nop =3D true in its own struct
> klp_func:
>
>   static struct klp_func funcs[] =3D {
>       {
>           .old_name =3D "cmdline_proc_show",
>               .nop =3D true,
>       },
>       { }
>       };
>
> .nop is internal to livepatch: it is set only by klp_alloc_func_nop(),
> for functions that the patch does not replace.  When the patch module is
> removed, klp_kobj_release_func() trusts the flag and hands any func that
> has it set to klp_free_func_nop():
>
>   klp_kobj_release_func
>   + if (func->nop)
>         klp_free_func_nop(func);
>
> For a func that was never allocated by klp_alloc_func_nop(), the free
> operates on memory that livepatch does not own, and the kernel warns:
>
> [  679.530851] ------------[ cut here ]------------
> [  679.530853] WARNING: mm/slub.c:6855 at free_large_kmalloc+0xc0/0xe0, C=
PU#55: kworker/55:1/794
> [  679.531695] Modules linked in: test_klp_nop_bad(OK) vfat fat intel_rap=
l_msr intel_rapl_common kvm_amd ccp iTCO_wdt kvm virtio_gpu virtio_dma_buf =
drm_shmem_helper i2c_i801 drm_client_lib i2c_mux irqbypass i2c_smbus drm_km=
s_helper pcspkr lpc_ich virtio_balloon input_leds sch_fq_codel drm fuse xfs=
 ahci libahci virtio_net aesni_intel gf128mul net_failover libata virtio_rn=
g virtio_blk virtio_console failover serio_raw sunrpc dm_mirror dm_region_h=
ash dm_log dm_mod qemu_fw_cfg
> [  679.533370] CPU: 55 UID: 0 PID: 794 Comm: kworker/55:1 Kdump: loaded T=
ainted: G           O  K     7.4.0-rc1+ #270 PREEMPT(full)
> [  679.533841] Tainted: [O]=3DOOT_MODULE, [K]=3DLIVEPATCH
> [  679.534047] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-5.el9 11/05/2=
023
> [  679.534320] Workqueue: events klp_transition_work_fn
> [  679.534530] RIP: 0010:free_large_kmalloc+0xc0/0xe0
> [  679.534729] Code: ed 80 3d d4 23 d8 01 00 ba 00 f0 ff ff 75 9d 48 c7 c=
7 62 a7 94 b3 89 55 ec c6 05 bc 23 d8 01 01 e8 b5 8e cf ff 8b 55 ec eb 82 <=
0f> 0b 48 c7 c6 49 a7 94 b3 4c 89 e7 e8 1f 41 fa ff 48 83 c4 08 41
> [  679.535478] RSP: 0018:ff7be23881c47cb0 EFLAGS: 00010202
> [  679.535697] RAX: 00000000000000ff RBX: ffffffffc0e50280 RCX: 000000000=
0000001
> [  679.535999] RDX: 0000000000000000 RSI: ffffffffc0e53054 RDI: ffb8a30e5=
7d794c0
> [  679.536287] RBP: ff7be23881c47cc8 R08: ff3c2d170ff94e58 R09: ff3c2d170=
08b7210
> [  679.536574] R10: ff7be23881c47c98 R11: ff7be23881c47ca0 R12: ffb8a30e5=
7d794c0
> [  679.536865] R13: ffb8a30e57d794c0 R14: ffffffffc0e50138 R15: ffffffffc=
0e50260
> [  679.537163] FS:  0000000000000000(0000) GS:ff3c2d3649d15000(0000) knlG=
S:0000000000000000
> [  679.537490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  679.537723] CR2: 000055eb5f6a5158 CR3: 00000015e9020004 CR4: 000000000=
0771ef0
> [  679.538023] PKRU: 55555554
> [  679.538139] Call Trace:
> [  679.538249]  <TASK>
> [  679.538348]  kfree+0x171/0x3a0
> [  679.538483]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  679.538681]  ? kernfs_put.part.0+0xcf/0x150
> [  679.538869]  klp_kobj_release_func+0x35/0x60
> [  679.539061]  kobject_cleanup+0x44/0x1b0
> [  679.539236]  kobject_put+0x40/0x70
> [  679.539383]  __klp_free_objects+0xaa/0x160
> [  679.539556]  klp_free_patch_async+0x52/0x80
> [  679.539730]  klp_try_complete_transition+0x2dc/0x310
> [  679.539941]  klp_transition_work_fn+0x24/0x40
> [  679.540131]  process_one_work+0x1db/0x410
> [  679.540306]  worker_thread+0x1bc/0x330
> [  679.540466]  kthread+0xfd/0x140
> [  679.540603]  ? __pfx_worker_thread+0x10/0x10
> [  679.540783]  ? __pfx_kthread+0x10/0x10
> [  679.540947]  ret_from_fork+0x178/0x250
> [  679.541115]  ? __pfx_kthread+0x10/0x10
> [  679.541273]  ret_from_fork_asm+0x1a/0x30
> [  679.541445]  </TASK>
> [  679.541542] ---[ end trace 0000000000000000 ]---
> [  679.541738] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x15f5e53
> [  679.541744] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1=
fffff)
> [  679.541747] raw: 0017ffffc0000000 ffb8a30e57d794c8 ffb8a30e57d794c8 00=
00000000000000
> [  679.541749] raw: 0000000000000000 0000000000000000 00000000ffffffff 00=
00000000000000
> [  679.541750] page dumped because: Not a kmalloc allocation
> [  679.541756] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x15f5e50
> [  679.541758] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1=
fffff)
> [  679.541759] raw: 0017ffffc0000000 ffb8a30e57d79408 ffb8a30e57d79408 00=
00000000000000
> [  679.541760] raw: 0000000000000000 0000000000000000 00000000ffffffff 00=
00000000000000
> [  679.541761] page dumped because: Not a kmalloc allocation
>
> A simple reproducer:
>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/livepatch.h>
>
>   static struct klp_func funcs[] =3D {
>           {
>                   .old_name =3D "cmdline_proc_show",
>                   .nop =3D true,
>           },
>           { }
>   };
>
>   static struct klp_object objs[] =3D {
>           { .funcs =3D funcs, },
>           { }
>   };
>
>   static struct klp_patch patch =3D {
>           .mod =3D THIS_MODULE,
>           .objs =3D objs,
>   };
>
>   static int test_klp_nop_bad_init(void)
>   {
>           return klp_enable_patch(&patch);
>   }
>
>   static void test_klp_nop_bad_exit(void)
>   {
>   }
>
>   module_init(test_klp_nop_bad_init);
>   module_exit(test_klp_nop_bad_exit);
>
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("livepatch reproducer: patch-supplied nop");
>   MODULE_INFO(livepatch, "Y");
>
> Fix this by rejecting such patches at initialization time, so a patch can
> no longer reach klp_kobj_release_func() with a bogus .nop.
>
> After this fix, the result is:
>
> [   47.563594] livepatch: test_klp_nop_bad: func 'cmdline_proc_show' must=
 not set the internal nop flag
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

[Severity: Low]
Since commit e1452b607c48 ("livepatch: Add atomic replace") introduced
the nop field and the klp_free_func_nop() call in klp_kobj_release_func(),
should this include:

  Fixes: e1452b607c48 ("livepatch: Add atomic replace")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116130402.7674=
3-1-laoar.shao@gmail.com?part=3D1
