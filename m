Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9C17C211;
	Sat, 15 Aug 2026 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757137; cv=none; b=nW6YGTc/62DekKm5gxhjmsd0TnxdKwXYr2dX9Lun6v+NGn7AI17byOng0PoycwNLaqss6NMugr2I4I/sE6kf0osWL1Q2hoMqZMLPI1T/nfHICQxElykDU4nBltKt9TIwbSrDBgWh4s9nyiZq/013i/lcXkjsKS50lgqlPVJNvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757137; c=relaxed/simple;
	bh=uuj3sIb8/16NjhY9ADaWM7jVagxVPUgGDJ7qO35+k0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4PcgCeWFy2Z+aneML1Ge+kEp5IeXvXlEQjWMtR/JEnN+Yvcz+R1GcBeB8h9d/jShkcdJZcUGdKiV28riTRDNoLUZiJn35NCOXo0MZk//8awe9/IDV7fYIhx8++SiKaZQaHfaqtPigVT1AQEto7D8J6/1rJk8xqZ09KaFj0s4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD2HZodM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD2HZodM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE67C1F000E9;
	Sat, 15 Aug 2026 01:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786757135;
	bh=QFZefKgyN0xN26UtFhsfl0y50ng/cw1paUVEUam+St0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SD2HZodM7bUNv5NFgpsIlsLRmq3Y25xw9ZXlDbS7r7X/iK76LqFkxMGxVoWk1/Q+f
	 9h8e6qaXg31lnRT6fMwxPBtsFYk74GR1Y7u+xnYpAYWfXVxaIk/fRRRyH+r88svdtu
	 lttE48eijunMXrxNKvwqv57UMBZ+wi1tEul8wrdvl6+T8Zy2vJyqClUoMHCg98hJGX
	 n/RTsb2V4U2fpYIqG1HdkMZlcXBjImfzB1Wtp4wBVdMjpmpL04trEVz/UrBoNm1VZx
	 tR91T9mGC6mP0SwrCvzQ6LdAeZMc6wSIMSwDikHGDfyZ7QzIy+aTauS6YXoMw4JOl/
	 9FV2GfO4eHvXA==
Date: Fri, 14 Aug 2026 18:25:33 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 8/9] objtool/klp: Fix relocations for
 EXPORT_SYMBOL_FOR_MODULES() symbols
Message-ID: <an-_y1AuR2DUkcSu@jpoimboe>
References: <cover.1786138493.git.jpoimboe@kernel.org>
 <fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org>
 <CADBMgpz7iWC0=t=_gE-tfvv0mTPq4kg0qQ2zgPH8DVPE6eQ9Kw@mail.gmail.com>
 <an-wHwTNX1xDxlRC@jpoimboe>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an-wHwTNX1xDxlRC@jpoimboe>

On Fri, Aug 14, 2026 at 05:18:19PM -0700, Josh Poimboeuf wrote:
> On Fri, Aug 14, 2026 at 02:05:48PM -0700, Dylan Hatch wrote:
> > Following up on the other thread [1], I noticed that when a patch is
> > touching a module function with a reference to one of these
> > module-exported symbols, the patch/module is rejected because KLP
> > relocs referencing vmlinux symbols are not allowed from
> > module-specific livepatch relocation sections. I was able to reproduce
> > this with a simple module/livepatch combo that depends on one of these
> > symbols [2] (see samples/livepatch/testmod.c and test.patch):
> > 
> > root@debian-vm:~$ insmod livepatch-test.ko
> > root@debian-vm:~$ insmod testmod.ko
> > insmod: ERROR: could not insert module testmod.ko: Invalid parameters
> > 
> > With dmesg:
> > [  655.596876] livepatch_test: loading out-of-tree module taints kernel.
> > [  655.600961] livepatch_test: tainting kernel with TAINT_LIVEPATCH
> > [  655.605436] livepatch: enabling patch 'livepatch_test'
> > [  655.609119] livepatch: 'livepatch_test': starting patching transition
> > [  656.653454] livepatch: 'livepatch_test': patching complete
> > [  738.777872] livepatch: invalid access to vmlinux symbol
> > 'get_task_policy' from module-specific livepatch relocation section
> > [  738.784899] livepatch: failed to initialize patch 'livepatch_test'
> > for module 'testmod' (-22)
> > [  738.790371] livepatch: patch 'livepatch_test' failed for module
> > 'testmod', refusing to load module 'testmod'
> > 
> > Do you recommend a strategy for working around this, or is this
> > something that would have to be fixed in the kernel?
> 
> Ah, this is another tooling issue, let me work up a patch.

Here is an untested diff, I'll post a proper patch once I get a chance
to test it.

diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index 646d8e1f12eff..c57775d78c71e 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -20,8 +20,9 @@
  * SHF_RELA_LIVEPATCH, nor does it support having two RELA sections for a
  * single PROGBITS section.
  *
- * "objname" is the name of the object being patched ("vmlinux" or a module
- * name).  post-link uses it to name the resulting
+ * "objname" is the object whose loading gates the relocation: "vmlinux" for
+ * references to vmlinux symbols, otherwise the name of the module being
+ * patched.  post-link uses it to name the resulting
  * .klp.rela.objname.section_name sections.
  */
 #define KLP_RELOCS_SEC	"__klp_relocs"
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index a66049e0726a6..16681a76f13d0 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1344,13 +1344,14 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 			   struct section *sec, unsigned long offset,
 			   struct export *export)
 {
+	const char *sym_modname, *sym_orig_name, *sec_objname;
 	struct symbol *patched_sym = patched_reloc->sym;
 	s64 addend = reloc_addend(patched_reloc);
-	const char *sym_modname, *sym_orig_name;
-	static struct section *klp_relocs;
 	char tombstone_name[SYM_NAME_LEN];
 	struct symbol *sym, *klp_sym;
 	unsigned long klp_reloc_off;
+	struct section *klp_relocs;
+	char sec_name[SEC_NAME_LEN];
 	char sym_name[SYM_NAME_LEN];
 	struct klp_reloc klp_reloc;
 	unsigned long sympos;
@@ -1441,20 +1442,28 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	 * This intermediate step is necessary to prevent corruption by the
 	 * linker, which doesn't know how to properly handle two rela sections
 	 * applying to the same base section.
+	 *
+	 * The objname decides when the reloc gets applied.  A reference to a
+	 * vmlinux symbol goes in the vmlinux section so it gets applied when
+	 * the patch module loads.  Everything else goes in the patched
+	 * object's section, applied when the patched module is loaded.
 	 */
 
+	if (!strcmp(sym_modname, "vmlinux")) {
+		sec_objname = "vmlinux";
+	} else {
+		sec_objname = find_modname(e);
+		if (!sec_objname)
+			return -1;
+	}
+
+	/* section format: __klp_relocs.objname */
+	if (snprintf_check(sec_name, SEC_NAME_LEN,
+			   KLP_RELOCS_SEC ".%s", sec_objname))
+		return -1;
+
+	klp_relocs = find_section_by_name(e->out, sec_name);
 	if (!klp_relocs) {
-		const char *objname = find_modname(e);
-		char sec_name[SEC_NAME_LEN];
-
-		if (!objname)
-			return -1;
-
-		/* section format: __klp_relocs.objname */
-		if (snprintf_check(sec_name, SEC_NAME_LEN,
-				   KLP_RELOCS_SEC ".%s", objname))
-			return -1;
-
 		klp_relocs = elf_create_section(e->out, sec_name, 0,
 						0, SHT_PROGBITS, 8, SHF_ALLOC);
 		if (!klp_relocs)
