Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D37416D02
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918870; cv=none; b=Bcxh1DqMs748vc+dp6O4cKwa3QFLcL7149L1kGNKLegYqOGmgoDSlnTAU8EIlnehcorbv1BWAfBa39bySivfIVyfIrxI7Rm/m9oDk4UGN24dbXUJ4BIuf3w+TEwSfwNJG+n/pE220oOmZi9klHwBKddLff7sumKZ6aacGgrMOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918870; c=relaxed/simple;
	bh=usd6Og46zgL8OHwYEQAfxolvwYRP5G/TAyvCg/TextU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptYFeetrAUTg8kW86f+ocFVw8jtAyTHUa32x6ZH0k9HUOsLeTb1RkHC5Up5C3EmNuQonWY0ZGldxnkT6/NcY1XWRjTn8VBlmSrwaQUc3K8ViylxQirPFrJC78mcLd5TT3qhBq1I8U1deCnK/ck+YkWJV63YU/y9CVgieYP+d3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OnD1l4rK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OnD1l4rK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-473dc4cf238so489148f8f.3
        for <live-patching@vger.kernel.org>; Wed, 01 Jul 2026 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782918867; x=1783523667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4uOOS0i9hpZWdGU1QnLKFN1aQHTMiBN/08DuR6TYPb0=;
        b=OnD1l4rK4mZyoVxa93LfsPS4E0YOaE4GkT/euRQ0MWfe4pBifO067RaEUeOiCuWmm+
         533D4X78VpJ63v2ujCsqXFAheGavUSXfWS2YdZ3aWmvPJpWaQkyCQwknOyByDy54RAsf
         DiNrgCyNGCBVD+P/yM3KiQgq7SDinGDzCIQH5BrH0h5XlborLavNps4apouMiDbRA8G4
         jydSYYN7A2QXHVkpgylH2VWFDfU4ndk9D38AfRgUBPHim79ESYzE79bAx8DLx5Y3ubjM
         0xONr2EQ+x6u18DdKd9ww6+307x10UsXksPn5IusnKkaPpI9qCHqeFfrDLYb8uLlXqBz
         J1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918867; x=1783523667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uOOS0i9hpZWdGU1QnLKFN1aQHTMiBN/08DuR6TYPb0=;
        b=ESh1+MGDdymSW2BoSFaE3chvk1r0u4bj1iCC+pwH9kn28nUSmN+vL5FzgRH5fu4wA5
         kaKwodU0XdEhYmUopzZS+fHk6JVqjnJBvFNCfg2LmhUJ9Emk7snIM5TDXbbpUfsF0lGp
         RdYiJDZFfFM1DaDfoBOsDChMaZc/v0UMpUZX7RR34JRLOMChAL2M/7xhyo67bQbNj7eA
         cLjm3LonXKsLUCpFMR1xm5QqAlZldY+H7JC8NaMkVKTygoijESA3+OJNw4SlyAdzncOu
         JkI21FqkgGoFg/cyvuAurzU/My9RPNvz9cfu9LymX6tZy4/W+nf7j7gg5OU2prWMoJ27
         qrYw==
X-Forwarded-Encrypted: i=1; AFNElJ9f7qmRX+/KtoBlCG3D0BLU06r/O5NQ0hDbVIbV7AHFb4+Frs5anw2+EzFa+LU4w1GKeA2kF8wPq7ZCZArp@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAmFKyKzds423lpzCev8ZIvuZZdHXEsf/w9H4B86QiKtlM3TO
	zrtF6cTaarbIj85yfreOUCOjgeLaugRW08IoSpORvLrNIyBJtq8ScTOvrYCJxtO00DQfheRwWrF
	/YhzlA4M=
X-Gm-Gg: AfdE7cmfaIVsB9HUrWwqO3e2fc52CAQAfePXfjcuyudmZTOUrPNMXVfYfWobH+ofVCm
	b0P4JMVY7gVV/k1FmjljxzlyzQpEHDPVvbkBVcSaW8zp4sE/PqRhKBB1T7wRA1qS90CkR/Yuxr9
	oqn82m4uf4mXVyfiJAtXfWf0trx+BTkvwafxJNcCtgZ4jZUsKiOZqIJ+XZsFWVKVTTuC+43ddZU
	ICoWUr48IXvGjqcWjfqnqbLsF0QJPf1QrKO23ExPteHWX6kHhMx2PsfRJQb84nJjwtJQLkOz7JZ
	h1SQMXVTN4GO324Z2YwxfwnwEv+Y6rao8ZOh5+XfaJ4PDUig3fgIx3zjUX/+r537Gwiz7J9DCZj
	1GsLkws87qVmxzVK2yLXdPLlDa3IqeS7ufuXFmKJF6/murGq6ZTLtw86WCmAJLolAjgBVBCEtW7
	s4S/YcuSrBOx8cpaM=
X-Received: by 2002:a05:600c:35d0:b0:493:c3cb:409e with SMTP id 5b1f17b1804b1-493c3cb42d9mr20649135e9.15.1782918867006;
        Wed, 01 Jul 2026 08:14:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm78287565e9.9.2026.07.01.08.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:14:26 -0700 (PDT)
Date: Wed, 1 Jul 2026 17:14:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Zelin Deng <zelin.deng@linux.alibaba.com>,
	Miroslav Benes <mbenes@suse.cz>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
	mpdesouza@suse.com, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: unset sub_make_done in case top
 level Makefile be overwritten
Message-ID: <akUu0DEYrhd9cLCL@pathway.suse.cz>
References: <20260525083721.27857-1-zelin.deng@linux.alibaba.com>
 <alpine.LSU.2.21.2606191638540.26638@pobox.suse.cz>
 <ccfed9b6-9a73-4299-b305-da7b593a52fd@linux.alibaba.com>
 <akPTcJjrIAI1ZNyH@pathway.suse.cz>
 <20260630181125-a7a41726-4270-4bb7-92fe-17ec28cbe176@linutronix.de>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630181125-a7a41726-4270-4bb7-92fe-17ec28cbe176@linutronix.de>

On Tue 2026-06-30 18:12:46, Thomas Weißschuh wrote:
> Hi Zelin,
> 
> On Tue, Jun 30, 2026 at 04:32:16PM +0200, Petr Mladek wrote:
> > Added some people involved in "filechk_makefile" feature into Cc.
> > 
> > For the new people, see the whole thread at
> > https://lore.kernel.org/all/20260525083721.27857-1-zelin.deng@linux.alibaba.com/
> 
> Thanks for the report and forwarding it.
> 
> > On Sun 2026-06-21 22:36:24, Zelin Deng wrote:
> > > 
> > > 在 2026/6/19 22:42, Miroslav Benes 写道:
> > > > On Mon, 25 May 2026, Zelin Deng wrote:
> > > Here're how I reproduce the issue:
> > > 
> > > 1. pull linux-next, reset to HEAD, for example
> > > 3ce97bd3c4f18608335e709c24d6a40e7036cab8 (tag next-20260619)
> > > 
> > > 2. at linux-next tree: make all -j$(nproc) && make modules_install
> > > headers_install -j$(nproc) && make install && reboot
> > > 
> > > 3. at linux-next tree: make kselftest-all
> > > 
> > > 4. top level Makefile in linux-next has been overwritten by
> > > 
> > >     export KBUILD_OUTPUT = .
> > >     export KBUILD_EXTMOD = /home/shiyu.dzl/linux-next
> > >     export KBUILD_EXTMOD_OUTPUT = /home/shiyu.dzl/linux-next
> > >     include /home/shiyu.dzl/linux-next/Makefile
> > > 
> > > it is a stub generated by filechk_makefile.
> > 
> > It seems that "filechk_makefile" has reached mainline in v7.1-rc1,
> > see the commit c9bb03ac2c66bc5aa81b ("kbuild: reduce output spam when
> > building out of tree").
> > 
> > The commit message says:
> > 
> > <paste>
> >     The Makefile is now created even if the build is aborted due to an
> >     unclean working tree. That should not make a difference in practice.
> >  </paste>
> > 
> > It seems that is actually makes a difference in the livepatch selftest
> > case.
> > 
> > Sigh, the Makefile rules are a maze to me. It is possible that
> > we do something wrong in
> > tools/testing/selftests/livepatch/test_modules/Makefile. Namely
> > with:
> > 
> > ifneq ("$(wildcard $(KDIR))", "")
> > 	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
> > endif
> > 
> > But I see "$(MAKE) -C ..." called in many other makefiles.
> > 
> > Best Regards,
> > Petr
> > 
> > > I'm not quite sure that it could be related to my toolchain (like make
> > > version ?), I briefed analysis the root cause on my environment (KDIR
> > > '/lib/modules/7.1.0-next-20260619/build' which actually a symbol link to my
> > > kernel source -> '/home/shiyu.dzl/linux-next'):
> > > 
> > >   1. sub_make_done leaks via environment. The top-level Makefile sets export
> > > sub_make_done := 1 after its first-pass initialization.
> > >   Because it is exported, every child make process inherits it.
> > >   2. livepatch test_modules re-invokes the top-level Makefile. The call
> > > chain is: top-level Makefile → kselftest-% pattern rule →
> > >   tools/testing/selftests/ → livepatch test_modules/Makefile → $(MAKE) -C
> > > $(KDIR) modules KBUILD_EXTMOD=..., which re-enters the top-level Makefile to
> > >   build an external module.
> > >   3. The inherited sub_make_done=1 skips critical initialization. The
> > > top-level Makefile's first-pass block (ifneq ($(sub_make_done),1)) is
> > >   skipped entirely. This block is responsible for correctly parsing
> > > command-line variables and setting up KBUILD_EXTMOD-related paths.
> > >   4. Path mismatch triggers false out-of-tree detection. With the
> > > initialization skipped, srcroot and CURDIR end up with mismatched values
> > > (e.g.,
> > >   absolute vs. relative). The comparison (ifeq ($(srcroot),$(CURDIR)))
> > > fails, so building_out_of_srctree is incorrectly set to 1.
> > >   5. outputmakefile overwrites the source tree's Makefile. Because
> > > building_out_of_srctree is set, the filechk_makefile rule fires and replaces
> > > the
> > >   real top-level Makefile with a generated stub containing KBUILD_OUTPUT,
> > > KBUILD_EXTMOD, and an include directive.
> > > 
> > >   Why make -C tools/testing/selftests/ all is unaffected: it enters the
> > > selftests directory directly without ever executing the top-level Makefile
> > >   first, so sub_make_done is never exported into the environment. When
> > > livepatch test_modules later invokes $(MAKE) -C $(KDIR), the top-level
> > > Makefile
> > >   runs its full initialization normally.
> 
> Can you try this:
> 
> diff --git a/Makefile b/Makefile
> index b9c5792c79e0..f717a4dc96d6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1591,10 +1591,10 @@ tools/%: FORCE
>  
>  PHONY += kselftest
>  kselftest: headers
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> +	$(Q)unset sub_make_done; $(MAKE) -C $(srctree)/tools/testing/selftests run_tests
>  
>  kselftest-%: headers FORCE
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> +	$(Q)unset sub_make_done; $(MAKE) -C $(srctree)/tools/testing/selftests $*
>  
>  PHONY += kselftest-merge
>  kselftest-merge:

Heh, this is exactly the same change which Zelin Deng proposed as
well, see
https://lore.kernel.org/all/20260525083721.27857-1-zelin.deng@linux.alibaba.com/

> The same is done for cmd_install.

I guess that this is related to the commit 14ccc638b02f9ec ("kbuild:
cancel sub_make_done for the install target to fix DKMS"). Which
is related to the commit bcf637f54f6d2515d ("kbuild: parse C= and M=
before changing the working directory").

Honestly, it all looks like a wild magic to me. I would need much
better understanding of the Makefile maze to get on top of it.

But it seems that it is a reasonable fix after all. It solves the
original problem. It does not break my workflow. So, I tend to add:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
