Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA446EC69
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591348; cv=none; b=t4pe7/BXfiXVzfOGs+qzRYhuhvvQ5p8+DQ+Yd5lBiiJvTdAOr45o0RIwnYfdHp7FlSaW/oWXKGY2lDxFsnPh7Er8JHa3qFhY4SxcVZlKEZJ2pNYZG1AzpZ+SV3vezWMgQKkgo7+9Yr76c1tKNd9pKAgGjzHJ4Vl9kvDVNWiEEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591348; c=relaxed/simple;
	bh=d2jvJpUbuIzerS2ErXZiA6xu5KfEPJb91uIeR3Hg9Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8GRVc9zOr9YmOvirYFLmztps6/65Pfz+JKzxNk/4VCNkmkD/mKMWHQ89OrTNC3f/rXcKtJTEKJS4FaeLQI5xDqYYKUvV5p5i0zq9M5ORsVxAqDsufIV79y/jUnZAZHb4NQASTsOS8yJaMYrZVAXX6nbV0DuPyEKj2iDj1DxDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5mlIKLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5mlIKLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A571F00A3A
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591347;
	bh=jzxjoHald0ICLYkD9VneKIOPX4Ju9D33E/f9wLR7FY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A5mlIKLolsmVhISRgQfNNR9J3/OWN0kGVRdWA3EB3cmRFY21XChSr+4Fgx7R9GwMn
	 9Y4C6Ab2+/R048M6DCvBCjSzlCqImoOjKlDJugKeKBCQ9p87A+92Eq/ib+OWF27DNE
	 BHml02Sry7o2bZ7fSl/47Y9bRJCMOwtobP79uiYKpZlK8mSyc6bH6/1vqBEHkWMxpt
	 Weparvk4cxO1K+2Z6N4Mz4yelsDsGIbPncrjKy5FHTbzYSmYGxt46xtAo24D5rwXtv
	 I8GUK7boeqVXoQTNj456sYURcaUXljH9aDtOC92xgPEwv0GXBi4mGB7SiB7+wOrDu8
	 M8i9MrpQqPqUQ==
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2868000b3a.2
        for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 10:09:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq2IOGCUHa3Kan3qlC5GpC/KDRwWbGBc/mgdAhxQdCA1P6QJBOXer+QgB8jE3RVKMmcuXXmu1IFJkzcQjBy@vger.kernel.org
X-Gm-Message-State: AFuF++k3Uw2V3ULBeEccXCUWm583T5SIBOo8u89/uTqM4NPfkVZBPUcU
	RxUanmtPAoQatAWqAwoA9GhkE9ToTnlgrlIm6XmHVgC9i0+WR01BnK47iKBCkUi7pZo7WYS+t4Y
	gZkxyt9ZDHBG0/fCOU/wPLnR9rnXeVew=
X-Received: by 2002:a05:6a20:938c:b0:3c3:9c4e:de3a with SMTP id
 adf61e73a8af0-3cd2febd396mr48541509637.6.1787591346894; Mon, 24 Aug 2026
 10:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com> <CALOAHbCBJObMPf-vQ4ZtdCCNwFNhGnfR9jP9Yeiu27D+yWPErg@mail.gmail.com>
In-Reply-To: <CALOAHbCBJObMPf-vQ4ZtdCCNwFNhGnfR9jP9Yeiu27D+yWPErg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 24 Aug 2026 10:08:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Y42JG5ADTa=KmyC3ojO5HF_D5W6Eb0B1oAjzY_7VouA@mail.gmail.com>
X-Gm-Features: AcwNN1VRaDp00kltm_G1zeOl7dJQAbfKK0ZCEDwTD3-eSQgJ5LylQtKf7XyCc5o
Message-ID: <CAPhsuW7Y42JG5ADTa=KmyC3ojO5HF_D5W6Eb0B1oAjzY_7VouA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] livepatch: Introduce replace set support
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:41=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
[...]
> >
> >   This is addressed by the patch posted at
> >   https://lore.kernel.org/live-patching/20260821031648.48195-1-laoar.sh=
ao@gmail.com/
> >
> > - Other review issues are addressed in this version; details in the cha=
nges
> >   section.
>
> Oops.
>
> It seems the sashiko-bot failed to apply the patch because of this change=
:
>
>   https://lore.kernel.org/live-patching/20260816090442.18128-2-laoar.shao=
@gmail.com/
>
> I based this series on that change.
> I'll wait for others' reviews and then rebase it onto the livepatch
> tree's for-next branch.

Please go ahead and send v7. Full review from sashiko-bot can help human
reviewers.

Thanks,
Song
