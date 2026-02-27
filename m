Received: from mail.189.cn (189sx01-ptr.21cn.com [183.56.237.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455123EA92;
	Fri, 27 Feb 2026 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.56.237.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156113; cv=none; b=p8uOFKBmZeTWAT5ZQOz6NJhcRBHntUlTNXmSC5XPWv5CwK/wy2oghuuXDeTThE6dllxpaQMAV50LsF9nqqwLj3UvuqN3aE2Z3dWEvFeESzFixnzFMLkKdcKUpDnTKSePAIRkrhSq3kH52MVSWq3KPbcvXgiYuJjXB/SCra8ujrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156113; c=relaxed/simple;
	bh=ebe4FPBu7q5yzI7imyByKLxHi97cWFTchWVYjuzRTLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhcjFSXeX179cDJXnjnSl0q7mXjIq3Dp0ruj+DeNW03kPjCbuGuViu/R5hohmml3Far0MG80t/MDPcDeH7juCjZnSJFbIFp7w8PE0y429xk1iS71NSFMYQHyW1fTOlZ+g6lQlAtSksIx+LB1kUgSbTQne+41qJ2wsIH5R0Am0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.56.237.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.949806391
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 33D7E400319;
	Fri, 27 Feb 2026 09:34:59 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id e986d7ed2f13484c82d796392a61918b for rostedt@goodmis.org;
	Fri, 27 Feb 2026 09:35:01 CST
X-Transaction-ID: e986d7ed2f13484c82d796392a61918b
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.48
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <321d4670-27cb-453f-a50d-426c83894074@189.cn>
Date: Fri, 27 Feb 2026 09:34:59 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/trace/ftrace: introduce ftrace module notifier
To: Steven Rostedt <rostedt@goodmis.org>, Miroslav Benes <mbenes@suse.cz>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, atomlin@atomlin.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
References: <20260225054639.21637-1-chensong_2000@189.cn>
 <20260225192724.48ed165e@fedora>
 <e18ed5f4-3917-46e7-bca9-78063e6e4457@189.cn>
 <alpine.LSU.2.21.2602261147150.5739@pobox.suse.cz>
 <20260226123014.2197d9b7@gandalf.local.home>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <20260226123014.2197d9b7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2026/2/27 01:30, Steven Rostedt 写道:
> On Thu, 26 Feb 2026 11:51:53 +0100 (CET)
> Miroslav Benes <mbenes@suse.cz> wrote:
> 
>>> Let me see if there is any way to use notifier and remain below calling
>>> sequence:
>>>
>>> ftrace_module_enable
>>> klp_module_coming
>>> blocking_notifier_call_chain_robust(MODULE_STATE_COMING)
>>>
>>> blocking_notifier_call_chain(MODULE_STATE_GOING)
>>> klp_module_going
>>> ftrace_release_mod
>>
>> Both klp and ftrace used module notifiers in the past. We abandoned that
>> and opted for direct calls due to issues with ordering at the time. I do
>> not have the list of problems at hand but I remember it was very fragile.
>>
>> See commits 7dcd182bec27 ("ftrace/module: remove ftrace module
>> notifier"), 7e545d6eca20 ("livepatch/module: remove livepatch module
>> notifier") and their surroundings.
>>
>> So unless there is a reason for the change (which should be then carefully
>> reviewed and properly tested), I would prefer to keep it as is. What is
>> the motivation? I am failing to find it in the commit log.

There is no special motivation, i just read btf initialization in module 
loading and found direct calls of ftrace and klp, i thought they were 
just forgotten to use notifier and i even didn't search git log to 
verify, sorry about that.

> 
> Honestly, I do think just decoupling ftrace and live kernel patching from
> modules is rationale enough, as it makes the code a bit cleaner. But to do
> so, we really need to make sure there is absolutely no regressions.
> 
> Thus, to allow such a change, I would ask those that are proposing it, show
> a full work flow of how ftrace, live kernel patching, and modules work with
> each other and why those functions are currently injected in the module code.
> 
> As Miroslav stated, we tried to do it via notifiers in the past and it
> failed. I don't want to find out why they failed by just adding them back
> to notifiers again. Instead, the reasons must be fully understood and
> updates made to make sure they will not fail in the future.

Yes, you are right, i read commit msg of 7dcd182bec27, this patch just 
reverses it simply and will introduce order issue back. I will try to 
find out the problem in the past at first.

Thank you both.

/Song

> 
> -- Steve
> 
> 

