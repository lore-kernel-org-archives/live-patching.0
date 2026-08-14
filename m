Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F53DC4D3
	for <live-patching@vger.kernel.org>; Fri, 14 Aug 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740263; cv=pass; b=l+BVvONPY/3th0+2h2lR4WUZrTY28Mn22R0kvUDETA37Ykg4PnqBRcG9xiNtjLaYie4TX24N3Twt4+pr5reyCM9RUJhjFTXvXqKub3HE7N7Vi681R3Bb3YIdVEsYfhhgwydWM0Z8ix1pZvc/LSta2iM5UX6RDBqt85GSte3ufjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740263; c=relaxed/simple;
	bh=Yef0+XlIt5CkGyFDHekUoQrBKiNSnjOiMr6bDpxcEAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzwnEww3Zr0WwOJ0DXsh1EvIJDSdazy3q01Sae5SCSkpoFa7zAUGnB46ECUxlLfapCSzTMOITCfmY4NwUTIcuVIxKILOWNgTAXYJ/4UtyzcpcJ35DRy50du7UHHYJClBqkKNrLZu94CratpYUDRrY6rOC0EK/64S4UX4F3hXpEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNr582kv; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNr582kv"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-76535268562so422029137.3
        for <live-patching@vger.kernel.org>; Fri, 14 Aug 2026 13:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786740260; cv=none;
        d=google.com; s=arc-20260327;
        b=k2MmDLrTjBU+QjXWAWGnr7dQtJYSKrrTrZhmREwsoZChXdesnEG4gFJ6X6hOZDpXDz
         ++AbuwtFNAXjer13oDEyv+3d/A2+t6bWHNIMKqswZx4fIEKZGIeMpd87lgCorGNV/r/1
         0zj2YE8MMbntw2fukZBZLbJWn6QJnxDafsxETcZjN7iu8UvLgvKey7ydeOQv9vXSEAgY
         IvZ27dP/pV3toWUFlpwSKKHtpnuFjSYFm7SZ9rIsCyd+xxL+RWgxiS6I26DAAqc+IElG
         U8TcPsyTL1OanKd5EqKyQkM2lRXPJSvFmLhIcaHrl7+VgUhxNba30+AMmN4xJSJBwKyG
         KndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GYGwalcvjkjv/vzHq/Wh7lCLdSqyXSnP87QCybk111Q=;
        fh=m538NdAkhTF2DuRQAyRfyF5rP5CgkWbPSMRJArrrA98=;
        b=ETCZpnjJMq3mwuZ6AETqXFwjRHC9hHuiqMup9vtTbFeyKw9tmSosHsRSDWhtLC7yai
         0aga5hAYvlFyA0gZ/7rNDbwb1pv220ZD3e+jG5S7k21iivSZ5vCnc6mVReWoYCqYglrB
         As47Co8wFNUPAeY/sVmxC56qd/ZP08sVxyeqZdEFRdP9VCbHUcm36n9E1r5MlPxOfJmB
         QLpgvQPs+XNXeB1IXwWp/8jAVjSkTlZUT7BFxxHBe8UoKqdn3U/LPq8lCbryRvh7AaBx
         3N0weEbX7zH6Bv8jKOFpqrKiHrcsgyaEQ2mCv4hdGiZ3GwmJyCHr4OGG4sPnI4Lf6D+H
         mvXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786740260; x=1787345060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYGwalcvjkjv/vzHq/Wh7lCLdSqyXSnP87QCybk111Q=;
        b=eNr582kvWnLdBPVqBuLK4CuituDSaYuO7aR+Fg4aUogm04XgO7g+CktP3Q0m4yklCR
         TCIlf7yhwKgUuLGdDcFdeedymXyRVIEFzLP18B8jvwz6wUQv8nKi1HyIWi0zRQw12eW3
         BpjjjyoECEuQX5IByb/44ERJNUG5wPkJC0tc8YxO/FXdmsoT+BpmzXSiqJwVhKV/mB14
         7jhuvQ3LhPCaSGVxaLGo8NMF69CSMTHnXq9L9g/WhZ2oBXUCw8BM3iHqHBxIdl3Ii8fC
         i8jh/S6KmyveE9gqZmSMz5BefUeAPcFxz2NEm1HCTfvS0EUbGzOFRt0UCA+fZ/S4qV6X
         zoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740260; x=1787345060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYGwalcvjkjv/vzHq/Wh7lCLdSqyXSnP87QCybk111Q=;
        b=cP3LaayRh2zSMfWILmqETp2YwCTQibrU3RcajAA3ALBjexgvzHfNu0Rf2Kme4ImqI7
         f0g0TbJmaDTSw7a3S2KZ/C5y+gDj9BRvlxfUMhOLq9MzQBJJ4DDO8/5Can2P4uiTGEJ7
         ScXQgajsCRvYf0natcMHbWDYN6Qna/YSYcazerAXr1pAWSjBJ7zBev5kcdYsFgkhB0/R
         4oCWTIJG+CXEo0FoMa4pkz+si9A0g+43p26g6nXUNEdNchYFBdJaXfnku6NGOMw80Fi6
         G/Lqi2QsBBjWtU+4GlZ8IRLF4ZbRDBtitCLMQSXpbVSmyWRJ9LxwhNO6j+kQ03rqap69
         AJvA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1bvCZ21hA4NsLfz0INFdbvQpLcuYhfDtanfIT+I0Mt/VW7OJ4hQTG57Z/WYbgzrQ1dM7RJag5dqAaYXDB@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwJ0gjcPY/N+As+M4lQqEz4Z/zOtZkUNWX+qlAVmtLAx/xrdf
	xUawP0cX57FUdbXFFHDW5d+NKRQU8sGmOpcOPK3yTc3gcTlhdMt+wl93r3bAlusL7fJOfXvCkQp
	uK84a+n8IchSapv93Sz93FD3llZeU144sQmtB+qpQ
X-Gm-Gg: AR+sD10rgf2hLFNJJ7W9pJZQbxe/Etgn0avB/X0OCwsJpOeUCiOqk94CirNmyYVRFkn
	ejP2ygK6LUpxKaHavmVpAuGjOEwJvK4LktxsuJgWxdlgvd1WWZ93IiyDue1n/up82PkSMVFQCth
	tvd6RVUlTdeiazwIQVo0opELjvXdSG47r+Y7aW9FW7FWYWI2wwypa9iXvaRrU2IRlsgSW66MbLH
	8KyXhHj/jc4PSxq2fTPDk4BxwQn7LmL9/h4gynZDUB1fhA9QvFb42g4hKopjIg0bvroLqE7RoId
	08HFFWguCAxIVTWQTGoGlg14DqXsSTRV3CT3mVcgY78N
X-Received: by 2002:a05:6102:548b:b0:75f:e517:ec96 with SMTP id
 ada2fe7eead31-76f27377fe3mr1344823137.0.1786740259079; Fri, 14 Aug 2026
 13:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785727106.git.jpoimboe@kernel.org> <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
 <anyufyGq2d-7AC_H@google.com> <anzW_H5OlQ-MqWjf@jpoimboe>
In-Reply-To: <anzW_H5OlQ-MqWjf@jpoimboe>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 14 Aug 2026 13:44:07 -0700
X-Gm-Features: AcwNN1Ws2u7TqlGkWkPnRDhb4Ze0atWVAAtFKe83ByDo08JtuB09SoN8yeYeXKU
Message-ID: <CADBMgpyY6R_YmEqhZSw=88-Bfkv9=s-N-x1siE1uPAgH_fTURw@mail.gmail.com>
Subject: Re: [PATCH 03/14] objtool/klp: Fix false module dependencies caused
 by dead relocs
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Ben Procknow <bprockno@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Wed, Aug 12, 2026 at 1:27=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Wed, Aug 12, 2026 at 10:33:51AM -0700, Sean Christopherson wrote:
> > E.g. if (not-so-hypothetically) one were to try to livepatch
> > nested_vmx_enter_non_root_mode(), how would livepatch.ko get at things =
like
> > kvm_service_local_tlb_flush_requests() and kvm_spurious_fault() without=
 also
> > creating copies of those functions?  Wouldn't the kernel need something=
 like the
> > below to exempt livepatch modules from the restriction?
>
> Indeed, though we approached it from the tooling side, see this (not yet
> merged) patched:
>
>   https://lore.kernel.org/fe5a00818e06ec613344d41d5944de054fcd8832.178613=
8493.git.jpoimboe@kernel.org

In the case where KVM is built as a module, a livepatch to
nested_vmx_enter_non_root_mode() doesn't seem to work because
livepatch doesn't allow KLP relocs for vmlinux symbols when they're in
a patch function originating in a module. I was able to recreate this
failure with a simple module/livepatch combo:

https://github.com/dylanbhatch/linux/tree/mod-ns-lp

Is there a way to work around this issue in the .patch source itself,
or some other way to allow these relocs?

I'll also send a reply to your V3 patch with some more details on my findin=
gs.

Thanks,
Dylan
