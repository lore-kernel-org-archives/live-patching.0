Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350633DF001
	for <live-patching@vger.kernel.org>; Tue, 30 Jun 2026 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844855; cv=none; b=GRarJ9jMdzJtiuyudV3TnUI2RbkUvgN2okGSeWg6iwDpbZ7lQdUvLeHrMGoefuQEyEskray1duQCgpQxHKsGX+/WC06nRfWEDHEtltZlYheT4dUlO4qSf81x/7WUVlkQCFoeq562GbDycWsTJ9L3M8NR6FEvbRK9gBRI3gQktNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844855; c=relaxed/simple;
	bh=b7kz+BYXPzyAhJkly9P833AoCRoue+Zg8P9/zTBVICA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sylH7RuHdtIkiEtrbLqa7+Zhs4Kzc65UBuhoaykGwPu0aGKVlWZflEvzZ7KEzTKFoKgFYOIGZDiL6gdmz4MNnJIXyfHg9veml38t4MnFKxRVt2emWAF5ygSgfbQDJYoDz11S7WR1xLnQ/SM3fkNNppGHJyTVCVKKDPM3YPC1nzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUIK6Vaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUIK6Vaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782844853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03Oo3Cf7JT/UPmuljUkLr4OWGWMPiP6ymFXAAr0ePwc=;
	b=RUIK6Vaj5IpDqHRjgdltE7h6yGK65K/J7A/7pUGAsUT6t3BL8ZffSsP1V6oBEuSLkZdREH
	VVhajiPWrea1QPju0ODx6YEM5Q/ZQoRqsZ9CrTVNmB3oYQLk4WlkJ87sLoxlv42GipGTmy
	wPyO8/8XQexagrZHZK5jFJc3iksGras=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-nSAxEOEKPmePHM-O2UQTYw-1; Tue,
 30 Jun 2026 14:40:51 -0400
X-MC-Unique: nSAxEOEKPmePHM-O2UQTYw-1
X-Mimecast-MFC-AGG-ID: nSAxEOEKPmePHM-O2UQTYw_1782844849
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 279741955BC5;
	Tue, 30 Jun 2026 18:40:48 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.46])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64AAE3692E;
	Tue, 30 Jun 2026 18:40:44 +0000 (UTC)
Date: Tue, 30 Jun 2026 14:40:42 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 14/21] objtool: Prevent kCFI hashes from being decoded
 as instructions
Message-ID: <akQNqlfFC0T5pcMa@redhat.com>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <b1d50c9fc9e6b9bca43833cc4ccbd88a31fed84b.1778642120.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d50c9fc9e6b9bca43833cc4ccbd88a31fed84b.1778642120.git.jpoimboe@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Tue, May 12, 2026 at 08:33:48PM -0700, Josh Poimboeuf wrote:
> On arm64 with CONFIG_CFI=y, Clang places a 4-byte kCFI type hash
> immediately before each address-taken function entry.  Since these
> hashes are in the text section, objtool tries to decode them, leading to
> unpredictable results (e.g., "unannotated intra-function call").
> 
> arm64 uses mapping symbols to annotate where code ends and data begins
> (and vice versa).  Use those to just mark such "instructions" as NOP so
> objtool will ignore them.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Hi Josh,

While continuing down the klp-build unit test path, I found a bug in
kCFI special-section handling.  I don't think it's directly related to
this patch, though it was the motivation to try testing kCFI + klp-build
together.

This looks like the same Clang/klp-diff issue as commit f7ceffd21a8a
("objtool/klp: Fix kCFI prefix finding/cloning").  That commit fixed
prefix finding in .text, while this one is in .kcfi_traps and causes
create_fake_symbols() to skip the entire section, so
clone_special_sections() extracts nothing. (klp-build still exits
SUCCESS, but the livepatch .ko has no __kcfi_traps.)

That means da4326573ae8 ("objtool/klp: Fix kCFI trap handling"), which
added .kcfi_traps to the special-section list, would be incomplete for
the fake-symbol path.

Bug report as follows:


Kernel Config
=============

Setup LLVM and CFI, plus livepatching requirements on top of the default
x86 config:

  $ make clean
  $ make LLVM=1 defconfig

  # For livepatching
  $ ./scripts/config --file .config \
         --set-val CONFIG_FTRACE y \
         --set-val CONFIG_KALLSYMS_ALL y \
         --set-val CONFIG_FUNCTION_TRACER y \
         --set-val CONFIG_DYNAMIC_FTRACE y \
         --set-val CONFIG_DYNAMIC_DEBUG y \
         --set-val CONFIG_LIVEPATCH y

  # For CFI
  $ ./scripts/config --file .config \
         --set-val CONFIG_CFI y

  $ make LLVM=1 olddefconfigremotes/origin/objtool/urgent
  $ make LLVM=1 -j$(nproc)


Livepatch
=========

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..6944d3f53847 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -809,6 +809,8 @@ static int proc_single_show(struct seq_file *m, void *v)
 	if (!task)
 		return -ESRCH;

+	pr_debug("test: proc_single_show\n");
+
 	ret = PROC_I(inode)->op.proc_show(m, ns, pid, task);

 	put_task_struct(task);


klp-build
=========

The klp-build looks good and exits with SUCCESS:

  $ LLVM=1 scripts/livepatch/klp-build -T klp-cfi-traps.patch 2>&1 | tee out
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  vmlinux.o: changed function: proc_single_show
  Building patch module: livepatch-klp-cfi-traps.ko
  SUCCESS

The patched vmlinux.o contains a per-function .kcfi_traps section
associated with .text.proc_single_show, but klp-build does not copy the
traps section into the livepatch module:

  $ llvm-readelf --wide --sections klp-tmp/3-checksum-patched/vmlinux.o

  Section Headers:
  [Nr]     Name                               Type      Address           Off      Size    ES  Flg  Lk      Inf    Al
  [74992]  .text.proc_single_show             PROGBITS  0000000000000000  164d470  0000f5  00  AX   0       0      16
  [74993]  .kcfi_traps                        PROGBITS  0000000000000000  164d565  000004  00  AL   74992   0      1
  [74994]  __patchable_function_entries       PROGBITS  0000000000000000  164d570  000008  00  WAL  74992   0      8
  [74995]  .rela.text.proc_single_show        RELA      0000000000000000  164d578  000120  18  I    299696  74992  8
  [74996]  .rela.kcfi_traps                   RELA      0000000000000000  164d698  000018  18  I    299696  74993  8
  [74997]  .rela__patchable_function_entries  RELA      0000000000000000  164d6b0  000018  18  I    299696  74994  8

  $ llvm-readelf --wide --relocs klp-tmp/3-checksum-patched/vmlinux.o | \
      awk '$0 ~ "at offset 0x164d698" {p=1; print; next} /^Relocation section/ {p=0} p'
  Relocation section '.rela.kcfi_traps' at offset 0x164d698 contains 1 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  00016d6700000002 R_X86_64_PC32          0000000000000000 .text.proc_single_show + 6b

  $ llvm-readelf --wide --sections livepatch-klp-cfi-traps.ko  | grep .kcfi_traps
  (none)


The root cause is that create_fake_symbols() skips the entire special
section if any symbol exists at offset 0.  But Clang places a .Ltmp*
label at the start of .kcfi_traps, so no per-entry fake symbols are
created and clone_special_sections() extracts nothing.

  static int create_fake_symbols(struct elf *elf)
  {
  ...
  	/*
  	 * 2) Make symbols for sh_entsize, and simple arrays of pointers:
  	 */
  entsize:
  	for_each_sec(elf, sec) {
  		unsigned int entry_size;
  		unsigned long offset;

  		if (!is_special_section(sec) || find_symbol_by_offset(sec, 0))
  			continue;

  $ llvm-readelf --wide --symbols klp-tmp/3-checksum-patched/vmlinux.o | \
          awk '$7 == 74993'
   93266: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   74993 .Ltmp78
   93544: 0000000000000000     0 SECTION LOCAL  DEFAULT   74993 .kcfi_traps


Possible fix: ignore .L* assembler-local labels at section offset 0
using the existing is_local_label() helper.

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index b9624bd9439b..4ba400926647 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1860,8 +1860,17 @@ static int create_fake_symbols(struct elf *elf)
 	for_each_sec(elf, sec) {
 		unsigned int entry_size;
 		unsigned long offset;
+		struct symbol *sym_at_0;

-		if (!is_special_section(sec) || find_symbol_by_offset(sec, 0))
+		if (!is_special_section(sec))
+			continue;
+
+		/*
+		 * Clang may place assembler-local .L* labels at offset 0;
+		 * they must not prevent per-entry fake symbol creation.
+		 */
+		sym_at_0 = find_symbol_by_offset(sec, 0);
+		if (sym_at_0 && !is_local_label(sym_at_0))
 			continue;

 		if (!sec->rsec) {

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

With that allowance, the section propagates through to the livepatch.ko:

  $ llvm-readelf --wide --sections livepatch-klp-cfi-traps.ko | grep kcfi_traps
    [ 5] __kcfi_traps      PROGBITS        0000000000000000 0000b8 000004 00  AL  0   0  1
    [27] .rela__kcfi_traps RELA            0000000000000000 001410 000018 18   I 51   5  8

  $ llvm-readelf --wide --relocs livepatch-klp-cfi-traps.ko | \
      awk '$0 ~ ".rela__kcfi_traps" {p=1; print; next} /^Relocation section/ {p=0} p'
  Relocation section '.rela__kcfi_traps' at offset 0x1410 contains 1 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000b00000002 R_X86_64_PC32          0000000000000010 proc_single_show + 5b


Additionally, how about a follow-on patch that detects and warns when
special sections should have been included, but are missing for whatever
reason?  Something like:

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 4ba400926647..2e265d38259e 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -2029,12 +2029,33 @@ static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym
 	return ret;
 }

+/* True if any relocation in sec references a changed (included) function. */
+static bool special_section_refs_included_func(struct elf *elf, struct section *sec)
+{
+	struct reloc *reloc;
+
+	if (!sec->rsec)
+		return false;
+
+	for_each_reloc(sec->rsec, reloc) {
+		if (convert_reloc_sym(elf, reloc))
+			continue;
+
+		if (reloc->sym->included && is_func_sym(reloc->sym))
+			return true;
+	}
+
+	return false;
+}
+
 static int clone_special_section(struct elfs *e, struct section *patched_sec)
 {
 	bool is_pfe = !strcmp(patremotes/origin/objtool/urgentched_sec->name, "__patchable_function_entries");
 	struct section *out_sec = NULL;
 	struct reloc *patched_reloc;
 	struct symbol *patched_sym;
+	unsigned int cloned = 0;
+	unsigned int skipped = 0;

 	/*
 	 * Extract all special section symbols (and their dependencies) which
@@ -2053,13 +2074,17 @@ static int clone_special_section(struct elfs *e, struct section *patched_sec)
 		ret = validate_special_section_klp_reloc(e, patched_sym);
 		if (ret < 0)
 			return -1;
-		if (ret > 0)
+		if (ret > 0) {
+			skipped++;
 			continue;
+		}

 		out_sym = clone_symbol(e, patched_sym, true);
 		if (!out_sym)
 			return -1;

+		cloned++;
+
 		if (!is_pfe || (out_sec && out_sec->sh.sh_link))
 			continue;

@@ -2075,6 +2100,19 @@ static int clone_special_section(struct elfs *e, struct section *patched_sec)
 		out_sec->sh.sh_link = patched_reloc->sym->clone->sec->idx;
 	}

+	/*
+	 * Detect extraction failures: the patched object references
+	 * changed functions from this section, but nothing was cloned and
+	 * nothing was intentionally skipped (e.g. disabled tracepoints).
+	 */
+	if (special_section_refs_included_func(e->patched, patched_sec) &&
+	    cloned == 0 && skipped == 0) {
+		out_sec = find_section_by_name(e->out, patched_sec->name);
+		if (!out_sec || !sec_size(out_sec))
+			WARN("%s: %s missing from output despite references to changed functions",
+			     objname, patched_sec->name);
+	}
+
 	return 0;
 }

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--
H
k
wHappy to spin the .L* fix out as a separate patch post based on your
tklp-build-arm64 or other branch (Fixes: da4326573ae8), with the
warn-on-empty-extraction as an optional follow-up if you'd like that
too.

--
Joe

