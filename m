Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAC481A81
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351685; cv=pass; b=CmgoDxDCiVdXZSfMmB+ZeKsBWLvaJ651pejsYqrQTW2w7MgqVUeeEMDmWLYFZZU3hhIVCkdfNxD7jLhFV4zkyWJbvyfv2vB+Go4+2Qq7T4PhxWq8DcjF2qjBgbAAbW9jEdYJeZrULGm9roHeLU+2Ga5Vb3s8mKxOR2mEgPuM4/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351685; c=relaxed/simple;
	bh=O3O45DqsLokwqPS0omzIYIneY9PP+a3pA033onKzYkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=momnTYvt4cTZt8EcMbIgh6SEyfOTXlaa7HQMXvv91t5KzHSoDsKl5tXmh/ul+IIRbCwS5oYPCkipuKb4iSK0A+BAuDTH4msix6XHhHyb7WQfsYEenvSbX79c0Fa0CuwG92MFtyuBbY8rJ51cur2wHN7U6LaTcJ4P0TOMtk/5yPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7IGUG+C; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7IGUG+C"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66e63c2c9e1so2455795d50.0
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 05:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788351683; cv=none;
        d=google.com; s=arc-20260327;
        b=I00Bwb7l+pfawgUCLGxaVPv8etnuIPWiQK8TRs61oN/vw3UhsvavQXHnvnSTkpDnzC
         pCE336i0homETUhY7cQtmuv3kViG7m0638h1L89+plgODVweF62tkVqno2zWvrqWy+3F
         LjPKOoDx70qXy93ifz+SiROdrUXlI8uuCjb56QklVj4ld132BFSCMs7Yjtd7Kk57CR06
         Sr44zX9QEKDNLwtrnzH7bpck9EM3ceGGVWyHNF7guQVIGekQzx2i5Z1jqHouDXCsRlpK
         VWAgZ/UxTx2wzjBhTfxQTEnlK60wijGcaZW9erIz1ldWCQ62nh0SPfAsZ3c1AcaVojB6
         Fd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O3O45DqsLokwqPS0omzIYIneY9PP+a3pA033onKzYkk=;
        fh=tM0i8XkA7ug6bzlqsvfIgnbg5MXm/FuW8xhMQCzb3kM=;
        b=cZi0EQsnMp66AkmrrQjLfc5XikVGxTcgQjpTAW43aWf3TrEHCfMWfyfRRC+UhYeOZk
         hH4zfr2vHUfrxGNG9klj1INJHs/ZdKFfQ0YwjXG8bFs/yJb+bIdaQKoS9xR80MH8Gfgp
         3O0aqAS2bHBkTDTe2DWOWl8McFF7DKEVNRxf90NyIMH3oysI8Mpi5pNSjw3m309VVvVu
         tN+kyz6m9VTe2JjmJiyLTDOok/uUkYTN2kubGQPbf+ONd+blsXv4xvmRUKH03ffK0H36
         jCui7bLq6aH/sX9/9VVEs7tMBP7yPqTz8aJ8kvqA172JBtKjU1vTEHp70TSPKZRdHxgM
         nCBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351683; x=1788956483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O3O45DqsLokwqPS0omzIYIneY9PP+a3pA033onKzYkk=;
        b=C7IGUG+CK9de9V+6PNZwzLz4Kh0Xt8Af89ZL3caHgHREkbZSN3U7BCR9pnxbt0qqQf
         GmMmkEpQLIWcAUPclRfIcQtdz0E1MSqyBVWhss52Ns1sD0ohUtQ4WjOXnpa6EtiOzDZO
         Z631CbN2XIBAeJWpi+4rkMpQABAGPrhhmgLya9Cl6v45K1F+X8SUOLZgTehAfZEox/v8
         JskfW3msHj1Ka9eOGpHSaySca6uyNMVBeXsO47wLBUTn8NCSo80KPswEoxCFrdU8NsJf
         ubARJfVcQW7diQD0l6F9N7yiI61upxJfqx6JBU4dV5GWjPShegVYgx4ncAF74w/Om+E6
         xNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351683; x=1788956483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3O45DqsLokwqPS0omzIYIneY9PP+a3pA033onKzYkk=;
        b=IYsS062hFpfCtzPAQSyVVlpR0pIipivnxD8PpMDqQTLHYJyIWrSH9KC39UZ9AYiktU
         qJmr1nSf3HuD3c0p1MhziYWX/yfEtkL5dTCWhf7t+OunVsKLESJV1ratbZT8EkH0GAGt
         3RteM1CmmiRzV4tsq5wxlhfwmz6JAaQP4hI8WYpKusC9TnPShYHc7oVOOnEOSxiXiVgS
         8quy42Zt3fmIbZUqNqBP3SI6XvRZvveN5vb4gDH2JcWVuVSUGwTdIERleGuGuoGIAVwo
         NV8f+68+6FV3OIf4CkJgtCeMdIAENGxvLHxE7z8Ho4OHyueA3f2/0Bymxuu0tDte3zT3
         Le0A==
X-Forwarded-Encrypted: i=1; AKwUvBwGw630QZaevZGQC1/6N5UaS3G9x3Xuuy3pDJABjfolM3ZwT0ICYxcWSEO6oEacgBgE8LthBTdWVSUbY2wm@vger.kernel.org
X-Gm-Message-State: AFuF++kOegAY0xyqNpQ0QM3YowCufGvKrs/Djbs++pTXdFqh4rdtmFTk
	Gf1buYrec6d5zaxtD39lCaPfd643IEmas9xySUb6OtQoFy9JU/qj+4tgxtqUhQw+6pUFAXarpCf
	Da5mfhPTa2H12qhpclxIDhSpYcnB77TE=
X-Gm-Gg: AYBFou0fAB9tHI6cn35A5b3LkOgu6RYnCyvX/UF2IhIVd+P0Sp2Q8fGXjj5GAGwIW7l
	bPx/426Ulvm3ZdCopzEFDx7xlqz5NBv6bQKICxcG7roKObvkDKytAez33entSgfdgpkfCBCVcec
	i72WYerWVgON5L8v76OqI7n5juJFPEqGWEHdFgeEYs+BQQhexCY7vz6uuDPhPN5FMj+L6N4s2js
	q2az/Cd4r7CqOuj47Xq6NfrUjCGiQZEjV2oucuOrICRr+Io39FdSgholuvkaGxpQG0sS2CFAqkf
	0Tjcv1WlOeYAg5qjTaHuj5yUzw3/uFlSDpfKXLX6Lyc9vckOGe8qh5RsTGPNGumrYKRMuUjivNv
	J3A==
X-Received: by 2002:a53:a384:0:b0:66e:5332:a911 with SMTP id
 956f58d0204a3-66f8a5168f9mr2878368d50.21.1788351683003; Wed, 02 Sep 2026
 05:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-5-laoar.shao@gmail.com>
 <apgQB-N56NtTBF_C@pathway.suse.cz>
In-Reply-To: <apgQB-N56NtTBF_C@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Sep 2026 20:20:45 +0800
X-Gm-Features: AcwNN1VuVhnzGESoyXhJmahRcNoRtNHjkY6zisRY1VDthhNq3zdU_9bHtdfmElU
Message-ID: <CALOAHbCPfreoKSNNx6JSqNY7amTJrxM8yUdcF5eq5yb6Bv7ujQ@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 4/8] livepatch: Deprecate stack_order
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
	Wardenjohn <zhangwarden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:01=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2026-08-25 19:46:37, Yafang Shao wrote:
> > stack_order is no longer needed for atomic-replace livepatches, as a
> > single function can only be modified by a unique replace_set.
>
> I would avoid "replace_set". As explained in 3rd patch, the term
> "replace set" is ambiguous. And "replace_set" with the underscore
> does not exits. I would write something like:
>
> <proposal>
> The stack_order sysfs attribute was added to determine which active
> livepatch is used for a given function. It is no longer needed because
> recent changes refuse loading another livepatch which would modify
> an already livepatched function unless the new livepatch would replace
> the conflicting one.
> </proposal>

Thanks for the suggestion.
I will update it.

--=20
Regards
Yafang
