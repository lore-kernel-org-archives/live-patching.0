Return-Path: <SRS0=n6j0=6A=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A44C2BB55
	for <live-patching@archiver.kernel.org>; Thu, 16 Apr 2020 12:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0284A20767
	for <live-patching@archiver.kernel.org>; Thu, 16 Apr 2020 12:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="At1JGyb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635003AbgDPMHi (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:07:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634999AbgDPMHc (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 16 Apr 2020 08:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587038851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wG2AA9p6i8I/UNxVkyDuMtpOTXAlIGJZQiEkiZEXjVk=;
        b=At1JGyb9cwzYLxa10RU1Cp6Re6ehn5h0W202IS2P3MZ0qg9mZUGRxWBEwYua1rPYJf1oTj
        BEcrKT1i8f+MZ7EiamJUpfXiSGAWysV3LFmXnAxdukdrQymCmjvhW4sIZ6gtQKcDsA7D2J
        H0w79cGIUbHo/ffNsWM39xaXa+lvT2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-45ApSQlFNbygU006p2L1RQ-1; Thu, 16 Apr 2020 08:07:27 -0400
X-MC-Unique: 45ApSQlFNbygU006p2L1RQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24BC68017F6;
        Thu, 16 Apr 2020 12:06:56 +0000 (UTC)
Received: from treble (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D00B25C290;
        Thu, 16 Apr 2020 12:06:54 +0000 (UTC)
Date:   Thu, 16 Apr 2020 07:06:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 4/7] s390/module: Use s390_kernel_write() for relocations
Message-ID: <20200416120651.wqmoaa35jft4prox@treble>
References: <cover.1586881704.git.jpoimboe@redhat.com>
 <e7f2ad87cf83dcdaa7b69b4e37c11fa355bdfe78.1586881704.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2004161047410.10475@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004161047410.10475@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, Apr 16, 2020 at 10:56:02AM +0200, Miroslav Benes wrote:
> > +	bool early = me->state == MODULE_STATE_UNFORMED;
> > +
> > +	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
> > +				    early ? memcpy : s390_kernel_write);
> 
> The compiler warns about
> 
> arch/s390/kernel/module.c: In function 'apply_relocate_add':
> arch/s390/kernel/module.c:453:24: warning: pointer type mismatch in conditional expression
>          early ? memcpy : s390_kernel_write);

Thanks, I'll get all that cleaned up.

I could have sworn I got a SUCCESS message from the kbuild bot.  Does it
ignore warnings nowadays?

-- 
Josh

