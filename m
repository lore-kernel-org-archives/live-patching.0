Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BF1C433F5
	for <live-patching@archiver.kernel.org>; Wed,  4 May 2022 14:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351532AbiEDO51 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 4 May 2022 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351533AbiEDO50 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 4 May 2022 10:57:26 -0400
X-Greylist: delayed 2195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 07:53:50 PDT
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE719C35;
        Wed,  4 May 2022 07:53:50 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34250)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmGNx-003gFY-Jr; Wed, 04 May 2022 08:53:49 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36918 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmGNw-00DdQV-Gz; Wed, 04 May 2022 08:53:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        kvm@vger.kernel.org
References: <20220503174934.2641605-1-sforshee@digitalocean.com>
        <20220504130753.GB8069@pathway.suse.cz>
        <YnKEnqfxSyVmSGYx@do-x1extreme>
        <20220504142809.GC8069@pathway.suse.cz>
Date:   Wed, 04 May 2022 09:53:40 -0500
In-Reply-To: <20220504142809.GC8069@pathway.suse.cz> (Petr Mladek's message of
        "Wed, 4 May 2022 16:28:09 +0200")
Message-ID: <87ee19fix7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmGNw-00DdQV-Gz;;;mid=<87ee19fix7.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Pmb3es8sVQGptMBHIKX3tnmcqpjmnk/g=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] entry/kvm: Make vCPU tasks exit to userspace when a
 livepatch is pending
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:

> On Wed 2022-05-04 08:50:22, Seth Forshee wrote:
>> On Wed, May 04, 2022 at 03:07:53PM +0200, Petr Mladek wrote:

>> > If "no" then I do not understand why TIF_NOTIFY_SIGNAL interrupts
>> > the syscall on the real hardware and not in kvm.
>> 
>> It does interrupt, but xfer_to_guest_mode_handle_work() concludes it's
>> not necessary to return to userspace and resumes guest execution.
>
> In this case, we should revert the commit 8df1947c71ee53c7e21
> ("livepatch: Replace the fake signal sending with TIF_NOTIFY_SIGNAL
> infrastructure"). The flag TIF_NOTIFY_SIGNAL clearly does not guarantee
> restarting the syscall or exiting to the user space with -EINTR.
>
> It should solve this problem. And it looks like a cleaner solution
> to me.

Why not just?

diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 9d09f489b60e..cbb192aec13a 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -8,13 +8,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
        do {
                int ret;
 
-               if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
-                       clear_notify_signal();
-                       if (task_work_pending(current))
-                               task_work_run();
-               }
-
-               if (ti_work & _TIF_SIGPENDING) {
+               if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
                        kvm_handle_signal_exit(vcpu);
                        return -EINTR;
                }

As far as I can tell the only reason _TIF_NOTIFY_SIGNAL was handled any
differently than _TIF_SIGPENDING in xfer_to_guest_mode_work is because
of historical confusion.

Eric
