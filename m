Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836533C1D7F
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268429; cv=pass; b=pWub2uBsY3XER4NOzp4E9y5aeGyj61hFW5epH1JDcBQG7nfzdaYx6gest8KwSgwr7apy+PhijH4uAEA0OV6Vm2taAUJA0LCdIzzz4JOkg8CtsOXKcuVuUT4vLVlNrq8KQS7ghUyE8RlL9aDf1/6KU4Hd8TSSNLgya7A+qb0ynlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268429; c=relaxed/simple;
	bh=IjAXkoa2oScEt51YbbIBHg8pXYHsVgq8o76+T3S43fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CepL+skae9GnPBNGdzxhB+dLgs+TewTPZpye6ctwNADOVNhYoI28OqlvaYTGCHRPCxhrRfNPDPwqGTodgZCElfUsDrSa9JfOecWTvd5VYNGWF89RHzQNZfpsHFUlsvwgdYuxoueR0wSLna1D4EnfVN4f1V1NWoi/dQMTD2MfO3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA/F0g8q; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA/F0g8q"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ed073fed0so12578907b3.0
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786268417; cv=none;
        d=google.com; s=arc-20260327;
        b=bL+G73ldcJlHkpbnuiaOIlDvLbqalg+vH4P/wnw+dr6wvgAbuehX0FnXshmvQ6cRvY
         JXJnhe3d9MXzB38htNH9NbiABxBUCEfQNajrUdpHIEagM6yrA4KlSG8yEpopvFajIv0V
         hx/sQP1LUuJzAfsrOaTudF87gPzkan2XxQs1S/C8GZRtYZ//IfUh98S7qwSe12U1l3Cm
         4e/aNumXCRekzeaLYbfA8R5pcu+RvvGYe3pT3LrH3SGtlAb9d/KnuABmgsiSEulb+CID
         7f/uR1aT692Myt+f8OitJ/ZqM6j2GNDGeOY2tS8PjmmBmIGNaaLNUjmtBSWIz49oXY8y
         zHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9KkcD4cNkJ7R3VcW+5XtLvUJk0Z7zp7MozqiVoOmiAA=;
        fh=10Ke2xGZe+25F6+lVsMRWGoyPhNRD5PjDOc9XXTatKI=;
        b=bUH5N8d3Q8JwI2CKgaYd4yPHPvDc28G1Dt/GE+vBQQCmkMz0GEkbHdjjyPmwP/51qH
         nJ33/+okeDpZavD7XzUVBZZIsD4qjzaoOPIzvIOyWYcrEI7p70Zw6e3R+dUYd7N/5yIR
         eNpq4rQrgofI6cIYOlmKHYDJ8kXv7lCkPKkrPArhVV0zQv/F5mqQAO+HxTouGKIZQVww
         TWk07qCe59BC9ylH6E+ynOYdYnHBuzSvYCA15XrhB63nxt+X25zu8jhaQ+1g5SwfWkIA
         mVl3ttVLkbmHraiXoADz3IV1di/sCF5ert7O2NzHXl9DzhVtGLuKEPp7XBcj7iZmYORp
         Usuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786268417; x=1786873217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9KkcD4cNkJ7R3VcW+5XtLvUJk0Z7zp7MozqiVoOmiAA=;
        b=fA/F0g8qur/Ixtef7Qp+gKAzJQL/yCue0CQF3DWjiBZc3u6R+MfNhPB6YqiSFjHQyo
         kBsMiBqW3z5HhirVRD/y8h/j0zlUK50kgQ2fJ71zt5yTbkvY/bPpc9wgu8ye6r8GTkEo
         Z2oxRtbbRJmvSlboeQ32bpjM+LApWhYLfjfkLeYJ0c7dM7zBLt//uVIeI2232bEX8rDz
         6d/HdHdnV2x5FlK7rR1ERUCn9pdPqcJhUtWFmdDzQVnTyBKmkwZ6aLHKsm07QovSDeD/
         M6TYxpjflNCRYRgUpbltMD5Mm/fhgUFZCZXXLtk/8YAaMpeprQG7+HBfwmqXJTMyim9p
         +D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268417; x=1786873217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KkcD4cNkJ7R3VcW+5XtLvUJk0Z7zp7MozqiVoOmiAA=;
        b=H9U7fZEFkKgrEIa/dVPqDhVrukpGUMGfgm7oixb/orJM67vXmmLqbdzjl5EoHDICLh
         aQYkiU0TmOyvU6UvLJ1bCS42vaKcN0HZBEyk2eMbelrdg9Ux43XFWreh55MTH0rmmEs7
         698YkYWUcKteP+ai1MbApudbI14eRsB3mDplSjIyg/x04J8l6RoC0V4dpqT9MWvsiqPW
         rdl/tlpA3g0PCdalkDadvbHDvcc7nfPMpuggtzahL+HYjgX+s0n0/ebzrNPs9VQxyHq+
         M60iJ36BIKAETbgLzuTGmZrOD0ruJkl7HtXIc0Imuto/5J/j8ibDAT9S/8CbNdNfg2TA
         CfKw==
X-Forwarded-Encrypted: i=1; AHgh+RorpaUghyoprChHRdPsAk+yPtTmTY95ySYD5a/eg+wSeuYqd96wO3VJKyi/yDR0v96bqMsUnbe+lsezEr0x@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJFU6JdYDvi0Kmh0f35MA2PSbvbCk1ND3FpO5yYLFpHnaXc8J
	8CsnXBHO3j2wbrZurhClJJXT2A/15GFoRtXlvtroDANfNgk9uOjR3awvyBvyZWJBiQMm0xXBmOP
	0FpMiyJWuIC3ZmCUt6TMbOBkzvjCi+Ts=
X-Gm-Gg: AR+sD10Symoqv7/QAgJpeuuh/6HykXHlYNpLQIyyuiLba3iGL+MLdsyKKydVia87dXL
	O3Wn5VLRTtwcW5y4F5Brl6omv8UIu5yOuX2CowRzgPzpp5J2zHEvVUrbQhIPn9TvccAdL9qi7Xi
	zj2trQqszl3j6kStGXAPnuz/wIV7KBkBLV38r+XjCXxrJa8q3KuDDjmtr9MBb2AOwCrUS7twXKB
	sDx2vUvINdB9oX+gueWnwFpe5QWAGSuJg2+G73bRXmzjv9qJZHdgZjywoYHyNrr7N0JVXHli70Y
	FpQ7/tn3AW31zb2T7KzZF9AcF4bydDRqPyZKiZckEi2RLOhRLnH15907joXOJsJoZMFtdEflKcz
	o+Q==
X-Received: by 2002:a05:690c:650c:b0:80c:8d09:3880 with SMTP id
 00721157ae682-8201f4a69bbmr219060497b3.15.1786268417150; Sun, 09 Aug 2026
 02:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091954.22930-1-laoar.shao@gmail.com> <20260809091954.22930-3-laoar.shao@gmail.com>
 <20260809093214.169491F000E9@smtp.kernel.org>
In-Reply-To: <20260809093214.169491F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Aug 2026 17:39:41 +0800
X-Gm-Features: AUfX_mwUPu4woBnmXuZZQ4trLTtU2ir7H6J_5FcX9RQDxlEWhKZkLdiT5BpUUpE
Message-ID: <CALOAHbB0nfrtSvV5m8DY3OBYu_6ugrJ=thtGyO+0KtVQtsTwUg@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] livepatch: Make klp_find_func() non static
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, mbenes@suse.cz, song@kernel.org, 
	joe.lawrence@redhat.com, pmladek@suse.com, jikos@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:32=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] A malformed livepatch module with a missing `old_name` triggers =
a NULL pointer dereference in `klp_find_func()`.

Invalid review issue.
This issue was already resolved by commit:

  livepatch: Fix NULL pointer dereference in klp_find_func()

https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.g=
it/commit/?h=3Dfor-7.3/trivial&id=3D1a38fd13c31ed8e7c7b598cc975ecc0f41fca46=
8

--=20
Regards
Yafang
