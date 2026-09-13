Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2361FBC8C
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268301; cv=pass; b=VbAWXbMtgNguCimFjq+TKCGgk9C89XUo+0C5TNncE/xn+YQ1kc3P3g/Qe6PCYdvl37bKZ4Jp0Tlods2MwWGBOT+k62x+qT8nCkhjyi+1ICGdXZKwepk+oy9RbwoV9lg1ekHNmVREdVqiZ2vpfk0k83l+HyGdwbZbRDtXVDqBcV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268301; c=relaxed/simple;
	bh=5UzfQdz5mP5ZZyzhPDmxZKIk9wApiMAHPpeiQGwrQhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InT8jKDF4W/24zjUT33t9QLgG7aba6+a+prNgCM+er0hCGasSa1ocfkboiXrqUmTzlWjoDxG+VI3pyKn3Ci67n9J2h3XIT8XxZZAIk3E8dZBddAWa2jpphXV8b2xefkPhTG/VkLZki1uM1KgCkIbJUU+1P0s7HE4laG/x71W51o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/n1048N; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/n1048N"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab19127so868294d50.1
        for <live-patching@vger.kernel.org>; Sat, 12 Sep 2026 19:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789268299; cv=none;
        d=google.com; s=arc-20260327;
        b=nOqPpizg/8Xdlbo1DQEo8ty7jZZGN3ZKmYNhRgfcU8r66WEfeRkKZvKfYjd2iBStGK
         f2L2pJIbjSu/yoJyO4IQUCqyZS/e/F+nf2MJtyMzRGdgTs5WGwUiUW8JqePzf46/77G+
         lbJHl6xT5n7+TEDv5ZThARLoJLrjvR1NNIpvYbF578wRlugBVVEu4TLZ3SOHflOxCTnX
         IXag+PIqBEdUY8eesas0K6gF7RFieetNPnQSga+NvScCcUz4nAdoPlCEzZynvwQW66H7
         oV2RzT4yytpvW73UF6nehSjQWvmfxz9qhZYq01waJIc7pLAwpLRDAKQVtgOWz+GLuvSJ
         wrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+zsyyUWoZeuEsNDePtAyeDZ8FoEK0FwB3reAh1f/WA=;
        fh=+gSq395T7TiToQYruMU6tfk1Olxqq2T5uIUgfYyI/OU=;
        b=CU/YqDawmLf1RQQKpfEEjSqbFHQ/G4P32D13ppOt59cHJvt4yaL62ZD2NTbW4aBWTP
         y3OCiAmCGkf18jEvOclqHOOR+PqslsnYSVeOgmjt+yiLvADnO6M9v4AUahDyw1J2gSNU
         oee67bUHVfAqRPZhkSFJ35A8jfeq/IpqYFy7tLQCVJhuj/Qtdhhb5bGH8yCqrdadtm+C
         ysvEyXFJcuq/6jjVDhJHQ+Dl3xTAbunvUz+f49Up+rb/FAp+6Nd1Cr0kBtgavni99pn0
         dpnZjqnpsYXl7rBfgh2/YMoL16OrJaleG2axISAvceCt4U08CiOTKseWN2kiVLNgQ8D9
         io8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789268299; x=1789873099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T+zsyyUWoZeuEsNDePtAyeDZ8FoEK0FwB3reAh1f/WA=;
        b=F/n1048NznzW+gWregscpMde+OzYcJ9mY8C1YXSJ8+e5BdioYf1bmS6cqjqrpqyw8+
         oS6EE/XFrhPOrOx8EtMrqvRdZ5lI6xegnTStBycEjAyt3PXx//ZgRefCZJh6gbFRyvcN
         6w5T1ADVL50VPlT4WkMqD9QmOeT0zRac6h60CLpKcPllaJDE50/GH/5SCPA0Vj4SVYcm
         cW1a8EV5uRMqh/9vq6HGH6f1W0/oofNpkXHhpeEwq/5whDE0Zx/2QDM3So/370sbh2Wj
         RJJUG0rQb46RIs7+IYeg0+ZBssPHd9Vu1wADfH9TUG6iW4Cv+0Td5qXkxkT693r6uFwk
         PfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789268299; x=1789873099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+zsyyUWoZeuEsNDePtAyeDZ8FoEK0FwB3reAh1f/WA=;
        b=AR7wT0i5+0LH2szbSrGrG0IVIWFN+kmocrcj22s5MAdrzeVpLUZEm01QyrGFcL1fcx
         axd9hZGncdgvyTV/OKuPaBWd+sVFEvx++biQUfRYhsSnRzVYnaixVv2S6t0rle3cajG9
         ReYAsOsK8rgj8oT0ZECInH/4EEnT7zc51zDmBCvKOszCuqZGLVqwYQ5MRTXNUVTusBgU
         mZBavRP1Fg6/5MaXcLrF4u8jb8FIz89ZJ505n6yesIG5xDscJVhbjF3bymXgN2BHCmIK
         ys5+me4lYM5aHWDm+0dBx307ER8w4JmsMozgGHwlfI0Gmde4kwhDPRgI4bwtyvajkkwd
         j2ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxCrWkPKTwokEayOiqId+iA65WAeXaxkqZi4AOt9JV7ckND9n9C42EWrHD4qswdSEL30hc+f/n8oTMYQ1FB@vger.kernel.org
X-Gm-Message-State: AFuF++lygku8qyyLyjXm4V1SI3I8oueEZUOSSjPDbJzCzDpXXysuTgfj
	1ozLwWAT1WDLmUx33va2HMVO8Nc2bqJzICj/jOX6NNAk6G18eQoRjxlpjfsNZBCVyeicKWSpxe2
	kh1sF2lzmndQODC4KbLd5JjevQqNjC+qD9RQ3
X-Gm-Gg: AYBFou0ReOeihqxH3adoMOZRiE7ariqhEBSN/zw4YuJ3eDKMEXgP7dz+8ucAvp/K2hz
	9wJ8ZZyU9FIodJ5sC90WTlfxprOOfLbw9naGP9zhHEGShNlvHXZbIl0yzPtNzOBgNHWrWkPZlKg
	0VJq+AMzmlVdpbZwnP9czz+l5+YMhFYSJLunHxXcEneBhcUCY11pr5xZwcwrWU8eV58izW7mIfD
	JHAYdf6U79s4lkzk9bnzxUjqPBIQAlOWo9nOOWPY6ntQY1Avu2jyJ83ikqHt/ThTqwr8A+9FEhG
	MGIOP7ReLNFxqCgDHaD6pY6/H3Gja48mmKGV1Wr26ByvjAN8cy+qU/AD67Rfqi4IxNBn54UzSrE
	5GcsoDu/QLqEY
X-Received: by 2002:a05:690e:134b:b0:671:3eae:6dbd with SMTP id
 956f58d0204a3-6713eae70a5mr912664d50.5.1789268299098; Sat, 12 Sep 2026
 19:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-5-laoar.shao@gmail.com>
 <20260913025505.D1F501F000FF@smtp.kernel.org>
In-Reply-To: <20260913025505.D1F501F000FF@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 13 Sep 2026 10:57:42 +0800
X-Gm-Features: AcwNN1UFs_X-Jm_BMmrMmGrVOj_gJ1eaEM_SnOPMja5balftl3GALAtjTI952IQ
Message-ID: <CALOAHbAffg2hfKp0YoQ5V1rYHBqZ7nh43rLiC8k5vsr8tW_oLg@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] livepatch: Call klp_init_patch_early() earlier
To: sashiko-reviews@lists.linux.dev
Cc: song@kernel.org, jikos@kernel.org, jpoimboe@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:55=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Use-after-free on statically allocated kobjects when CONFIG_DEBU=
G_KOBJECT_RELEASE is enabled

As explained in the previous version [0], this pre-existing issue has
already been fixed by commit 7f4ca0d0b40a ("livepatch: Fix UAF of
unregistered patch kobjects"), which is in the livepatching for-next
branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching=
.git/commit/?id=3D7f4ca0d0b40ac1ccd82ebaf1514c2d26c3db71c4

[0]. https://lore.kernel.org/live-patching/CALOAHbCOFvcDy9kVVKRBAECnDi-vRcw=
h=3DdQQSC0ENeVxLYB_GQ@mail.gmail.com/T/#u

--=20
Regards
Yafang
