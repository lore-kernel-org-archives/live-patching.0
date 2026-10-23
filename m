Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717868;
	b=mzGEFSQA4eIY7PelnxObul4Ix3TC13dOHsaIuNA2WX1yZd4ZInmGnFONDA9+a0252USx
	 voUGGFsLsmD8vBc/2a/M/DTYlDWSzODdAuWBGVHCzMU8aUYkgyUZwI1EKSRgJesimaIg+
	 8zfIkq2uY1ceSQWEVpv8UmxkYljM7U5IzZug046us654cC57+WQsAPvHbsr6u+0FfyNb9
	 LMjU/bHF0/sac5J1PYs8wCzTMzdV+xpxlHqnCZIhVmoDXFULZF6bBnZY/fKz9L6UZJ2rQ
	 HuliDSfowg9ik8JpDrOVmtOV1YkaoNz9sgSlHUj1a43/9bQxkbLpJ019ucg8u1YeGHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w9+88Jlzt772upZdqk8We2SPgjcfOiU0U8AJ+xOeguU=;
	b=wviTA+uIxXPCYqEhi2hLA1jnZD/5QdkY04CdRTcMH+gdUzCuOIcQlzO2CauE1BP/4Smq
	 XDysnSUUDSo5ic2a5NKi++qFJfbFfYbAnGc3P55NLvaPFDtwZY4rI/pB9M2jJ3EmiN9JL
	 gkzqC4yUWHeNwPcZtSNRRkJl94xBYf0wE3IVQJda2FjUT48omLguIH9GKGYZsjHVI9Ott
	 TNJRoUYJK5u3qeM5Rmr/NVw9pVMnqatKFKN/S6jUfh02HAlgCKLt9C2WHLRGAvsMBRDzx
	 OzGezudkTWPcSHEoiJUAEzWS+lEbA57I+juJsMNQ9r1vB4/apdzECX9QTJQfivX7UEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keskdqwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743D606A319;
	Fri, 23 Oct 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keskdqwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375D01F031E5;
	Fri, 23 Oct 2026 01:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717867;
	bh=w9+88Jlzt772upZdqk8We2SPgjcfOiU0U8AJ+xOeguU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=keskdqwk5k14gDBdNZcROtq/2tI1WN+lIOQCZwSDWtXqQBEix+mrVmsxqzW/Ab9dI
	 mRRU6654JBbdG46B35UOOZ3Z8Lhs5WFmn9HIRcmqsn3c98tlg4mUgovCl+u/+rT771
	 QqxjuFwZezaGQMguy5UZx9RAB1DRdv0Djk7aPpgP91Q8uX+tZsf11geB3aafRSqitM
	 qzpLmEoRXWWk2VFtsDhsKgS7YHp+7eq4jJNi50n9euk+6c/O5TQyOZl6jYZM4N58pB
	 c3KVXd5K5NWByq45Omtd4rMR+eGQA9qVyAfXq24IEBZ6wIlcAIvEpFHPWacy4bakpq
	 TbWoqXXsrZxpw==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 02/16] x86: Mark CPU state helpers used by resume and kexec notrace
Date: Thu, 22 Oct 2026 18:10:35 -0700
Message-ID: <20261023011049.1164625-3-song@kernel.org>
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

__restore_processor_state() is notrace because it starts running before
%gs and the IDT are restored, when the function tracer cannot run yet.
Before it restores MSR_GS_BASE, it calls wrmsrq(), __write_cr4(),
write_cr3(), write_cr0(), load_idt() and loadsegment(), and after that
it calls load_gs_index(). With CONFIG_PARAVIRT_XXL, wrmsrq() calls
paravirt_write_msr(). machine_kexec() calls virt_to_phys() after
load_segments() has reset %gs. All of these are plain inline functions.
If the compiler emits one of them out of line, that copy is untraced
only because inline implies notrace.

Mark them notrace explicitly, together with the other paravirt MSR
accessors, so they stay consistent with paravirt_write_msr(). No
functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/include/asm/gsseg.h         |  2 +-
 arch/x86/include/asm/io.h            |  2 +-
 arch/x86/include/asm/msr.h           |  2 +-
 arch/x86/include/asm/paravirt.h      | 20 ++++++++++----------
 arch/x86/include/asm/segment.h       |  4 ++--
 arch/x86/include/asm/special_insns.h |  6 +++---
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index 14596425f36a..d46d6effb631 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -52,7 +52,7 @@ static inline void __init lkgs_init(void)
 
 #ifndef CONFIG_PARAVIRT_XXL
 
-static inline void load_gs_index(unsigned int selector)
+static inline void notrace load_gs_index(unsigned int selector)
 {
 #ifdef CONFIG_X86_64
 	native_load_gs_index(selector);
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 7f4847b2b904..721ce7878966 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -126,7 +126,7 @@ extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
  *	this function
  */
 
-static inline phys_addr_t virt_to_phys(volatile void *address)
+static inline phys_addr_t notrace virt_to_phys(volatile void *address)
 {
 	return __pa(address);
 }
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index ca138498a00b..7c311dbcd0bf 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -194,7 +194,7 @@ static inline void wrmsr(u32 msr, u32 low, u32 high)
 #define rdmsrq(msr, val)			\
 	((val) = native_read_msr((msr)))
 
-static inline void wrmsrq(u32 msr, u64 val)
+static inline void notrace wrmsrq(u32 msr, u64 val)
 {
 	native_write_msr(msr, val);
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 0591aa38fd85..c30af937103b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -98,7 +98,7 @@ static inline unsigned long read_cr0(void)
 	return PVOP_CALL0(unsigned long, pv_ops, cpu.read_cr0);
 }
 
-static inline void write_cr0(unsigned long x)
+static inline void notrace write_cr0(unsigned long x)
 {
 	PVOP_VCALL1(pv_ops, cpu.write_cr0, x);
 }
@@ -120,32 +120,32 @@ static inline unsigned long __read_cr3(void)
 			      "mov %%cr3, %%rax", ALT_NOT_XEN);
 }
 
-static inline void write_cr3(unsigned long x)
+static inline void notrace write_cr3(unsigned long x)
 {
 	PVOP_ALT_VCALL1(pv_ops, mmu.write_cr3, x, "mov %%rdi, %%cr3", ALT_NOT_XEN);
 }
 
-static inline void __write_cr4(unsigned long x)
+static inline void notrace __write_cr4(unsigned long x)
 {
 	PVOP_VCALL1(pv_ops, cpu.write_cr4, x);
 }
 
-static inline u64 paravirt_read_msr(u32 msr)
+static inline u64 notrace paravirt_read_msr(u32 msr)
 {
 	return PVOP_CALL1(u64, pv_ops, cpu.read_msr, msr);
 }
 
-static inline void paravirt_write_msr(u32 msr, u64 val)
+static inline void notrace paravirt_write_msr(u32 msr, u64 val)
 {
 	PVOP_VCALL2(pv_ops, cpu.write_msr, msr, val);
 }
 
-static inline int paravirt_read_msr_safe(u32 msr, u64 *val)
+static inline int notrace paravirt_read_msr_safe(u32 msr, u64 *val)
 {
 	return PVOP_CALL2(int, pv_ops, cpu.read_msr_safe, msr, val);
 }
 
-static inline int paravirt_write_msr_safe(u32 msr, u64 val)
+static inline int notrace paravirt_write_msr_safe(u32 msr, u64 val)
 {
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
@@ -167,7 +167,7 @@ do {						\
 	val = paravirt_read_msr(msr);		\
 } while (0)
 
-static inline void wrmsrq(u32 msr, u64 val)
+static inline void notrace wrmsrq(u32 msr, u64 val)
 {
 	paravirt_write_msr(msr, val);
 }
@@ -215,7 +215,7 @@ static inline void load_gdt(const struct desc_ptr *dtr)
 {
 	PVOP_VCALL1(pv_ops, cpu.load_gdt, dtr);
 }
-static inline void load_idt(const struct desc_ptr *dtr)
+static inline void notrace load_idt(const struct desc_ptr *dtr)
 {
 	PVOP_VCALL1(pv_ops, cpu.load_idt, dtr);
 }
@@ -234,7 +234,7 @@ static inline void load_TLS(struct thread_struct *t, unsigned cpu)
 	PVOP_VCALL2(pv_ops, cpu.load_tls, t, cpu);
 }
 
-static inline void load_gs_index(unsigned int gs)
+static inline void notrace load_gs_index(unsigned int gs)
 {
 	PVOP_VCALL1(pv_ops, cpu.load_gs_index, gs);
 }
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index dbd90fede5e7..01ed6f1f7952 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -303,7 +303,7 @@ extern const char xen_early_idt_handler_array[NUM_EXCEPTION_VECTORS][XEN_EARLY_I
  * FS and GS.
  */
 #define LOAD_SEGMENT(seg)						\
-static inline void __loadsegment_##seg(u16 value)			\
+static inline void notrace __loadsegment_##seg(u16 value)		\
 {									\
 	asm volatile("1:	movl %k0,%%" #seg "\n"			\
 		     _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k0)\
@@ -325,7 +325,7 @@ LOAD_SEGMENT(gs)
 
 #else
 
-static inline void __loadsegment_fs(u16 value)
+static inline void notrace __loadsegment_fs(u16 value)
 {
 	asm volatile("1:	movw %0, %%fs\n"
 		     "2:\n"
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 810c992f3a0d..f854eb3333d0 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -147,7 +147,7 @@ static inline unsigned long read_cr0(void)
 	return native_read_cr0();
 }
 
-static inline void write_cr0(unsigned long x)
+static inline void notrace write_cr0(unsigned long x)
 {
 	native_write_cr0(x);
 }
@@ -171,12 +171,12 @@ static inline unsigned long __read_cr3(void)
 	return __native_read_cr3();
 }
 
-static inline void write_cr3(unsigned long x)
+static inline void notrace write_cr3(unsigned long x)
 {
 	native_write_cr3(x);
 }
 
-static inline void __write_cr4(unsigned long x)
+static inline void notrace __write_cr4(unsigned long x)
 {
 	native_write_cr4(x);
 }
-- 
2.53.0-Meta

