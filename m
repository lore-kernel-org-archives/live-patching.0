Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58138399CF0
	for <live-patching@vger.kernel.org>; Tue,  6 Oct 2026 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270614; cv=none; b=kGgW21nUsx25PsYBNArUpS1nvMHse4uzXysEp9DVOCQA9fF/92gdyhIhwEVyNpksAS0E4zKFY3uRbSseFudA6vmC4KgB/0TbuCFuaqeneEiy3RtIdOJJfgbIt/lRpKWw1UdxfuxakpjHXra9PONf+dDNP5qH485KxEyWWfmvBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270614; c=relaxed/simple;
	bh=vYnjVhDtloIxAbFfle/bKGhDoZZixZpgT5vIEhRJ8Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJ6qxXOQdEWEMrhxoy+RLCVoN+8UFhBdbM3SuQJWo7sVeETeQgLgXBpOxBCCdRwLlTP2aj8O2H4xhqzdXUk3ENhuA3VO8Lj/qLCqfVWlF+73eM9rqNgwkkt49KaeleXiQws0CG3Q592LIgslPlVfidZcb+2oYCcjUVto4M3Pu94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCqm7Kk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCqm7Kk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29E21F00893;
	Tue,  6 Oct 2026 07:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791270613;
	bh=H2B4pFhh9Up5TZm+g+LPAgTBWRk9cOPjvt7oge8zZsc=;
	h=From:To:Cc:Subject:Date;
	b=KCqm7Kk9RcZgAN2cQic6nW9mRYY3VmFcjb+FuD63YtcGBlsfKLzZQJthQCveR58gp
	 7psIXUBJQ83+7n43k9TVDn0Te0Xi/+cvtn8oJuZmiXrK4nTqMuMRssv/aQeD7hBmJn
	 FrDDVEHCHEmMHRudL14oC5SnUlUBbg0DRFCveyerkr3JeHh8Mxrj/bJQPB63XW6xO9
	 kvA2uKoRL30q1t+iiTHgic2VVLkHOj7PKu56zVd6eACjEm1ieq8g7bdpZFXYrnnvC9
	 Q9yeonrv+eD4r+n/dooMXmxEj6hxPPCG9xQQiFHdd+EBDZ+4fc7EwcfvvuvECUDYSt
	 RH1Q6R/pmUjjQ==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	Song Liu <song@kernel.org>
Subject: [PATCH] objtool/klp: Fix detection of static keys defined in other files
Date: Tue,  6 Oct 2026 00:10:03 -0700
Message-ID: <20261006071003.291679-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_special_section_klp_reloc() finds the key of a __jump_table or
.static_call_sites entry by looking for a reloc to an STT_OBJECT symbol.
But a key is STT_OBJECT only in the object file which defines it.  In
any other object file it is an undefined symbol, which is STT_NOTYPE,
and the check misses it.  For example, with tracepoint keys:

  Patched file            Tracepoint          Key defined in       Type
  ----------------------  ------------------  -------------------  ------
  vmlinux:
  kernel/sched/core.c     sched_switch        same file            OBJECT
  kernel/sched/fair.c     sched_stat_runtime  kernel/sched/core.c  NOTYPE
  kvm.ko:
  arch/x86/kvm/x86.c      kvm_msr             same file            OBJECT
  arch/x86/kvm/lapic.c    kvm_apic_ipi        arch/x86/kvm/x86.c   NOTYPE
  cachefiles.ko:
  fs/cachefiles/io.c      netfs_sreq          vmlinux              NOTYPE
  kvm-intel.ko:
  arch/x86/kvm/vmx/vmx.c  kvm_exit            kvm.ko               NOTYPE

Missing a key in vmlinux is harmless, as the check accepts vmlinux keys
anyway.  Their entries are cloned with a normal reloc to the key if
vmlinux exports it to all modules, as for netfs_sreq, and with a klp
reloc otherwise, which the module loader applies before it initializes
the livepatch module's static branches and static calls.

But a livepatch can't use a key defined in a module, so klp-diff has to
disable such tracepoints, as it does for kvm_msr above.  For keys
defined in another file of the same module, as for kvm_apic_ipi, or in
another module, as for kvm_exit, it instead clones the entries with klp
relocs for their keys.

The resulting patch module crashes the kernel on load.  The livepatch
module's static calls and static branches get initialized while their key
fields still wait for the klp relocs.  The static call init rewrites the
call instruction, so applying its klp reloc fails:

  module: x86/modules: Invalid relocation target, existing value is nonzero for sec 66, idx 16, type 4, loc ffffffffa04021f3, val ffffffffffffe0f5

and static_call_del_module() then dereferences the bogus key while
cleaning up after the failed init:

  BUG: unable to handle page fault for address: ffffffffa2373994
  RIP: 0010:static_call_del_module+0x38/0x80
  Call Trace:
   static_call_module_notify+0x42/0x1a0
   notifier_call_chain+0x5f/0xd0
   blocking_notifier_call_chain+0x41/0x60
   do_init_module+0x23d/0x2a0

Also treat undefined symbols as keys.  The other relocs of these entries
refer to code in the patched object, which is always defined.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/klp-diff.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 34da55e45609..cbc475d79156 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1862,8 +1862,13 @@ static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym
 		if (convert_reloc_sym(e->patched, reloc))
 			continue;
 
-		/* Static branch/call keys are always STT_OBJECT */
-		if (reloc->sym->type != STT_OBJECT) {
+		/*
+		 * Static branch/call keys are STT_OBJECT if they're defined
+		 * in this object file.  Keys defined in another file, whether
+		 * in vmlinux, the same module or another module, are undefined
+		 * symbols, which are STT_NOTYPE.
+		 */
+		if (reloc->sym->type != STT_OBJECT && !is_undef_sym(reloc->sym)) {
 
 			/* Save code location which can be printed below */
 			if (reloc->sym->type == STT_FUNC && !code_sym) {
-- 
2.53.0-Meta

