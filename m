Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513082C027C
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851201; cv=none; b=cQ+oQxRyidAlgLDGbHdLDpDTo8vSzItkNi/Si8BO+QO0T4/JGB6PMpYBrWH1KHWnq8HTBKIuH0es94T5Ym5RxmKMswxJ5FYV9SF2Y0sxgxyetkp9sCbjJJMtwjWtDRvlEevKT8j5A+qxZ4aAFtW7Db+wEXXsb+2jiIHahYhgUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851201; c=relaxed/simple;
	bh=UF0fuhs2KUnT/AG6X6nloda47GwQtywQNTmgw9+Mp/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keRXVEPec/oSQta+5X0dJQ+5sbilrl59T2ZyeuP6gXB5F5PX064G72HzJI6IeaLhbb70gO2GCVCtvSUTLrTthwCREe+mYjPs1o0kacHoldS9jtBY2lsa3BLDXyOIXhT6gnTOZEZFmZhnpOw56k9MQfapJNm3De3PfFFcX5HKlMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fY7ozbf7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fY7ozbf7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so40954535e9.1
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 00:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788851198; x=1789455998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4OKhHlTxP+mf8Lckkb+JFWYpmo6Azxr4Ph5bz47dtc=;
        b=fY7ozbf74zyHAFClTQM2FZ0U6WpitMrksDP4X4cd7A6X/Caju3GirbLfo+8x0rEFOl
         juZq0OkV/EhpDRBAbV2A94Jt8Ww6Z2mCeIoacJyH3FYq6/3C2o/BF/BG0NbYft7Ibl6+
         vhi0j3wBL2uVpSlI8t1+GKfLLSB6L+voRoOwWCZYaL+HXeh5RYEj2XQylXsHzVR1WyIv
         duLIiRcFbEaIseOBeyjJwdSPJdoCxau92tQ2ux7VOPcEU7Qt4EMyfCVMCdmoWcfj0gvW
         +HbNJ+zaRYHRxcLyLTQlwt6+g8jd7e5joqODXVFCOsOhoIc5Nq+WP9QJWTppDNNw62Gj
         riHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851198; x=1789455998;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4OKhHlTxP+mf8Lckkb+JFWYpmo6Azxr4Ph5bz47dtc=;
        b=A6rZZ9VFZcYCmApNI0Q+pBI2HHVaKNo6V+FZU2ZZbIFFviRxQxKvFlc5VcwHH6lWPo
         UJUO/PEDmnvzKX2vl1Xwbfcll6R8mP/Wj7MyR4OFkPs40Yi9IsgFVl1Igu+zzcThWYtq
         rNUEmOZ/WIsBv2uDglxXxZX3eq8qi7Qmel/DxNKSo4loTriGlF/53G+lNefbKU3edaqs
         lAxi0R4FiCJwFvHV43WZgW8W3S4T9wv38b/w8BKhb7JvzorvhartMZRo5/XtLJOruyh5
         UextKvSAChQJKcYVeEXLuR06f84wh/fXjVpIs0+O0CMdefdyoAyhLl4dBwD7kR2Kg0ug
         rdwQ==
X-Forwarded-Encrypted: i=1; AKwUvByyFgkBuuO3qz/4yYAdrlPSdhntx5HZtNU2PQNn3BW3QTTJ+fQaT0hkCY8d6r4P6a6LTqcLEFBi3oS62uOg@vger.kernel.org
X-Gm-Message-State: AFuF++kHDhDYLm6BY0vyRV1tpzPMjmEpXTUMvWXaQB+CKBUrSVOtuW7C
	uN8tYpXRI+il0sJ97jSjCeSzTI8N5uDzakryEkOlVtQNPFQLXzMDseTjPI1LCPJpfQ8=
X-Gm-Gg: AYBFou01f71dr1/vZ6naZJCR5L7OZiAYZHijoqp0WzWYkCkNkE4XvVI0JO3aWqjO+mv
	RsOh2Kf4ieTRWUlxEfyyVhwmhZvzObg2fSuFcQPVp6RTyN6rSGQM9QvhEpPOZf4SyLAuOsQDhVW
	x27hH+Xk6Aap0P8ExJ4MZEn+VCX/9Gq52JB0gRKI7CIVJveS8jSqXr8e40WX72xB4cwrPNRguIC
	e/mbRWEy7+cvxYmYlId4ZfhceNLyIZo7cZSFkP5/zmIEm2cSU5xjzTSo5qua0CsLz6AetQIM/QU
	NrNOBiyo+SCwvsCnGdGzpHamkfAkVfQ8q2CUCjW8Drl2ZU8BfCdEiAMghvEduuR8VCJ7sWYESli
	N927QyMfRG2oTAVeCoYmUWv7XV46PWsXITnMnq0Snsx3dKzakffkSWIjlHSzQunfEVJb0dufbf7
	FTECpUuYzWipDwTjUChYzPZi/8HJfuCeK/qn6k9hDt11hxLynqLtNo
X-Received: by 2002:a05:600c:4e51:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49cff8db5demr463345525e9.11.1788851198438;
        Tue, 08 Sep 2026 00:06:38 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbdacc45sm340625455e9.11.2026.09.08.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:06:37 -0700 (PDT)
Date: Tue, 8 Sep 2026 09:06:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] livepatch: Fail object initialization on duplicate
 patched function
Message-ID: <ap-z-3n9BbtiV9lT@pathway>
References: <20260830173343.52759-1-x90613@gmail.com>
 <20260830173343.52759-2-x90613@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830173343.52759-2-x90613@gmail.com>

On Mon 2026-08-31 01:33:06, Harry Hsu wrote:
> Several symbols can share one address:
> 
>   ffffffff8ed7fef0 t __do_sys_fork
>   ffffffff8ed7fef0 T __ia32_sys_fork
>   ffffffff8ed7fef0 T __x64_sys_fork
> 
> klp_find_ops() looks the ops up by func->old_func, i.e. by address, so
> two klp_funcs of the same livepatch naming two of these symbols resolve
> to the same klp_ops and are both pushed onto one ops->func_stack.
> 
> This breaks the assumption that a single livepatch contributes at most
> one entry to any func_stack.  klp_ftrace_handler() picks the entry at
> the top of the stack, but when both entries belong to the same livepatch
> there is nothing that says which of them should be used in the PATCHED
> state, and the UNPATCHED state has to end up at the original function
> either way.  klp_check_stack_func() cannot tell them apart either: it
> asks whether the preceding entry is the original function or another
> livepatch's replacement, and an aliased sibling is neither.
> 
> Patching two aliases of one function from a single livepatch was never
> meaningful, so fail object initialization in klp_init_object_loaded()
> rather than leave the redirection undefined.
> 
> Fixes: 3c33f5b99d68 ("livepatch: support for repatching a function")
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Harry Hsu <x90613@gmail.com>

Looks good to me and passes selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
