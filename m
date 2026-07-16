Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01040D574;
	Thu, 16 Jul 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199865; cv=none; b=S1zdO2GgI6ob40fedmMmjHjrhl5QMo+YXetIvkddbfvyQJsXaOzPADQs34iwwIM4USKLTlAhj2dwXMtIunPxGNcmnG2gkXrD1bddO+YptcCN0iQTcoEhriIg69qshznS5YzjKW05XqZd1k0w5jUwk+gE2dJK0vkvX4EyqLUHf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199865; c=relaxed/simple;
	bh=0uhB6JZero0uFe53Xe1vmqN69XtR1JjLnJXmSH8Qg+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itPowcVffEPx+hpoHgiI//AGW6XFJj48h8dHT4KNrTrYVSR4MJFKyeX7BFFV0+VyRPnONE9c46yKhNd9xUzp8p97Phkk+HfnwP67rfl/41A64yHsM5lNKJ1OufdhZo2uS2KJub2GFbBNCTHn1LqfvGzhBvm2IZVRoIQ2zEMAwgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iO8lCc5K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iO8lCc5K"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GABoGo2922347;
	Thu, 16 Jul 2026 11:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=syG8oa
	0x17nOPzOhAPL//LIrS2zYKzGiZTlOE/eHYXM=; b=iO8lCc5KOGv6IQ/8Ugep8B
	voJ6Zw7qHlVqH/9U/r+HYXnrSoSttG4G39iLXxLMtEtzIg8tf6mCJ1W90kQshFoJ
	G2AvBIWb/GrLj1+7du4ScYnvQ6tCi5Sq9OhzmfNyXXjgdJ5l8dkQLVxB337OJUW9
	85reHVwg6j8vitZiiUleAHthWJ3VmKylt/rH5FGQVoaW+cfUGmKlDF4VRbJMKrx8
	czbEjpRrW1JiEhVByTRF1Vb0lsMv6+V/hESvmp9OyipnjkPSpEYNB9I9Rux4dMss
	GagLbW7a8d1xHpXI2MAelNcrrLF1Bgww8gYHJlA9og58px4gvnbtyZvMNpu/30fA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtgeyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 11:03:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GAnbBm008794;
	Thu, 16 Jul 2026 11:03:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k4mj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 11:03:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GB3bKh28311832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 11:03:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E560520040;
	Thu, 16 Jul 2026 11:03:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA6EB2004D;
	Thu, 16 Jul 2026 11:03:35 +0000 (GMT)
Received: from [9.111.199.119] (unknown [9.111.199.119])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 11:03:35 +0000 (GMT)
Message-ID: <f2be839a-07c0-4884-9cc2-afd37d025f9e@linux.ibm.com>
Date: Thu, 16 Jul 2026 13:03:35 +0200
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] unwind, arm64: add sframe unwinder for kernel
To: Brian Norris <briannorris@chromium.org>
Cc: Indu Bhagat <ibhagatgnu@gmail.com>, Dylan Hatch <dylanbhatch@google.com>,
        Mostafa Saleh <smostafa@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Weinan Liu <wnliu@google.com>, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
        Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>,
        joe.lawrence@redhat.com, linux-toolchains@vger.kernel.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20260428183643.3796063-1-dylanbhatch@google.com>
 <agcEMEl-QR0g6DgF@google.com>
 <CADBMgpx38SUUuYYCm612STqh01jqv817WnJeeXYTD7Uc1r-fug@mail.gmail.com>
 <4f429a50-df5d-411f-b40e-048d3cad5133@linux.ibm.com>
 <alWCuAA7r1otvROg@google.com>
 <6e0d0afc-8a54-4763-b25d-dea122c4cd12@linux.ibm.com>
 <alezZ6tDIXSBY-v9@google.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <alezZ6tDIXSBY-v9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mFkmib2Ynx93WG7rAAmlrwW2hd8ZdZl4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDExMCBTYWx0ZWRfX83BHsh1GG+56
 8OZoWigMbqVR3uPmbViFeQ1rl2lk/Ds7DO8beZGZTqXOCrvrNYwcgOEbXFIIHbfkuiTYj+LEVJ8
 rb6cTX3/YDdAIpiyDfxlYP1GL5qPOzI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDExMCBTYWx0ZWRfX+vKwh9j9eQoi
 LZ4gF8hf1y4dXzYUlsP7WyBnFLNKokxeFonhdL5oZdEsEbJnB+aCRb2qt22knTyZSBu/iXXLWVO
 kyFVFrU0btlrMvOCzGvqkC9H57gZBiCYMxteoxsr3LhKgX5OXDWvwj31voIot++SbQunXvtYick
 JGgll6skfVrYadgMdsc5SmEAWhZJjQuf5JMUb5LsYh82O5QN/BiChVyBewtxeNKh5vkXCQz42Jf
 IWYBgb7xblsCKxG4c+kNFfPfWGUIdFskr6YhrlKcsRnTmfFH6vgMD1lCZYUHd27To5dD46wUeif
 o4Ho49gtvJnHCw4KNdJ5ZHTssiCfCk/FHXBIRQ80Q6U5lmPMqHjHMt6CgxvZAcrDtF7p3hjIQNk
 x1KrTcYqLWdfwoWv28oo+W1/xh8PSZdiFSoSMG3DOPkZvxtKve4QkbscFHXrtTEJUd1O5Fbbd2J
 ZFWKSzYYx7RZJ5L75uw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a58ba8f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=fdNkcG8_l0O0GnhJFeUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 55k7zW-ZyjeVhp1hJTXAIJ3fALSceZoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160110

On 7/15/2026 6:20 PM, Brian Norris wrote:
> Thanks for looking! Lots more output below. Feel free to ask for more
> info you tink could help.`
>=20
> On Wed, Jul 15, 2026 at 10:06:20AM +0200, Jens Remus wrote:
>> On 7/14/2026 2:28 AM, Brian Norris wrote:
>>> On Tue, May 19, 2026 at 01:05:23PM +0200, Jens Remus wrote:
>>
>>> I also work at the same company as Dylan and Mostafa, and am therefor=
e
>>> probably using the same company-maintained Linux distribution.
>>>
>>>> On 5/18/2026 7:55 PM, Dylan Hatch wrote:
>>>>> On Fri, May 15, 2026 at 4:32=E2=80=AFAM Mostafa Saleh <smostafa@goo=
gle.com> wrote:
>>>>>> Not sure if related, but after updating my toolchain
>>>>>> (aarch64-linux-gnu-gcc (Debian 15.2.0-4) 15.2.0), I hit link error=
s:
>>>>>> ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.sframe) is=
 being placed in '.sframe'
>>>>>> ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.sframe) is be=
ing placed in '.sframe`
>>
>> My understanding of above message is that the linker complains that th=
e
>> input object (e.g. vgettimeofday.o) has an .sframe section for which
>> the linker script does not have any rule, so that it defaults to place=

>> it in .sframe in the output, which could not be the desired result.
>=20
> Not sure if it's obvious to you, but I also found a few more details:
>=20
> * This is most noticeable with CONFIG_WERROR=3Dy, which turns the linke=
r
>   warning into an error.
>=20
> * It appears both with LD=3Dld.lld and with the default (bfd linker). b=
fd
>   shows:
>=20
> /usr/bin/aarch64-linux-gnu-ld.bfd: error: unplaced orphan section `.sfr=
ame' from `arch/arm64/kernel/vdso/vgettimeofday.o'
> /usr/bin/aarch64-linux-gnu-ld.bfd: error: unplaced orphan section `.sfr=
ame' from `arch/arm64/kernel/vdso/vgetrandom.o'
>=20
>=20
> Otherwise, I don't have to do much special to hit this. Just
> cross-compile ARCH=3Darm64 defconfig.
>=20
>>> I've also been hitting this for some time, and I'd like to see if I c=
an
>>> figure out what's going wrong. My current workaround is:
>>>
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -946,6 +946,8 @@ ifdef CONFIG_CC_IS_GCC
>>>  KBUILD_CFLAGS	+=3D $(call cc-option,--param=3Dallow-store-data-races=
=3D0)
>>>  KBUILD_CFLAGS	+=3D $(call cc-option,-fno-allow-store-data-races)
>>>  endif
>>> +# No sframe generation for kernel if enabled by default
>>> +KBUILD_CFLAGS	+=3D $(call cc-option,-Xassembler --gsframe=3Dno)
>>> =20
>>>  ifdef CONFIG_READABLE_ASM
>>>  # Disable optimizations that make assembler listings hard to read.
>>>
>>>>> Previously when developing against the SFrame V2 format, I had fixe=
d
>>>>> these warnings with the VDSO Makefile change currently in this seri=
es:
>>>>>
>>>>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vd=
so/Makefile
>>>>> index 7dec05dd33b7..c60ef921956f 100644
>>>>> --- a/arch/arm64/kernel/vdso/Makefile
>>>>> +++ b/arch/arm64/kernel/vdso/Makefile
>>>>> @@ -38,7 +38,7 @@ ccflags-y +=3D -DDISABLE_BRANCH_PROFILING -DBUILD=
_VDSO
>>>>>  CC_FLAGS_REMOVE_VDSO :=3D $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \=

>>>>>                         $(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS)=
 \
>>>>>                         $(GCC_PLUGINS_CFLAGS) \
>>>>> -                       $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>>>>> +                       $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(CC_FLAGS_=
SFRAME) \
>>>>>                         -Wmissing-prototypes -Wmissing-declarations=

>>>>>
>>>>>  CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-t=
ables
>>>>>
>>>>> But the warnings seem to have returned after upgrading my toolchain=
,
>>>>> possibly due to SFrame V3 or some confounding change in GCC. The
>>>>> --gsframe in the assembler should be set to 'no' by default, so
>>>>> perhaps GCC is providing an override --gsframe internally?
>>>>
>>>> Could it be that your build of binutils was configured with
>>>> --enable-default-sframe, so that the GNU assembler defaults to gener=
ate
>>>> .sframe?  AFAIK this configure option was meant for distributors and=

>>>> package maintainers.
>>>>
>>>> You can check as follows whether --gsframe defaults to "no" or "yes"=
:
>>>>
>>>> $ as --help | grep -A1 gsframe
>>>>   --gsframe[=3D{no|yes}]    whether to generate SFrame stack trace i=
nformation
>>>>                           (default: no)
>>>> ...
>>>
>>> $ aarch64-linux-gnu-as --help | grep -A1 gsframe
>>>   --gsframe[=3D{no|yes}]    whether to generate SFrame stack trace in=
formation
>>>                           (default: no)
>>> --
>>>   --gsframe-<N>           generate SFrame version <N> information. 3 =
=3D=3D <N>
>>>   --scfi=3Dexperimental     Synthesize DWARF CFI for hand-written asm=

>>>
>>>> Maybe build the VDSO separately with V=3D1 to see what assembler/com=
piler
>>>> options are effectively used (e.g. for vgettimeofday.o and vgetrando=
m.o
>>>> mentioned in the linker error message above)?
>>>
>>> A slightly tweaked version of my vgetrandom.o build line:
>>>
>>> # CC      arch/arm64/kernel/vdso/vgetrandom.o
>>>   aarch64-linux-gnu-gcc -Wp,-MMD,arch/arm64/kernel/vdso/.vgetrandom.o=
=2Ed -nostdinc -I./arch/arm64/include -I./arch/arm64/include/generated -I=
=2E/include -I./include -I./arch/arm64/include/uapi -I./arch/arm64/includ=
e/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./i=
nclude/linux/compiler-version.h -include ./include/linux/kconfig.h -inclu=
de ./include/linux/compiler_types.h -D__KERNEL__ -mlittle-endian -DCC_USI=
NG_PATCHABLE_FUNCTION_ENTRY -DKASAN_SHADOW_SCALE_SHIFT=3D -Werror -fshort=
-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -std=3Dg=
nu11 -fms-extensions -mgeneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=3D1=
 -Wno-psabi -mabi=3Dlp64 -fno-asynchronous-unwind-tables -fno-unwind-tabl=
es -mbranch-protection=3Dpac-ret -Wa,-march=3Darmv8.5-a -DARM64_ASM_ARCH=3D=
'"armv8.5-a"' -DKASAN_SHADOW_SCALE_SHIFT=3D -fno-delete-null-pointer-chec=
ks -O2 -fno-allow-store-data-races -fstack-protector-strong -fno-omit-fra=
me-pointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=3Dzero -fz=
ero-init-padding-bits=3Dall -fno-stack-clash-protection -fno-inline-funct=
ions-called-once -fmin-function-alignment=3D8 -fstrict-flex-arrays=3D3 -f=
no-strict-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen =
-Wall -Wextra -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Di=
mplicit-int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format=
-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member=
 -Wframe-larger-than=3D2048 -Wno-main -Wno-type-limits -Wno-dangling-poin=
ter -Wvla-larger-than=3D1 -Wno-pointer-sign -Wcast-function-type -Wno-unt=
erminated-string-initialization -Wno-array-bounds -Wno-stringop-overflow =
-Wno-alloc-size-larger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-tim=
e -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -Wenum-c=
onversion -Wunused -Wno-unused-but-set-variable -Wno-unused-const-variabl=
e -Wno-packed-not-aligned -Wno-format-overflow -Wno-format-truncation -Wn=
o-stringop-truncation -Wno-override-init -Wno-missing-field-initializers =
-Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno=
-unused-parameter -g -mstack-protector-guard=3Dsysreg -mstack-protector-g=
uard-reg=3Dsp_el0 -mstack-protector-guard-offset=3D1344 -fno-common -fno-=
builtin -fno-stack-protector -ffixed-x18 -DDISABLE_BRANCH_PROFILING -DBUI=
LD_VDSO -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tables -include ./lib/v=
dso/getrandom.c   -I./arch/arm64/kernel/vdso -Iarch/arm64/kernel/vdso    =
-DKBUILD_MODFILE=3D'"arch/arm64/kernel/vdso/vgetrandom"' -DKBUILD_BASENAM=
E=3D'"vgetrandom"' -DKBUILD_MODNAME=3D'"vgetrandom"' -D__KBUILD_MODNAME=3D=
vgetrandom -c -o arch/arm64/kernel/vdso/vgetrandom.o ./arch/arm64/kernel/=
vdso/vgetrandom.c
>>
>> That command line does not have any --gsframe[-3] (e.g. -Wa,--gsframe)=
=2E
>> I am not aware of any binutils release / repository state where the
>> --gsframe default was broken.
>=20
> FWIW, I'm usually testing on both v7.1 and approx v7.2-rc3, to make sur=
e
> my results are consistent, and it's not already somehow fixed.
>=20
>> @Indu: Do you have any idea what could be going on?
>>
>>> I mostly don't know what I'm looking for w.r.t. gsframe features, but=

>>> I'm willing to poke at my compiler/assembler/build-process.
>>
>> Could it be that your gcc injects --gsframe e.g. via its spec file?
>> Maybe that would show up if you run above command manually and append
>> gcc option -v?
>=20
> I've dumped most of the output below. I see that the 'as' invocation
> includes --gsframe, but I'm not sure why.
>=20
> $ aarch64-linux-gnu-gcc -Wp,-MMD,arch/arm64/kernel/vdso/.vgetrandom.o.d=
 -nostdinc -I./arch/arm64/include -I./arch/arm64/include/generated -I./in=
clude -I./include -I./arch/arm64/include/uapi -I./arch/arm64/include/gene=
rated/uapi -I./include/uapi -I./include/generated/uapi -include ./include=
/linux/compiler-version.h -include ./include/linux/kconfig.h -include ./i=
nclude/linux/compiler_types.h -D__KERNEL__ -mlittle-endian -DKASAN_SHADOW=
_SCALE_SHIFT=3D -Werror -fshort-wchar -funsigned-char -fno-common -fno-PI=
E -fno-strict-aliasing -std=3Dgnu11 -fms-extensions -mgeneral-regs-only -=
DCONFIG_CC_HAS_K_CONSTRAINT=3D1 -Wno-psabi -mabi=3Dlp64 -fno-asynchronous=
-unwind-tables -fno-unwind-tables -mbranch-protection=3Dpac-ret -Wa,-marc=
h=3Darmv8.5-a -DARM64_ASM_ARCH=3D'"armv8.5-a"' -DKASAN_SHADOW_SCALE_SHIFT=
=3D -fno-delete-null-pointer-checks -O2 -fno-allow-store-data-races -fsta=
ck-protector-strong -fno-omit-frame-pointer -fno-optimize-sibling-calls -=
ftrivial-auto-var-init=3Dzero -fzero-init-padding-bits=3Dall -fno-stack-c=
lash-protection -fmin-function-alignment=3D4 -fstrict-flex-arrays=3D3 -fn=
o-strict-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -=
Wall -Wextra -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dim=
plicit-int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-=
security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member =
-Wframe-larger-than=3D2048 -Wno-main -Wno-type-limits -Wno-dangling-point=
er -Wvla-larger-than=3D1 -Wno-pointer-sign -Wcast-function-type -Wno-unte=
rminated-string-initialization -Wno-array-bounds -Wno-stringop-overflow -=
Wno-alloc-size-larger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time=
 -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -Wenum-co=
nversion -Wunused -Wno-unused-but-set-variable -Wno-unused-const-variable=
 -Wno-packed-not-aligned -Wno-format-overflow -Wno-format-truncation -Wno=
-stringop-truncation -Wno-override-init -Wno-missing-field-initializers -=
Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-=
unused-parameter -g -fno-var-tracking -femit-struct-debug-baseonly -mstac=
k-protector-guard=3Dsysreg -mstack-protector-guard-reg=3Dsp_el0 -mstack-p=
rotector-guard-offset=3D1344 -fno-common -fno-builtin -fno-stack-protecto=
r -ffixed-x18 -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO -O2 -mcmodel=3Dtiny=
 -fasynchronous-unwind-tables -include $LINUX/lib/vdso/getrandom.c    -DK=
BUILD_MODFILE=3D'"arch/arm64/kernel/vdso/vgetrandom"' -DKBUILD_BASENAME=3D=
'"vgetrandom"' -DKBUILD_MODNAME=3D'"vgetrandom"' -D__KBUILD_MODNAME=3Dvge=
trandom -c -o arch/arm64/kernel/vdso/vgetrandom.o arch/arm64/kernel/vdso/=
vgetrandom.c  -v
> Using built-in specs.
> COLLECT_AS_OPTIONS=3D'-march=3Darmv8.5-a'
> COLLECT_GCC=3Daarch64-linux-gnu-gcc
> Target: aarch64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion=3D'Debian 15.2.0=
-4' --with-bugurl=3Dfile:///usr/share/doc/gcc-15/README.Bugs --enable-lan=
guages=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2,cobol,algol68 --prefix=3D=
/usr --with-gcc-major-version-only --program-suffix=3D-15 --enable-shared=
 --enable-linker-build-id --libexecdir=3D/usr/libexec --without-included-=
gettext --enable-threads=3Dposix --libdir=3D/usr/lib --enable-nls --with-=
sysroot=3D/ --enable-clocale=3Dgnu --enable-libstdcxx-debug --enable-libs=
tdcxx-time=3Dyes --with-default-libstdcxx-abi=3Dnew --enable-libstdcxx-ba=
cktrace --enable-gnu-unique-object --disable-libquadmath --disable-libqua=
dmath-support --enable-plugin --enable-default-pie --with-system-zlib --e=
nable-libphobos-checking=3Drelease --without-target-system-zlib --enable-=
multiarch --enable-fix-cortex-a53-843419 --disable-werror --enable-checki=
ng=3Drelease --build=3Dx86_64-linux-gnu --host=3Dx86_64-linux-gnu --targe=
t=3Daarch64-linux-gnu --program-prefix=3Daarch64-linux-gnu- --includedir=3D=
/usr/aarch64-linux-gnu/include --with-build-config=3Dbootstrap-lto-lean -=
-enable-link-serialization=3D32
> Thread model: posix
> Supported LTO compression algorithms: zlib zstd
> gcc version 15.2.0 (Debian 15.2.0-4)
> COLLECT_GCC_OPTIONS=3D'-nostdinc' '-I' './arch/arm64/include' '-I' './a=
rch/arm64/include/generated' '-I' './include' '-I' './include' '-I' './ar=
ch/arm64/include/uapi' '-I' './arch/arm64/include/generated/uapi' '-I' '.=
/include/uapi' '-I' './include/generated/uapi' '-include' './include/linu=
x/compiler-version.h' '-include' './include/linux/kconfig.h' '-include' '=
=2E/include/linux/compiler_types.h' '-D' '__KERNEL__' '-mlittle-endian' '=
-D' 'KASAN_SHADOW_SCALE_SHIFT=3D' '-Werror' '-fshort-wchar' '-funsigned-c=
har' '-fno-PIE' '-fno-strict-aliasing' '-std=3Dgnu11' '-fms-extensions' '=
-mgeneral-regs-only' '-D' 'CONFIG_CC_HAS_K_CONSTRAINT=3D1' '-Wno-psabi' '=
-mabi=3Dlp64' '-fno-unwind-tables' '-mbranch-protection=3Dpac-ret' '-D' '=
ARM64_ASM_ARCH=3D"armv8.5-a"' '-D' 'KASAN_SHADOW_SCALE_SHIFT=3D' '-fno-de=
lete-null-pointer-checks' '-O2' '-fno-allow-store-data-races' '-fstack-pr=
otector-strong' '-fno-omit-frame-pointer' '-fno-optimize-sibling-calls' '=
-ftrivial-auto-var-init=3Dzero' '-fzero-init-padding-bits=3Dall' '-fno-st=
ack-clash-protection' '-fmin-function-alignment=3D4' '-fstrict-flex-array=
s=3D3' '-fno-strict-overflow' '-fstack-check=3Dno' '-fconserve-stack' '-f=
no-builtin-wcslen' '-Wall' '-Wextra' '-Wundef' '-Werror=3Dimplicit-functi=
on-declaration' '-Werror=3Dimplicit-int' '-Werror=3Dreturn-type' '-Werror=
=3Dstrict-prototypes' '-Wno-format-security' '-Wno-trigraphs' '-Wno-frame=
-address' '-Wno-address-of-packed-member' '-Wframe-larger-than=3D2048' '-=
Wno-main' '-Wno-type-limits' '-Wdangling-pointer=3D0' '-Wvla-larger-than=3D=
1' '-Wno-pointer-sign' '-Wcast-function-type' '-Wno-unterminated-string-i=
nitialization' '-Warray-bounds=3D0' '-Wstringop-overflow=3D0' '-Walloc-si=
ze-larger-than=3D$XXX' '-Wimplicit-fallthrough=3D5' '-Werror=3Ddate-time'=
 '-Werror=3Dincompatible-pointer-types' '-Werror=3Ddesignated-init' '-Wen=
um-conversion' '-Wunused' '-Wno-unused-but-set-variable' '-Wunused-const-=
variable=3D0' '-Wno-packed-not-aligned' '-Wformat-overflow=3D0' '-Wformat=
-truncation=3D0' '-Wno-stringop-truncation' '-Wno-override-init' '-Wno-mi=
ssing-field-initializers' '-Wno-shift-negative-value' '-Wno-maybe-uniniti=
alized' '-Wno-sign-compare' '-Wno-unused-parameter' '-g' '-fno-var-tracki=
ng' '-femit-struct-debug-baseonly' '-mstack-protector-guard=3Dsysreg' '-m=
stack-protector-guard-reg=3Dsp_el0' '-mstack-protector-guard-offset=3D134=
4' '-fno-common' '-fno-builtin' '-fno-stack-protector' '-ffixed-x18' '-D'=
 'DISABLE_BRANCH_PROFILING' '-D' 'BUILD_VDSO' '-O2' '-mcmodel=3Dtiny' '-f=
asynchronous-unwind-tables' '-include' '$LINUX/lib/vdso/getrandom.c' '-D'=
 'KBUILD_MODFILE=3D"arch/arm64/kernel/vdso/vgetrandom"' '-D' 'KBUILD_BASE=
NAME=3D"vgetrandom"' '-D' 'KBUILD_MODNAME=3D"vgetrandom"' '-D' '__KBUILD_=
MODNAME=3Dvgetrandom' '-c' '-o' 'arch/arm64/kernel/vdso/vgetrandom.o' '-v=
' '-dumpdir' 'arch/arm64/kernel/vdso/'
>  /usr/libexec/gcc-cross/aarch64-linux-gnu/15/cc1 -quiet -nostdinc -v -I=
 ./arch/arm64/include -I ./arch/arm64/include/generated -I ./include -I .=
/include -I ./arch/arm64/include/uapi -I ./arch/arm64/include/generated/u=
api -I ./include/uapi -I ./include/generated/uapi -imultiarch aarch64-lin=
ux-gnu -D __KERNEL__ -D KASAN_SHADOW_SCALE_SHIFT=3D -D CONFIG_CC_HAS_K_CO=
NSTRAINT=3D1 -D ARM64_ASM_ARCH=3D"armv8.5-a" -D KASAN_SHADOW_SCALE_SHIFT=3D=
 -D DISABLE_BRANCH_PROFILING -D BUILD_VDSO -D KBUILD_MODFILE=3D"arch/arm6=
4/kernel/vdso/vgetrandom" -D KBUILD_BASENAME=3D"vgetrandom" -D KBUILD_MOD=
NAME=3D"vgetrandom" -D __KBUILD_MODNAME=3Dvgetrandom -include ./include/l=
inux/compiler-version.h -include ./include/linux/kconfig.h -include ./inc=
lude/linux/compiler_types.h -include /usr/local/google/home/briannorris/g=
it/linux/lib/vdso/getrandom.c -MMD arch/arm64/kernel/vdso/.vgetrandom.o.d=
 arch/arm64/kernel/vdso/vgetrandom.c -quiet -dumpdir arch/arm64/kernel/vd=
so/ -dumpbase vgetrandom.c -dumpbase-ext .c -mlittle-endian -mgeneral-reg=
s-only -mabi=3Dlp64 -mbranch-protection=3Dpac-ret -mstack-protector-guard=
=3Dsysreg -mstack-protector-guard-reg=3Dsp_el0 -mstack-protector-guard-of=
fset=3D1344 -mcmodel=3Dtiny -g -O2 -O2 -Werror -Wno-psabi -Wall -Wextra -=
Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -We=
rror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-security -Wno-=
trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wframe-larger=
-than=3D2048 -Wno-main -Wno-type-limits -Wdangling-pointer=3D0 -Wvla-larg=
er-than=3D1 -Wno-pointer-sign -Wcast-function-type -Wno-unterminated-stri=
ng-initialization -Warray-bounds=3D0 -Wstringop-overflow=3D0 -Walloc-size=
-larger-than=3D18446744073709551615EiB -Wimplicit-fallthrough=3D5 -Werror=
=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-in=
it -Wenum-conversion -Wunused -Wno-unused-but-set-variable -Wunused-const=
-variable=3D0 -Wno-packed-not-aligned -Wformat-overflow=3D0 -Wformat-trun=
cation=3D0 -Wno-stringop-truncation -Wno-override-init -Wno-missing-field=
-initializers -Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sig=
n-compare -Wno-unused-parameter -std=3Dgnu11 -version -fshort-wchar -funs=
igned-char -fno-PIE -fno-strict-aliasing -fms-extensions -fno-unwind-tabl=
es -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-pr=
otector-strong -fno-omit-frame-pointer -fno-optimize-sibling-calls -ftriv=
ial-auto-var-init=3Dzero -fzero-init-padding-bits=3Dall -fno-stack-clash-=
protection -fmin-function-alignment=3D4 -fstrict-flex-arrays=3D3 -fno-str=
ict-overflow -fstack-check=3Dno -fconserve-stack -fno-builtin-wcslen -fno=
-var-tracking -femit-struct-debug-baseonly -fno-common -fno-builtin -fno-=
stack-protector -ffixed-x18 -fasynchronous-unwind-tables -fasynchronous-u=
nwind-tables -o /tmp/cc6nO0fY.s
> GNU C11 (Debian 15.2.0-4) version 15.2.0 (aarch64-linux-gnu)
> 	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.=
2, MPC version 1.3.1, isl version isl-0.27-GMP
>=20
> GGC heuristics: --param ggc-min-expand=3D100 --param ggc-min-heapsize=3D=
131072
> ignoring duplicate directory "./include"
> #include "..." search starts here:
> #include <...> search starts here:
>  ./arch/arm64/include
>  ./arch/arm64/include/generated
>  ./include
>  ./arch/arm64/include/uapi
>  ./arch/arm64/include/generated/uapi
>  ./include/uapi
>  ./include/generated/uapi
> End of search list.
> Compiler executable checksum: 2014541e26adcb350b182f07eff54ec5
> COLLECT_GCC_OPTIONS=3D'-nostdinc' '-I' './arch/arm64/include' '-I' './a=
rch/arm64/include/generated' '-I' './include' '-I' './include' '-I' './ar=
ch/arm64/include/uapi' '-I' './arch/arm64/include/generated/uapi' '-I' '.=
/include/uapi' '-I' './include/generated/uapi' '-include' './include/linu=
x/compiler-version.h' '-include' './include/linux/kconfig.h' '-include' '=
=2E/include/linux/compiler_types.h' '-D' '__KERNEL__' '-mlittle-endian' '=
-D' 'KASAN_SHADOW_SCALE_SHIFT=3D' '-Werror' '-fshort-wchar' '-funsigned-c=
har' '-fno-PIE' '-fno-strict-aliasing' '-std=3Dgnu11' '-fms-extensions' '=
-mgeneral-regs-only' '-D' 'CONFIG_CC_HAS_K_CONSTRAINT=3D1' '-Wno-psabi' '=
-mabi=3Dlp64' '-fno-unwind-tables' '-mbranch-protection=3Dpac-ret' '-D' '=
ARM64_ASM_ARCH=3D"armv8.5-a"' '-D' 'KASAN_SHADOW_SCALE_SHIFT=3D' '-fno-de=
lete-null-pointer-checks' '-O2' '-fno-allow-store-data-races' '-fstack-pr=
otector-strong' '-fno-omit-frame-pointer' '-fno-optimize-sibling-calls' '=
-ftrivial-auto-var-init=3Dzero' '-fzero-init-padding-bits=3Dall' '-fno-st=
ack-clash-protection' '-fmin-function-alignment=3D4' '-fstrict-flex-array=
s=3D3' '-fno-strict-overflow' '-fstack-check=3Dno' '-fconserve-stack' '-f=
no-builtin-wcslen' '-Wall' '-Wextra' '-Wundef' '-Werror=3Dimplicit-functi=
on-declaration' '-Werror=3Dimplicit-int' '-Werror=3Dreturn-type' '-Werror=
=3Dstrict-prototypes' '-Wno-format-security' '-Wno-trigraphs' '-Wno-frame=
-address' '-Wno-address-of-packed-member' '-Wframe-larger-than=3D2048' '-=
Wno-main' '-Wno-type-limits' '-Wdangling-pointer=3D0' '-Wvla-larger-than=3D=
1' '-Wno-pointer-sign' '-Wcast-function-type' '-Wno-unterminated-string-i=
nitialization' '-Warray-bounds=3D0' '-Wstringop-overflow=3D0' '-Walloc-si=
ze-larger-than=3D$XXX' '-Wimplicit-fallthrough=3D5' '-Werror=3Ddate-time'=
 '-Werror=3Dincompatible-pointer-types' '-Werror=3Ddesignated-init' '-Wen=
um-conversion' '-Wunused' '-Wno-unused-but-set-variable' '-Wunused-const-=
variable=3D0' '-Wno-packed-not-aligned' '-Wformat-overflow=3D0' '-Wformat=
-truncation=3D0' '-Wno-stringop-truncation' '-Wno-override-init' '-Wno-mi=
ssing-field-initializers' '-Wno-shift-negative-value' '-Wno-maybe-uniniti=
alized' '-Wno-sign-compare' '-Wno-unused-parameter' '-g' '-fno-var-tracki=
ng' '-femit-struct-debug-baseonly' '-mstack-protector-guard=3Dsysreg' '-m=
stack-protector-guard-reg=3Dsp_el0' '-mstack-protector-guard-offset=3D134=
4' '-fno-common' '-fno-builtin' '-fno-stack-protector' '-ffixed-x18' '-D'=
 'DISABLE_BRANCH_PROFILING' '-D' 'BUILD_VDSO' '-O2' '-mcmodel=3Dtiny' '-f=
asynchronous-unwind-tables' '-include' '/usr/local/google/home/briannorri=
s/git/linux/lib/vdso/getrandom.c' '-D' 'KBUILD_MODFILE=3D"arch/arm64/kern=
el/vdso/vgetrandom"' '-D' 'KBUILD_BASENAME=3D"vgetrandom"' '-D' 'KBUILD_M=
ODNAME=3D"vgetrandom"' '-D' '__KBUILD_MODNAME=3Dvgetrandom' '-c' '-o' 'ar=
ch/arm64/kernel/vdso/vgetrandom.o' '-v' '-dumpdir' 'arch/arm64/kernel/vds=
o/'
>  /usr/lib/gcc-cross/aarch64-linux-gnu/15/../../../../aarch64-linux-gnu/=
bin/as -v -I ./arch/arm64/include -I ./arch/arm64/include/generated -I ./=
include -I ./include -I ./arch/arm64/include/uapi -I ./arch/arm64/include=
/generated/uapi -I ./include/uapi -I ./include/generated/uapi --gsframe -=
-gdwarf-5 -EL -mabi=3Dlp64 -march=3Darmv8.5-a -o arch/arm64/kernel/vdso/v=
getrandom.o /tmp/cc6nO0fY.s
> GNU assembler version 2.46.50 (aarch64-linux-gnu) using BFD version (GN=
U Binutils for Debian) 2.46.50.20260617
> COMPILER_PATH=3D/usr/libexec/gcc-cross/aarch64-linux-gnu/15/:/usr/libex=
ec/gcc-cross/aarch64-linux-gnu/15/:/usr/libexec/gcc-cross/aarch64-linux-g=
nu/:/usr/lib/gcc-cross/aarch64-linux-gnu/15/:/usr/lib/gcc-cross/aarch64-l=
inux-gnu/:/usr/lib/gcc-cross/aarch64-linux-gnu/15/../../../../aarch64-lin=
ux-gnu/bin/
> LIBRARY_PATH=3D/usr/lib/gcc-cross/aarch64-linux-gnu/15/:/usr/lib/gcc-cr=
oss/aarch64-linux-gnu/15/../../../../aarch64-linux-gnu/lib/../lib/:/lib/a=
arch64-linux-gnu/:/lib/../lib/:/usr/lib/aarch64-linux-gnu/:/usr/lib/../li=
b/:/usr/lib/gcc-cross/aarch64-linux-gnu/15/../../../../aarch64-linux-gnu/=
lib/:/lib/:/usr/lib/
> COLLECT_GCC_OPTIONS=3D'-nostdinc' '-I' './arch/arm64/include' '-I' './a=
rch/arm64/include/generated' '-I' './include' '-I' './include' '-I' './ar=
ch/arm64/include/uapi' '-I' './arch/arm64/include/generated/uapi' '-I' '.=
/include/uapi' '-I' './include/generated/uapi' '-include' './include/linu=
x/compiler-version.h' '-include' './include/linux/kconfig.h' '-include' '=
=2E/include/linux/compiler_types.h' '-D' '__KERNEL__' '-mlittle-endian' '=
-D' 'KASAN_SHADOW_SCALE_SHIFT=3D' '-Werror' '-fshort-wchar' '-funsigned-c=
har' '-fno-PIE' '-fno-strict-aliasing' '-std=3Dgnu11' '-fms-extensions' '=
-mgeneral-regs-only' '-D' 'CONFIG_CC_HAS_K_CONSTRAINT=3D1' '-Wno-psabi' '=
-mabi=3Dlp64' '-fno-unwind-tables' '-mbranch-protection=3Dpac-ret' '-D' '=
ARM64_ASM_ARCH=3D"armv8.5-a"' '-D' 'KASAN_SHADOW_SCALE_SHIFT=3D' '-fno-de=
lete-null-pointer-checks' '-O2' '-fno-allow-store-data-races' '-fstack-pr=
otector-strong' '-fno-omit-frame-pointer' '-fno-optimize-sibling-calls' '=
-ftrivial-auto-var-init=3Dzero' '-fzero-init-padding-bits=3Dall' '-fno-st=
ack-clash-protection' '-fmin-function-alignment=3D4' '-fstrict-flex-array=
s=3D3' '-fno-strict-overflow' '-fstack-check=3Dno' '-fconserve-stack' '-f=
no-builtin-wcslen' '-Wall' '-Wextra' '-Wundef' '-Werror=3Dimplicit-functi=
on-declaration' '-Werror=3Dimplicit-int' '-Werror=3Dreturn-type' '-Werror=
=3Dstrict-prototypes' '-Wno-format-security' '-Wno-trigraphs' '-Wno-frame=
-address' '-Wno-address-of-packed-member' '-Wframe-larger-than=3D2048' '-=
Wno-main' '-Wno-type-limits' '-Wdangling-pointer=3D0' '-Wvla-larger-than=3D=
1' '-Wno-pointer-sign' '-Wcast-function-type' '-Wno-unterminated-string-i=
nitialization' '-Warray-bounds=3D0' '-Wstringop-overflow=3D0' '-Walloc-si=
ze-larger-than=3D$XXX' '-Wimplicit-fallthrough=3D5' '-Werror=3Ddate-time'=
 '-Werror=3Dincompatible-pointer-types' '-Werror=3Ddesignated-init' '-Wen=
um-conversion' '-Wunused' '-Wno-unused-but-set-variable' '-Wunused-const-=
variable=3D0' '-Wno-packed-not-aligned' '-Wformat-overflow=3D0' '-Wformat=
-truncation=3D0' '-Wno-stringop-truncation' '-Wno-override-init' '-Wno-mi=
ssing-field-initializers' '-Wno-shift-negative-value' '-Wno-maybe-uniniti=
alized' '-Wno-sign-compare' '-Wno-unused-parameter' '-g' '-fno-var-tracki=
ng' '-femit-struct-debug-baseonly' '-mstack-protector-guard=3Dsysreg' '-m=
stack-protector-guard-reg=3Dsp_el0' '-mstack-protector-guard-offset=3D134=
4' '-fno-common' '-fno-builtin' '-fno-stack-protector' '-ffixed-x18' '-D'=
 'DISABLE_BRANCH_PROFILING' '-D' 'BUILD_VDSO' '-O2' '-mcmodel=3Dtiny' '-f=
asynchronous-unwind-tables' '-include' '/usr/local/google/home/briannorri=
s/git/linux/lib/vdso/getrandom.c' '-D' 'KBUILD_MODFILE=3D"arch/arm64/kern=
el/vdso/vgetrandom"' '-D' 'KBUILD_BASENAME=3D"vgetrandom"' '-D' 'KBUILD_M=
ODNAME=3D"vgetrandom"' '-D' '__KBUILD_MODNAME=3Dvgetrandom' '-c' '-o' 'ar=
ch/arm64/kernel/vdso/vgetrandom.o' '-v' '-dumpdir' 'arch/arm64/kernel/vds=
o/vgetrandom.'

This proves thet assembler option --gsframe did not originate from the
kernel Makefile, but was supplied by GCC for the assembly step.  I guess
it gets injected by some GCC .specs file.  Please review the output of:
for "sframe":

$ aarch64-linux-gnu-gcc -dumpspecs

>> Does the intermediate source or assembler source have any
>> ".cfi_section .sframe" statement?
>>
>> $ make arch/arm64/kernel/vdso/vgetrandom.i
>=20
> This fails to build with WERROR, because it seems to require the linker=

> step that fails, so I have to disable WERROR. Afterward:
>=20
> $ grep -i sframe arch/arm64/kernel/vdso/vgetrandom.i
> // (empty)
>=20
>> $ make arch/arm64/kernel/vdso/vgetrandom.s
>=20
> This fails to build.
>=20
> $ make CROSS_COMPILE=3D'ccache aarch64-linux-gnu-' ARCH=3Darm64 -j80 ar=
ch/arm64/kernel/vdso/vgetrandom.s
>   CC      arch/arm64/kernel/vdso/vgetrandom.s
> arch/arm64/kernel/vdso/vgetrandom.c:5:8: error: =E2=80=98__cvdso_getran=
dom=E2=80=99 undeclared here (not in a function)
>     5 | typeof(__cvdso_getrandom) __kernel_getrandom;
>       |        ^~~~~~~~~~~~~~~~~
> arch/arm64/kernel/vdso/vgetrandom.c:7:1: error: unknown type name =E2=80=
=98ssize_t=E2=80=99
>     7 | ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned i=
nt flags, void *opaque_state, size_t opaque_len)
>       | ^~~~~~~
> arch/arm64/kernel/vdso/vgetrandom.c:7:42: error: unknown type name =E2=80=
=98size_t=E2=80=99
>     7 | ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned i=
nt flags, void *opaque_state, size_t opaque_len)
>       |                                          ^~~~~~
> arch/arm64/kernel/vdso/vgetrandom.c:4:1: note: =E2=80=98size_t=E2=80=99=
 is defined in header =E2=80=98<stddef.h>=E2=80=99; this is probably fixa=
ble by adding =E2=80=98#include <stddef.h>=E2=80=99
>     3 | #include <uapi/asm-generic/errno.h>
>   +++ |+#include <stddef.h>
>     4 |
> arch/arm64/kernel/vdso/vgetrandom.c:7:94: error: unknown type name =E2=80=
=98size_t=E2=80=99
>     7 | ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned i=
nt flags, void *opaque_state, size_t opaque_len)
>       |                                                                =
                              ^~~~~~
> arch/arm64/kernel/vdso/vgetrandom.c:7:94: note: =E2=80=98size_t=E2=80=99=
 is defined in header =E2=80=98<stddef.h>=E2=80=99; this is probably fixa=
ble by adding =E2=80=98#include <stddef.h>=E2=80=99
> make[4]: *** [scripts/Makefile.build:184: arch/arm64/kernel/vdso/vgetra=
ndom.s] Error 1
> make[3]: *** [scripts/Makefile.build:549: arch/arm64/kernel] Error 2
> make[2]: *** [scripts/Makefile.build:549: arch/arm64] Error 2

No idea.

>> Can you please verify that your arch/arm64/kernel/vdso/vgetrandom.o
>> actually contains an .sframe section:
>>
>> $ readelf -WS arch/arm64/kernel/vdso/vgetrandom.o
>=20
> $ readelf -WS arch/arm64/kernel/vdso/vgetrandom.o | grep -i sframe
>   [22] .sframe           GNU_SFRAME      0000000000000000 002438 000083=
 00   A  0   0  8
>   [23] .rela.sframe      RELA            0000000000000000 003988 000018=
 18   I 24  22  8

This proves that there is an .sframe section, which is expected given
that GCC specified --gsframe during assembly.

Regards,
Jens
--=20
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsra=
ts: Wolfgang Wendt; Gesch=C3=A4ftsf=C3=BChrung: David Faller; Sitz der Ge=
sellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

