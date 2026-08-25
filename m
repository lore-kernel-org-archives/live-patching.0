Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6B31DDBF
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624922; cv=pass; b=nvCtriWiR9gJ1CwKspT19yfWtv4pBc43H9iHfQ7Gwj+JAqNJzXs/h3mMG5PVZbqPL6DVxy5S8kIQc45m7WXpqcx0tFAhEIsJOITbss9NcwegamXNc3cCGxUec7DqUIAF2M0BOyjhubSc9LVbr74HhqwhWWm5Wf0pxtVRE6FikxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624922; c=relaxed/simple;
	bh=DXAAfml3njkeokMyWU6UFyqtWFF33x7HPH6ttAt1SPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZcUPgrerwWQkXmimO0iD6/ViGhTjjKFK7d6BHxaRsubSLrU8W2CX72wzHd3tGvtKk17pRk+l+4OjIv34f28nG3jkk97Q1rJMcxWtbEl0hfvV4S4tVYmxW/oX9oev9ijzJL95XeFsqAf2fqy34n2DsWqeUDTj+uUzNAV87QSF0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9+ge2hH; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9+ge2hH"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c8bde2dcso61284097b3.0
        for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 19:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787624920; cv=none;
        d=google.com; s=arc-20260327;
        b=Sd0veymZwUHnd9fPbXVjBEdl/EQ466BHkhZwo8dGW8NJ0MoChFEsEaGOH/LTNXTUJF
         hCf4wDhLjsbpPws+tF1O5J32OLYUiXtFM0KGedPzzou0hDPmjXL9j2w8nSBMk89yDhg+
         WFyCCsHWJgNw+mW/X3YhCtE6GKtazDWPcGpmosZlOgMAV5xA7dsZxRnpblfNN0b1sESo
         eIkzirRtuYKxC9DgsE4oVgPOZrIzYLrVQjNYLpox4ain0Arfg2np5uRT2EUWJtNc73jc
         EoHslbhg77UKuCjP2dJt7MvjUVl2vkyOd92L9Vzrj0Wh4DJ2Nx2aV2nlJZ3SNxG8eyOA
         7RWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+jPzs1d9elk0QN/Nwdm4RH1UzswqpIZjOUi3PNcBv5s=;
        fh=jWyD3mUyRUVifRqbDsemSDC7dbhZF20UpdPBP5URuok=;
        b=WNIuWzZciEkVqD/ek9UFM4Ls7tKABXIV18eFuPQcyzUpa1B3IaxTXq4gN5ddM33iqp
         wGeSEXZwePrEIDGMieB/nca8b9YXHa+/6OdK1gDQF1HTKzgLgRdnm811TZni44q60/AU
         jpd+6I5nunqvn/iWksPt+c6TY2tt8PCoN3TCFERu3wy3EqFuCPX8d2ikhRw0qrDdA38Z
         fqo9j/8O1C3cZvupur50cNDmBKXBJ2ip0jJeSDHHHnMJw+eaYvbbokqln/rA6Gh0XdMf
         HBvuhy9Z4JuyTXe/t2PUxIExdjv0lvjEOMJks5j+9xNs0p4efPAkMZjBK4xbGcGt6UXY
         2vOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787624920; x=1788229720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+jPzs1d9elk0QN/Nwdm4RH1UzswqpIZjOUi3PNcBv5s=;
        b=p9+ge2hHebPaccymUqr7f+FaVZWbs3XjQbBuVLOJIU9UTHXe1q3k1ivgG3GEBW4JjI
         WmjgXGSgucHl/TxiDvEQ4Gft8YhGL/bX3RxFPWvJxLoK61IAQgA7qeepIitHntyf2dRd
         kJWxzE4vEWtFiYvKkbnZFU5G1yVkTNpzj69Z4l6saHjA+W4EYFDHU6T858zl+RMhYsx8
         lGDhjNGUIf4A6l29bEgvo7IL0vs1tbqpGa/fqBhpaC06rLXvRStpRIQtuTHyZ4nqjaq9
         WUq5dMHZFwjGtzZb4rHxZlzXM/hhBNxpaUAt1X/TtQSaJ45UOHtOF9kLoGbXCY8N4TFm
         JBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787624920; x=1788229720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jPzs1d9elk0QN/Nwdm4RH1UzswqpIZjOUi3PNcBv5s=;
        b=HNNgDNw+cp9abWOq6aEqI+sHw4c9A3enKnk3RHo5JKe6LIfdY2kS8A1wQ9sJk1dxzk
         CfP1DiJ/J/vkBGIk88aT0QVxgAQEyxzai1lNjtRdCANamsFzMZBRgn2szSc0ECTli9q/
         Xr7vpWVilOLBHRfFd/sz5xxNnDf5MNqJyPGEg4Pk0vmb8Esn/X/XIAfoNPtu8ohnb7hU
         bvyAW0wrPUVU2Ef5/jbJCkZErTQDfasOBdQkYAKRlaPsJtcuEkm5/6ahVlVgomGWtiFE
         wM+mSsAmLiOYJ63FWOxlyBwXpLPoZwe2AINy9eOlIcKTRolLS7gsxR7AFuA6ry00nnm/
         8EPw==
X-Forwarded-Encrypted: i=1; AHgh+RoyBGF8PlAYJo+oF2acV7OxZGYLD01NLZTVySVP57ADcbtFd+qZnn3YN7SDkAIXLMV20id2LlVxZiUsMxnN@vger.kernel.org
X-Gm-Message-State: AFuF++niiEVa2nThYc6NFX8eib1cCTSqk3F3IW2ZDcGsLdkGtUndEUx+
	zlibXU4VS35GUUrpamK7MH1AtB4hn+KPgP0w9qJ15uMIaMKhzEJOfEe0g8RHLjw5qMYUDUuSXvM
	KJxQ+IvyLqzvuFzgqYHA1KodX6/lzsl4=
X-Gm-Gg: AR+sD111ELWb+tzOtehZ0KEQbH66Cj8jOKMGrdY7NUHfjjeHgd6wHat3fnukggjwRJy
	gU3wYulcB4RISNPRTCEF1Tkl23o37UP0V/GfOz6zOZ+4PZ+lTh38AWR3THUqsQ+ddqE83X+6cIR
	C7PURBvmokFzKZ5oQ9vLAFzrn1Z4qcwn8NESSTcsyVOWmhL3STODDuj8MWGlcU7k95baZJFE/AC
	oK5rPXhlYxVHP3v9nQaTxjrDFdXNFFLPnkH7ppFEfc3J7c9xNH0W19PBhUrgEEzZkGE0Gj6BAqs
	7kMxbBnnK5+mwzY3cQguxbpgutvQ9UwVdm86w2O12JVB62DXJ+1qn90M4JCGZFJttL1rLf3Auaf
	Riw==
X-Received: by 2002:a05:690c:6e8c:b0:854:4f31:61ee with SMTP id
 00721157ae682-8544f316e27mr22028177b3.2.1787624920032; Mon, 24 Aug 2026
 19:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com> <20260824032732.56686-4-laoar.shao@gmail.com>
 <CAPhsuW6HP0x9rFZDXffP6k5LgYDp=8VkjCTTqXYAiJrVQiVCHQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6HP0x9rFZDXffP6k5LgYDp=8VkjCTTqXYAiJrVQiVCHQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 25 Aug 2026 10:28:03 +0800
X-Gm-Features: AcwNN1Wf-KqQpLNk2R_P2SAOvUxQG5Kt0xKtGd27bwlFiIO0tx0Wo5ZEDBFUL-Y
Message-ID: <CALOAHbCHhYMASaY+qS+R2cJJuoZqsBr-AGbKNwKDtRS_xUkJ_Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] livepatch: Implement replace set for scoped atomic replace
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:41=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Aug 23, 2026 at 8:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > The current bool replace flag is too coarse: it is either all or
> > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > livepatches, which is safe but inflexible. There is no way to have
> > multiple independent livepatch sets coexist on the same system.
> >
> > Replace it with a more flexible model using two new fields in
> > struct klp_patch:
> >
> > - provides: an unsigned int id identifying the patch replace set.
> >   By default (provides=3D0), any livepatch replaces any other livepatch=
.
> >
> > - obsoletes: an optional array of unsigned int ids specifying
> >   additional provides ids to be replaced. This allows a new patch
> >   to explicitly obsolete patches from different replace sets.
> >
> > A new livepatch atomically replaces any existing livepatch whose
> > provides id matches either:
> >   1. The new patch provides id (same replace set), or
> >   2. Any id in the new patch obsoletes list
> >
> > The klp-build script is updated with -p/--provides and -r/--obsoletes
> > options. The obsoletes list automatically includes the provides id
> > and deduplicates entries. Input validation rejects malformed values
> > at build time.
> >
> > Two helper functions are introduced:
> > - klp_patch_replaceable(): checks if an old patch should be replaced
> >   by a new patch.
> > - klp_has_function_conflict(): rejects loading a livepatch that would
> >   modify a function already patched by a livepatch with a different
> >   provides id.
> >
> > Suggested-by: Song Liu <song@kernel.org>
> > Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Co-developed-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Looks good to me. Thanks for working on this.
>
> Acked-by: Song Liu <song@kernel.org>
>
> With a few nitpicks below:
>
> [...]
>
> > +/*
> > + * Check if old_patch should be replaced by new_patch:
> > + * 1. Same provides ID
> > + * 2. Old provides ID is in new patch's obsoletes list
> > + */
> > +bool klp_patch_replaceable(struct klp_patch *old_patch, struct klp_pat=
ch *new_patch)
>
> I think "replaceable" is not the accurate name here. It sounds like
> "can replace", but the actually logic is "will replace". Maybe we can
> just call it "klp_patch_replaces", and switch the order of the two
> parameter. IOW, it will be
>
> bool klp_patch_replaces(struct klp_patch *new_patch, struct klp_patch
> *old_patch).
>
> And it reads new_patch replaces old_patch.

I will update it.

>
> [...]
>
> >
> > -REPLACE=3D1
> > +PROVIDES=3D0
> > +OBSOLETES=3D""
> >  SHORT_CIRCUIT=3D0
> >  JOBS=3D"$(getconf _NPROCESSORS_ONLN)"
> >  shopt -o xtrace | grep -q 'on' && XTRACE=3D1
> > @@ -132,7 +133,8 @@ Options:
> >     -f, --show-first-changed    Show address of first changed instructi=
on
> >     -j, --jobs=3D<jobs>           Build jobs to run simultaneously [def=
ault: $JOBS]
> >     -o, --output=3D<file.ko>      Output file [default: livepatch-<patc=
h-name>.ko]
> > -       --no-replace            Disable livepatch atomic replace
> > +   -p, --provides=3D<id>         Set the provides id for this livepatc=
h
> > +   -r, --obsoletes=3D<ids>       Set the obsoletes ids array (e.g., "[=
0,1,2]")
>
> Do we really need the bracket "[]" here? "--obsoletes=3D1,2,3" looks more
> natural to me.

I will change it.

Thanks for your review.

--=20
Regards
Yafang
