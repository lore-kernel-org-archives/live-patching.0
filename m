Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3754418EC;
	Wed, 12 Aug 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540409; cv=none; b=Y/Ccqq5EC5i6ZKJcclaq0SfroMJeKBfhPdUE/JNvk52q6iqBwzKc5uGPejABoTbHFdQrXH81Y83ZvXNKEfJvQtL/qV953UnRh6vkw+wOwFUy/20WFB1xiBoAQFgFR3mGr18IIDyJdQ0Fqi6mwmC40CMwaT8jQfZJBsgS4ywCsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540409; c=relaxed/simple;
	bh=upk04SS1B2C7wI0ygiTWmeF1qo2uxOPjsP724LcPCdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B0im9yLcc/awhTnJQGcHqT3OiTGsgkr3YVfBf5kbeBQWF3Vbg+p8cb3QcydmpXu93f/0Mp4NMrcoZHnFiEJfXhhuk+yMlwThfRClSuB0sh+CCis3zzZdUG8Y1ysQDt0mycI1wMFG9AXrp31CadYcY/FWGuqIvENB7MXEzLI3tQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfm5uW3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfm5uW3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89A71F000E9;
	Wed, 12 Aug 2026 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786540408;
	bh=dg/xtKmMQjuPSVG7VmefBJb0/up7zKFnMw/Lbz3H4+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Gfm5uW3uxqCqXBc6hG4X2D4npsYqTKbLMIxYZoxn09T0uMEds2+nTPRHFyroNk/w2
	 AeUegSzbbuzMR4aadIbD4OGOA4JuaJU7CzRIrYle5ja7V4gMCHD/vuIs0xXDALPFZp
	 pFsEyyp0fApGjRUuiPogHPwFogMVkbpdTioJ33AG2U/rdjTsEipLczC6Xmu8GSAjLM
	 RcHttkW1Xfo1bEZ6qoG+nVr/+hJQXZMIRjqxgG1p4vJTbUzTUhUUEqlWW3C+7m0CXQ
	 hxu4vBwe8zRLXg1Ulf+foCIXdMhX9UonAF/yyCQImh/up57Vil7sV/dmbe8zjcHNDd
	 Lt8s9EHw+1miQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>, sashiko-bot@kernel.org
Cc: linux-modules@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
 live-patching@vger.kernel.org
Subject: Re: [PATCH 05/14] objtool/klp: Add .klp.symid for sympos
 disambiguation
In-Reply-To: <7avwg6oos7kjtotwlpcxhy5qiviu5gzhwew2ibjcfccu4vbonu@25ayhrgt7b33>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
 <20260803034116.43C111F000E9@smtp.kernel.org>
 <7avwg6oos7kjtotwlpcxhy5qiviu5gzhwew2ibjcfccu4vbonu@25ayhrgt7b33>
Date: Wed, 12 Aug 2026 14:13:00 +0100
Message-ID: <m24igzlbxf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Poimboeuf <jpoimboe@kernel.org> writes:

> On Mon, Aug 03, 2026 at 03:41:15AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] Relocations in .klp.symid pointing to discarded sections (.exitcall.exit, .exit.text, etc.) will cause a link-time error when building vmlinux.
>> --
>> 
>> --- Patch [5]: [PATCH 05/14] objtool/klp: Add .klp.symid for sympos disambiguation ---
>> commit 09454266fcd41f3c022cac215ab86d1269c37d52
>> Author: Josh Poimboeuf <jpoimboe@kernel.org>
>> 
>> objtool/klp: Add .klp.symid for sympos disambiguation
>> 
>> This commit introduces a new .klp.symid section to vmlinux.o to help
>> livepatch reliably determine the sympos of duplicate-named symbols. It
>> emits an array of identifiers and relocations that survives the final link,
>> allowing klp-diff to correlate symbols between vmlinux.o and vmlinux.
>> 
>> > diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
>> > new file mode 100644
>> > index 0000000000000..cf188cdfa6079
>> > --- /dev/null
>> > +++ b/tools/objtool/klp-symid.c
>> [ ... ]
>> > +static const char * const discarded_secs[] = {
>> > +	".discard",
>> > +	".modinfo",
>> > +	"__tracepoint_check",
>> > +};
>> > +
>> > +static bool discarded_sec(struct section *sec)
>> > +{
>> > +	if (!(sec->sh.sh_flags & SHF_ALLOC))
>> > +		return true;
>> > +
>> > +	for (int i = 0; i < ARRAY_SIZE(discarded_secs); i++)
>> > +		if (strstarts(sec->name, discarded_secs[i]))
>> > +			return true;
>> > +
>> > +	return false;
>> > +}
>> 
>> [Severity: Low]
>> Should the discarded_secs array also include .exitcall.exit and .exit.
>> sections?
>> 
>> Because these exit sections have the SHF_ALLOC flag set, the first check in
>> discarded_sec() will not catch them. If they are also omitted from the
>> discarded_secs array, klp_create_symid_sections() will mistakenly generate
>> relocations pointing to them.
>> 
>> Since the linker script unconditionally discards .exitcall.exit via the
>> DISCARDS macro, generating relocations against it causes a deterministic
>> link-time error ("relocation refers to a discarded section") when building
>> vmlinux.
>> 
>> Could this happen in practice? Common driver exit handlers (e.g.,
>> module_cleanup used by drivers like cx18 and ivtv) often result in
>> duplicate static symbols like __exitcall_module_cleanup in the
>> .exitcall.exit section when the modules are built-in.
>
> I'm not convinced this can happen in practice.  Why would somebody be
> trying to patch or reference a module exit symbol anyway?


I see this on my arm64 host with your arm64 support patches applied:

make KLP_SYMIDS=1 -j$(nproc) vmlinux
  DESCEND objtool
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
`__exitcall_aes_mod_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
`__exitcall_aes_mod_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
`__exitcall_dax_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
`__exitcall_dax_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
`__exitcall_usb_serial_module_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
`__exitcall_usb_serial_module_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
`__exitcall_hid_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
`__exitcall_hid_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[1]: *** [/data/users/pjy/linux_worktrees/meta_klp_build/Makefile:1341: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Applying the patch below fixes it:

-- >8 --

From 93c99313870d7375ab07e494c2d0d971758578eb Mon Sep 17 00:00:00 2001
From: Puranjay Mohan <puranjay@kernel.org>
Date: Fri, 7 Aug 2026 11:16:29 -0700
Subject: [PATCH] objtool/klp: Fix vmlinux .klp.symid link error for
 .exitcall.exit symbols

Building a kernel via klp-build fails to link:

  `__exitcall_aes_mod_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
  `__exitcall_dax_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
  `__exitcall_hid_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
  `__exitcall_usb_serial_module_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o

module_exit() on a built-in emits a static __exitcall_$fn pointer into
.exitcall.exit, which vmlinux.lds.h discards unconditionally via
EXIT_CALL.  When two built-in translation units define a module_exit()
function of the same name, the resulting local symbols collide,
symid_needed() sees a duplicate and emits a .klp.symid entry for each,
referencing symbols the linker then throws away.

Same-named module_exit() functions are not rare:

  dax_exit                drivers/dax/device.c, drivers/dax/fsdev.c
  hid_exit                drivers/hid/hid-core.c, drivers/hid/usbhid/hid-core.c
  aes_mod_exit            arch/arm64/crypto/aes-ce-ccm-glue.c, lib/crypto/aes.c
  usb_serial_module_exit  module_usb_serial_driver() expands to this fixed
                          name in each of its ~49 users

The last one makes the collision structural rather than accidental: any
kernel with two built-in USB serial drivers has it.  This is not arch
specific either; it only requires the objects to be built in rather than
modular, which is why a monolithic config trips it while a typical
distro config does not.

Add .exitcall.exit to the discarded section list so its symbols don't get
symids.

This is the same failure mode as "objtool/klp: Fix vmlinux .klp.symid
link error for .no_trim_symbol symbols", for another unconditionally
discarded allocated section.

Fixes: 029223d30162 ("objtool/klp: Add .klp.symid for sympos disambiguation")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/objtool/klp-symid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
index 1934c2a1afc4d..1bdb8e4516e8f 100644
--- a/tools/objtool/klp-symid.c
+++ b/tools/objtool/klp-symid.c
@@ -30,6 +30,7 @@

 static const char * const discarded_secs[] = {
        ".discard",
+       ".exitcall.exit",
        ".modinfo",
        ".no_trim_symbol",
        "__tracepoint_check",
--
2.53.0-Meta

-- 8< -- 

Thanks,
Puranjay
