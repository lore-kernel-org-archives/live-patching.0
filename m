Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120F395ACF
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884772; cv=none; b=CCthPXhtSuUvdXVhjfFP3iOodX56S4SNQinh+887ITGq5Qt4qdCwTRanyuvDsHD/HMSGHWbb7yxQ3Jo/pxbrtCuXg6qKmHy+Hh9SOwXtoOA9bV5a9S+Ln6R3+QyzQXjEW2QkGegHNvPiyBycfioSw2EGkSs7FoUTP4lrk+9wi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884772; c=relaxed/simple;
	bh=OLsc5zckQtauOnlJz+CNAjia6jwAsNvSrLNm/70qjlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgZrFbUsC+wE/VJkZtir4q531Kxq6uKfaE3aExBcfe/iFa04G8UVl0CB/tFS77MQ7LB8KcOJ8vnE2FnZ5iq8DIK/hYqzPjNIZCLw2Vp0SGPpbFOYpPSE+bc1Kpaso4KyEerUxUmdPqvy7i9K4XE6aVX7+pwkARmMyXg+v1F9jKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4HcKB8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4HcKB8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA591F00A3A
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 23:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785884771;
	bh=ItgSGgnxU0DHs3r8o9XH+GWmo7vnMNxF1oP5kaOMYKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k4HcKB8s4RTVSZVt3GozMlJhk4QW2isbzYMgkd1nNfjPwuiUlQ9dZUwo73pE8Oaob
	 vzHfXxREZAvlPoimWztm2/Q+DGO1p6Dbpte+DgUKQhMpiQmzsbhB6XzKVdNVLshMNP
	 REXplcE5RLBeGgCk55KWfCofPDJyuIJbaFgd9/gUVA9hwBvzq1B7NfXL2gypkv23gs
	 HB+a2iYIx72IalsXbNrYcVL3uSfNgduO5y6B63BYWiFaX2C4ZvZajWfMvKldOdxS5c
	 4AruXo2SMf8YyCN6GLD5BPEAFSQDtS2DhJCQ2A5M7U6XBs+8h+L3/zhcR6915bLKnV
	 UHtVKrwLnvC+g==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9309d4ea213so33314885a.1
        for <live-patching@vger.kernel.org>; Tue, 04 Aug 2026 16:06:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqCXlBTlu4OyYWWVS7pjavb4jlRAFR2AnDP3sROGTObRLAO4SO3RhYWp7UhT390kUaybpQflcf1ksQQqJkc@vger.kernel.org
X-Gm-Message-State: AOJu0YwSf81s3YG1E+VYZd4ipCtrJ5gJy1+sTtvq5vo1wmHbQHv3XaAC
	wDHvHXPACs+Nk6BxK6LaBmCiI1BDQL3bO7Z0LpJVWINk8WKglz+SBNGad6ICNsviLWC6CspwzPk
	+AQ7HwISe/ld0+8+n97VueRfH0ZvF/Wk=
X-Received: by 2002:a05:620a:8bc7:b0:90f:9cde:977e with SMTP id
 af79cd13be357-93648eb85c9mr173812085a.0.1785884770424; Tue, 04 Aug 2026
 16:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804065010.44922-1-laoar.shao@gmail.com> <20260804065010.44922-4-laoar.shao@gmail.com>
In-Reply-To: <20260804065010.44922-4-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 4 Aug 2026 16:05:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ge+nbXvqZO4FhQFhUbn7Lqt3Uvn0KTC-dYr=wL73FQA@mail.gmail.com>
X-Gm-Features: AUfX_mzIQRSaYBCaN3mRMz2WBkwNbY2wwteExqpF6GA-Myhhmh-2yPX9f2skhIY
Message-ID: <CAPhsuW4ge+nbXvqZO4FhQFhUbn7Lqt3Uvn0KTC-dYr=wL73FQA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/4] livepatch: Implement replace set for scoped
 atomic replace
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:50=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
[...]
>  /*
> - * Check that the new livepatch will not break the existing system state=
s.
> - * Cumulative patches must handle all already modified states.
> - * Non-cumulative patches can touch already modified states.
> + * Refuse loading a livepatch which would want to modify a
> + * function which is already livepatched with the livepatch
> + * with another "provides".
>   */

The comment above is not really accurate. This function doesn't
really check "provides" or "obsoletes". Also, as long as the old
patch's "provides" is in the new patches "obsoletes" or "provides",
this replace is allowed (the comment doesn't mention "obsoletes". )

> +static bool klp_has_function_conflict(struct klp_patch *patch,
> +                                     struct klp_patch *old_patch)
> +{
> +       struct klp_object *obj, *old_obj;
> +       struct klp_func *func;
[...]
>
> +       # Always add provides ID to obsoletes (even if provides=3D0)
> +       # This ensures the new patch replaces old patches with the same p=
rovides ID

Do we really need th toolchain to enforce this? AFAICT, the kernel already
guranteed "provides" means "obsoletes".

Also, it will be great if we can add some basic tests for this. We are
working on some new test framework for klp-build toolchain. But we
don't have to wait for that. It is always good to add some tests for
a major feature change.

Thanks,
Song

> +       if [[ -n "$OBSOLETES" && "$OBSOLETES" !=3D "[]" ]]; then
> +               local obsoletes_clean=3D"${OBSOLETES//[\[\] ]/}"
> +               local IFS=3D','
> +               local -a obs_array=3D()
> +               local obs_id
> +               local provides_added=3D0
> +               local already_exists

[...]
