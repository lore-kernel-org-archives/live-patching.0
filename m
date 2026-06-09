Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104453D3CEF;
	Tue,  9 Jun 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990090; cv=none; b=LB7XbhpB/KL/dlL0YPvpfOO+wKZeecF9+rF3QKaTvkvyVrW2YfweET/6Wzhs+E0anDVvxXIjm+lNWl7fbO0C8Hxuo8jEqDfx46tXVR0APGaAOHLM+SSArgxk/HzQdeMr0AJVQoWCB1z4pAjmcHryx/VQgnGkJKLGpkPfpdVmu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990090; c=relaxed/simple;
	bh=1tjO6VMGzyVIS+TNlEBflb9MJnuAW7Hr0LU4DhXj+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjAyRMDvFn/ydG3DIwJwvZk0GGtEv6KZCEBzUaMolb8xDTX66QX8rOjblYXVCNka4S9mBXGyAXEFrg8GPH8ag0k6K5fww35vMtjzfsoQHZMihLNdL6GvQaJr7PfUKqhRTitTHMLC1q/stOjyxury47WYrgHLSgJjHAWFTNBHyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wWqsJ-000000020yB-196a;
	Tue, 09 Jun 2026 09:27:51 +0200
Date: Tue, 9 Jun 2026 09:27:50 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Wang Han <wanghan@linux.alibaba.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Pei <cp0613@linux.alibaba.com>, Andy Chiu <andybnac@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, oliver.yang@linux.alibaba.com,
	xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/8] scripts/sorttable: Handle RISC-V patchable ftrace
 entries
Message-ID: <aifAdmxJtnVjshl2@nb282.user.codasip.com>
References: <20260528082310.1994388-1-wanghan@linux.alibaba.com>
 <cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com>
 <20260609063002.3943001-1-wanghan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609063002.3943001-1-wanghan@linux.alibaba.com>

Thus wrote Wang Han (wanghan@linux.alibaba.com):

> RISC-V uses -fpatchable-function-entry=8,4 when the compressed ISA is
> enabled and -fpatchable-function-entry=4,2 otherwise. In both cases, the
> patchable NOP area starts 8 bytes before the function symbol address.
> The __mcount_loc entries therefore point at the patchable NOP area
> associated with a function, while nm reports the function symbol at the
> entry address used for the function range check.

> After RISC-V selected HAVE_BUILDTIME_MCOUNT_SORT, sorttable started
> applying that range check at build time. Without allowing entries just
> before the reported function address, the mcount sorter treats valid
> RISC-V ftrace callsites as invalid weak-function entries and writes
> them back as zero. The resulting kernel boots with no ftrace entries,
> breaking dynamic ftrace and users such as livepatch.

> The failure is silent during the final link because zeroing weak-function
> entries is an expected sorttable operation. At boot, those zero entries
> are skipped by ftrace_process_locs(), so the only obvious symptom is that
> the vmlinux ftrace table has lost valid callsites and ftrace users cannot
> attach to them.

> CONFIG_FTRACE_SORT_STARTUP_TEST also reports the table as sorted in this
> state: it only checks that the __mcount_loc entries are in ascending
> order, which a fully zeroed table trivially satisfies. The original
> commit relied on this check and did not see the regression.

> On an affected RISC-V QEMU boot with both CONFIG_FTRACE_SORT_STARTUP_TEST
> and CONFIG_FTRACE_STARTUP_TEST enabled, the sort check still passes
> while ftrace reports zero usable entries and the early selftests fail:

>   [    0.000000] ftrace section at ffffffff8101da98 sorted properly
>   [    0.000000] ftrace: allocating 0 entries in 128 pages
>   [    0.054999] Testing tracer function: .. no entries found ..FAILED!
>   [    0.172407] tracer: function failed selftest, disabling
>   [    0.178186] Failed to init function_graph tracer, init returned -19

> Handle RISC-V like arm64 for the function-range check and allow
> patchable entries up to 8 bytes before the function address.

> With this fix, a RISC-V QEMU smoke boot with ftrace startup tests shows
> the vmlinux ftrace table is populated and dynamic ftrace still works:

>   [    0.000000] ftrace: allocating 46749 entries in 184 pages
>   [    0.051115] Testing tracer function: PASSED
>   [    1.283782] Testing dynamic ftrace: PASSED
>   [    6.275456] Testing tracer function_graph: PASSED

> Fixes: 0ca1724b56af ("riscv: ftrace: select HAVE_BUILDTIME_MCOUNT_SORT")
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Chen Pei <cp0613@linux.alibaba.com>
> Link: https://lore.kernel.org/all/20260527113028.4b21a5de@fedora/
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> ---
>  scripts/sorttable.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index e8ed11c680c6..d8dc2a1b7c31 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -891,17 +891,22 @@ static int do_file(char const *const fname, void *addr)
>  	table_sort_t custom_sort = NULL;

>  	switch (elf_map_machine(ehdr)) {
> -	case EM_AARCH64:
>  #ifdef MCOUNT_SORT_ENABLED
> +	case EM_AARCH64:
> +		/* arm64 also needs RELA-based weak-function fixups. */
>  		sort_reloc = true;
>  		rela_type = 0x403;
> -		/* arm64 uses patchable function entry placing before function */
> +		/* fallthrough */
> +	case EM_RISCV:
> +		/* arm64 and RISC-V place patchable entries before the function. */
>  		before_func = 8;
> +#else
> +	case EM_AARCH64:
> +	case EM_RISCV:
>  #endif
>  		/* fallthrough */
>  	case EM_386:
>  	case EM_LOONGARCH:
> -	case EM_RISCV:
>  	case EM_S390:
>  	case EM_X86_64:
>  		custom_sort = sort_relative_table_with_data;
> -- 
> 2.43.0

I ran into this problem and came up with pretty much the same fix.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
