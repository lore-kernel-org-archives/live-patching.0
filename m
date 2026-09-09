Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2152AD37
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925535; cv=pass; b=lKIc2kAqlMLhIhBdogr5AdGMYq3WRO7G3ZyyG6AyzolaIkFz9bz7cj98V1aCzFlwuhWMhSv+6PXThkczdK2bga/hsINXofcrrLabn7SOsZiCpyrV0vTjjyggL4y1vH8sfbzvTs/c3zFT26eE00rvXSxIEPbT/fZa/nnD5TFD5Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925535; c=relaxed/simple;
	bh=IXNmuepENNR4tE9HqqYaDhxsSc1n6zibwfYbLVTCyO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqROGNneEgy5PZoTQfb98md/FGHgClQS+/R85aNLL2vtK5qG0DazGk6HByHBdTUHdk2ycvw2dIgrraZ1UKuwZTwjM6jYXkI+Rv+xtWHpku0elxLo7/E/BaN3qBWEG3dzDWweZQuauF8v+mbcmuLTc4TXSZG552dLUJKljmz5XIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj3zYOht; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj3zYOht"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-866e57f63a3so61524997b3.3
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 20:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788925533; cv=none;
        d=google.com; s=arc-20260327;
        b=axFieOWK/FB51gRoLyyyhOZWq3pivC3ce6Kl3tkGjsEC7N8JVHMSs9eHaDVst+jiE6
         axq+3xdbj6N9QGokkKOKj4quB3DunrTVHR9KUktxCWbPp1YKxvV/w1aiI2CUeRfqP1j/
         WVN8DPRCavQe0XdEmZcorlAd9e/3dpRiGW3rVBvB1lqUsKiX53B4jLk3rqfvXI7NMiwh
         R4jY7ODPgct+ci/9IZTMrpY11EllhS+BpENnE+AzL8eO0Ozota07u235pbJa4m7ZjBgB
         UNuaKSlbNAicE4UkvIZLo8l+Obaz1BqKe8DbyZ4N9sSCWY9jcD/DSxtwlYwA08Wvkg+K
         VHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZn/g/PqABJQU3OOPezBemcwd84aUSRVAJ6HUBRncq0=;
        fh=6+V4CxQ5lKzA1GpJ6T54rLsObYVeqilE7cBDufSSWHA=;
        b=V1wvbeYczfAi+4k/xP89e2WJQfBJJ4P0N8KprpSJBw14d4w9vZdNnjmTwf97HIWzsf
         4J/CzOQFhWYsExk2FykQws5zuAKYBCOz9xAw131DRswhgLrJEzjY+6Gd/GbtVsm5mFwr
         K/5Kq250nzX5FB5aj3A2wc/VKKoVC4b0+khn6rvRbTrujg1keTvol/2yq1A5qJjKEAcH
         dxm33zLIcwhxjTyDutK7A32UXATU/op6gWt/xcg+il7t8B85t7gS6ZU9l3ZyJ83/vTDN
         nn2XcBYBDbc9HqreXHUDQL8XPEpOuFTtNNGbYoxhHfHT00FQ49DoOvhQD5tq/E69uTzu
         gqiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788925533; x=1789530333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hZn/g/PqABJQU3OOPezBemcwd84aUSRVAJ6HUBRncq0=;
        b=Vj3zYOhtQckg995b+vxDrugWiG/JZwhgsvEyVbTZ2KcaOCqc2gokNduJ3A9tO6+BkC
         2CsIc/URn31YNDDxzgaumTzOYv6CMAepKa9tUXCDhakZm03vBT7xVIdt4MZ1GuC/JMOM
         d2iadWsYwu4w4iwWw7N81fRNqDimWsdsVQ7why3COi2q8TercN2PIylrH0o5M/ILQWNX
         3P03SVAiFPiS9uJWSeJ60NdofMkhmTGR6p4BgnVHJF3iUT/g3QjeBIZKlBrV8Gn4yQGr
         jCv6RcLn2xOKBw7SE1EJjeqgsjW+j/Ct4F/RPp67L0qyO2L2tnInn7I1ElrDqH0CBDOf
         eVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788925533; x=1789530333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZn/g/PqABJQU3OOPezBemcwd84aUSRVAJ6HUBRncq0=;
        b=pY0hyqH/toYrEFg2tZtKRxQefUUFgdiX4cMlD6kWmruCCAF27qmT4KMKcKE7OtPU5s
         2B9va6Aov8Kn1JlTSj8OOSP2FP7x8S1UTkAWafaJJQ30Z9vv0sQSoy9CPLY1k3nR5P1Z
         vO+aNllO93QQoRuwD5xk/+4tmXLJOoEUMdy9yB5h3PjezNPIBQ9hmmEsIPoj8eaS10gF
         /zmt+R1TkQyvZ9dhA2Jw3TcG5edOQlALrUchSLmtjOccbMhpQx34vUmHWRvs5Ne4SkZz
         ocD0r5UJYSu2OgdUQG+fxWQumDBR+zf2UvRqBCYFWKuihcq2OWgOAZKmEN3mZ00gAJp6
         EBjw==
X-Forwarded-Encrypted: i=1; AKwUvBwF+JEGPNwbq4popZgETlqz3lVwZtWz69j/tydoVACDevFoKmnAxvFrkaG6g2PhWCNX3JypdlkzBspG+MwN@vger.kernel.org
X-Gm-Message-State: AFuF++mjDP71S9GUaBaezUt6QWTkyBwiybxCqOeCq3Y+eZdzCnn2NlCQ
	p+L/kQt+bnmqpSji558dK3dkSQQUAR5EXu4ld/60unBB7Cgi51w5sYoL6C+bvV2jXcFEJloOLnH
	tu0QcTWh/kb3J4a3atsIFtFmXJV8rF2k=
X-Gm-Gg: AYBFou0Lzxie072WPFE5V8j7q9tFrzS4eIITX8wc/1QpGpQRLiY0x5UNrA3L1IpE/T0
	clelWQMs65V/GYYSy4QdSaT/iifsCBYNFpSZAhtJXmAEBc4JuCr0zD6P+qUCNsFTg7p6j0nru/2
	Z9bkYUtUfH/ONgxEJ1GPj3M9MIOBtdj6FmcCXwh1rn7NNc5LRvE7EaRp8rEnOAJVZl7gR4LxOZX
	jy9x+NgQ3V8p5o2x2NJJYSAGQkoOA5uzA1lEr5OOvIzpdlCPGAZaFPqwHsaJTqBaT4smkaA5UdS
	B8uuhW2lNuO/kBCkEm+Sn0swnEKi9FmB4y+4rn1NHsGFgiFabJZ5t3GUt9jUZMnAYCvF3iFTtHC
	ZD22MxlPjr2Ix
X-Received: by 2002:a05:690c:a1ce:b0:873:5ddf:d879 with SMTP id
 00721157ae682-8735ddfda51mr71341387b3.68.1788925533074; Tue, 08 Sep 2026
 20:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024324.16002-1-laoar.shao@gmail.com> <20260909024324.16002-5-laoar.shao@gmail.com>
 <20260909025625.110F31F00A3A@smtp.kernel.org>
In-Reply-To: <20260909025625.110F31F00A3A@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 9 Sep 2026 11:44:55 +0800
X-Gm-Features: AcwNN1VwiwpG2WQP02MARWQxkcNbYWqZelwY3kpV9fIJSd5ESRPFeD9J7Iz66Yk
Message-ID: <CALOAHbCOFvcDy9kVVKRBAECnDi-vRcwh=dQQSC0ENeVxLYB_GQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] livepatch: Call klp_init_patch_early() earlier
To: sashiko-reviews@lists.linux.dev
Cc: jikos@kernel.org, joe.lawrence@redhat.com, song@kernel.org, mbenes@suse.cz, 
	jpoimboe@kernel.org, pmladek@suse.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:56=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Fatal UAF / Kernel Panic on module unload due to unparented kobj=
ects triggering delayed work in freed memory.

This has already been fixed by commit 7f4ca0d0b40a ("livepatch: Fix
UAF of unregistered patch kobjects"), which is in the livepatching
for-next branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching=
.git/commit/?id=3D7f4ca0d0b40ac1ccd82ebaf1514c2d26c3db71c4

It seems sashiko-bot's review was not generated against the
livepatching for-next branch.

--=20
Regards
Yafang
