Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84D402B8C
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659847; cv=pass; b=blqHkXszWf2C1P2P8Fw/fXYfZsItlVoRsT2E77p1qJhjyLhyyfN44nq1jKvn8cSjRcHOygiVVqR3h/mq5VLe5fBCm4DIIqxC46BxFTm+NsgSy0x+Kaa+Pu3CY6YF16e9R6w++UWg8MBiSh1J/MGaIEudWGQkLqoIJLYqLFOU8dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659847; c=relaxed/simple;
	bh=kJ9hrWQedvb79ipaVMOGn2vkaw9mO7jS+bNOdzYa/Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+ILGRmjeNsgp31RNFZGnDY+kgnZoQlyAt/CkiaUQ2Y7u089RWKAmnowwRQH9Wow107RtT/lNdW/iKyGJ//TT8Naavi++eQo62TfSmk5yEHmu/g0WZWu9Q0Zu/rMzJqAJq8AOJZSh5yQ2R3P1WFWDSLRlFC4bm2m3NsKKZohnM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjbuC7+g; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjbuC7+g"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-852ee3bb0c3so24196907b3.3
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 05:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787659844; cv=none;
        d=google.com; s=arc-20260327;
        b=AlGcr1XtwOfRqvNq3xhcWHWIpOV14XU0j/Kgi3T767TIW1OXSNGdyHWJgF3L9UqZCq
         6PKmcjdQwqCcR+Fh2hIHMLMECMwnQ8fOTU50CA7YKkBbRLLSOHcWeNPDKiDaEgfQknQF
         xz/6CiruPCqqFSnos1dA5j5mDMIKGnzL3ciGIndIcrRlrZqMU19oj44ObGx+7q7uRwnE
         kQWWuuHA+KdL5n7Reid0lQZpFggq7ZsYKo9R4aLH0Nf3mXxpNG0DmBCfeo2lqv8K/WWF
         WJQsO3FRjNaYwGcnjSUabBHtPTMICjSrEAt9HJnjd7LhJqJCyTYKes2z4HlLfoJCHv/e
         KtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJ9hrWQedvb79ipaVMOGn2vkaw9mO7jS+bNOdzYa/Ss=;
        fh=S8S7m4inC+IhEqKuA6xH710IS+X8iGpw4VvGRzRLHuE=;
        b=fwPSznfl+JrWH7Ds7cdg02unXqKIVgYA58TTapFnwFkXsACOIWQ8mb6bCEia7VokxH
         gRubWUk1IonLIJFhcS2NtUxFvFCkT68yvKqueT5t4ian5V8zILG5pIzIvAUbfVkLA7Bv
         /irvKt4Cn6I5mLndHl7z/yhWUZkWyTai9s6p7ac+8bqWeDMvQVfcXpOXYbH+B6+MZWwT
         ismNR5MPYwPVsH3oKTrQBOC5qZuKMlVOW9B/E4ngdm+VGjA6ccEzceFDPnaamIeE+i8l
         y+FOzSZgn5yDVpbd4kEQDvLVPT/SJhPXclW17WBsbZISam0zDjOqabkpTfhFr5/Ybiy6
         Ahqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787659844; x=1788264644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kJ9hrWQedvb79ipaVMOGn2vkaw9mO7jS+bNOdzYa/Ss=;
        b=hjbuC7+gQCQYbaRBBKRUSg83UkGVCoJ32dugHOsVXaKBvnrr7fDClleJzx/9FAEWMS
         pueHbCMsQoZsPxTBW0wyk+htYp9WQ20RnZ85Q73oCwf23jcG3HSFD+KXDS5nHkF7uLn4
         W2Sg7T+dpf1M856mqDARM1HE9Ak2J+OcOCvbT2KI2yTfjJqmC4GP5P/sQkmTn/3FOuYt
         uFfnH4jYEyAkLeVObwrf1HLszhIC13I3ojR6NzajFrnIwJCc5BBCfiE+ZqVDShsW3NUZ
         OsfGBuvVxFRPYqYDAtNeLKuop2hF3TBCF+ujPwjesZDo2vG2TwMaLEBBtTyPUgGtzpOw
         R2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787659844; x=1788264644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJ9hrWQedvb79ipaVMOGn2vkaw9mO7jS+bNOdzYa/Ss=;
        b=NWNpjLamyqYZRKRlph//D476CUUOcXOlPM2+IlqL27OP+Yszlz6QCcQJEdyLUEGjk/
         EPsQr/hGZCPftsYSLJQA9ZBPdpFswTImuwcrmTYeg5twncnTyHa6XljHPAf2wJXuywik
         7k7QIPOXdxzE/AFRzS+Ue5CTA2S8BWB0M4eLcDeTC5aMLkfWPNAo6PRFaNCfZ2Ifu1S3
         Y/BTxMx38sKFqDWrfylDepQsPnrPbMwWulXOLYDANyhpOUj/5nXUXB9Z7mHvyGpIfDHY
         77RduuHcJq+oVcAsD0tpcj+Ys4zEUvvA4gEJCxk279eTOK/V3LtNfMR4v3j7Fc1vKdN7
         pKCg==
X-Forwarded-Encrypted: i=1; AHgh+RoezQxrAZKCQtUe1yCj8Guyrz/8QfffljPfaqdOIs/z1WA+TaOYXkJKU4WvqOiMN81xp16fax7ML0vEDzDc@vger.kernel.org
X-Gm-Message-State: AFuF++nLMXSxMOlMMiOa9Y3csSxSGP56XZvgRPqP3W/QObaNAu6KLBYr
	/gIGbWNnwU97X5WAx0QMUgakFQgg8WxElH+NqDNiriMdU5sSn969RZMAnKzyGTJ39Ith0mgzM8c
	38hHzdqGVYldDKlZve5y6zDzMqouLCdI=
X-Gm-Gg: AR+sD12teKvokhk4EAazuaIknLH9U3gP7A5umbU/Pd5ngDggV/oln+itQH9S2Xmx2Fo
	5rTabnSTmsxJlPsRMqozIBt+s2DPZMaUy9Q8pNmoIAPMRD6zvFo9YnZvwP/eScjGXe5Cy2ILp0S
	guZpE+akifeikVLF90EtxCjlImptXKyJO/kG7gczK71sm+A4LdgevSIcbIAAccnzYeDmxS/mN4J
	OAu35ZKwlj9eNaUvbY71We6F4lOURYMJwhOeOXFtPZUakWSQlllW9YZy1GKNIiQBp1U/Bfqm/qb
	sa2DIMfWuwp8Ac5dsgwcNbKJfNOCdPZAvYLjisK3w1qhDk93h+dM2w7Cl4+ggj8Xg2J0nPyaqY3
	o8g==
X-Received: by 2002:a05:690c:660a:b0:7ff:1a93:be35 with SMTP id
 00721157ae682-849f2453bf8mr135633127b3.16.1787659844109; Tue, 25 Aug 2026
 05:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <20260825115949.50A6E1F000E9@smtp.kernel.org>
In-Reply-To: <20260825115949.50A6E1F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 25 Aug 2026 20:10:08 +0800
X-Gm-Features: AcwNN1UuC7F10aj4YHVAMkQvoflardyEu4XV_wVleTpEOQfCZEfcg6pMaNlgGIM
Message-ID: <CALOAHbB99x=RxEmpqiwD+Z1F9BDUTr4gPEGHdT2zM8FfHOtupQ@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 3/8] livepatch: Implement replace set for
 scoped atomic replace
To: sashiko-reviews@lists.linux.dev
Cc: mbenes@suse.cz, jpoimboe@kernel.org, joe.lawrence@redhat.com, 
	pmladek@suse.com, song@kernel.org, jikos@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:59=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Contradiction between documentation/commit message and actual =
code regarding the 'obsoletes' list.

Ah, the provides ID is not included in the obsoletes list.
I will update it.

--=20
Regards
Yafang
