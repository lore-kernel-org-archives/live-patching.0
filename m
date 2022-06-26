Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D9DC43334
	for <live-patching@archiver.kernel.org>; Sun, 26 Jun 2022 08:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiFZI6R (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Sun, 26 Jun 2022 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFZI6P (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Sun, 26 Jun 2022 04:58:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 287B1B90;
        Sun, 26 Jun 2022 01:58:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C347D6E;
        Sun, 26 Jun 2022 01:58:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.71.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4C73F792;
        Sun, 26 Jun 2022 01:58:00 -0700 (PDT)
Date:   Sun, 26 Jun 2022 09:57:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     madvenka@linux.microsoft.com
Cc:     broonie@kernel.org, jpoimboe@redhat.com, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        jamorris@linux.microsoft.com, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 6/6] arm64: Introduce arch_stack_walk_reliable()
Message-ID: <YrgflcfxP7pYtob7@FVFF77S0Q05N>
References: <ff68fb850d42e1adaa6a0a6c9c258acabb898b24>
 <20220617210717.27126-1-madvenka@linux.microsoft.com>
 <20220617210717.27126-7-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617210717.27126-7-madvenka@linux.microsoft.com>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Jun 17, 2022 at 04:07:17PM -0500, madvenka@linux.microsoft.com wrote:
> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
> 
> Introduce arch_stack_walk_reliable() for ARM64. This works like
> arch_stack_walk() except that it returns -EINVAL if the stack trace is not
> reliable.
> 
> Until all the reliability checks are in place, arch_stack_walk_reliable()
> may not be used by livepatch. But it may be used by debug and test code.

For the moment I would strongly perfer *not* to add this until we have the
missing bits and pieces sorted out.

Until then, I'd like to ensure that any infrastructure we add is immediately
useful and tested. One way to do that would be to enhance the stack dumping
code (i.e. dump_backtrace()) to log some metadata.

As an end-goal, I'd like to get to a point where we can do:

* Explicit logging when trace terminate at the final frame, e.g.

  stacktrace:
    function_c+offset/total
    function_b+offset/total
    function_a+offset/total
    <unwind successful>

* Explicit logging of early termination, e.g.

  stacktrace:
    function_c+offset/total
    <unwind terminated early (bad FP)>

* Unreliability on individual elements, e.g.

  stacktrace:
    function_c+offset/total
    function_b+offset/total (?)
    function_a+offset/total

* Annotations for special unwinding, e.g.

  stacktrace:
    function_c+offset/total (K) // kretprobes trampoline
    function_b+offset/total (F) // ftrace trampoline
    function_a+offset/total (FK) // ftrace and kretprobes
    other_function+offset/total (P) // from pt_regs::pc
    another_function+offset/total (L?) // from pt_regs::lr, unreliable
    something_else+offset/total

  Note: the comments here are just to explain the idea, I don't expect those in
  the actual output.

That'll justify some of the infrastructure we need for reliable unwinding, and
ensure that it is tested, well before we actually enable reliable stacktracing.

Thanks,
Mark.

> 
> Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/stacktrace.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index eda8581f7dbe..8016ba0e2c96 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -383,3 +383,26 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  
>  	unwind(&state, consume_entry, cookie);
>  }
> +
> +/*
> + * arch_stack_walk_reliable() may not be used for livepatch until all of
> + * the reliability checks are in place in unwind_consume(). However,
> + * debug and test code can choose to use it even if all the checks are not
> + * in place.
> + */
> +noinline int notrace arch_stack_walk_reliable(
> +					stack_trace_consume_fn consume_entry,
> +					void *cookie,
> +					struct task_struct *task)
> +{
> +	struct unwind_state state;
> +	bool reliable;
> +
> +	if (task == current)
> +		unwind_init_from_caller(&state);
> +	else
> +		unwind_init_from_task(&state, task);
> +
> +	reliable = unwind(&state, consume_entry, cookie);
> +	return reliable ? 0 : -EINVAL;
> +}
> -- 
> 2.25.1
> 
