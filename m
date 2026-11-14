Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794676291;
	b=MbtVOYmMjQO5yEdX2NrgttZl01pWLXkVyeO/FY1OmGDaM3Ub6sBICODNzxBUWdACHzuY
	 XWNZ8iMyGXFvBbyEHjBtEExDPPNPhkPYB6S9OmQesygFs5LiviWrNXWJb+WcmwesrLdw2
	 yuDSm0FgUakz5Guj7VND9ISEwAsX0+XrozXpUjmSLEFJdCRoreb9vNKsHA9Iru7g7I4gL
	 sNI78L4qnlbeVWmu0pQsYfF0wm2EA6OfP67rO0cLC0YakiElOyZGNGHbXmLHNmTnrGp6C
	 0Q0q2pC2hCK5qEPcj0U+zo70sejY99BRBUI9l3zR8nB44gtVDq6IyBXkvBgS0X6XAcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VSOfGERFH4pEDKWamyJaLP62gyGxpA0Ka4pqh6Z9BNk=;
	b=RTyl5dqf5rySGqnf1gZHMzXM9ZUY1nL2iL3Gk3FQ0xv3G6bxjbQD2VCOZpPkMZefOvi8
	 2GmUluPaOVUS23RD+jnHwP5OFMaDbwiObOJtoIzSO/p/6+dnqocP88ZmNT/VUAtTr6tey
	 aYyK5iYxAztG0xflXk9lYuI+uU4Col+8CMzp9bpvcK9sDk6tt1O/hcZGNG/l6STq7/ix/
	 Ad53Zx4DKjRSKYrIIqPrZbTUtXOw3G8cxv7jXqsK9GUvOkRfyfEDhUBJftK8Au8M/655v
	 qhEoAYBqv5EQmbLrwo2+NhQ6QHJsD3Ne8eT3LFb5avEKOHureY+gzBD3cM/DD+FuWWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHfKscxP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3A606A323
	for <live-patching@vger.kernel.org>; Sat, 14 Nov 2026 17:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C3A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHfKscxP
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c6f1019a3so2316463d50.0
        for <live-patching@vger.kernel.org>; Sat, 14 Nov 2026 09:11:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794676290; cv=none;
        d=google.com; s=arc-20260327;
        b=ULJJgDMjXAqYH/rXmxVtqyxkLCzD+dQnzrauDdKq3kD0Kbm3XLbKg4dzZZVOE0b41d
         wzwxTSKWLVg7AnJkbRpol+O9rG3/6dd6zvQ5cz0uogCvUDpjDOtTDydI1y8s6uxqFcXw
         rC+lIo36SSlhSNeqxizuKEp0OAwqfdyFkiTkHWp1uR6RhJ+24PNu7a8QCBkBirLtofF/
         jWRArDFGODOWZZkeA3B5zgJCz0+KNsFQmbCAvEQ5nssTEedodhqUDHThI/l2K1WSxjPH
         47P6p5ZRqrWBkK14pvBCVWb+fofzyJhv4ewoPKA8P5QWK84Xb0UhspCxVTJgeLpfZa6H
         cKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VSOfGERFH4pEDKWamyJaLP62gyGxpA0Ka4pqh6Z9BNk=;
        fh=fvQO3mpVjpRk/WbW8240vllbup8il66jqqObRLxMAyM=;
        b=gGkUTCNH6tHPipPV+NRZLRDeHCHW+Us1r8I3ybekPRSeU9vIBQnnubqpsTXjFAHgZR
         Vkln0H+HFu6lXjoW9xPSdmCcuU3vdp24RIpQmxAfMObYku97VqyN+C+ikNp7HRkiAo3h
         oTNJvjXSBbkNnFRd7UvyNrEz/7jRBHLTSPbTQDnV3RjYmaU6FIrglb0z3NH6SoM/n205
         7yoFcmGjNTDcDJycBTZEvv2Uf4ZEMxuB867jwM9B7m7cBHXC4PzvJ/GAUhK4bwjRR5OW
         hIB8YVZmfcTZNRhoZk3AEiQSJhnnJcDJoe7NRQHohsD6N/pv7hOhSl5Bm37P/keUecld
         ZNhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794676290; x=1795281090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSOfGERFH4pEDKWamyJaLP62gyGxpA0Ka4pqh6Z9BNk=;
        b=CHfKscxPs8539x7E4zQhLhGlVq4r46kaEqLOWYdcsgWj70uDsw7b/2JzILz/RI4N/S
         oHiMEk7jvfcsum0bDbG6dwxgnmVbouto4NJsgAm/agziM0rikFtXiA5mqimhdTfXvNLZ
         AXmdYT302MZUTW50GtBwPL7oNfuaTdfspfGa4TngY6eua0ZnrRcTg3007eT7ya3AtnbC
         5+l87GUVtmxO35Hfyh4vpo9fX0xmBmJGFWDN+qkZfZPGliNBuTyCyQxYY4jB5SMA91Wc
         fALtofyLAEKNm2LIFnd+97w7Lo1k9XP3PdOQv2uFme3N4mIrajIUwM1VqQ+PIBr03wvD
         I6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794676290; x=1795281090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSOfGERFH4pEDKWamyJaLP62gyGxpA0Ka4pqh6Z9BNk=;
        b=nQbP9WT4rWVsRFwRysGrw2pbrSCSWTtpg0iRqg7UvqSVR9WBeg4J7Rxpor8U3MJBCM
         3VPFPxSusyIVJR+kWj85oVpvXTQhJGXog+BDNRG0cymO5Szo3DAgW5+aEgH2yKXRWNWG
         6+8/3BRT0k1iTPFWpMMEQXUpdKsv7afbtrBiPvY91qBoOYfCz0vNbK11BFSBDW1VrvAr
         BYw9CXNJlOsfdWekwKEBosahBaiWVWk+SYmjBUbjS91amaR+Y00K+d+i0ObSpVGV+EIJ
         a5CoRx2H7HLKxxQZZhVLdkNJpsQqVvRvsQlRVCgH3zP6ytfvjtizW1e99U6yYq8n1o+g
         nDRA==
X-Forwarded-Encrypted: i=1; AL+hErE62x8FRvZ/xL5Chzdi9hrVJ+p1e7ivfDWrb1117J+RteUmUmwfvpixgM87u4MNP2kKxz7EJmMnDEnYU7Do@vger.kernel.org
X-Gm-Message-State: APuU4Z+AuzgOvRhrIGFgP7DrZtUh0MeLD6YYd9tMJZ7hZJ/cYsU4W9bi
	DbAZ4WxHOcXtTUTWCjOXXAG5ieKvuqudEFd+FphO5r82qgHZ1Sy2+W9aWWbUxHJIHhJNIjl0Ss6
	TFlak6j2oSk2AYSoIyvSXS1TcB6ZmHMs=
X-Gm-Gg: AYBFou0ApsPRS1S/GG/c6CFM9YSKSKroCoILc7DteewSD8wcKEOCFXge9DHtnVay5ru
	znVsSD9AppIrA28l2+k/fmpzwkwWEQjvf0Aq/COLePfT6yozRHIevx54TxH0ubYg+RrgidNt+Sv
	bPVdGczYXxWM1+plct0guAMLLhkxyMJjwkhmDmaQDts42EAwaOL5Ucgb9peMMxl1vvIacJwC0Z8
	00AHwEe6Ytx1anr/aczds1t+uiRWFVkfP3Miuy56wHBWehYnbBE773eZ/bSq4dkMT77wh2mE/d3
	D6IcJnJDNxpRIoKBMr2cbnc0TAcdUkjK7w2xf82uZ2YwgNzHrSN3uMK3rgqYfi2CfJSarIEuIxr
	T4ugmejJivlY1M72an/llUbmcO1hk75WwsdYvFHs=
X-Received: by 2002:a05:690e:4845:b0:674:981:a937 with SMTP id
 956f58d0204a3-67d8972f1eamr2440317d50.121.1794676290257; Sat, 14 Nov 2026
 09:11:30 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <avZ9Ku61M8z-2axF@jpoimboe> <CAKL4jwXA4OBVLFGAP4DWw6i9d5bneU=Ur=D58FnrssOt7ygm6A@mail.gmail.com>
 <avdWz3m2YJnlGgnS@jpoimboe>
In-Reply-To: <avdWz3m2YJnlGgnS@jpoimboe>
From: Longjun Luo <luolongjuna@gmail.com>
Date: Sun, 15 Nov 2026 01:11:19 +0800
X-Gm-Features: AclHuK8SkhxY4RW-7U4DuqAnwzbj1NmDVqMiHao8193oK5xeW2NzqHxvET-tpi0
Message-ID: <CAKL4jwXicjF4xJR0HSK7X49gUqp3df1_sGF9KBmeTKGeE_uwVw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] objtool/klp: DWARF-based cross-build symbol correlation
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, live-patching@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thanks, that makes sense, but for upstreaming I think we will need to
> take a more iterative approach, even if it ends up causing some
> intermediate patches to be obsoleted by later ones.

Agreed. I actually got into livepatch through kpatch =E2=80=94 I guess I go=
t a
bit nervous and wrote the RFCs like papers.

I'll follow up case by case within the current design. For cases
klp-build leaves unsupported for now, I think documenting the limits
would help patch authors and AI tools know what to check.

The two RFCs can stay as background on another approach, for
cross-checking and future discussion.

Longjun
