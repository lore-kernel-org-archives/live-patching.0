Return-Path: <SRS0=4vjg=CR=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0EFC2BC11
	for <live-patching@archiver.kernel.org>; Tue,  8 Sep 2020 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113E52080A
	for <live-patching@archiver.kernel.org>; Tue,  8 Sep 2020 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599591258;
	bh=5EnbF8rNLGG5aMK5Q8jyUVJ17bSgfsM7/LGaAbj29fY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p+2OaNWbVR8kcweAZ/IAbU2BUXGRUhjQUgDpDOPU9Z6W44Xj38fD/OFH0+bZ84VlW
	 qNw1be7wRHJ/dzBFmoLMLUZpmWFMWhbS/pzgO4cb3gElFkE42PRihiTQ4ORceDbEmY
	 DMVasmmed0wB8q9/ylHGG2eGgNokqU6CJ7usipYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgIHSna (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgIHSmT (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 8 Sep 2020 14:42:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA68C061573
        for <live-patching@vger.kernel.org>; Tue,  8 Sep 2020 11:42:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so200252ljg.9
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2020 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ex6ni327I15z8C3RrOtZFWWRNPfspAjIP05UlmQ1nl4=;
        b=cCJaROOcsnp26K4DukJrO0BU+LT56NzAyYSPMFzM8BMKk7BWV5Pl7UCZa+6PS5tKQu
         xxI3a0RzwnjPeHxeXrwE/SnLoNnxWz3vaDJ2QF370ZSDUbmHT+Kd4HNeWX461sOlZjkF
         uEwgTWEiQSdVN9BvCS9xomWc5XghpodRjW0sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ex6ni327I15z8C3RrOtZFWWRNPfspAjIP05UlmQ1nl4=;
        b=qQMyAyqR1SUwvzKKh1JaFZfqOIzn3J3SsrFWNl4tdlQw30CcNIkfSAPC5b0f8F2pRV
         1C7mBvAe8tA3Z/Xv5il10/10LRRpJWy/6FVOcuMa7XNgvWIUZnIaId1YmzBW2kGcBaw0
         eYFjlmroUA+7BKDun+4bhrIlmW7jkMkKmELjt/q4Sbyh+3425cVeMA8MQ12J0FwF7RZc
         i760SYOqxUpz4wuIlGmVehpZKtJeWLozNi8MMif+mHr3ZXi68xIJn2fyOYz/YZsyEnJR
         xybuiUHhiK6GOTUGpISHifsWENn1/C4rnTx+fbksNRPB76wKG4uBvFs12xRaXGYxPQr3
         NYjQ==
X-Gm-Message-State: AOAM531sgzb+YSPcdprXuYQGJ7C78ZSusVo4xw4D+A1lRn0WVIJH3ehA
        Q76GRaYPRH2qGe/17Mn31uLCs+mmnIdKtg==
X-Google-Smtp-Source: ABdhPJzazJqETWhufH1YLscc810avGG1D9x5ERO/2m/EPvjD2r7gum4rooFQHFT/KlPOifXHTrrYSA==
X-Received: by 2002:a2e:8988:: with SMTP id c8mr12854329lji.433.1599590537064;
        Tue, 08 Sep 2020 11:42:17 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i5sm90947lfe.8.2020.09.08.11.42.16
        for <live-patching@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:42:16 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id k25so262991ljk.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2020 11:42:16 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr5241560ljc.371.1599590536022;
 Tue, 08 Sep 2020 11:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200907082036.GC8084@alley> <CAHk-=wiZUYjmPLiEaN5uHM4mGyYq8RBFvk=iZKkm9=8NxvcoZQ@mail.gmail.com>
 <20200908183239.vhy2txzcmlliul7d@treble>
In-Reply-To: <20200908183239.vhy2txzcmlliul7d@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Sep 2020 11:42:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi==UJf0fWUGn6RhQ2hvLW7PA9Yj4GWaTJxa3roENAHDg@mail.gmail.com>
Message-ID: <CAHk-=wi==UJf0fWUGn6RhQ2hvLW7PA9Yj4GWaTJxa3roENAHDg@mail.gmail.com>
Subject: Re: [GIT PULL] livepatching for 5.9-rc5
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, Sep 8, 2020 at 11:32 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Can you share the .o file?  At least I can't recreate with GCC 9.3.1,
> which is all I have at the moment.

Done off-list in private, because I don't think anybody else wants
object files flying around on the mailing lists..

               Linus
