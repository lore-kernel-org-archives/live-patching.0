Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C459392C20
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851371; cv=none; b=jVC5k+764q/hfoI/qzqQM2kaHsT8COycRUr6eRm+rct8xioEmCAHcFjpTqiYKLfhlRzVSBEovJoDj+u61sMjuvQD1GLwVdgnXtmgbvqklLf9qVQfAfr6COEl3gnpYD78N8hSZWKVZ1mfWABqD6jDC1d5Y7MK5hSJ8JNy8awXVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851371; c=relaxed/simple;
	bh=u+ey/CJS2ARmIQu5wX+w7GU/MrgYt6L2EL87LvMkuBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST2JHYkdzywFk05DdazgjlzbVkpXhabVHHvWQ4xkXTBwxZeDhYheurvE+Qy/g+qPsp+QreHZxzVvlqSNtECCHqanFWT/E7jksFhFhp81xuEhWlCELkpK5bMajuf+2puuflbc7b0IbFn1Fq6rN3tnMXpLLnbphz+abDTLykSY1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZYjWVFwi; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZYjWVFwi"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356257so340704f8f.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788851363; x=1789456163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KaN8ORG6D91TdeVvPbVzs5MI5F+Br3tg7mv89xYjlPA=;
        b=ZYjWVFwi2Cc6OukpxbZKVvjmFZIpkWLZq8M84L4yQphYUd/wNr/quUFeO4G9nSVOjk
         xx5X0AL9RPi02lwvFk00TZvav9Ta+Wv+I1Mul2zLxbUc8nXc+o7GjmMrhFFI0vFSCgbr
         TFsFhkZYnxfgMMppaPt9FPVCOqDSpGXQT7pokxrE87gyPmiPSlS38/Tc3nOh7jpT/jKs
         sBPdgzEkN2p7ic8wwYZxnwy+8MA6ITLR47a8yZtroJfYTzTAx1fAQ2IDA9LUneimxMat
         /Ggfc71n1ILLQUhKOBFQG5KwMxFVvk91IOua8FOvJufVY57FcJy0K9NdMQ2dm+9TLsjk
         naug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851363; x=1789456163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KaN8ORG6D91TdeVvPbVzs5MI5F+Br3tg7mv89xYjlPA=;
        b=ksv+1baucdtRBCykc/NNdKG0vPTRhC+nVM/wmYqrU3z3pQ/Zac4ddumHlEjWSNQZYK
         QCZuFpyPTj78/GHBXtWzTUe76Dv1YJFu+U36bEwZjM6Uxv9ynaPR5faQQai1/cf/ejH3
         nWgaGn3Ag3jAy+8WRPKLeAT/gFJ3R0jeBvUFyjueYmb/gTKvaYKga+rCpCcxXkcManw4
         Q6R8lb5opTXxsCZItbV3yULqdOjq3s4pyLBj77+bM8aTaTfYSnputkIzXIP+3Lguhf+R
         d8mtLkkKuQivNf5OkQxQY6UL5NKHImk3XuN1vR0gca+3Bv+9lTSUUEqAMJSDAPHRUOOZ
         +pYw==
X-Forwarded-Encrypted: i=1; AKwUvBxPJG2n9l3vt7mNEQI5aNXHD5rAOEELVqkOCVcA/veyCblvMhlwQQWmFdGCSM+9TVwNdd3cBjIcQ2zve4XK@vger.kernel.org
X-Gm-Message-State: AFuF++nQ9edLq5ZQZ8pPzNbGWcOtyo1F8DcSa3st8AlD9HGk21VKzMgS
	Fpwo40AiiUxpUYF2qYaeIJVhIc9SaOHqdMqSmEFW8CpjEay1fpSlOZ4SRcrlAJL0XFk=
X-Gm-Gg: AYBFou2+9lqGGyzE0t0ZavSMMvnjg6xPPX863n5TP480ndk0P8V78Mh7KE6hre41VP+
	vRFZR9yYSCsVCU5RR5A8wyVbRi2D6waOhBF8hJdbilii8EOqQnlOvy97bk7DE4ZIH5kyZGGhO3E
	y7WuVmI5AiyDBxQX57mVhSnJaGnKNQ+ZkkpATTpjT9W04sxOZ3HVJYfoUcb2lBwMd3pH4reMpOT
	yqJcCFw4OQmkWGumwUZYsMseqlus1tu+6bZLRgo8lK5xID5qbJEqZvvjG/DMz9RSQLtkuDBq0he
	EfEakmY+olMWJ01HVmjimHXflhE9EMF6LNimYj86cDzVAKm19PRIJ6EP6lxLfse/fdkFYuq4oFc
	Ata+FdJ/lChhxa5xDpRZYVYugmeFhh2H9yKIUe1jFk/U3v2NkPPXZqUOz8YRg4pQhDSG8VgONLV
	8XIbLeNEy41bWrrwxJDgtWRYg/Cz2nIU5gY8v/DTQjSq3wBbUMCAE=
X-Received: by 2002:a05:600c:1908:b0:49c:f13e:e4f with SMTP id 5b1f17b1804b1-49d1757b03dmr45007475e9.12.1788851363346;
        Tue, 08 Sep 2026 00:09:23 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm279962065e9.13.2026.09.08.00.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:09:22 -0700 (PDT)
Date: Tue, 8 Sep 2026 09:09:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org, song@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: Test rejection of aliased symbols
 in one object
Message-ID: <ap-0odfpLVv8k2er@pathway>
References: <20260830173343.52759-1-x90613@gmail.com>
 <20260905155507.273262-1-x90613@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905155507.273262-1-x90613@gmail.com>

On Sat 2026-09-05 23:55:07, Harry Hsu wrote:
> klp_init_object_loaded() now rejects an object whose klp_funcs resolve to
> the same address, because aliased symbols would push two klp_funcs of one
> livepatch onto a single ops->func_stack and leave the redirection
> ambiguous.
> 
> Add a target module providing test_klp_alias_show() together with its
> __alias() sibling, and a livepatch naming both of them.  Two test cases
> cover both callers of klp_init_object_loaded(): the klp_enable_patch()
> path, where the target module is loaded before the livepatch, and the
> klp_module_coming() path, where the livepatch is loaded first and the
> module loader has to refuse the target module.
> 
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: Harry Hsu <x90613@gmail.com>

Looks good to me and seems to work:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

> This is the selftest I promised in the v2 thread [1].
> 
> It applies on top of patch 1/3 of the series [2] and does not touch the
> rest of it.  Petr, since you are going to post v4 of the whole patchset
> anyway, please feel free to fold this in as the last patch.  Otherwise I
> am happy to resend it as a separate follow-up once the series lands --
> whichever is less work for you.

Yup, I am working on v4 and included this patch.

Best Regards,
Petr
