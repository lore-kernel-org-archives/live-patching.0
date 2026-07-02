Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0087478
	for <live-patching@vger.kernel.org>; Thu,  2 Jul 2026 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022428; cv=none; b=LRdZHM7nmHqloBUF7Re63ddUMVAW0H3XG05S4xoIf25jRUtZ0FhjPqHaxKoGq9KUo7yZdiLeXISQsQKdjHFdIB/gpvVc1R6kdzDl/OHBCd2eGH+LAcRw1vlmLFbsaeZowOZdqFn2nlrWFzFMkKDM5f498q/f2mhokcdPNsiFHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022428; c=relaxed/simple;
	bh=rACSdKpoLnV/hBjV8rM9vAK5K4UQ0NdFBrLa4EE/F8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRSP3VfRpCSFxSOiNu2WUYr6cQCWoObb4+EZrG0BLJZjF/p7qPcbewPIgEU9zQcyYD2ok2ou65juL8miYQvqlmY/D/C8AYUCCQcIkYbNze2GBLGOiU5PA7HfwAO02bUG0cieCQQ3fneRSwfQYVWodMlNkwVfMVMNXHDfmVyyvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODKVAGY3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODKVAGY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783022424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/lB8bTJ0EyNsIX6BYhLdG+YbNBS2otPFvnCug1uqq4=;
	b=ODKVAGY3hWW673GeLdk24xjAArlCNNKo4JELqLF9rxMWdvowkyQWRw0+KJpcnj0y42904g
	4tyt5ZpXhGfZWmgdDjoO5+5WKfol4GAUf2BkluLu81L9NnkczlwA8ThtRlFuAzEw4GcTC+
	UgMhu+Z3Mmdx+yKDLH/iRtrqMz8ByJY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-XxULGeL9MfegSBDwmfEAEw-1; Thu,
 02 Jul 2026 16:00:19 -0400
X-MC-Unique: XxULGeL9MfegSBDwmfEAEw-1
X-Mimecast-MFC-AGG-ID: XxULGeL9MfegSBDwmfEAEw_1783022416
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D1ED195419B;
	Thu,  2 Jul 2026 20:00:14 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B0153002D2F;
	Thu,  2 Jul 2026 20:00:07 +0000 (UTC)
Date: Thu, 2 Jul 2026 16:00:04 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
	kernel@xen0n.name, rostedt@goodmis.org, ardb@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn, jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn, guodongtai@kylinos.cn, xry111@xry111.site,
	wangyuli@aosc.io, loongarch@lists.linux.dev,
	live-patching@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] LoongArch: Add livepatch build (KLP) support
Message-ID: <akbDROiVKjbkqMZL@redhat.com>
References: <20260608100852.325413-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608100852.325413-1-dongtai.guo@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jun 08, 2026 at 06:08:44PM +0800, George Guo wrote:
> This series adds LoongArch support for the klp-build livepatch tooling,
> enabling automated livepatch module generation using objtool on
> LoongArch.
>
> It is based on Josh Poimboeuf's klp-build series [1] (see base-commit
> below) and extends it with the LoongArch-specific objtool and build
> pieces, plus a few LoongArch toolchain/relocation fixes required to make
> livepatch modules load and run correctly.
>

Ok, what am I doing wrong here:

- Git tree is jpoimboe/klp-build-arm64 + this patchset
- Using clang v21.1.8 and a defconfig + CONFIG_LIVEPATCH requirements
- A simple patch to net/core/dev.c :: netif_rx_internal()

$ clang --version
clang version 21.1.8 (Fedora 21.1.8-4.fc43)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg

Setup and build the reference kernel:

  $ ARCH=loongarch LLVM=1 make defconfig
  $ ./scripts/config --file .config \
           --set-val CONFIG_FTRACE y \
           --set-val CONFIG_KALLSYMS_ALL y \
           --set-val CONFIG_FUNCTION_TRACER y \
           --set-val CONFIG_DYNAMIC_FTRACE y \
           --set-val CONFIG_DYNAMIC_DEBUG y \
           --set-val CONFIG_LIVEPATCH y
  $ ARCH=loongarch LLVM=1 make olddefconfig
  $ grep LIVEPATCH .config
  CONFIG_HAVE_LIVEPATCH=y
  CONFIG_LIVEPATCH=y

  $ ARCH=loongarch LLVM=1 make -j$(nproc)
  ...

Then provide this small patch:

  $ cat test.patch
  diff --git a/net/core/dev.c b/net/core/dev.c
  index 06c195906231..14fd3d5f351a 100644
  --- a/net/core/dev.c
  +++ b/net/core/dev.c
  @@ -5717,6 +5717,7 @@ static int netif_rx_internal(struct sk_buff *skb)
                  unsigned int qtail;

                  ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);
  +               pr_info("test");
          }
          return ret;
   }

to klp-build:

  $ ARCH=loongarch LLVM=1 ./scripts/livepatch/klp-build -T test.patch
  Validating patch(es)
  Building original kernel
  LoongArch detected: adding -fno-direct-access-external-data to KBUILD_CFLAGS_KERNEL
  Cannot find symbol for section 5: .text.sched_clock.
  kernel/sched/build_utility.o: failed

The "Cannot find symbol for section" error message comes out of the
recordmcount script.

What's strange is that arch/loongarch/Makefile wants to use patchable
function entry:

  ifdef CONFIG_DYNAMIC_FTRACE
  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
  endif

but Kconfig doesn't set it up for LoongArch.  If I select when
DYNAMIC_FTRACE is turned on, like:

  diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
  index 1dbf51ba9d6a..6d9bc4a580d9 100644
  --- a/arch/loongarch/Kconfig
  +++ b/arch/loongarch/Kconfig
  @@ -139,6 +139,7 @@ config LOONGARCH
          select HAVE_DMA_CONTIGUOUS
          select HAVE_DYNAMIC_FTRACE
          select HAVE_DYNAMIC_FTRACE_WITH_ARGS
  +       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
          select HAVE_FTRACE_REGS_HAVING_PT_REGS
          select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
          select HAVE_DYNAMIC_FTRACE_WITH_REGS

then rebuild the kernel and retry klp-build, it at least completes the
original and patched kernel builds:

  $ ARCH=loongarch LLVM=1 ./scripts/livepatch/klp-build -T test.patch
  Validating patch(es)
  Building original kernel
  LoongArch detected: adding -fno-direct-access-external-data to KBUILD_CFLAGS_KERNEL
  vmlinux.o: warning: objtool: __efistub_efi_boot_kernel(): unexpected end of section .init.text.efi_boot_kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  LoongArch detected: adding -fno-direct-access-external-data to KBUILD_CFLAGS_KERNEL
  vmlinux.o: warning: objtool: __efistub_efi_boot_kernel(): unexpected end of section .init.text.efi_boot_kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  vmlinux.o: changed function: netif_rx_internal
  vmlinux.o: error: objtool: __jump_table_23683+0x8: duplicate reloc
  error: klp-build: objtool klp diff failed
  error: klp-build: line 829: '( cd "$ORIG_CSUM_DIR"; [[ -v VERBOSE ]] && echo "cd $ORIG_CSUM_DIR && ${cmd[*]}"; "${cmd[@]}" > >(tee -a "$log") 2> >(tee -a "$log" | "${filter[@]}" 1>&2) || die "objtool klp diff failed" )'

but ends with a new error on "duplicate reloc" out of klp-build.

What compiler / kernel config should I be trying with this patchset?

Thanks,

--
Joe

