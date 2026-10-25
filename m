Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792915100;
	b=3M+ihQc0e1YZJLEcE21QabwVgDXNTTQs/fTJrvzloTDw+MoK4buc0UPi5Sb9GtQtM36j
	 GvLasHE2GciCP1I2Wr6XWEPvpZlSf9amRDPzHSYUivvr61zZixHWcU1rzNNQ2O33cT1Qc
	 x3lQrki6W3fNXXN2RXyi06jrQuB+sChcGXjd7iiSoGoo+HJyC1U60epVjgd0pvhSfLzT3
	 bTbXcy+nwPj4uBmW9mL/zwqVrfRPqoY2fnRWaW/uVTl8Y/3g0R73HS2AmDYDIPvgblFX8
	 PVezSRaDeXYQth2OLO2rwW1ZrWEUEPWBZ+Ss3VU/Ki+YLw2zVyw5Ge+KcudiA/uLlqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792915100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9g5fInaMy5+0RBlAovUoH6oaxXkg3UJw/5Fiqy2Mm9w=;
	b=pDhefQWZN3uXjWlo0Zy0xY3ApoK3D2NYx0FOyfkEBiGm1QTmaie1059HBzpcgODxRRsg
	 94b9CvunKCOMCDEe6aZoXffhI8LeIJjzN6+i/Ue/hU/i4bS3p3rP1kao5eILa3HqpuS3r
	 o3dK5n5i5uc4eHacPKL++7uJ5KsHOQwurLcUTFU+Av0GzErJ54HZQFQSaQyEL+G1/fQE8
	 U7pR8/tCiipM4SRWCUtBBLBH+jGI7T7lN9Y1n7fU9DvB0FJLrEXSXf0DHwcZ0lwU/iOI4
	 /Ek/u7SMtFgbmPWtEt3gDUBA7YUaqCFa3nXbk/zBYZKLgWvm2Qav0htk6kyTdxJtKqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnhqlLzP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269D606A31A
	for <live-patching@vger.kernel.org>; Sun, 25 Oct 2026 07:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4269D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnhqlLzP
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67990a45e02so1923823d50.3
        for <live-patching@vger.kernel.org>; Sun, 25 Oct 2026 00:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792915099; cv=none;
        d=google.com; s=arc-20260327;
        b=AyqO+6Oqnh9R3tv0C7dUSwxagijVNQbDf0TXk/toxypIaDmAhX08lVRBrfTLMu4/D2
         3D/WFi/N6ExEaFf81hn4YUGMmKQh9CD5fkCkWQzUZ6bSaTOnecNJVBSqQRDPUL5i9tDI
         b6E/ocSwsFNnK/bApAYnPbg0v1hN3b+ZE+90ZHH56MWsN3m9Q5R2FuYwmQrZxKsEKeWu
         zWf4fF+KM65WXktoEP+YnYtMv37grEq8bS4QHazALW20CPW9ggI8T3pjM6I3a2JqR8u/
         lQlzGCJL4BDmCUv6R+5/hvotr1gXBybj1CkM98EHYAIV/OKtJMhT5Um9Skqo1Dh2ojN8
         CMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9g5fInaMy5+0RBlAovUoH6oaxXkg3UJw/5Fiqy2Mm9w=;
        fh=r00b+mdqZimRyrDApnPpeQ2oZ/VCZSPNZzegTSod80Y=;
        b=Vueggnx9ewFYCCgUXoPEs/JtdbwwdizJSmDXzm7KiqR17OJIRazBh7YNqYPcigPb+U
         Cpj1WiD1vgDQUn3Ussn7BA8qQuLOhIedlZVYzyHBydwuU3WJDFTWLekZ8+5QWdB34Hnh
         BTocbWPR2Prdhdx3JU2Perpnott01GwhqepO0JnWvPnbikI8EN3xv9Q8atoaOOr8YF87
         4iTF0vFw/AcWACeozDtZDgaP/DAGWPgyxm5zO7hmVMKQ7jSLQTLEHNWvsuh5y3USOcM/
         WGhzzfLqARaWKQJ88hgl+0GQzAEC3QvtUuld9dhG1o9rQezB32USV4ctOkT7puKNkhrx
         ozPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792915099; x=1793519899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9g5fInaMy5+0RBlAovUoH6oaxXkg3UJw/5Fiqy2Mm9w=;
        b=pnhqlLzPjLZni7zm+6SioVV2GPmku1we7OiD5Yf7eoGpKKbHLCZoFlCYolWnklT6/c
         ahHOrsOJA1x0fT/O2kiP2WT5R9A42kWH8xiCt/xy4f9V68mtWoEedmV/cU2GQVR5t6bF
         1iHycBO6Hb3/ojwwuFONWriCm5Zr6qD9uTpsgaFwOE3lXoYREGwIABrNHq7zyPGyysaB
         2uROZwOFCYbGnWzfVTBSPgiXfoe6qiXK/chV4lz18FTw8vqgpYAiqoaNYOclmlw6in92
         8ZiK/x1L92/d7QhZE7JK+kwSrIuOFuIe3stgvASvtD6TIOSsQRRIF4MsXL/8YwNoEraJ
         Hclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792915099; x=1793519899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9g5fInaMy5+0RBlAovUoH6oaxXkg3UJw/5Fiqy2Mm9w=;
        b=BI6vX+k6qXOWPY7OXxS43QEC0n4FVFpYN/kMdHmR9i4Ii74gYt4YlnBWBz08pxevij
         CsUC7YjUF8Xdmde6rSyqFrKud6gXCCBgmxzy5mKxWY/AQ/K1xIKrYfhVyqXaNeJ6hK/g
         lxgzZp1FFMuDQXJBHESrPDYenZZD3R8R2qSv/DHMDg0g00/qATRRq8J5iB46gG4auehu
         sVFAeYoIi5eWKN5f5e7PFBrm+fYCDL3vIPGb9B8JicN1Am+3UjOePls2GOYnPp1IsuOE
         KdxcZaljAREQRVipbHneiAmUSSvtdjNTSOda49NRkWdGnMP7hMI+a1lWZqVkYJy0yOMt
         GdcA==
X-Forwarded-Encrypted: i=1; AKwUvByMV0S+3vUK98dhSA5wC+M9DeDBVJ6rPYnp8E81Ht4ZDfokT8LguVL7b5g2Z9xM02n/CqNMFPEWmey1CSVU@vger.kernel.org
X-Gm-Message-State: AFq9FYID++cVgesl4ohzc0n/Lc9vnsW5E1D06zQDFbTl1xKH9h85dPVl
	lAvHq4Jtir14YNQgk9gJkbfvN5k0l2J0g75GnSPOQPwiwI2I0j6oHLn3fAiuOfFOtsuZWacl6BS
	UF2spa+bSZjmBcRRkXQL8ygbaSbbjoKk=
X-Gm-Gg: AYBFou39TecLLjJiyWHbAldXD7VoDkDzVmGUAWz+gQSj0VrijbI+4duNK0d683L8dIV
	UOxItnHFeH8oN/Nip6W6TEVjjRnJZ1ajNMaKXl5SNwKzQOwv4bMDxUQ0zqVi2mmN0nVPUjAbByw
	ONhsSzlj7Gu1Bkjy5chUGnDYYhS/lnFzQ2+lo4C8+fk2hJ/afpDH9IAU7hUNcD/GLGdIMjMirL3
	R154k8Pia3yJzkmiQQOlMrpq0vjf0aiLKKMNI9RiD2gBUX/A5gr9YiYVqyoCv2261Bp8WbPPDRp
	kD1Khd7IDY3uEmSI57XtPndFLNGlJXuH8fCih7seTfSV/pX1nVCJYdQ9zKfSHNRQ8mDJJPLH/1L
	IpeILvS9JH8OBFXU+x3hmZOLAwes1mf6e2sBHze0D1KshKaZae1j6OOKp7el5qZvCnE8=
X-Received: by 2002:a05:690e:1517:b0:679:a2f4:386e with SMTP id
 956f58d0204a3-67a45198fbamr3305985d50.9.1792915099133; Sun, 25 Oct 2026
 00:58:19 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016053708.47089-1-laoar.shao@gmail.com> <20261016053708.47089-6-laoar.shao@gmail.com>
 <atsvvqPJk-413GzJ@pathway.suse.cz>
In-Reply-To: <atsvvqPJk-413GzJ@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Oct 2026 15:57:43 +0800
X-Gm-Features: AclHuK-1caj8hAHZPT3H24FxJMZe1DPivWaWb2xEruKl-GM-eNZMK8ad4-yNcxo
Message-ID: <CALOAHbDJWBB_Y0EjDSxWHbtavbZFN8tA9Jghp+EWUmoi4=CnpQ@mail.gmail.com>
Subject: Re: temporary broken selftest: was: Re: [PATCH v12 5/9] livepatch:
 Implement provides and obsoletes for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:58=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2026-10-16 13:37:04, Yafang Shao wrote:
> > The current bool replace flag is too coarse: it is either all or
> > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > livepatches, which is safe but inflexible. There is no way to have
> > multiple independent livepatch sets coexist on the same system.
> >
> > Replace it with a more flexible model using two new fields in
> > struct klp_patch:
> >
> > - provides: an unsigned int id identifying the changes made by
> >   the related livepatch. Where the changes are a set
> >   of modified objects, functions, and used callbacks,
> >   shadow variable ids, and state ids.
> >
> > - obsoletes: an optional array of unsigned int ids specifying
> >   additional provides ids to be replaced. This allows a new patch
> >   to explicitly obsolete patches from different scopes.
> >
> > A new livepatch atomically replaces any existing livepatch that
> > meets either of the following conditions:
> >
> > 1. It has the same provides id as the new patch,
> > 2. Its provides id is listed in the new patch's obsoletes list.
> >
> > A new livepatch that does not replace an existing one can coexist
> > with it. In this case, the two livepatches must not modify the same
> > function, or use the state with the same id. Any attempt to load an
> > incompatible livepatch will be rejected by the kernel.
> >
> > klp-build gains -p/--provides and -r/--obsoletes options.  The two
> > parameters are not validated in klp-build, since the compiler and the
> > kernel handle invalid values.
> >
> > Enable the CONFIG_KLP_HAS_PROVIDES compile-time marker now that the
> > provides/obsoletes interface is implemented.
>
> I tried to run selftests when rebasing on top of this patch.
> And test-sysfs.sh fails with:
>
> <paste>
> # selftests: livepatch: test-sysfs.sh
> # TEST: sysfs test ... ok
> # TEST: sysfs test object/patched ... ok
> # TEST: sysfs test stack_order value ... ERROR: Unexpected value in /sys/=
kernel/livepatch/test_klp_callbacks_demo/stack_order: 2 vs. 1
> not ok 6 selftests: livepatch: test-sysfs.sh # exit=3D1
> </paste>
>
> The livepatches are not longer stacked and the test should get
> skipped. It is called only when:
>
>         if [[ "$HAS_STACK_ORDER_ATTR" =3D=3D "1" ]]; then
>                 start_test "sysfs test stack_order value"
>
> But "stack_order" is still there at this stage. It is removed
> by the next 6th patch.
>
> It would be nice to fix this to do not break bisectability.
> The following change might do the job:
>
> diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/test=
ing/selftests/livepatch/test-sysfs.sh
> index 32d3af0097ac..e48bf33207ca 100755
> --- a/tools/testing/selftests/livepatch/test-sysfs.sh
> +++ b/tools/testing/selftests/livepatch/test-sysfs.sh
> @@ -13,6 +13,7 @@ HAS_REPLACE_ATTR=3D0
>  HAS_STACK_ORDER_ATTR=3D0
>
>  setup_config
> +detect_provides_attr
>
>  # - load a livepatch and verifies the sysfs entries work as expected
>
> @@ -154,7 +155,7 @@ livepatch: '$MOD_ATOMIC_REPLACE': unpatching complete
>  % rmmod $MOD_ATOMIC_REPLACE"
>  fi
>
> -if [[ "$HAS_STACK_ORDER_ATTR" =3D=3D "1" ]]; then
> +if [[ "$HAS_STACK_ORDER_ATTR" =3D=3D "1" && "$HAS_PROVIDES_ATTR" !=3D "1=
" ]]; then
>         start_test "sysfs test stack_order value"
>
>         load_lp $MOD_LIVEPATCH
>
>
> It should be merged into the 2nd patch which prepares the selftests
> for this change.

Thanks for catching it.
I will update it.

--=20
Regards
Yafang
