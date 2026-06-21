Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D23C07A;
	Sun, 21 Jun 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782052597; cv=none; b=PIbD5KOI3UOpcBZ8Tu86px4fK0JpiZF3/0Z5Dv+KICQF+s0ShZX7Gzxk+uovBsbowixTkQDY7N0/YFqchbhGd4yj9zd6iRrYEvMTYb3aWCxqm7ueKmC9ArGkuH6PstpLFhaoUXl+J0BesAizCg49MlWGpcV6Kynnr2H3IS4JpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782052597; c=relaxed/simple;
	bh=xJ2ebWVRvG1hb1+4o+mytX6T6w1AcG5tyFQQyiFv2YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClPZ1Aup9+RosIMRbIAchW6kJrNoqOFa+n3sPGk/oHOolbgGPj5of6KbZHsJa+kcjjN3EaDXoO6qFkh2uDvopVBlOPScjx/xxEdQ39jrIPPfPDqLgtL9q9/4ne5ZukIyb/r+Gu9kyxT9eYTp1ZdfKqlRDSljpr/3wcQlVoQ+3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dz2egSQy; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dz2egSQy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782052587; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=giyWaz2rbcgHxviVzOBaO9+sHfE30gVkb6c05dSu02Y=;
	b=Dz2egSQy0279DrUckFNjW8YeEvZU5VqNodLOiuavBk6AP85rQaJY/4oJa88UZ4kX548lMCYhdZUPp5jrrNahxtxDS4NRQez+C+qes01SolEYJZG8J9Wx03pRFOtjWNqOcHs/FYzDJeML3bJycC1V1/8SQJWsffFrmUAhIklN8Pk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X5FNjQ1_1782052585;
Received: from 30.180.85.62(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0X5FNjQ1_1782052585 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 21 Jun 2026 22:36:26 +0800
Message-ID: <ccfed9b6-9a73-4299-b305-da7b593a52fd@linux.alibaba.com>
Date: Sun, 21 Jun 2026 22:36:24 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: livepatch: unset sub_make_done in case top
 level Makefile be overwritten
To: Miroslav Benes <mbenes@suse.cz>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org, mpdesouza@suse.com
References: <20260525083721.27857-1-zelin.deng@linux.alibaba.com>
 <alpine.LSU.2.21.2606191638540.26638@pobox.suse.cz>
From: Zelin Deng <zelin.deng@linux.alibaba.com>
In-Reply-To: <alpine.LSU.2.21.2606191638540.26638@pobox.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/6/19 22:42, Miroslav Benes 写道:
> On Mon, 25 May 2026, Zelin Deng wrote:
>
>> After I did: make kselftest-all in top level of kernel source tree, top
>> level Makefile was overwritten by auto generated contents by
>> filechk_makefile:
>> [root@emr: /home/shiyu.dzl/linux-next]$ cat Makefile
>> export KBUILD_OUTPUT = .
>> export KBUILD_EXTMOD = /home/shiyu.dzl/linux-next
>> export KBUILD_EXTMOD_OUTPUT = /home/shiyu.dzl/linux-next
>> include /home/shiyu.dzl/linux-next/Makefile
>>
>> Top-level Makefile export sub_make_done=1, leaks into unrelated re-invocations
>> of the top-level Makefile when recursive descent through selftests -
>> building test_module of livepatch. That causes KBUILD_EXTMOD setup to be
>> skipped, which leads to a relative/absolute path mismatch in srcroot vs
>> CURDIR, falsely setting building_out_of_srctree, and ultimately overwriting
>> the source tree's Makefile with a generated stub.
>>
>> Clear sub_make_done before re-invoking the kernel Makefile.
>>
>> Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
>> Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> Adding Marcos and KLP ML.
>
> I cannot reproduce and I do not understand it much from the changelog (I
> am by far not a Kbuild expert). Could you share the exact steps to
> reproduce please? If I just run 'make kselftest-all' in the top level, it
> passes and livepatch test_modules are not even touched.
>
> Miroslav

Thank you for replying.

Per my understanding, to build livepatch test_modules KDIR must be 
either set explicitly when doing 'make kselftest-all 
KDIR=<path-to-kernel-build-dir>' or have the kernel devel package 
installed. Otherwise the compilation could be skipped. (see 
tools/testing/selftests/livepatch/test_modules/Makefile)

KDIR ?= /lib/modules/$(shell uname -r)/build

...

# Ensure that KDIR exists, otherwise skip the compilation
modules:
ifneq ("$(wildcard $(KDIR))", "")
     $(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
endif

...

Here're how I reproduce the issue:

1. pull linux-next, reset to HEAD, for example 
3ce97bd3c4f18608335e709c24d6a40e7036cab8 (tag next-20260619)

2. at linux-next tree: make all -j$(nproc) && make modules_install 
headers_install -j$(nproc) && make install && reboot

3. at linux-next tree: make kselftest-all

4. top level Makefile in linux-next has been overwritten by

     export KBUILD_OUTPUT = .
     export KBUILD_EXTMOD = /home/shiyu.dzl/linux-next
     export KBUILD_EXTMOD_OUTPUT = /home/shiyu.dzl/linux-next
     include /home/shiyu.dzl/linux-next/Makefile

it is a stub generated by filechk_makefile.


I'm not quite sure that it could be related to my toolchain (like make 
version ?), I briefed analysis the root cause on my environment (KDIR 
'/lib/modules/7.1.0-next-20260619/build' which actually a symbol link to 
my kernel source -> '/home/shiyu.dzl/linux-next'):

   1. sub_make_done leaks via environment. The top-level Makefile sets 
export sub_make_done := 1 after its first-pass initialization.
   Because it is exported, every child make process inherits it.
   2. livepatch test_modules re-invokes the top-level Makefile. The call 
chain is: top-level Makefile → kselftest-% pattern rule →
   tools/testing/selftests/ → livepatch test_modules/Makefile → $(MAKE) 
-C $(KDIR) modules KBUILD_EXTMOD=..., which re-enters the top-level 
Makefile to
   build an external module.
   3. The inherited sub_make_done=1 skips critical initialization. The 
top-level Makefile's first-pass block (ifneq ($(sub_make_done),1)) is
   skipped entirely. This block is responsible for correctly parsing 
command-line variables and setting up KBUILD_EXTMOD-related paths.
   4. Path mismatch triggers false out-of-tree detection. With the 
initialization skipped, srcroot and CURDIR end up with mismatched values 
(e.g.,
   absolute vs. relative). The comparison (ifeq ($(srcroot),$(CURDIR))) 
fails, so building_out_of_srctree is incorrectly set to 1.
   5. outputmakefile overwrites the source tree's Makefile. Because 
building_out_of_srctree is set, the filechk_makefile rule fires and 
replaces the
   real top-level Makefile with a generated stub containing 
KBUILD_OUTPUT, KBUILD_EXTMOD, and an include directive.

   Why make -C tools/testing/selftests/ all is unaffected: it enters the 
selftests directory directly without ever executing the top-level Makefile
   first, so sub_make_done is never exported into the environment. When 
livepatch test_modules later invokes $(MAKE) -C $(KDIR), the top-level 
Makefile
   runs its full initialization normally.

Thanks,

Zelin

