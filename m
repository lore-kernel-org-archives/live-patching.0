Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B340A953
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429692; cv=none; b=jtgbzOO/F8RR46SbP3jQ1JwrXBRAlQDhd1JNemVOfARo7nyP+/ZriXrHR4HI/mGOiUmqnmBZWa+kCiUKC5CDiUHTnxy7yQbMG3s1SEahDODcbyk4F/wzwTtgntCT3qgB44Wj2Z+HXGqXOQ/fMAU5MArp5Ysh46sNqEbhJ8zFN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429692; c=relaxed/simple;
	bh=uwF6htSJF9erDtYWcfFPBCptePp7Y9GrvrMK/taj0So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od1YcJrvD8H2CBWz+iGd2gh7E1TlucmxhHBseA6/mmO6wJk2lDAbzD32NPDUeDSLJ6tAQq1/bVMoAjgW/pJRElMQffeUNX7AwJvMhtkxp36l1kCMYe2jMlZ5Bpc6l8NZ1CabbQsaZR178Rtubr7GLbZsgLydwWJbsg0IezO9I98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cGlMd+32; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cGlMd+32"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso15814315e9.0
        for <live-patching@vger.kernel.org>; Thu, 03 Sep 2026 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788429689; x=1789034489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XhxsB9Y4lyNkVz2GbygsjuQAPyv2x2eZNWEH4wFI/g=;
        b=cGlMd+32Ks1PbJgX5L0F1EGdtcdCqvZvd7ltdRovSV51pA+Ha8WVfAGHz3Oyjji/oW
         VFIwTVg2AH4QKbM+UpyAt0JDhnrDzChHe2Lz+bNtYcBV+GHM4QZZ8Dt1a8GehOljJ2Lk
         IfGqAUM6qY+dnUUaQHIlap6Z2C9nvvTm5chP/y18TWeqZSG4i15Ox8dWrPQzCd5W3Sll
         9lN6dnCadNZdh2FQ1C+pPh7Soy2dhWj2TQx4R2N7XYDXrlBkEhkpPpBlvvqWmzlG9Vw8
         oizeEwa37oDCWCmg4Ir5GsPgE8VPQDLzcH+8EeRoJGBaARZkRP0kWxpQ6sMqcJdz9KlZ
         nnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788429689; x=1789034489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0XhxsB9Y4lyNkVz2GbygsjuQAPyv2x2eZNWEH4wFI/g=;
        b=OMSTW1eSpw0wF6mT13IPAeB52/lx3Gsx378fNWRQWp0ftoHw+yfMArourYepliE7fB
         luvvQ5CxWfb20/3Nvn2T7xDyDpwHWwZjSFNLSwAVWdyE9CMocQh5Octz0jLigdEDJ4V0
         vuKv7Gl+DLN7lM4HG+63DBXBBTYsY69ZBvN338IEpCG1hio/N2WrKPcLwkaaQqNvSRZA
         MJ0WF2I8nJbPx2KKc3lYHwHQc/UmOjRONMsVHmNNsKHZntGgWaLajezsSehFxLWrrU/2
         uu1LRTK/JhaJHc9pE8G0lwh3QLz4YzYqkrLAD4Ro2AFV63zTHttLMT9CuEJ4/2uubiln
         FbJw==
X-Forwarded-Encrypted: i=1; AKwUvBxKX3qMtk1BDr0G4KY8TlL+L6YoFek0ZVuHpll7tMlmZkAk7UwGC7nbZ+pmLIVK6+TT2SsmCXv9St1cImnx@vger.kernel.org
X-Gm-Message-State: AFuF++mwE2qa4ObMz6QtyvtWnPGz4oqwQ1bmPx6zp2V2YwkfASSzu6Yl
	wbmGo7lj+w0EwRZagkn71wUkbFQ3Y6iKjew8QVbV01KX6MZMWWF2kvZgsdAc2CC2Y3o=
X-Gm-Gg: AYBFou3S2o4aSfgbUN9CAGpZHyHDBAOQDhzWMlvShYfMGZRyeZyYSRTRggk6uZaqLha
	ZjAShhM9wzA0QbKL5wGGZYs5mgRNQg4/I+Cyw3gVmhui6EhH4j7FfdZ2GsnbKE5DyaZFZZyKK50
	wBarJHVYBYkFV/kZDiI52IEmIbj95IH6QDA/LhT0qs4yuGjYUeyABfj/ea6URr03KdfLMXESEDK
	o4DxWFITnIRLBllw8JKX+xpcZbUceiEXzAwHoy9VqkjKO/o19hhWLr3DetE28EtQaPt4WAcMQ5c
	9/gB5n1W+WeNTy5/mztwFAapFHyZMt6L5sUiFR20JdwwohCgCHgG9yJBEkWvbQDNsWAi3xGClPc
	cabtd7W84MHIntnf2f8Gflg6vlh9eLIJveuX9zWAjoav3t8si3CmYl6uEpXdJOyaUbzv+trWSWq
	z33txuaaSXDx+m6fAT86uzH+gRlFgl5eARDVsgzORdMQAWFUQmypx0kq23SdbnzrrNjVF+Ih7lY
	wmw
X-Received: by 2002:a05:600c:a402:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cee22422dmr89412065e9.9.1788429689107;
        Thu, 03 Sep 2026 03:01:29 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm70417595e9.9.2026.09.03.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:01:28 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:01:26 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
Message-ID: <aplFds1grx-d5y-m@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz>
 <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
 <CALOAHbDVSD=sNb86VdtOG_KY3VL6Vz5EP+aO7GmY-TrkogOJXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDVSD=sNb86VdtOG_KY3VL6Vz5EP+aO7GmY-TrkogOJXA@mail.gmail.com>

On Wed 2026-09-02 19:50:25, Yafang Shao wrote:
> On Wed, Sep 2, 2026 at 5:40 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Wed, Sep 2, 2026 at 3:31 PM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> > > > The current bool replace flag is too coarse: it is either all or
> > > > nothing. A livepatch with .replace=true replaces ALL existing
> > > > livepatches, which is safe but inflexible. There is no way to have
> > > > multiple independent livepatch sets coexist on the same system.
> > > >
> > > > Replace it with a more flexible model using two new fields in
> > > > struct klp_patch:
> > > >
> > > > - provides: an unsigned int id identifying the patch replace set.
> > > >   By default (provides=0), any livepatch replaces any other livepatch.
> > > >
> > > > - obsoletes: an optional array of unsigned int ids specifying
> > > >   additional provides ids to be replaced. This allows a new patch
> > > >   to explicitly obsolete patches from different replace sets.
> > >
> > > > --- a/include/linux/livepatch.h
> > > > +++ b/include/linux/livepatch.h
> > > > @@ -123,7 +123,8 @@ struct klp_state {
> > > >   * @mod:     reference to the live patch module
> > > >   * @objs:    object entries for kernel objects to be patched
> > > >   * @states:  system states that can get modified
> > > > - * @replace: replace all actively used patches
> > > > + * @provides:        only one active livepatch per id
> > > > + * @obsoletes:       replace given livepatch id(s)
> > > >   * @list:    list node for global list of actively used patches
> > > >   * @kobj:    kobject for sysfs resources
> > > >   * @obj_list:        dynamic list of the object entries
> > > > @@ -137,7 +138,9 @@ struct klp_patch {
> > > >       struct module *mod;
> > > >       struct klp_object *objs;
> > > >       struct klp_state *states;
> > > > -     bool replace;
> > > > +     unsigned int provides;
> > > > +     unsigned int *obsoletes;
> > > > +     unsigned int nr_obsoletes;
> > >
> > > This is a different sematic in compare with the other arrays.
> > > I guess that you wanted to allow obsoleting livepatch with '0' ID.
> >
> > right.
> >
> > >
> > > But '0' is special. It obsoletes anything. Maybe, we could
> > > make it even more special and say that it can't obsoleted.
> > > Then we would be able to use it as the trailing element
> > > in the array...
> > >
> > > I do not have strong opinion about this. It is just an idea.
> >
> > Making '0' special is good for backward compatibility, but it
> > complicates usage for users. Therefore, I prefer not to treat '0' as a
> > special case.
> >
> > >
> > >
> > > Another question:
> > >
> > > Should we allow to enable a livepatch when its provides id
> > > is obsoleted by a currently enabled livepatch?
> >
> > Good question.
> > I believe it's best to refuse to load it, as doing otherwise might
> > introduce potential issues. I will update this rule in the next
> > version.
> >
> > >
> > > For example, let's have:
> > >
> > >   + Livepatch A: provides:1
> > >   + Livepatch B: provides:2, obsoletes:1
> > >
> > > Now, two scenarios:
> > >
> > >   1. Livepatch A can be replaced by livepatch B. This is easy.
> > >   2. Can livepatch B get replaced by livepatch A?
> >
> > No, I don't believe B should be replaced by A. In this case, if B is
> > already enabled, A should fail to load.
> 
> This brings up another question regarding large server fleets. In our
> production environment, if a new livepatch introduces a regression, we
> always roll back to the old version.

Good point. Well, note that the above example with two livepatches
is artificial. More realistic example would be with three livepatches,
for example:

  + livepatch A: funcs[] = {a, b}; provides = 1;
  + livepatch B: funcs[] = {c, d}; provides = 2;
  + livepatch C: funcs[] = {a, b, c, d, e}; provides = 1; obsoletes[] = {2}

Now, imagine that C does some semantic changes in the function 'e'
so that all other functions {a,b,c,d} have to be updated accordingly.

You could not install B when C is installed. The functions {c,d} would
break because they won't be compatible with the rest.

The only safe solution would be to replace:

  1. C with B and install A later
  2. C with A and install B later
  3. C with A+B atomically

The 3rd solution would be the best. But it might need some significant
changes in the core code. We would need to handle an array of
transition patches instead of just one.

But we might allow 1st and 2nd solution after all.

Summary: We should not allow to install B in parallel with C.
	 Instead, we might allow to replace C with B.

> For example, if A is the old
> version and B is the new one, we will roll back to A if B causes
> issues. In that case, if we refuse to load A while B is already
> loaded, we can't roll back. (In practice, though, we haven't rolled
> back a single livepatch after rolling out 40 versions on our 6.1.y
> stable kernel.)

Good to know. We should keep it simple. For example, it might be
nice to allow atomit update to more livepatches but it probably
is not worth the effort.

> However, this isn't an unfixable issue.  In the future, I plan to
> introduce dynamical provides IDs and obsoletes IDs at load time,
> allowing us to change IDs on demand

This sounds hacky and dangerous. IMHO, this should not be needed
if we allow to replace C with B in the above example.

Best Rergards,
Petr
