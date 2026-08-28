Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB736F8EA
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939093; cv=none; b=WDf44l8wmQdnr0b7YK9nPW5g/hVkiW7aNH75AioXlhQtwA37KY3EHbNRuuxqJzNbm9g7sre2wIGc++hdFRAvXw02sG0Ni78DzfgDpumOb6Eab2jMJKgj7u23PfyAZGSnQLu1ul71w7lwaXRzwVRI9t/sc3NMQ27mztpij2dEcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939093; c=relaxed/simple;
	bh=766DyMEpJOwyNL/XlvEzrOOwTcWuBPAUuZV84ZGnPSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz+Qx6iybmhrm+vLauP5Vb3/Y90QNPgRBVuj4sWQ0hYCJ1lr/K165PyudVHPw0jEULy51btUSnC9VXPUYDtgqn0qWo1BdJ3F15EY2aVQ0XqaFAjErq58k1A+HRMGaU2aWbXnPJObCFgCAP7YJkwnc3ooHUaCTB+xzlzJcXHm08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1egFN+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1egFN+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89B81F00A3F
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939091;
	bh=Uf72SaRNDLZax3EKX9q5bl7BWC2OsoDxL3UyLBezK8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i1egFN+20Qq99fsczummgB1j9KfOJSvax4pbylxWIlJc9zft6cRNLI++L9k15ujy9
	 hbxx47G72i6aqrbU2sh09tM25xanmGzSYd6AxjXk1RpdTgtRXf/4KXMd9nki6puUr6
	 5ulrOvA2TjdOAPkODmkpgSiGjLbGaUw6a6VjziJOBZSlVAtlLNGPIGczhJHp+01pUp
	 14sHEcA5Yxt/7ynbwRjCOv7t6Opo0S+okhwL9Q3NEycLpZKWoGLnyhznhNkui3eV54
	 4ovDSR5aIjbtwZbKrTt+WlY4gPPX4mQKwBrAbYx+ffrpA7TE9aEW9nHLjjokjdtaDF
	 2NPJutYlvBzUg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e55b62640so49523985a.0
        for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 10:44:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqyv3Q6A4jPGSecZBZJlQ4HUXTc3pcKxWGyNJ7NWiq7t4iXXVnCvKSBtCTy7qa2OmRNdCswTgw0AxY0MmmN@vger.kernel.org
X-Gm-Message-State: AFuF++m/CnLTYJ9jcwHUk1KaoQOweUXRlpwkyVpoTmWoWd5gt9gXTO3D
	FGBsWrzmtnYVMRNiP39+gf9SKwEySngO+6Ej+zfCW+PIj0t0kglYF7JU/xUOX5tlk/IHawHqqEN
	uigFEPMlRs32vAggKM0/oVZJMaLsSrsA=
X-Received: by 2002:a05:620a:458c:b0:936:d833:6c48 with SMTP id
 af79cd13be357-9391386acfbmr946959185a.27.1787939090878; Fri, 28 Aug 2026
 10:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apBbjoEHJ98DWN_W@pathway.suse.cz> <20260828125244.509977-1-pmladek@suse.com>
 <20260828125244.509977-3-pmladek@suse.com>
In-Reply-To: <20260828125244.509977-3-pmladek@suse.com>
From: Song Liu <song@kernel.org>
Date: Fri, 28 Aug 2026 10:44:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Jr16Wyd4oEXKEwJPwX=p7HWLZTA63uNeu=13GYf+=Uw@mail.gmail.com>
X-Gm-Features: AcwNN1VMejembc2ZMnl8oIYpMoYDa966_qns0XD7le-2iTipjtzUnpVE6PZViBw
Message-ID: <CAPhsuW7Jr16Wyd4oEXKEwJPwX=p7HWLZTA63uNeu=13GYf+=Uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] livepatch: Clean up klp_init_object_loaded() when fails
To: Petr Mladek <pmladek@suse.com>
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:53=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> When a module is loaded, klp_module_coming() iterates over patches and
> calls klp_init_object_loaded(). If initialization fails, it delegates
> cleanup to klp_cleanup_module_patches_limited().
>
> However, the cleanup loop skips the failing patch. Each function called
> in klp_init_object_loaded() is supposed to clean its own changes. This
> works except for the changes done by klp_init_object_loaded().
>
> The current code is a bit messy. The changes done by
> klp_init_object_loaded() should get cleared by klp_free_object_loaded().
> But this function also clears obj->mod which is set by
> klp_module_coming(). And relocations are cleared separately.
>
> Fix the situations by updating klp_free_object_loaded(). It should
> revert all and only changes made by klp_init_object_loaded().
> This requires some shuffling:
>
>  + Clear obj->mod explicitly in klp_cleanup_module_patches_limited()
>    and do not rely on klp_free_object_loaded().
>
>  + Clear relocations in klp_free_object_loaded(). Remove the explicit
>    call from klp_cleanup_module_patches_limited(). This requires
>    adding the @patch parameter.
>
> Finally, call klp_free_object_loaded() in the error path in
> klp_init_object_loaded().
>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel=
.org
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Song Liu <song@kernel.org>

With one nitpick

> ---
>  kernel/livepatch/core.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index cdb25949f73b..1e59a3cc0895 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -725,18 +725,20 @@ static void __klp_free_funcs(struct klp_object *obj=
, bool nops_only)
>  }
>
>  /* Clean up when a patched object is unloaded */
> -static void klp_free_object_loaded(struct klp_object *obj)
> +static void klp_free_object_loaded(struct klp_patch *patch,
> +                                  struct klp_object *obj)

nit: Do we still need to fit every line in 80 characters? checkpatch.pl
only enforce 100 characters these days.

Thanks
Song

>  {
>         struct klp_func *func;

[...]
