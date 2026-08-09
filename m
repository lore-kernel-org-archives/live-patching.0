Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3892FD69D
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268745; cv=pass; b=cGUMdaSR8HwFQV3z2Rdl0nAIza55YNiAFfLE3boIeNXPlMd+a9Sicml4W8yaayx61HQ/3wYvbqqtpIF3CrU2Hn3RfER6+MewJUVls/b13wUqwr8cvNuKJZWEBBSnhJmDc6l2K8O8QVw17Gc0yL7z897dBDGRtbG1JkYhk7bd36w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268745; c=relaxed/simple;
	bh=5xSDC0oLtI68eWY5ijMf/yPYW7jiPMqykDc3qllVndM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCX7Vt7NAdJeiv0GMoukZwZlI6Wp1FjuhlIS48d2fpurGwRsYBYJkJFUuXxI/xjEHPsKk+RIJTMIMpMqsA8I4Q93jiSi49SLWtcYBou42GPIyPqPN5cPUecUW95sBioW1z3Gif1QU/7xGNvfWREVpudBsVwi7AbI2cbAPmf5Q3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNMwm39f; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNMwm39f"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8201447e8cdso15954637b3.3
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786268743; cv=none;
        d=google.com; s=arc-20260327;
        b=DpCHoOfa3a4lKbRaJjsEvcWTsoC13wnRNF8q9iJmBxPzqEMn8bSM/oiIFwZrqCGBQu
         beZyg4a305ArHud6WMxlduiqpPvJQGLSZclRrrlV4GpkJ+tZaJSLHbQz53YEOvXoBgA1
         embZZPzP5j743HzgblgM0NBiMZD9/MxHl3TCVY90rHBOdeZIUiMk0hqlGbIkbIJdVXN5
         ZCrxQR0m+9akuH25/qHGo8H85F882GC2rvuI8nCXO6kisegZb9jz3G0ejrz3thA3uIcI
         thZMHe3eEyQWZg82RbYg+0siyyvhbLzHEKQO02Oi1fKrjKc+xZqMK6b7v1dnQpgt47J6
         EjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lBbxh2phVxoMYMLBkCkqrZYLjL0mF4xtsl2HTtRI7dA=;
        fh=e/MankfUb7L910NHPCFKVtZYtEVRVPw3MGxS36rtV8s=;
        b=kVspbkyYlJ3gB1Z9MWYzfk3pUgZwVT2x2iuH6dfBEWHZqmh7DzTuTwXYs+TIS+iTj9
         ubGldlWHBNCsnUFH8LJ+9W71mL5JzE0kYEkQbU6P/JsGsUbUk1rlUnzWJ5OPXhoJXlJB
         vMnmV/AHfUYRoNy7gbxIov+hiWOkTGaev65KyC5q1MSYiJ+hEoz9yoY0erGJMG87d/kx
         X12iCTev4O/eKMb6qdLWrOxQwAus61d0akA9a3rf0m8UeUEy7NmJ+d8kbYzkYABFdgja
         nIgsYBW21lgEoApCpf9UiYwLeZ0KoFfljR3gCjuII27mmoT7bDV8EfN4An+3815AN4zd
         NTSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786268743; x=1786873543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBbxh2phVxoMYMLBkCkqrZYLjL0mF4xtsl2HTtRI7dA=;
        b=iNMwm39fSSwS1gRA+hKCHm41dDD7yJYDPUFd4hSSR/1ZDXDYCh/tvgmAMRkcjYgsr4
         OCGNUDyub2UpXrXIhu/NZAQqJWpMFpfThdbFaZ4mgXjm0l1O7EOeRdYa8YLdaN2ieHCk
         XtybTPGWDq3Kxo7WdO/r58+g1T673ded2mR/EeMOBL15mI2iRPHtPVdc/Y4DcbLEOTAe
         LlXH1DFdjUjrVHp2T/eB+W4KTQw7ydL3W6qV7mox+eh21uRSNAKq9MRy5fWtFUPhbZYU
         IP3C96FpDKJ+I1hqLdbfzZlIuw9mQXM7dJZo4P6aMbVv6s6Xt4F7ZRPdva6de36x6tXq
         Z9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268743; x=1786873543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBbxh2phVxoMYMLBkCkqrZYLjL0mF4xtsl2HTtRI7dA=;
        b=mqFqLzZJhDFHR3FWfot0Mc3fqd04qOvUPH6CIj4VNqavYnUcLkraEGGR6ABsTz1wEN
         O98MQMi5AwV3kMMkjRQd+wYhR78cM+tb1bpTNulz3zRlDENju3NBG8quB5OoVdHUvPWl
         Av8ngtnoYYp/bZuK6RoGKtZ2E/D0C1Ad85bQJCGo4NO20X9KxwOw6R7gg0sxs/asyeJR
         rMeJXw0zfg2ziEx0VEQSNis37JwQNhZBs68C2rLhLTr+7j3aZHLvFEf7VJ1q7TFlhWq8
         pHJfg1h6p01rHRDd/q/BHx23OqI4fCvXqoqbujKlHa9ixEVqQcJryX3FIMtM4I2AG7z3
         JocQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/hUyiOb5hKOgARhgqQ641wnTQaaz0CaB858A5ThcHlLUqb3r7zNh3XH8nXSc41rzpO3EL1H/IQABPOuLU@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmtwL7CLmOyfGdDTzhugTyItcHP/HzBGruSg7lpnVJIFJXtIP
	Q3Eof05dxVk2ijgntY7a6ajKwGBLmrECg0+u5KBFPuzfwnBwcFQJuvMDRz7Za8NwmzPlzH35uPi
	utuZbGXxmKjoOU9j8JrEvnEz8/CvBueM=
X-Gm-Gg: AR+sD12Hf8nH1LBsO7sjDASt65DwetFlkt1f5iXbJKqosUXvLmBoUp2ffBx5KtMCiEc
	enOHVkb0kL2r0dAAsVox3LJg/6Q6fuJ2us1n+ypCcX2kitYsIGUaQFl35mvdAbjmUHoWYyONyZV
	HFC7QEwJSgstSQy2Xvyj+y5zNaVZYbN5Va3xEF2EfBCcz9t9E3xHVvfNS/WhA1L+fLOD16pg0i4
	Lf2HzLJ+vUvX9geSVQVpinS920tqmZ/EQNOUxcn1JxcAXOmbPEWr6dEbsLmvEylU3oA8cWh3Ta9
	Nf8ycmoe0hbSiPj51LvefxMkyNAA9vpwJVAK/KptxD/N8DOrb71Tqs7AzIO82Mboe54lD/c+nKB
	Q/A==
X-Received: by 2002:a05:690c:7247:b0:81e:4aa9:d025 with SMTP id
 00721157ae682-8201bc8540bmr220966037b3.6.1786268743301; Sun, 09 Aug 2026
 02:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091954.22930-1-laoar.shao@gmail.com> <20260809091954.22930-7-laoar.shao@gmail.com>
 <20260809093321.D25BB1F000E9@smtp.kernel.org>
In-Reply-To: <20260809093321.D25BB1F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Aug 2026 17:45:07 +0800
X-Gm-Features: AUfX_mz9q_u1iOlQ--x8wWTRrHUl6egTQn9VU3RYTDCYrZpWWIK2oIFcZD0WLdI
Message-ID: <CALOAHbBe=1W8pyWJ6evZFmeUeLevxgy39CecKHrpU2LifUK8EA@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] selftests: livepatch: Adapt atomic replace tests
 to provides/obsoletes
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, pmladek@suse.com, mbenes@suse.cz, song@kernel.org, 
	jikos@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The 'replace' feature detection in test_modules/Makefile fails=
 for out-of-tree (O=3D) kernel builds, breaking tests on older kernels.
> --
>
> --- Patch [6]: [PATCH v5 6/9] selftests: livepatch: Adapt atomic replace =
tests to provides/obsoletes ---
> commit e4d15e9f2792340ea543b405f9d074e729665c9b
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> selftests: livepatch: Adapt atomic replace tests to provides/obsoletes
>
> The legacy "replace" field in struct klp_patch was replaced by the
> provides/obsoletes mechanism. This commit adapts selftests to build and
> run on both old and new kernels by detecting the presence of the
> "replace" field.
>
> > diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/=
tools/testing/selftests/livepatch/test_modules/Makefile
> > index a13d398585dcb..29c55df360467 100644
> > --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> > +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> > @@ -16,6 +16,16 @@ obj-m +=3D test_klp_atomic_replace.o \
> >       test_klp_state3.o \
> >       test_klp_syscall.o
> >
> > +# The legacy "replace" field was replaced by provides/obsoletes. When =
the
> > +# kernel (KDIR) still supports "replace", pass KLP_HAS_REPLACE to the
> > +# modules so that they can #ifdef the legacy "replace" code. Otherwise
> > +# the modules are built with the provides/obsoletes based code (to be
> > +# added later).
> > +KLP_HAS_REPLACE :=3D $(shell grep -q 'bool replace' $(KDIR)/include/li=
nux/livepatch.h 2>/dev/null && echo y)
>
> [Severity: Medium]
> Will this grep fail for out-of-tree (O=3D...) kernel builds?
>
> If $(KDIR) points to the build directory rather than the source directory=
,
> $(KDIR)/include/linux/livepatch.h might not exist.
>
> When tests are run, detect_replace_attr() will still correctly identify t=
he
> replace sysfs attribute on the running kernel and set HAS_REPLACE_ATTR=3D=
1.
>
> However, since the module would be compiled without KLP_HAS_REPLACE, it l=
acks
> the replace module parameter. When the test scripts attempt to load the m=
odule
> with replace=3D1, insmod will fail, causing the test suite to abort.

I believe this case is invalid. We always run `make run_tests` to
execute the full livepatch selftests, which ensures all kernel modules
are rebuilt against the running kernel.

--=20
Regards
Yafang
