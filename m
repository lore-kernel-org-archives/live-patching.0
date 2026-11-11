Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369543;
	b=m3kBW4vZMLmooTmOUXYTCWummcFsmfHdFPXeCgyM8/2IJYgQay6i83NeKvOdcECdRAG+
	 iFtOm/9KSl4X7kUKPKjaKL5Ng+ZTW3xxllJQrRm9uwOcFJXPqFewNdzJiq61mRzHgFsvk
	 d899JAi/O/36kbDLwaY1hobgmPZqxRhSLBdEcdnDg20xdB+tI2AviB7enpjuVEkEFpeiB
	 0miSxkZA66iM++AZoaW5Id41ALKfzNwnm2eKccoYvNPYKlRxkWX+CLVebYs9nE0JF5dHQ
	 o2Lx5YKzci8SsOgtvz7olKHm1VmYWWcQhin53W9Q7ny6Fhfe10p3/mabGX3lc2xpNEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369543;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZjXqMQ6hdZ4kwTB36gvdCoIT1cQInDYuK47u5mGhQyM=;
	b=uSIqq9K9C+byEvwz2eZ7q0zrLpC3Lrk9Hx2gcvMyal14aKqoq4J7+LYjRKF5vFwrh/kf
	 Ak5WLeoTjzd1xim+mJfQVqu0DHqjkLXcZFq5LD7BklLCt6dwaG0zAIguNRBzMMTXPc1cL
	 uejd03C2X3tNKxyOO3vohmfopUrUWntdZtAeE6BJ6SzJEetj4fxrPC95ufK37FRdhn5Eg
	 gNYufy2ZzDgCQIW5p94a2wqX1dFZcLsBTyzTHHfMjTX5O4S247CzQYFPW/0EY96WpbWpP
	 NdlnTJavv+QrhJww5No5/oWgSC1ASJz7SuBrJtewT4A5EDegbSqUx3kvyQn4t8y0rDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFHl1tC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298A606A31C
	for <live-patching@vger.kernel.org>; Wed, 11 Nov 2026 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFHl1tC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BF11F00A09
	for <live-patching@vger.kernel.org>; Wed, 11 Nov 2026 03:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369543;
	bh=ZjXqMQ6hdZ4kwTB36gvdCoIT1cQInDYuK47u5mGhQyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EFHl1tC6ueX3JKX2R3ySeYPUy01OSp6rXKtawQKXTBu94NPvJm9mZtRwQPE/LwqwY
	 sYJqDrj04Y72nFkSsHbqlx0Vq7ptabNrt904LWtsXtWEXgDJLqJJV9p5GTnBdsZ2ex
	 lehRSjT8cFj5yBfHb6sNHDAb5D/DvQ5mj7MhCbnGVmj7ruOszC3JzidQLA5jkKu+te
	 DGtADIVeIJlEMT7kKXt6YHH5ZQdG01K3Cj/Ze3HWoex5ELm6ZrGKZGaEdti8OpX/na
	 HJ0w2H/NIANei2micvB/xdnX4+C4DvTP4HpcIlTRsRcIhVYUCQNjZ7oOKOYyiU//li
	 4BPALXu3EvhxA==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f2f2edb19so224471085a.0
        for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 19:59:03 -0800 (PST)
X-Gm-Message-State: APuU4Z+j/08BMNWPNPhywGSw2LLRWB9HSciS4GEnlRFSK9wgnrS2lvXx
	l0t2AAG9y4lNO+3bFvt242zRWweq9ikzXxosfWMilodCzZI9zFJf8GxFCBsiNf8O5hupg4Y8XB0
	REzKvqmrygJPrKMeLbgfCL2a8pmv4by8=
X-Received: by 2002:a05:620a:26a5:b0:93c:c7c6:90b5 with SMTP id
 af79cd13be357-947afcd389amr174760785a.9.1794369542448; Tue, 10 Nov 2026
 19:59:02 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028214534.1919398-1-song@kernel.org> <avMR6tKwddVBrkpk@pathway.suse.cz>
In-Reply-To: <avMR6tKwddVBrkpk@pathway.suse.cz>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Nov 2026 19:58:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4Dh=QRgChcfbrTZtxCko90+o5cgzFpytBEQcHh9xd61A@mail.gmail.com>
X-Gm-Features: AclHuK8gWgOZlTHZU4sFNAsP3ftW_dWVZ6cjjSNApGFC4mxEwRvyPBBX-lKjT34
Message-ID: <CAPhsuW4Dh=QRgChcfbrTZtxCko90+o5cgzFpytBEQcHh9xd61A@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] klp-build: Fix dependent patches, add selftests
To: Petr Mladek <pmladek@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 4:45=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
[...]
> >  create mode 100755 scripts/livepatch/klp-prepare-patch
> >  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/Ma=
kefile
> >  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/fu=
nctions.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/ru=
n-tests.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-basic.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-cancelling-patches.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-independent-patches.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-line-directives.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-new-and-deleted-files.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-offset-and-fuzz.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-patch-not-applying.sh
> >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/te=
st-unsupported-files.sh
>
> I am sorry, I am overloaded and do not have time for a proper review.

No worries.

> I just see that it adds a lot of new files. And I wonder how much it
> shares with the livepatch selftests. Would it make sense to put
> it into a separate directory, e.g. tools/testing/selftests/klp-build ?

This set of tests is mostly independent to current livepatch selftests.
But in the longer term, as we add more end to end tests with klp-build,
there will be more overlap between klp-build tests, and livepatch tests.

Thanks,
Song
