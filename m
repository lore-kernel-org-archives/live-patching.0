Return-Path: <SRS0=dM1V=XV=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A1FC432C2
	for <live-patching@archiver.kernel.org>; Thu, 26 Sep 2019 11:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA626222C2
	for <live-patching@archiver.kernel.org>; Thu, 26 Sep 2019 11:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfIZLf3 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:35:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfIZLf3 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 26 Sep 2019 07:35:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6B0BACD9;
        Thu, 26 Sep 2019 11:35:27 +0000 (UTC)
Date:   Thu, 26 Sep 2019 13:35:04 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
In-Reply-To: <20190919150809.860645841@linutronix.de>
Message-ID: <alpine.LSU.2.21.1909261324580.3740@pobox.suse.cz>
References: <20190919150314.054351477@linutronix.de> <20190919150809.860645841@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h

[...]

> +#define EXIT_TO_GUESTMODE_WORK						\
> +	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_RESUME |	\
> +	 ARCH_EXIT_TO_GUESTMODE_WORK)

[...]

> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
>
> +int core_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
> +				unsigned long ti_work)
> +{
> +	/*
> +	 * Before returning to guest mode handle all pending work
> +	 */
> +	if (ti_work & _TIF_SIGPENDING) {
> +		vcpu->run->exit_reason = KVM_EXIT_INTR;
> +		vcpu->stat.signal_exits++;
> +		return -EINTR;
> +	}
> +
> +	if (ti_work & _TIF_NEED_RESCHED) {
> +		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +		schedule();
> +		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
> +	}
> +
> +	if (ti_work & _TIF_PATCH_PENDING) {
> +		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +		klp_update_patch_state(current);
> +		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
> +	}

If I am reading the code correctly, _TIF_PATCH_PENDING is not a part of 
EXIT_TO_GUESTMODE_WORK, so the handling code here would not be called on 
any arch as of now.

I also think that _TIF_PATCH_PENDING must not be handled here generally. 
It could break consistency guarantees when live patching KVM (and we do 
that from time to time).

Adding live-patching ML to CC.

Miroslav

> +	if (ti_work & _TIF_NOTIFY_RESUME) {
> +		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +		clear_thread_flag(TIF_NOTIFY_RESUME);
> +		tracehook_notify_resume(NULL);
> +		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
> +	}
> +
> +	/* Any extra architecture specific work */
> +	return arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> +}
