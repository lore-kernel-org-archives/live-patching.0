Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE630149F
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931462; cv=none; b=TmevrlaPIDKd1NbQeWDUNYqpXo0isEdsp3NSbi+TM28bZORsRTq9bh9YISjLMpNpYaEN+7C2HLpC1EP1kqc9WQiBdCwdFVlUow5iLwv8fdC/0Q2LOMpWyAMtXByT3ONDJuQTiddqQ9fZsM7HVt8ASLSCNcX21R48cbfR2mxEpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931462; c=relaxed/simple;
	bh=TNimib0kIbnVRZ6Rs9ngiAVqMNzswl4jrAeDKRpTJpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=PzaMQxt5WOAUQCv80O4Hwgj6rCpysfovDh96uV8NLfFBHGSU6NF5AfYKuBIbAosmya8d1ZLAwR8Z0vW2ASW+/qRVM8SWPVbynjdeNIr+VciRvy79S4RQSYa6O1aOnW43PaW5W/0b9Dto3bIfavRlE/w3FIyfEk4wFbqJ5fOpAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxLvA2X+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxLvA2X+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784931459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fsk+4SZ49bGTt24iVuRNykleuq00KRYLAQi8m/58gEQ=;
	b=VxLvA2X+JtG0CfYQZNjGasCi6ImXCIqAPoFEH0m+2m/SNF+1S3JHV72RBNFkcbce2QFeKH
	hNFb37fN1U4Z8qEDTspArXm2PSgnqG+Xk8nF2GaxUlxWheJEMg6cCpnD5lXWhUzN+C5bHv
	D9RqoVCxibcwo3DvmTzcxPBbVlosstA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-eQOofWfbP4qJeQMHhYaPBA-1; Fri,
 24 Jul 2026 18:17:38 -0400
X-MC-Unique: eQOofWfbP4qJeQMHhYaPBA-1
X-Mimecast-MFC-AGG-ID: eQOofWfbP4qJeQMHhYaPBA_1784931456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8841A1851153;
	Fri, 24 Jul 2026 22:17:36 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.207])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3878B1800634;
	Fri, 24 Jul 2026 22:17:35 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Ben Procknow <bprockno@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 0/1] objtool/klp-diff: fix klp-build data sympos bug
Date: Fri, 24 Jul 2026 18:17:29 -0400
Message-ID: <20260724221730.3126529-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Josh,

Here's v2 addressing your feedback, rather than extending the
section-ordering HACK, this computes sympos during the checksum phase as
passes it through with that.

This adds --linked-obj to `objtool klp checksum`.  (Not sure if there is
any other way other than to pass that around.)  It opens the linked
binary (vmlinux or .ko), finds all duplicate local symbols matching the
.o being checksummed, sorts them to match the kallsyms order, and writes
the result into a .discard.sym_order section.  klp-diff then reads this
section instead of trying to determine the order from vmlinux.o's symbol
table.

Note that the sort order matches what the livepatch core sees when
loading the patch:

- For vmlinux, sort by address: this matches
  kallsyms_on_each_match_symbol() which loops through the symbols in
  address order, counting dupes until it hits the target sympos.

- For modules, sort by symtab index: this matches
  module_kallsyms_on_each_symbol() which iterates the .ko's symtab
  as-is.

With this, the section-ordering HACK is completely removed.

On the klp-build side, the script now stashes the original vmlinux/.ko
into 1-orig/ during copy_orig_objects before the patched rebuild
overwrites them, then passes --linked-obj pointing there during the
original checksum pass.  As mentioned earlier, I'm not sure if there is
a better way to do this.

Finally, this doesn't address the age-old, same source-file::symbol-name
problem.  That was astutely flagged by one of our internal AI reviews :)
But it's Friday and I don't think I need to solve that one today, too.


v1: https://lore.kernel.org/live-patching/ini7aoz6vvowmu5dvxoxpi6l4ednsov6omjcoffmuod3d2iaof@vflcrwqktqsl/T/#t
- Complete rewrite and change of approach to stashing sympos with the
  checksum [Josh]

Joe Lawrence (1):
  objtool/klp: compute sympos during checksum phase

 scripts/livepatch/klp-build                   |  36 +++-
 .../objtool/include/objtool/checksum_types.h  |   6 +
 tools/objtool/klp-checksum.c                  | 195 +++++++++++++++++-
 tools/objtool/klp-diff.c                      |  88 ++++----
 4 files changed, 267 insertions(+), 58 deletions(-)


Reproducer and analysis
=======================

Config
------
Basic config plus a DM module for testing:

  $ make defconfig
  $ ./scripts/config --file .config \
             --set-val CONFIG_FTRACE y \
             --set-val CONFIG_KALLSYMS_ALL y \
             --set-val CONFIG_FUNCTION_TRACER y \
             --set-val CONFIG_DYNAMIC_FTRACE y \
             --set-val CONFIG_DYNAMIC_DEBUG y \
             --set-val CONFIG_LIVEPATCH y \
             --set-val CONFIG_DM_THIN_PROVISIONING m
  $ make olddefconfig

Helper debug functions
----------------------
These help shorten some of the analysis below:

  # Symbol table order
  $ dump_sym() { objdump -t "$1" | awk -vSYM="$2" '/\.c$/{file=$NF}; $NF==SYM {print file": "$0}' | column -t | sort -k2; }

  # Kallsyms address-sorted order
  $ dump_sym_addr_sort() { dump_sym "$1" "$2" | sort -k2; }

  # Magic spell to coax pahole into pretty-printing the klp_func_ext struct
  $ dump_klp_func_ext() {
    echo '#include "include/linux/livepatch_external.h"
    struct klp_func_ext dummy;' | gcc -g -c -x c -include linux/types.h - -o /tmp/type.o
    objcopy -O binary --only-section=.init.klp_funcs "$1" /tmp/funcs.bin
    pahole -F dwarf -C klp_func_ext /tmp/type.o --prettify /tmp/funcs.bin 2>/dev/null
  }


Find initial sympos
-------------------
Find the symbol positions for pwq_cache symbols and unregister_vclock
functions:

  $ dump_sym_addr_sort vmlinux pwq_cache
  eventpoll.c:  ffffffff82b8ab40  l  O  .rodata  0000000000000008  pwq_cache        << sympos=1
  workqueue.c:  ffffffff83a99b00  l  O  .bss     0000000000000008  pwq_cache        << sympos=2

  $ dump_sym_addr_sort vmlinux unregister_vclock
  ptp_sysfs.c:  ffffffff81265a00  l  F  .text  0000000000000056  unregister_vclock  << sympos=1
  ptp_clock.c:  ffffffff81f01680  l  F  .text  0000000000000024  unregister_vclock  << sympos=2

Test 1: vmlinux sympos=1
------------------------

  $ cat test-sympos-vmlinux-1.patch
  diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
  index dc398c6b7528..b3267430f4c2 100644
  --- a/drivers/ptp/ptp_sysfs.c
  +++ b/drivers/ptp/ptp_sysfs.c
  @@ -177,6 +177,7 @@ static int unregister_vclock(struct device *dev, void *data)
   	ptp_vclock_unregister(vclock);
   	(*num)--;

  +	pr_info("klp-build test");
   	/* For break. Not error. */
   	if (*num == 0)
   		return -EINVAL;
  diff --git a/fs/eventpoll.c b/fs/eventpoll.c
  index 0e65c7431dfc..b99bfe757c50 100644
  --- a/fs/eventpoll.c
  +++ b/fs/eventpoll.c
  @@ -905,6 +905,7 @@ static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
   	while ((pwq = *p) != NULL) {
   		*p = pwq->next;
   		ep_remove_wait_queue(pwq);
  +		WARN_ON_ONCE(!pwq_cache);
   		kmem_cache_free(pwq_cache, pwq);
   	}
   }

  $ ./scripts/livepatch/klp-build -T test-sympos-vmlinux-1.patch

Check the pwq_cache symbol klp-relocation sympos:

  $ readelf --wide --relocs livepatch-test-sympos-vmlinux-1.ko | grep -w '.klp.sym.vmlinux.pwq_cache'
  0000000000000008  0000006100000001 R_X86_64_64            0000000000000000 .klp.sym.vmlinux.pwq_cache,1 - 4
  0000000000000069  0000006100000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.pwq_cache,1 - 4

Check the unregister_vclock function sympos, first dump out the klp_funcs
relocations to figure out the entries in the array:

  $ readelf --wide --relocs livepatch-test-sympos-vmlinux-1.ko | awk '/.rela.init.klp_funcs/' RS="\n\n" ORS="\n\n"
  Relocation section '.rela.init.klp_funcs' at offset 0x1b0 contains 8 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + 9c
  0000000000000008  0000002b00000001 R_X86_64_64            00000000000000a0 ep_remove + 0
  0000000000000018  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + a6
  0000000000000020  0000002d00000001 R_X86_64_64            0000000000000140 ep_clear_and_put + 0
  0000000000000030  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + b7
  0000000000000038  0000002f00000001 R_X86_64_64            0000000000000210 unregister_vclock + 0
  0000000000000048  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + c9
  0000000000000050  0000006800000001 R_X86_64_64            0000000000000280 eventpoll_release_file + 0

and then pretty-print the klp_func_ext struct:

  $ dump_klp_func_ext livepatch-test-sympos-vmlinux-1.ko
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00, 
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << ep_remove
          .sympos = 0,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << ep_clear_and_put
          .sympos = 0,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << unregister_vclock
          .sympos = 1,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << eventpoll_release_file
          .sympos = 0,
  },


Test2: vmlinux sympos=2
-----------------------

  $ cat test-sympos-vmlinux-2.patch
  diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
  index d6f54ccaf93b..69c4d1f75e15 100644
  --- a/drivers/ptp/ptp_clock.c
  +++ b/drivers/ptp/ptp_clock.c
  @@ -490,6 +490,7 @@ static int unregister_vclock(struct device *dev, void *data)
   {
   	struct ptp_clock *ptp = dev_get_drvdata(dev);

  +	pr_info("klp-build test");
   	ptp_vclock_unregister(info_to_vclock(ptp->info));
   	return 0;
   }
  diff --git a/kernel/workqueue.c b/kernel/workqueue.c
  index 78068ae8f28a..2068c7aa8d6d 100644
  --- a/kernel/workqueue.c
  +++ b/kernel/workqueue.c
  @@ -5310,6 +5310,7 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
   	if (!pool)
   		return NULL;

  +	WARN_ON(!pwq_cache);
   	pwq = kmem_cache_alloc_node(pwq_cache, GFP_KERNEL, pool->node);
   	if (!pwq) {
   		put_unbound_pool(pool);

  $ make -j$(nproc) && ./scripts/livepatch/klp-build -T test-sympos-vmlinux-2.patch

Check the pwq_cache symbol klp-relocation sympos:

  $ readelf --wide --relocs livepatch-test-sympos-vmlinux-2.ko | grep -w '.klp.sym.vmlinux.pwq_cache'
  0000000000000038  0000005a00000001 R_X86_64_64            0000000000000000 .klp.sym.vmlinux.pwq_cache,2 - 4
  0000000000000167  0000005a00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.pwq_cache,2 - 4

Check the unregister_vclock function sympos, first dump out the klp_funcs
relocations to figure out the entries in the array:

  $ readelf --wide --relocs livepatch-test-sympos-vmlinux-2.ko | awk '/.rela.init.klp_funcs/' RS="\n\n" ORS="\n\n"
  Relocation section '.rela.init.klp_funcs' at offset 0x128 contains 4 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000d00000001 R_X86_64_64            0000000000000000 .rodata + 74
  0000000000000008  0000002700000001 R_X86_64_64            0000000000000040 alloc_unbound_pwq + 0
  0000000000000018  0000000d00000001 R_X86_64_64            0000000000000000 .rodata + 86
  0000000000000020  0000002900000001 R_X86_64_64            0000000000000370 unregister_vclock + 0

and then pretty-print the klp_func_ext struct:

  $ dump_klp_func_ext livepatch-test-sympos-vmlinux-2.ko
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .sympos = 0,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .sympos = 2,
  },

Test3: Test1 + Test2 + module sympos=1
--------------------------------------

This last test combines the vmlinux test cases and then adds a module
case on top.

Dump the klp-relocations, we should see the vmlinux.pwq_cache,1 and ,2
as well as dm_bio_prison._cell_cache,1 for the module:

  $ readelf --wide --relocs livepatch-test-sympos-vmlinux-module.ko | \
    grep -w -e '.klp.sym.vmlinux.pwq_cache' -e '.klp.sym.dm_bio_prison._cell_cache'
  0000000000000008  0000007100000001 R_X86_64_64            0000000000000000 .klp.sym.dm_bio_prison._cell_cache,1 - 5
  0000000000000020  0000007100000001 R_X86_64_64            0000000000000000 .klp.sym.dm_bio_prison._cell_cache,1 - 4
  0000000000000068  0000009000000001 R_X86_64_64            0000000000000000 .klp.sym.vmlinux.pwq_cache,2 - 4
  00000000000001b8  0000007a00000001 R_X86_64_64            0000000000000000 .klp.sym.vmlinux.pwq_cache,1 - 4
  000000000000004c  0000007100000002 R_X86_64_PC32          0000000000000000 .klp.sym.dm_bio_prison._cell_cache,1 - 5
  00000000000000f1  0000007100000002 R_X86_64_PC32          0000000000000000 .klp.sym.dm_bio_prison._cell_cache,1 - 4
  0000000000000287  0000009000000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.pwq_cache,2 - 4
  00000000000004c9  0000007a00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.pwq_cache,1 - 4

Finally dump the klp_func_ext struct to see that it's got the correct
sympos for both module unregister_vclock cases:

  $ readelf --wide --relocs livepatch-test-sympos-vmlinux-module.ko | awk '/.rela.init.klp_funcs/' RS="\n\n" ORS="\n\n"
  Relocation section '.rela.init.klp_funcs' at offset 0x250 contains 14 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + 62
  0000000000000008  0000005800000001 R_X86_64_64            0000000000000040 dm_bio_prison_create + 0
  0000000000000018  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + 78
  0000000000000020  0000002b00000001 R_X86_64_64            0000000000000160 alloc_unbound_pwq + 0
  0000000000000030  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + 8a
  0000000000000038  0000002f00000001 R_X86_64_64            0000000000000500 ep_remove + 0
  0000000000000048  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + 94
  0000000000000050  0000003100000001 R_X86_64_64            00000000000005a0 ep_clear_and_put + 0
  0000000000000060  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + a5
  0000000000000068  0000003300000001 R_X86_64_64            0000000000000670 unregister_vclock + 0
  0000000000000078  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + b7
  0000000000000080  0000003500000001 R_X86_64_64            00000000000006c0 unregister_vclock + 0
  0000000000000090  0000000e00000001 R_X86_64_64            0000000000000000 .rodata + c9
  0000000000000098  0000008900000001 R_X86_64_64            0000000000000730 eventpoll_release_file + 0
  
  $ dump_klp_func_ext livepatch-test-sympos-vmlinux-module.ko 
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << dm_bio_prison_create
          .sympos = 0,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << alloc_unbound_pwq
          .sympos = 0,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << ep_remove
          .sympos = 0,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << ep_clear_and_put
          .sympos = 0,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << unregister_vclock
          .sympos = 2,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << unregister_vclock
          .sympos = 1,
  },
  {
          .old_name = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,
          .new_func = 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00,    << eventpoll_release_file
          .sympos = 0,
  },


base-commit: 393988901632138e76d55518d5a0c6cc07cd3ad3
-- 
2.54.0

