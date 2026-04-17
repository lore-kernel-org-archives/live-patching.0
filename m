Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E02BE035
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440787; cv=none; b=UPOuowGN3nCxeCjRT96JHFIECt0qhzn50M40uPhV1x2BOX95bLSi1wBrHcv6hyB+tZ+DJzYHNozspQvcbobgG19OIXiFVbsoGxKQLEuVg9WgPcym2Njowyg8TL08UvhgZytAatr6tWp+Q4JL+o2weK1NnJa+dBOTv87Y6TiK1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440787; c=relaxed/simple;
	bh=UnNCUFWkAPoAilxFbNVEbFcc9VC0OTy4Kd82fdW9J1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tay0haZ9CTFDOgLR2KfH0qZSNYAcf4zyhMkqBA10OvQ6kaVXJ58p+LrMwyn//W1BuBd8gJdbEgAezn34SEuOavTY+3Z88R6lVQ9VgFFwd7peL0Bz9p7Y+5PG6szDuqnVWSMlXzkW159Ul+o/dQwPpEdosOSVFny6fn4K0AvWj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwkGDeS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwkGDeS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA80C4AF09
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776440786;
	bh=UnNCUFWkAPoAilxFbNVEbFcc9VC0OTy4Kd82fdW9J1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qwkGDeS/9vGwvBvjTzLIZmf6yOa2hsB1/JtF80f5Rhv6TC3Dd31fnqN2XZYB48GL9
	 A9jbpzCTrONLdRV/6QJID2tGnkqqSxtvrSnJ2xL71IqsgTbDlyXLKsbUGwfagWq0d+
	 QLohCvXKnlfFMUaqHxpj+6I16eER5QH/aFGWMYUhco9IaEuLRaUx47QwH2j35ibnkc
	 yYgdcDuCY894ppcsn36dSeAkyMIOwKs9udJipc2laTH1lluYLCAoh72+QQcfQ+Vcu+
	 nawA1uX32T29Mbw65SGrokAaSVSkktT73jsIGAhvbGgENP+z3SgorwUr+e64OiNHef
	 dTOfK/0ZLgsiw==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a032383008so7707906d6.1
        for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 08:46:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywhivv+YHoG3nFKiIOIzkgbbhH1pbdlLXEA9KbjYfUpRX2jisGl
	GtPi33U4hTgtcLF+m0XLzTcIBPtYfRMH31w6KDUOBpr+9I1a+3SeMor30GxshQzYudr45G922Ks
	cPz4K+I5wHbAvy8zw19uRC5oLfmudGrY=
X-Received: by 2002:a05:6214:2587:b0:8ac:ab13:8f0a with SMTP id
 6a1803df08f44-8b02804d2afmr54626516d6.11.1776440786034; Fri, 17 Apr 2026
 08:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416001628.2062468-1-song@kernel.org> <alpine.LSU.2.21.2604171011570.24300@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2604171011570.24300@pobox.suse.cz>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Apr 2026 08:46:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4HVpCTEis6b2g2fqJNvfewwb9-4zR9Xv_A0okzyPC8eA@mail.gmail.com>
X-Gm-Features: AQROBzAZiE_zeB2xvjUqGzpzzYg7K5RYdqtdKzwDq21uvLDclb-lvNC1jCmcbyo
Message-ID: <CAPhsuW4HVpCTEis6b2g2fqJNvfewwb9-4zR9Xv_A0okzyPC8eA@mail.gmail.com>
Subject: Re: [PATCH] samples/livepatch: Add BPF struct_ops integration sample
To: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
	joe.lawrence@redhat.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 1:13=E2=80=AFAM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> Hi,
>
> On Wed, 15 Apr 2026, Song Liu wrote:
>
> > Add a sample module that demonstrates how BPF struct_ops can work
> > together with kernel livepatch. The module livepatches
> > cmdline_proc_show() and delegates the output to a BPF struct_ops
> > callback. When no BPF program is attached, a fallback message is
> > shown; when a BPF struct_ops program is attached, it controls the
> > /proc/cmdline output via the bpf_klp_seq_write kfunc.
> >
> > This builds on the existing livepatch-sample.c pattern but shows how
> > livepatch and BPF struct_ops can be combined to make livepatched
> > behavior programmable from userspace.
> >
> > The module is built when both CONFIG_SAMPLE_LIVEPATCH and
> > CONFIG_BPF_JIT are enabled.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Interesting. It does not make me comfortable to be honest. Is this
> something we want to advertise through samples?

I can understand your concern. We don't have to add these to the
samples.

> Sashiko has comments...
> https://sashiko.dev/#/patchset/20260416001628.2062468-1-song%40kernel.org

These are valid points.

Thanks,
Song
