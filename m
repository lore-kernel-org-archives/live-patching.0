Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEB469831;
	Wed, 12 Aug 2026 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547257; cv=none; b=WPoFXFXHD/kqQ1rbOuRfiVsFHpDsbRZwHJUDJl8guxdlxCvz4Pd0kSJPTXh9exhkJk0zmA/MGKhm3G4+YD1OZiHyzBgWF5nhZbl+nsT1vfqONq8RczI63x9UQ0ReB0Lrpm3Okf21/FVlhd1WGqAJxIJNBMRKY/eWmAfBn8dZqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547257; c=relaxed/simple;
	bh=0Fo81//RgC8k3nfFYN+dhP6noVpjMDVZ4sr5feRxv70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNvY/gSh36kMHwXagZrEXWGQyxSHDA3hjr00utyZu3yghL7pLvpC8WXVE30RA/Jn9m3Y4jq58XKIACV+JhK/t/BRfffkJuNw3QqfithKPCN6kkbSztgzTbSgcI/4H7SrDK8Usg+0P6M9Ly/FRmT179LYV1NezygT6AJy2jNFTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWQXxVPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWQXxVPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70B41F00A3A;
	Wed, 12 Aug 2026 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547249;
	bh=Ay8a+MvRMHevy/LrhWEIPwck3bBcqIJ1nzC5/mwZWAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWQXxVPy+bOAjYp1vBoyz+CEJ1OaNYeFiSgjpPtn1TlobokM1rTTJ3VHArfxqXp05
	 fkSY5a4pNo1TAyhkkh1b0AacZdlCwCQPy9bqGownevKOqzb5GJGlo2WA83q81MeNBU
	 FqguXv6qlhcNPXiQyly8rwhs+8UfFzjtCmAJkZwaMohh/tz37sqo15jXig9gqqvRIC
	 6NlHkobn3Sapxyzpmt3wwr3Tqnqo+BIXHivGQ7Fv4GmBxt+NQzKOwvuYG0QQi8ZnkJ
	 fIo5i93kdIGTbc6Guhe1lH7aokK4wdbSx4rsk+hx2rrrOy5xQ/vmhlmCPLI/HgyVKP
	 NTwddXtM/DtNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] livepatch: Fix stack check for aliased old_func
Reply-To: sashiko-reviews@lists.linux.dev
To: mbenes@suse.cz, jikos@kernel.org, "Harry Hsu" <x90613@gmail.com>, pmladek@suse.com, jpoimboe@kernel.org
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, joe.lawrence@redhat.com
In-Reply-To: <20260812140232.48079-1-x90613@gmail.com>
References: <20260812140232.48079-1-x90613@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:07:28 +0000
Message-Id: <20260812150728.B70B41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] klp_ftrace_handler() incorrectly executes newly patched code for u=
npatched tasks when multiple aliased functions exist in the same transition=
 patch.
- [High] Premature freeing of dynamically allocated NOP functions without R=
CU synchronization leads to a Use-After-Free in klp_ftrace_handler().
- [High] Concurrent module loading or unloading during a livepatch transiti=
on causes list corruption and Use-After-Free due to lockless klp_ops traver=
sal.
--

--- Patch [1]: [PATCH] livepatch: Fix stack check for aliased old_func ---
commit 3438e93da695fdf6d92c99235da90b29e8a2a08f
Author: Harry Hsu <x90613@gmail.com>

livepatch: Fix stack check for aliased old_func

This patch fixes an out-of-bounds read and an infinite -EAGAIN loop in
klp_check_stack_func() when aliased functions share a single func_stack.
It addresses the issue by testing the function's position in the stack
rather than relying on list_is_singular().

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 2351a19ac2a9e..8d6e3a58101fc 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -223,7 +223,7 @@ static int klp_check_stack_func(struct klp_func *func=
, unsigned long *entries,
>  		 */
>  		ops =3D klp_find_ops(func->old_func);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does klp_find_ops() traverse the global klp_ops list safely here?

Since klp_check_stack_func() can be called during a context switch, it exec=
utes
without klp_mutex protection. If a patched module is concurrently unloaded,
klp_module_going() acquires klp_mutex and calls klp_unpatch_func(), which
removes the ops from the list and frees it:

kernel/livepatch/patch.c:klp_unpatch_func() {
        ...
        list_del_rcu(&func->stack_node);
        list_del(&ops->node);
        kfree(ops);
        ...
}

Could this concurrent module unloading race with the lockless traversal in
klp_find_ops() and lead to a use-after-free or list corruption?

> =20
> -		if (list_is_singular(&ops->func_stack)) {
> +		if (list_is_last(&func->stack_node, &ops->func_stack)) {

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does the same list_is_singular() assumption cause a use-after-free in
klp_unpatch_func()?

When a replacement livepatch overrides only one of several aliased functions
from an older patch, a NOP function is dynamically allocated for the
un-overridden alias. When the transition finishes, klp_discard_nops() trigg=
ers
unpatching and immediate freeing of the NOP functions:

kernel/livepatch/core.c:klp_discard_nops() {
        klp_unpatch_objects_dynamic(klp_transition_patch);
        klp_free_objects_dynamic(klp_transition_patch);
}

Since the stack also contains the overridden real function, the check for
list_is_singular() in klp_unpatch_func() evaluates to false, which bypasses
unregister_ftrace_function() and its associated ftrace_sync:

kernel/livepatch/patch.c:klp_unpatch_func() {
        ...
        if (list_is_singular(&ops->func_stack)) {
                /* ... */
        } else {
                list_del_rcu(&func->stack_node);
        }
        ...
}

The NOP is then immediately freed by kfree(). If klp_ftrace_handler() execu=
tes
concurrently on another CPU, might it access the freed NOP object?

>  			/* original function */
>  			func_addr =3D (unsigned long)func->old_func;
>  			func_size =3D func->old_size;


While reviewing the alias handling, I noticed one more pre-existing issue:

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does klp_ftrace_handler() correctly handle unpatched tasks when multiple
aliased functions exist in the same transition patch?

When an unpatched task invokes the intercepted function, klp_ftrace_handler=
()
observes that the patch is in transition and advances exactly once:

kernel/livepatch/patch.c:klp_ftrace_handler() {
        ...
        if (patch_state =3D=3D KLP_TRANSITION_UNPATCHED) {
                /*
                 * Use the previously patched version of the function.
                 * If no previous patches exist, continue with the
                 * original function.
                 */
                func =3D list_entry_rcu(func->stack_node.next,
                                      struct klp_func, stack_node);
        ...
}

If multiple aliases are placed on the same ops->func_stack by the same patc=
h,
won't the next entry just be another alias that is also in transition? Can =
this
cause the handler to mistakenly execute newly patched code for unpatched ta=
sks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812140232.4807=
9-1-x90613@gmail.com?part=3D1
