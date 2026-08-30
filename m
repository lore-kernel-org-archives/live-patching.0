Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0921DFFD;
	Sun, 30 Aug 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788112570; cv=none; b=ejMmM7lvzh3xbGykQ7gOLnLN6VyXRNgr5jNwqGWG2TOkGRAlCaq2USQO5sWa6CfoyyhZRPLl48EowQUofDyKY4pVj9vANB/Id61sQlR+YCAZMoqi8dxVUa3/JTPGdgmBQGUFW+x3CgL6kR82cOMzlp91gE5U6FnCIqxwTy1BYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788112570; c=relaxed/simple;
	bh=Xp5wHcBcPiiQTcpwoSqZ469cyCkUGVeYi6l2ITj9b+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P6RJEFJ0Xxl2vAi4oH5pgLnlUjhRQisblq8pEp8mE1DD36AlkgVxWLjKC9hqW06czr7VzSuLSpp+z2tg+GCIl+0+odRumUxKUWSeKlDUctemwVmtIjI6UsdSIV/ymw9HEW/gZqQdkddIBDmELoPYHoeBTmqBld00+WgiGZIepic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg/Mf207; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg/Mf207"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BABB1F000E9;
	Sun, 30 Aug 2026 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788112568;
	bh=MP2cYbOMQ2yPxsWmqbaEgbim2t5PGL0Oh3kp+NhD3Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sg/Mf207ElMq9UPBD++UvJIjjunCI4kMpOUqONLj+LSierSJhZ6FE4HSE3hSILL4Z
	 fk008p3jEfeG+4X88SKnkLh9XLoZAzebV66m/1Qch30vnDIbjGlP82Sm1qdmkevmLm
	 V5Y31LMQPwsSm3BHGA/VDYDLAidhN1zTbVu/e4zWgV2qtFL2CMFFJkj7kaoHpYWWgB
	 2Bu2kjJ+byG3uIF3Ldx1b8LyFQsOV8j3Z/hUZ2ta3Aeq0dcgk4Y5/gN5oVNYnmOCmz
	 dZ4d0cuy8PVeL+I2S7v4Sy59vbs5DmEK9LLBujSisltlAtmK1izy4hZu+IdE37qRJf
	 rHJ3c+bBtGWVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] livepatch: Clean up klp_init_object_loaded() when
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: pmladek@suse.com, "Harry Hsu" <x90613@gmail.com>
Cc: jpoimboe@kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org, mbenes@suse.cz
In-Reply-To: <20260830173343.52759-4-x90613@gmail.com>
References: <20260830173343.52759-1-x90613@gmail.com>
 <20260830173343.52759-4-x90613@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 17:56:07 +0000
Message-Id: <20260830175608.4BABB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Failing `klp_apply_object_relocs()` triggers spurious architectu=
ral warnings due to unconditional clearing of unapplied relocations in the =
newly added error path.

Pre-existing issues:
- [High] If `klp_pre_patch_callback()` or `klp_patch_object()` fails during=
 `klp_module_coming()`, the successfully initialized state from `klp_init_o=
bject_loaded()` is leaked. The cleanup function `klp_cleanup_module_patches=
_limited()` intentionally skips the currently failing patch, leaving applie=
d relocations in the livepatch module uncleared and causing subsequent load=
 attempts of the target module to persistently fail.
--

commit a90c142b7a6f2c5551f83382ec1fcf15614ffbac
Author: Petr Mladek <pmladek@suse.com>

livepatch: Clean up klp_init_object_loaded() when fails

When a module is loaded, klp_module_coming() iterates over patches and
calls klp_init_object_loaded(). If initialization fails, it delegates
cleanup to klp_cleanup_module_patches_limited(). This commit updates
klp_free_object_loaded() to revert all and only changes made by
klp_init_object_loaded().

Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.o=
rg

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index a6796cd6b65fd..706a4a7193514 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c

[ ... ]

> @@ -916,11 +920,17 @@ static int klp_init_object_loaded(struct klp_patch =
*patch,
>  		if (!ret) {
>  			pr_err("kallsyms size lookup failed for '%s' replacement\n",
>  			       func->old_name);
> -			return -ENOENT;
> +			ret =3D -ENOENT;
> +			goto err;
>  		}
>  	}
> =20
>  	return 0;
> +
> +err:
> +	klp_free_object_loaded(patch, obj);
> +
> +	return ret;
>  }

[Severity: Medium]
Does this unconditionally clear unapplied relocations?

When klp_init_object_loaded() fails (for example, if a symbol lookup fails
after klp_apply_object_relocs() succeeds, or if klp_apply_object_relocs()
itself fails), this newly added error path calls klp_free_object_loaded().

This unconditionally invokes klp_clear_object_relocs(), which iterates over
all .klp.rela sections and attempts to un-apply them via
clear_relocate_add().

However, for sections that were never applied, the target memory remains
unmodified (zeroed). On architectures like x86, clear_relocate_add() uses
memcmp() to verify that the memory contains the expected relocated value.
Since it does not, it prints an "Invalid relocation target" warning for
every unapplied relocation entry, resulting in significant spurious warning
spam in the kernel log.

[ ... ]

> @@ -1274,8 +1284,8 @@ static void klp_cleanup_module_patches_limited(stru=
ct module *mod,
>  			klp_unpatch_object(obj);
> =20
>  			klp_post_unpatch_callback(obj);
> -			klp_clear_object_relocs(patch, obj);
> -			klp_free_object_loaded(obj);
> +			klp_free_object_loaded(patch, obj);
> +			obj->mod =3D NULL;
>  			break;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does this cleanup logic leak relocations
if klp_module_coming() fails after klp_init_object_loaded() succeeds?

If klp_pre_patch_callback() or klp_patch_object() fails during
klp_module_coming(), the successfully initialized state from
klp_init_object_loaded() is leaked.

The cleanup function intentionally skips the currently failing patch:

kernel/livepatch/core.c:klp_cleanup_module_patches_limited() {
	...
	klp_for_each_patch(patch) {
		if (patch =3D=3D limit)
			break;
	...
}

This prevents its newly applied relocations from being cleared. Since these
relocations modify the livepatch module's memory, they persist even after
the target module's load attempt is aborted.

Upon a subsequent attempt to load the target module,
klp_apply_object_relocs() will attempt to apply the relocations again. On
architectures like x86, apply_relocate_add() verifies that the target
memory is zero; finding it non-zero, it returns -ENOEXEC. This causes
klp_module_coming() to fail, permanently preventing the target module
from being loaded as long as the livepatch is loaded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830173343.5275=
9-1-x90613@gmail.com?part=3D3
