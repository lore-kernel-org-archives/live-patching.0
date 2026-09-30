Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC923BF91
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739039; cv=pass; b=BJ6YHfhAVbtccoNch7d16TGdANmjtsHWFq6Xxm4ZTV07QWbOz6iVtgghprHRonbcWZwG5nHDRnvYrnlW+cWRa3njk7Wm8EX15zhf/XsseQ78A3PpRefcCxboMtqdy8HKDYUN2zc40U/cupACK624Yr9BhlfzWMxJMKPr47vh5Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739039; c=relaxed/simple;
	bh=63h2jRpyI+1NH923VQI2q86vk+ew88Ebv7NZcuaSHTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WibAgYFF6IXu3oLinYD6VosbIRS/aRlEkhyfJQuy/urWPQrNRknDORzH+C6KfE5rhd+fBjup9opULXOdU/aSr8BFZ/oCS5S0ns/+UmjLTrgYqug7HQzg7g0qyBSF4TDl4NWTpb3qfwFpCaxKdWPIn58rwmCpj2Cuke/F1OjYzGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad5dZzUC; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad5dZzUC"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f4b7091dso2565135d50.0
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790739037; cv=none;
        d=google.com; s=arc-20260327;
        b=io25TuiJOJ5Hf/81DF9HBQXfJZyf5tjz3qTpNXJV4Ue6bl6Bbz7VN1saH5fR+iU28I
         kAAPawLneiTZzV66mszfK/wUNtnHlbamxA2NPfonr8rL97VDROVJZB9l3gvk5YrKf67L
         AI/ECsy2HiFSX4klB7O5LLDkc/MptOYo+4MuP3THhyJwq5y3ieS2Rq1bFCP3MXNudrtb
         hUXCSiJ6o5IS5G7jlIIHX8QRPnU4qjxnWOMqjyXL47ouZ9xOmwvsoWam21wrEKaBEZ/g
         86a2sFItjPHuT9uHmDWvMpnv2iBXPgls+JUlqx9DRnnrIX4OrcPiCMSav7194ZkKSA1g
         D3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=63h2jRpyI+1NH923VQI2q86vk+ew88Ebv7NZcuaSHTM=;
        fh=CJYY4uaRFS5kK7u1D3H16sEpezJViQAgsB/F2ECw+l0=;
        b=CtJigyxQyeICjhun1t37WYJdvbaKdTf/AnnONQtlAdOMeVpFIzFhcUVGyA2xtY5FBH
         dofsriBA4KaKLCty3qATY8oTy+PT3ZVX8qMGqqBgFF4FwVXzh5gB79IYXmXKY65AOAjn
         2FDBttn1g+xG4ngzZtePpa1BKMD6q+F+0hDk/LRtXshaoInLWnbQwA91MkNhI8XpiaIx
         RuxtNLSx16giUZEoURY7rI1UI1cjr70S8oKOvIvGV5m/z89nnbtItZiRwYZSpgA11ZBI
         MTiBojlrCeASSrok79MvBwq437AGCdu/akkxm58++YDs6PEt29+X49CWy/BiMPSgLpwZ
         nRdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739037; x=1791343837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63h2jRpyI+1NH923VQI2q86vk+ew88Ebv7NZcuaSHTM=;
        b=Ad5dZzUCJd5+IojDGU54pCuBAt6GbCWd4ysim1msYeMiWEQuUcxNhJyDwQvLuTwdbR
         w/aqdTfKiCQtuNWpHRaXg63eK43ZxLLG0Bw4+ansDcmgiE1ZrOtJo4ac2tZAl4LmAgDX
         Q5LqlBAPLBbifhYoqfWFdXzOurS973EyeGvUsTGLkMKtXu+ixAfxcK6jhn8radaHgzED
         6sK41ZXQb5OTf/0L77KCRz9Y1LMvrZvxv+ak7OARQn/PMJSqzoN1sfjHZYH2SojhE/PE
         gE7FYKjj4/WWYD2rWQAXjDwxBTlKiWSk2JmSdWJCFX89UKDvHcGroUlRBz1IirTheh9J
         M3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739037; x=1791343837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63h2jRpyI+1NH923VQI2q86vk+ew88Ebv7NZcuaSHTM=;
        b=i7AONLliPS9FvyApawlaLjTGtsiIwBsivaCQXefMBeoDJsdbQiJNungVFH7z9xICmR
         jaZDgCzAVbKAtFL4LanXSPlKcl7Sh4pThTai2MYGo32/nUhJutXRTZjjch/7gb0ve6Jx
         tPQ/YdublwKreQ9ytgxhk0DZDmAIridv/4r5KcCMZ8q2ztruhKmYNf4LtkmEgER0pyFo
         uHOqV3Px2kidjGSEi/QxICWLyFlFt/zFckI/VoOwV660fEUQKg2Ssu4r2MbDCsmotPwb
         yLwBFC9Vb0WPPh4hqbxB4bsZiiaPZacpvtv5U0Os+aLybVmkp5AjOuOepbkGwc9kx2Pf
         z9pQ==
X-Forwarded-Encrypted: i=1; AKwUvByUA7CAAjqiWoXV9TsxaD1/gOr2iXaIMPhtpNIOYJqki8IjgQDl91vpgKw3/lvQi+b1udyT6TydNA2e0IWd@vger.kernel.org
X-Gm-Message-State: AFq9FYLWjKyjlhldHxmbYrKXu/Ggr3/Eh0F+lhrRvtGykank0NaG2PXo
	hFxvfDo5iwA4pYnXCNgd3HQxqO8MmiD2/7VNNB7q+HjFTciy2/d/mh8NcOdHejZv3HV3vjILuGV
	KvxpibudN1wVwTkGxtBR11aAXEFo59kc=
X-Gm-Gg: AYBFou2Zs6X//AjmYrFx0ADiWpvd4nDwwzly/rKZd5oMQQy8p6ZN8C2h9ltGahNDVyi
	fxhTtettQGfL7eL4MsEkHuquBt5OKpUB1NMP0YbvOA7Exy24jlEyKC/PT+F3N2G0qPTTs27nx++
	2XWFtGi2w4cfkc3TmhttEk7O7HqrsgBw37vj1t/EyVkrhl0CheBomc5GgHYhg+GlUPgC6ZG9MDB
	9NO8ub1P5Sj2RfG9pjKYvv8Y6/0WaoIhT6n9xyRDsrmcU5tXoapWR/cHl7B1fJzepPswc6dZV3P
	f1ZwxSdT4xi/Q4ndTulJWe+sI+Xe4AtvJ0q8gENpyNHf/6mx8Ucpuv1gOGO+a2HzyJyvt5MA2p+
	gatrLKC0+jw==
X-Received: by 2002:a05:690e:1686:b0:675:3dfb:41aa with SMTP id
 956f58d0204a3-676838404demr64196d50.16.1790739036829; Tue, 29 Sep 2026
 20:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930030323.14396-1-laoar.shao@gmail.com> <20260930030323.14396-8-laoar.shao@gmail.com>
 <20260930031358.8C7611F000FF@smtp.kernel.org>
In-Reply-To: <20260930031358.8C7611F000FF@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Sep 2026 11:29:59 +0800
X-Gm-Features: AclHuK-cQZ3A5hHINIoMvk7iQUtahzNO9_m454roXPXhodRMviOcAfc0GZgB5GI
Message-ID: <CALOAHbBm066Sv+w6gs-eWfX5zagXV3im59S9xRwtP46+4mQBzA@mail.gmail.com>
Subject: Re: [PATCH v10 7/9] selftests/livepatch: Add provides/obsoletes test scenarios
To: sashiko-reviews@lists.linux.dev
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, jpoimboe@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 11:13=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] selftests: comment mismatch in obsoletes test

Nice catch.
I will update it.

--=20
Regards
Yafang
