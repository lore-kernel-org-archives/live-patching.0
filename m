Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E22EA171
	for <live-patching@vger.kernel.org>; Wed, 15 Apr 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247133; cv=none; b=l809FqID2XCM0xda2DnGQCmEv+1YRhrDcm/18SPLJXnJSo/eflSi8OGaI1sfZtXt+gvR3+W1AhAtklChrR4QQ7yRdjY5Laq/tKYgcQms9UyrmOFugikFupJSBHcp0CfzMMf84biAtelHswB+FRD2ZZ3HFplxuywne/nqQwbxGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247133; c=relaxed/simple;
	bh=FJjQg6+ajwdSb2YinDQGQQVPHZXIXGCeuUqs30O3xQs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fkhiTtriGOIXo/0QD3ve8kRDl3K61DV8Ddo15uDBVrZwOjYF0c6Z5kAhfDdY2a1vCFkqSQamp6QfksAgZMAjbgXNbenbsDX61wL6/RbFs6jGw7kV+TAjiJ8yg8J/Ceyay12jCYC7D7r0HeNqT2+ZQpbkPIkGAm9Hs94VftT4a4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vDB2QW89; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zQfjjTKa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vDB2QW89; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zQfjjTKa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vDB2QW89";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zQfjjTKa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vDB2QW89";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zQfjjTKa"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 893EB6A7E3;
	Wed, 15 Apr 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776247130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dcRxfkAdzDk7Zhvra4nNB/DbQIffMMgrxS8OnxtUX7g=;
	b=vDB2QW892Air6/p0thgJ/jce/Zi5L3hZaWdWObz34lA/yA78Qs7JNjuUJoDAcip1lHIoJU
	kxvNa7LXuB19CqSgpRYv/w/niEDD6DxxHrJcsYq11ezWM0gN8Avcc37swz+D1Ljo+nKa9j
	ISGkDj7rop7WvcLZ2LCxeZqv8/EndL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776247130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dcRxfkAdzDk7Zhvra4nNB/DbQIffMMgrxS8OnxtUX7g=;
	b=zQfjjTKaw43oE0mL6WQ+pTStG7SqjkmF0jSpbbL4uqusxkED7U+V0V9zxpzFbjGeVyebeA
	GUNMA2S8/CFktGAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776247130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dcRxfkAdzDk7Zhvra4nNB/DbQIffMMgrxS8OnxtUX7g=;
	b=vDB2QW892Air6/p0thgJ/jce/Zi5L3hZaWdWObz34lA/yA78Qs7JNjuUJoDAcip1lHIoJU
	kxvNa7LXuB19CqSgpRYv/w/niEDD6DxxHrJcsYq11ezWM0gN8Avcc37swz+D1Ljo+nKa9j
	ISGkDj7rop7WvcLZ2LCxeZqv8/EndL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776247130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dcRxfkAdzDk7Zhvra4nNB/DbQIffMMgrxS8OnxtUX7g=;
	b=zQfjjTKaw43oE0mL6WQ+pTStG7SqjkmF0jSpbbL4uqusxkED7U+V0V9zxpzFbjGeVyebeA
	GUNMA2S8/CFktGAg==
Date: Wed, 15 Apr 2026 11:58:50 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] selftests: livepatch: Check for ARCH_HAS_SYSCALL_WRAPPER
 config
In-Reply-To: <20260413-lp-tests-old-fixes-v2-1-367c7cb5006f@suse.com>
Message-ID: <alpine.LSU.2.21.2604151154330.1967@pobox.suse.cz>
References: <20260413-lp-tests-old-fixes-v2-0-367c7cb5006f@suse.com> <20260413-lp-tests-old-fixes-v2-1-367c7cb5006f@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO

On Mon, 13 Apr 2026, Marcos Paulo de Souza wrote:

> Older kernels that lack CONFIG_ARCH_HAS_SYSCALL_WRAPPER config don't
> have any prefixes for their syscalls. The same applies to current
> powerpc and loongarch, covering all currently supported architectures
> that support livepatch.
> 
> The other supported architectures have specific prefixes, so error out
> when a new architecture adds livepatch support with wrappes but didn't
> update the test to include it.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  .../selftests/livepatch/test_modules/test_klp_syscall.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> index dd802783ea84..b5527a288a7c 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> @@ -12,15 +12,26 @@
>  #include <linux/slab.h>
>  #include <linux/livepatch.h>
>  
> -#if defined(__x86_64__)
> +/*
> + * Before CONFIG_ARCH_HAS_SYSCALL_WRAPPER was introduced there were no
> + * prefixes for system calls.
> + * Both ppc and loongarch does not set prefixes for their system calls either.
> + */
> +#if !defined(CONFIG_ARCH_HAS_SYSCALL_WRAPPER) ||  defined(__powerpc__) || \
> +	defined(__loongarch__)
> +#define FN_PREFIX
> +#elif defined(__x86_64__)
>  #define FN_PREFIX __x64_
>  #elif defined(__s390x__)
>  #define FN_PREFIX __s390x_
>  #elif defined(__aarch64__)
>  #define FN_PREFIX __arm64_
> -#else
> -/* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER */
> +#elif defined(__powerpc__)
> +#define FN_PREFIX
> +#elif defined(__loongarch__)
>  #define FN_PREFIX
> +#else
> +#error "Missing syscall wrapper for the given architecture."
>  #endif

I know that Sashiko commented on that already but even with that I wonder 
if it was cleaner to structure it differently...

#if defined(CONFIG_ARCH_HAS_SYSCALL_WRAPPER)
  #if define(__x86_64__)
  ...
  #elif define(__powerpc__)
    #define FN_PREFIX
  #else
    #error
  #endif
#elif
  #define FN_PREFIX
#endif

?

I still hope that it will be sufficient and we do not have to introduce 
KERNEL_VERSION checks since wrappers changed/will change.

Miroslav
