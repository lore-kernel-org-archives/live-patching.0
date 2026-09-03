Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28B36167E
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427658; cv=none; b=UcmB5WrpjMfhLxJlp0OIaAIMKPF2J9rAmYnWamxsZFWwYMBUq6/1SOofcJNY+2/aqZ9L1tN/ayMooK48arF7Wg8i/vCTW6jCy+9Q5+1Yu93/S+Krly2gRQSIvNq+D5AWmDMqL7uxdm9g1smL7bNchysspixJbu9/tZHsms+cekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427658; c=relaxed/simple;
	bh=2CqoirDhSro/DIzmMuu5OHYE92zS0qQ9eAazAOgBd/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPUkmkY3eqQFTccekMMAfNoh0umQTfIg//8ehy6vLu/LOmYmVmeAhQRT9kpDlqBaWdEKfYAhfwDd+ublTi2KPwhN1DaaWSSk43wO2MMVZWOwxQ+bZzKD8LSE4YIGjWq9wOlS37i8p9UilkRebgqRF+oqDMEgVAoRvQdEmGk6UCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BJQUIBKu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BJQUIBKu"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-485843aeab8so215712f8f.1
        for <live-patching@vger.kernel.org>; Thu, 03 Sep 2026 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788427650; x=1789032450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jp3vYoWtYDkgfiHgrii6jKsTHN9fg0+wIpwgB3iVTJY=;
        b=BJQUIBKusMLnYSQ5P3o/wmAiP+42EkpqpFGlo1LBYnt/hipLk/4JFUniS4D00G/UQn
         IZzEmWXa7cGmNJwbcLP6gp5fobSqJhvPQKR1EvI+d1BD77d29PArW0PZSg8Q/YDw7JlE
         kYAZMUrvNsv4aLJ0iqwuY9Gt0C16SpRoqbIhGF1ZedWCyYD+Qahse8g0mzpqE/+BVmYH
         68yYkIK3peDz+7kzI6Dp5Hg83qNl9Lwa/eH1P75wd5+Nwn3biEabmbO6LvmdsNTilWnE
         mRuo+9oI3eTwRKfCwebQ9WcGmjfJZZNfxXMU3FrxrK1spgerjPclG64yJYbdEAqd9Dgw
         Gf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427650; x=1789032450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jp3vYoWtYDkgfiHgrii6jKsTHN9fg0+wIpwgB3iVTJY=;
        b=Gxw1CMXj7RXuTNospWFCiyeNqFKySonk9VK70ZTPzuKShEIs3KoNsgy+DbyQnqXj+y
         7d5fgiL6m9wT2Vw/VXHTftfxTIwWYeicK2CWGOvGMgM5py33HG1QeNkNJ64jLeGRsU6F
         i++sCKesmB6QzYQuaRJ+ma4eVAMtPnHapTlGmu3MhNEmfI33UFrJtUkDFn9RVHMVTfGT
         ekKchalk+UT1yXiF5JrQ7akmjO3/bSJoLLijAt1ld9qi5P0Q0B1co+JMmMbOj3SNSQUE
         C5uLl7RQT+lOWso/09kaRapQz/trloIG5PV8osBjt7UJdKbd/6lU3nJm2bbkyUj7dZs2
         e/dA==
X-Forwarded-Encrypted: i=1; AKwUvBxRDdh/CaiCKtm/lHQgp+t8UnSvnJx/cF9WHGurMkq53bgfo/DX3eAfaMxOxKBbT6Ghb4+mDzML8M1UgX43@vger.kernel.org
X-Gm-Message-State: AFuF++nQqQ+a2NAlTfRdQFeRGvzmpRA18j5OelKw2mC3Qxt0R89iLwsd
	7ZNjWJ0pvY7RF3BkZpgQkd8pdQMD6DyRH8w/1Vm+mtcjSNMggjCFIE7PM8XnVTH6cZvDqvahDDD
	O7h1CyGs=
X-Gm-Gg: AYBFou1kh58kDYXzEMevkGcydmXcZV8eaY+UM8AkzaZHnLrHq28xRaQF56jKkbs8Ioe
	lkwtjhs+/yniP8nzG+uz1plFb4t7tXXOzofP8HPxx3V+RKLGo0X62hS2u6QXdHBq5qJvKFlYbV9
	1nWkJ1BKu82hemeNivyqHVFaYN9ZPEAVXlIj/DLfw/NM2lV60Qb4WlDrbJ3xbpbXprZAmH+2yWj
	z3SKSAP7Evc3Hq7fbYORlpFSUMreuKBxhyMydaiY6OObB/B4DA+6+/6ZXiwXp7Go/kfa5QdWSFv
	FkupjE+nKXeOboAhkRtjDVjrANgZtgQZgCQckks59AkM4Yc8nRqQ1zKz6v+hZE72Q+mvH4VR9bk
	a6XEazdSezZ+SUiDyJJJTNx9vGFpFAfdVAAognvVEE4M1HRNcWkjCuLPgRrrkrd4+687kJvnCke
	W/qS3GxqCCTBopmjsFRp3JSkcX4QBvyriP9lh6PjmQrNwIKixiZNE8YQpoHVeJUlgMtjsPwnXD1
	PJezrJ8UZ4AlLI=
X-Received: by 2002:a05:6000:1449:b0:482:ea9b:962c with SMTP id ffacd0b85a97d-48488f23cb6mr20489334f8f.22.1788427649730;
        Thu, 03 Sep 2026 02:27:29 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce5e5sm12209135f8f.36.2026.09.03.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:27:29 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:27:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
Message-ID: <apk9f_LsGRYHzN0Z@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz>
 <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>

On Wed 2026-09-02 17:40:02, Yafang Shao wrote:
> On Wed, Sep 2, 2026 at 3:31 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> > > The current bool replace flag is too coarse: it is either all or
> > > nothing. A livepatch with .replace=true replaces ALL existing
> > > livepatches, which is safe but inflexible. There is no way to have
> > > multiple independent livepatch sets coexist on the same system.
> > >
> > > Replace it with a more flexible model using two new fields in
> > > struct klp_patch:
> > >
> > > - provides: an unsigned int id identifying the patch replace set.
> > >   By default (provides=0), any livepatch replaces any other livepatch.
> > >
> > > - obsoletes: an optional array of unsigned int ids specifying
> > >   additional provides ids to be replaced. This allows a new patch
> > >   to explicitly obsolete patches from different replace sets.
> >
> > > --- a/include/linux/livepatch.h
> > > +++ b/include/linux/livepatch.h
> > > @@ -123,7 +123,8 @@ struct klp_state {
> > >   * @mod:     reference to the live patch module
> > >   * @objs:    object entries for kernel objects to be patched
> > >   * @states:  system states that can get modified
> > > - * @replace: replace all actively used patches
> > > + * @provides:        only one active livepatch per id
> > > + * @obsoletes:       replace given livepatch id(s)
> > >   * @list:    list node for global list of actively used patches
> > >   * @kobj:    kobject for sysfs resources
> > >   * @obj_list:        dynamic list of the object entries
> > > @@ -137,7 +138,9 @@ struct klp_patch {
> > >       struct module *mod;
> > >       struct klp_object *objs;
> > >       struct klp_state *states;
> > > -     bool replace;
> > > +     unsigned int provides;
> > > +     unsigned int *obsoletes;
> > > +     unsigned int nr_obsoletes;
> >
> > This is a different sematic in compare with the other arrays.
> > I guess that you wanted to allow obsoleting livepatch with '0' ID.
> 
> right.
> 
> >
> > But '0' is special. It obsoletes anything. Maybe, we could
> > make it even more special and say that it can't obsoleted.
> > Then we would be able to use it as the trailing element
> > in the array...
> >
> > I do not have strong opinion about this. It is just an idea.
> 
> Making '0' special is good for backward compatibility, but it
> complicates usage for users. Therefore, I prefer not to treat '0' as a
> special case.

Ah, I have missed that the current code does not treat '0' special.
I was confused by the following sentence in the commit message:

<paste>
  By default (provides=0), any livepatch replaces any other livepatch.
</paste>

and this paragraph in the documentation:

<paste>
 It should be emphasized that the preferred and most secure way is to always use
 the default ``provides = 0``. In this mode, any livepatch replaces any other
 livepatch, preventing any unexpected interactions between incompatible
 livepatches.
</paste>

I understood it the way that ``provides = 0`` was supposed to be
special and always replace all other livepatches.

I think that I was affected by Miroslav. I had an off-list discussion
with him about this some time ago. My understanding is that Miroslav
would prefer to somehow preserve the original ``replace = true``
when the livepatch patch replaced anything.

It might be useful for OS providers who want to make sure that their
kernel critical fixes can be installed on the user system. Otherwise,
customers might complain that some update failed, ...

Of course, it has a drawback that any livepatch with ``prov ides= 0``
would wipe any 3rd party livepatches, even when they are against 3rd
party modules.

I am not completely sure that this the special handling is a good
idea. A better solution might be an option which might be used when
loading the livepatch. e.g.

    insmod livepatch.ko replace_all=y


Any opinions?
Miroslav?

> > Another question:
> >
> > Should we allow to enable a livepatch when its provides id
> > is obsoleted by a currently enabled livepatch?
> 
> Good question.
> I believe it's best to refuse to load it, as doing otherwise might
> introduce potential issues. I will update this rule in the next
> version.
> 
> >
> > For example, let's have:
> >
> >   + Livepatch A: provides:1
> >   + Livepatch B: provides:2, obsoletes:1
> >
> > Now, two scenarios:
> >
> >   1. Livepatch A can be replaced by livepatch B. This is easy.
> >   2. Can livepatch B get replaced by livepatch A?
> 
> No, I don't believe B should be replaced by A. In this case, if B is
> already enabled, A should fail to load.

This is my preference as well.


> > The current code would allow to replace B with A when there is
> > _no_ real conflict in the livaptched objects, functions, and states.
> >
> > But does it make sense?
> >
> > Reasoning: Livepatch B obsoleted the livepatch A for a reason.
> >         It sounds like they should not be enabled at the same time.
> >
> >
> > Special case:
> >
> > Should we allow to install a livepatch with non-zero provides
> > when a livepatch with zero provides is installed.
> >
> > For example, let's have:
> >
> >   + Livepatch A: provides:1
> >   + Livepatch B: provides:0
> >
> > Now, two scenarios:
> >
> >   1. Livepatch A can be replaced by livepatch B. This is easy.
> >   2. Can livepatch A be installed in parallel with B?
> >
> > Reasoning: The livepatch B replaces everything because it wants
> >         to be the only installed livepatch. It sounds weird
> >         to "break" it by installing A in parallel later again.
> 
> So, let's just not treat '0' as a special case?

I am not sure.

I personally think that '0' should not be special. A better solution
for a forced cleanup is the "replace_all" module option.

The module option would need to be implemented in the livepatch code.
But it will need some support in the livepatch core as well, either
a flag in struct klp_patch or parameter in klp_enable_patch().
IMHO, the flag in struct klp_patch might be more practical.

Best Regards,
Petr
