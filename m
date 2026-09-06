Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F2DDA9
	for <live-patching@vger.kernel.org>; Sun,  6 Sep 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683688; cv=pass; b=e5xwLCfJ9N4nmOVNK33y2pR1Bgft7TEwVyXEiaiIm5HOD+oUsKK20fIBKS0AFzs55foJLekAcnkwWkCmLEu3Bsvn0BPcHGK1PssozcRk+u1Xg7SuvurPSHBclJWzyV7NMSVHTOjO4EabAgH5lpuVOvsiG6YyuZswQuySx8ZhGb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683688; c=relaxed/simple;
	bh=Hfn+Xh+nT/9tx0cilbQeJyyNP80Ci55okC86U9np2kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZdLnESwz1Ax+5htG7XZo8bb2mBvey6E9BMd1wG/JeaUUDo8Hc/9NedSrGZWWzt3u/Cqn+dFYkrOi2Oiino/Dk6jGUP1E28YfXYjCicGrHwMggYpkWhQyVyfsUHRXB5DXpx5svIj3a/dk/3dDSZp6U69Tv8h3j0kfEAicS/JEdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQVpLgTm; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQVpLgTm"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-86162c086f8so29141687b3.1
        for <live-patching@vger.kernel.org>; Sun, 06 Sep 2026 01:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788683686; cv=none;
        d=google.com; s=arc-20260327;
        b=n070mnytTaftUJ6B94DcZ5dA6rDicIpvH/bc6djG/yC/uyL3cKZ+pf8t1ACNJ5rNRt
         uefqnmtt9U+DhJb7BmQ5zE+8uxGNvuZmpJCAMWpN+IQDMMNEIpJ103KC/IoA5YeG3z5N
         ozbYxH0COrDrV0RnJ+Z0fx9yMAC8cTcbDJYaap2RKgQCozfI7dxJ1UV7F+4ZTq/2p2Cv
         LpE7kNxCs+uXQQzHdqf8nYFaC1Bsx56+X2p2cfus8foSefCMB+ttRME9uVQ2KXsxPx+/
         qY3atp9dZ3ZvPD8jHM5gQ7nrEUVSJLC+JvRx26zWQnFrq94pYASTYmCOJwj83N7MJZvT
         vM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OzOhjtcZopYbZnJ+/5VY/ekUPYU8vaAV181LmFq26lI=;
        fh=WNIYmDnxvmvxaPpME7x+IC1Nt6L7nx/07LzBROq41Kc=;
        b=YqgjL8+8OVkF+vrHK/jWBQYlLb4W1RJj9iBHacXIF0GdYb1ZNSCH/pIrydSob9NiJJ
         jQGGlY6KlJ4EwXcjyxWsx4iTBPiuq1AatMRsp3+RAi2IM5ulLuT5BjQPwnmPiHAjxZLq
         NC/XXPUj7o8/ir3v1tvAAAm8ud6IXHDzToKT10J+QQIAo2Nc3Ut09E4yB/mNL9t64n2W
         qNYSzMvm5V6CDUwyPjKtA2aPfy3GkSbC79y38/bVIZt/4oysa9TAgyyNxF9ci/0GRfID
         Cp4CfLQTt5bLFwheUOZten9suZwZHADstjPIwoMvMZPBJO5p/UD1E1FLVxkCeEoeruDI
         zD8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788683686; x=1789288486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OzOhjtcZopYbZnJ+/5VY/ekUPYU8vaAV181LmFq26lI=;
        b=UQVpLgTmnI/2QnN2uC/j/yLcl7ODTmqPD4rH2DC4SMC9YBR2ammTVnh/YQuGtThHg6
         3H3+VGzVUZc2FtVh/kJxw6RQXgtyBuow2fott3gLu1c/5jhU6m/8JA3qDOLM+WbufPxV
         tq9avst9MckgVH7A2aM6sMx724opwMjifcP02POENb1s8URr0XlpARiYwkXMrVQqeY5G
         Sdytks/m8gdfLVzSg7K0TP8Shc6gZHVjQhMMawQ+lo+Hb9is+DVJRd43DXzJnv+9xcc2
         oxOkwRwVm65VRjTBcYEbWxTWXW2tR2U9/xjvXN6w4/PuOE9UXAR4F6KoPb4IGx9PFLrf
         nh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788683686; x=1789288486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OzOhjtcZopYbZnJ+/5VY/ekUPYU8vaAV181LmFq26lI=;
        b=HAeZVgy7021rCOHtNXcCoMjuSkS9TJArgieq4DhFmnBBMWI1HUzUp6ImTRAjfLc05S
         v5nZSuODV/BuGgCww+pjTc2YB9UzzsYAo8B7Y5Mlt40nCkwolewnjbHExvrJDMq4Cm20
         Vx5Ln5LvQSz0RRGDSXw2YHilQgay8raAZ30chAEBU40IXUPNihmFaWIe5JOtFrj3uzab
         xSTSpokk2ZsnvlcH1eNw+gq0NvNIg2rlyD9I0ofNdfVTBMg09F3POWhDguN7qGl1qgTv
         SvYogHTKr3uWP0jFug6wwjs95kqEKwtSK8kkSAkwwi7Q3GwoTvDN+jcSGOguXHZQPJxH
         aO9A==
X-Forwarded-Encrypted: i=1; AKwUvBy53E+HzmsR1ndIlBDtQxcscD9A2kcxk2iqI5HVJ/mlZbOcdY8bXBe0dZU0BxLlGbLiLnihl7OWzhufGX0c@vger.kernel.org
X-Gm-Message-State: AFuF++nq+xGw0TkCLjpmHcN9RnYQQHgQC3e8dgoMm8rAyO3ntmh0Hz7j
	OGMbZpq4FKunusB45HZZxCe/5pz8dEyj/y16BKXeoPfKjjuWhjTe0hk/+uLKYEOiiVcLA+U3Sbj
	iHLjXVE5bkSuGVph8vNCxG/ElR03VEro=
X-Gm-Gg: AYBFou0amLsACOQ+2N1qUoovx+uEYvNjIW/3YVb0s9qPDUzETYV7iZzyLrnax7a1Px3
	7vw4gmeJS4NKOHwZnvPbHjHqEF6XF9sJGrnSv6uPtVUhpoxBPFb7qn1+FuMb9Kl9eBgUqYmjp+U
	wnoBbNrZKomfCINomdZrnt4nYRkQob++sG1RtZlysW3inDCgW2H6cSybWoVnITCmKFlS8yZM7I+
	Abk1ydrw/YdT4c2GNUAt3R2Xh38D6DVBKbjy+KtrtYYCcmrWiUuMKPWwizM3c2RWPd+Kg8JNREk
	GtPaf1fqI+73pCyU3uHhUXDGqG0GjD4/WZhOpcehXYJtV4Qtzwvz5rMLAbAxY5dbmk6mmJwIu6m
	3CQ==
X-Received: by 2002:a05:690c:97:b0:86f:8542:5c43 with SMTP id
 00721157ae682-86f85425feemr72362067b3.14.1788683685880; Sun, 06 Sep 2026
 01:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
 <apk9f_LsGRYHzN0Z@pathway.suse.cz> <CAPhsuW4sac0Xzumm0sRPXTy7Pe=OZucA4RDEBmmgF-e_fT_tqA@mail.gmail.com>
In-Reply-To: <CAPhsuW4sac0Xzumm0sRPXTy7Pe=OZucA4RDEBmmgF-e_fT_tqA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 6 Sep 2026 16:34:10 +0800
X-Gm-Features: AcwNN1XoOy1acVE0Bgb9b5hLPKSG-7KCu4Z6bA2urq5YMyK_9dkyhEtqUcyJkjA
Message-ID: <CALOAHbCC6tAxM+CyaP-EfqvrnWmvDtY4CE7Xi7kWL9zXwskENA@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Song Liu <song@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:18=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Thu, Sep 3, 2026 at 2:27=E2=80=AFAM Petr Mladek <pmladek@suse.com> wro=
te:
> [...]
> > > > Reasoning: The livepatch B replaces everything because it wants
> > > >         to be the only installed livepatch. It sounds weird
> > > >         to "break" it by installing A in parallel later again.
> > >
> > > So, let's just not treat '0' as a special case?
> >
> > I am not sure.
> >
> > I personally think that '0' should not be special. A better solution
> > for a forced cleanup is the "replace_all" module option.
>
> If we want '0' to be special, let's make it "not replace anything".
> Then folks who prefer to have all the live patch loaded at the
> same time have an easy solution.

Perhaps we should set aside the special handling of '0' for now. We
can always add it later if real use cases emerge.

>
> > The module option would need to be implemented in the livepatch code.
> > But it will need some support in the livepatch core as well, either
> > a flag in struct klp_patch or parameter in klp_enable_patch().
> > IMHO, the flag in struct klp_patch might be more practical.
>
> What is the use case of replace_all?

With provides/obsoletes, the default behavior is 'replace all' if the
user doesn't set any IDs, because there can only be one livepatch
enabled. However, if the user explicitly sets provides and obsoletes
IDs, they are expected to understand how this feature works.
Personally, I lean towards not adding this replace_all flag.

--=20
Regards
Yafang
