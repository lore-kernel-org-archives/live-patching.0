Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717862;
	b=VdRHXv6asOc4tXBtugf6kkg04OE4na/LqQgieNOjLdnE2FFZg2DETKVhLqQ+HQXTzQIg
	 Y5U9vCMeHZInYsYMGYfnS4WASd1IyQYpu5BgVk6X8yVQZy3Aq8AFziRYGFW0GDI2kXqZ6
	 yWJ2BC6MhmnABt7iA6TBBv9fJ97TQMNbSoTB4F9yT9kmJZapgU3hxA3sYPKtvsQTDYtn+
	 OvNoqPgImKkFAE9zJXFihZuyNsjOpWACzMoO4Z0TKODaQ3G0mIaArPFP30Gk/KMzMe1o4
	 S6TuHNIowIL5IDmXaWMUsptseGuMLYaQ3qOt/5mDVE1l1i9jWIivsb8VjmgncA7mdYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717862;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lZzPvzju+g33P3liCaxscm0OcvvfOjw+rlMrb9m5NcI=;
	b=ucsBRvIuUevCEmQGn4or0FISGLdPc0S+WzIgBhL+riZeHOQFIP9cgAWlfoL5l8spU67D
	 iHzKHZN4L5K1l75s2z3UMM8m9qbGlnyGZZymeJAwlWzx7iJ5dpdqAYbpam7homsr6bKvg
	 XuXETrK0utaYUgbCnz9+3feeO9Lm0EwIw3A08wZqYcEx5je8CfjzJE9AH02QIdFnvtk8N
	 2fe0bHo0otdtLTxAqzCjTFY1QqnLO8yTQLJ6QG4fpMIXhYAhrEtB7hRTMobSK+3/ExmGs
	 kKi/sgfsxW9/XIYOX1/Sdu8s2lTMmG840rDGK/goaBtIdWwLB9OzIglYBEdkQhprRPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5xOFylA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC75606A319;
	Fri, 23 Oct 2026 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5xOFylA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7831F031E4;
	Fri, 23 Oct 2026 01:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717862;
	bh=lZzPvzju+g33P3liCaxscm0OcvvfOjw+rlMrb9m5NcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5xOFylA7ua/MYMKvvpx6sbPeR9Oo6n93/BVdgS3Hmj4rsxCsx9QBQvZeN+9QIyyz
	 s+pB3U6J8fDgx0K7k+IYf5/3b2bZnvoaKDDNCT8zIiwQg87DA7JsjZ0ICF1g5aoP7u
	 KfjV7rN3QcxcqePCM1MPcTFaFWuSWUqre7rvsZBrP9T0DWSke1kkWJW3lFPq6KE8KR
	 GqI17mX1IITqpz6wLJqq1EQ7+pVN1s0Pn1QbMz0QVfnxog05uad0hLhUugx6Rpnljv
	 DN6udEW+8UTJTTnQHPFyhlfEfXcKup02bSihFqC7Ew6u+vA2jseKZJYswffrgKYfvW
	 LcD523PRP1qQw==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 01/16] x86/paravirt: Mark native pv_ops helpers notrace
Date: Thu, 22 Oct 2026 18:10:34 -0700
Message-ID: <20261023011049.1164625-2-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023011049.1164625-1-song@kernel.org>
References: <20261023011049.1164625-1-song@kernel.org>
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

The native implementations of several pv_ops are static inline functions
in headers. pv_ops stores their address, so with CONFIG_PARAVIRT_XXL the
compiler emits an out-of-line copy of each one, and pv_ops calls go to
that copy. Today these copies are not traced only because the inline
macro implies notrace.

Some callers of these helpers must not be traced:
restore_processor_state() is notrace and runs during resume,
__switch_to() is __notrace_funcgraph, and arch/x86/kernel/cpu/common.c
and arch/x86/kernel/tsc.c, which call several of them, are built
without -pg.

Mark these helpers notrace explicitly, like native_write_msr() and
native_write_msr_safe() already are, so they stay untraced if inline no
longer implies notrace. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/include/asm/cpuid/api.h     |  4 ++--
 arch/x86/include/asm/desc.h          | 17 +++++++++--------
 arch/x86/include/asm/gsseg.h         |  2 +-
 arch/x86/include/asm/io_bitmap.h     |  2 +-
 arch/x86/include/asm/msr.h           |  6 +++---
 arch/x86/include/asm/pgalloc.h       |  2 +-
 arch/x86/include/asm/pgtable_64.h    | 10 +++++-----
 arch/x86/include/asm/processor.h     |  2 +-
 arch/x86/include/asm/special_insns.h |  2 +-
 include/linux/pgtable.h              | 12 ++++++------
 10 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 82eddfa2347b..8322792c1208 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -23,8 +23,8 @@ static inline bool cpuid_feature(void)
 }
 #endif
 
-static inline void native_cpuid(u32 *eax, u32 *ebx,
-				u32 *ecx, u32 *edx)
+static inline void notrace native_cpuid(u32 *eax, u32 *ebx,
+					u32 *ecx, u32 *edx)
 {
 	/* ecx is often an input as well as an output. */
 	asm volatile("cpuid"
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 00aeae843529..9a01dc9c191a 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -134,17 +134,18 @@ static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
 
 #define store_ldt(ldt) asm("sldt %0" : "=m"(ldt))
 
-static inline void native_write_idt_entry(gate_desc *idt, int entry, const gate_desc *gate)
+static inline void notrace native_write_idt_entry(gate_desc *idt, int entry, const gate_desc *gate)
 {
 	memcpy(&idt[entry], gate, sizeof(*gate));
 }
 
-static inline void native_write_ldt_entry(struct desc_struct *ldt, int entry, const void *desc)
+static inline void notrace
+native_write_ldt_entry(struct desc_struct *ldt, int entry, const void *desc)
 {
 	memcpy(&ldt[entry], desc, 8);
 }
 
-static inline void
+static inline void notrace
 native_write_gdt_entry(struct desc_struct *gdt, int entry, const void *desc, int type)
 {
 	unsigned int size;
@@ -189,7 +190,7 @@ static inline void __set_tss_desc(unsigned cpu, unsigned int entry, struct x86_h
 
 #define set_tss_desc(cpu, addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 
-static inline void native_set_ldt(const void *addr, unsigned int entries)
+static inline void notrace native_set_ldt(const void *addr, unsigned int entries)
 {
 	if (likely(entries == 0))
 		asm volatile("lldt %w0"::"q" (0));
@@ -205,7 +206,7 @@ static inline void native_set_ldt(const void *addr, unsigned int entries)
 	}
 }
 
-static inline void native_load_gdt(const struct desc_ptr *dtr)
+static inline void notrace native_load_gdt(const struct desc_ptr *dtr)
 {
 	asm volatile("lgdt %0"::"m" (*dtr));
 }
@@ -251,7 +252,7 @@ static inline void native_idt_invalidate(void)
  * original writeable version when needed.
  */
 #ifdef CONFIG_X86_64
-static inline void native_load_tr_desc(void)
+static inline void notrace native_load_tr_desc(void)
 {
 	struct desc_ptr gdt;
 	int cpu = raw_smp_processor_id();
@@ -280,7 +281,7 @@ static inline void native_load_tr_desc(void)
 }
 #endif
 
-static inline unsigned long native_store_tr(void)
+static inline unsigned long notrace native_store_tr(void)
 {
 	unsigned long tr;
 
@@ -289,7 +290,7 @@ static inline unsigned long native_store_tr(void)
 	return tr;
 }
 
-static inline void native_load_tls(struct thread_struct *t, unsigned int cpu)
+static inline void notrace native_load_tls(struct thread_struct *t, unsigned int cpu)
 {
 	struct desc_struct *gdt = get_cpu_gdt_rw(cpu);
 	unsigned int i;
diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index ab6a595cea70..14596425f36a 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -25,7 +25,7 @@ static inline void native_lkgs(unsigned int selector)
 			    : [sel] "+D" (sel));
 }
 
-static inline void native_load_gs_index(unsigned int selector)
+static inline void notrace native_load_gs_index(unsigned int selector)
 {
 	if (cpu_feature_enabled(X86_FEATURE_LKGS)) {
 		native_lkgs(selector);
diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 7f080f5c7def..af3b08a685e6 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -19,7 +19,7 @@ struct task_struct;
 void io_bitmap_share(struct task_struct *tsk);
 void io_bitmap_exit(struct task_struct *tsk);
 
-static inline void native_tss_invalidate_io_bitmap(void)
+static inline void notrace native_tss_invalidate_io_bitmap(void)
 {
 	/*
 	 * Invalidate the I/O bitmap by moving io_bitmap_base outside the
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 2f41a9289d79..ca138498a00b 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -101,7 +101,7 @@ static __always_inline u64 native_rdmsrq(u32 msr)
 #define native_wrmsrq(msr, val)				\
 	__wrmsrq((msr), (val))
 
-static inline u64 native_read_msr(u32 msr)
+static inline u64 notrace native_read_msr(u32 msr)
 {
 	u64 val;
 
@@ -113,7 +113,7 @@ static inline u64 native_read_msr(u32 msr)
 	return val;
 }
 
-static inline int native_read_msr_safe(u32 msr, u64 *p)
+static inline int notrace native_read_msr_safe(u32 msr, u64 *p)
 {
 	int err;
 	EAX_EDX_DECLARE_ARGS(val, low, high);
@@ -159,7 +159,7 @@ static inline int notrace native_write_msr_safe(u32 msr, u64 val)
 extern int rdmsr_safe_regs(u32 regs[8]);
 extern int wrmsr_safe_regs(u32 regs[8]);
 
-static inline u64 native_read_pmc(int counter)
+static inline u64 notrace native_read_pmc(int counter)
 {
 	EAX_EDX_DECLARE_ARGS(val, low, high);
 
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c88691b15f3c..8d233e2e72bf 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -12,7 +12,7 @@
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
-static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
+static inline int notrace __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index ce45882ccd07..8399ff79941f 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -58,7 +58,7 @@ static inline bool mm_p4d_folded(struct mm_struct *mm)
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte);
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
-static inline void native_set_pte(pte_t *ptep, pte_t pte)
+static inline void notrace native_set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
 }
@@ -74,7 +74,7 @@ static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
 	native_set_pte(ptep, pte);
 }
 
-static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
+static inline void notrace native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	WRITE_ONCE(*pmdp, pmd);
 }
@@ -110,7 +110,7 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 #endif
 }
 
-static inline void native_set_pud(pud_t *pudp, pud_t pud)
+static inline void notrace native_set_pud(pud_t *pudp, pud_t pud)
 {
 	WRITE_ONCE(*pudp, pud);
 }
@@ -135,7 +135,7 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 #endif
 }
 
-static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
+static inline void notrace native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
@@ -155,7 +155,7 @@ static inline void native_p4d_clear(p4d_t *p4d)
 	native_set_p4d(p4d, native_make_p4d(0));
 }
 
-static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline void notrace native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	WRITE_ONCE(*pgdp, pti_set_user_pgtbl(pgdp, pgd));
 }
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 87b1d4c0727e..e25f709720df 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -536,7 +536,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 	fpu_thread_struct_whitelist(offset, size);
 }
 
-static inline void
+static inline void notrace
 native_load_sp0(unsigned long sp0)
 {
 	this_cpu_write(cpu_tss_rw.x86_tss.sp0, sp0);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 46aa2c9c1bda..810c992f3a0d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -12,7 +12,7 @@
 
 void native_write_cr0(unsigned long val);
 
-static inline unsigned long native_read_cr0(void)
+static inline unsigned long notrace native_read_cr0(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr0,%0" : "=r" (val));
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2981e386da7b..bfdd19ae3194 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1602,9 +1602,9 @@ static inline int pmd_none_or_clear_bad(pmd_t *pmd)
 	return 0;
 }
 
-static inline pte_t __ptep_modify_prot_start(struct vm_area_struct *vma,
-					     unsigned long addr,
-					     pte_t *ptep)
+static inline pte_t notrace __ptep_modify_prot_start(struct vm_area_struct *vma,
+						     unsigned long addr,
+						     pte_t *ptep)
 {
 	/*
 	 * Get the current pte state, but zero it out to make it
@@ -1614,9 +1614,9 @@ static inline pte_t __ptep_modify_prot_start(struct vm_area_struct *vma,
 	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
 }
 
-static inline void __ptep_modify_prot_commit(struct vm_area_struct *vma,
-					     unsigned long addr,
-					     pte_t *ptep, pte_t pte)
+static inline void notrace __ptep_modify_prot_commit(struct vm_area_struct *vma,
+						     unsigned long addr,
+						     pte_t *ptep, pte_t pte)
 {
 	/*
 	 * The pte is non-present, so there's no hardware state to
-- 
2.53.0-Meta

