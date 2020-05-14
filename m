Return-Path: <SRS0=47f4=64=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60A4C433E0
	for <live-patching@archiver.kernel.org>; Thu, 14 May 2020 21:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C58A206F1
	for <live-patching@archiver.kernel.org>; Thu, 14 May 2020 21:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589492712;
	bh=SrjBxjuvO2xIOH81KR141yOl4ZrKeyzuGmHkqf9XFGA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=zFMk7qs0KAOnKYKucIhaHJ4kqPbYvBl5LtRGhRzxuiT8f/624IeniK2KMKB2+0uzf
	 bGK5kN+pXjKvWCzV+Ag9ahf0yJhNgSDlsQ6PaAMryHGWUag6cVI6laAwWKmuQ3+1xW
	 EDvLfpBcQ+WccXXRzH6MAMlyVyjjeH511B6MGs6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgENVpJ (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 14 May 2020 17:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgENVpJ (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 14 May 2020 17:45:09 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B3E20709;
        Thu, 14 May 2020 21:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589492708;
        bh=SrjBxjuvO2xIOH81KR141yOl4ZrKeyzuGmHkqf9XFGA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R1VGab0Nt7+Xgr5r/YG6q2wVuG7JVAdqrEdlDRXs3RvfywgsAc4R6hWti66JDBWHK
         A19V4brp1JkCbas+v55UFeYRwpl9i0vPpCje/eM/DUk4XMaRxUQ39XqMc0HAXcrccM
         Bua6aWzIvEf76Sl8QdMsAwp5sOf5I439+y5EojkA=
Date:   Thu, 14 May 2020 23:45:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to livepatch .klp.arch removal
In-Reply-To: <bfe91b2d-e319-bf12-6a15-4f200d0e8ea4@linux.vnet.ibm.com>
Message-ID: <nycvar.YFH.7.76.2005142344230.25812@cbobk.fhfr.pm>
References: <20200509073258.5970-1-lukas.bulwahn@gmail.com> <bfe91b2d-e319-bf12-6a15-4f200d0e8ea4@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Sat, 9 May 2020, Kamalesh Babulal wrote:

> > Commit 1d05334d2899 ("livepatch: Remove .klp.arch") removed
> > arch/x86/kernel/livepatch.c, but missed to adjust the LIVE PATCHING entry
> > in MAINTAINERS.
> > 
> > Since then, ./scripts/get_maintainer.pl --self-test=patterns complains:
> > 
> >   warning: no file matches  F:  arch/x86/kernel/livepatch.c
> > 
> > So, drop that obsolete file entry in MAINTAINERS.
> 
> Patch looks good to me,  you probably want to add following architecture
> specific livepatching header files to the list:
> 
> arch/s390/include/asm/livepatch.h
> arch/powerpc/include/asm/livepatch.h

Good point, thanks for spotting it Kamalesh. I've queued the patch below 
on top.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] livepatch: add arch-specific headers to MAINTAINERS

Add arch-specific livepatch.h for s390 and powerpc to MAINTAINERS
F: patterns.

Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0827670425..8e14444eb98d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9854,6 +9854,8 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
 F:	Documentation/ABI/testing/sysfs-kernel-livepatch
 F:	Documentation/livepatch/
+F:	arch/powerpc/include/asm/livepatch.h
+F:	arch/s390/include/asm/livepatch.h
 F:	arch/x86/include/asm/livepatch.h
 F:	include/linux/livepatch.h
 F:	kernel/livepatch/


-- 
Jiri Kosina
SUSE Labs

