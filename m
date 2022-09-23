Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD14AC6FA82
	for <live-patching@archiver.kernel.org>; Fri, 23 Sep 2022 14:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIWOul (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIWOuk (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 23 Sep 2022 10:50:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB7F1D50;
        Fri, 23 Sep 2022 07:50:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38501219F9;
        Fri, 23 Sep 2022 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663944637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YQrlWL6wNFbRYikCHxQb3xp14YQTW/zz/u0eDQpZh5U=;
        b=SY5dKo+2rGkQTOEJ6mJAnQ1z7MCFJtli2MQp5nmsRex8xjp7v03xwyrhY2kHDXdPeeS/MU
        co/OMVRGrRhufxs/ZnRKTinTQTD/DsVhCUj7kQl3DgQTZdDSBW2dUOoXGRCyI2SRdVes4U
        KX8UwNmsmX0TN6cAsz1CvT7EwZeNrKM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1290C2C15A;
        Fri, 23 Sep 2022 14:50:37 +0000 (UTC)
Date:   Fri, 23 Sep 2022 16:50:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Song Liu <song@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com
Subject: Re: [PATCH v3 0/2] add sysfs entry "patched" for each klp_object
Message-ID: <Yy3HvGe/kcW2OCam@alley>
References: <20220902205208.3117798-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902205208.3117798-1-song@kernel.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri 2022-09-02 13:52:06, Song Liu wrote:
> I was debugging an issue that a livepatch appears to be attached, but
> actually not. It turns out that there is a mismatch in module name
> (abc-xyz vs. abc_xyz), klp_find_object_module failed to find the module.
> Add a sysfs entry for each klp_object, so that it is easier to debug
> such issues.
> 
> Changes v2 => v3:
> 1. Improve selftest. (Petr Mladek and Joe Lawrence)
> 
> Changes v1 => v2:
> 1. Add selftest. (Petr Mladek)
> 2. Update documentation. (Petr Mladek)
> 3. Use sysfs_emit. (Petr Mladek)
> 
> Song Liu (2):
>   livepatch: add sysfs entry "patched" for each klp_object
>   selftests/livepatch: add sysfs test

For both patches:

Reviewed-by: Petr Mladek <pmladek@suse.com>

And I have pushed the patchset into livepatching.git,
for-6.1/sysfs-patched-object.

Best Regards,
Petr
