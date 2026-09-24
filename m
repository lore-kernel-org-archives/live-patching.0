Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFE4D8DA2
	for <live-patching@vger.kernel.org>; Thu, 24 Sep 2026 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283410; cv=none; b=fAX6I479IqLK77EYywby4quZ9AXtEouq2YiXSHNm3p337pXCe+LMMuCr8+IjAABa9y9ZdnZYSgjigZNPqD+DNdrTF/kgdayoZfduSsdGjy2lg5373kTjWr3l2WjOxt1MU8xCK8Tez1zXsLS84xhxzXjVgjdGbG+MR1iPylnMSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283410; c=relaxed/simple;
	bh=kknudogB5BtrfaQXOM7wsfx402z3nwW6k/GLGmvVzI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK2lLTCgS4lHqQFkHOkOZTHalDHBCJUeokMQFwMP1h3lwUHNSSaE3w2/FsCq+NhClEjMPOZEvaOpCNd0xMYCYQp4ovTrahPGhej5p+jgEfuMs3shcJdoWt/l0T4Ezbi5zzk2J5bdA15xpXq8G95apYdZqzX/M9TPHBFSQd9qTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQyjmkSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQyjmkSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8351F000FF
	for <live-patching@vger.kernel.org>; Thu, 24 Sep 2026 20:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790283405;
	bh=dUtmqSN+6M/hUVMtIrsHNykAAJlU23tg25psI9q0xH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AQyjmkSZY3CiS0URW8/Thn7tUu19vYIQEAUCRVNG4dlQwYIN1mxodHAMrSAVVIQRI
	 30XPc1yNhFNHwKJW/bTALk5IAsFJU3Nscx2mc48hhaxwtt1m2biXGbGIUaPq6NS5+s
	 xD/DWas7vsbd5soHZuAKKhCPELuLWAzy8w4Nczq4CJyu3D5vBug0qzy8hPIQVHov7X
	 p3ApOawQGdCwqVyCaG+Qk5a3cyXacZ6VKf/ngpdIHn1B5UscDmppLs6QE8s63a2M+M
	 K9dkSiBVQ4ut4ehYXxDMtIsPhnYxSpVaYOYRYMR9PAir17dCjk6+LhQJ0KOx1V51bk
	 8yz6ANDpQMA4A==
Received: by mail-qv2-f29.google.com with SMTP id 6a1803df08f44-90cdfc9b6ebso2738456d6.2
        for <live-patching@vger.kernel.org>; Thu, 24 Sep 2026 13:56:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxfVYPF5o1rkAmFVQkd3vq9gViLfhr/OSPf/nirlqTPTQ5sCq/LeOEGEazdd6ji8r2q67OGMDVi0G0QGQKG@vger.kernel.org
X-Gm-Message-State: AFuF++lUWtdfo1yx6iYGvDpKIlOT/24WjLMVY4iJNa/9lp4kPL7V5/6p
	o0/YDpgFTxRSlQgTNq9kgIkWc5fk/56ymkqyTd9iikKDA5KHpoLQJqzjT6Po4pUoHGdyTv1oIPO
	kcMj/s5V/6rYGiLiWXwxlqmGxL35PQu0=
X-Received: by 2002:a05:620a:1a1d:b0:939:8373:b552 with SMTP id
 af79cd13be357-93c43b7e879mr99057985a.1.1790283404898; Thu, 24 Sep 2026
 13:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com>
In-Reply-To: <20260913024228.72317-1-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 24 Sep 2026 13:56:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5+j8ff0h1ty-vOiAWUnUOcJ0UQhUqvJRVSMrVH9WqbZA@mail.gmail.com>
X-Gm-Features: AclHuK9iVL2ga0l4sLu8kTo3svFKpE4wr8E9i_QmrBpyK3iGYDdATknOV3ywbBA
Message-ID: <CAPhsuW5+j8ff0h1ty-vOiAWUnUOcJ0UQhUqvJRVSMrVH9WqbZA@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] livepatch: Add support for scoped atomic replace
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

Do we have pending comments/changes for this set? If not, can we land this
soon, so that it can go upstream in the upcoming merge window?

Thanks,
Song

On Sat, Sep 12, 2026 at 7:43=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Atomic replacement is currently all-or-nothing: a livepatch with
> "replace" set either atomically replaces all previously installed
> livepatches, or - with "replace" disabled - it replaces none. There
> is no way to atomically replace only a selected set of livepatches
> while keeping the rest running untouched.
>
> We previously proposed a BPF+livepatch method to enable rapid
> experimentation with new kernel features without interrupting production
> workloads:
>
>   https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao=
@gmail.com/
>
> In the resulting discussion, Song and Petr suggested that it should be
> possible to selectively replace or skip individual livepatches.
>
> This patchset introduces a more flexible model using two new fields in
> struct klp_patch:
[...]
