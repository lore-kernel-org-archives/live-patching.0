Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB24437466
	for <live-patching@vger.kernel.org>; Mon, 17 Aug 2026 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983709; cv=pass; b=mYe5JiLI4Sv7ev6irJ95cF90Un5MC20sTSJNQo41PVVebXdx9/KraHZSC+u2gVtZYy9i+Ffg/MR233owaOD81Hr00j8VHdQXo0nRih56k9b/37wvB59NNZc6TUXg/fvHO8EW2rTuawe8NPJrruGKJIkMHxomtafL+Y4csxS2gPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983709; c=relaxed/simple;
	bh=WO5RLhNy6wgk2VO9vtq4cDOPINlb1Zz0AE8zVdsxeSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc9sSdbIbz8Xn4VzQo79vSE/TG++otEDepO0Vb4v+VizA68aIgRMwSuuIdda/oqnusLakNKEDO5rwoIq9PvX9jK9RSFHrHz0NsYJi8Qd0Kwua0C6iSw/K1XZN+bmsRXAsiPwQ0vlQTkoS7T8KqOeEO1+uJ0YEtkPkZDgv1TmaIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emGQIK4n; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emGQIK4n"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-973b676e5f5so2241904241.1
        for <live-patching@vger.kernel.org>; Mon, 17 Aug 2026 09:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786983707; cv=none;
        d=google.com; s=arc-20260327;
        b=NQ4D1HdpDaffJdeVQew3SFK9WszRHFI3GIhpU93ZyBtKcjbL+SX6b0319oN3akEVVB
         j7sQYdyGgRz4lcOdVa8LfBJ8EPOScquU9H/kXYnNzadQ5N9pKPXWn3Qus1fBwBDSc+Sz
         V+0FG55m5Syt670ZVRjgZTSDdgzVLqCt2oIXMabbVZwPYkFoMRSsNMwv6ovMDRw3p0YV
         5HIAhjoARN41vK1LqgBZSmkcXoWsu2X7aB8KDlk+L5oJTEd4eid6dl1HgHgl2vf1WUdU
         EUrkveeexCMNNZ91hgJveCsVLd3VkBhFJN2i8zue0x0DuRQitoSNx4vjJRaf2E0uf9sh
         iBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FZyrt6IjYQSavG1nrP4yJOtRcXdQLCpSrREUXwAdIwM=;
        fh=7gPZUAfDzpdvhUzCAKxpN+qO6NPtvTPTWXvpYjvesu0=;
        b=ZZFTweSiTqdPj9a+KQZSxFqEFGMghJ+ljzH6k1e4411Rli5dAdy0dsover/5y9IaXp
         VwNV6ruZ9gWibDNP2SUVvUKBoDNAMAOkYhuHytJOXqnMwIytPMhWHpn0/l5jf1IaFS7I
         YVGn8HliyDJZ365RpKQlOu2JP63PKLxNKyp+3KEtiLsPOaBuEpxVHwAau2pM3YTL12Qn
         XvLYfeY8GgZbnyN5/SXtlXZ9t3Fu9yfH0uj1bnga5dGRdgnXOB5aW5UboxQ2ZpdpwQR1
         Rt+t3zGH6buOfutoMqpDfp/7mASLOc5MZr3GeJSe812wJJaTFukFn9jFMimHsunbYho9
         0viA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786983707; x=1787588507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FZyrt6IjYQSavG1nrP4yJOtRcXdQLCpSrREUXwAdIwM=;
        b=emGQIK4nbrh5jMYsisukD2Y6kQ45Wvrh2RWSx4ixjfEs6RjGISPmKacuU0W4XRpZXz
         14gadFTcR1ke14no4ZPh/gkBcx5V6B8pjquoswjX2f7H90Upuae3aGV9B5i393pWGiAb
         +xKKkezOaNEOwZKauKcZ/J+Bn4q52n/kpAzWGdhYbSTA3sCUJ/jNU1c25AuD09FMia3/
         GW4nZA6odN2z//dbRs4VwK7nu+Cs8V7hU4TAnVQW6VmmUULf+fByy/u+PEQHdJI0XRQM
         qZvmY6LZRW+UHiSlEzTtLWkjMZm39PrQ284KFEBUvM5AhyFvjCVKLTPRSZVwBzsMF8f/
         EPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983707; x=1787588507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZyrt6IjYQSavG1nrP4yJOtRcXdQLCpSrREUXwAdIwM=;
        b=lXJVDZBBtJlghSWnw+UG+iZRSNfncKm4FtzHoFBcxS9xefN1NTXwq3Cfl7szwoqQ8o
         8csyeT2bYKyzxDpZWK84ZZW9r/CunzZ2v9dtksfnRep+7GD2oyn8yUagi6nDRp3sIH9e
         hoMJnhmwCZ5TcpVyxkYKMZzwjkwBTyNE5Ov+OFG5N/3cVb/cceh3JDn2lI7ZY5y+ra4U
         lYKmkjImgNJkrKl7LbbMu6WxKcC0LrpI3gGqLEeTGjUryCFMxmkCMxtSURE4IB7GR4UF
         +DtvovfSeUV2bvY6etvwMrX0hKGUEW297GW3CtbsKg5UE3sWj0w8Mh1ACApr6Yjtm3+A
         VDww==
X-Forwarded-Encrypted: i=1; AHgh+RoMfnHtrGCyH9TXXmi8pjMeW2YtHsAjuLGkMWhFkUurVmB5G8XufF2ugCPS9VursLD6Lq95hQFHFH/RIMqx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46xc/YLuT0bv7YziBcIry7C5Jg7/uyl5PxxzHW5rGnoIFqUDU
	8k+55wIvtIJLfOFVrZ3HxXjdDNA7BFieb6tIw8EzX7wIyjZ5kY/f6Dtmb2AfVZe4EcDnV/Jj3Ow
	BExv6A9ICglSLb5bRbI+2X/7X8YPG63Rc7sVf3Xmv
X-Gm-Gg: AR+sD12HyC7CjvdhoIfLxc0huW9B9E3vQm3bgyUxhEJ45j6iOvl9jlNCCzYZaWS/US/
	P4mZ6Kma1aWCpLTN7t0KB4Xt7scz/G0Tk4XWbOWAGWzichRowQFwV2Wf70FK9kNBvy3NDDQwvlf
	/OZQwbJ8vHyc0He511eONv1lWT8xhg5aEvMzMJ48a/08DY+aS2MNmyWHVtLe9t6/zYAE1+W3s9X
	9VbzC/mnFhVyg1nWXEQt+V6puQ23iZIna1TrJf22jOh5pas7zTpElA+B1EIgBYnrvHH3Nl6UNUM
	jylK4TMtwI/0w8Ch1A2c4lMmQvIV0XTZwU8ORQiBZv1QFcgmk/nMD2D1
X-Received: by 2002:a05:6122:f89:b0:5bf:9bfa:53a0 with SMTP id
 71dfb90a1353d-5c591c69d80mr6542068e0c.1.1786983706099; Mon, 17 Aug 2026
 09:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8e3b9fae109903a6aafb2a33310e4afdcebf58e.1786761327.git.jpoimboe@kernel.org>
In-Reply-To: <f8e3b9fae109903a6aafb2a33310e4afdcebf58e.1786761327.git.jpoimboe@kernel.org>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Mon, 17 Aug 2026 09:21:34 -0700
X-Gm-Features: AcwNN1UhpU0WEI36f1ADUKugN_WFzoyJEEKwwGCy5zSbfxnDW7V4P6HGPoHXDgU
Message-ID: <CADBMgpxZYtSGi=SPRCJ_zOG10arL3uax+fyouctxi5tLLWPE+Q@mail.gmail.com>
Subject: Re: [PATCH] objtool/klp: Fix vmlinux klp relocations for EXPORT_SYMBOL_FOR_MODULES()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 7:36=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> When a module function references a vmlinux symbol which is exported
> with EXPORT_SYMBOL_FOR_MODULES(), a patch to that function needs to use
> a klp reloc.
>
> Currently, livepatch fails to load such a module:
>
>   livepatch: invalid access to vmlinux symbol 'get_task_policy' from modu=
le-specific livepatch relocation section
>   livepatch: failed to initialize patch 'livepatch_test' for module 'test=
mod' (-22)
>   livepatch: patch 'livepatch_test' failed for module 'testmod', refusing=
 to load module 'testmod'
>
> klp diff puts all klp relocs in __klp_relocs.<patched object>, so
> post-link names the section .klp.rela.<patched object>.<secname>, which t=
he
> kernel rejects for vmlinux symbols.
>
> Commit 07f14d6af9d77 ("objtool/klp: Fix cross-module klp relocation
> section naming") changed the meaning of objname in the klp rela section
> name to be where the referenced symbol is referenced rather than where
> it lives.  That premise only holds for symbols in a module: the relocs
> get applied when the patched module gets patched, and the module
> dependency guarantees the referenced module is loaded by then.
>
> A vmlinux symbol needs the opposite.  It's always resolvable, and it has
> to be applied when the patch module loads, before the module loader
> initializes the patch module's special sections, which may reference it.
> That's why livepatch rejects vmlinux symbols in module-specific
> sections.
>
> Use "vmlinux" as the section objname when the referenced symbol lives in
> vmlinux.  This moves such klp relocs from .klp.rela.kvm..text to
> .klp.rela.vmlinux..text.
>
> Fixes: 07f14d6af9d77 ("objtool/klp: Fix cross-module klp relocation secti=
on naming")
> Reported-by: Dylan Hatch <dylanbhatch@google.com>
> Closes: https://lore.kernel.org/CADBMgpz7iWC0=3Dt=3D_gE-tfvv0mTPq4kg0qQ2z=
gPH8DVPE6eQ9Kw@mail.gmail.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/include/objtool/klp.h |  5 +++--
>  tools/objtool/klp-diff.c            | 35 ++++++++++++++++++-----------
>  2 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/=
objtool/klp.h
> index 646d8e1f12eff..c57775d78c71e 100644
> --- a/tools/objtool/include/objtool/klp.h
> +++ b/tools/objtool/include/objtool/klp.h
> @@ -20,8 +20,9 @@
>   * SHF_RELA_LIVEPATCH, nor does it support having two RELA sections for =
a
>   * single PROGBITS section.
>   *
> - * "objname" is the name of the object being patched ("vmlinux" or a mod=
ule
> - * name).  post-link uses it to name the resulting
> + * "objname" is the object whose loading gates the relocation: "vmlinux"=
 for
> + * references to vmlinux symbols, otherwise the name of the module being
> + * patched.  post-link uses it to name the resulting
>   * .klp.rela.objname.section_name sections.
>   */
>  #define KLP_RELOCS_SEC "__klp_relocs"
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index a66049e0726a6..16681a76f13d0 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1344,13 +1344,14 @@ static int clone_reloc_klp(struct elfs *e, struct=
 reloc *patched_reloc,
>                            struct section *sec, unsigned long offset,
>                            struct export *export)
>  {
> +       const char *sym_modname, *sym_orig_name, *sec_objname;
>         struct symbol *patched_sym =3D patched_reloc->sym;
>         s64 addend =3D reloc_addend(patched_reloc);
> -       const char *sym_modname, *sym_orig_name;
> -       static struct section *klp_relocs;
>         char tombstone_name[SYM_NAME_LEN];
>         struct symbol *sym, *klp_sym;
>         unsigned long klp_reloc_off;
> +       struct section *klp_relocs;
> +       char sec_name[SEC_NAME_LEN];
>         char sym_name[SYM_NAME_LEN];
>         struct klp_reloc klp_reloc;
>         unsigned long sympos;
> @@ -1441,20 +1442,28 @@ static int clone_reloc_klp(struct elfs *e, struct=
 reloc *patched_reloc,
>          * This intermediate step is necessary to prevent corruption by t=
he
>          * linker, which doesn't know how to properly handle two rela sec=
tions
>          * applying to the same base section.
> +        *
> +        * The objname decides when the reloc gets applied.  A reference =
to a
> +        * vmlinux symbol goes in the vmlinux section so it gets applied =
when
> +        * the patch module loads.  Everything else goes in the patched
> +        * object's section, applied when the patched module is loaded.
>          */
>
> +       if (!strcmp(sym_modname, "vmlinux")) {
> +               sec_objname =3D "vmlinux";
> +       } else {
> +               sec_objname =3D find_modname(e);
> +               if (!sec_objname)
> +                       return -1;
> +       }
> +
> +       /* section format: __klp_relocs.objname */
> +       if (snprintf_check(sec_name, SEC_NAME_LEN,
> +                          KLP_RELOCS_SEC ".%s", sec_objname))
> +               return -1;
> +
> +       klp_relocs =3D find_section_by_name(e->out, sec_name);
>         if (!klp_relocs) {
> -               const char *objname =3D find_modname(e);
> -               char sec_name[SEC_NAME_LEN];
> -
> -               if (!objname)
> -                       return -1;
> -
> -               /* section format: __klp_relocs.objname */
> -               if (snprintf_check(sec_name, SEC_NAME_LEN,
> -                                  KLP_RELOCS_SEC ".%s", objname))
> -                       return -1;
> -
>                 klp_relocs =3D elf_create_section(e->out, sec_name, 0,
>                                                 0, SHT_PROGBITS, 8, SHF_A=
LLOC);
>                 if (!klp_relocs)
> --
> 2.55.0
>
Tested-by: Dylan Hatch <dylanbhatch@google.com>

Tested with the reproducer patch I mentioned earlier:

https://github.com/dylanbhatch/linux/tree/mod-ns-lp

Also, are there integration test cases kept anywhere for klp-build?
And would this reproducer be helpful as a test case?

Thanks,
Dylan
