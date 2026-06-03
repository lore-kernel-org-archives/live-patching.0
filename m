Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4B283FCF;
	Wed,  3 Jun 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452653; cv=none; b=Xj0l9Px7x3h0iRb97l+x48cNVj5r3Vq0EcPwSpgKD67ltPHv1ooIz+LITpeQRKawhuu81K0NIz5cGuOkiqMEeHPLQkf4jQdsSaMew3tSxx0hrNKwEnT50n+z3HXPKgQLxfN3p6Em2YuDlsucNpL0xmGPh+dKP4g4eECkKyHiSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452653; c=relaxed/simple;
	bh=sXwvZ3wYOxFDQXt0kfCdHokeQDrQ2QizOVau/+esg4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWDWxz6AiV8iCBXj/A6DFAq9zYy+GFSrApi7UcseFA/59ubesf7KQyK2iqbPKGGOO+00QCgHNnTF6OG+Mgt68iZCaeH0c0oJLREPjsl6O/HYT8BPPxm2L45R9TWLKuTJeJaWEhZDtI9km5xvTD0UZUaclr+bFhgAKxlqv6X8svU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PdQ9892K; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PdQ9892K"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780452649; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jv3cJulouSWGCvGi6TS1IMCaE/rqytDPu3rilFU0XAM=;
	b=PdQ9892KisRjKniNqwNvBrPBbRq95IfB9m4CDMSoqRaJtuAVVn0WhQNcM5u5UjO5axes7st/Dz3DfepyMAEiSF/KRgCj3uX6niBrXtSvXhKicchdpXFj4vfXLoU4qir6AgvEifNR8+X9DQgBeg50mjCS5k+cwvqfd+e54wK6boQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X45l.8N_1780452644;
Received: from 30.246.180.204(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X45l.8N_1780452644 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 10:10:47 +0800
Message-ID: <6753385b-c2ab-4ed0-9400-78ce967450ba@linux.alibaba.com>
Date: Wed, 3 Jun 2026 10:10:44 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] scripts/sorttable: Handle RISC-V patchable ftrace
 entries
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Han <wanghan@linux.alibaba.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Pei <cp0613@linux.alibaba.com>, Andy Chiu <andybnac@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Deepak Gupta <debug@rivosinc.com>, Puranjay Mohan <puranjay@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, oliver.yang@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527123530.2593918-1-wanghan@linux.alibaba.com>
 <20260528082310.1994388-2-wanghan@linux.alibaba.com>
 <0a913398-3d0c-472e-89c4-062052eae04d@linux.alibaba.com>
 <20260601095746.70c01d24@fedora>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260601095746.70c01d24@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/1/26 9:57 PM, Steven Rostedt wrote:
> On Mon, 1 Jun 2026 14:17:08 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>>> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
>>> index e8ed11c680c6..4c10e85bb5af 100644
>>> --- a/scripts/sorttable.c
>>> +++ b/scripts/sorttable.c
>>> @@ -891,17 +891,21 @@ static int do_file(char const *const fname, void *addr)
>>>    	table_sort_t custom_sort = NULL;
>>>    
>>>    	switch (elf_map_machine(ehdr)) {
>>> -	case EM_AARCH64:
>>>    #ifdef MCOUNT_SORT_ENABLED
>>> +	case EM_AARCH64:
>>>    		sort_reloc = true;
>>>    		rela_type = 0x403;
>>> -		/* arm64 uses patchable function entry placing before function */
>>> +		/* fallthrough */
>>> +	case EM_RISCV:
>>> +		/* arm64 and RISC-V place patchable entries before the function */
>>>    		before_func = 8;
>>
>> Nit: The shared comment now sits under `case EM_RISCV:` but the two
>> lines above it (sort_reloc / rela_type = 0x403) are strictly
>> arm64-only — they configure the RELA-based weak-function fixup that
>> RISC-V does not need. On a quick read it is easy to wonder if RISC-V
>> is implicitly inheriting that path. Splitting the comments would
>> help, e.g.:
>>
>>          case EM_AARCH64:
>>              /* arm64 needs RELA-based weak-function fixup */
>>              sort_reloc = true;
>>              rela_type = 0x403;
>>              /* fallthrough */
>>          case EM_RISCV:
>>              /* arm64 and RISC-V place patchable entries before the function */
>>              before_func = 8;
> 
> Makes sense.
> 
> Care to send a v3?
> 
> -- Steve

Hi, Steve,

It's a pure comment cosmetic, not worth a respin on its own. But for the
rest of the feedback on this series (the frame-record metadata contract
in patch 2 and the dead state->regs field / Call Trace output change in
patch 6) are the ones actually worth a new version.

Just to get the routing straight: are you planning to pick this one up
through the tracing tree on its own?

It feels like a good candidate for that -- it's an independent
regression fix (Fixes: 0ca1724b56af) that breaks *all* RISC-V dynamic
ftrace, not just livepatch, so it shouldn't have to wait on the rest of
the livepatch series.

Thanks.
Shuai


