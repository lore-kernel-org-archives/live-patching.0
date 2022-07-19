Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7595C433EF
	for <live-patching@archiver.kernel.org>; Tue, 19 Jul 2022 23:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiGSXEj (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 19 Jul 2022 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGSXE0 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 19 Jul 2022 19:04:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A882B5C945;
        Tue, 19 Jul 2022 16:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 663EFB81DAD;
        Tue, 19 Jul 2022 23:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2C0C341C6;
        Tue, 19 Jul 2022 23:04:22 +0000 (UTC)
Date:   Tue, 19 Jul 2022 19:04:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/4] ftrace: allow IPMODIFY and DIRECT ops
 on the same function
Message-ID: <20220719190420.2121c659@gandalf.local.home>
In-Reply-To: <C6229252-B41F-43B9-BABC-538947466710@fb.com>
References: <20220718055449.3960512-1-song@kernel.org>
        <20220718055449.3960512-3-song@kernel.org>
        <20220719142856.7d87ea6d@gandalf.local.home>
        <C6229252-B41F-43B9-BABC-538947466710@fb.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, 19 Jul 2022 22:57:52 +0000
Song Liu <songliubraving@fb.com> wrote:

> >> +	hash = ops->func_hash->filter_hash;
> >> +	size = 1 << hash->size_bits;
> >> +	for (i = 0; i < size; i++) {
> >> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> >> +			unsigned long ip = entry->ip;
> >> +			bool found_op = false;
> >> +
> >> +			mutex_lock(&ftrace_lock);
> >> +			do_for_each_ftrace_op(op, ftrace_ops_list) {
> >> +				if (!(op->flags & FTRACE_OPS_FL_DIRECT))
> >> +					continue;
> >> +				if (ops_references_ip(op, ip)) {
> >> +					found_op = true;
> >> +					break;  
> > 
> > I think you want a goto here. The macros "do_for_each_ftrace_op() { .. }
> > while_for_each_ftrace_op()" is a double loop. The break just moves to the
> > next set of pages and does not break out of the outer loop.  
> 
> Hmmm... really? I didn't see it ...
> 
> 
> #define do_for_each_ftrace_op(op, list)                 \
>         op = rcu_dereference_raw_check(list);                   \
>         do
> 
> #define while_for_each_ftrace_op(op)                            \
>         while (likely(op = rcu_dereference_raw_check((op)->next)) &&    \
>                unlikely((op) != &ftrace_list_end))
> 
> Did I miss something...?

Bah, you're right. I was confusing it with do_for_each_ftrace_rec(), which
*is* a double loop.

Never mind ;-)

> 
> > 
> > 					goto out_loop;
> >   
> >> +				}
> >> +			} while_for_each_ftrace_op(op);  
> 
> [...]
> 
> >   
> >> 	mutex_lock(&ftrace_lock);
> >> 
> >> 	ret = ftrace_startup(ops, 0);
> >> 
> >> 	mutex_unlock(&ftrace_lock);
> >> 
> >> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >> +	if (direct_mutex_locked)
> >> +		mutex_unlock(&direct_mutex);
> >> +#endif  
> > 
> > Change this to:
> > 
> > out_unlock:
> > 	mutex_unlock(&direct_mutex);
> >   
> 
> We still need #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS, as 
> direct_mutex is not defined without that config. 

Ah, right. I just meant to get rid of the if statement.

To keep the code clean, perhaps we should have:

#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
# define lock_direct_mutex()	mutex_lock(&direct_mutex)
# define unlock_direct_mutex()	mutex_unlock(&direct_mutex)
#else
# define lock_direct_mutex()	do { } while (0)
# define unlock_direct_mutex()	do { } while (0)
#endif

And use that here.

-- Steve
