Received: from relay0-f.mailbaby.net (relay0-f.mailbaby.net [64.20.38.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606D409292
	for <live-patching@vger.kernel.org>; Thu,  9 Jul 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.20.38.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593678; cv=none; b=Ts7FX0PufZrhNKdKMG9rJE5XWWCEqqCU+tsdtlaaj88rjaqKtzY7Zk3D1UJ3fKpAvADUBSBzL/d3jw4mGN599Ys9wcSaneqkoyw6PA8SCBTD94bKGrbPehJlfnpVYmkWB+MxOtX7tinirr7W+P33e8krlp6cEQHGRw3vprQ78/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593678; c=relaxed/simple;
	bh=iuAO6jQC/WaLwuwhK4aKZNz2WyCpzvuBAKK6bIbE/4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzyInWDBV9TSYRdnGXQJptKg0vZI2WovwCP3cV7j93DyUFVGwq7SDzKiIIxqolCaA5R+St/LDlBY94aF+7F4WrdmG9FJW8lHKi6vCLiWpnrtpt0NbnGrpd4EVk+vgPA+7isEJ5al6pfd2EMhGTzxCqWf/ZYoYZWHgtYXsgq1K7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=IuxhFKoW; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=yeD7fQEl; arc=none smtp.client-ip=64.20.38.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="IuxhFKoW";
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="yeD7fQEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=NUpjc7mbFVFhqclUPg6iTZmmEYmJNrqVwy0B2j1MH1E=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references:feedback-id;
 b=IuxhFKoW8kvoNBJeFcvTkzvjvcF1f3G2cne0Gc1R5pHu2dDA23gwsRD7iftJiTFXfmeA+LLxe
 TepVNW0xCWNEvyxunVRrY4FBMUfjFz1e8qPl+mcOkKiq6Nyb+NbbG+ZD11TemJDDZmkteXcTrxf
 HFvUJ7p1Bgye/47zaPBbItE=
Received: from mb-nj-kvm1.internal (mb-nj-kvm1.internal [10.10.2.10])
  (Authenticated sender: mb86144)
 by relay0-f.mailbaby.net (MailBabyMTA) with ESMTPSA id 19f4672993100033e5.002
 for <live-patching@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 09 Jul 2026 10:35:43 +0000
X-Zone-Loop: 6faa75e897e1246aad2a74640f4256249572eaa394e7
X-MB-ID: mb86144
X-SPF: pass
Feedback-ID: mb86144:19f467:587f4d465843594778405947455d:mbaby
X-NS-SCAN: PASS
X-MAILBABY-ORIGIN: PASS
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 26B2620097;
	Thu,  9 Jul 2026 10:35:34 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id E4D643E912;
	Thu,  9 Jul 2026 10:35:25 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id A6D57400CB;
	Thu,  9 Jul 2026 10:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1783593325; bh=iuAO6jQC/WaLwuwhK4aKZNz2WyCpzvuBAKK6bIbE/4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yeD7fQElFTFHB0boJ14yXTUsVSXCSpjb0D7Ewq74dmWkHPKsI9+EHAkW++36gkuiS
	 CVyz6jP6Um/ti5ufdjqU+mcb2AZCEQUI8pEwptroQaZ8bdu+MvAEI2ErNA/KvPILNP
	 EkcLIBVcJdXMz8Y3gULLHjhBHUDMeoKkXZKU7pwk=
Received: from [10.128.231.248] (unknown [114.244.129.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3879943A7F;
	Thu,  9 Jul 2026 10:35:18 +0000 (UTC)
Message-ID: <f8cdf51f-82f1-4dfc-a9b4-c2c372255bbd@aosc.io>
Date: Thu, 9 Jul 2026 18:35:15 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] LoongArch: Add livepatch build (KLP) support
To: Huacai Chen <chenhuacai@kernel.org>, George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, peterz@infradead.org, jikos@kernel.org,
 mbenes@suse.cz, pmladek@suse.com, kernel@xen0n.name,
 joe.lawrence@redhat.com, rostedt@goodmis.org, ardb@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, yangtiezhu@loongson.cn,
 jiaxun.yang@flygoat.com, liukexin@kylinos.cn, guodongtai@kylinos.cn,
 xry111@xry111.site, loongarch@lists.linux.dev,
 live-patching@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
 <CAAhV-H4cr9xBkM-SEUHXm9t0yQ=r3B9pkNdmUDftP00hvVsZrQ@mail.gmail.com>
Content-Language: en-US
From: WangYuli <wangyuli@aosc.io>
In-Reply-To: <CAAhV-H4cr9xBkM-SEUHXm9t0yQ=r3B9pkNdmUDftP00hvVsZrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.20 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	MIME_GOOD(-0.10)[text/plain];
	R_SPF_ALLOW(-0.10)[+mx];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TAGGED_RCPT(0.00)[lkml];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,suse.cz,suse.com,xen0n.name,redhat.com,goodmis.org,gmail.com,loongson.cn,flygoat.com,kylinos.cn,xry111.site,lists.linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Queue-Id: A6D57400CB
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action

Hi Huacai,

Thanks a lot for pointing this out!

Actually, I haven't stopped working on this patch series; rather, I've
been continuously refining it. During the process of perfecting this
feature, I realized that making it fully robust is no small feat. As a
result, I have been iteratively polishing it in my own local tree. You
can find my current progress here [1].

I did notice that Dongtai went ahead and sent out a version of this series.
However, as pointed out by other reviewers, that patchset still has some
issues—which is quite understandable given the complexity.

Out of caution, and since I personally feel this feature is not extremely
urgent for the LoongArch architecture, I previously chose not to send a
"half-baked" version to the mailing list. Livepatching (KLP) involves
far too many corner cases. That is also why I remained quiet while Dongtai
was iterating on his version.

Furthermore, to avoid any unnecessary conflicts, I have just updated my
patchset [1] to attribute the overlapping parts to Dongtai (setting him
as the author), while keeping my original commit titles and messages.

I believe we can slow down the pace a bit and give everyone enough room
to get things right the first time, which is much better than rushing it.

Lastly, my apologies for not keeping everyone updated on my work earlier.

Thanks,
WangYuli

[1]: https://github.com/Avenger-285714/wyl-linux-dev/pull/4


On 2026/7/9 17:43, Huacai Chen wrote:
> Hi,George,
>
> On Tue, Jul 7, 2026 at 3:21 PM George Guo <dongtai.guo@linux.dev> wrote:
>> This series adds LoongArch support for the klp-build livepatch tooling,
>> enabling automated livepatch module generation using objtool on
>> LoongArch.
>>
>> It is based on Josh Poimboeuf's klp-build series [1] (see base-commit
>> below, unchanged from v1/v2) and extends it with the LoongArch-specific
>> objtool and build pieces, plus toolchain/relocation fixes required to
>> make livepatch modules load, generate, and run correctly under both GCC
>> and Clang.
> 1. Wang Yuli released his version first; re-releasing it without any
> prior communication is simply rude.
> https://lore.kernel.org/loongarch/20251203091039.125259-1-wangyuli@aosc.io/
>
> 2. Perhaps you were genuinely unaware about his earlier patches, but
> Wang Yuli had already alerted you in your v1. At that point, you had
> two options: a) abandon your own patches and let Wang Yuli continue
> his development, or b) thank Wang Yuli for the reminder and
> assistance, then seek to collaborate on development. However, you did
> neither; instead, you released new versions on your own again and
> again. This is highly unethical.
>
> 3. You might argue that Wang Yuli’s version is incomplete, but is
> yours complete? Since you’re releasing v3, it’s clear that  your v1
> and v2 were also incomplete. If you can simply take over someone
> else’s project just because their version is incomplete, does that
> mean Wang Yuli can now throw yours in the trash when he releases his
> v2?
>
>
> Huacai
>
>> Overview:
>>
>>   - Patches 1-8 are unchanged from v2 [3]: the LoongArch objtool hooks,
>>     special-section marking, the -fPIC/-mdirect-extern-access fixes,
>>     EFI linking, KLP_SYSCALL_DEFINEx() support, and finally wiring up
>>     LoongArch klp-build (kept last so the series stays bisectable).
>>   - Patches 9-12 are new in v3, fixing issues Joe Lawrence found across
>>     two rounds of review by actually running the full klp-build flow
>>     (see Changes since v2 below for details).
>>
>> All new patches (9-12) fix bugs in objtool/klp-diff.c and the LoongArch
>> Kconfig; none of them touch other architectures.
>>
>> Testing:
>>
>> GCC on LoongArch hardware: livepatch modules generated, loaded, and
>> exercised (unchanged from v2).
>>
>> Clang 21.1.8 on LoongArch hardware, reproduced end to end with Joe's
>> exact test case (test-joe.patch below), since it happens to exercise
>> patches 10-12 together: netif_rx_internal() has __ex_table entries,
>> a __bug_table entry, and three __jump_table static keys, one of which
>> (a tracepoint's key) is unexported and not defined in the same
>> translation unit -- exactly the case patch 12 fixes.
>>
>>    $ cat test-joe.patch
>>    diff --git a/net/core/dev.c b/net/core/dev.c
>>    index 06c195906231..14fd3d5f351a 100644
>>    --- a/net/core/dev.c
>>    +++ b/net/core/dev.c
>>    @@ -5717,6 +5717,7 @@ static int netif_rx_internal(struct sk_buff *skb)
>>                    unsigned int qtail;
>>
>>                    ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);
>>    +               pr_info("test");
>>            }
>>            return ret;
>>     }
>>
>>    $ LLVM=/path/to/clang-21/bin/ ./scripts/livepatch/klp-build -T test-joe.patch
>>    ...
>>    $ ls livepatch-test-joe.ko
>>
>> klp-build completes cleanly: no "duplicate reloc" (patch 12), no
>> "Cannot find symbol for section" (patch 9), and the __ex_table/
>> __jump_table entries for netif_rx_internal are present in the output
>> module (patches 10-11).  The module was then loaded into a VM running
>> a matching Clang-built kernel:
>>
>>    # insmod livepatch-test-joe.ko
>>    [  105.584252] livepatch: enabling patch 'livepatch_test_joe'
>>    [  105.586141] livepatch: 'livepatch_test_joe': starting patching transition
>>    [  106.824310] livepatch: 'livepatch_test_joe': patching complete
>>    [  120.036530] test
>>
>>    # cat /sys/kernel/livepatch/livepatch_test_joe/{enabled,transition}
>>    1
>>    0
>>
>> Toggling the netif_rx tracepoint exercises the jump-table relocation
>> patch 12 folds for the unexported __tracepoint_netif_rx key, and lets
>> us cross-check the patch's own pr_info() against independent evidence
>> that the static branch actually flipped:
>>
>>    # echo 1 > /sys/kernel/debug/tracing/events/net/netif_rx/enable
>>    # ping -c2 127.0.0.1
>>    # cat /sys/kernel/debug/tracing/trace | tail -4
>>                ping-1267    [001] b....   472.753651: netif_rx: dev=lo skbaddr=... len=84
>>                ping-1267    [001] b.s2.   472.753671: netif_rx: dev=lo skbaddr=... len=84
>>                ping-1267    [001] b....   473.762993: netif_rx: dev=lo skbaddr=... len=84
>>                ping-1267    [001] b.s2.   473.763096: netif_rx: dev=lo skbaddr=... len=84
>>    # dmesg | tail -4
>>    [  472.753653] test
>>    [  472.753671] test
>>    [  473.762994] test
>>    [  473.763096] test
>>
>> Each traced packet has a matching "test" line at the same timestamp
>> (microsecond-aligned), confirming the tracepoint's static-key
>> relocation and the patch's own code path are both live at once.
>> Disabling and unloading works cleanly:
>>
>>    # echo 0 > /sys/kernel/livepatch/livepatch_test_joe/enabled
>>    [  557.922932] livepatch: 'livepatch_test_joe': starting unpatching transition
>>    [  558.905248] livepatch: 'livepatch_test_joe': unpatching complete
>>    # rmmod livepatch_test_joe
>>
>> Changes since v2 [3]:
>>   - Patches 1-8 are unchanged.
>>   - New patch 9: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY.
>>     arch/loongarch/Makefile already builds with
>>     -fpatchable-function-entry=2, but nothing selected this, so kbuild
>>     ran a pointless recordmcount pass on every object.  Harmless under
>>     GCC (GAS always emits a section symbol for recordmcount to anchor
>>     on), but it fails under Clang with -ffunction-sections (as klp-build
>>     uses) for any __weak function that ends up alone in its section,
>>     e.g. sched_clock.  (Joe Lawrence)
>>   - New patch 10: convert local-label references in special sections.
>>     GCC/GAS on LoongArch reference __ex_table/__bug_table/__jump_table
>>     entries via a local text label instead of the usual "section symbol
>>     + offset" that objtool's klp-diff.c assumes; the label is never
>>     cloned into the livepatch module, so such entries were silently
>>     dropped from GCC-built modules with no error at build or load time.
>>     (Joe Lawrence)
>>   - New patch 11: fix ANNOTATE_DATA_SPECIAL parsing for the same local
>>     label references.  create_fake_symbols() computed each annotated
>>     entry's offset from the relocation's addend alone, which is only
>>     correct for the section-symbol form; with local labels, every entry
>>     in a special section got offset 0, producing a single fake symbol
>>     that covered (and pulled into the output module) the section's
>>     entire contents instead of just the patched function's entries.
>>     Found while verifying patch 10 with a real special-section entry.
>>   - New patch 12: fold LoongArch's paired ADD/SUB relocations into a
>>     single PC-relative one.  The "key - ." field of a __jump_table entry
>>     can come out as two relocations at the same offset (R_LARCH_ADD64 +
>>     R_LARCH_SUB64) when Clang's integrated assembler encounters a key
>>     that isn't defined in the same translation unit (e.g. a tracepoint's
>>     static key); objtool only allows one relocation per offset, so
>>     cloning such an entry failed with "duplicate reloc".  (Joe Lawrence)
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=klp-build-arm64
>> [2] https://lore.kernel.org/all/20260604065317.219777-1-dongtai.guo@linux.dev/
>> [3] https://lore.kernel.org/all/20260608100852.325413-1-dongtai.guo@linux.dev/
>>
>> George Guo (12):
>>    objtool/LoongArch: Add arch_adjusted_addend() for KLP support
>>    LoongArch: Mark special sections for KLP support
>>    livepatch/klp-build: disable direct-extern-access for LoongArch to fix
>>      kernel panic
>>    livepatch/klp-build: build LoongArch with -fPIC to keep GOT-indirect
>>      symbol references
>>    LoongArch: Fix EFI linking with -fdata-sections
>>    objtool/klp: Add LoongArch jump opcode bytes support
>>    klp-build: Add LoongArch syscall patching macro
>>    LoongArch: Add livepatch build (KLP) support
>>    LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>>    objtool/klp: Convert local label references in special sections
>>    objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label
>>      references
>>    objtool/klp: Fold LoongArch paired ADD/SUB relocations into PCREL
>>
>>   arch/loongarch/Kconfig                        |   2 +
>>   arch/loongarch/include/asm/alternative-asm.h  |   5 +-
>>   arch/loongarch/include/asm/alternative.h      |   6 +-
>>   arch/loongarch/include/asm/asm-extable.h      |  10 +-
>>   arch/loongarch/include/asm/bug.h              |   1 +
>>   arch/loongarch/include/asm/jump_label.h       |   2 +
>>   arch/loongarch/kernel/asm-offsets.c           |  20 ++++
>>   arch/loongarch/kernel/vmlinux.lds.S           |   2 +-
>>   include/linux/livepatch_helpers.h             |  22 ++++
>>   scripts/livepatch/klp-build                   |  36 +++++-
>>   tools/objtool/Makefile                        |   3 +-
>>   tools/objtool/arch/loongarch/decode.c         | 108 ++++++++++++++++++
>>   .../objtool/arch/loongarch/include/arch/elf.h |  18 +++
>>   tools/objtool/klp-diff.c                      |  57 ++++++++-
>>   14 files changed, 280 insertions(+), 12 deletions(-)
>>
>>
>> base-commit: 85afaba140a4b9f20fe8c8a64b24fc85f022d981
>> --
>> 2.25.1
>>
>>
