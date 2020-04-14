Return-Path: <SRS0=4WRz=56=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9EC2BA19
	for <live-patching@archiver.kernel.org>; Tue, 14 Apr 2020 16:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D722F20656
	for <live-patching@archiver.kernel.org>; Tue, 14 Apr 2020 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586880586;
	bh=92IsLYBmWN95MoOIca4RMfGjPAcw1IKPVPEKjp32bes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a37976DOzBz4Fyt42RFRZwVWPuWjznLLp5h/T88UQ5DtCsAzkEUDWKVOwduGodjpH
	 xpCdhP8suVmTRBbEW34ZKHBoKwvS4s2kLra/0LcZ2ia+dQgWOOzHw4lxELT2/bCRCn
	 JVnzuqNFeSiyfAQm5Zyiuz7gP8WbYsCUtCOMpRdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbgDNQJi (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbgDNQJg (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 14 Apr 2020 12:09:36 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC5720656;
        Tue, 14 Apr 2020 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586880575;
        bh=92IsLYBmWN95MoOIca4RMfGjPAcw1IKPVPEKjp32bes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ac5iWxiX16fyMzAsVdtABxx+uPrGaYPif+EvWbdKo3vaSAQKTs4GavzuqzXTDgcUD
         Fqx1T4fSnNr9aDcq/qaWoWUt20C0kk0NH8NRSokf/Ycem6zqvFuF2ztPgItdjMUmQ2
         XmyJVIq/vgwRBP6uSDXkYcvTcw7SNTWDzw8VgXbw=
Date:   Tue, 14 Apr 2020 18:09:31 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: RFC: Handle hard module dependencies that are not symbol-based
 (r8169 + realtek)
Message-ID: <20200414160930.GA20229@linux-8ccs>
References: <f8e3f271-82df-165f-63f1-6df73ba3d59c@gmail.com>
 <20200409000200.2qsqcbrzcztk6gmu@ldmartin-desk1>
 <6ed6259b-888d-605a-9a6f-526c18e7bb14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6ed6259b-888d-605a-9a6f-526c18e7bb14@gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

+++ Heiner Kallweit [10/04/20 00:25 +0200]:
>On 09.04.2020 02:02, Lucas De Marchi wrote:
>> On Wed, Apr 01, 2020 at 11:20:20PM +0200, Heiner Kallweit wrote:
>>> Currently we have no way to express a hard dependency that is not
>>> a symbol-based dependency (symbol defined in module A is used in
>>> module B). Use case:
>>> Network driver ND uses callbacks in the dedicated PHY driver DP
>>> for the integrated PHY (namely read_page() and write_page() in
>>> struct phy_driver). If DP can't be loaded (e.g. because ND is in
>>> initramfs but DP is not), then phylib will use the generic
>>> PHY driver GP. GP doesn't implement certain callbacks that are
>>> needed by ND, therefore ND's probe has to bail out with an error
>>> once it detects that DP is not loaded.
>>> We have this problem with driver r8169 having such a dependency
>>> on PHY driver realtek. Some distributions have tools for
>>> configuring initramfs that consider hard dependencies based on
>>> depmod output. Means so far somebody can add r8169.ko to initramfs,
>>> and neither human being nor machine will have an idea that
>>> realtek.ko needs to be added too.
>>
>> Could you expand on why softdep doesn't solve this problem
>> with MODULE_SOFTDEP()
>>
>> initramfs tools can already read it and modules can already expose them
>> (they end up in /lib/modules/$(uname -r)/modules.softdep and modprobe
>> makes use of them)
>>
>Thanks for the feedback. I was under the impression that initramfs-tools
>is affected, but you're right, it considers softdeps.
>Therefore I checked the error reports again, and indeed they are about
>Gentoo's "genkernel" tool only. See here:
>https://bugzilla.kernel.org/show_bug.cgi?id=204343#c15
>
>If most kernel/initramfs tools consider softdeps, then I don't see
>a need for the proposed change. But well, everything is good for
>something, and I learnt something about the structure of kmod.
>Sorry for the noise.

Well, I wouldn't really call it noise :) I think there *could* be
cases out there where a establishing a non-symbol-based hard
dependency would be beneficial.

In the bug you linked, I think one could hypothetically run into the
same oops if the realtek module fails to load for whatever reason, no?
Since realtek is only a soft dependency of r8169, modprobe would
consider realtek optional and would still try to load r8169 even if
realtek had failed to load previously. Then wouldn't the same problem
(described in the bugzilla) arise?  Maybe a hard dependency could
possibly come in handy in this case, because a softdep unfortunately
implies that r8169 can work without realtek loaded.

Another potential usecase - I think livepatch folks (CC'd) have
contemplated establishing some type of hard dependency between patch
module and the target module before. I have only briefly skimmed
Petr's POC [1] and it looks like this patch module dependency is
accomplished through a request_module() call during load_module()
(specifically, in klp_module_coming()) so that the patch module gets
loaded before the target module finishes loading.

I initially thought this dependency could be expressed through
MODULE_HARDDEP(target_module) in the patch module source code, but it
looks like livepatch might require something more fine-grained, since
the current POC tries to load the patch module before the target
module runs its init(). In addition, this method wouldn't prevent the
target module from loading if the patch module fails to load..

In any case, I appreciate the RFC and don't really have any gripes
against having an analogous MODULE_HARDDEP() macro. If more similar
cases crop up then it may be worth seriously pursuing, and then we'll
at least have this RFC to start with :)

Thanks,

Jessica
