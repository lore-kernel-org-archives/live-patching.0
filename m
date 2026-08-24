Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECE3750D5
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542911; cv=pass; b=hNOQ+ASXcNoKvgHqXKyFuUdxIaUTFyIo7updA39XrLLuSoPHPwEwtTsWVEyBkuC9sn7YCHYXvhcZVaxeLbLaDG3fHDoaZDxKAjtPHQqUf0Kev83KSwTcrwpLAXiMM7LU2Q8sm6et7X4/KfLQL78Q+671bypVvVWeMPt/VWNuadU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542911; c=relaxed/simple;
	bh=myIHxxEh9pUhY3yl37rHvdYs6e4bb8/2j1/h1pmeTWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JneFCQoxhOfHtKGf/Rc52nsf+GE1eLWlZGNS1Nfm/IiAIeWHI5KgKQKlnoIkAPO09p09Gwd53rXWsEMg0EqUdj0kGDkSBIbdoVkSMCVTl1gZL8X/quv24JBowYf3sJ/55WxqgUdPMlXsVDIkePKEQ51xnk6StqAQh4/74HLqenQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEQguJ3g; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEQguJ3g"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c70f05859so4306818d50.1
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787542908; cv=none;
        d=google.com; s=arc-20260327;
        b=LzSvVPLKnCLH27kMmR174vjlz5q3YUyudhFzxgl5V7LV24COGognov1F3idZg4ZTJt
         1giDCEhpQlYb4ysbIKuD72BiBtZMvTdI2Rm1ZgP+n2j8XUhNNs/wxJcCInrBms65+8OS
         j/tlA59Y0bQAwY9xYTCihP9wE1BPfwBN4rzrs2+lEz4C91m2K5yRpBjvEtZfpLE/bTaT
         WIN2G2HhESGtpFCIBcEDspmbOSJykBOKTYc8xlokTIqxsIvmqpRc8ArD+lYSRkd0jce9
         L3k/MD15EPe9uqbZS3quimYKBsqPqbA8kz/VeKS/6wz4wp1dV464o3jzITEWwnUp8Y3t
         zXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kRZsawTsybG2N196EGa4l+XJdmtQD7c6FfZ0RhX8kZE=;
        fh=OdHVMSr86RdAB3iqRrIyOEHRpklBXua/aLwa4rH4uEg=;
        b=Z4nuEu9p8nWJ1WiJfjxy2T57psH0KovUmgoQqmyG8RqCE6KqkZKjz/pUhe23nHumEb
         LdARhncgoRV1JdUcNRsSa/jtxZYVV3Ia8eqSqXkZaihPGFefk3KwYJPM09I5F3P4odAm
         LaPu/nI7INWHBHpibi3zhXUoOR36/XxmVryMbjTfJADhe7+wwr90RaFmshJtQlKiFqOt
         FU60vVVl2U8MMMj8CKhstZvM07P4G6sDQJf5rgiLBri6PPNSmoCo1QNLSg8/6omczmQf
         3VokPQeX9f+6dY+irPkod5zL6fCQQ3Jj5sQSkp69qzbEUf5lfpev+Widxn70Hvt4UAGc
         RXfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542908; x=1788147708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRZsawTsybG2N196EGa4l+XJdmtQD7c6FfZ0RhX8kZE=;
        b=UEQguJ3gCsZeApaQfjOHkx0CoW1So81dux1Y52FBGcdXRBKXYONPVvLBYnJZsSZ67v
         fo4fAi0z+2QsHrPpao/iV/X0+4YpVdy/8Eywn2xZc2NCeyPbn0Fn/R1ozVfNDb/V4Wa/
         XsDOnUdjjOygXJzR2jgQel4W4FDyitdpiPOsNtFMPxOuyQ/y9kADEwh5I5LoiS3+EbbT
         ykdTezAU9l1GbLBj3a5T9vuywJGE68617iPrDJgn86jorGnoEkiLtSBiAWoD9kK2gXa/
         cLsftQndKPbyU+40A6Q6YCRleHaOJk8uS5Pb3Ekc4YkBKhxdt84lk39wfPgMIX3kemuG
         Aoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542908; x=1788147708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRZsawTsybG2N196EGa4l+XJdmtQD7c6FfZ0RhX8kZE=;
        b=IQvCfP5BFW7gwZfaJeGQpOO60xgxoMnwrk0s3Gbdz/TWlBOAbVjwtwkuqsQWN/4G3H
         djAUJzWZ3eGIok1NIQFgUuAq3X4PrTK9dZG7fg0TEnqrsc2QpEROXnpjl6Hpq+zOEbvW
         2FHdX75KIXlMMIhxYWo/j0kBfeowiLDT0vh0xAuCNMAYZ/5/zsPbBrj7EDU81xEdjNte
         9H9I4EsEhHGIKIDCp3HQJN79v/25g0YZF6I7WOBeMRuzzQ/lw+GUS3EDwfcKIVMB4Q6i
         jokSEilhF8tc1UTd2OtNFwN6BIapZ6s48vvgEZ0K2COTv2XiHCXhFjLrXRigwj///DMk
         GERA==
X-Gm-Message-State: AFuF++mP6dHVvvS7UmMsZs4FTtCD0lOY+DdTgwczgwKsrhvP/qDGsVwB
	Lk4Ql6IDV6Y0wfeI2zraYZbVZPIEAVIwx5ooyj6WqMYpwTwY4m5KqpTTWd4aO76cGlNMuM0F1wW
	xHHxFW2f1cq+NmVr5BlCQ0/3nHWg7/JjgEA+xhCI=
X-Gm-Gg: AR+sD12n5ia7sv0wJqBdBQi/o76ryssTYl9rW3duuXpilS3g22sxgK85PDC2nGtFrOJ
	jquNgIhp/6zll+VTQuGof98QDLirfoqIPlTtIR8medhhWkT2TSC59wI9OIczxRgb9jDksOpiSj7
	SfA+jGmx8Q+mFRppQHfMY7CdHKo7dKrqXcQBJJhqjIa4TSciMCCiP/8PtNqk67jE97Cd/OLp0Hy
	pPNTEJsvL8X6kj8ILfOt62dfAW9PEjUqiVMrzvYEVI8D0hOGEPLontD8nyMcHcFsXYOpcNE5cpO
	hHy+aR4ch6tHV/iFrjlBFGisK5kSdAmf2JSvvQl6Ovd5f3BZ5PclskujxbIiJgfTRUDMMQepZYA
	uTw==
X-Received: by 2002:a53:b3d1:0:b0:66c:e948:1d08 with SMTP id
 956f58d0204a3-66cf22495f0mr3526082d50.53.1787542908477; Sun, 23 Aug 2026
 20:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com>
In-Reply-To: <20260824032732.56686-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 24 Aug 2026 11:41:12 +0800
X-Gm-Features: AcwNN1XlerLCG7ilEDQRlFOIHVlb6AvJNm4ZC7FgNcmvEosOEq-LvBuXMclhSlM
Message-ID: <CALOAHbCBJObMPf-vQ4ZtdCCNwFNhGnfR9jP9Yeiu27D+yWPErg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] livepatch: Introduce replace set support
To: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org
Cc: live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 11:27=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> We previously proposed a BPF+livepatch method to enable rapid
> experimentation with new kernel features without interrupting production
> workloads:
>
>   https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao=
@gmail.com/
>
> In the resulting discussion, Song and Petr suggested adding a "replace se=
t"
> to support scenarios where specific livepatches can be selectively replac=
ed
> or skipped.
>
> This patchset introduces a more flexible model using two new fields in
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
> Additionally, this design deprecates the traditional non-atomic-replace
> model. Previously, setting 'replace' to 0 was the only way to keep
> certain livepatches persistent on the system, forcing developers to
> disable atomic replacement entirely. With the introduction of replace set=
,
> developers now have a selective option to keep specific livepatches
> persistent while maintaining atomic replacement capabilities elsewhere.
>
> At present, KLP state, shadow variables, and callbacks are not integrated
> with the new replace_set mechanism in this patchset. Support for these
> features is deferred until Petr's klp-state-transfer infrastructure is
> completed and merged:
>
>   https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12
>
> Future Work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Allow `provides` and `obsoletes` to be configured dynamically at
>   module load time, rather than being fixed at build time.
>
> Notes for sashiko-bot
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In your review of v5, you found the following issues:
>
> - A malformed livepatch module with a missing `old_name` triggers a NULL
>   pointer dereference in `klp_find_func()`.
>
>   This has already been addressed by commit 1a921fd13c31e
>   ("livepatch: Fix NULL pointer dereference in klp_find_func()").
>
> - When CONFIG_DEBUG_KOBJECT_RELEASE is enabled, an error during patch
>   initialization causes a use-after-free during module unload due to the
>   delayed kobject release.
>
>   This is addressed by the patch posted at
>   https://lore.kernel.org/live-patching/20260821031648.48195-1-laoar.shao=
@gmail.com/
>
> - Other review issues are addressed in this version; details in the chang=
es
>   section.

Oops.

It seems the sashiko-bot failed to apply the patch because of this change:

  https://lore.kernel.org/live-patching/20260816090442.18128-2-laoar.shao@g=
mail.com/

I based this series on that change.
I'll wait for others' reviews and then rebase it onto the livepatch
tree's for-next branch.

>
> Changes
> =3D=3D=3D=3D=3D=3D=3D
>
> v5->v6:
> - Check `--provides` argument in `klp-build (sashiko)
> - Fix the 'replace' feature detection for OOT kernel builds (sashiko)
> - Fix race condition in sysfs polling (sashiko)
>
> v5: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.sh=
ao@gmail.com

[...]

--=20
Regards
Yafang
