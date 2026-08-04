Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45042EEA7
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830445; cv=pass; b=O5u9JPAw8JR2rrFIWgi/Ek4MkKSN+Nbiq4D39t1xQIgzZYKue7WE0Pu4dPOVvl2HD6IFJQqE0GNIGvKIeOZfW0et8jKFKWW895sQhOQQc6P9KuiAFluzrs2i/LWdYc6L+ulC+KGhpwO+k0fCzPLMUfcAemObmbwWQy8KTvEhTcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830445; c=relaxed/simple;
	bh=OGVS8gsiozxEdjWEPDQzeoafxc/DPHmM78nhgq5r6/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vmv/ZLCd9PrTXcTXN9BHbF2xfOKHKvKlansMvfQSGaDYLU/f3bei4De57f5GEoSD/N8BOA4gtb38bC6w29weHI8OkTIl/Fg+w2Cc19uXRo9icYFGRj0/IjYyfhR54YAG1qRVU0mg4yv0k6eSQWRugTXMMTBQu8Xar58hB8u6OzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU++q2IL; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU++q2IL"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ec29f1d07so51914617b3.1
        for <live-patching@vger.kernel.org>; Tue, 04 Aug 2026 01:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785830443; cv=none;
        d=google.com; s=arc-20260327;
        b=h8Vhs+kNxWEO7gVKhN81/mGWcVTJNPHnR7cvvK+C+umdOl27LbFablD4OULhWhQ8w+
         5QL/YF4WwRfKJ/cDV+fwOmi642p0pFndoYTaNM8cTOM5fpQmMXNOcbs7B7u42FDyiygF
         gz4IwK7B8wVhbir26AMj/j0O53qvxw7Wgk3zbU0HJ+p94KGoz6OQkBd4s91+/kKZRiVZ
         9FVn5Wzy0Dbg6VnRHMf8QlzaRykj9fYumVRtrFPwi3poVRM/MQjpCPgcLMM6dP31/oPA
         fdjRsZbaaYOfeBFRDhTM18PGYpW5DZCDOyqHc0GSTYu9mSOCy5r8ZeG0LHUUXwTFozVo
         zyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6sN7hyGeF3/QBGyqG1sqeR8O1GAdeZpGRRACa/xNXes=;
        fh=85HV38ARLlNHWSNxm7GdRg0WpO6fvFt2e7poh979gbY=;
        b=qU1DT4S4CzhxTz9s3Ac1BUfidf+Ql3YYe4U5gpqzQn5kSDPCiM6RAL90okd2A3q8hB
         lGeyXIsbuMBCTtwm6JBxO+YZZpiSonK9IJmN8FRUD+PSAjTyumR9l98H/pEF1vR5s3HP
         /jv4CVdTJ2DGRr0Ks4YOOVpiA1luVNsSAd9xGuYymN5lMNxnE3t2KoGcBxkvuhXO7ayc
         cjU/lmg7nWub9w82Vuo5QrqsTwXE7coPsPZqfUfr22boDNM3ZeEw+LssB2lTvv2pryIF
         QiBMNoPhEEigRwv596ys6wg00SarXvhl6+bm2Es3wMacqaEpgA9yTt3kYPGwSHsmv0Il
         GgyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785830443; x=1786435243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6sN7hyGeF3/QBGyqG1sqeR8O1GAdeZpGRRACa/xNXes=;
        b=TU++q2ILqItlmQlcqK496g5yr3IMKjVek3e2iaYDAJ502P4lyHoFVsSACjRShTXAru
         uXC0wpPO5FxfbB9uPVB0FrmBxyVsLe8ZmCzuKALylfdmRBIgMFAt/KTJnBIySypB/R87
         fq11iTItiGA95eGLvRhNAE3kMgN811zVo+o5ZNCEVvmZ4yR1k6dL8gsDM7yPmJ2qdkzk
         sEoMJ3yR/Ett1EhFRtO2RvRicQEnoY/k+J9oIUxMQIEdXWv+Wh6cClMEFVYdZ7t4K2V2
         1o9sC4tSi63kZ/F6Ym5h/5tBZIVsp5yCS+qmnOI/Za4SS13QjDqA2AKi88wnDIzsFaC+
         IdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785830443; x=1786435243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sN7hyGeF3/QBGyqG1sqeR8O1GAdeZpGRRACa/xNXes=;
        b=AAd2UC497snUVNTlT36F5nNGh3nrDsU6dKaYAMBf/AgEi26mfI1xFK2WT+LKErUURb
         9/HBRSi+y0vLZlxZjjvqU/iYbIIvfprA/5/nkWefYCBlTKR3ZMY5lcjlvgzizumZdQT6
         k2TKKwgsG333QQYONmfil+Xom4aoNEgXDsuDDngDctK1cE6R60dc/vs32qf2VR3MF6te
         RvOuA8Qw64uU5ctnoRAkMRT6N6HwdGoL8YXbs5NasnTJlT2GFPsdnl8WdjjJIrk1AqZo
         A3m1e1Y0x5+Oo8wwJO0PgyOCCVIDNFbPQ7D3qO/43cZmJo6j66DFe91uJ2kSRd6aS7Bl
         qX4w==
X-Forwarded-Encrypted: i=1; AHgh+RpD61kfp+Bu+fBUV7gg8I6lavuRvvtMcQgHnxolBcZfuuw8A7EQuiEvl87rGzXZ1zEJS1zom3J79OYluDPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdP6jIGq8JP0xONpDBGulm/GhmFiptNkrrEO3XpS1M4TC4ccJ
	jQnW1wKYGvPkqHRiexocU3qHDMuoUTDsv1q0OxbMZhFMk8aF8oYmxJ8+rVhSja9cLzqME52U9gd
	YoyWmE3Gt4pQjnLVYxQ+Gxl+ve+hOwY8=
X-Gm-Gg: AR+sD13d3My/zWghrhjlAgS3uRVfB399LCW7NIwinehmmkjvIh1ClCAMnm4yhL+RLv6
	nOV9yIZvlOAMIka67fIW4LGlk1YeKipeKv2yZtxxomJOvYD2sBIlU8Z1jlsUBjTQa4W0154DWaP
	Y16W7rps90tZ514+10Q9r0/qZUYMXopx0qI8xBR3oEEPX2jQ0K57IndeCHIWm8i15R4wuZRUaX8
	MBw3pQZVJFvGItQ17ShaX9Jg7gsfibzsGuv5GfnYWwDZ9CyDVPVUFOPvqjQNgATC/RhO7DX2/OC
	Z3LYiS5yfoA7pEvsXOe/Ca5XyrFmw0WU9Cl21cjMA5nKGRPYmExqb9GzXWiAMI1M9pAtdvLNhrs
	+WA==
X-Received: by 2002:a05:690c:6387:b0:81f:650c:98ce with SMTP id
 00721157ae682-81fd4bf4886mr174550617b3.31.1785830441484; Tue, 04 Aug 2026
 01:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804065010.44922-1-laoar.shao@gmail.com> <20260804065010.44922-3-laoar.shao@gmail.com>
 <20260804070336.5878F1F000E9@smtp.kernel.org>
In-Reply-To: <20260804070336.5878F1F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 4 Aug 2026 16:00:05 +0800
X-Gm-Features: AUfX_mxGSk-xETKXTtNYxe5sKvhCIlGzr52N7RGo-baY3Ws7lFHISe3-JXv4JWg
Message-ID: <CALOAHbDvXRY9cfHQxDdsT+=CSOePvSgG5JF=uNK_A3dP9noLXw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/4] livepatch: Call klp_init_patch_early() earlier
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Moving klp_init_patch_early() before early failure checks viol=
ates the kobject API lifecycle and introduces missing cleanup on error path=
s.
> --
>
> --- Patch [2]: [RFC PATCH v4 2/4] livepatch: Call klp_init_patch_early() =
earlier ---
> commit 6b8df20b82104d4c61053ebea3721f1d77891456
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Call klp_init_patch_early() earlier
>
> This commit moves the invocation of klp_init_patch_early() earlier in the
> livepatch initialization process. This prepares the code for an upcoming
> patch by avoiding mixing iteration variants later in the sequence.
>
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index e07c41a0f3ac8..c98cbcf59566d 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -1135,6 +1135,8 @@ int klp_enable_patch(struct klp_patch *patch)
> >
> >       mutex_lock(&klp_mutex);
> >
> > +     klp_init_patch_early(patch);
> > +
> >       if (!klp_is_patch_compatible(patch)) {
> >               pr_err("Livepatch patch (%s) is not compatible with the a=
lready installed livepatches.\n",
> >                       patch->mod->name);
> > @@ -1147,8 +1149,6 @@ int klp_enable_patch(struct klp_patch *patch)
> >               return -ENODEV;
> >       }
>
> [Severity: Medium]
> Since klp_init_patch_early() initializes kobjects for the patch, does
> returning directly on compatibility or try_module_get() failures leak
> these resources?
>
> The kobject API requires that once kobject_init() is called, kobject_put(=
)
> must be used to release the object. Because klp_init_patch_early() is now
> called before these checks, if we hit the early return paths in
> klp_enable_patch(), we bypass cleaning up the initialized kobjects.
>
> Also, would simply changing these early returns to jump to the err label
> cause issues with klp_free_patch_finish()?
>
> kernel/livepatch/core.c:klp_enable_patch() {
>     ...
> err:
>         klp_free_patch_start(patch);
>         mutex_unlock(&klp_mutex);
>         klp_free_patch_finish(patch);
>         return ret;
> }
>
> It looks like klp_free_patch_finish() calls module_put(patch->mod)
> unconditionally. If try_module_get() failed, jumping to the err label
> might underflow the module reference count.

Good point. It seems we need the following additional change:

--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1168,19 +1168,20 @@ int klp_enable_patch(struct klp_patch *patch)

        mutex_lock(&klp_mutex);

+       if (!try_module_get(patch->mod)) {
+               mutex_unlock(&klp_mutex);
+               return -ENODEV;
+       }
+
        klp_init_patch_early(patch);

        if (!klp_is_patch_compatible(patch)) {
                pr_err("Livepatch patch (%s) is not compatible with
the already installed livepatches.\n",
                        patch->mod->name);
-               mutex_unlock(&klp_mutex);
-               return -EINVAL;
+               ret =3D -EINVAL;
+               goto err;
        }

-       if (!try_module_get(patch->mod)) {
-               mutex_unlock(&klp_mutex);
-               return -ENODEV;
-       }

        ret =3D klp_init_patch(patch);
        if (ret)

--=20
Regards
Yafang
