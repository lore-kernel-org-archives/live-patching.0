Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836273;
	b=wVR9gg6g9v8I4w4LMSUSDoqJI+lvtUlt/sNviGGGrC9s5EJBWKhcZchQM4nh1Nmli0WG
	 2Qn4f5YZLppwkDETg6poVu8hDysX64c2uEM9u543oEhqPXuJvXTW8NDhdJUI3XcG/6/Kd
	 a+/d9bYZvr9OC1kSxG1Jxw4pZbP28d6BIbMCiC3XhOliF94MdXmyyFkdr97nXpLv26cRt
	 dndLX7EZ3ClfzQvxHG9v1/+RN6QRt0nC3U29BhoZweNdQoWgouXr5Ngatjc+TrUdPRJ6f
	 DJOhbCgnN5m0gQ9HU9v/xprrtXQH1RAdpFa0UDGnBx2k2dOC061CCzsShwfM5hAVQhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XtCTPF42T8b9hGYoMbuRmFRm0maPqH8IWbUOhB7Rxz4=;
	b=ByfoyXGM0sLhdeHdgzn3MZfUmsjVFdKb7DVHZzQJ3xytw60Lng3d+w1OFl/AJyh7iPCK
	 XQVepk0pkZtCJxA/Tdw1bSBjhWIJut/vatSMYcZia8P1Fyfv6cC6Y/d5vHi5L5TAYvqgm
	 ukLiZni7c5tYhRVg8DiZjhN6N+6Lel/KCgQsRLIPE64zl8cxBUP9bHTbI+GNrRJTdKCOY
	 Kl/+dRdXyAExC7EIRSXzPY6Ni5GLSGb9SnP8i7J3twfmKuzCd6oOwO6KVYF8wr3MyxLNg
	 I9w2wOlZVRqqY2UTJS2eADaZ9WkF3cak9UWDreimyTwzh61qHAUJ+7sduNB9+xOIuGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1COr+hJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF8606A323
	for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 13:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEAF8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1COr+hJ
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4dd5cb4f6so4851527b3.2
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 05:37:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794836272; cv=none;
        d=google.com; s=arc-20260327;
        b=SraWNhOqLi//dczNGDMu/1M4ijKQB8oFF9rMHZTIEKnVZoYgofigdJY6kRXTbz9++E
         BzsB+rwt04FAFNmypliu5AFrhJo35NX64XcTn7T96n8r7CURBHm/QHvohYcrCYA8tXm7
         JHE0SrYAfI2tLwghAqkPL2rc10L/S2pnf/KSjLl+EL4ocpRLH09n1T3rcWGu17pwXCCu
         rvd8eFkyFIMAyJPUrIumk643pHNqfn2gRQZdxBtdAI87Z+tVAV/UAtfHUDPwwM3QMIaR
         CMIusMTjG74KJjcO09qWTbXsFUXwuS6vjdaorWpd5uqfK0sZRShZmFTPhmEEmDUTnPcn
         PwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XtCTPF42T8b9hGYoMbuRmFRm0maPqH8IWbUOhB7Rxz4=;
        fh=zwlFluTC3mg7F7WMu2DpLFQHHbcm5zVmyGQXETRypZc=;
        b=SqwE96p7MMaJGwKXdacIZYIyKmcTJnWtH0vj6pe7Hfs+YYbWUnBr+N6iRLZhDSri/p
         nbnwayE0PLPfvzUXRrKiagteaxWh11SCXvxI8GO9QVQ2NZRMQCkekDJ8QqJqXgIHZXSp
         RGcsdiSEzbSfaqJg2Bfrb2lXPAkk20GRron1Dn12p3Ced+u88oot9d2cmgcalOAnuq7o
         dw97VRK0r1uxILgwJzIhuAG63PMGBwK5iX0uslRhbxevz0eaRk3vnRHpeyxzYiGZwd5F
         +eA3lGBYWoRJUIUlk2aZKxevheOXgSrhoSbvA6+lbUkRp+4PRuYIsHw0ZX0/BeMmEyg0
         jPtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836272; x=1795441072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XtCTPF42T8b9hGYoMbuRmFRm0maPqH8IWbUOhB7Rxz4=;
        b=N1COr+hJHnFJtHj1vwk8UdnE52Q+E8KYAZrvxTz0hVta9xnkKrK3TwtTWicN1Lx+kD
         C8DqZdI5CjTl0TB7SVxf88PdQ6OxBOWaFZOke89Mh/tkmqmr+mHpiH657aRuKaqHXswS
         g5+s9plzxZNdRQR1SrZB/urz+OY8K/cZOg8u+KHOJsiTsjwHnMXUXrelpnzRlHFc9VWL
         HUDawZpHeaAqnSej6Tk2MlPv1oCW/Iabh+pC7JIx0UaX4qpcsTAqWf6H9v7CjG2lq4TN
         Z7u1JkhOs4yvLDBQCAN/EOJTqlwJG/Xn/oQmuvDOp+y/bcLxOolBtEXK/T8zikkLE47l
         Lk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836272; x=1795441072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtCTPF42T8b9hGYoMbuRmFRm0maPqH8IWbUOhB7Rxz4=;
        b=MiwPYtEh49CPPxVj6T8ciH4FuAwHABf/va33UMACYhr+jKMgcw9Qu0p7CutRHQZE2o
         3zd/FS1F13dVjj3KrEx6PM1/PofHlnyomLnbDKgqo1VVlVa3jWAZ1rv44qAN3D7uLf68
         qyxUydGCCa0IzPd9yu46z0V/a4S6zsauNVsAWzt3oJGaC5EDnDpbc0W/BHpc3kwLH9s7
         H1+3ECI0ULtQnFLzS5UuOJqeAF8fHpyFdndAB3WMel0dXW06TCUNwlQ7k01Ik+CbJ+kI
         0tQIM87PoNxRyOE8ndbPjm+AZm/Evsrm1t3FVLlTCjDnz67zBZdCOW+DYicnvKjleqAI
         GKiw==
X-Forwarded-Encrypted: i=1; AL+hErGwdq2fT9XdwlzRCSC8ryWNe5dTv/N+DvZaDFKjo6//dhh29jVucDGukHYrkSwl7mW1NU5KF+Ld4PM1X3gc@vger.kernel.org
X-Gm-Message-State: APuU4Z9CI7DbnED4Ajt+FxnyxVMK9lFkDmWt1y9ODnv9wKz8x37HpymD
	EBXfnNJ52M4cphfIDf1BxPHQSJtVDXObajSPQUWMonBuQubggCiAhqbjZE3OCPgQDQX1axZSM/q
	P+zZjwvcPdG7PA+xxXFF10xp8IBKHlG0=
X-Gm-Gg: AZFdTZffYGXWYu8ow1aqZK0QDG11vhQMbJixx4kY2nHmi8eXabtnHZPyWdZkz4wYkk0
	RbNpCkhAPl68sPoOroWgikZPtRZri/D0QXRXLc2ycDx5jCoEbhF8mlWJta+x7tGC12oJTG98pkZ
	ispw0ozDRk3VvsZQjmx3XPW5IfAciDvEYXG2c4u62Jp/MNbHAE96WACm1NzUpDYcQWBZ8KN4g1n
	u+qEM2g/kzI68rlAoWABKgTDwAICwMzwncrMoN7uud8qUJya5q5i45XH4yEd5B14p9970R6dIea
	b7EzqhGlMbiMgttW64YmTUNakQpyw4B8a94F0Mt3v7jj8YUeO7jA/XUKa0DCQG9Q3pbGXHovwnF
	TtibrLmLx9h7yDEeYrRJ20R0aaqjZ8hlGif139eqPnHJ3aZ+7hzma0Jk6UBojrOfjV9c=
X-Received: by 2002:a05:690c:4990:b0:8b4:d9d2:df80 with SMTP id
 00721157ae682-8b4d9d2e1d8mr11602807b3.24.1794836271953; Mon, 16 Nov 2026
 05:37:51 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116130402.76743-1-laoar.shao@gmail.com> <alpine.LSU.2.21.2611161415040.24417@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2611161415040.24417@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 16 Nov 2026 21:37:15 +0800
X-Gm-Features: AclHuK_scKVRISfJh6JLUDO_gLNVsNPruWc9LBo_91kDk9tENjU-81s0EN9Mets
Message-ID: <CALOAHbAnfpdeiy1NxkX=DB_s9NW9_TDuGFSRYaBqiUzMK_fu0g@mail.gmail.com>
Subject: Re: [PATCH 0/2] livepatch: reject internal flags set by a patch
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
	song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:18=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> Hi,
>
> On Mon, 16 Nov 2026, Yafang Shao wrote:
>
> > While upgrading an atomic-replace livepatch, an application in a k8s
> > environment reported high latency spikes.  While writing a reproducer
> > for it on a test server, I unintentionally set the .nop flag for a
> > function in the patch, which triggered the issue described in #1. I the=
n
> > checked for other similar issues and found the one in #2.
>
> a nice example of shooting oneself in the foot...

Right. I hit it by accident while writing a buggy livepatch module ;)

> is it really worth
> fixing this? If yes, I would rather vote for silently setting both
> obj->dynamic and func->nop to false somewhere in klp_init_*_early() path.

Since it triggers a noisy WARN and a page dump on the unload, I
believe we'd better fix it.  Resetting sounds good to me and is
simpler.

>
> Btw I do not think you need to add the splat and the live patch source
> code to the changelog. A simple description would be enough.

Sure, will do.

--=20
Regards
Yafang
