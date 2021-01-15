Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87FC433DB
	for <live-patching@archiver.kernel.org>; Fri, 15 Jan 2021 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A90B222B3
	for <live-patching@archiver.kernel.org>; Fri, 15 Jan 2021 16:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbhAOQsJ (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 15 Jan 2021 11:48:09 -0500
Received: from foss.arm.com ([217.140.110.172]:45098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbhAOQsI (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 15 Jan 2021 11:48:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD964D6E;
        Fri, 15 Jan 2021 08:47:22 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A273F719;
        Fri, 15 Jan 2021 08:47:20 -0800 (PST)
Date:   Fri, 15 Jan 2021 16:47:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
        live-patching@vger.kernel.org, linux-doc@vgert.kernel.org
Subject: Re: [PATCH v3] Documentation: livepatch: document reliable stacktrace
Message-ID: <20210115164718.GE44111@C02TD0UTHF1T.local>
References: <20210115142446.13880-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115142446.13880-1-broonie@kernel.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Mark,

On Fri, Jan 15, 2021 at 02:24:46PM +0000, Mark Brown wrote:
> +.. Table of Contents:
> +
> +    1. Introduction
> +    2. Requirements
> +    3. Considerations
> +       3.1 Identifying successful termination
> +       3.2 Identifying unwindable code
> +       3.3 Unwinding across interrupts and exceptions
> +       3.4 Rewriting of return addresses
> +       3.5 Obscuring of return addresses
> +       3.6 Link register unreliability
>

It looks like we forgot to update this with the addition of the new
section 3, so this needs a trivial update to add that and fix the
numbering.

Otherwise this looks good; thanks for taking this off my hands! :)

Mark.
