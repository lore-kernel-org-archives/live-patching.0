Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF440DB2D
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827759; cv=pass; b=kj/QMYVzegPKHM9+/xBsu4WN8yhDukR8RkJ0GgA+8F8pkB7Z5LZVnP9lNS2a/K9uHxJdICl6TZuJPQjWtVYD6//t9LIWpMi/hAcx+qzeBF55O8HQrepSuHKiZ1gqaQkr1vh4Ju90Zo+rp1dBcOO2R/CXqUabUsSlIy/JffJirhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827759; c=relaxed/simple;
	bh=8X1/tFmkNvucKU55SD9C0MQcuAuBHd6BgGuyErlYnmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKFbIlwDVxiVQHmd+CTw7VYKXhDuR7mXV2y6hpW7zD204hpRMHZK2d76qM4zqHCOSPtHzVw3JGBo6RKBttDzG56KobCCXlD0rDFvL6RMnTTKefjzpwnIWhXg1szBp0qiut+1RXltsFDPbQ9jSQc3TikBPKa5rc/dNzfPFuu0RaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS6nh0mY; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS6nh0mY"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ff017d420so10731487b3.0
        for <live-patching@vger.kernel.org>; Tue, 04 Aug 2026 00:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785827757; cv=none;
        d=google.com; s=arc-20260327;
        b=X1bFJAD4N0OXhOiALxP+gPiBBZlhsaAznSU5J5OkK2EEQ25MVT9C+yXav5CToU2AhF
         pxpFoO/mV3brusycuLQ1g2mIw5yfNKoDFm1eEEts7EbqOgBXxVbDf3St9vR//hVifgSp
         zl6pbOMbvX/ZA9DF+YKUSJNZP0FAB9LQ6DZDfbWlZ8gCLb7xPyKeeGEG9CD3oxUe1wIA
         joySd0WX70UB+eFFrYyDIE2xpVrDpkGldFML2KhIqYdZU/pu2qb3kGAQXQhO2HmGQYhT
         /ViXKm2t4k9kKuX1L/Ofn5G9+fwcu/95Oif8CqNkyI4ueHZ7oRQMUm8WU4URqK8dH/kX
         tMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UZdXVSYuS8SOnebG5/dNG4Br4MK+c8iN1GqhwiKB41U=;
        fh=y0EfjjJSYAC0K99RIF8xXlhIybLwUXdIxiaCL/C2f2E=;
        b=U0DEj2dqaP5qwa/rA82Mjp00ywBL3J+x48NpH2I4MaTYSSzi7TBUlUYjOZ1NRqULX+
         hSiW1AR9SnjQftmmWUG2yt1bSTY2Bkbv/vZaXBfXvgBufnsNscSch4Masa99f3a0d6kF
         f8b8HHn9bA3NuvBgAI08p/5Ar4mnKWim8R1JYuQtNBDDhUva9vzDJy5Sq70pLJY8evGa
         rbjqPuV6WSClY3KAaofpssymqG04FKdvJFzpQhja3458jQhZlNqe3t/Mcj/9oFQW3SNK
         oL3BOLGsOlyFWhbRMy8m6kxdp9nwqFKowDMDJRbj5d7cCplIrKbbw3it6Zj/iCF0wNoo
         wJyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827757; x=1786432557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UZdXVSYuS8SOnebG5/dNG4Br4MK+c8iN1GqhwiKB41U=;
        b=IS6nh0mY+xiEV+7GrelQmBmK9wnR7+OEDUdjBQ9UO7bXK+cz4dWJPgzeNHocMXyDPL
         1Axs57+o78h5cMnngfgfhcjRqs8XoLSgOUIkKRLiCuVoSE957qzZubtltiv3RsdTUY7W
         6Di01ch5Wum3ZtCWPo8+FkVjnig3MscSDJhe5nXizymJqJofeyeZatGdSsxONI3/ODuz
         NzwcI0CbFRWzbBf7umKFPvsPsisHAEyRc1gTkJ9M8Qd6JXZma73VeCK2elaBHPnQr2Nv
         LH7IFvJkK2MK885ylx5tGMM7yl1DCKo6ySkQS0ymzcv7Ow8sMQoav3Xb/WW0ilTaMSwE
         e9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827757; x=1786432557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZdXVSYuS8SOnebG5/dNG4Br4MK+c8iN1GqhwiKB41U=;
        b=bdjpSIz3KJw1f7s/SqCAg62HmGupVnQtCah+AjOzt10sptXWLF3BzodbSdjM/awQQW
         PSG2Uzxdx3kzemDjKO5ZFyInL54el149oX46FwSQHeru3ZQ9pl/9FggXO3FQO1wNAetf
         8AzgtMS90RSL+5XsXBYiqN273EEz32H+GNCiiRox097xCBn1KMgATd9Kz59uY4k/ptQQ
         VEyxgeP0ERsJdBknEgvpj4Hd04KDdlYn21DSPtil7UCX7kQY0Q+TyHtdDRMtD9XgxLTJ
         H8vTKkLf5aqE5ulESbsddhkqHsWNm3/voK3lQE2u5SpZotyQYWrltnKgVELy5YPFuBBL
         NuRA==
X-Forwarded-Encrypted: i=1; AHgh+RoKdNWevsBnX5/xG9w78wttHUXscPSjKOH8emkE8I4YsWpwtDsIxYf0i0NcKB3JETaJ6BsXJkYlMurIwONu@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNf9t0KtvPZva1nx59vuLtjxbvkTxk1hC7uzLoMjY1IaLiOXy
	RGH78eVxvsV+UFxA0cooQdFFMwy6/Zrbkx/APHbE3H4nOdiX1jINQLF2PMDxd5342frSWavgxL3
	db+pCiN26eB+X30+LMJxz3Fq3Tt3CebADeAvAwRI=
X-Gm-Gg: AR+sD11YKvTIWBGsh9XXgXRxFW/1hEfEUXpZ2TaUQ6ifsUTEONDVSzYBUuuC18Qz7ZE
	KExEP4Gx9vrOCKpPN/V9Mu6C2/E4OmFLJSGsQWyqJY2VqtLCu7AZaEuuRQ6BqMmHC0fq3VmILBy
	SrriuZkg56XaWl82ZAVCNLvBEm/LEeZ+a1sjOleaPHNBIK0A26YmnG3CtUQeKq/+J7Izpuus15n
	+cYMYDwj3OFKZxffMvKKHUgq8cXP5EomYXqCOpnnc6zSV97QXJ0jlHMltuzpuGcQ1nVdmgmixQh
	RTY7Qcb8Aii8ya7mLBdpsdfQm++2a361sncUCfm/cVLGooegFVi+JJroafVRPG9jfHttmNkczww
	wkg==
X-Received: by 2002:a05:690c:3387:b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-81fd4e786c0mr156961537b3.12.1785827756762; Tue, 04 Aug 2026
 00:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804065010.44922-1-laoar.shao@gmail.com> <20260804065010.44922-4-laoar.shao@gmail.com>
 <20260804070310.4EBB21F000E9@smtp.kernel.org>
In-Reply-To: <20260804070310.4EBB21F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 4 Aug 2026 15:15:18 +0800
X-Gm-Features: AUfX_mz0mPAcZttxPV8arJ9zHdDybvfjJB3aD6W_N_l7e8YsDdlZKGrKPkEdwkE
Message-ID: <CALOAHbDmZBahx3Qsvfs5Y-qV+CvMg7FDaXoN1bj+m+EcKd04CA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/4] livepatch: Implement replace set for scoped
 atomic replace
To: sashiko-reviews@lists.linux.dev
Cc: pmladek@suse.com, jpoimboe@kernel.org, joe.lawrence@redhat.com, 
	jikos@kernel.org, mbenes@suse.cz, song@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Dynamically allocated `funcs` arrays are leaked on KLP_OBSOLET=
ES parsing failure.
> --
>
> --- Patch [3]: [RFC PATCH v4 3/4] livepatch: Implement replace set for sc=
oped atomic replace ---
> commit d186609c1a3dbe210857d0040f657fa918504faf
> Author: Yafang Shao <laoar.shao@gmail.com>
> Subject: livepatch: Implement replace set for scoped atomic replace
>
> This commit introduces a more flexible atomic replace model for livepatch=
es
> using provides and obsoletes fields. A new patch will replace any existin=
g
> patch with a matching provides ID or any ID listed in its obsoletes array=
.
> The klp-build script and init code are updated to parse and validate thes=
e
> new fields.
>
> > diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> > --- a/scripts/livepatch/init.c
> > +++ b/scripts/livepatch/init.c
> [ ... ]
> > @@ -72,10 +73,73 @@ static int __init livepatch_mod_init(void)
> [ ... ]
> > +#ifdef KLP_OBSOLETES
> > +     /*
> > +      * Parse KLP_OBSOLETES string (format: "0,1,2" or "0" or empty)
> > +      * and convert to unsigned int array for patch->obsoletes
> > +      *
> > +      * Note: KLP_OBSOLETES is always defined and includes at least th=
e
> > +      * provides ID, ensuring the patch replaces old patches with same=
 ID.
> > +      */
> > +     {
> > +             unsigned int *obs_array;
> > +             unsigned int count =3D 1;
> > +             char *obsoletes_str;
> > +             char *token, *str;
> > +             int i =3D 0;
> > +
> > +             for (str =3D (char *)KLP_OBSOLETES; *str; str++) {
> > +                     if (*str =3D=3D ',')
> > +                             count++;
> > +             }
> > +
> > +             obsoletes_str =3D kstrdup(KLP_OBSOLETES, GFP_KERNEL);
> > +             if (!obsoletes_str) {
> > +                     ret =3D -ENOMEM;
> > +                     goto err_free_objs;
> > +             }
> > +
> > +             obs_array =3D kmalloc_array(count, sizeof(unsigned int), =
GFP_KERNEL);
> > +             if (!obs_array) {
> > +                     kfree(obsoletes_str);
> > +                     ret =3D -ENOMEM;
> > +                     goto err_free_objs;
> > +             }
> > +
> > +             str =3D obsoletes_str;
> > +             while ((token =3D strsep(&str, ",")) !=3D NULL) {
> > +                     unsigned int val;
> > +
> > +                     ret =3D kstrtouint(token, 10, &val);
> > +                     if (ret) {
> > +                             kfree(obsoletes_str);
> > +                             kfree(obs_array);
> > +                             goto err_free_objs;
> > +                     }
> > +                     obs_array[i++] =3D val;
> > +             }
>
> [Severity: Medium]
> Does this code leak the funcs arrays on error?
>
> Earlier in livepatch_mod_init(), the funcs arrays are dynamically allocat=
ed
> for each object in a loop:
>
>         funcs =3D kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_K=
ERNEL);
>         ...
>         obj->funcs =3D funcs;
>
> If KLP_OBSOLETES parsing fails during string duplication, array allocatio=
n,
> or integer conversion, the error paths jump to err_free_objs. It appears
> that the cleanup label only frees the objs array itself but leaves the
> individual obj->funcs arrays allocated:
>
> err_free_objs:
>         kfree(objs);
> err_free_patch:
>         kfree(patch);

You are right.
Furthermore, there is a pre-existing bug in the error path that should
be fixed as well:

--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -52,7 +52,7 @@ static int __init livepatch_mod_init(void)
                if (!funcs) {
                        ret =3D -ENOMEM;
                        for (int j =3D 0; j < i; j++)
-                               kfree(objs[i].funcs);
+                               kfree(objs[j].funcs);
                        goto err_free_objs;
                }

--=20
Regards
Yafang
