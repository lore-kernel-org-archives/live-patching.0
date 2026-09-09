Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEEC3C3F71
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937335; cv=pass; b=E3CKMUTwbn9R5c3cAJdabV0oeYDrc7sIjiDfZHzRG5B70gzmn9595ox16u8XsdFdVZV6LONc7oPJcaIVolmMf0n+667ZlEjy+PltTp8DlADR8E0IrQNqBVtRHq+0bxsShqBAm1tF2n3FuX9W1HaUgEGfvxos7DXcnjiXxQMWBrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937335; c=relaxed/simple;
	bh=2J+vU0dHxTEM2Vn+6tCclkeUSsHDRRGywNVKfsL5GqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjnYhmFwxdkIoVbP8f+dQ9WfwGm2l9jgp56mNNMdiOaxb00knFMT/0XvGjtGphxfB6dYEcwQZ3mkRy8bodhKtcr1FKuAcVPcNMRJm6iT1VI//Fat7EWEy0vgySchS1aRN+rl7OAcQ9AStgfA/z38iOCKTQMOh7GypmIf6iAvo8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7oUTzhu; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7oUTzhu"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8588583a7c3so56059157b3.2
        for <live-patching@vger.kernel.org>; Wed, 09 Sep 2026 00:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788937328; cv=none;
        d=google.com; s=arc-20260327;
        b=Je3WWH+PEejAV/mA6VIVpYQz1Ic1DQ9fmbA6bZ8OHRzv5NHk4Rpvmi1OFFoXt8mGts
         2ZY3+6GEZmHa3qAGVhQqAQB6J54VbeeS25B8NZiYlTrBgUHz8pB+CdjUwQXbdzFHQani
         Y10+sd5/Utif3Im08a/WO8rzbuA54cwrSgAkAN4XQQINYDX/DmSGHV9N1qKTFLkN1IdO
         xpj/opHCvtAQNMzRIQU/GkyD9pKEXETE2wD2RvcTj4maddwBaGzGFIGTe/KM3PfVrzPk
         wjvGU0F/EB59XL+3CWKg1xw3LV3hpOY/5dVwEG4mvnLsiS8RU2ixFE4vbBgvvwZxJ1Sw
         KL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtHcV2BeRJN7u2qRKVsV7oQ2/f0s7oaSuNmPDH3kCBk=;
        fh=BlE9OUzLEgnqUv1Tw4ursWyjj+Mq1GX9xjTJSpMmfTc=;
        b=nkZcEwPaSc+Js/yLYPZgvG6kscqPM6yH9m5yKAg0IgHvJmX/Bh7QpqPE4gJJGowsVA
         zcQwAFspqsRH8RJOdAT+IeMJwphu4jybMElMWptikJA4kQSZYmYnrbMpgGNhwLPaHrKS
         LUjAgJButiUt98l2omhUYuRQKTKNqKf1sxGb/SjrLLhOMJMXlVeRdEuXFu7g58CAN15W
         jOI5WF0soO3oCJ1nqADkTCNbElMYDNhz7fdIbr8jX7EN85xSsTpaZYfTJmTxKcGm73Z9
         //4s/EctSCUROZ6hTY0bj0vTX4KYD3cMygfqoPXiTswx8x12qUuEtUaItwGjjhfFbpwU
         CNsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788937328; x=1789542128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtHcV2BeRJN7u2qRKVsV7oQ2/f0s7oaSuNmPDH3kCBk=;
        b=g7oUTzhuUtMIZ1jTzrp/17aow88vPVkclmM44CdO2ibfN1YBy500J2Z4F0+AC31eLw
         o4VcW7E6F0cFptRjmzwL+OZrJwqA4Eg18f8RXTOIBVnGFO4MB1FDxRDnLF9Ysvuwl8RP
         yWLAqfBK2CAUV4QWsM15lUTscxuk5onMVxBzZkdHV3DRmoP00iW5L8/d4WlyterfUDpc
         qJzAZcBmPmo7qV1WYM4ZqLzxGrKC1yb73hGBdvMwQD5C1QQ49N/8ngt2aZa1SSxIQw6G
         neLs3CP1Mj4tLMEXgotToyHxAD9OIK6Ajju+vOKb8FIBgxYgbUCMWIKkTn3zO2UhFotV
         W6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788937328; x=1789542128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtHcV2BeRJN7u2qRKVsV7oQ2/f0s7oaSuNmPDH3kCBk=;
        b=MYcY4frca59baudbBeeawXW6TDsWa41fa+GTShPHN25Kbiak08naWB5aqtFA6qeCDG
         x1e422pIwiInAP26RwrHa62WSWFHHn8R+yXvFZKeY6KD60wnisYPopGu1opVqvfqYnw2
         THXOEghzw4wdH5fELe9GefTrL38rL1m753KJVPdTeWYyISTaRy6Zcwq63MH6wsb4pCXv
         X3SZ8U/jBjlMjonkLHNyartv9WYgW0WDo3drKXTtU3Fpy3gWQe8oDiO1tl24r+k6cFks
         +3h1z6fA87oZMEt1e0wDvT/gr+30nLzFj1JU+LDfuwU4WBb0iZ101BlFrQZ+Eke7s1+N
         lCYw==
X-Forwarded-Encrypted: i=1; AKwUvBxDKLCSYipFP52WERAdYEQCqYmWIjwf7OCxBMEizz/BDlR5ezedFD83QdiOtsB/P8NPzDjDzVQxEmERnWnO@vger.kernel.org
X-Gm-Message-State: AFuF++mzdWlV6nAaGZ0qHktrzutDj9l4OGIOY6/deUCA/f/X9clUsQyg
	7vGnxBYDi2O1l0/RzxQnny0GyqfLUEwZPta0jFnNRAu8BOFdiZxdAdqG8jJEy9PLJ03ncQnOvpo
	nMtSCFYfDU3Mki7cDS0arVNasio4bA/I=
X-Gm-Gg: AYBFou1Ic0CgHVaF6U1hmMOnu3ds0DlerbKHUG/4LQ5/NLswD9WiH32AGOihQU6fgxJ
	PpYzq8nx200TjsE9BcHEVMIOZBIOZ6uMLe8q1vReFEVbp9JzmPn2+kS0aEfsNffCK2fIm+rj95j
	hHvkIT2wY9M5Fve6CrwElKzYxl89RBv7PuYd9APP7kDDWjApuAMSFwB19M1Ovb/BCwfG9gaMWNo
	wUfo+I6VY2PnzKgSBxychsWKD4UWlGCy0v9QtlRHlv7nAjSFnDELIyD7t2fI0o7h6eila3FezAk
	7MWLJgfNoXS8yJKVRACZQfGyGBUtwfEpzwSeL7eyzAZt7zFESdY8UI16/oZXm7bWr2TecrhZXir
	pqhyejWUVqnsU
X-Received: by 2002:a05:690c:15:b0:873:5bb2:6bfd with SMTP id
 00721157ae682-8735bb26dafmr96729107b3.39.1788937328146; Wed, 09 Sep 2026
 00:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024324.16002-1-laoar.shao@gmail.com> <20260909024324.16002-10-laoar.shao@gmail.com>
 <20260909025604.14C2C1F00A3A@smtp.kernel.org>
In-Reply-To: <20260909025604.14C2C1F00A3A@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 9 Sep 2026 15:01:32 +0800
X-Gm-Features: AcwNN1VAmTZpGCZaes0KAMDlEawTsQnOVz10d90Gk4r_1ogB0jj3Jg4oDnaUcTo
Message-ID: <CALOAHbAQQ8odjtyYjGvzPF-dYT61tYgOHpW_nMuvcRxtjzeC1w@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] selftests/livepatch: Add function test for provides/obsoletes
To: sashiko-reviews@lists.linux.dev
Cc: song@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, mbenes@suse.cz, 
	jpoimboe@kernel.org, jikos@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:56=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The test fails to verify its own claim that a function is func=
tionally unpatched after an atomic replacement.
> --
>
> commit abfccb0026870ac46d37d3802586498b0874cba2
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> selftests/livepatch: Add function test for provides/obsoletes
>
> This commit adds selftest scenarios for livepatches using the provides
> and obsoletes features to ensure patches with different provides IDs do
> not modify the same function. It verifies replacement and coexistence
> behaviors for different function combinations. Tests are skipped on legac=
y
> kernels.
>
> > diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.=
sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> [ ... ]
> > +# - after the replacement /proc/meminfo is no longer patched, while
> > +#   /proc/cmdline is patched
> > +# - unload the replacing livepatch, then the replaced one
> > +
> > +start_test "different functions, atomic replace works (nops)"
> > +
> > +load_lp $MOD_MEMINFO provides=3D1
> > +
> > +grep 'live patched' /proc/meminfo > /dev/kmsg
> > +
> > +load_lp $MOD_CMDLINE provides=3D1
> > +
> > +grep 'live patched' /proc/cmdline > /dev/kmsg
> > +
> > +disable_lp $MOD_CMDLINE
>
> [Severity: Medium]
> The test documentation explicitly claims that after the replacement,
> /proc/meminfo is no longer patched while /proc/cmdline is patched.
> However, only /proc/cmdline is checked during this sequence.
>
> Should there be an additional step to grep /proc/meminfo and verify it
> is functionally unpatched before disabling the livepatch? If the atomic
> replace logic had a flaw that accidentally left /proc/meminfo patched,
> it appears this verification would be missed and the test would still pas=
s.
>

Nice catch.

I will update it with the following change

--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -545,6 +545,7 @@ grep 'live patched' /proc/meminfo > /dev/kmsg

 load_lp $MOD_CMDLINE provides=3D1

+grep 'live patched' /proc/meminfo > /dev/kmsg
 grep 'live patched' /proc/cmdline > /dev/kmsg

 disable_lp $MOD_CMDLINE

--=20
Regards
Yafang
