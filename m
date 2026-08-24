Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9844C65B
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591148; cv=none; b=lXEvspL6T8L90wqUSi7YohRp4QeFu7kjkY1UEUFgr/toLC9DrXjFYa0z7KLRtMAS+6yu3bBXmbqptpPud/V37RdZnpryXtSHvHLAimTT4NU8Hxco2L0ig/sSVbSt4z+AdFSCGRpIN2fAQIzHjGp9CEnbgdjrmJ2ZpAmcVj9RMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591148; c=relaxed/simple;
	bh=QW138sLp080SBlamo43ij9JFe526ogVSO2PTyzAXKB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl70XqL1cjnAhkKpKqNU8dTSQHknpGD58d6XiUJcV68nQKjq75pnw1GeP52HpmKw35xa81EaBgokGmgKwh6oIao5Mjjpn7Vpak6lCpLLmlOKew0/Uit/qhWuXs0/c3zdnh15ZspocXkLgjg6svjPmnpRWtm7L0HCuZ1Y/MZoKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzNYean1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzNYean1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F6C1F00A3F
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591146;
	bh=QW138sLp080SBlamo43ij9JFe526ogVSO2PTyzAXKB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RzNYean1wwYOKKpETnkXFOkFfSKQ29cezALOnjZlNsdBVqOHJJbqrfBoK23ii/H/b
	 UY70tocRpzpSOM2bhBw32zvETmR+a1aghnbLTBx679IUfI09Ga1UY5HTr8boN5AOhp
	 vOxTBwXUIJa1Cm1zFwqR9XK3iAYQF2umuAHfFguP8qXqaD8i9gbuA0m0j8jjPIByoX
	 6aoaRxqnqFSeIGo86LG/EXf7nVsH1fhThjV+Oc2b8m93T6uqsi3lW8XM/UaN8JGUlE
	 flTCBFFcrbpEkSouWRK2GmJZbJ74hU+dq6IIKdA9tIYG7ptLg0hSfUpnSznOf2DYIz
	 j2rDCjVBiFXCw==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e512a9a6bso171493185a.2
        for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 10:05:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoOVpMFDTiHv/54xQICqjw23fqKgDG15GPTN6VL49kH4nEXjQIylQFt9FWmUPOuBYQ6q9VrUKwsIq2/VRrO@vger.kernel.org
X-Gm-Message-State: AFuF++mxfda7hJu4awLu1JAKuqHZoRZGcKJT73rtuweqmty8bmK2mY4/
	pNB6yslPjW4yDEp3AA4VOpnvPLfwKfu1Jd0uZHROPM1mJZq2CAZFve7TjovOdpI0T3qRQhoG0Vr
	6pxkbZL+I09Vpt16QKx4436o/56cQh+g=
X-Received: by 2002:a05:620a:225a:10b0:915:e670:4021 with SMTP id
 af79cd13be357-937395eebd4mr2015515185a.45.1787591146071; Mon, 24 Aug 2026
 10:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com> <20260824032732.56686-2-laoar.shao@gmail.com>
In-Reply-To: <20260824032732.56686-2-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 24 Aug 2026 10:05:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5RuNYvJOGMW-U+U8+Q6nUCqFEgNS1RfXrSYWEu1-r5Ag@mail.gmail.com>
X-Gm-Features: AcwNN1XzpOdxxp9XrNALnqGraH0ipBq5bXNiw9SYki7CzJOJCkmiJ9V1KSR6Ldc
Message-ID: <CAPhsuW5RuNYvJOGMW-U+U8+Q6nUCqFEgNS1RfXrSYWEu1-r5Ag@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] livepatch: Make klp_find_func() non static
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Make klp_find_func() non static to allow its use in other source files
> by an upcoming patch.
>
> While at it, rename the parameter @old_func to @func to better reflect
> its generic purpose.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Song Liu <song@kernel.org>
