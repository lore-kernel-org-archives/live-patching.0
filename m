Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2D34E74B
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432011; cv=none; b=Nhm8/JiCiDcvc57QXUIjONXS/2fGxeKSJExTKZrPpu7TuDFsceNoR68JwK9+Lv+XoTyo0CbuhPjNOCYmmd3fGV2b7PzIHto4+SPlYCRULkXJsITgf3q6BOFGePB8DUY/azjMAREOswHSN7IO7cNFG9b9btMzLLFrXJFFR0L++rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432011; c=relaxed/simple;
	bh=QO6n8shgNNzicDiRk9WJ8J8gvnjJThrLNn+7RqcqEGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEQMdrnLib/KKghWrxXNHRHKJiqxnSoE1kMH5aTyaKGiJR4Gh9selDrdjIpjHiDf+KwBkGlXH6qVrWTLjGm5J33M8ZsT3oC/SOdanpU6w2Mnq0YtJg2V7vnaDHrDrrTsVQ+sFZS2sNVOQDVGhwYiMc2kphqzHpfPrF0yBcYVESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S4MsdbVB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S4MsdbVB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so6815475e9.2
        for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776432008; x=1777036808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+A9VkE+t2mFDGJt22lIe27tbrI7H4mn8yKG3LHQaHZg=;
        b=S4MsdbVBR68b5TdwRtVWNpCv5fi+3F+Z4M2jvVW/PIsOZsKehkHMdek4lpV/S2n/7w
         TgUl3uaxrCYNClx5h5cgZEb2L+V5qIaZcFTpu46KlP2ssJPSAwPzTyXdRz1dvFFZjZcI
         /ssjawAC//WOA8zXtq29CcjjLB8bLYLsYPzCov0DwHBDqlamZY634J688gYgf99J95/0
         Yx2z6EYKfSXuL1I7XWCXM12ctUY/HeXuud6cuX9+KyYdE0Q7Q77WwXV5BXXkGS9yLBMw
         7QgxTZuJ+KwJWfd5LPzOB9EkI/D9qWSwn6irLqlDH1LSS8ys4BdNog6oPCL0SnYkrf+y
         1uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432008; x=1777036808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+A9VkE+t2mFDGJt22lIe27tbrI7H4mn8yKG3LHQaHZg=;
        b=mpfIN/fRUbbA143ftB3OiVbJLxlar2hEwnj5OsGQSe4zSSqoIVu8oSPlvw4fWxRnoZ
         3D2c0JoAr0r3iKFzU5lJLTbHcAej0dAuuIBR84nNgqZsi7IbBmlVXm37FBCPDJGWsEGu
         vl8hYv/vWljBPBAyagAyPXavqiAOroH/U34X1/4+/VLvkzS4tPlFVIgtiwGNHoGtknFo
         Za1U/0oK81Q+Gd3Iqz1hQwoGo7fxVlA4mQCEU0shvJwUtm7Hd8vVt5CveRBL4MCu4MFg
         9msq7bqO4FmDylAhSHpNdXVoFiHvxgq5wEl+In/ka7TXwF495GM6C71ubPcd1YJSoJ1M
         eeSA==
X-Forwarded-Encrypted: i=1; AFNElJ+5Fh3/67Jm45lmyJHLjc0KECIcUeOx+1VeXhJO55B/rfTy+tDlFdAuwtY7SAcXqLnoHg4L8+fi//A/b4W2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8C7maTacoKu7tZa8xXeeIz7nK8KCQ4H510yNIFbGuTq2NigtC
	5/LkdOfHX33FmqIM9RVv0GisRYXl0Er6SK/CbMZG0aFpuFU2RZYw2BpvPwpQpNZfTlA=
X-Gm-Gg: AeBDievX0nhGAMsxiy8aCaScIyfUYLg6P7A2LwuGMN2DuUvO0SqxcsWHXQz1m9m+INT
	08kG6c6XChw/fWMRR0v3Wq9hiLxUeO8ft1pMSfx94KC0vIRXqvLFE5W31++zQI4V97nbIbI1Axj
	pu8qhS7XB/MGyXaHs02nkmkpNtKrsAinKYHq7ufJSr/Hrz3pid2oTupAmWvVTCAPQ0iw8vaLWVJ
	M1je1QQ6orWsjMJg/XPlKP5IZvma/ZHwxdyVRlUaWFVsVwiefC+q/wMlhVHChURvpKtjWU2OM3N
	yA18nRWBpjPS6hhXIYamDeVKAPF3En0qDtnWNdR+wK/YT+xH/hn6jNk6iT4cmQlzeBtmEn7yqER
	LWnitErXlMLtShwn0U4Oo45smhHx1latLaJ2I/IUyzzG2yQY+9GNVMemZ3pguFETq7yNmF8d8ag
	JuCDtdSWPqwacdtW68hxJRElu0d9sofmBypKXN
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488fb792dd0mr43768295e9.23.1776432007872;
        Fri, 17 Apr 2026 06:20:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm56138635e9.4.2026.04.17.06.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:20:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 15:20:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH] samples/livepatch: Add BPF struct_ops integration sample
Message-ID: <aeIzhNyvYaR2Krrq@pathway.suse.cz>
References: <20260416001628.2062468-1-song@kernel.org>
 <CALOAHbDSpofLCQ-LCU2uVtkc9w+zib0PPgBr+6sEv5FD5+Hd=g@mail.gmail.com>
 <CAPhsuW5=oXwQQyOU7Hf6Qf5=tK=-J75Xr+p+dcGiPs2vVEeMFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5=oXwQQyOU7Hf6Qf5=tK=-J75Xr+p+dcGiPs2vVEeMFw@mail.gmail.com>

On Thu 2026-04-16 09:32:46, Song Liu wrote:
> On Thu, Apr 16, 2026 at 12:46 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> [...]
> > > +
> > > +static struct klp_patch patch = {
> > > +       .mod = THIS_MODULE,
> > > +       .objs = objs,
> >
> >   Nit: I suggest enabling the replace flag for this patch to align
> > with the recommended implementation.
> >
> >     .replace = true,
> 
> This is an interesting topic. To fully take advantage of the replace
> feature, we need more work on the BPF side.

IMHO, this brings a synchronization problem. I do not have practical
experience with BPF but I expect that:

   + The BPF program could be loaded only when the related bpf_struct_ops
     is registered.

   + The bpf_struct_ops is registered when the livepatch module is being
     loaded.

   + The new livepatch module would replace the older one when it
     is being loaded.

Now, we would need to load the BPF problem after the bpf_struct_ops
is registered but before the livepatch gets enabled. Otherwise,
the new livepatch would not continue working as the previous one.

Let' use the code from this patch:

static int __init livepatch_bpf_init(void)
{
	int ret;

	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
					&klp_bpf_kfunc_set);
	ret = ret ?: register_bpf_struct_ops(&bpf_klp_bpf_cmdline_ops,
					     klp_bpf_cmdline_ops);
	if (ret)
		return ret;

--->	/*
--->	 * We would need to wait here until the BPF program gets loaded.
--->	 * for the new bpf_struct_ops in this new livepatch.
--->     */
	return klp_enable_patch(&patch);
}

Or maybe, the bpf_struct_ops can be _allocated dynamically_ and
the pointer might be _passed via shadow variables_.

One problem is that shadow variables would add another overhead
and need not be suitable for hot paths.


Anyway, I think that I have similar feelings as Miroslav.
The combination of livepatches and BPF programs increases
the complexity for all involved parties: core kernel maintainers,
livepatch and BPF program authors, and system maintainers.

Do we really want to propagate it?
Is there any significant advantage in combining these two, please?
Is it significantly easier to write BPF program then a livepatch?
Is it significantly easier to update BPF programs then livepatches?

IMHO, the livepatches should allow enough flexibility. And it might
be easier to update the livepatch when needed.

Or do you install more independent livepatches as well?

Would the support of different replace tags help?
They would allow to replace only livepatches with the same tag.

Best Regards,
Petr
