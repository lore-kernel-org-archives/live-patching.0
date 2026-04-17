Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B9314A86
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441159; cv=none; b=ZkQVOz9diPI7zCmUDTiPDYLZrKhw+NnnrJ1f5cOtVmsDMjb3GpUOHbVfXt99Cv6GYmidJ+LqugCfVtD2XSgpwk+5Q5fZ+hpqv19cXrhkW+wU1JgFnsE3UuDpz91QDHZK2J3Rae1OXA0cn64xjFr0lRvBNkC36GUb8HeybrDiimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441159; c=relaxed/simple;
	bh=PiA3mTLszP2wuwFh7nfl9RQZy7J3J6oQRlJkiolWoNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkNBBJi63Pvc7Yz6fI7FXtG88T0FUuNlsxXRQxrRT1vhsXT86PmtnZRCffNUmtpU7YOldKKQ6dm8918BGNijCQAc0i6O9Te8aQYWAhaMzhjNHDdO0jVflUhUj87RZknnys6u1tXXYDV0237aypKEN/LDFlXUKnH/VgNn7twkz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8RWZWxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8RWZWxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6484CC19425
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776441159;
	bh=PiA3mTLszP2wuwFh7nfl9RQZy7J3J6oQRlJkiolWoNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q8RWZWxc3IzB9WgkfbXQm+2Zm4pCvaXOU36nB2NxPKSEDTLTKqPr1IHPp+ooWOnBk
	 FmX+ir92nkRmCGOgc9xYB2p5AEavsAevzftJApo56ZlJwtQbScwIr0jZ5YomtrGma/
	 LUEEGByLueQNHCLi/7uRNMJ9PyueCAIo4l9qrlVQFTPsw5E22BzvamTcFYYtDmdsjY
	 Oe/flI8CxLlnrStdbf7Kvx1VrFcaFywd3GI5cyERw50VOV3F1zDeAcvJLFB2JfN9tE
	 yop9ppi5fCjZtzsPJ8uV+Ay//X0DaHV6ZyhTJEUJ7Vz+49+GQciZZzK1XNSxV7Zhy0
	 0N0F+whMdZokg==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso8052406d6.3
        for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 08:52:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8yfugNPIFE+E4j5mAwSrG5ylL6fiOgzQUMqOdWZYK2f/eaPwR5CAoKIsnQacCtSqVBpNDyW3SWvsqaAI3x@vger.kernel.org
X-Gm-Message-State: AOJu0YycBnu/PoWW1kKe7EVnNBCqwFp9hWuzrvJY4m/W9GCjSTE5Q6GL
	r87P+daLFLPeNPSuUS1prokOLGSpNklpdaq3wAe2lFPVeXX5dFIEWwKwcOozf6isXrc0OOM971z
	Befm2J6eBQMLTWJRpxh5+eQLH4G5VZfM=
X-Received: by 2002:a05:6214:5f82:b0:8ae:7146:603d with SMTP id
 6a1803df08f44-8b0280fc43bmr45445356d6.13.1776441158607; Fri, 17 Apr 2026
 08:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416001628.2062468-1-song@kernel.org> <CALOAHbDSpofLCQ-LCU2uVtkc9w+zib0PPgBr+6sEv5FD5+Hd=g@mail.gmail.com>
 <CAPhsuW5=oXwQQyOU7Hf6Qf5=tK=-J75Xr+p+dcGiPs2vVEeMFw@mail.gmail.com> <aeIzhNyvYaR2Krrq@pathway.suse.cz>
In-Reply-To: <aeIzhNyvYaR2Krrq@pathway.suse.cz>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Apr 2026 08:52:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Z91qAM7G=iA_APX4Jfa8a0pshnGSTYn0+JXKsUfEVqQ@mail.gmail.com>
X-Gm-Features: AQROBzB_Y82sC84m4Aso-1GIlQUzZAZ1ICzC-zH3u-nIc68ICmgCXkfMrUOdlVc
Message-ID: <CAPhsuW6Z91qAM7G=iA_APX4Jfa8a0pshnGSTYn0+JXKsUfEVqQ@mail.gmail.com>
Subject: Re: [PATCH] samples/livepatch: Add BPF struct_ops integration sample
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, joe.lawrence@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 6:20=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2026-04-16 09:32:46, Song Liu wrote:
[...]
> Let' use the code from this patch:
>
> static int __init livepatch_bpf_init(void)
> {
>         int ret;
>
>         ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                         &klp_bpf_kfunc_set);
>         ret =3D ret ?: register_bpf_struct_ops(&bpf_klp_bpf_cmdline_ops,
>                                              klp_bpf_cmdline_ops);
>         if (ret)
>                 return ret;
>
> --->    /*
> --->     * We would need to wait here until the BPF program gets loaded.
> --->     * for the new bpf_struct_ops in this new livepatch.
> --->     */
>         return klp_enable_patch(&patch);
> }

Yes, something in this direction is needed to make atomic replace work.
We have no plan to use this in production. I will let Yafang figure out
his plan.

> Or maybe, the bpf_struct_ops can be _allocated dynamically_ and
> the pointer might be _passed via shadow variables_.
>
> One problem is that shadow variables would add another overhead
> and need not be suitable for hot paths.
>
>
> Anyway, I think that I have similar feelings as Miroslav.
> The combination of livepatches and BPF programs increases
> the complexity for all involved parties: core kernel maintainers,
> livepatch and BPF program authors, and system maintainers.
>
> Do we really want to propagate it?
> Is there any significant advantage in combining these two, please?
> Is it significantly easier to write BPF program then a livepatch?
> Is it significantly easier to update BPF programs then livepatches?

Some combination like this will probably make sense for Yafang's use
cases. But I agree maybe we don't want this in the samples, because
it is indeed complicated and could be more dangerous.

Thanks,
Song

> IMHO, the livepatches should allow enough flexibility. And it might
> be easier to update the livepatch when needed.
>
> Or do you install more independent livepatches as well?
>
> Would the support of different replace tags help?
> They would allow to replace only livepatches with the same tag.
