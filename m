Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A83C1F2B
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556164; cv=none; b=ME66pggAZUL4KpLUHXJRtJCY4ToRSnNF+TDCaMIwekGfykZC42WViAsVG+lvuhaNuWs1BQwKhz2nApnGfad4gix7GqjJX1G5yA1E4Vy+J1oNMCHVAfAawbUSOGx+ZHmuXfbNVI4GQm7uj8WASEZ8Pz5iMGqe75KBRZk+1howYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556164; c=relaxed/simple;
	bh=u1iDBVc2w/8vztJQrTnvoSQW8h/eE2UgCzY5Oc9d34c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icM5AHIMCAU6BwzGwCNhfrxhdu9dydctWL5wrhHreANFxz/3wKyBcbOyOJYPJF2nefRUX9GYXMg9MgFP0XVXQ7vYz0ORsjZIjY3JP3wMQ32agUEZBE3+DX+ypn0kL42w+B242jAusagpqJs0vLiN+UsQ7Iy131Hq836QPH+rYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ctkvIpS3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ctkvIpS3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npSVQzrI/XnrvzPC4XtktJ2Mr3iT0r1KkLt6HOzTG1o=;
	b=ctkvIpS3BVWrT2AHdJySXGoxvdLf5e+qSEylduVmVDE5YJVLosqtUhWc6Zxgnnk7UkTPUF
	8Dloeogh/Ndt9gCDE3jDdRBhyZhZYLCHBa7AgtDY2eJbJ5FnTp4p20Zdyaethg6Ec+hNQw
	eDhSTVK0I6ViWR26M62X0g33Q04tLqU=
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
Subject: [PATCH 4/8] livepatch/klp-build: disable direct-extern-access for LoongArch to fix kernel panic
Date: Thu,  4 Jun 2026 14:53:13 +0800
Message-Id: <20260604065317.219777-5-dongtai.guo@linux.dev>
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

On LoongArch systems, livepatch modules containing references to
EXTERNAL global variables trigger kernel panics when the core kernel is
built with the -mdirect-extern-access optimization.

Root cause:
The -mdirect-extern-access optimization replaces GOT-based external
symbol access with direct addressing for improved performance. However,
this breaks the kernel module loading mechanism, which relies on GOT
entries for proper relocation of EXTERNAL symbol references. Direct
access to global variables from livepatch modules causes invalid memory
accesses and kernel panics.

Solution:
For LoongArch klp builds, conditionally disable direct-extern-access by
adding:
- -mno-direct-extern-access for GCC builds
- -fno-direct-access-external-data for Clang builds

See also commit 38b10b269d04 ("LoongArch: Tweak CFLAGS for Clang
compatibility"), which added -mdirect-extern-access to the kernel as a
nice-to-have optimization that reduces GOT accesses.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 scripts/livepatch/klp-build | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index e83973567c87..529437d75346 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -542,6 +542,17 @@ fix_patches() {
 
 clean_kernel() {
 	local cmd=()
+	local ARCH_KBUILD_CFLAGS_KERNEL=""
+
+	if [[ -v CONFIG_LOONGARCH && "$CONFIG_LOONGARCH" == "y" ]]; then
+		if [[ -n "$CONFIG_CC_IS_CLANG" ]]; then
+			ARCH_KBUILD_CFLAGS_KERNEL="-fno-direct-access-external-data"
+		else
+			ARCH_KBUILD_CFLAGS_KERNEL="-mno-direct-extern-access"
+		fi
+
+		status "LoongArch detected: adding $ARCH_KBUILD_CFLAGS_KERNEL to KBUILD_CFLAGS_KERNEL"
+	fi
 
 	cmd=("make")
 	cmd+=("--silent")
@@ -582,6 +593,7 @@ build_kernel() {
 	fi
 	cmd+=("-j$JOBS")
 	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections")
+	cmd+=("KBUILD_CFLAGS_KERNEL=$ARCH_KBUILD_CFLAGS_KERNEL")
 	cmd+=("vmlinux")
 	cmd+=("modules")
 
-- 
2.25.1

