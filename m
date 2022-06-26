Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DDCC433EF
	for <live-patching@archiver.kernel.org>; Sun, 26 Jun 2022 09:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiFZJSw (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiFZJSv (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Sun, 26 Jun 2022 05:18:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E538F5B9;
        Sun, 26 Jun 2022 02:18:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C0A2B;
        Sun, 26 Jun 2022 02:18:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.71.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0447E3F792;
        Sun, 26 Jun 2022 02:18:47 -0700 (PDT)
Date:   Sun, 26 Jun 2022 10:18:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Will Deacon <will@kernel.org>, broonie@kernel.org,
        jpoimboe@redhat.com, ardb@kernel.org, nobuta.keiya@fujitsu.com,
        sjitindarsingh@gmail.com, catalin.marinas@arm.com,
        jamorris@linux.microsoft.com, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v15 0/6] arm64: Reorganize the unwinder and implement
 stack trace reliability checks
Message-ID: <YrgkdBtbFmOvKJpX@FVFF77S0Q05N>
References: <ff68fb850d42e1adaa6a0a6c9c258acabb898b24>
 <20220617210717.27126-1-madvenka@linux.microsoft.com>
 <20220623173224.GB16966@willie-the-truck>
 <66545c21-cfcf-60eb-4acf-39be99520369@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66545c21-cfcf-60eb-4acf-39be99520369@linux.microsoft.com>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Jun 24, 2022 at 12:19:01AM -0500, Madhavan T. Venkataraman wrote:
> 
> 
> On 6/23/22 12:32, Will Deacon wrote:
> > On Fri, Jun 17, 2022 at 04:07:11PM -0500, madvenka@linux.microsoft.com wrote:
> >> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
> >>
> >> I have synced this patch series to v5.19-rc2.
> >> I have also removed the following patch.
> >>
> >> 	[PATCH v14 7/7] arm64: Select HAVE_RELIABLE_STACKTRACE
> >>
> >> as HAVE_RELIABLE_STACKTRACE depends on STACK_VALIDATION which is not present
> >> yet. This patch will be added in the future once Objtool is enhanced to
> >> provide stack validation in some form.
> > 
> > Given that it's not at all obvious that we're going to end up using objtool
> > for arm64, does this patch series gain us anything in isolation?
> > 
> 
> BTW, I have synced my patchset to 5.19-rc2 and sent it as v15.
> 
> So, to answer your question, patches 1 thru 3 in v15 are still useful even if we don't
> consider reliable stacktrace. These patches reorganize the unwinder code based on
> comments from both Mark Rutland and Mark Brown. Mark Brown has already OKed them.
> If Mark Rutland OKes them, we should upstream them.

Sorry for the delay; I have been rather swamped recently and haven't had the
time to give this the time it needs.

I'm happy with patches 1 and 2, and I've acked those in case Will wants to pick
them.

Kalesh (cc'd) is working to share the unwinder code with hyp, and I think that
we need to take a step back and consider how we can make the design work
cleanly with that. I'd had a go at prototyping making the unwinder more data
driven, but I haven't come up with something satisfactory so far.

It would be good if you could look at / comment on each others series.

Thanks,
Mark.

> 
> I can drop patches 4 thru 6. Actually, the objtool patch series that I have
> sent separately for supporting livepatch already addresses reliability. So, if that
> gets reviewed and accepted, we don't even need patches 4 thru 6.
> 
> If you are OK with that, I can resend v16 with just patches 1 thru 3. Let me know.
> 
> Madhavan
> 
