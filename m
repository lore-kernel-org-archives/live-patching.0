Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E726B0A9;
	Sat, 15 Aug 2026 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769151; cv=none; b=P6t1KFfct/K2Uq1DILtmYbw4RYTXSZKhT1Z85QdCpC2NkYVGKq8I1qMNjQacblRzj8WCbvT5YbTRE3yFD4qQoahY8pNN+cu7QkmdRPDWyppp94Nz2fdAiP48s50LlGx6K9d8Yu6dJx17j5Y+7sj2bgM5vq/+A8SHG+TEEcXiwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769151; c=relaxed/simple;
	bh=A09Gz/TbCoq2Ti5x0s6Ko+kTzNOkw34ti4/mPVs+PyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb9zhS3dpvLMjguZZ/SBatdk1XnlJy32VX9jswBVvFKQS7/61CH1EnxKjb8DHU9WqY7H1iLT0px8qeo8pNFH1Dw8plhfSSxJCylFOqGRDrx/fWno3ZcVjEI/5KQnvYAfLrtt1PUZ2VKSHPBEQGVlJRVcDQ7psPF0I3ggSKHwpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLDRKPO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLDRKPO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067411F00A3E;
	Sat, 15 Aug 2026 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769148;
	bh=6LkxS33qnyE/6tqok/ZW8s+G6Ny9jOmY+DYEf5VvPts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLDRKPO2UAIfe9qZWTOKMzIBtGSupsM7I5UNXXkTscXGh4eLgd5aRLRk2KX5Jo9em
	 RqQGPZtUjoVXI7ylHlpW8LzTWmAN5wKggj2aGVJP6BnCloppuw7OTvjLVBQ34sPHb1
	 m2vlhihI3FNAeccKVL8GKESwDkGqmCdiaXWxmDw/AEETGuZnttpgiKD5Qdrc6Os9Zs
	 OcF2DovHma57YhbyvB5TncHDkq3gL+Yu5z0s+O5bS6Ha5fFIhDmPGIsiwWzeNXC67J
	 ZmDvvdmkEXE067zQSkVAvypdT3TL8RecUiVLt5eOE9rqN0MUaK1UlubbUz9ACME0xT
	 jwox+srVzRe8g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 08/12] arm64/bti: Enable BTI in the pi/ startup code
Date: Fri, 14 Aug 2026 21:45:25 -0700
Message-ID: <5c25e0a625b4d16a6e91e63c8d82e33d8c043d74.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The early startup code in kernel/pi/ is built with
-mbranch-protection=none and has its property note stripped, which
prevents the linker from generating BTI veneers in >128MB kernels.

Unlike the assembly objects, which only lacked the note because
SYM_FUNC_START*() already emits the landing pads, pi/ needs the real
thing.  Some of it runs with the MMU on, where the kernel text is mapped
PTE_GP and BTI is enforced: __pi_scs_patch() is called when loading a
module, and __pi_map_range() is called from create_idmap().

Add -mbranch-protection=bti.  The added "bti c" landing pads execute as
NOPs in the startup code wherever BTI isn't implemented or isn't enforced.

Also stop stripping the objects' property notes, as the linker only
marks the output BTI-compatible if *all* objects advertise it.  Keeping
the note as-is isn't enough either: --prefix-alloc-sections=.init
renames it to .init.note.gnu.property, which GNU ld still parses but LLD
ignores.  Rename it back afterwards so both linkers see it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/pi/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index be92d73c25b21..2101d96d754e5 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -4,7 +4,7 @@
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
 		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_KSTACK_ERASE) \
 		   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
-		   $(call cc-option,-mbranch-protection=none) \
+		   $(call cc-option,-mbranch-protection=bti) \
 		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
 		   -include $(srctree)/include/linux/hidden.h \
 		   -D__DISABLE_EXPORTS -ffreestanding -D__NO_FORTIFY \
@@ -21,11 +21,14 @@ KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 hostprogs	:= relacheck
 
+# --prefix-alloc-sections=.init also renames .note.gnu.property, which LLD then
+# ignores, dropping the BTI property.  Rename it back.
 quiet_cmd_piobjcopy = $(quiet_cmd_objcopy)
-      cmd_piobjcopy = $(cmd_objcopy) && $(obj)/relacheck $(@) $(<)
+      cmd_piobjcopy = $(cmd_objcopy) && \
+		      $(OBJCOPY) --rename-section .init.note.gnu.property=.note.gnu.property $(@) && \
+		      $(obj)/relacheck $(@) $(<)
 
-$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
-			       --remove-section=.note.gnu.property
+$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_
 $(obj)/%.pi.o: $(obj)/%.o $(obj)/relacheck FORCE
 	$(call if_changed,piobjcopy)
 
-- 
2.55.0

