Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20C481FB9
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326036; cv=none; b=W3vmYKNGuamcEqEJhoi7Y8LRAD7vWmxkfF1qxkSnMMhvRSx+kkOA2H6djKrzDmGRia4bGjS376UC5vv8tJVQGTj+uablchhM0HP/QtP0s0zASC+yHD/a5x+oi9HsmVeKs77cJ1nua3+GAPeie9QNdS1XAhPVlpdgE+75L5rb5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326036; c=relaxed/simple;
	bh=+EsCzgrXMt9QD8hXX2kOX2g/Puefx594N+RxSmmNQw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGe1RuJB3FljR7bCzcAB50AWpH6wdXgyAk80Ie59WY/Zq4rdORrxxXcyQzYufaqlW5PVPpGkUuSrdR+NtIxdNAuKOFoCBt4jhbVhhAoIXqqDJO+e06LAwBfZ+gIo6OBZ6PVjNwgGTBU/Ia8K/kDcbCW43+n1UdDA3oer2KjgCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SvWz0E53; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SvWz0E53"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so2189835a12.1
        for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787326033; x=1787930833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5KNqR+Z9IxLSc32b0C//meXHlhovgNH24s4FNBaoQws=;
        b=SvWz0E534oVtnqQzIPoJ0zfmicHUd2gseIwHRDkfWpLDpFQhgWtjoDg/ny7gvaZXHS
         edVd+J+Pun+HTqZFRQhbSHVZYg2v9zfiNDhb3PBlkS1hk8nmWq/JAbklDpi+M6UBOQkh
         f8tkJO84lcIJd5PfT73OwOa+wRWRQslFVLw+jGOGA0rpK9aNQ6A2ikKLQwgCi1Azmbny
         oZyTed+6CLnLkiHaWp0P3/76mdiRw3UI3qyisVf3vpKq7NmvWZ+S6x+FgPP4jbQ9OywR
         z2drrSk8nnTAZieJ1zCMhGc9GXt4vBeqyVKKdYBAYOahAnJ7rv9qSXfdM9ld8qHmvdm5
         IRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326033; x=1787930833;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5KNqR+Z9IxLSc32b0C//meXHlhovgNH24s4FNBaoQws=;
        b=PFEqSNQy+PW9NNpsp3MZGM/Yt+c5ULgkOWCBR1hw+HvdeqPmJwcjlKpc6NLgyci8xs
         nD6WCbPNa9xbBsqcVHk96GUffY5RK77rQpRxxYyJhHIqfAzq1nQkNTxHz7IGhVLNESlM
         nAD14XGnNOnCqbERHn53+t5jl6l/vthsXNlUwgyYQONqX+M3BxxVza1MpnYY02K4GyAc
         X4juVeAXsSVJKfU/SmlsEXc9s5RRgFO0axNek/ubrZPamERrxGfxa1PmpN/a2Apxg+kw
         vyD7uOGaLsJQ0XNgi8RoD3pkbeMrT+wqM7yKJlT/2BoRhBEgHGqxNoZvave9khRyiS0a
         ZIog==
X-Forwarded-Encrypted: i=1; AHgh+RqWdYPQVoQWGtsmIdDTlWr2ZIUuGW87tABuBLsr+Xcfjg277Y1jT7xxjGBRfWw5LKJIX1yAjqb9dqK8/7B8@vger.kernel.org
X-Gm-Message-State: AFuF++n3nycEpv7r9Km7bXT+503vKadWGDP+7mvSm7Al1bQZmg9egTK3
	IHiDWGk5CztMweITjcV9nLrM2l+POf3+cAE3PQSm0N0aA/7ugq7nDWI0uO5kOq6kR0I=
X-Gm-Gg: AR+sD12BNOd329jRmdnCs7YMrNvQNwwmxyaUYgfpqJTGo9rUg7VTIsZz7mC+Io31ErK
	c8ASwm0MiwQTeiSNVOl1nl4mhpxM0W1M+WJ9CVAOCWao4bcybxQCRU6wc29eiMYJW50kvP4zbsg
	IjdeW3pOqLX9UZL3waYpyN88hw3zDSIbGN0H+HDEDkSVziEzA46HXUm6j0rWeOb1evjidA4NzjC
	aD4n7/jixLuxHgXF5pk9curAUm6gQp57qdhURUP8dReKIgPvMX265i5Bkn+NB7BiG5oYkHcFHCc
	P7D61zene6rpY0Q+8IZMDHDQBFK3zT8KO+orC1r1r4TPGUNBNRra6A0sD/wn3hEv0/7P4w73llz
	nvKDgJbz0PDha/Y/XaHPZtv/qPjm8W/J7/aSoQjRfYgOvBl2FUy+jMadn7W/DPJgnWJI5y/qrG5
	nef85P4g2Ew1658clE2CklYlYN892HUEJyhSDw+BmX54ZKjWEExr6/CujLS6dctA==
X-Received: by 2002:a05:6402:20da:b0:69f:d4b7:9476 with SMTP id 4fb4d7f45d1cf-6a42f18886emr6669855a12.4.1787326033035;
        Fri, 21 Aug 2026 08:27:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9e2esm6925285a12.5.2026.08.21.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:27:12 -0700 (PDT)
Date: Fri, 21 Aug 2026 17:27:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Fix stack check for aliased old_func
Message-ID: <aohuTo9QOhzvCkP2@pathway.suse.cz>
References: <20260812140232.48079-1-x90613@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812140232.48079-1-x90613@gmail.com>

On Wed 2026-08-12 22:02:32, Harry Hsu wrote:
> klp_check_stack_func() decides which address range to look for on a
> task's stack by asking whether the func preceding @func on
> ops->func_stack is the original kernel function or another livepatch's
> replacement.  It uses list_is_singular(&ops->func_stack), which only
> tells "one func on this stack" from "more than one".  That assumes every
> klp_func of a patch gets its own func_stack.
> 
> Aliases break the assumption.  Several symbols can share one address:
> 
>   ffffffff8ed7fef0 t __do_sys_fork
>   ffffffff8ed7fef0 T __ia32_sys_fork
>   ffffffff8ed7fef0 T __x64_sys_fork

Interesting. Great catch!

> klp_find_ops() looks the ops up by func->old_func, i.e. by address, so
> two klp_funcs of the same patch naming two of these symbols resolve to
> the same klp_ops and are both pushed onto one func_stack.

Right.

> The stack is then head -> B -> A.  A is the last node and does
> correspond to the original function, but list_is_singular() is false, so
> the "previously patched function" branch runs: list_next_entry() applies
> container_of() to &ops->func_stack, treating the list head as a struct
> klp_func, and reads func_addr/func_size from past the object.  Besides
> the out-of-bounds read, the bogus range can keep matching stack entries,
> so tasks that are safe to switch get -EAGAIN forever and the transition
> never completes.
>
> Test whether @func itself is the last entry instead.  The answer is
> derived from @func's position rather than from the list length, so it
> holds however many klp_funcs share a func_stack and never steps onto the
> list head.  A single-entry stack is still trivially last, so existing
> behaviour is unchanged.

This might fix klp_check_stack_func() for A. But not for B. B won't
be the last entry so that klp_check_stack_func() would use
the list_next_entry() and will check for A on stack instead of
the original function.

Another _big problem_ is in klp_ftrace_handler(). It would use A
in PATCHED state and B in UNPATCHED. But it is not clear whether
A or B should be used in the PATCHED state. And it should use
the original code in UNPATCHED state.

IMHO, we must catch this situation when preparing livepatches
and when enabling the livepatch. A single livepatch must never
create two entries on any ops->func_stack.

IMHO, we should catch the duplicate (aliased) entries in
klp_init_object_loaded() and return -EINVAL when they are found.

I do not see any other solution. We could not decide which
struct klp_func should be used for the redirection when
more of them point to the same original function.

Best Regards,
Petr
