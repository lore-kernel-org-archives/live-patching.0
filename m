Return-Path: <SRS0=n6j0=6A=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E17C2BB55
	for <live-patching@archiver.kernel.org>; Thu, 16 Apr 2020 12:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114D20780
	for <live-patching@archiver.kernel.org>; Thu, 16 Apr 2020 12:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAadrJXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634959AbgDPMKW (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:10:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2634579AbgDPMKT (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 16 Apr 2020 08:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587039018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UkBX4tWUeuF6phNnH/IEoeZJtqdkC3zMlBoaKCG3/EY=;
        b=TAadrJXsSpikxHZmI8VObEc9y93GnvCtwmeovpBePp3A579/JYsJish5Ecn3QUrXkKII6E
        KVByrwBvcSI8VNdS/qDe7DTGjICKxiGBlB9ot6L7qIDiN4zr9xyHaUg9IGsYe3JwLU2Btc
        WYslU9btHOBwfKqbmuhpS4/HQLhZlQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-yO9ig_6DNtKAekjRYWwj2g-1; Thu, 16 Apr 2020 08:10:13 -0400
X-MC-Unique: yO9ig_6DNtKAekjRYWwj2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAB601005513;
        Thu, 16 Apr 2020 12:10:11 +0000 (UTC)
Received: from treble (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 228DE7E7C9;
        Thu, 16 Apr 2020 12:10:10 +0000 (UTC)
Date:   Thu, 16 Apr 2020 07:10:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jessica Yu <jeyu@kernel.org>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/7] livepatch: Remove module_disable_ro() usage
Message-ID: <20200416121008.i5vmafqcv4ab7van@treble>
References: <cover.1586881704.git.jpoimboe@redhat.com>
 <9f0d8229bbe79d8c13c091ed70c41d49caf598f2.1586881704.git.jpoimboe@redhat.com>
 <20200415150216.GA6164@linux-8ccs.fritz.box>
 <20200415163303.ubdnza6okg4h3e5a@treble>
 <alpine.LSU.2.21.2004161126540.10475@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004161126540.10475@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, Apr 16, 2020 at 11:28:25AM +0200, Miroslav Benes wrote:
> If I remember correctly, text_mutex must be held whenever text is modified 
> to prevent race due to the modification. It is not only about permission 
> changes even though it was how it manifested itself in our case.

Yeah, that's what confused me.  We went years without using text_mutex
and then only started using it because of a race with the permissions
changes.

-- 
Josh

