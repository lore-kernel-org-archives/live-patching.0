Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AE49364C
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455439; cv=none; b=nJs6O10SdhsN6Cu3FDHR5jCQlV0uZR6/z5T1xKDIbK9vjk/KhdhpRh0UfoS7LtbacarwlFJucgheI+T6mjqXo87Uv8e+PrH9rXqobvt0yXeNoAwtHVK1ySawqYwaIepT41bAb7mcNBQLuxF4J2HQTyGBZ5/S2qcyT6cZkxpbvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455439; c=relaxed/simple;
	bh=/H2LwDDtOX/EmUnvbwXJyMI/Z8Hsm619lX2ibqh/FMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtMlmo35+d6yfwpbdnZmq+D6lFjdkD0/PEliUApPGbxktQuPdDErpBNyexgS990PM5yZpqeJe6jiD9zwyUcj+bLX7z2JX8g2QUzmdV+C5mUuTWI6fC3HYimIsybfpywnwFHnX4+4sVVZS94nEK3SfpoYe3iYH7xJ7ySq6RNMEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GuJSO2xq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GuJSO2xq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so20280905e9.0
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791455435; x=1792060235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JvAFFhqw5GLuICDIcnRG7fS1nPF0i45hBH9T+Umii+g=;
        b=GuJSO2xqNs5YcNQ9Buh5ZlK6mVudozbIyq5Mrz63wghV85sJGZ8mCcl1cNdkVfBUOJ
         jSlfXGUhUvkR61SSAvibK0IbUkyUAfX92b1x4hT+kYEMggnLVjIGVDOX2KTqf5iFsfyF
         2NrnGxKf53EyLKjOs2Hd2+w9wADp6oSIlyKx77g2htHZ64Hpnxd9FUhNUa+SfqbqOAN0
         SqPptgAE2xf/KSSG6PqQCoTGuIDm7rvvJtTwPB+yw1PlKvUeV5PcxwcbUGNP3F0tLvSM
         Q/aToviKAS68sF9Ft6tgQkQdbTNl1NOx6htYHdVcz29pDcBPEuqXLTkkhFfcJHY/XDm9
         80FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455435; x=1792060235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JvAFFhqw5GLuICDIcnRG7fS1nPF0i45hBH9T+Umii+g=;
        b=itRFJUeuJugKdhnrTdP2DiCwc5ixht1XV38ADjLCa1+WZrocDhLDixBFnqBJOZqp8D
         WSIPQjHfBLoBNrC757SiYKUkpS1zRW0wNj5n1g9jklp6J/YvS4O6znzYfrURMkK8kymD
         nSBuAYJEYgC4vUX9g31w7f1+DdvF6cJM4dAY7cwK25QRkW00McyYCp1LFy+W+q7cbGx6
         mrfTw1l/hL4cNmGiZ6qqW4YhDx8KEE39RoGXZdKsdDKKySZuSMqaxIo0R/DpIJy1MYZi
         wdTL2b2RnzqgkJUhpU1g4qFMYRvnjluLMxf/7HL7ookB2nZq4lbEIscvdyaR9bzPzB7O
         6Gtw==
X-Forwarded-Encrypted: i=1; AKwUvBxAdPexI1onAQpdEgj/m8ec3zZyIqK4PmDOdgJaV7+X9xicpIOAIUk41GOH8DPWgROlJZ3AIkaCzX0T/VBr@vger.kernel.org
X-Gm-Message-State: AFuF++nle+CUr5B3QzrgmxjfTAZTjsoSk0WY6H7uL4DAHlg+iyYf7f1F
	GicDhAuwZw3KZb/wZndBYwJlfErfUVUGEo6eJ9zOV5rilL//1WnT72hfvwQeg0YJWhw=
X-Gm-Gg: AYBFou2MxZLfbBiC/rUPgp9w/TVydE+EWyfSIzT/zoSPivReEYxf/WfLGVudAL8UQEr
	S9ZHx3N4kzsrUkMSSRJ10xSQA54h64TPnPUnRQDhiDq9EVIAPe7E/5kEXRKEL4w35MX68Q+q4W8
	135otUtwyTJaqiLx3Sg3j/+Ba5LtO/buswHRJ45c6GDC6x3W9pskEHnXI9Td5hQmyBjoLREKWzB
	P0dk0PNHeIIcxd2PuhKT+FKAt/bvQgCJOVgIVVCY4OLIJWW4tJzyHaHb0JlN5xUwR3owwjw0/Od
	5zqK1AwbWKOi1UPnKV+b1bpUBdSn6uhkLHr2AB9H9vPHb+d4XicuHIt0gN+AHqRqmdSH2u0pM7X
	GMuFmOfLehck5SLIXnpc05u0DJuh8bF+jhpU68VOdIOgg4WDsAkZvyX5val7MOexxLK3t+mCwj/
	hFENLwn2yYev1ct3Nz6ozypkRA59xO8xv9d8CCWv4YAkJM2Lbtz6cGoR4z9AM7LM3fbA09IgxJ
X-Received: by 2002:a05:600c:3f0b:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18007e381mr86048665e9.0.1791455435163;
        Thu, 08 Oct 2026 03:30:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843dfb3bsm67008095e9.13.2026.10.08.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:30:33 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:30:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v10 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
Message-ID: <asdwx-BENZy6dajG@pathway.suse.cz>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-6-laoar.shao@gmail.com>
 <ar_kouwlAGcnnUYQ@pathway.suse.cz>
 <CALOAHbCHwJ2htPOoako_EqNg-bQF=4NLNqVGAnzsAi2uitMdeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCHwJ2htPOoako_EqNg-bQF=4NLNqVGAnzsAi2uitMdeQ@mail.gmail.com>

On Sun 2026-10-04 23:46:29, Yafang Shao wrote:
> On Sat, Oct 3, 2026 at 1:06 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2026-09-30 11:03:19, Yafang Shao wrote:
> > > The current bool replace flag is too coarse: it is either all or
> > > nothing. A livepatch with .replace=true replaces ALL existing
> > > livepatches, which is safe but inflexible. There is no way to have
> > > multiple independent livepatch sets coexist on the same system.
> > >
> > > Replace it with a more flexible model using two new fields in
> > > struct klp_patch:
> > >
> > > - provides: an unsigned int id identifying the changes made by
> > >   the related livepatch. Where the changes are a set
> > >   of modified objects, functions, and used callbacks,
> > >   shadow variable ids, and state ids.
> > >
> > > - obsoletes: an optional array of unsigned int ids specifying
> > >   additional provides ids to be replaced. This allows a new patch
> > >   to explicitly obsolete patches from different scopes.
> > >
> > > A new livepatch atomically replaces any existing livepatch that
> > > meets any of the following conditions:
> > > 1. It has the same provides id as the new patch,
> > > 2. Its provides id is listed in the new patch's obsoletes list, or
> > > 3. The new patch's provides id is listed in its obsoletes list
> > >    (the obsoletes relationship is symmetric).
> > >
> > > The obsoletes relationship is symmetric: two livepatches that
> > > obsolete each other are mutually exclusive. Loading either one
> > > atomically removes the other, so they can never be enabled at the
> > > same time. This allows swapping between two independently prepared
> > > livepatches that cover the same scope, in either direction.
> >
> > Honestly, I am confused by the 3rd rule and by the last paragraph.
> > It is not compatible with my understanding of the provides/obsoletes
> > semantic.
> 
> Correct. In package management semantics, Obsoletes is not a symmetric
> relationship.
> 
> >
> > In my mental model, the provides and obsoletes define which
> > way is supported. Let me show an example, let's have:
> >
> >  Livepatch A:
> >    + provides: 1
> >    + obsoletes:
> >
> >  Livepatch B:
> >    + provides: 2
> >    + obsoletes: 1
> >
> >  Livepatch C:
> >    + provides: 3
> >    + obsoletes: 1,2
> >
> >  Livepatch D:
> >    + provides: 2
> >    + obsoletes: 1,3
> >
> > How is this supposed to work, please?
> >
> > In my mental model:
> >
> >   Livepatch A:
> >      + can be replaced by B, C, or D because they all obsolete 1
> >      + can _not_ replace B, C, D because A does not obsolete 2 and/or 3.
> >
> >   Livepatch B:
> >     + can be replaced by C because C obsoletes both 1 and 2
> >     + can be replaced by D beause D provides 2 and obsoletes 1
> >     + can't replace C or D because B neither provides not obsoletes 3.
> >
> >   Livepatch C:
> >     + can be replaced by D because D provides and obsoletes
> >        all ids which are proviced and obsoleted by D
> >
> >     + can replace D from the same reasons.
> >
> >
> > OK, I understand that it might be practical to allow replacing
> > the patches just because they are "conflicting". As a kind
> > of revert/downgrade.
> 
> Right. This will let us easily roll back the buggy livepatch and
> reinstall the old one as part of the rollout.
> 
> >
> > It might help to rename "obsoletes" to "conflicts". And just
> > say that the livepatch replaces livepatch with the same id
> > in provides and also all conflicting patches.
> >
> > But then I see another problem. We have three types of conflicts:
> >
> >   1. same id in provides/obsoletes/conflicts
> >   2. same livepatches function
> >   3. same livepatch state id
> >
> > It is weird that we would silently replace livepatches with 1st
> > type conflict. But we would refuse to load the livepatch with
> > the 2nd and/or 3rd type conflict.
> >
> > Note that the inconsistent handling of conflicts exists in
> > this patch even when the array is called "obsoletes". My proposal
> > to rename it to "conflicts" just helped me to see this
> > inconsistence.
> >
> > Any option/idea? Yet another naming?
> 
> Perhaps it could use a better name, but I'm not good at naming things ;)
> 
> >
> > One more thing, the commit message does not describe that
> > the livepatches might conflict when livepatching the same
> > function or using the same state id. It is important part
> > of the semantic and must be documented.
> 
> Sure. I will update it.
> 
> >
> > Best Regards,
> > Petr
> >
> > PS: I am sorry but I won't be able to finish the review before
> >     the Plumbers conference. But I am happy that I have found
> >     the above problem. We could discuss it at the conference
> >     and come up with some sane naming and semantic.
> 
> I can't be there in person, but I believe we'll come up with a
> sensible name or semantic. I'll hold off until we reach a final
> conclusion.

I am not sure if you saw the video from the the conference.
It looked like we were going to nack this feature because
installing more livepatches on the system was considered
too dangerous.

In particular, it allows using livepatches provided by different
teams/vendors. It is almost impossible to prevent incompatible
changes and breaking the system. The check preventing livepatching
the same function or using the same state IDs is just the best
effort but it still allows many hidden incompatibilities.

We should rather discourage people installing more livepatches
in parallel.

Anyway, we had a follow-up discussion and agreed to accept this
feature in the end. We already allow to install more livepatches
in parallel. So this patchset is not adding any new danger.
Instead, it reduces the danger a bit without complicating the
code too much.

Also we understand that there might be some use cases for this
feature. And it might be safe when used carefully.


We also discussed the semantic of the obsolete field and we
would like to it simple. The livepatch with a provides ID should
replace a livepatch with another provides ID _only_ when the other
ID is mentioned in obsoletes.

By other words, please remove the symmetry and "support" for
a rollback. The symmetry causes some confusion as explained
before. I would summarize it by two reasons:

   + In the packaging world, the "obsoletes" behavior is not
     symmetric.

   + The symmetric behavior adds a "conflict" semantic. But
     this particular conflict is handled another way than
     the other conflicts (livepatches functions, state IDs).
     I mean replacing an already enabled livepatch vs.
     rejecting the new one.

In addition, we do not support the rollback in all situations,
for example, let's have:

Livepatch A:
  + provides: 1
  + obsoletes:

Livepatch B:
  + provides: 2
  + obsoletes:

Livepatch C:
  + provides: 3
  + obsoletes: 1,2

The meaning is:

  + A and B are independent livepatches.
  + C adds some dependency and has to replace both A and B.

Here a proper rollback from C to A+B would require loading both
A and B livepatches synchronously. It would require adding
special support into the module loader and the livepatch core code.
We do not want to add this complexity. Especially, because
the parallel installation of livepatches is considered a bad
practice.

A partial workaround might be to allow changing "obsoletes" via
a livepatch module parameter. It would allow to do the
rollback in 2 steps:

   modprobe obsoletes=3 livepatch_A
   modprobe livepatch_B

It is still not an atomic rollback. But it is better than
without the parameter which would require 3 steps:

   echo 0 > /sys/kernel/livepatch/livepatch_C/enabled
   modprobe livepatch_A
   modprobe livepatch_B



Summary:

We are open to accept this feature but please:

    + Remove the symmetric handling of obsolete flag.

    + Properly document, in both the commit message and
      documentation, when the livepatches will be replaced
      and when they will conflict.

    + Document the pitfalls with the rollback.

    + Add a warning that installing more livepatches in parallel
      is dangerous, especially when they are provided by different
      teams or vendors. The built-in checks of possible conflicts
      do not prevent potential incompatibilities and breakages.


Heh, I hope that I got it right.

Best Regards,
Petr
