Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DD3115B8
	for <live-patching@vger.kernel.org>; Tue, 24 Mar 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368024; cv=none; b=aEbjd6SeBgjdmSzihwTyG8xq4AnwEophM4YVZbSsdoOro7SPviML4tOFuy3e68ZgfgiBTyPQLxrPvSRtBx6HxDPUqhfvjbBg69YTxr2T4DffrwQdDT/+eagQSaQLFFNoFw/82xY+lzbedw7btqrvJmN2xD+x6MFk1K0M9DTFP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368024; c=relaxed/simple;
	bh=o+cMkXZ4AL0yvc8YxODTxfgOpONgzCRH94hoPaiSk6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQeXOJs4vDISNP0ac+cI7N/qFkNEHCc3CPIMBW7Dwc/tE072SfequGC7KKqcSyMsF6OdpJJFEcWpODGdyWPNja2X4EI1oXHG11CIfzMYXcwqnUD0h+iUlqjouojZKVVprdQaQdgyJcrlkSz4Kw/06LpMn9vnI166z2S9KvpmAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KkAkN/7n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KkAkN/7n"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so16401875e9.1
        for <live-patching@vger.kernel.org>; Tue, 24 Mar 2026 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774368021; x=1774972821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZud2txb2+gokYF6qCswpOqRe8hThYc5D0An7F/T1G0=;
        b=KkAkN/7nZwFHSlOrMHhFIszI7EZfNiGhn2NZaPp3knF8FbvT7qhEsjnixr18ZsPQ8F
         Np694D1YOe7BoBzB06L6vrk44wLjWMWnkgXEjYUCNuk/nUAcrOazMZ/scQP6rctvOpQ8
         LlUa3xx/PjV6E1b47uLOkTh4GrxZBh25woSoYps5wJzpOkbCjEWWEtHoIFpGIpZoSFIj
         FX+VQxihc19Umdtg1EwdS+Qt0Q/v4QCIIVnV5969BwS118bpndgeKe1mzo4Y6KDlWneV
         JFTCVf11QpRpe1vcHy7jPH+oE6oAejDbwwylsLzsf9nhEs0vc51h886yPsVqpln9Xq5q
         3JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368021; x=1774972821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZud2txb2+gokYF6qCswpOqRe8hThYc5D0An7F/T1G0=;
        b=cX6eipjanbOwvnBtdgo5+iMJIfPjbqCYrChAW/rFgfAAYw7FrUnXjcr3n2kQ++8o/b
         MbZJ0IRPSbTqX9oG44xTRwL413g8AbLZbZz7albWl0plXyriDycUEueO0cSi4md1EUWO
         /P1nUfqD7UeDn4DezKQUwTNFxkKb7nxLmEHtqERviVRArVRxBv5oKVJtt2hd330xw8kr
         hcPrapgSH3avvtLyT/zczTuFdNz7DuARpbl+mD3+7Sp/i5ae42jB/L1V3n+dffKx8SZ+
         paJVPpeZCBQFJcj2sUV2XcnZUVodJsFodLN9R9HUXM+h1zytznvu9+V1hJal5uUlWBXg
         F02Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdIb8cLx+O1QWZGSpYIFYoEcylYV54SX+x0AQ4gyXlHp1PZOmCQm3fbaC8dmg43tH4XQ19DEF8vtR6QSQK@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpfYKneWJsqfZRpKz5gP2e2TBZjw9hDTEou0p/KddNmUQjYcS
	nmOOJ21hdFq5DF8ALu5jHu1Hi2dzAVPyeEerCVI8u7HaC8gxYT4MUZPtvCdbvhGojww=
X-Gm-Gg: ATEYQzzSy52/V7uTtA0Ac+d0AvU+4KRfFwkNtaO/vf45BitTUPXEcNJ5loCAYs2IR91
	ZVmgJ0PmMbWg7QYwNt/J7HA9dSNoeGKf3EugiHyEPw2TW7PpTLWh3AjkXI3ycblka7v/8QEBJpg
	8HIKHbJYtMMcnYa4q5lvrDHxoDnEukrnVobOSl+ELvnabT1Nmas56O1EDe8/2BCmL4C6d0FsLkt
	7Qaxk7qo7kCtKZdk7DA2mjJsd8zu+j9vj/CbnqerDOf77Y+Pb07VjhuzzKcHw3sfkr/AMMo73Tn
	e+DzStBlXh3FewMIN2qViVrXCEjTMt+zISlDkRV1rbEYlgR1EVJ2eM2q8KQ0YdYZVkTwi/daxQe
	cF0kS9WYkZCWM3tc2/zXc/ygioHAdbKgwxJGJzYG4SkZyocoxQFLW/c1lVdo4B2xQ5fs39C4E6N
	DT3lOuv51NnaoAzA2H/qsenX2DxQ7FQ5rsh3r7T41BPxNM
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-487160881a5mr4153985e9.31.1774368020765;
        Tue, 24 Mar 2026 09:00:20 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487113c4eb3sm68147455e9.0.2026.03.24.09.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 09:00:20 -0700 (PDT)
Message-ID: <282574df-7689-4677-929b-b844e7201bd5@suse.com>
Date: Tue, 24 Mar 2026 17:00:19 +0100
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/kallsyms: sort function symbols and use binary
 search
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Viktor Malik <vmalik@redhat.com>
References: <20260317110423.45481-1-stf_xl@wp.pl>
 <b6030f42-b4d2-4e52-acec-76e25c0f40db@suse.com>
 <20260324125304.GA15972@wp.pl>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260324125304.GA15972@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 1:53 PM, Stanislaw Gruszka wrote:
> Hi,
> 
> On Mon, Mar 23, 2026 at 02:06:43PM +0100, Petr Pavlu wrote:
>> On 3/17/26 12:04 PM, Stanislaw Gruszka wrote:
>>> Module symbol lookup via find_kallsyms_symbol() performs a linear scan
>>> over the entire symtab when resolving an address. The number of symbols
>>> in module symtabs has grown over the years, largely due to additional
>>> metadata in non-standard sections, making this lookup very slow.
>>>
>>> Improve this by separating function symbols during module load, placing
>>> them at the beginning of the symtab, sorting them by address, and using
>>> binary search when resolving addresses in module text.
>>
>> Doesn't considering only function symbols break the expected behavior
>> with CONFIG_KALLSYMS_ALL=y. For instance, when using kdb, is it still
>> able to see all symbols in a module? The module loader should be remain
>> consistent with the main kallsyms code regarding which symbols can be
>> looked up.
> 
> We already have a CONFIG_KALLSYMS_ALL=y inconsistency between kernel and 
> module symbol lookup, independent of this patch. find_kallsyms_symbol()
> restricts the search to MOD_TEXT (or MOD_INIT_TEXT) address ranges, so
> it cannot resolve data or rodata symbols.

My understanding is that find_kallsyms_symbol() can identify all symbols
in a module by their addresses. However, the issue I see with
MOD_TEXT/MOD_INIT_TEXT is that the function may incorrectly calculate
the size of symbols that are not within these ranges, which is a bug
that should be fixed.

A test using kdb confirms that non-text symbols can be found by their
addresses. The following shows the current behavior with 7.0-rc5 when
printing a module parameter in mlx4_en:

[1]kdb> mds __param_arr_num_vfs
0xffffffffc1209f20 0000000100000003   ........
0xffffffffc1209f28 ffffffffc0fbf07c [mlx4_core]num_vfs_argc  
0xffffffffc1209f30 ffffffff8844bba0 param_ops_byte  
0xffffffffc1209f38 ffffffffc0fbf080 [mlx4_core]num_vfs  
0xffffffffc1209f40 000000785f69736d   msi_x...
0xffffffffc1209f48 656c5f6775626564   debug_le
0xffffffffc1209f50 00000000006c6576   vel.....
0xffffffffc1209f58 0000000000000000   ........

.. and the behavior with the proposed patch:

[1]kdb> mds __param_arr_num_vfs
0xffffffffc1077f20 0000000100000003   ........
0xffffffffc1077f28 ffffffffc104707c   |p......
0xffffffffc1077f30 ffffffffb4a4bba0 param_ops_byte  
0xffffffffc1077f38 ffffffffc1047080   .p......
0xffffffffc1077f40 000000785f69736d   msi_x...
0xffffffffc1077f48 656c5f6775626564   debug_le
0xffffffffc1077f50 00000000006c6576   vel.....
0xffffffffc1077f58 0000000000000000   ........

-- 
Thanks,
Petr
