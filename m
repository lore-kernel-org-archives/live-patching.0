Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CA3D891F
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556181; cv=none; b=l8n7/r+/TL5IO+03Q5AJxbx/bvL0E04on6l/CnFzxr7ss7xRomaSnALzBDs1VvZtmo1rJrPkrwSpylKEe/GqUMqospSbx7Gmbo/hOktSLAHt0wlc+NRJFOK1Hckjo75E1nygklgScNtxrVBbun8isF/eWDhOEu5M65FUelIY3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556181; c=relaxed/simple;
	bh=XpoFR3JPzQXTMZQiHIvD3lfABbsedj0sRsdZarmYqIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTuZ4ZvKMK/KEPPR5pyz21kPgonS9sFtFsSLmF8B9NCClhB3GjAS8vyXg7U2QMWPOhYiBkPy46kDGAZAfiqo75XsFSTciO6sgzszMwJXBN+zkCRdf08yuCZLJJUcdF6os+VCbrImm2DgIyYS7GiO5FRzkwMYgWqETLmTpJR1oHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EWZwYByV; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EWZwYByV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUaBjWh3I/w17j3E4iJEmAnEhQBvyWwQtpl5kUTTn+8=;
	b=EWZwYByVU7d16ZXu2gAI/jM9FAlDGr3F/INboyuc+u0Op7en0cyq+T5idhjqO78SGl50Nb
	x6gc7Ecu0Y+55pqC+xs+h+UwggWMehp/Y01ok+yqr1atQp0l2Vt1lLULezqLRClxu226qA
	k8NW0zV0JPNkIhQlJjEwZ6imlYOPyI8=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	xry111@xry111.site,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 5/8] LoongArch: fix kernel panic with -fPIC for same-compilation-unit symbol references
Date: Thu,  4 Jun 2026 14:53:14 +0800
Message-Id: <20260604065317.219777-6-dongtai.guo@linux.dev>
In-Reply-To: <20260604065317.219777-1-dongtai.guo@linux.dev>
References: <20260604065317.219777-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add architecture-specific -fPIC compiler flag for LoongArch64 to prevent
kernel panics when applying livepatches containing references to symbols
defined in the same compilation unit.

Root cause:
In the KLP workflow, when a function is livepatched, it's extracted
from the original object file and compiled into a separate kernel
module. When the patched function references symbols defined in the
same compilation unit (like 'uts_sem' in kernel/sys.c), these
references break if not compiled as position-independent code.

On LoongArch64, without -fPIC, references to same-compilation-unit symbols
use absolute addressing that assumes fixed memory locations. When the
function is relocated into the livepatch module, these absolute addresses
become invalid, causing kernel panics.

Example failure case:
- SYSCALL_DEFINE1(newuname) references the same-compilation-unit
  symbol 'uts_sem'
- When kpatch extracts this function into a module, the reference to
  'uts_sem' must be properly relocated
- Without -fPIC, the absolute address reference causes invalid memory
  access and kernel panic

Solution:
Force -fPIC compilation for all LoongArch64 KLP builds. This ensures
that references to same-compilation-unit symbols use position-independent
addressing, allowing proper relocation by the kernel module loader and
preventing kernel panics in livepatch scenarios.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 scripts/livepatch/klp-build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 529437d75346..83a43e0df3b9 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -543,8 +543,10 @@ fix_patches() {
 clean_kernel() {
 	local cmd=()
 	local ARCH_KBUILD_CFLAGS_KERNEL=""
+	local ARCH_KCFLAGS=""
 
 	if [[ -v CONFIG_LOONGARCH && "$CONFIG_LOONGARCH" == "y" ]]; then
+		ARCH_KCFLAGS="-fPIC"
 		if [[ -n "$CONFIG_CC_IS_CLANG" ]]; then
 			ARCH_KBUILD_CFLAGS_KERNEL="-fno-direct-access-external-data"
 		else
@@ -592,7 +594,7 @@ build_kernel() {
 		cmd+=("-s")
 	fi
 	cmd+=("-j$JOBS")
-	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections")
+	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections $ARCH_KCFLAGS")
 	cmd+=("KBUILD_CFLAGS_KERNEL=$ARCH_KBUILD_CFLAGS_KERNEL")
 	cmd+=("vmlinux")
 	cmd+=("modules")
-- 
2.25.1

