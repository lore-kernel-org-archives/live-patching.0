Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95F1E0DE8
	for <live-patching@vger.kernel.org>; Mon, 13 Jul 2026 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978312; cv=none; b=aMEPMUUxilA4BrWIg364+5etpZOZL8F5Nxhre//nyJrLavGla6KZm5ip8dV3RiUt79x7kwU/13DWH/3PWYyQFPaTyhyb/6Yh6p+ofNstPIHchOKuoP6rC42T1K8YWbwLof4CYBoZIhcteDm0izjpLY7T+6b6B+v05vxpQiY4AKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978312; c=relaxed/simple;
	bh=qELT8NVIlrF1qYk23bi2uooH3q0/btzM7Q6hnDHxXbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=kHPknvxv9tp3A9SEURfOlxvbr4/a2LhSJKzp5atwMesMy0DzaSwV27sejbyeY3XCQNJWMp4WPynyn5OkTmg9UAiQ195sHGCf76xYv8u/O/XoTfcnxX0sDnofoait0N8v2pSjSxU2P2b+mdUB3tG2OvoBJAyJWolWNvdAnomHUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEbeNU6b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEbeNU6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783978298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IXuFEOqs+B0Wip5pAcFw5Vle4O0AKryBsKKzv5Qjktc=;
	b=PEbeNU6bx1xKoB26OJDHtapb6vrDM/gr/JN5lKNwaxHcpVuHPwP8UQc6wclpHjaufgslNa
	0laUhKGJWn7hOb6gdygAfk47I8cn2e+L9sJYntat1nn5Rk9WRUCGYm9CUGXWrASKIWcFgl
	7tcbRr9RG64okHdZRKSFxONbrjP3sGY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-u3FX9bfUN-y3i6gL0KhN4w-1; Mon,
 13 Jul 2026 17:31:33 -0400
X-MC-Unique: u3FX9bfUN-y3i6gL0KhN4w-1
X-Mimecast-MFC-AGG-ID: u3FX9bfUN-y3i6gL0KhN4w_1783978292
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7547F195608D;
	Mon, 13 Jul 2026 21:31:32 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3E151956044;
	Mon, 13 Jul 2026 21:31:30 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Ben Procknow <bprockno@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 0/1] Fix exported symbol klp-relocation bug
Date: Mon, 13 Jul 2026 17:31:27 -0400
Message-ID: <20260713213128.3529250-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Here is another klp-build bug reported downstream by Ben and reproduced
upstream by me:

Config
======

Default-ish config, note the KVM modules and allowing missing module NS
imports (more on that later):

  $ make defconfig
  $ ./scripts/config --file .config \
             --set-val CONFIG_FTRACE y \
             --set-val CONFIG_KALLSYMS_ALL y \
             --set-val CONFIG_FUNCTION_TRACER y \
             --set-val CONFIG_DYNAMIC_FTRACE y \
             --set-val CONFIG_DYNAMIC_DEBUG y \
             --set-val CONFIG_LIVEPATCH y \
             --set-val CONFIG_KVM m \
             --set-val CONFIG_KVM_INTEL m \
             --set-val CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS y
  $ make olddefconfig


Base kernel and livepatch build
===============================

  $ make -j$(nproc)

Build a small patch to kvm :: mmu.c that introduces a call to
kvm_flush_remote_tlbs():

  $ cat minimal-kvm-repro.patch
  diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
  index 24fbc9ea502a..3f11b8c051ce 100644
  --- a/arch/x86/kvm/mmu/mmu.c
  +++ b/arch/x86/kvm/mmu/mmu.c
  @@ -2553,6 +2553,9 @@ static void __link_shadow_page(struct kvm *kvm,
                  drop_large_spte(kvm, sptep, flush);

          spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
  +
  +       if (flush)
  +               kvm_flush_remote_tlbs(kvm);

          mmu_spte_set(sptep, spte);

Ignore the namespace complaint for now:

  $ ./scripts/livepatch/klp-build -T minimal-kvm-repro.patch
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  arch/x86/kvm/kvm.o: changed function: __link_shadow_page
  Building patch module: livepatch-minimal-kvm-repro.ko
  WARNING: modpost: module livepatch-minimal-kvm-repro uses symbol kvm_flush_remote_tlbs from namespace module:kvm-intel, but does not import it.
  SUCCESS

klp-relocation inspection
=========================

Take a look at the generated klp-relocation symbols:

  $ readelf --wide --symbols livepatch-minimal-kvm-repro.ko | grep -o '.klp.sym.*'
  .klp.sym.kvm.kvm_flush_remote_tlbs_sptep,0
  .klp.sym.kvm.make_nonleaf_spte,0
  .klp.sym.kvm.drop_spte,0
  .klp.sym.arch/x86/kvm/kvm.kvm_flush_remote_tlbs,0        << "arch/x86/kvm/kvm" what?!
  .klp.sym.kvm.pte_list_add.isra.0,0
  .klp.sym.kvm.kvm_mmu_mark_parents_unsync,0

Oddly, the klp-relocation looks like the pathname / Module.symvers:

  $ grep kvm_flush_remote_tlbs Module.symvers
  0x00000000      kvm_flush_remote_tlbs   arch/x86/kvm/kvm        EXPORT_SYMBOL_GPL       module:kvm-intel
                                          ^^^^^^^^^^^^^^^^


klp-diff
========

In klp-diff.c :: clone_reloc_klp() there are two paths for grabbing a
symbol's module name, depending on whether it's been exported or not:

  	/*
  	 * Create the KLP symbol.
  	 */

  	if (export) {
  		sym_modname = export->mod;
  		sym_orig_name = export->sym;
  		sympos = 0;
  	} else {
  		sym_modname = find_modname(e);
  		if (!sym_modname)
  			return -1;

where the !export path calls find_modname() and __find_modname contains
some string manipulation at the end to form a simple, normalized kernel
module name:

  	for (char *c = name; *c; c++) {
  		if (*c == '/')
  			name = c + 1;
  		else if (*c == '-')
  			*c = '_';
  		else if (*c == '.') {
  			*c = '\0';
  			break;
  		}
  	}

but the export path assigns export->mod directly, which was originally
extracted from the Modules.symvers file in read_exports() with no such
string simplification.

AFAICT no where does klp-diff expect to handle export->mod as a path and
not a normalized module name.


Fix
===

With that, the attached patch extracts the string code from
__find_modname() into a helper function that both it and read_exports()
can call.

  $ ./scripts/livepatch/klp-build -T minimal-kvm-repro.patch
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  arch/x86/kvm/kvm.o: changed function: __link_shadow_page
  Building patch module: livepatch-minimal-kvm-repro.ko
  WARNING: modpost: module livepatch-minimal-kvm-repro uses symbol kvm_flush_remote_tlbs from namespace module:kvm-intel, but does not import it.
  SUCCESS

  $ readelf --wide --symbols livepatch-minimal-kvm-repro.ko | grep -o '.klp.sym.*'
  .klp.sym.kvm.kvm_flush_remote_tlbs_sptep,0
  .klp.sym.kvm.make_nonleaf_spte,0
  .klp.sym.kvm.kvm_flush_remote_tlbs,0                     << fixed
  .klp.sym.kvm.drop_spte,0
  .klp.sym.kvm.pte_list_add.isra.0,0
  .klp.sym.kvm.kvm_mmu_mark_parents_unsync,0


Next: symbol namespaces
=======================

Now a harder question, I think, about symbol namespaces.  In the past,
kpatch-build had supported patching symbols in namespace where
MODULE_IMPORT_NS() is allowed.  Looking at kvm :: mmu.c
::kvm_flush_remote_tlbs(), that is annotated with
EXPORT_SYMBOL_FOR_KVM_INTERNAL() instead.

Should we make an effort to support klp-relocations / patching to this
use-case?

If modpost were to let klp-relocation symbols through, I *think*
(untested) that might be enough... but it seems like that may violate
the spirit of what the namespacing effort is trying to achieve.

Note that klp-post-link converts these symbols to SHN_LIVEPATCH before
the module is loaded, so the kernel module loader already skips them in
simplify_symbols() (see SHN_LIVEPATCH case).  AFAICT, the namespace
check in modpost is the only enforcement point, and it's checking a
symbol that will never be resolved through the normal module loading
path anyway.

Regards,

Joe Lawrence (1):
  objtool/klp-diff: normalize Module.symvers paths to module names

 tools/objtool/klp-diff.c | 42 ++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

-- 
2.54.0

