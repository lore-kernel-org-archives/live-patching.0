Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443051;
	b=m52P+UqiQTI4Hcbf2QEukv50x93RF54J6RJc8fyjjEG/EiXBqIoQOqPM+9M+4cB9LGsv
	 lUUfH0t4F8WNXeWix2uu3rJK2cBBNybBDraGIs/ubTS4VMKwFPniDuO0rHGK+aa1O9HVm
	 C2PYtMKadp32nJUybMwKfvFh5gEuKF2z+DH2tMf670JaVGOZenj4F8JMh3VlYfEmuGp1w
	 PbBZ3fDnBxpZmpfmXYrZ9Ihz9LpQMGnUg1aPk7c29c422RjzccgzGsdVEsTCQemyxIxtX
	 1ZQZwWCmNAXXB4VBTB94+YAd4DpsiweOYjLkoNwihCBJlldstzRPWwX13T+pbMp/sPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2CrQ8byNBxWbycTnDL6KtWcb6fchKu5DyLo4nJng2g8=;
	b=Y2MjoyyiOD/bHT/iTw8rTXr61S/dvrvG9zqihb5aTgEFSHCgATxf7a2zXe9k7w28mbYZ
	 ha0Yh3ztjxGH6Sb8YYJmw5qOe2/DVniSkbIPdji+W2GW+xPkmMz/G+luWTrExBIgRZK5u
	 BecBJCG2p3o+7UXFJyoOHkhPFK95DRzZ8uaNdCU/OgvUm+X0x1CfKctc52M+nWOyUBmZY
	 8P+mIrPJ68x39rZkmS0iuKOt3P9x+jlS8i1daE0Pq5LkZwqVrLZ8m73IuAKtce+CUTsM+
	 9z53hRdjr/xpdud//TLfBRE5sdAi+gTOve0RBv/HWluVzBAPilNX1dNu68vLNq9kCXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=QO9MixTI;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F640606A31A
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 14:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F640606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=QO9MixTI
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso2994510f8f.2
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 06:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795443049; x=1796047849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2CrQ8byNBxWbycTnDL6KtWcb6fchKu5DyLo4nJng2g8=;
        b=QO9MixTI3SP6WzE673jroWTo4bM4VJt8wUzo6e26AhlaT1vPZku4GxlHYdZkB++1gL
         6oDwK0YsLcoirbLz7+R/HCxBIoWRYpkSTs1ly9d0bUqWGuA/B2RjKRD/plP378Q2yBID
         HgVgBVcwprrmqfdg9S9BK9pe1GOlQHNzDsrEXaINo05GNOxqnpyBuWbO/D+BOguSdtck
         51mqjOQaJ99KVbwqD3cLe4GSow9FCrIQvndomR5pb3XB7G1NhkSUPWhFHCKsMXhyR06t
         X+dHBs69Du8+rc0SQFdHBTb+O4PnXaWtVWycxi2/IVtqCeZotAjOc+BGgpVj1nglB3nY
         Zjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443049; x=1796047849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CrQ8byNBxWbycTnDL6KtWcb6fchKu5DyLo4nJng2g8=;
        b=D/G19ppNdj/gi65L0Qho828OclMwFR4/lNaeGUgWdLK4iHVIyKr5Rnm9BIHuyDD8Gb
         DoI80LHrCxIjZD4LMqx5z7+gVdYtWcCAeJ5M4bbkbrZP8flzONI+dr84eO4X8xjCy2Co
         XMbcq5SRyBCo7hTg34dBKjX+AVH5Npekr7YhRjNbpLH4UV0Gmzmd5RLMPzE65OjkQ/nm
         20DZbyaE8MOLQRM4R5VsNPtiGfFpucqo4MYawKniV6R0PR17930cojC9V6lyFWViq0+Y
         BGO6EXMS7vhxb4prwTEYfPsAMkUQEfCvjmi+8qQBuOkIC5GjgdKJgcGAOEHTjom4U5N4
         hDlA==
X-Forwarded-Encrypted: i=1; AL+hErEyOZI/G233cf1IYAtBB2Z2dV11o7SNhGHs+bDYJkNoUX8tkcVuZ518zcwcv5fA9R6c3X1PxcxysI/YeE2Q@vger.kernel.org
X-Gm-Message-State: APuU4Z/XGB0yDhV9xKEbG9YT8E4TuHWcUuU5aPFhVWxzoNXKzRePFs5D
	MlBWazbY2nI0Z1kjz4Oplyu77hY+wTTPKE3VRXJEtLt9XxIbW9/kB8l7m1H+7lxdSFI=
X-Gm-Gg: AZFdTZcG9Ue8Rm73QdYxnxZlNHfmtYAH92tSy6UsUZ66J7OMckxe09bflLmLryD10Fi
	6Dif9EsfMDI1q46Ysm/vQtbKDXP7cpW6EJqDDEaBnC7TXO6n6+2ZEV23fJtHkWDiNE2qHsnLORv
	dEtdYicGWBDx8pPrb5NraDpLadCmHiWShwTq19bKLVI+ehQWjw6WcL9a2Qm02H1h7b56XvUvjQg
	dU5nPmxUpH5eDW3wxhlsUjKhxwRuVua68k7SaDei5U/nlcUc7ntsv2D9Dc8kk3Z+1ESA6sbUf3K
	HL3elezlmMmAwvwgEfBO+7liP4wJj72OpIH2wH5fYbVtwFzwS51LVos4m+onEx5BdsqBCPt3P9k
	51MvNNp99mgkNQGIQMJXmW5AmEx6dT48N7pb8CG9d8Vc3LwdSh/bKQ3vhjfn1xgSEBkFVlvuE+0
	FhyQOqaCIN9J8zrUhmoW62xv7FudZ7VhAy6J14Q7T34ddtcaB0auEjkQb4X6qvaLNdQkYYsDLSd
	4m54czbY7koAE+mGNeG0/pc0NYYeTlLIgRaRHMCrrF+SA2Cidbrt+PcfEhItCktdu7XgqxxGQfM
	ZEOcZG3TtdoJgn2NsEAAV+icdTEdvNw=
X-Received: by 2002:a05:6000:230e:b0:4a6:5a2a:f4c4 with SMTP id ffacd0b85a97d-4abb7d45653mr27120870f8f.37.1795443048856;
        Mon, 23 Nov 2026 06:10:48 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm23448524f8f.8.2026.11.23.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:10:48 -0800 (PST)
Date: Mon, 23 Nov 2026 15:10:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests/livepatch: run the tests with prebuilt
 test modules
Message-ID: <awRJZokKoPXdbyW3@pathway.suse.cz>
References: <20261110161050.2451750-1-sashal@kernel.org>
 <20261110161050.2451750-5-sashal@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110161050.2451750-5-sashal@kernel.org>

On Tue 2026-11-10 11:10:50, Sasha Levin wrote:
> The tests are skipped unless the machine running them has a kernel
> build directory, in $KDIR or /lib/modules/$(uname -r)/build. They do
> not need one when the test modules were built with the selftests,
> because the scripts load the modules from test_modules/.
> 
> As a result the tests are skipped on a machine running an installed
> selftests tree without the kernel devel files, for example one
> installed with
> 
>   make O=/tmp/kselftest TARGETS=livepatch kselftest-install
> 
> although the modules are there.
> 
> Run the tests when the test modules are available, so that they can
> run without the kernel devel files. Without the modules, keep skipping
> the tests when there is no kernel build directory to build them with.
> 
> Fixes: 54ee3526796f ("selftests: livepatch: Avoid running the tests if kernel-devel is missing")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Looks good and seems to work:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
