Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63373403E8
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878368; cv=none; b=It+6RwWjL7rfmVkLpqDX6uiv8rxPIijaj88yAkeekDkwvU3EtR3b5NHdaaeDar/+KLP+GYVf/3mwJJZskVi/FQgfVQ+GISwQhSLLoVCH/kBR0x8rlgkdmtmvfLqHgLB/oaeMSjodx726Q6Tyvr0FOFU502vrbvYxOto5MgEMwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878368; c=relaxed/simple;
	bh=xmocsn+ymvASuoCuEA5DIFUqwDKDOBG9rbEJaCL9LBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt8PSgwOvpg8KtIfRvXntpg5RZ6bm7R/RpeH/yEmWD7fvH17pJGFwXFuXZZQz0eaDxD76pnMO1Enplhm2ZCrUM9MfkJFVSsxc7OWITDwsEAg6zDY294G/k0eMmgbxMv5UUHs/SqTjj9Vv7uyahkafkHwoHfCy7vEfMBAVxnnV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luFuVXmi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luFuVXmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5C41F000E9;
	Fri, 24 Jul 2026 07:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784878367;
	bh=dgvVvx9Pm5quah5L9kyv+qxd+Nm3H68D5No+cvvmlaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=luFuVXmid9TyzOfQguz69T0ov9l2qtKneRtPw7W6nDhf3l0XZJSKZrb3EUZAu4pwX
	 bSpma+KHfqg5fQq7QwHzOlHnCKnYshkNm9hPTc2FHC8/IqhK2FCGf5A3QKEgeIijkV
	 f7E9SCyxCt9GGsvUhIt+wgLzlWk6SFsPLCX2F3DFLOMjqtiRWv5vxAftbCPXWwbtLH
	 2rfZQHtcWlozbHCRW998j1oziDf8x6Hp3OUqRKjZBRj8+sYb1sUPIv6r+fnge2he8+
	 CSKbU2UXuFnNkOqtHl1MVZNBH/qRgtuYLc8g4Atbu9xWxa+54o+Pt3eNNem9g5yfS9
	 mxT7WjbBbrp4w==
Date: Fri, 24 Jul 2026 00:32:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org, 
	Ben Procknow <bprockno@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>
Subject: Re: [PATCH 0/1] Fix exported symbol klp-relocation bug
Message-ID: <6kbyujrfzo7on5p24wb5e4iadzomjewpuwkofktgodiit3qlta@3uxl4foryfq6>
References: <20260713213128.3529250-1-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2607231109210.6525@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2607231109210.6525@pobox.suse.cz>

On Thu, Jul 23, 2026 at 11:25:25AM +0200, Miroslav Benes wrote:
> Hi,
> 
> > Next: symbol namespaces
> > =======================
> > 
> > Now a harder question, I think, about symbol namespaces.  In the past,
> > kpatch-build had supported patching symbols in namespace where
> > MODULE_IMPORT_NS() is allowed.  Looking at kvm :: mmu.c
> > ::kvm_flush_remote_tlbs(), that is annotated with
> > EXPORT_SYMBOL_FOR_KVM_INTERNAL() instead.
> > 
> > Should we make an effort to support klp-relocations / patching to this
> > use-case?
> > 
> > If modpost were to let klp-relocation symbols through, I *think*
> > (untested) that might be enough... but it seems like that may violate
> > the spirit of what the namespacing effort is trying to achieve.
> > 
> > Note that klp-post-link converts these symbols to SHN_LIVEPATCH before
> > the module is loaded, so the kernel module loader already skips them in
> > simplify_symbols() (see SHN_LIVEPATCH case).  AFAICT, the namespace
> > check in modpost is the only enforcement point, and it's checking a
> > symbol that will never be resolved through the normal module loading
> > path anyway.
> 
> I think we will see more and more EXPORT_SYMBOL_FOR_MODULES() in the 
> kernel. kvm is probably by far the most interesting one for us as of now.
> 
> Tough. All changes in upstream so far, as I remember, around reducing the 
> possibility to use internal symbols for OOT modules (like kallsyms API but 
> there are probably more) have been done with KLP usage in mind. Or at 
> least people tried. However, there is a limit to it. If we introduce a 
> workaround in upstream for this, people will definitely use it to get 
> around the enforcement in their OOT modules. We should avoid that in my 
> opinion.
> 
> So I would keep whatever we come up with in downstream.

klp relocs are already designed to enable accessing those.

The symbols being warned about by modpost are basically placeholder
tombstone symbols which are only needed so as not to confuse objtool
when it runs on the patch module.  They otherwise have no functional
runtime purpose, as they are replaced by klp symbols/relocs.  So it's
probably fine to just rename them to avoid triggering modpost:

diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index 6f60cf05db86..aab6db42052d 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -23,6 +23,8 @@
 #define KLP_RELOCS_SEC	"__klp_relocs"
 #define KLP_STRINGS_SEC	".rodata.klp.str1.1"
 
+#define KLP_TOMBSTONE_PREFIX	".klp.tombstone."
+
 struct klp_reloc {
 	void *offset;
 	void *sym;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f7a02c4a2429..505553f9bdc1 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1359,6 +1359,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	s64 addend = reloc_addend(patched_reloc);
 	const char *sym_modname, *sym_orig_name;
 	static struct section *klp_relocs;
+	char tombstone_name[SYM_NAME_LEN];
 	struct symbol *sym, *klp_sym;
 	unsigned long klp_reloc_off;
 	char sym_name[SYM_NAME_LEN];
@@ -1373,15 +1374,21 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	/*
 	 * Keep the original reloc intact for now to avoid breaking objtool run
 	 * which relies on proper relocations for many of its features.  This
-	 * will be disabled later by "objtool klp post-link".
+	 * reloc now targets a functionally dead tombstone symbol and will be
+	 * disabled later by "objtool klp post-link".
 	 *
-	 * Convert it to UNDEF (and WEAK to avoid modpost warnings).
+	 * To avoid modpost warnings, convert the symbol to UNDEF/WEAK and
+	 * rename to .klp.tombstone.sym_name to prevent modpost from creating a
+	 * false module dependency or warning about module namespaces.
 	 */
 
 	sym = patched_sym->clone;
 	if (!sym) {
-		/* STB_WEAK: avoid modpost undefined symbol warnings */
-		sym = elf_create_symbol(e->out, patched_sym->name, NULL,
+		if (snprintf_check(tombstone_name, SYM_NAME_LEN,
+				   KLP_TOMBSTONE_PREFIX "%s", patched_sym->name))
+			return -1;
+
+		sym = elf_create_symbol(e->out, tombstone_name, NULL,
 					STB_WEAK, patched_sym->type, 0, 0);
 		if (!sym)
 			return -1;
