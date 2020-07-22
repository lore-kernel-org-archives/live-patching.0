Return-Path: <SRS0=8KIh=BB=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A263AC433E3
	for <live-patching@archiver.kernel.org>; Wed, 22 Jul 2020 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F91020717
	for <live-patching@archiver.kernel.org>; Wed, 22 Jul 2020 16:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bed0O3JP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGVQHj (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:07:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728400AbgGVQHi (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 22 Jul 2020 12:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595434057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bE26wHn/H6+Nxep03XAoDVa8RROZuwKayFCoxg4SHVI=;
        b=Bed0O3JPdiDiBoePqKHAX5iAsEsNCh7pJU82v3Pn3ovGaohNKL/W+GjsPQhj8h3eA5nZ+d
        ScGuoQGN0eta7limsEN/dZVxztqIXtDFeFqmJ9eOH0bgBqU3zs6DpzkWnsHAl/y0G226Rj
        lacj255VnZMz8EaqiMORSk5iFsIF3ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-ZOruSB_gPSe_y9gfuhk1QQ-1; Wed, 22 Jul 2020 12:07:35 -0400
X-MC-Unique: ZOruSB_gPSe_y9gfuhk1QQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9535193F571;
        Wed, 22 Jul 2020 16:07:33 +0000 (UTC)
Received: from treble (ovpn-117-60.rdu2.redhat.com [10.10.117.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5574B2B4DD;
        Wed, 22 Jul 2020 16:07:32 +0000 (UTC)
Date:   Wed, 22 Jul 2020 11:07:30 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <20200722160730.cfhcj4eisglnzolr@treble>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <alpine.LSU.2.21.2007221122110.10163@pobox.suse.cz>
 <202007220738.72F26D2480@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007220738.72F26D2480@keescook>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, Jul 22, 2020 at 07:39:55AM -0700, Kees Cook wrote:
> On Wed, Jul 22, 2020 at 11:27:30AM +0200, Miroslav Benes wrote:
> > Let me CC live-patching ML, because from a quick glance this is something 
> > which could impact live patching code. At least it invalidates assumptions 
> > which "sympos" is based on.
> 
> In a quick skim, it looks like the symbol resolution is using
> kallsyms_on_each_symbol(), so I think this is safe? What's a good
> selftest for live-patching?

The problem is duplicate symbols.  If there are two static functions
named 'foo' then livepatch needs a way to distinguish them.

Our current approach to that problem is "sympos".  We rely on the fact
that the second foo() always comes after the first one in the symbol
list and kallsyms.  So they're referred to as foo,1 and foo,2.

-- 
Josh

