Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394646D2B1
	for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322578; cv=none; b=c5rw3NrRuI8A7J7zmS/2r/v8gAiUf+pH+TPDmDG8+f3circoIoRNyNWGja3Ve6MEX+PQ3dfmzEdHu9F2G9/j0Nb9onAXf3nKjuEMZDm0QCWqozrSUfEEFeBPsvDG/Z1cAzGf0B+KLYHAOjalbjtfC5LcSLSsiPyG0/7GI9V1xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322578; c=relaxed/simple;
	bh=OTBaz7Yhpkf0KZ6fy/eutPd13N6qBoXZG+DHLOKiIjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8UOfxVZY87U2c1j6/Or04qpQmaKcQQRDH5vrwVLM0EOWf0bpS5B/54eMIBjV0MuGfVajCaWdci6lz40j8axz/SlNpciFL+hzKYLEkR9lDP72U3RYPABFVlJKHY6ch3qo/w+/mAWzHUODUwVnITYV14LSwBBUyg0eNzxA9o1nQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lh150y7X; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lh150y7X"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so474831f8f.0
        for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790322575; x=1790927375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CY695p5MCNOWHql0mn2kyFYA9B9N04eTw362AzsTaBI=;
        b=Lh150y7XTpel5V/zl3TWLtTm/DT6r7tMTARUsqARof73Rzcm1k8WXUsjY5RPdBeN4A
         VBEth0uxT4kCEhC+/Nsu+S34hbmkhc++jG+20ibSLpMTmz/VR490jVika9SqnwAfdfpA
         LZ9dCZvtbjHX2pbf62QZ44eUQHjioVgqYU2lDFhV21CadTpgYqeQmhD2mbnIanY2LhAf
         tdWje8d0SL5DZwxF3tUFb5Slhxn5c2QffL/k2oR/u2Ln7Tt04LQQkSnl9IRxiX5MdbsX
         NPZxRKNPP2seS/VT3sSNauluriflAnL38TyqoFA982ArvGU9L1WrBpmxMQsW0Xf90gEH
         wjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790322575; x=1790927375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CY695p5MCNOWHql0mn2kyFYA9B9N04eTw362AzsTaBI=;
        b=xlGvWcKjWBXLERUZrkNYo9Fh1Bd2UQxrOacAG498uFRV3n4VRjtphz8xxG9khC20iA
         jNCMjHK6o1bTmSY+u2BYxbnR5BlLTj74sZLxp+zV4rTSuAdJcRXA9sx7NMxgDdUPEt6q
         8275qZL7hGf1vf0sRgVN0n8utjH1z3VRDeYFQswDd2KM1NtwBADoKDTRETM5JuGy30ON
         uVUpbymqtgANbdiV8N2JysWEGiQ9MBoBgcpAUwPWGeexZSjTfZz3e+8+QAaGxObpEpX0
         0ltyY3H7UZmBZuH/I5APRVMmorF22vad10mhF8E18k7F2cL8ujVK2g97J4AMIJ+mBZ55
         Rbqg==
X-Forwarded-Encrypted: i=1; AKwUvBzFz5Y4SoyPaTGEC3CzBx2cXowMGgCeh0pwHgtLhxGuD0TBlNift04CekpmsHGjUsuVeQLMA59VAX6W2dSq@vger.kernel.org
X-Gm-Message-State: AFuF++mPcwKc8EkcieN24hMh4p+UjkQ+vlhsLuurnMYvrpcqHXbIO6gp
	RWFReNhMPYN8VzJHArHYBd6FQ8UwUlJBVRUevsdJFLirDKzO1JbbeN7Vgk2MzToNF34=
X-Gm-Gg: AYBFou32u/yZ0aMACGe2xseQxmciu8UvS41fR6CAkXw1k1XPdVQml6/cNfRyltWOHLV
	kiKCWIVpyvpQKp+Od0ncW1EsVZOCW4de9ZgNnfYKhYP8dwH0e3STR6MmGge5d14cG++yCJoP1ZR
	3cddPEqE5FB4+2ZIe3nqKJBTmLyv99Mr9R8PqVJAI1QM49VCyq5oMvJJavgtvMhw8HqUPVkHT9F
	oXPmS2Hngi4Uv2heNyQhxrV5tzBllB78108m7385139c8mFwBDxuooUhkk7xiQvUfp97oML0ZPO
	q0ZyuFQaU98Krid2ZkHXqI0umwNT1xtzkQ/HS+aQDFB7aGt61vnCmRmFT6QB7VX/r9jD52cIDD+
	MqtVVwzAWzaWleqApYDp+pB7MVgHfc4rp82AbCq5+wD4XY7VaO0AX8bdWm8uVD9cYVhobsKlAME
	/QmaeNVsgLTEGkGnnrJFPKPZrtzqnLZGrf0nQBdVxQN0C2P1T+JL4HBztrgOihS/z8JsnrJsOZ
X-Received: by 2002:a5d:5e0f:0:b0:488:76f5:ca0 with SMTP id ffacd0b85a97d-48876f50d6amr3541810f8f.39.1790322575127;
        Fri, 25 Sep 2026 00:49:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a744fb5sm4608860f8f.33.2026.09.25.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 00:49:34 -0700 (PDT)
Date: Fri, 25 Sep 2026 09:49:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v9 0/9] livepatch: Add support for scoped atomic replace
Message-ID: <arYnjJxU_JecIrZq@pathway.suse.cz>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
 <CAPhsuW5+j8ff0h1ty-vOiAWUnUOcJ0UQhUqvJRVSMrVH9WqbZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5+j8ff0h1ty-vOiAWUnUOcJ0UQhUqvJRVSMrVH9WqbZA@mail.gmail.com>

On Thu 2026-09-24 13:56:32, Song Liu wrote:
> Hi folks,
> 
> Do we have pending comments/changes for this set? If not, can we land this
> soon, so that it can go upstream in the upcoming merge window?

I still have to review this last version. It is getting on top
of my TODO list but...

Anyway, my main concern is breaking the backward compatibility.
I assumed that we would discuss this during the micro conference
at Plumbers first.

Best Regards,
Petr

> Thanks,
> Song
> 
> On Sat, Sep 12, 2026 at 7:43 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Atomic replacement is currently all-or-nothing: a livepatch with
> > "replace" set either atomically replaces all previously installed
> > livepatches, or - with "replace" disabled - it replaces none. There
> > is no way to atomically replace only a selected set of livepatches
> > while keeping the rest running untouched.
> >
> > We previously proposed a BPF+livepatch method to enable rapid
> > experimentation with new kernel features without interrupting production
> > workloads:
> >
> >   https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao@gmail.com/
> >
> > In the resulting discussion, Song and Petr suggested that it should be
> > possible to selectively replace or skip individual livepatches.
> >
> > This patchset introduces a more flexible model using two new fields in
> > struct klp_patch:
> [...]
