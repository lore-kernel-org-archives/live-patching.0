Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014163;
	b=clL4go30fMwCKX+HfFm7aDjTYgMJylJiWekCCak6PVpltDqwalA4h7CZb3Ydig5IIzLv
	 FLmWhWNnOD82a7xGCbWy/Vtxzy5V3+faXVc8lOPVULIT9dSjmDR6H58BiBoiyMTegHKXi
	 mdjuejk1/FvOcMVBpPpXyS4G7N8d5ZougY93sWJseeEukvzuSLqqFU8DMNy+k/MZ5d7bV
	 5qHjaH64pqYttF5M8+xGI1PUV2bIvSPe1J/0tEdB3/uPygR5m7XEqouIC93g6t6g+9o/a
	 aWYYbJZKigfIP4hLwPS0vDzR+KReupVJ9qvMIAPJ5YexMowwpfAnLmNsSc6bfbzypgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014163;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D9G88MuywnJnhToH4/l3hxWSTiG8xaiFEIAR80Jv9jc=;
	b=xK1Ax+MbyR6dqg4VdEo67Qmwgc8WGDE6ZwyMGbZvSRjoBc2KTwpCLUG0eDGiX1k9tQE3
	 OuYdhH0aUy7+hq2aKeB7TQbvKBEQGY6viuxvKG52lgq6ZrJV17bJ9++ly6FKI8PDY9F4D
	 zyzIWmVOYma4j1s8O2HmVsrMXf1EabbS7fhHDD1oDHPhyjXMZKTKvgHKsw/LGzwdyVPCK
	 cVbVZ6okBy9WZhjKACdude8AfoVJqgbQDpDYgcafL2LstRrDWbccJgiYutLspR/dkAHh0
	 AkGvT5qQw8ijqyqQC1rAcFFHXmlmY0s/VYXWHXULwi/eBPN/MgUePdiZuzQyuS/3HKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YawAyKI6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E719606A33F;
	Wed, 18 Nov 2026 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YawAyKI6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A891C1F000C5;
	Wed, 18 Nov 2026 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014163;
	bh=D9G88MuywnJnhToH4/l3hxWSTiG8xaiFEIAR80Jv9jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YawAyKI6hh5HPjn5p4rjlLsuju+FYNVD4RNUBSfbvzC61zcdSlN4QPcO6CJ54Otq7
	 ub6qnwe7xsak5+ClPkKxNJM+d5zfeVtoBYVr3+H8QDeIOp25eqBW68f7EHXBqjmexP
	 J1KKLnzFgCTPmHw9S5yOj+O3QFG9XtZZIWTtUmsw6/jTMD/PMv+EEjTotYK/NjoZh8
	 2KQeACjATUzyzLzjAfwkvpRGDb0p5dkjS0es70erL5Qyp/zTns+dN2zJCB6mhuKvRP
	 Ly+h5fMrWGDN34A3iakLA2XgvTFO8Gnt5ti9/7xH7LM74vcnvb+8/7ooDaobv/q6/C
	 MAXGB2RhLSGeA==
Message-ID: <sashiko-outbox-221282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] module/kallsyms: sort text symbol indices and
 use binary search
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislaw Gruszka" <stf_xl@wp.pl>, linux-modules@vger.kernel.org, "Sami
 Tolvanen" <samitolvanen@google.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>
Cc: linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org, "Daniel
 Gomez" <da.gomez@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Jordan
 Rome" <linux@jordanrome.com>, "Viktor Malik" <vmalik@redhat.com>, "Petr
 Mladek" <pmladek@suse.com>
In-Reply-To: <20261118145125.29399-3-stf_xl@wp.pl>
References: <20261118145125.29399-1-stf_xl@wp.pl>
 <20261118145125.29399-3-stf_xl@wp.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:02:42 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] module/kallsyms: leftover commented-out debug function pr_tab()
--

commit 70739117310db5d1cdad00c748372a0032a51a0f
Author: Stanislaw Gruszka <stf_xl@wp.pl>

module/kallsyms: sort text symbol indices and use binary search

This commit builds a sorted index array of core text symbols during module
load and uses binary search to speed up module text address lookups in
find_kallsyms_symbol().

Link: https://gist.github.com/sgruszka/09f3fb1dad53a97b1aad96e1927ab117 [1]
Link: https://lwn.net/Articles/1105642/ [2]

> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 5dae0832714a9..4e7a1c5a3b8bd 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c

[ ... ]

> @@ -161,12 +259,28 @@ void layout_symtab(struct module *mod, struct load_=
info *info)
>  	mod_mem_init_data->size =3D ALIGN(mod_mem_init_data->size,
>  					__alignof__(struct mod_kallsyms));
>  	info->mod_kallsyms_init_off =3D mod_mem_init_data->size;
> +	info->num_text_syms =3D ntxt;
> =20
>  	mod_mem_init_data->size +=3D sizeof(struct mod_kallsyms);
>  	info->init_typeoffs =3D mod_mem_init_data->size;
>  	mod_mem_init_data->size +=3D nsrc * sizeof(char);
>  }
> =20
> +// static void pr_tab(unsigned int *tab, unsigned int n, Elf_Sym *syms)
> +// {
> +// 	int i;
> +// 	// printk("\n");
> +// 	for (i =3D 0; i < n; i++) {
> +// 		printk(KERN_CONT "%d,", tab[i]);
> +// 	}
> +// 	printk("VALUES \n");
> +// 	for (i =3D 0; i < n; i++) {
> +// 		printk(KERN_CONT "0x%08llx,",
> +// 		       (unsigned long long)syms[tab[i]].st_value);
> +// 	}
> +// 	printk("\n");
> +// }
> +//

[Severity: Low]
Was this commented-out pr_tab() debug helper left in by mistake?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145125.2939=
9-1-stf_xl@wp.pl?part=3D2
