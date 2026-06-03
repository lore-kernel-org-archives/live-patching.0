Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125939B4BB;
	Wed,  3 Jun 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470896; cv=none; b=IBeXSs6xJG59AOmqDrJODvfoF8+kfUEx979phQw1JrjKOTxfha8quamC7tflG6hnKw7G5a3iN1U1QMl1qDTe0IYxYMEOnNYhvC5oE+7hyr9A2+OJ8ijKE0UEvvoOoGNiiSiGh+uVJIlrnDVpaWGoiKuZlEng0V+2Ojx9s5mkLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470896; c=relaxed/simple;
	bh=rDxOehn6sudiAxRrHRT66Kpef5+QJrVaK09yRPwMOOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGpxF5YyVAMIYOIktPXj4SsNp9uEQsWF9MHnB1wjMgM6+YzXDRVoF4JxCSKa95KoCRC4kqthhzn+Sjim3kaGvzgexrUfGVjcKAod19N6pNsOlJGL2HWM+SyI5hMirPqJmV2AB9paWi3BEM2qWk4n9PdliKkyksDk1g/cB9N6qmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gl6upFNn; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gl6upFNn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780470884; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=S3SFKFoWcboEPyPNGOUmpMlqfzFH7srYWpl0FUhqNPI=;
	b=gl6upFNnzDhHgvU+qiSg9Y/QA3GA1MuqGKfxArPk75YFM4ejp3tz97Nv9GY9erqV8pK/6XqCI6tCPEw7XwqncUpINiDz52JKcyE7ojWOLYeh6EVbNH7Z2otNhFCdFhLDMZsEno22oyOEwF7OB3wRM4SJ14Rz0NqsFViDdTNexQU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0X46a5-T_1780470878;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X46a5-T_1780470878 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 15:14:42 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: wanghan@linux.alibaba.com
Cc: acme@kernel.org,
	alex@ghiti.fr,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	bjorn@rivosinc.com,
	catalin.marinas@arm.com,
	conor.dooley@microchip.com,
	cp0613@linux.alibaba.com,
	debug@rivosinc.com,
	jikos@kernel.org,
	joe.lawrence@redhat.com,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	mark.rutland@arm.com,
	mbenes@suse.cz,
	mhiramat@kernel.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	palmer@dabbelt.com,
	peterz@infradead.org,
	pjw@kernel.org,
	pmladek@suse.com,
	puranjay@kernel.org,
	rostedt@goodmis.org,
	shuah@kernel.org
Subject: Re: [PATCH 1/8] scripts/sorttable: Handle RISC-V patchable ftrace entries
Date: Wed,  3 Jun 2026 15:14:29 +0800
Message-ID: <20260603071430.59794-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527123530.2593918-2-wanghan@linux.alibaba.com>
References: <20260527123530.2593918-2-wanghan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 May 2026 20:35:23 +0800, wanghan@linux.alibaba.com wrote:

> On an affected RISC-V QEMU boot with both CONFIG_FTRACE_SORT_STARTUP_TEST
> and CONFIG_FTRACE_STARTUP_TEST enabled, the sort check still passes
> while ftrace reports zero usable entries and the early selftests fail:
> 
>   [    0.000000] ftrace section at ffffffff8101da98 sorted properly
>   [    0.000000] ftrace: allocating 0 entries in 128 pages
>   [    0.054999] Testing tracer function: .. no entries found ..FAILED!
>   [    0.172407] tracer: function failed selftest, disabling
>   [    0.178186] Failed to init function_graph tracer, init returned -19
> 
> Handle RISC-V like arm64 for the function-range check and allow
> patchable entries up to 8 bytes before the function address.
> 
> With this fix, a RISC-V QEMU smoke boot with ftrace startup tests shows
> the vmlinux ftrace table is populated and dynamic ftrace still works:
> 
>   [    0.000000] ftrace: allocating 46749 entries in 184 pages
>   [    0.051115] Testing tracer function: PASSED
>   [    1.283782] Testing dynamic ftrace: PASSED
>   [    6.275456] Testing tracer function_graph: PASSED
> 
> Fixes: 0ca1724b56af ("riscv: ftrace: select HAVE_BUILDTIME_MCOUNT_SORT")

Oops, sorry for missing that. Thanks for the quick fix!

Reviewed-by: Chen Pei <cp0613@linux.alibaba.com>
