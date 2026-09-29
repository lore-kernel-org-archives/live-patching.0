Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCE3AA50B;
	Tue, 29 Sep 2026 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669591; cv=none; b=ZLzOjqZ+lQREzTKnuN9+jrGM+ZzizjkIw1ZozQM1w1vkC6Jty4nNLT5eca6wJyh9TZYkmD/tOTnUURUEQq+KahSzF7Zdd193TExMt5DQwkFEJjv4Qd9PyUhthq7JKKBHfdYpYotDlEtEOAXttY06Fh5sGP2OND1aZSbsEC/1/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669591; c=relaxed/simple;
	bh=v8DQUlsclNkmugEM/JKprg85AKOfY+LbK3ZR6vv+I9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa0rK9LaUn51jv7GQ2CyUzTOHvxjU0UYmenH4JH2PKyNiYZ6bX43cTDCy21HfVeoaEi+ol/x2g9C0fQWhz1QANS6RVYQNVS+Y6bIM39E/2/jvxsv9B9JA2GwDp0taulCeiArUQAGSXLitGhkcyD8PEQ7aAhgtL97fezYVCKd9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1xBSG5-00000002hMb-0XNg;
	Tue, 29 Sep 2026 09:28:13 +0200
Date: Tue, 29 Sep 2026 09:28:13 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com,
	shuah@kernel.org, mpdesouza@suse.com, oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 0/7] riscv: Add reliable stack unwinding for livepatch
Message-ID: <artojcJftbMIgPrj@akranes.kaiser.cx>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Shuai Xue (xueshuai@linux.alibaba.com):

> Hi,

> This is v6 of the RISC-V reliable stack unwinding series for livepatch.
> Wang Han has left our team, so I am taking over this series from now on.

> The series adds explicit frame-record metadata, preserves the frame
> pointer through dynamic ftrace, and replaces the open-coded stack walker
> with a conservative frame-pointer based unwinder. It then enables the
> RISC-V livepatch capability and adds the syscall-wrapper selftest prefix.

> Changes since v5:
> * Rebase onto the current riscv/for-next; no functional changes.
> * Fold in the tags collected from the v5 thread:
>   - Reviewed-by: Shuai Xue on 2/7, 3/7, 4/7 and 6/7
>   - Acked-by: Miroslav Benes on 7/7
> * Add my sign-off as the new sender.

> Since the patches are otherwise identical to v5, the v5 validation
> results still apply. For reference, from the v5 cover letter:
> * Built Linux 7.2.0-rc6 with riscv64-unknown-linux-gnu-gcc 15.2.0
>   and binutils 2.46.
> * Standard livepatch configuration built successfully, including
>   Image, vmlinux, modules, compile_commands.json and GDB scripts.
> * CONFIG_IRQ_STACKS=n variant linked successfully with GCC.
> * QEMU 8.2.2, 1 CPU: livepatch selftests PASS: 7, SKIP: 1,
>   FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
> * QEMU 8.2.2, 4 CPUs: livepatch selftests PASS: 7, SKIP: 1,
>   FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
> * No BUG, WARNING, Oops, panic, unreliable stack or Call Trace found
>   by the validation log scans. Expected negative livepatch errors are
>   part of the selftests.

> v5 was posted in early August and has been quiet since then. I would
> appreciate it if the series could be considered for the upcoming merge
> window. Happy to address any remaining feedback.

> Base:
> riscv/for-next 77ae27fd98f3 ("Merge tag 'printk-for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")

> Previous versions:
> v5: https://lore.kernel.org/r/20260804103626.2803112-1-wanghan@linux.alibaba.com
> v4 RESEND: https://lore.kernel.org/r/20260629072713.3273743-1-wanghan@linux.alibaba.com
> v3: https://lore.kernel.org/r/cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com
> v2: https://lore.kernel.org/r/20260528082310.1994388-1-wanghan@linux.alibaba.com
> v1: https://lore.kernel.org/r/20260527123530.2593918-1-wanghan@linux.alibaba.com

> Assisted-by: Qoder:Qwen-3.8-MAX-Preview

Thanks for these patches.

I tried them on a standard rv64 qemu and on a rv64 cheri system
(cheri-linux.org). The latter needed some minor tweaks, but in
both cases, I could get livepatch to work.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Tested-by: Martin Kaiser <martin@kaiser.cx>
