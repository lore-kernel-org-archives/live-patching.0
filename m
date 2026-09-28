Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1788320A14
	for <live-patching@vger.kernel.org>; Mon, 28 Sep 2026 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565076; cv=pass; b=VHy+kxj7VTtUdi5imzHQTs4seV9C9PxRNFfWb9NHZOXPsGmfskBkA1XvuddDpFqZxLDt1CUNsWSI4XBqdgSNI7S+cI26wobqOCpu4nHsj/p1GR5eCP4OSJODvioBvwZqFM0FI6i9cW3KpSdXulDJ/OoFys8un0meKDJfqEqdzys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565076; c=relaxed/simple;
	bh=9obpQrbNmc5gSC6Qdog2mNAqN+2q2wxs4ZCFYq/wssI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rei9QuNg05TGy/uRL/vzXwsIl8UtcrU96xsSsqGJeuEfHs0mNM/5D8/Z/T6b5ZJ7IFq5k4IKZGu8aWB3IZRWYsYsduCp/9h5RznMvl1xMEBzuMbJzwhgzs0PP80Z8jBNIHzfMrpYgeHWVzftdS6Fj8unVHG/a1zYVG9A7PRrfs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXUynqM1; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXUynqM1"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ecso2220358d50.2
        for <live-patching@vger.kernel.org>; Sun, 27 Sep 2026 20:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790565073; cv=none;
        d=google.com; s=arc-20260327;
        b=BbGTnB9zkjAhHrI4luPuIcCdWf+J7RKCiF60cKhxM9VgPCI98GceBB2F8qxn8MqGUT
         VLXpRVlhQFMRdqz7kIwS6+JRk2/02t7WXho97Bsg4HvIu3zaSg4f8vdNyFGhxTSXyV1O
         P5gF+WQ7T3yhSU8pu570OWmW5i/lKIoTm/8jPRNcMIxImYA0Mjbht7ZSgooEDIP7galS
         bSfx8ZSKkxYYzdE4doRrgm7fhw9gBw3JBsK1bm8v36I986T4EWNlwd2KRoEqgTICjjmZ
         HyDJ53fiFKMNtBmmE/vvcI0NvrIC+BJwMjaAmzAEjB/ot8DowUAbI8oFsvuendqiEtxM
         ki/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PAHRmDW7jtxEPeP2M/FFNm79Q6RbakqkSiEZEAa0RSI=;
        fh=cDeoGbOlAw6BR6T4dIyvwyvjrCNMJ24ow2/6rDdKBm4=;
        b=aDBn5B786dKtLyG02+c9qe62/2BZeZvVYZ6UMifLcL3vWvAhIrxqhyY/6z6k6lz/jd
         AOorgTY59nhs5ez1q5Rv8JJOV9UfrGOpgAnuIrACVozSYPbnL5rnjSNQmr76TKyB62mE
         3yQjPf1Dcb3eXOp8pMO813jzWxl3wxy0YwY37emXkpvEb7shMtot3jWWLsX9czvzeBR0
         pHXHRmSRZEULu507iapMrWzs/yxbnJ4j0WYEjdwfcDbBkEkBnXbFbDFUk0bMY7WxaXW1
         5sVBZ47flGpLFY9WhE1ncbRuDec44VW4AuYiZqXGVwfLR6ZiPABfnQriP7k3h4M2e9Dx
         9cew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790565073; x=1791169873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PAHRmDW7jtxEPeP2M/FFNm79Q6RbakqkSiEZEAa0RSI=;
        b=bXUynqM1iiiaR7O4QS+Ynt0CKOcHNlpymQmg+41cm9T8KPyaun1U8isVVvjBZFxblz
         cKGKrbGLxfKmG5k6qml1jm2oWOXsrNnzyvDp5JwKRMoDx7vDpNPXDhe/xFuiQzTZO+R9
         OkB+TzKSo+8v4uWS9OlgFDJFyoR5XOYqMC8QbicW5x8z+X6pcQngZWFB6Tu+LaQ47UaK
         XQt4i9IoPbE3GSyc/G71x57Pf5U28K2Qacb/lzJ00PFk8hieU1T1WHwogiXauBJHlgnJ
         BxksD+fNMAFVmWzEDVf9HT6tWWnswf+h+lyrN+MbqKD45uS5MFvjGdPOjEbXzDv4Qcvj
         Xj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790565073; x=1791169873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAHRmDW7jtxEPeP2M/FFNm79Q6RbakqkSiEZEAa0RSI=;
        b=JWNzhXpI+3x3l6fgzEh4BKntjmBrw5Og7O0Kj9KzdVBIcEUIERlW9ActiyKS46/tn1
         f9bI91GWP6Sqq22Tm3B+gubBIgCMHONiEVQ4GNev4JbyoO4ZQ7hib8Wm58po6UIOdSPX
         mXO7mwoTFWfUud7wTTkTIAa7EQWk5iqo0d0YtmUR2Cf6ygfKJmzKFHSyLVWM23u1j0LX
         ee9Ov/SbMK74xa2kGicflZDQi4O4Zci7W8d0CZpT2GF+pgY4uutbz5Rrfu1cpHetJ1P+
         8F47+chBO4kdFRCnap4kbn8PmRIDcibc5Q4AEuWs6I/rG/drGHocYQMwUG/McXqsKilv
         3RDg==
X-Forwarded-Encrypted: i=1; AKwUvBxw637C2+QNjLI4d3/sDqSaUtErt23s/RIdyhpjSo5T8Ocg1yoioQmpra0tRIYROFr0Ni1NLIC0xCN7ztrP@vger.kernel.org
X-Gm-Message-State: AFq9FYKQvqy7ePhWomypz7xTuKHa/5Crjc+c759+eACCCdm/XPsv7NhW
	df+F3lxzrVGSP2vYfxsaO7S9MSPpvq+ZcJXJDAak+YW0QeA8fS9u2r6A77Z23gPHZzaaO+KwX51
	Fbv17gc8PfA8OOS8KQE0nwCN4duVnQoatRPXnUDo=
X-Gm-Gg: AYBFou3a6YFc+KS/vnajmQ74nGPgq/gsQPVIHuwpAXdCZMyCJ22bJC/CudgjvVzzy85
	omF/wLT3+HF7RmZZa0wknDyXvV0d7q22X1fFi+Bua/p3cQk6PL3A44SuDIluTvo1+6onvqN6Z3u
	Gdr/piyOMVBce61pdJYHmg3PEsKvY0MwUmNjA4a5ct56f84msuWBx8D1KgvMNSXpEfrtld+N7Ci
	L3XzeKiR9ndTvULtLzuNsCT1k4ELhojl0yOFcCoYCUCIZQqJJgd0sIrp38ZLdtXPa8R9GKY+XQw
	1vCSGiINdUbISN+n8YJaUjFXvRq9jS9PjNqvv2w2km8kXSzA8JCo0wNBnc+AXtrtsRbFLJIdbZA
	rgBu7hd0mEw==
X-Received: by 2002:a05:690e:128a:b0:672:d16b:a500 with SMTP id
 956f58d0204a3-672ee65b460mr5073286d50.71.1790565073584; Sun, 27 Sep 2026
 20:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-8-laoar.shao@gmail.com>
 <179034105515.68715.14204526729868200872.b4-review@b4>
In-Reply-To: <179034105515.68715.14204526729868200872.b4-review@b4>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 28 Sep 2026 11:10:35 +0800
X-Gm-Features: AclHuK8ovWDRFOkCrJ7OeMbIRClzoQS7aGC_TwYwHYiycO31D8-C_U2hCzkb-hE
Message-ID: <CALOAHbCTOLfA1nqPsX3h-vZagS98yPJD8zMUa3HnPGxXwafOOw@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] selftests/livepatch: Add provides/obsoletes test scenarios
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:57=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> > [ ... 175 lines skipped ... ]
> > +# - load two livepatches with different provides ids that modify
> > +#   different functions and verify that they coexist
> > +# - in particular, verify that provides=3D0 does NOT replace a patch
> > +#   with a different provides id
> > +# - unload both livepatches
> > +
> > +start_test "provides 0 coexists with provides 1"
> > +
> > +load_lp $MOD_CMDLINE provides=3D0
> > +load_lp $MOD_MEMINFO provides=3D1
> > +
> > +disable_lp $MOD_CMDLINE
> > +unload_lp $MOD_CMDLINE
> > +disable_lp $MOD_MEMINFO
> > +unload_lp $MOD_MEMINFO
> > +
> > +check_result "% insmod test_modules/$MOD_CMDLINE.ko provides=3D0
> > +livepatch: enabling patch '$MOD_CMDLINE'
> > +livepatch: '$MOD_CMDLINE': initializing patching transition
> > +livepatch: '$MOD_CMDLINE': starting patching transition
> > +livepatch: '$MOD_CMDLINE': completing patching transition
> > +livepatch: '$MOD_CMDLINE': patching complete
> > +% insmod test_modules/$MOD_MEMINFO.ko provides=3D1
> > +livepatch: enabling patch '$MOD_MEMINFO'
> > +livepatch: '$MOD_MEMINFO': initializing patching transition
> > +livepatch: '$MOD_MEMINFO': starting patching transition
> > +livepatch: '$MOD_MEMINFO': completing patching transition
> > +livepatch: '$MOD_MEMINFO': patching complete
> > +% echo 0 > $SYSFS_KLP_DIR/$MOD_CMDLINE/enabled
> > +livepatch: '$MOD_CMDLINE': initializing unpatching transition
> > +livepatch: '$MOD_CMDLINE': starting unpatching transition
> > +livepatch: '$MOD_CMDLINE': completing unpatching transition
> > +livepatch: '$MOD_CMDLINE': unpatching complete
> > +% rmmod $MOD_CMDLINE
> > +% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
> > +livepatch: '$MOD_MEMINFO': initializing unpatching transition
> > +livepatch: '$MOD_MEMINFO': starting unpatching transition
> > +livepatch: '$MOD_MEMINFO': completing unpatching transition
> > +livepatch: '$MOD_MEMINFO': unpatching complete
> > +% rmmod $MOD_MEMINFO"
>
> The verification step is missing. The following unloading steps kind of
> verify it but it is not the same.

I will update it.

--=20
Regards
Yafang
