Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E42DB798
	for <live-patching@vger.kernel.org>; Sat, 15 Aug 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786813751; cv=none; b=ptzMnaSF9/QDuXEg62mr6dvbpVvfgNXfVj4zizRHkb4v+8YUZp9IxTdTLUSZ2vQtZ17ep7uPxZh6JRYyqEkNsJ+c6wuYnuDGdKRIfbllnqcpbQm0PnAKy81AwpRZFmYNCOwV0/ci7LEliXjvMNF1Or5ymI1FLqVZqaZ0wnBGNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786813751; c=relaxed/simple;
	bh=SV+BD2YJRNOQdqtaOIvSmQ4jrzNq/y+GykQ/po3GPKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTG6VA8vIAStg2EN1sKNk4GDxuZ2t+8eYWhvDQqS5acq0L1BKZbfI3vdKxqQWW/zjjzBRTa6YXeqyOGiT8/6J/jOsXMiphKwIE2OrjBwg7t4lNjxSAgG14I+5zuE5I9ziKUFKmer45fK7ysFfQmTx9h0HjN47hTI22ZucxjrQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzponyrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzponyrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3D71F00A3E
	for <live-patching@vger.kernel.org>; Sat, 15 Aug 2026 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786813750;
	bh=tbuc/7uRQBtgCvHYfbaNsltOXp9jrbjsZWlvMIhsgzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DzponyrqvB4uJvaDFGlqr1qX2FtPLxsLT6bIPRyaZ+Hb9OkKmn6iS6qOZ2HQtQbYe
	 lvk9KBoPpG7SRy7ncxCgEvfa9byI420cxgq6+mI/C9cFLbNzJnkzhTktj44Z8uh4Ts
	 xT11wtnjLOCAyTj2tMGUNOIpl4DPjbEcnw3rdMKwro/seSxWOcNLf991xCKn7c+l5h
	 og9yKbTzetglnLhhg6u+KkzSSZNCWwSSWc07gd6VIVywIqdZx6cJ56RH2XIs/zCt2S
	 dFsLT/c21o10KX3oIjwiYzQ2NFfKn1bG3dMGdr1GjLywobeECdyjKGwAgr1lU4Yxcp
	 RcXb9CeaiaRcQ==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e6c4a867cso126469185a.0
        for <live-patching@vger.kernel.org>; Sat, 15 Aug 2026 10:09:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqr/sAT3lKvTblvpf8b1A8SioiDxxKjMW3IDzc2wuTIhjh3cRLrmBMlqlmeAtDDP1Vk5vZAYq4k8efHHfYn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0nBj8pJMoxDIJhN+IeYz8rFIkLN23dG5UthUUZp/rmRzkTPr
	lmb55/loPZjZNU+AL0tLKLZwmFX8krKXfvUr8LJFNVzRCfyEGoLSg4pps+G2xXS8aagJaTJm5IU
	KvVqV7oEqESb80aY7mBpAbvrA1eUzYu0=
X-Received: by 2002:a05:620a:5e42:b0:936:cf9c:a9ab with SMTP id
 af79cd13be357-936d22403d4mr1233299785a.21.1786813749760; Sat, 15 Aug 2026
 10:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8e3b9fae109903a6aafb2a33310e4afdcebf58e.1786761327.git.jpoimboe@kernel.org>
In-Reply-To: <f8e3b9fae109903a6aafb2a33310e4afdcebf58e.1786761327.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Sat, 15 Aug 2026 10:08:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7kHtrhaXRaBmdh69FCcM7tbnVOVBkjn67_x_nJK6Z8QA@mail.gmail.com>
X-Gm-Features: AUfX_mzJ3mVYdA4KjeP7CimBZ_sO2drfnC6W8a9nseiKBh9JHKHhYudyTle6aDw
Message-ID: <CAPhsuW7kHtrhaXRaBmdh69FCcM7tbnVOVBkjn67_x_nJK6Z8QA@mail.gmail.com>
Subject: Re: [PATCH] objtool/klp: Fix vmlinux klp relocations for EXPORT_SYMBOL_FOR_MODULES()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Dylan Hatch <dylanbhatch@google.com>
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

Acked-by: Song Liu <song@kernel.org>
