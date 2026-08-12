Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394E470EAD
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556035; cv=none; b=PTNbJ5yFlKykhz0mpq4qZHM6wFu9FCaw78u+QFPfh2XOOnJeJmW9rZ/bjRCbbNHSH/4FKnKNbaSDN9fJEPs/bm5R62MILeaK8g+m+8o2CVe9Ik3KG0436qDIlURfBxXZycGMWmtjQVxZRlLl0ssRPR7QtTq2u3oxq1Nvl6lkD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556035; c=relaxed/simple;
	bh=/hnDmjwxmrJpbe9QYFrqG+D0DSrYDexbzx8XrdL1Utc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vAl2NkvTcn6hhMPYOy7H5pVi3jB6YmuL/Hru+cZ62P8Q9iT83uztPQCgXbh7iaTAOkthcSS+3Zup2T6w51WoBjDf0jJ+yOWzpWsZUGqLonTro1hsp57FJFZfh8kJ40/2+FxX+AwWNP09sXSIZyvrJrmNc70h9oMuYYv66YapXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cl2Z58J3; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cl2Z58J3"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc73f47bdcso15245745ad.3
        for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786556032; x=1787160832; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QI9k6LB5sz62CbOLY/wR28xgl05dZyGnVmDcR2qTGh8=;
        b=cl2Z58J3UfwPzNXKPzNTKvcnhS0dEYmwyhVHURD2mGCVu+vWHKkSbHDaggRIodxzYW
         +0BSBJQz/aq//VjTU2mVQGNw33TTft5uneVH2E+H86RgK8aqkGSUVUG+DVi+ajEPMLlx
         xd+KKxNgjYEOLqimeTHOyYM2Kancrc7arGtNJ00iJ31pDR//4lsG6zEPIZ3XZtNOvlP1
         GhsX/P71ZDbSmsdlqXzhwJZvtvpfIOo9FK+ip4oWzY1mbaNTpyy0FWeYWtHCDkuW2pAD
         86hyCPLsSQB9EGdoD4KaL+87X2tZZvZgVyNGALj56cDUjKM+j/2h7ZuOkfq0gKDefn3y
         j3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556032; x=1787160832;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QI9k6LB5sz62CbOLY/wR28xgl05dZyGnVmDcR2qTGh8=;
        b=A+chf9CJvKq0fM6ZDQfNjypdP4HegYpr/PIyM/Qp6nk6jqFVi//DSYnrOOFFmmPblR
         cN5FBAD/5ARibqcamhOrQyCo40/LsRPomnyBMov0OSwj9Ej8l57ahNuTLuJidMkprv8a
         oadZJ5/iZxpbJaSjC2E9C4A8AQX0DiXYSEqEg8B1wCm7cm2oirQYp+M9PPy93CLHUIl5
         Uic2r9QFjw+kkWVVl9K9nTyMSHBrK8+ExusLPJhnqgkBHS0iTC1ZEnQuR1hg4F5xfIlH
         HpIGShEJ6e0DPhbWPcda+iy0PzB5cL7kMDn1zqgGcY0natLS2euAAwjl+653J6c40dNO
         dYdg==
X-Forwarded-Encrypted: i=1; AHgh+RrHoUN8iJKNUc+v+BfxXkSS13d5DoO7sX756XFDoeohQua3llTDM27UEU2gvk5PncRnAKho7S/1BNhW4o4T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2lv2OHskvfSnTvQD7sPh2onSM0s5UTnLrhPZVO0ODngLAqrR
	UdZvCe/CPrSuY5fvnadmXsbav6NffMqE05lfWWVzzFQENt8CFMVQmLx4b/ZD3S/oGYACI+x2sqr
	XlwGaUA==
X-Received: from plaq21.prod.google.com ([2002:a17:903:2055:b0:2c7:a802:500b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2306:b0:2cf:8131:75e8
 with SMTP id d9443c01a7336-2d34565d781mr78916615ad.13.1786556032258; Wed, 12
 Aug 2026 10:33:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 10:33:51 -0700
In-Reply-To: <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1785727106.git.jpoimboe@kernel.org> <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
Message-ID: <anyufyGq2d-7AC_H@google.com>
Subject: Re: [PATCH 03/14] objtool/klp: Fix false module dependencies caused
 by dead relocs
From: Sean Christopherson <seanjc@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Ben Procknow <bprockno@redhat.com>, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="us-ascii"

+Dylan

On Sun, Aug 02, 2026, Josh Poimboeuf wrote:
> When creating a klp reloc, klp-diff keeps the original relocation but
> converts the referenced symbol to an UNDEF/WEAK placeholder tombstone
> symbol, which gets fully disabled later by klp post-link.  The tombstone
> symbol is only needed to avoid confusing objtool when it does the final
> run on the patch module.
> 
> However, for references to exported symbols, modpost sees the reference
> to the tombstone symbol as a real reference to an exported symbol,
> resulting in a false module dependency getting created.
> 
> Further, for a reference to a tombstone symbol which is exported into a
> module namespace, e.g. via EXPORT_SYMBOL_FOR_KVM_INTERNAL(), modpost
> can't satisfy the dependency, resulting in a warning like the following:
> 
>   module ... uses symbol kvm_flush_remote_tlbs from namespace
>   module:kvm-amd,kvm-intel, but does not import it.
> 
> Rename the placeholder tombstone symbols to ".klp.tombstone.<name>" so
> modpost no longer recognizes them.
> 
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Reported-by: Ben Procknow <bprockno@redhat.com>
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Link: https://lore.kernel.org/20260720145658.1103243-5-joe.lawrence@redhat.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/elf.c                 | 13 +++++++++++++
>  tools/objtool/include/objtool/klp.h |  2 ++
>  tools/objtool/klp-diff.c            | 16 ++++++++++++----
>  3 files changed, 27 insertions(+), 4 deletions(-)

Naive question(s) incoming...

How does livepatching deal with the kernel's restrictions around module-specific
namespaces/exports?  AIUI, klp builds a livepatch module, and then loading the
resulting livepatch.ko (or whatever its called) performs the actual patching of
the kernel.  If a patched function in livepatch.ko references an module-specific
exported symbol, how does it actually resolve that symbol?

AFAICT, livepatch.ko would need to explicitly import the module namespace, but
then it would run afoul of setup_modinfo()'s checks that a module isn't explicitly
importing a module namespace.

E.g. if (not-so-hypothetically) one were to try to livepatch
nested_vmx_enter_non_root_mode(), how would livepatch.ko get at things like
kvm_service_local_tlb_flush_requests() and kvm_spurious_fault() without also
creating copies of those functions?  Wouldn't the kernel need something like the
below to exempt livepatch modules from the restriction?

--
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 14:27:50 -0700
Subject: [PATCH] module: Allow livepatch modules to import module-specific
 namespaces

Allow livepatch modules to explicitly import module-specific namespaces,
i.e. to use symbols that were exported for select module(s), as disallowing
use of module-specific exports cripples the ability to livepatch the target
modules.

KVM x86 heavily uses module-specific exports to restrict KVM-internal
exports to KVM's own sub-modules, e.g. kvm-{amd,intel}.ko on x86, and to
restrict a variety of "dangerous" kernel exports that exists purely to
support KVM.  See commits 20c489205836 ("KVM: Export KVM-internal symbols
for sub-modules only") and 6276c67f2bc4 ("x86: Restrict KVM-induced symbol
exports to KVM modules where obvious/possible").

Preventing livepatch modules from using those exports makes it infeasible
to livepatch huge swaths of KVM, even if the to-be-livepatched function
itself is generally compatible with livepatching, to the point where KVM is
effectively un-livepatchable as the most interesting/critical flows in KVM
vendor code rely on functionality provided by the kernel and/or kvm.ko.

Exempting livepatch modules isn't exactly ideal, as it allows circumventing
the "no explicit module-specific imports" rule by using MODULE_INFO() to
tag an arbitrary module as a livepatch module.  However, that's only viable
on kernels built with CONFIG_LIVEPATCH=y, and loading such a module also
taints the kernel.

Fixes: 520b1a147d91 ("module: Add module specific symbol namespace support")
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/module/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..67181c768af0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1823,9 +1823,10 @@ static int setup_modinfo(struct module *mod, struct load_info *info)
 	for_each_modinfo_entry(imported_namespace, info, "import_ns") {
 		/*
 		 * 'module:' prefixed namespaces are implicit, disallow
-		 * explicit imports.
+		 * explicit imports, except for livepatching.
 		 */
-		if (strstarts(imported_namespace, "module:")) {
+		if (!is_livepatch_module(mod) &&
+		    strstarts(imported_namespace, "module:")) {
 			pr_err("%s: module tries to import module namespace: %s\n",
 			       mod->name, imported_namespace);
 			return -EPERM;

base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
-- 
