Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5038348C4C
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933870; cv=none; b=eTvuaEidkRwMM10gEGHFsQYPmZhRkNuUgeC3tsmALZP4UldJh0FlnCiDFJXsLF8RweaNna8663tbE8qoo443ff3YRLT+Af1fHsZ7cK6r0mvpWdWTHBXK9MhAWro6L9IS98VNDE7vmEx/sEN7GsD/s8IcxSDbmeVMys3Yngvx6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933870; c=relaxed/simple;
	bh=31jn+ZflGNeptEWnU+H7PqU+oMzvnAXJoGDtzDIfLZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHt/XdddHJS5g7Us+FUvBMcBlkSlQmHaKMEM9TqcfO0sIDapxgybFa2p+G8NswlcvLxTrwUl6S/5ewU+sSGwY62VDi2y+NTrQsQ5HD6jdFj/Qjr0jEbPSeMksz7Z4b4mCUz/mK8osqq8P7hOZ/r3YgnJTnjjGy8D8tFmqOHi7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiBFUEo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiBFUEo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A765C1F00ACF
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933868;
	bh=1tv8Tm8R0ZAZUADjQb2rjUZ5SgJ1aUsSJAnw3EF0xWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PiBFUEo63zfvjTsAPZg3tDWfaru3f0MTUgLLJSCcJa/BbaisYT6MGHr48un4XN1eo
	 c2ffIkkz25EgKqfqktLa/eKaoA5/+0/1BIwlpfwT0IhF7Madg8v78/lyktww9eyeKH
	 f+jMQnsafuJ1WaNTn81UDN9dGXrRCmNCDrNOjPiDHGmyGuGM8qIptyiGAQZgBnhCfc
	 VFwcVKLJLbpx50xKSpwpMQRYrgZXtixgFpw9cugX0epb6BQte5mHwncZpZ8lTckzFU
	 QlkdXGV/UgutpPpfrDyBHnEVZ0ImSX3wvcsbEYiW36AJAwEfNDie3//sJ4MZXthqSp
	 CAH5FLVy+bA8A==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6a434cabso53866585a.1
        for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 09:17:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoL3Qh6srTOEtkGtJds8Fq15YYMyZzqns6asJKSfEjwrkwgo/y0JZKPWeEeH8fPj/fkESRi2EphJizdr2zX@vger.kernel.org
X-Gm-Message-State: AFuF++ly7Vyzb4OuNPqKM5vSec5zOtHPpEYIACseHkLYS8WIxV045zWJ
	jvkSUUq4BTN6ZcPohq9h1iqbQL+y5SnnRBtkAg+FYPU2AUWtdYhxYIyThQ8SsbtSlJTCdPAjT2D
	FGEX7MmttmyL7vG46Tkb6TBospuHv178=
X-Received: by 2002:a05:620a:2b48:b0:936:ce17:dac3 with SMTP id
 af79cd13be357-939139aef87mr944576385a.40.1787933867884; Fri, 28 Aug 2026
 09:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823060734.58443-1-x90613@gmail.com>
In-Reply-To: <20260823060734.58443-1-x90613@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 28 Aug 2026 09:17:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW70RpkZ1ciioSjt6qkQePWyeic_L+98d0h-Ao3ze-TmkA@mail.gmail.com>
X-Gm-Features: AcwNN1VJy8nH2sdZFR2KuQawv-IkOq_WyTdDQowYx_pyUkDU7wCkjInIfZQ2pDI
Message-ID: <CAPhsuW70RpkZ1ciioSjt6qkQePWyeic_L+98d0h-Ao3ze-TmkA@mail.gmail.com>
Subject: Re: [PATCH v2] livepatch: Reject livepatches with aliased old_func
To: Harry Hsu <x90613@gmail.com>
Cc: pmladek@suse.com, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 11:07=E2=80=AFPM Harry Hsu <x90613@gmail.com> wrote=
:
>
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

Acked-by: Song Liu <song@kernel.org>

Can we add a selftest for this case?
