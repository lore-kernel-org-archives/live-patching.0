Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3581C27C76
	for <live-patching@archiver.kernel.org>; Wed, 25 Jan 2023 16:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjAYQqV (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 25 Jan 2023 11:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjAYQqU (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 25 Jan 2023 11:46:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA65618B;
        Wed, 25 Jan 2023 08:46:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BA8DB81B1A;
        Wed, 25 Jan 2023 16:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9EFC433D2;
        Wed, 25 Jan 2023 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674665177;
        bh=YeCOLGSvIumlcrZ7av8GvxR+/ErNvo1cXm8+M2K16/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbMN/zr4jJXDcBrQ4WyELbfAvEarnhllZNr/+74Q/d5+KDTZpgvZW6qyfG53ALtxQ
         c609vHX1nuEwbgnCFAKswiR6tVAQfbYg6FawacXUsfHxVRwd+IEo5DCrtCOS/yJv4C
         1etJPd65uQC0dCubcxbi5g+pnBTcQ2osaH20QTAJwX41SBdFiO21Ntca58u1mp63Ww
         wtDeO1Qv6ABJwJkcdu67DMWD+fYrygwcGXyRQfegIRgvKEGVGcRkD301huJ/gQV7Tm
         nNV2NsaqmkRC3W/JxiA3WktGhqq8vE8G33cBBhSv/thSUFSdULTCaR72lHJSSB+Q3s
         gieyprWNnuwiQ==
Date:   Wed, 25 Jan 2023 08:46:09 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/module_64: Fix "expected nop" error on
 module re-patching
Message-ID: <20230125164609.wvuarciciyoqa3tb@treble>
References: <cover.1674617130.git.jpoimboe@kernel.org>
 <2f6329ffd9674df6ff57e03edeb2ca54414770ab.1674617130.git.jpoimboe@kernel.org>
 <CAPhsuW40jEiyp0ogsO6oH_frpFCmiioSHrMOKkwGcZ8_6w5dZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW40jEiyp0ogsO6oH_frpFCmiioSHrMOKkwGcZ8_6w5dZA@mail.gmail.com>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, Jan 24, 2023 at 10:09:56PM -0800, Song Liu wrote:
> > @@ -514,9 +515,18 @@ static int restore_r2(const char *name, u32 *instruction, struct module *me)
> >         if (!instr_is_relative_link_branch(ppc_inst(*prev_insn)))
> >                 return 0;
> >
> > -       if (*instruction != PPC_RAW_NOP()) {
> > +       /*
> > +        * For livepatch, the restore r2 instruction might have already been
> > +        * written previously, if the referenced symbol is in a previously
> > +        * unloaded module which is now being loaded again.  In that case, skip
> > +        * the warning and the instruction write.
> > +        */
> > +       if (insn_val == PPC_INST_LD_TOC)
> > +               return 0;
> 
> Do we need "sym->st_shndx == SHN_LIVEPATCH" here?

My original patch had that check, but I dropped it for simplicity.

In the non-livepatch case, the condition should never be true, but it
doesn't hurt to check it anyway.

-- 
Josh
