Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27216443C34;
	Thu,  8 Oct 2026 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460071; cv=none; b=k8Pv6uw8ifoqIIEJOzIoYgmmo5AopaSZYlzJSP2DAeO3Y+1XTmRfwplCc/Vn62+vuNRpvsDy7IqOLput02xyvIdEa/5SixvVPXmzbp/82zx2ebMgztGqOd9iAbyawjgE2LotRQ8lf2FpS84LQeNbAqEGC7BdjCTt9eSqyXGy1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460071; c=relaxed/simple;
	bh=OUNZ/VZ8OrrRrCTA8+5HB6ElWjtVTJ5aPjr31lVAvcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7BN8Ue3ZXfPAHP4kAHtQcl4N/6zfCbhw4zCycXWzPHWApjOG+sEJhKCJ5LvuXIJBDTuzHuUaciMi8jDubHuanlxDZEJvBcArVt/UUTigE6Mldg1LQJYlMQ5NKKoTrQBS+8ucrYm1J1g7kZL/k3F1mU/4WNfpI/N1wAUFm/GwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d9SfD7/i; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d9SfD7/i"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791460059; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2uRUiMGM/3kM5oFgvWkstit41ISjJ8dKFkmnjBOgzTY=;
	b=d9SfD7/i3F8/7mhWPtNs4PbENsPzHePZ1tusqOfNzF5OEb5MFFoyDHTotZ1yhdHWLAPcOqQcJ7vrppp+F7wUyLx6J0Kmq+NKypSW6hYOV3xee4wMei9wClqocofEV3QaqZCjRJjxL3enc1nYpJX9r9cQ+T9pDtH57kKkJMPiO58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0XCP.Q2W_1791459729;
Received: from 30.246.161.100(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XCP.Q2W_1791459729 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 19:42:10 +0800
Message-ID: <fbdb7b4c-0f80-41b0-b6d8-a4501ff3e820@linux.alibaba.com>
Date: Thu, 8 Oct 2026 19:42:08 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] riscv: Add reliable stack unwinding for livepatch
To: Martin Kaiser <martin@kaiser.cx>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>
Cc: pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, oleg@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org,
 jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com,
 shuah@kernel.org, mpdesouza@suse.com, oliver.yang@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <artojcJftbMIgPrj@akranes.kaiser.cx>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <artojcJftbMIgPrj@akranes.kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/29/26 3:28 PM, Martin Kaiser wrote:
> Thus wrote Shuai Xue (xueshuai@linux.alibaba.com):
> 
>> Hi,
> 
>> This is v6 of the RISC-V reliable stack unwinding series for livepatch.
>> Wang Han has left our team, so I am taking over this series from now on.
> 
>> The series adds explicit frame-record metadata, preserves the frame
>> pointer through dynamic ftrace, and replaces the open-coded stack walker
>> with a conservative frame-pointer based unwinder. It then enables the
>> RISC-V livepatch capability and adds the syscall-wrapper selftest prefix.
> 
>> Changes since v5:
>> * Rebase onto the current riscv/for-next; no functional changes.
>> * Fold in the tags collected from the v5 thread:
>>    - Reviewed-by: Shuai Xue on 2/7, 3/7, 4/7 and 6/7
>>    - Acked-by: Miroslav Benes on 7/7
>> * Add my sign-off as the new sender.
> 
>> Since the patches are otherwise identical to v5, the v5 validation
>> results still apply. For reference, from the v5 cover letter:
>> * Built Linux 7.2.0-rc6 with riscv64-unknown-linux-gnu-gcc 15.2.0
>>    and binutils 2.46.
>> * Standard livepatch configuration built successfully, including
>>    Image, vmlinux, modules, compile_commands.json and GDB scripts.
>> * CONFIG_IRQ_STACKS=n variant linked successfully with GCC.
>> * QEMU 8.2.2, 1 CPU: livepatch selftests PASS: 7, SKIP: 1,
>>    FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
>> * QEMU 8.2.2, 4 CPUs: livepatch selftests PASS: 7, SKIP: 1,
>>    FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
>> * No BUG, WARNING, Oops, panic, unreliable stack or Call Trace found
>>    by the validation log scans. Expected negative livepatch errors are
>>    part of the selftests.
> 
>> v5 was posted in early August and has been quiet since then. I would
>> appreciate it if the series could be considered for the upcoming merge
>> window. Happy to address any remaining feedback.
> 
>> Base:
>> riscv/for-next 77ae27fd98f3 ("Merge tag 'printk-for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")
> 
>> Previous versions:
>> v5: https://lore.kernel.org/r/20260804103626.2803112-1-wanghan@linux.alibaba.com
>> v4 RESEND: https://lore.kernel.org/r/20260629072713.3273743-1-wanghan@linux.alibaba.com
>> v3: https://lore.kernel.org/r/cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com
>> v2: https://lore.kernel.org/r/20260528082310.1994388-1-wanghan@linux.alibaba.com
>> v1: https://lore.kernel.org/r/20260527123530.2593918-1-wanghan@linux.alibaba.com
> 
>> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> 
> Thanks for these patches.
> 
> I tried them on a standard rv64 qemu and on a rv64 cheri system
> (cheri-linux.org). The latter needed some minor tweaks, but in
> both cases, I could get livepatch to work.
> 
> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
> Tested-by: Martin Kaiser <martin@kaiser.cx>


Hi Martin,

Thank you very much for testing the series and for the tags!

It is great to hear that livepatch works both on a standard rv64 QEMU
and on the rv64 CHERI system. Could you share what the minor tweaks
for CHERI were? If any of them are generic -- for example frame-record
size/alignment or pointer-width assumptions in the unwinder -- it may
be worth folding them into this series, so the cheri-linux tree has
less to carry downstream. If they are purely CHERI-specific, a pointer
to your tree would still be a useful reference.

+Palmer, Paul, gentle ping on this series.

It has been under review since late May (v1 on May 27, now in its sixth
revision) and the tags collected so far are:

   * Acked-by: Miroslav Benes <mbenes@suse.cz>             (7/7, livepatch)
   * Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com> (7/7)
   * Reviewed-by: Martin Kaiser <martin@kaiser.cx>         (whole series)
   * Tested-by: Martin Kaiser <martin@kaiser.cx>           (whole series,
     rv64 QEMU and rv64 CHERI, livepatch working on both)
   * Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>   (2/7, 3/7, 4/7, 6/7)

v6 still applies cleanly onto the current riscv/for-next
(52318cf0fa6e). If it helps, I can send a v7 that folds in Martin's
Reviewed-by/Tested-by tags.

Could the series be considered for the upcoming 7.4 merge window?

Thanks,
Shuai Xue


