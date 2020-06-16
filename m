Return-Path: <SRS0=CImh=75=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C16DC433E0
	for <live-patching@archiver.kernel.org>; Tue, 16 Jun 2020 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025E3207C3
	for <live-patching@archiver.kernel.org>; Tue, 16 Jun 2020 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkmdHbLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgFPPRP (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:17:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729754AbgFPPRP (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 16 Jun 2020 11:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592320633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DzSD8rSRTPiP9kOLG6lDIkt11X+pbq+5vdEcao3or80=;
        b=YkmdHbLdB2iEZcrtuY3a01kWx34/K3ukB35/oD6VqXcPBXBONGOExmU6BNPFv/Oyb58DRh
        oK9TRlnycHwH2Oc/FPvvB7WJsKSUSAjiULxhOtECp+UMy7GhhkYhi45aakcfENpxremPUx
        VPNrv6XVK820Ke+dhyVWTSLAcWpREUk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-yDznxGY-NxWLoPbHB4FglQ-1; Tue, 16 Jun 2020 11:17:11 -0400
X-MC-Unique: yDznxGY-NxWLoPbHB4FglQ-1
Received: by mail-qt1-f198.google.com with SMTP id x6so17005376qts.3
        for <live-patching@vger.kernel.org>; Tue, 16 Jun 2020 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzSD8rSRTPiP9kOLG6lDIkt11X+pbq+5vdEcao3or80=;
        b=W3Ho5KJgdxy2DyhaT9ssRDWl6pUnHFvWWE0pJYgfWwNcmTa37kTtxMVpOHNafQuNf9
         oitj2Og/oxgP53qri2XUpzVeQC+HKCDimnmC8QKOrWu1Hdo/hc2vhPuzxb99dmLqmWsC
         haEnRC6/AI09yLRzyU0mfi1hnws9FXtb78eRUzdlQ56U4KD3kK78zG6FJJy9cvlLdI+h
         UiauQlhz7hHqg5oH1hGAM0Q2zibf/b0j3E1q67qSQxcxbd/zSVhfFBuP4rSbIBhZyTn7
         Df9Gu89CmeXzlihtHslY6FB7lwEAnKmcKaaLgaHdvPvjA5rBDfL8yXO/PvXofOXxewiD
         z27Q==
X-Gm-Message-State: AOAM533UuQsZIvG9WDi+ekzSz7KJFdMKx7sBVqNPYxEBnRcpGFjX+iD+
        wu9wym2fpooJAOQg0Rg1w+YEjH44FKtkMxdHrUdU0tpX9bPhoclmWrms1uHS+rbHb078hgG/Htz
        BVaBC6TJusuFLC7UU+etskV0FCaiBoMgYZ2FHSE1rWg==
X-Received: by 2002:a05:620a:122e:: with SMTP id v14mr20659815qkj.94.1592320631199;
        Tue, 16 Jun 2020 08:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhfVwldfmQoamEb+64JZ052zy0sJJmSX0MiLsUc9HmsYRQbP8S1iPl67CiWVSZtG/RGJJ0JSpBxFEGdvVhaVU=
X-Received: by 2002:a05:620a:122e:: with SMTP id v14mr20659789qkj.94.1592320630943;
 Tue, 16 Jun 2020 08:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
From:   Yannick Cote <ycote@redhat.com>
Date:   Tue, 16 Jun 2020 11:16:59 -0400
Message-ID: <CAKMMXfbE1kfGnXZoC=rG_zVfE+0JndsBt4Azh8BLJ4HJVKAikQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] selftests/livepatch: small script cleanups
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

For the series:

Reviewed-by: Yannick Cote <ycote@redhat.com>

On Mon, Jun 15, 2020 at 1:28 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> This is a small collection of tweaks for the shellscript side of the
> livepatch tests.  If anyone else has a small cleanup (or even just a
> suggestion for a low-hanging change) and would like to tack it onto the
> set, let me know.
>
> based-on: livepatching.git, for-5.9/selftests-cleanup
> merge-thru: livepatching.git
>
> v2:
> - use consistent start_test messages from the original echoes [mbenes]
> - move start_test invocations to just after their descriptions [mbenes]
> - clean up $SAVED_DMSG on trap EXIT [pmladek]
> - grep longer kernel taint line, avoid word-matching [mbenes, pmladek]
> - add "===== TEST: $test =====" delimiter patch [pmladek]
>
> Joe Lawrence (4):
>   selftests/livepatch: Don't clear dmesg when running tests
>   selftests/livepatch: use $(dmesg --notime) instead of manually
>     filtering
>   selftests/livepatch: refine dmesg 'taints' in dmesg comparison
>   selftests/livepatch: add test delimiter to dmesg
>
>  tools/testing/selftests/livepatch/README      | 16 +++---
>  .../testing/selftests/livepatch/functions.sh  | 32 ++++++++++-
>  .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
>  .../selftests/livepatch/test-ftrace.sh        |  4 +-
>  .../selftests/livepatch/test-livepatch.sh     | 12 +---
>  .../selftests/livepatch/test-shadow-vars.sh   |  4 +-
>  .../testing/selftests/livepatch/test-state.sh | 21 +++----
>  7 files changed, 63 insertions(+), 81 deletions(-)
>
> --
> 2.21.3
>

