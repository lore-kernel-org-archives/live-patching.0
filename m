Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EC3B9D99
	for <live-patching@vger.kernel.org>; Mon, 20 Jul 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559429; cv=none; b=qGcmvIHYgQigkzQP2wGkv3uD6SHggns+ind/QwFyFo3rNJaQT+gXMRoB5IErUD0pOiH08BFqIhoeYyyXjyY9D0fI77mDsMiXInYD6rUpP61EsFonjTF+AvKKHD0eC+o3z34RLde8CFseURQo8Wza1mLqS8kVB2/tWUNLGp5cO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559429; c=relaxed/simple;
	bh=EBCw4ahKd0mk6lFsFMU8bF8GJ5Gy4/x6bw7MxSjOUjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=dYNofW37NvFLNwivmN1OKlVYoVU8wGquj1Chvrxm71bymD3J9d8jNjlYOkpSEXS9bkvIKdspBLBYanbV5YnWLjXKHe6A6yuMkz7v6W9xowSN7zrfKheR9UemFMYtVd/dpo9KKcVOfdnekHDl3/On4fUVcXx4F7FTvMzs3UA1xYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XazaHdRV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XazaHdRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784559426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YE4fqRbTdQHm92PtONqCeX2PzCW9M/UiuKneTBVCf8U=;
	b=XazaHdRVcORsGTGj7hTgBeyv7Ud4/UBJ5+fwq7F7KOf3KWOD0L/rRAlmJJBDPAEIudlg8S
	FGRbNGuUEuDwKlzfeWsQtU8OafnJDbeSxiIM1XCfdgsAiUhwVnU8yA++lgsxCg/AwcZw2Z
	xf1+QJq+oNgqiHQ4iQhnnkARRfatFow=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-llpFmAXZN0qFiQ9oBLulag-1; Mon,
 20 Jul 2026 10:57:02 -0400
X-MC-Unique: llpFmAXZN0qFiQ9oBLulag-1
X-Mimecast-MFC-AGG-ID: llpFmAXZN0qFiQ9oBLulag_1784559421
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91B891802A98;
	Mon, 20 Jul 2026 14:57:01 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82A7930001BE;
	Mon, 20 Jul 2026 14:57:00 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 0/4] klp-build: klp-relocation fixups
Date: Mon, 20 Jul 2026 10:56:54 -0400
Message-ID: <20260720145658.1103243-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is a combination bug report and patchset (apologies for the
cover-letter length).

The problem space is klp-build, klp-relocations, exported symbols and
everyone's favorite, late-module patching :(

The first two patches could probably stand on their own, but the last
two make policy decisions that I could have gotten wrong, or require
some further discussion.  The final patch was AI-created as I just
wanted something out there to demo a potential fix.  I'm sure Sashiko
will have something to say and the bots can critic each other :D 


Summary
=======

Patch1
------
Fix klp-relocation section handling so that the <objname> piece refers
to the patched object, and not the parent object of the symbol.
Otherwise they may not be processed by the kernel (which is iterating
over livepatch klp_objects, not all loaded kernel objects).

Patch2
------
Relax a twin-symbol check when the livepatch adds a new reference to an
exported module symbol.  This restriction doesn't exist for non-exported
symbols, so we should allow it.

Patch3 & 4
----------
These could be considered for squashing, but I've kept them separate for
their initial triage / review.

Existing cross-module references (i.e. from can-isotp.ko to can.ko)
produced klp-relocations that modpost turned into depends= entries.  This
meant that the livepatch module inherited an explicit module dependency
on those referenced modules, breaking late-module patching for such
livepatches.

Restore late-module patching by stripping the module dependencies
specifically introduced by klp-relocations (leave other dependencies
untouched).  At the same time, reject patches that would introduce
references to modules the patched target doesn't already depend on (i.e.
do not allow klp-build to introduce new module dependencies).

Together this allows the livepatch to load before its target's
dependency chain is present, while still maintaining safety: when the
target module eventually loads, its own dependencies guarantee the
klp-relocation targets are available.


Config
======

The patchset and reproducers were based on top of:
  393988901632 (jpoimboe/objtool/urgent) objtool/klp: normalize Module.symvers paths to module names

Start with a default x86 config, add livepatch requirements, and build
the can and can-isotp modules:

  $ make defconfig
  $ ./scripts/config --file .config \
               --set-val CONFIG_FTRACE y \
               --set-val CONFIG_KALLSYMS_ALL y \
               --set-val CONFIG_FUNCTION_TRACER y \
               --set-val CONFIG_DYNAMIC_FTRACE y \
               --set-val CONFIG_DYNAMIC_DEBUG y \
               --set-val CONFIG_LIVEPATCH y \
               --set-val CONFIG_CAN m \
               --set-val CONFIG_CAN_ISOTP m
  $ make olddefconfig


Patch1: existing-xmod-ref.patch
================================

Build a small patch to can-isotp :: isotp.c to do anything:

  $ cat existing-xmod-ref.patch
  diff --git a/net/can/isotp.c b/net/can/isotp.c
  index c48b4a818297..3e216e11be98 100644
  --- a/net/can/isotp.c
  +++ b/net/can/isotp.c
  @@ -1195,6 +1195,8 @@ static int isotp_release(struct socket *sock)
   	struct isotp_sock *so;
   	struct net *net;

  +	pr_info("klp-build test");
  +
   	if (!sk)
   		return 0;

  $ ./scripts/livepatch/klp-build -T existing-xmod-ref.patch
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  net/can/can-isotp.o: changed function: isotp_release
  Building patch module: livepatch-existing-xmod-ref.ko
  SUCCESS

klp-relocation inspection
-------------------------
The build succeeds, the correct function marked as changed, but the
corresponding klp-relocations are saved across two sections:

  $ readelf --wide --relocs livepatch-existing-xmod-ref.ko

  [ ... snip ... ]

  Relocation section '.klp.rela.can_isotp..text' at offset 0x30a0 contains 7 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  00000000000000f6  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  0000000000000112  0000004100000002 R_X86_64_PC32          0000000000000000 .klp.sym.can_isotp.isotp_busy_notifier,0 - 4
  000000000000011b  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  0000000000000131  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  000000000000014d  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  00000000000001c9  0000003c0000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_rcv,0 + 0
  00000000000001f5  000000370000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_rcv_echo,0 + 0

  Relocation section '.klp.rela.can..text' at offset 0x3148 contains 2 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  00000000000001df  0000005a00000004 R_X86_64_PLT32         0000000000000000 .klp.sym.can.can_rx_unregister,0 - 4
  000000000000020b  0000005a00000004 R_X86_64_PLT32         0000000000000000 .klp.sym.can.can_rx_unregister,0 - 4

Note that the same patch built with kpatch-build puts them into a single
section:

  Relocation section '.klp.rela.can_isotp..text.isotp_release' at offset 0xe12e8 contains 10 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  00000000000000c1  000000610000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,1 + 0
  00000000000000d7  0000006200000002 R_X86_64_PC32          0000000000000000 .klp.sym.can_isotp.isotp_busy_notifier,1 - 4
  00000000000000e0  000000610000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,1 + 0
  00000000000000f6  000000610000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,1 + 0
  0000000000000102  0000006200000002 R_X86_64_PC32          0000000000000000 .klp.sym.can_isotp.isotp_busy_notifier,1 - 4
  000000000000013a  000000610000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,1 + 0
  00000000000002b4  000000630000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_rcv,1 + 0
  00000000000002ca  0000009500000004 R_X86_64_PLT32         0000000000000000 .klp.sym.can.can_rx_unregister,0 - 4
  00000000000002e0  000000640000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_rcv_echo,1 + 0
  00000000000002f6  0000009500000004 R_X86_64_PLT32         0000000000000000 .klp.sym.can.can_rx_unregister,0 - 4

which aligns with the Documentation/livepatch/module-elf-format.rst
definition:

  The name of a livepatch relocation section must conform to the following
  format::

    .klp.rela.objname.section_name
    ^        ^^     ^ ^          ^
    |________||_____| |__________|
       [A]      [B]        [C]

  [A]
    The relocation section name is prefixed with the string ".klp.rela."

  [B]
    The name of the object (i.e. "vmlinux" or name of module) to
    which the relocation section belongs follows immediately after the prefix.

  [C]
    The actual name of the section to which this relocation section applies.

and its example:

  Relocation section '.klp.rela.btrfs.text.btrfs_feature_attr_show' at offset 0x2ba0 contains 4 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  000000000000001f  0000005e00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.printk,0 - 4
  0000000000000028  0000003d0000000b R_X86_64_32S           0000000000000000 .klp.sym.btrfs.btrfs_ktype,0 + 0
  0000000000000036  0000003b00000002 R_X86_64_PC32          0000000000000000 .klp.sym.btrfs.can_modify_feature.isra.3,0 - 4
  000000000000004c  0000004900000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.snprintf,0 - 4

So as I understand it, there are two objnames with two different roles:

    (section name) .klp.rela.objname.section_name
                             ^^^^^^^
                             WHICH object is being patched

    (symbol name)  .klp.sym.objname.symbol_name,sympos
                            ^^^^^^^
                            WHERE the symbol lives

The kernel only applies .klp.rela.<objname>.* sections when it processes
a matching klp_object.  The reproducer livepatch module's
.init.klp_objects only declares can_isotp (the patched module).  There
is no klp_object for can (only a module dependency), and so only the
.klp.rela.can_isotp..text relocations get resolved.

With fix
--------
Unfortunately while klp-diff knows the patched module name, it cannot
create the final .klp.rela.* / SHN_LIVEPATCH yet (the module link would
not preserve them).  So klp-post-link creates those KLP relocations after
linking, but by then the original object's name is gone from the .ko.

I think the easiest solution is to stash the patched module name in the
struct klp_reloc during klp-diff, then the klp-post-link can simply read
the per-rela modname and assign to the correct klp-relocation section
accordingly.

Here is the same klp-relocation section with the attached patch:

  Relocation section '.klp.rela.can_isotp..text' at offset 0x3208 contains 9 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  00000000000000f6  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  0000000000000112  0000004100000002 R_X86_64_PC32          0000000000000000 .klp.sym.can_isotp.isotp_busy_notifier,0 - 4
  000000000000011b  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  0000000000000131  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  000000000000014d  000000590000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_notifier_lock,0 + 0
  00000000000001c9  0000003c0000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_rcv,0 + 0
  00000000000001df  0000005a00000004 R_X86_64_PLT32         0000000000000000 .klp.sym.can.can_rx_unregister,0 - 4
  00000000000001f5  000000370000000b R_X86_64_32S           0000000000000000 .klp.sym.can_isotp.isotp_rcv_echo,0 + 0
  000000000000020b  0000005a00000004 R_X86_64_PLT32         0000000000000000 .klp.sym.can.can_rx_unregister,0 - 4


Patch2: new-xmod-ref.patch
=================================

Build a patch to can-isotp :: isotp.c to call an exported function in
the can module:

  $ cat new-xmod-ref.patch
  diff --git a/net/can/isotp.c b/net/can/isotp.c
  index c48b4a818297..b54236e9e1d0 100644
  --- a/net/can/isotp.c
  +++ b/net/can/isotp.c
  @@ -1195,6 +1195,8 @@ static int isotp_release(struct socket *sock)
   	struct isotp_sock *so;
   	struct net *net;

  +	can_set_skb_uid(NULL);
  +
   	if (!sk)
   		return 0;

  $ ./scripts/livepatch/klp-build -T new-xmod-ref.patch
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  net/can/can-isotp.o: error: objtool: unexpected klp reloc for new symbol can_set_skb_uid
  net/can/can-isotp.o: changed function: isotp_release
  error: klp-build: objtool klp diff failed
  error: klp-build: line 729: '( cd "$ORIG_CSUM_DIR"; [[ -v VERBOSE ]] && echo "cd $ORIG_CSUM_DIR && ${cmd[*]}"; "${cmd[@]}" > >(tee -a "$log") 2> >(tee -a "$log" | "${filter[@]}" 1>&2) || die "objtool klp diff failed" )'

Error explanation
-----------------
This error is emitted by klp-diff :: clone_reloc_klp(), when it's asked
to clone a klp-relocation for a patched symbol that has no twin:

  	if (!patched_sym->twin) {
  		ERROR("unexpected klp reloc for new symbol %s", patched_sym->name);
  		return -1;
  	}

(just to confirm):

  $ readelf --wide --symbols ./klp-tmp/1-orig/net/can/can-isotp.o | grep can_set_skb_uid
  (nothing)
  $ readelf --wide --symbols ./klp-tmp/2-patched/net/can/can-isotp.o | grep can_set_skb_uid
     188: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND can_set_skb_uid

With fix
--------
For this specific case, I believe that we can safely relax the check to
allow for new klp-relocations to exported symbols*.

  $ ./scripts/livepatch/klp-build -T new-xmod-ref.patch
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  net/can/can-isotp.o: changed function: isotp_release
  Building patch module: livepatch-new-xmod-ref.ko
  SUCCESS

and there's a klp-relocation generated for the exported symbol:

  $ readelf --wide --relocs livepatch-new-xmod-ref.ko
  [ ... snip ... ]
  Relocation section '.klp.rela.can_isotp..text' at offset 0x33a0 contains 11 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  000000000000005a  0000005b00000004 R_X86_64_PLT32         0000000000000000 .klp.sym.can.can_set_skb_uid,0 - 4
  [ ... snip ... ]

* note the following module dependency info ...

ratsai
Module dependency side-effect
=============================

Note that cross-module klp-relocations currently introduce a livepatch
module dependency through modpost.  For example, the Patch 1 livepatch
module:

  $ modinfo -F depends livepatch-existing-xmod-ref.ko
  can

This occurs because clone_reloc_klp() creates STB_WEAK UNDEF placeholder
symbols (so the linker/objtool are happy before post-link).  modpost
runs before post-link and adds depends= from these weak undefs.

(For comparison, kpatch-build avoided this by stripping the original
relocation symbols entirely before linking.)

On the one hand, the module dependency introduces a refcount that
prevents the can driver from unloading while the livepatch is loaded,
turning the implicit klp-relocation dependency into an explicit one.  On
the other hand, it prevents the late-module patching scenario for any
realistically complex livepatch that patches a module and not vmlinux.

IMHO, the best of both worlds is to strip the module dependencies
introduced only by klp-relocations, while rejecting patches that would
reference a module the livepatch target doesn't already depend on.
Patches 3 and 4 implement this: klp-post-link strips the spurious
depends= entries, and klp-diff validates that new export references stay
within the target's existing dependency chain.

(Alternatively, we could allow livepatch module dependencies for new
cross-module references.  That should be safe and still allow partial
late-module patching (of the original target module's other
dependencies).  That said, the permutations of late-module patching make
the head spin, so this v1 patchset keeps it simple.)


Patch3 & Patch4
===============

These two (squashable?) patches seek to restore late-module patching to
selective livepatche scenarios that contain cross-module references to
exported functions:

  0- (regression test) livepatch adds a klp-relocation to vmlinux
     exported function, can-isotp.ko -> vmlinux:

     existing-xmod-ref.patch - OK
     $ modinfo -F depends livepatch-existing-xmod-ref.ko
     (nothing)

  1- (now passes) livepatch adds another klp-relocation to an existing
     cross-module dependency, can-isotp.ko -> can.ko:

     new-xmod-ref.patch - OK
     $ modinfo -F depends livepatch-new-xmod-ref.ko
     (nothing)

  2- (expected failure) livepatch adds a klp-relocation cross-module to a
     new cross-module dependency, can-isotp.ko -> can-dev.ko:

     $ cat new-xmod-dep.patch
     diff --git a/net/can/isotp.c b/net/can/isotp.c
     index c48b4a818297..6ea83d55a714 100644
     --- a/net/can/isotp.c
     +++ b/net/can/isotp.c
     @@ -1195,6 +1195,10 @@ static int isotp_release(struct socket *sock)
      	struct isotp_sock *so;
      	struct net *net;

     +	extern struct net_device *alloc_candev_mqs(int, unsigned int, unsigned int);
     +
     +	pr_info("can-dev export: %px\n", alloc_candev_mqs);
     +
      	if (!sk)
      		return 0;

     ./scripts/livepatch/klp-build -T new-xmod-dep.patch
     Validating patch(es)
     Building original kernel
     Copying original object files
     Fixing patch(es)
     Building patched kernel
     Copying patched object files
     Generating original checksums
     Generating patched checksums
     Diffing objects
     net/can/can-isotp.o: changed function: isotp_release
     net/can/can-isotp.o: error: objtool: alloc_candev_mqs: new reference to alloc_candev_mqs (exported by can_dev) would create an undeclared module dependency
     error: klp-build: objtool klp diff failed
     error: klp-build: line 729: '( cd "$ORIG_CSUM_DIR"; [[ -v VERBOSE ]] && echo "cd $ORIG_CSUM_DIR && ${cmd[*]}"; "${cmd[@]}" > >(tee -a "$log") 2> >(tee -a "$log" | "${filter[@]}" 1>&2) || die "objtool klp diff failed" )'


Joe Lawrence (4):
  objtool/klp: use patched module name for klp-relocation section naming
  objtool/klp: allow new references to module exports
  objtool/klp: reject new cross-module references without existing
    dependency
  objtool/klp: strip klp-induced module dependencies from livepatch
    modules

 tools/objtool/include/objtool/klp.h |   1 +
 tools/objtool/klp-diff.c            |  98 ++++++++++++--
 tools/objtool/klp-post-link.c       | 195 ++++++++++++++++++++++++++--
 3 files changed, 271 insertions(+), 23 deletions(-)

-- 
2.54.0

