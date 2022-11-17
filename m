Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13007C4332F
	for <live-patching@archiver.kernel.org>; Thu, 17 Nov 2022 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiKQUAU (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 17 Nov 2022 15:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiKQUAT (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 17 Nov 2022 15:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5117EC9C;
        Thu, 17 Nov 2022 12:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3A96205B;
        Thu, 17 Nov 2022 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722D9C433C1;
        Thu, 17 Nov 2022 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668715217;
        bh=vO+cKwGnnt7Ikp4K63ZOyB2XNYmenlQEdQ2QOJjZGLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qBYjZa/IMlM5KHeE09wABdhBZYEwPpjSjJIewLnsQOK2jagLXDzJKNAC+8P0TGMXB
         aHGKpChuj12Gwa7Bf4xXECgPo8xYZys0D7zAFVnUYPqyq+GfMzHbgUY7AL5WMud7Ig
         ACvYjH5wAkDAYx2409RaAYKs88aLxCkw0dL02JMhF2v4T2hV5Mrj94QELuDjvy9BoI
         UcJe8WHHheCZtWrkr0AHL9Y2RctZqIuX2fvaCpTrLGZFvSN7olSLrkR+FcOV1IFu0V
         RkuT9dRd8U1xbpV8pu7/ya50NWOGz3iRdQzSLENEj0ITSYTyZkF5BQfoeKTx/R7D/U
         DSTTSk6NLM3xQ==
Received: by mail-ej1-f52.google.com with SMTP id t25so7795802ejb.8;
        Thu, 17 Nov 2022 12:00:17 -0800 (PST)
X-Gm-Message-State: ANoB5pktOUx3aYSim57QAhG8Asd4qyqns6vuS9rw2x+7LzrDI+2YO3K6
        KZ6EagFccW8GTIHZCjISBKMEq+rbejbpvUHO8eg=
X-Google-Smtp-Source: AA0mqf6SNJLDD3oiqBQCmMYdAYbreHZsfuDK2kTU00718Bq5Y5pcgY1A6dEu0CdLovuJ4lmnGI/Lx90ew7Kr9kt8xFM=
X-Received: by 2002:a17:906:2645:b0:781:d0c1:4434 with SMTP id
 i5-20020a170906264500b00781d0c14434mr3379349ejc.756.1668715215682; Thu, 17
 Nov 2022 12:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org> <20221114114344.18650-41-jirislaby@kernel.org>
In-Reply-To: <20221114114344.18650-41-jirislaby@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 17 Nov 2022 12:00:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4GBD4uhPqDAubO=xF+ve6G-STtt8fxzFNvGcnWcfaSxQ@mail.gmail.com>
Message-ID: <CAPhsuW4GBD4uhPqDAubO=xF+ve6G-STtt8fxzFNvGcnWcfaSxQ@mail.gmail.com>
Subject: Re: [PATCH 40/46] x86/livepatch, lto: Disable live patching with gcc LTO
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon, Nov 14, 2022 at 3:48 AM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> From: Andi Kleen <andi@firstfloor.org>
>
> It is not supported by gcc 12 so far, so it causes compiler "sorry"
> messages.
>
> Other than the compiler support, there shouldn't be any barriers for
> live patching LTOed kernels, although it might be more difficult to
> create patches for larger functions.

A loosely related question: does livepatch work with CLANG LTO?
AFAICT, kpatch-build doesn't support it. But the kernel side should
work just fine?

Thanks,
Song

[...]
