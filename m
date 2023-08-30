Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C4C83F12
	for <live-patching@archiver.kernel.org>; Wed, 30 Aug 2023 00:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbjH3Act (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 29 Aug 2023 20:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbjH3Acc (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 29 Aug 2023 20:32:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C728D107
        for <live-patching@vger.kernel.org>; Tue, 29 Aug 2023 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1693355539;
        bh=rtqXqefWaBdTc7Vn+73gF/lqYmAcwv/JWQvT26wbRSU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dw+eJVuSXBbZmTNgDCl9I9pzEsIFC4a0h4ZYqDY5K0Fs2xZja4AOo5QTJg+6auudC
         JhgQ4R+fZoowT3VPKIAXTJqagwnq2h7AB8MoGA1CSRZ7Lc8zGsiVyND2jwzDFVS/uM
         04n/Azom2vQmSJuOE/oGtJRYAVkYK+Y4zu9Bm1xHEeMJWzmlRbmr5kgJ1ZFhZ3zKBd
         OPr76+tCyHGusUkwvOZHXrWm+tSpdkgYUzNZc9qSN7F/wwp4pvjEbCE4leu6xsf+sN
         9oo1OeMqU+hqH4SOYkKD/jy7XLFXNp300yQ+Y4pAHQ8o0DKMyoN+BNTlpzz0Vl/7UG
         KEs+oveCmJBKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rb4xb2X0Dz4wd0;
        Wed, 30 Aug 2023 10:32:19 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     live-patching@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Ryan Sullivan <rysulliv@redhat.com>
Subject: Re: Recent Power changes and stack_trace_save_tsk_reliable?
In-Reply-To: <ZO4K6hflM/arMjse@redhat.com>
References: <ZO4K6hflM/arMjse@redhat.com>
Date:   Wed, 30 Aug 2023 10:32:15 +1000
Message-ID: <87o7ipxtdc.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Joe Lawrence <joe.lawrence@redhat.com> writes:
> Hi ppc-dev list,
>
> We noticed that our kpatch integration tests started failing on ppc64le
> when targeting the upstream v6.4 kernel, and then confirmed that the
> in-tree livepatching kselftests similarly fail, too.  From the kselftest
> results, it appears that livepatch transitions are no longer completing.

Hi Joe,

Thanks for the report.

I thought I was running the livepatch tests, but looks like somewhere
along the line my kernel .config lost CONFIG_TEST_LIVEPATCH=m, so I have
been running the test but it just skips. :/

I can reproduce the failure, and will see if I can bisect it more
successfully.

cheers
