Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8138331B
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607705; cv=none; b=ftWq7Yq1aAInh5aMIGx6Kmx1o5ObE/FQlUH/3xJkYKh9HRMli6xtN2aIal+Aah+3m+0ABYxFrucBIiuf8X1VmQIiHzXesNyuUap8vF1Slq8tQ+fgpO2fFhekWMZbkmSiKizqxsMHHuP4y/EESXAN0MYfNlOSTtfioXygQEOAp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607705; c=relaxed/simple;
	bh=hmdB8eLN8uytfMbStM44Xqo5kGeZ6j0bNV3WVA6K9u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMqb6iSjQdzi2ThncWEVLwtmgdxUcj3qdT68f5yRbl3n6G2mJLqYsJ1itytbIEIlo0piQ+/YFdMyfrNEFzawXllqiN8mYkzEpHAThp+fQWAyesQGCf1iqi8fY8aSqG3BA5nxwpGFZQ2N31wcWXXRY7voZSiFV1wxzVLVgmuobL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxOUSQhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxOUSQhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA401F00A3A
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787607704;
	bh=oxESZmQ/GN/o5Psr6dT5QLLKW7lVDhAHx6BhR5Qpf+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JxOUSQhFoPZAO7i0Uo944N02DKBIf3hqqfLofjNVngjhJu3akj1zGMx7cJ3pkRMNf
	 Fni3zVnBW42B2RgUX8HVwaoh1jo0W2MMHfx3AO5Gv+jLAxdi7JeG+zurW8rnOKrOgt
	 ybt8Pfyv0L9sT9pwh5pfOMvI+ZZE/XMFPBW86gUPujPY+QRTd3nYlb77eOXD2QsecG
	 Pj5je/CJDK3V2H0i2tKUqXOEm2Gaq3fIimtppKpyqqAQz/7oZddGyIsa1N9/M1cPRk
	 0YjXZWjpr1Mtrzd8z4tLybrf7MGOMA2ZOFCs2w+wvvu+worGYrXn7SbmN6x5WZr1FA
	 R1pMohtVukTfg==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e85499ffbso313580385a.0
        for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 14:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpGuH3d1q77Shtmn9np8Qj3dHwFIG/P2zA0jrVIvVvsEzMneOpgfpAdSow5bJjBeecBhxAckE6Jda2WH16p@vger.kernel.org
X-Gm-Message-State: AFuF++mH5B1EHPNzXKiwXoiE62P8XAJRwk9KVjyuWbI4A/V4FO7Tp8FQ
	pCw9kYvqM4Gzn2de/rWYDgkb4onjFoKUwHDOLuBU+oHl2RHRVBb1/Oa7ItrbShjQuDHLePj/P/t
	ptNrTSTTgox17cM4aADIaY5J+FO5CmtM=
X-Received: by 2002:a05:620a:480c:b0:932:ddff:123d with SMTP id
 af79cd13be357-9376fa72fdamr249878385a.29.1787607703641; Mon, 24 Aug 2026
 14:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com> <20260824032732.56686-4-laoar.shao@gmail.com>
In-Reply-To: <20260824032732.56686-4-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 24 Aug 2026 14:41:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6HP0x9rFZDXffP6k5LgYDp=8VkjCTTqXYAiJrVQiVCHQ@mail.gmail.com>
X-Gm-Features: AcwNN1XK1M0Pp6Ys952IbR7sG_-CNuwUvUpH5hisBd1G47MZWFvfHkGKnLYEP38
Message-ID: <CAPhsuW6HP0x9rFZDXffP6k5LgYDp=8VkjCTTqXYAiJrVQiVCHQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] livepatch: Implement replace set for scoped atomic replace
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
>
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
>
> - provides: an unsigned int id identifying the patch replace set.
>   By default (provides=3D0), any livepatch replaces any other livepatch.
>
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different replace sets.
>
> A new livepatch atomically replaces any existing livepatch whose
> provides id matches either:
>   1. The new patch provides id (same replace set), or
>   2. Any id in the new patch obsoletes list
>
> The klp-build script is updated with -p/--provides and -r/--obsoletes
> options. The obsoletes list automatically includes the provides id
> and deduplicates entries. Input validation rejects malformed values
> at build time.
>
> Two helper functions are introduced:
> - klp_patch_replaceable(): checks if an old patch should be replaced
>   by a new patch.
> - klp_has_function_conflict(): rejects loading a livepatch that would
>   modify a function already patched by a livepatch with a different
>   provides id.
>
> Suggested-by: Song Liu <song@kernel.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Looks good to me. Thanks for working on this.

Acked-by: Song Liu <song@kernel.org>

With a few nitpicks below:

[...]

> +/*
> + * Check if old_patch should be replaced by new_patch:
> + * 1. Same provides ID
> + * 2. Old provides ID is in new patch's obsoletes list
> + */
> +bool klp_patch_replaceable(struct klp_patch *old_patch, struct klp_patch=
 *new_patch)

I think "replaceable" is not the accurate name here. It sounds like
"can replace", but the actually logic is "will replace". Maybe we can
just call it "klp_patch_replaces", and switch the order of the two
parameter. IOW, it will be

bool klp_patch_replaces(struct klp_patch *new_patch, struct klp_patch
*old_patch).

And it reads new_patch replaces old_patch.

[...]

>
> -REPLACE=3D1
> +PROVIDES=3D0
> +OBSOLETES=3D""
>  SHORT_CIRCUIT=3D0
>  JOBS=3D"$(getconf _NPROCESSORS_ONLN)"
>  shopt -o xtrace | grep -q 'on' && XTRACE=3D1
> @@ -132,7 +133,8 @@ Options:
>     -f, --show-first-changed    Show address of first changed instruction
>     -j, --jobs=3D<jobs>           Build jobs to run simultaneously [defau=
lt: $JOBS]
>     -o, --output=3D<file.ko>      Output file [default: livepatch-<patch-=
name>.ko]
> -       --no-replace            Disable livepatch atomic replace
> +   -p, --provides=3D<id>         Set the provides id for this livepatch
> +   -r, --obsoletes=3D<ids>       Set the obsoletes ids array (e.g., "[0,=
1,2]")

Do we really need the bracket "[]" here? "--obsoletes=3D1,2,3" looks more
natural to me.

Thanks,
Song

[...]
