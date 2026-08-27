Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9621ABD7
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841774; cv=none; b=QEpeZTltWwrhzXifruguFEZsHG+14Y69Q68BfkTrvLuakmYNjBRYdx3LrryuYmDaqIX3nAQaXL6PjlrPW6sCT76Rzef/5BWumx19GahQJce4HyY6OyKeRQoMHnCRmD20Ho4PN7PQxM1bBPAyTNF6IriBdTQVV703ThS1zgSbcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841774; c=relaxed/simple;
	bh=1ikHomWgH+UponDHIhemDS2OV7lez+IwhkQn8e53KEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKEe9bDo2e5z9BLfXcscjVZKN4IPfKAO9miez/KcHBzynMR0j49ibfo4XdF/Sg+pzQpe+TlizwXmJlA88GTZPoZQu/yXOoTaJcVo40NMOyx1vv+AEY+yVkYCuhduGOWl8l7VzGYTuoPYw20oUk5Pu8HLE2B7aHobCMN4razjUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H77UYuX/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H77UYuX/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956869750eso14949295e9.2
        for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787841771; x=1788446571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y3f6zBlmNQlRLONz4SXWdsjVECFDgl+lzqa1kODqWpg=;
        b=H77UYuX/56r4sdWtu5U5Ex//2xyO+bcFSzYtn+3ubZ2Q3oaIzEjGbidh7CjOs8p2F1
         DWZelorMOlytEtUJyH3/GHySVIpvmwZwwGc03bXyztUAyBCaJ6OSskPfRBIeqJEzG7od
         bPHhWwu1lmaoHx+CCi5OkAchlTuJqgiqkrgGgyhjl3Fo0egr83tFZA8o0ihTpN7AAYVm
         bTH7rRIJslQxbVkW/B9IRgt4dJbN3LjpcDl55OMib/N3Mbom16fBSJwh3ntGWd6H8OBX
         rRwF2rEK/0w8dTguA7ylB1mmi8cxHU3KdMUUW7a00tSlFZdLvz2KHVbHGogNH/h+kuTX
         568w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841771; x=1788446571;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3f6zBlmNQlRLONz4SXWdsjVECFDgl+lzqa1kODqWpg=;
        b=pqaIgN4nPolQI0QLkqPNfC45lzDC20LtcfOGXFpvoS3XyNEbqO+xQLy/rGJj+XMiyG
         HtLle3hZ+bbQboN+wvE7IA5Vt2yfnAVDznFOP8I1We/aEb1svEfQaTZ8fC3WbcNOuy/w
         3BZgegdNBv+z7LrZ2KfFsyqnCxqu6p9tPPx9v+16+aeubNMUXG+0wDI8+xdqFcxTvm3S
         CG9IwGwsxUMwuge6K7XHYZoTAK6UYU7bN3gC8jGB4p05CMlZd2u/Z1nZpYL3xk6q9xq/
         VF7Is5T7Su5pFci2dV0b1g4TijL2O1CuJC5S1Qmyc6mjrBJBZhpHsJcFI3yddciI/vk2
         LyxA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3XUODsvGphhydb8yVO08bSG/GmMQ6dB/h32rjLJhLj0BKJcUP19Wb6N3yh+MyBzuIgnXfvg1gDDnV029J@vger.kernel.org
X-Gm-Message-State: AFuF++kNQkJs1cLXclLB5tmCzKsSNjYOVfJUX6JTCzTn3tW1qLZ20d5a
	HDjz4xqzmS8VxFUFwdNvCU19QfXQEooXNM6EpGEK1y4x7MH6jKrBdMRZ1Pyc1WvpY1c=
X-Gm-Gg: AR+sD13qu43NWG0DePRrrGBC+2k75sBzoOEoJIpQcRtehla/Ec9yM4hrlu3OSwtunVH
	bMwFVFbStxSFky72jo9z7VlxTrAIdtEzW4LIClrahfIYS4/NCdbRv4PsSmQAHb20Uq0bPP5+grS
	3bC4My+sawqEk8lUR0lcXpFoIytQyLq/KdNd1VtZbJvFFl0FSwTSJHjnt88bgdD1JF6lNY35KN3
	bd1zh/uBRxg9yDz5XHc1cIFWXtLnH3CNxq/Q81ATU7SPbCce/g+c6qXuzeU5ocEnCimSKbZ3eeS
	RxGOtzBguJcsKTmY+sT/jYB03incrrurRw5uhWFXjeilZDOMqPN6Ff6Qa3YDKAo5lF9VIZIFIMF
	Hhar9yKxqFm3HkdVzxoD+rNAAr+vvHzsQN34zpBQuD5Q2S9oLzqYQYNL7d+QVlG3POsIgxT9V2k
	NklqHaicXyzJdVyd1N6suVHsGLTxFjr63xvQ9c39VIt9L69f1LJKzNFVE+0tdEcVE=
X-Received: by 2002:a05:600c:4e55:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499dc723fadmr194049945e9.9.1787841770892;
        Thu, 27 Aug 2026 07:42:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4dfdf00csm52342545e9.14.2026.08.27.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:42:50 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:42:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: Reject livepatches with aliased old_func
Message-ID: <apBM6MW42WNFLjIO@pathway.suse.cz>
References: <20260823060734.58443-1-x90613@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823060734.58443-1-x90613@gmail.com>

On Sun 2026-08-23 14:07:34, Harry Hsu wrote:
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
> meaningful, so reject it while the object is being initialized rather
> than leave the redirection undefined.  Compare the resolved old_func of
> each klp_func against the ones already resolved for the same klp_object
> and return -EINVAL on a match, naming both symbols so that the offending
> pair can be found in the livepatch source.
> 
> Fixes: 3c33f5b99d68 ("livepatch: support for repatching a function")
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Harry Hsu <x90613@gmail.com>
> ---
> v2:
>   - Drop the klp_check_stack_func() change.  As Petr pointed out, using
>     list_is_last() only made the last entry behave, still checked the
>     aliased sibling's range for the other entries, and did nothing about
>     klp_ftrace_handler() being unable to pick between them.  Reject the
>     livepatch in klp_init_object_loaded() instead, as suggested.
>   - Rewrite the changelog around rejecting the configuration rather than
>     around the out-of-bounds read that v1 described.
> 
> Link: https://lore.kernel.org/all/20260812140232.48079-1-x90613@gmail.com/
> 
>  kernel/livepatch/core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

The patch makes sense, looks good and passes selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to wait one week. Then I will push it if nobody
    complained in the meantime.
