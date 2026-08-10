Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BE23BD17
	for <live-patching@vger.kernel.org>; Mon, 10 Aug 2026 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786332908; cv=pass; b=ooEHKcAMSd/79GYqjODTt+IwfSZXDEmmM4sl+WBKKLsNuAAOow3T4CpO9/YZkQa0/wI794JRBEiU+q+FJY8ZPbqH3gVO+mftpSMpmVHwGw939fB3yJG8Xp5Un4eH88r+U9QtmSC7NBi+sA8GFwGFKGIs+GcP67BX7DLQ9eL+J2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786332908; c=relaxed/simple;
	bh=nrDHJ3Gk92dRSWD11QS7hoO4J7V89rsy52yiVCPdPMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLq80n1hAngpXxwMzIvjQuT5VFVypmQV4A8DcUvLIH/+PYbHcoEl4MJEljqMhoUczB4zx386cC++3S3l+nVDstwWxBwBZ+E9UjvroDOMqvjdrD6sjHGVCuN2UUfEkjFsYjf8+aydhxHRniY1dgeIpEAzxtJG1ltoJMM0Ih6UEuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYCT3puL; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYCT3puL"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81f3b227a4aso20688197b3.1
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 20:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786332906; cv=none;
        d=google.com; s=arc-20260327;
        b=EmBmzv8EkT0vpP4zbrOZ0RHPH8J7glljdOJB40BrvgcyV1Y3HwVGPNr/v1ISSj/vnI
         kWpc40A9h9pRIpTUfM6RwMXMJsiRihbHDvafi4iuYJnfjk6iGCvo6Xp95Uqx4IKOMZS4
         NC/C5MlzovYfxe9XOOd5OL+Gh+BgJ0/4/kuVj1VTbq1cwJth5sEooCJ5DloMJ6JNvnda
         2ugxVlHGFmmpQMwishN0ZZQVCwZYxSsLxGCWWQD4oIOgsIQo/G0yFp/e1aKPHRoChDhn
         Plmgwe4d9/tO8c0j+10zJW6J03VGHaQ3iCyStkcA1hv8usK8VlgaKO0GUedZUQXAMv0d
         dDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/7ZreFox0bzGLpZmjmw+ippLqhhG3N3kXDUNYf9WX9c=;
        fh=EkVnCgHqBqFz6oEPiZPg5t8iBOKqUtpM1mMM0HpHj4U=;
        b=EG8qtT3zQf1ohp9C43ozJnE5q12UrwCxPZeiJKSQ4GlqMgNMmmZBpeJ72QaiW3ic0T
         SUIGQgw18ALdWFMwhZCdNq8xjahBL9cGIoPdd82mf9CeYOo2O7DYGARkBgbDu5WekIzX
         3/VPqKHsQEd6mwoQRV9wnxo5EvG6nUFBRN43ezN0bfb5N5mdbrBq+/mUhrHtxLQFmIvA
         VxrPkVdUn+Ez33LVP/4GuTRsNfOVLD046JyMAx8XiS8isp0QW3wA3q+LVhPnaLwpkHiK
         BCoYRwaCT1E82ZElb3L/aSrNMBpN3FRDfNBfkc1OO3kuOwCVwdU/oLOFGIoRy07xiYtZ
         FFow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786332906; x=1786937706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/7ZreFox0bzGLpZmjmw+ippLqhhG3N3kXDUNYf9WX9c=;
        b=gYCT3puLiPG7LFiJ+8ETBepGkhAgk2B8TNrp1cnXuFe8n2pJ/2NEmvbu9GHPNKzJgw
         poGpcL4Gk22onHyg4+j4e9+oxHWJg+dtbtOxAOKFfyIeHgsvaNfedVXE4V53fVuaYen7
         z9wfCkBqY0/OHIiy+XD1E7Chc0KB/IBSch6IXZnS8P1ckOmZEXtAQJxMwg1K9U10JUPN
         mLKT6fpHJlRlSSq2OC6oXXhXmLQK0NqglrsIsteJA6cC9AZ54in7JkCrKlyp3lXmYV4U
         IXSQAqs3pELIYcOx2U3aGEQc0UpqLHYe40nOnmHo62BypiVmfvdcPuzkw/g/XQHe8bua
         dBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786332906; x=1786937706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7ZreFox0bzGLpZmjmw+ippLqhhG3N3kXDUNYf9WX9c=;
        b=lHep5lc1kuiaLvSnCw6dmQBD3Kq8xpE8aHRkxnqHj1z4IMu4rMXngHuZ59nteYjVxh
         +lUcJwlz883stDfERJI421fxjRZDsdkVICcmGlhjDPSuHII4QKfL50CbedwM1Q9EvywI
         CY1AHmICXeBcrOmL310O3rCkm7WnXCFYFOa018iP2lKLFq+48QsxJ+ojX57Cs4bDFw7u
         SmUAuZNmsDW96fGB4pyhvLUMQqZdeKokuK7VmbGEFj75865sNssOvpaL+p+G7RtW5Piu
         gRqvQHhRhCIi157RfZg4EgcbadGAILaYhLZMul7khNK96UysXQvhLyp7bgpbFV4L3ZM+
         /pnw==
X-Forwarded-Encrypted: i=1; AHgh+RpJtG06ujZuI3bDDVG11eKZfKjgISonfdlAbe+2Qv6cvvdQZbyic90CNvNkNkgp1AEabtDCpOGBgbS089oP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UIalMxHe8NWPCkbazd5pnpLw/mCWw6eIXHUomxHhIMtOxgOi
	SM6K8jhbyPAwkBANQVq/EYQ/8ttC1MaOiNBwmnxw9oyMlrwHbg29RmPWVZf9L3v2DW74vh1egox
	HG12K4k6+0lCKubb2gY+eiAZRodpkVw8=
X-Gm-Gg: AR+sD10l1HNpfJiDQ/aKmki7276wxtg7GH8bTkzVK+68rQTKfrt64ib6DxClrwrQ7tO
	zHKKa9tmAmcjxTCpz4cSkcrebr1VzfXpOerfJE9m3f0oU3S4/nIVIB22X1JWhMmxfA8XxuaWFOa
	3a61Fbhf7ld1oAmPBlmjOneAuzpF2RJTTjIMWqsVCNW64w2bXhazsFBL9kSYMDFohi5rtFMIJLv
	QwOswbxdcR0MOQlZ6hPnBYFSNqAXOe+1ZFj0IY0UOrOLjSeF/x6TUHya9Idxei2eVkNe2uV76GI
	MZ6K6K4sfEv5nmW/eH5aehGx32DtTzrzV9Y3v0l18teXec5nkEoAbk33iDhnDWbaDgItCIP7svx
	P
X-Received: by 2002:a05:690c:b01:b0:804:a2d5:1e04 with SMTP id
 00721157ae682-82574af4157mr110216907b3.16.1786332906395; Sun, 09 Aug 2026
 20:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091954.22930-1-laoar.shao@gmail.com> <20260809091954.22930-8-laoar.shao@gmail.com>
 <20260809093147.9D9081F000E9@smtp.kernel.org>
In-Reply-To: <20260809093147.9D9081F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 10 Aug 2026 11:34:28 +0800
X-Gm-Features: AUfX_mz4L-Y04JrtYY7v3tt6DGnwuRY3dzPpYvi3YncrY_c9gKj1_aIBlj4eKCg
Message-ID: <CALOAHbDzY-hWPMd1KkSG2MyqieTQrPOoQNT=YY73ka90Cwa2+A@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] selftests: livepatch: Add provides/obsoletes test scenarios
To: sashiko-reviews@lists.linux.dev
Cc: mbenes@suse.cz, joe.lawrence@redhat.com, jpoimboe@kernel.org, 
	pmladek@suse.com, song@kernel.org, jikos@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Race condition in test-provides-obsoletes.sh leading to flaky =
test failures.
> --
>
> --- Patch [7]: [PATCH v5 7/9] selftests: livepatch: Add provides/obsolete=
s test scenarios ---
> commit b45263c641deb4b2b48bbe22a1f0bf862b20a22f
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> selftests: livepatch: Add provides/obsoletes test scenarios
>
> This commit adds test scenarios for the new provides/obsoletes mechanism =
in
> livepatching. It introduces test-provides-obsoletes.sh to verify replacem=
ent,
> coexistence, and obsolete features.
>
> > diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.=
sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > new file mode 100755
> > index 0000000000000..c740d463f556d
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> [ ... ]
> > +start_test "provides 0 replaces provides 0"
> > +
> > +load_lp $MOD_LIVEPATCH provides=3D0
> > +load_lp $MOD_ATOMIC provides=3D0
> > +
> > +mods=3D($SYSFS_KLP_DIR/*)
> > +nmods=3D${#mods[@]}
> > +if [[ "$nmods" -ne 1 ]]; then
> > +     die "Expecting one module listed, found $nmods"
> > +fi
>
> [Severity: Medium]
> Could this directory check race with the asynchronous sysfs cleanup of th=
e
> replaced patch?
>
> When load_lp returns, it polls until the new patch's sysfs transition fil=
e
> reads '0'. However, in the kernel, klp_try_complete_transition() clears
> klp_transition_patch before scheduling the asynchronous work to free repl=
aced
> patches (klp_free_replaced_patches_async).
>
> If the test checks the directory count immediately, couldn't it sporadica=
lly
> see the old patch before the async cleanup completes, causing the test to
> flake with "Expecting one module listed, found 2"?
>
> This same pattern appears in the "same provides replaces" and "obsoletes
> replaces" test cases later in this script.

Makes sense.
I will update it in the next version.

--=20
Regards
Yafang
