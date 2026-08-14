Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2633B6F9
	for <live-patching@vger.kernel.org>; Fri, 14 Aug 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786741563; cv=pass; b=m19p8QX3/Vf64+DxfSh31HpMkW4FpdgAPrwX1nmY0K+PvyoIdYBJaC17S9nqgg5y20OYa+jzV7bjNGHtoVI0mUhFfiSYDm9KWtAsArWMUedZmBOFEGvl3++pu/QMBWerA21ZXL2MuU9aChtqMuEO7iDACuagZ2fq7aeXXoOqMVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786741563; c=relaxed/simple;
	bh=cXWcSbcGS7ZGC53RHukif6q6gpX+SVWX+TIErG28eCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u84DbknRU5UMsRr1wdkgJy+OhzBYU/IlizQfbNqzQ8QBfHy5QLZ40Y9NL6wKQrBny0X94l42aJvzcwHcpGhOdlqB0a6NFl43kwucnhWQkKkYFvYGXcgsu2lX4WS9dbkzqYb99pwJp5gY1DFhKZEivY54a4XF2MbLJYGFgeC2j78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnOYuoyD; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnOYuoyD"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7466771f1caso443282137.0
        for <live-patching@vger.kernel.org>; Fri, 14 Aug 2026 14:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786741561; cv=none;
        d=google.com; s=arc-20260327;
        b=CclEMXaaJL44ZFDGF/PoHcaO3Ue07Qx19vBEex0P/SaFLD4GCWRWA1Kg/RlnugJvp6
         IGP3fu12k7qT5TEB4kPDB1+egeV+51ZuwkJxPHEEg9DwNSJskGO8gWEfXxf6sH4q7aYi
         XFs6WKmq7Yv9PwAiv6j9CfZH4AOb5CJvCx48eSVVFft5Ll6jSH14P7O5/ZP0x5opaDQG
         y8ufvOq1EvZCOnQWbzhCA9NfQRQCixTHu/OJ+foNrlbCCjFkG/FhzUhLV+CZ8+qaNyeF
         wFzlgy0/15OvhnsQmI9xzH6JMkFCDbp1qVeUifiue4fa6sarILIvtn7+DYBoC3H5wOf1
         7/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yNaXu5zAPx3AyG36ZbBZSTEPSv7O98uldT4eGNgw44=;
        fh=ZpVsFyvL8tcGcfHWiv+m26VeEl9IXxGAwg4Q3kwp3dU=;
        b=hB5fchEjs19FLAVMYcsbDZ2mDdV2d8ux4vYL01f+uGNy34qzXfgS2Ct4OMzljJoy/u
         ecjSTJ+SMlygtFsHkIMojRGV+hnj+TXOPpDWIpzeANf38VoNkAjtcHeLkS7A0vrfI4ju
         M2EIAxptqEYWlGLOq3+jntPEzCLZFTf9Sz4QA4Jyd3obSGJ0Zabiwn7oM42wHcOxKLxU
         T2KnsRmjGuhIyWfPrjNrVEVDZByPVk1eowfs4zkNles3CRyA/aAVt7FlIWkOPXBbzYZP
         JgIvso7Zb0TyNiu34pd/4Lx8oyGEChw59c6KHEzvkbUdPWN9Y2wvxscrAtF0LS1K8LxL
         WPng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786741561; x=1787346361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3yNaXu5zAPx3AyG36ZbBZSTEPSv7O98uldT4eGNgw44=;
        b=RnOYuoyDDmicQY5sR+tUEYy9ovnUbo1yZO4FE1jt5NBe8OTa2nxA+Dck4YlLXAK0sR
         AkELBhw3GyxQSnfzGqTpBIa0bmkXjNr40fWfqd2Rgocu35hDHupIib+puMjhToU9Kv+W
         ZYXtqjd+rsnAEwYpJqNjBn8fPPb3cmVkVWcWQ2WKySaxJZy8uPwo+GCH/efH/fMVHgir
         VICQVzUB9lCYd20kRkL/g9nunRIwiCiPudUz6FC1sSqEqvfjhGHOXLvRv1V/G0Ecu6DH
         eU1BpA1PQfeFwE6S6y5g1d9FUUaEuFXWRrtEJ5v9ckpaiOym1zyZ2AnFaN8yEZ9/uTWw
         gO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786741561; x=1787346361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yNaXu5zAPx3AyG36ZbBZSTEPSv7O98uldT4eGNgw44=;
        b=Hb8Kbynmr0VPaz94SgHbVTBUi+yNdScoPOuUCCi19kuHEk1vZi4zEG1k0TD26UULmM
         unC/LU14NaIcxzHtSFRRWVyLKVeKLVZYOpOx+DgJ8zpAFEm8R/9mPo7woG4dk0AmCH1F
         6Eb1yPjWkyjEKu23ofccqE7+2FVAfD7znXe65mrcYlUTkdsMTUj14xZBdUTOsZhODMJV
         tS1acHGWKasiwaFHsVwtnt4HHSZiy+yWS1cnler5LGID8sYp4YlI5Fw1quoo+ZZIfLBV
         bghFPB2s23LtBmh5VUkPh3vwkVe8AbeOvJ6ktFW7seJq6sdTN/CV1s26rycoM2sc+yTF
         djfA==
X-Forwarded-Encrypted: i=1; AHgh+RqdbLJPlsEKsD1hWKJFi4xrChTzgD58tDt0ozR6+pyogH9gsyudcqysjURzu1Vx0wkH3bYDUvIKMMOFANeA@vger.kernel.org
X-Gm-Message-State: AOJu0YwYfmBhi9/y+6p8a8is4KKezxMXRRPyGlF0hrYrBwXEvFWnsoCM
	6cF2n+WNsK8ZZJQryBTsrBO25sPY57xTk9/D/mGNDAxHsZCPsAElkSrfhMt1JQhqQFjg2fa0OL1
	86I2Tcaahq79EBTnx+BBlwhTBUFxX4ytln0ABgon3
X-Gm-Gg: AR+sD12ba0onq3/0T+Y6okQzOMk2+1VD6E0FBvLewfJK6Q6LGVbzDgNmMEGFWk2z4Ys
	Qlw7IicDaEcPqF+QA8V6aRirLhig3wIoMH648P5vk+hTzasClmvkUzYihNX4RsgR/RqUSNfs7g4
	zSAhW/+E0xryPEDrIZ78gtfbzSB2gM0Kj1r+UNPNuVWw5FeX3IT19wJn26AAIbn0/8CIpQv6And
	khHhulHmwB3/EO4Il6ZqMFxg7EBol+FygSXFnKPqUQCLbLReqkFhLxUHSoIQQrAbCcIpzZRBaBF
	cVNgx72lT25OyN9SzzEfkqhAmmf96RFk+mP+/+VsLIUM
X-Received: by 2002:a05:6102:5108:b0:738:9c30:2baf with SMTP id
 ada2fe7eead31-76f2a8e7b15mr1276145137.2.1786741560059; Fri, 14 Aug 2026
 14:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786138493.git.jpoimboe@kernel.org> <fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org>
In-Reply-To: <fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 14 Aug 2026 14:05:48 -0700
X-Gm-Features: AcwNN1VHAH_L3oPQ_CpDsmzr6zfDuTDLCW6sUb_xcFbxQRr9JVfbc2LBNqgye9g
Message-ID: <CADBMgpz7iWC0=t=_gE-tfvv0mTPq4kg0qQ2zgPH8DVPE6eQ9Kw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] objtool/klp: Fix relocations for
 EXPORT_SYMBOL_FOR_MODULES() symbols
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Fri, Aug 7, 2026 at 2:42=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> EXPORT_SYMBOL_FOR_MODULES() puts a symbol in a "module:<names>"
> namespace, which the module loader grants access to by matching the
> importing module's name against that list.
>
> klp_reloc_needed() only creates a klp reloc for module-owned exports; a
> vmlinux export gets a normal reloc.  For a vmlinux symbol exported with
> EXPORT_SYMBOL_FOR_MODULES(), using a normal reloc results in a modpost
> failure in klp-build:
>
>   ERROR: modpost: module livepatch-foo uses symbol mpol_shared_policy_loo=
kup from namespace module:kvm, but does not import it.
>
> And the modpost error is correct: even with that error removed, the
> patch module would fail to load:
>
>   livepatch_foo: module uses symbol (mpol_shared_policy_lookup) from name=
space module:kvm, but does not import it.
>   livepatch_foo: Unknown symbol mpol_shared_policy_lookup (err -22)
>
> Treat it like an unexported symbol by using a klp reloc.
>
> Note this only affects "module:" namespaces.  Ordinary namespaced
> exports continue to work with normal relocs thanks to copy_import_ns(),
> which propagates the patched object's import_ns tags to the patch
> module.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Link: https://lore.kernel.org/6a6608f4-0a05-4d75-8b7f-edddfac9c5d4@redhat=
.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/klp-diff.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 6d34186d8b24c..0f135b74a5b0c 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -30,7 +30,9 @@ struct elfs {
>
>  struct export {
>         struct hlist_node hash;
> -       char *mod, *sym;
> +       char *mod;
> +       char *sym;
> +       bool mod_ns;
>  };
>
>  bool debug, debug_correlate, debug_clone;
> @@ -135,7 +137,7 @@ static int read_exports(void)
>         }
>
>         while (fgets(line, 1024, file)) {
> -               char *sym, *mod, *type;
> +               char *sym, *mod, *type, *namespace;
>                 struct export *export;
>
>                 sym =3D strchr(line, '\t');
> @@ -162,6 +164,14 @@ static int read_exports(void)
>
>                 *type++ =3D '\0';
>
> +               namespace =3D strchr(type, '\t');
> +               if (!namespace) {
> +                       ERROR("malformed Module.symvers (namespace) at li=
ne %d", line_num);
> +                       return -1;
> +               }
> +
> +               *namespace++ =3D '\0';
> +
>                 if (*sym =3D=3D '\0' || *mod =3D=3D '\0') {
>                         ERROR("malformed Module.symvers at line %d", line=
_num);
>                         return -1;
> @@ -188,6 +198,9 @@ static int read_exports(void)
>                         return -1;
>                 }
>
> +               /* EXPORT_SYMBOL_FOR_MODULES() */
> +               export->mod_ns =3D strstarts(namespace, "module:");
> +
>                 hash_add(exports, &export->hash, str_hash(sym));
>         }
>
> @@ -1174,11 +1187,16 @@ static bool klp_reloc_needed(struct reloc *patche=
d_reloc)
>          * clusterfunk that is late module patching, the patch module is
>          * allowed to be loaded before any modules it depends on.
>          *
> -        * If exported by vmlinux, a normal reloc will do.
> +        * If exported by vmlinux to all modules, a normal reloc will do.
>          */
>         export =3D find_export(patched_sym);
> -       if (export)
> -               return strcmp(export->mod, "vmlinux");
> +       if (export) {
> +               if (strcmp(export->mod, "vmlinux"))
> +                       return true;
> +
> +               /* EXPORT_SYMBOL_FOR_MODULES() gets a klp reloc */
> +               return export->mod_ns;
> +       }
>
>         if (!patched_sym->twin) {
>                 /*
> --
> 2.54.0
>
>

Following up on the other thread [1], I noticed that when a patch is
touching a module function with a reference to one of these
module-exported symbols, the patch/module is rejected because KLP
relocs referencing vmlinux symbols are not allowed from
module-specific livepatch relocation sections. I was able to reproduce
this with a simple module/livepatch combo that depends on one of these
symbols [2] (see samples/livepatch/testmod.c and test.patch):

root@debian-vm:~$ insmod livepatch-test.ko
root@debian-vm:~$ insmod testmod.ko
insmod: ERROR: could not insert module testmod.ko: Invalid parameters

With dmesg:
[  655.596876] livepatch_test: loading out-of-tree module taints kernel.
[  655.600961] livepatch_test: tainting kernel with TAINT_LIVEPATCH
[  655.605436] livepatch: enabling patch 'livepatch_test'
[  655.609119] livepatch: 'livepatch_test': starting patching transition
[  656.653454] livepatch: 'livepatch_test': patching complete
[  738.777872] livepatch: invalid access to vmlinux symbol
'get_task_policy' from module-specific livepatch relocation section
[  738.784899] livepatch: failed to initialize patch 'livepatch_test'
for module 'testmod' (-22)
[  738.790371] livepatch: patch 'livepatch_test' failed for module
'testmod', refusing to load module 'testmod'

Do you recommend a strategy for working around this, or is this
something that would have to be fixed in the kernel?

Refs:

[1]: https://lore.kernel.org/all/CADBMgpyY6R_YmEqhZSw=3D88-Bfkv9=3Ds-N-x1si=
E1uPAgH_fTURw@mail.gmail.com/
[2]: https://github.com/dylanbhatch/linux/tree/mod-ns-lp

Thanks,
Dylan
