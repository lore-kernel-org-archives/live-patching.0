Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8152931C4;
	Wed, 15 Jul 2026 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102824; cv=none; b=BIroY/56nyCxevRn/aNlJQH2Mpv3x9J+s+gvjfY/gl6gBub8PajEKCYZFCiF5xls2VzCP8K10RlHkQZNGHsWMedWN0p/7DwyGTG+VVw1rEpU79vDcCrG0FPnz8o92eUAwNyFGZG+IvWTl0b8xBBwh1xKR13mPbokgD1zg/EnkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102824; c=relaxed/simple;
	bh=gGaO6pSTboVJq2ImHWpwqazqQN4eqdgIS/TL5aFStDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv+U12PxT5pm6cnh2WRTjBbA6t/MNx68lpyA436Y6nqwix+iGRWvNS3DOCy/rBOisFzYBIutTOMT5XBjWp/FMySN1RhUBqWh9OLaVVMUA7OjC5lP36xNSt2Yi3mcsWBnr0pUAOV8nJX7s1p4hA7DD1DB9MP9ot5SBuMyxdELFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nkJoiVi9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nkJoiVi9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F4CEux3301893;
	Wed, 15 Jul 2026 08:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yvL7sG
	JmKNG6SEfg8yAMFMk/Xw+FZlpecB/5dIcp8wo=; b=nkJoiVi9CjX6/qMkyY+QZq
	MSMENx7vFpK2EYWd+Lqbe2W/pj/d50mZM3UnHnSyOfS1yNm5FX6yTadWGYgxRzAP
	baVjEGYLYga9oXm+rm18rGRC5ZiiXGyvrLbfU6tDHIx8LhSDjozmwk06c3UIJUKb
	AbnljVTuqT/9kt4izUYLL8YReUxrtMag4GTwYCLCMe7RYvx7IPULQj5VuxPS7Mk/
	yNRiIptyQD+n8R/4sCGg5B7WXJLmfBYWG2mfaViMR03yegWN7f/XwtfGovm+u7XL
	ofKZCqMwtotFx/F/wts/S3ecoKY8zrWiTu0AM2NFGfbaakBZ4drSclui7CoMbPFQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtacx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 08:06:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66F84dZx010270;
	Wed, 15 Jul 2026 08:06:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jxua1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 08:06:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66F86LF028967248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 08:06:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4BCA20067;
	Wed, 15 Jul 2026 08:06:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1846A20043;
	Wed, 15 Jul 2026 08:06:21 +0000 (GMT)
Received: from [9.224.91.136] (unknown [9.224.91.136])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 08:06:20 +0000 (GMT)
Message-ID: <6e0d0afc-8a54-4763-b25d-dea122c4cd12@linux.ibm.com>
Date: Wed, 15 Jul 2026 10:06:20 +0200
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] unwind, arm64: add sframe unwinder for kernel
To: Brian Norris <briannorris@chromium.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
Cc: Dylan Hatch <dylanbhatch@google.com>, Mostafa Saleh
 <smostafa@google.com>,
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <alWCuAA7r1otvROg@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Li_ffEFtPdqZ6AuIRg5cq_kWiQIb06S3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3MyBTYWx0ZWRfX59V8lUsx3lmE
 ICkTk/hkotsyWTXD+8WrDeaJt+RloeGwnSLfac+KEdoi4VmwPJYwLbUfkCbYvKURy4/5MOy68xG
 eB3QDlhCmo3NpDPC6cS0HFs7wGXRQB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3MyBTYWx0ZWRfX7l+JkKl8k+dp
 DrsGpOuQOYjp+D5VlQA2E6Xgz1rNQVnb8N0r61MZugFejJw/8p/IZMTcJcdR9/wCFG3Eg7XarTt
 Yd7wbf7aqGBnpSBxq7c7v8IGj1N2lVoG3jkjrRdFpSwsgbknTnhLKF7gEEBrMP04h5KuzAscQ1i
 nfCE2Ug1l0DGdIvBZkl4CLObO5YMuja1/oNbfpINAVL3yP9mlASIhv2dmYK+GkF14n5iAtTE0Z5
 rK+GR2AZxPtYThNeuxvDXD6QFBBWLubRfwVr2kC58mHWaBcvFhM5+Lk9QcfJ/6exEoxqyiuBTWC
 AFd0E+Mda2HXkK8CnWEU7878MkT1pKqmmLV07ItfO480QG8PFYHGTqM/yqbhyPMUQ6Z0pzAGP8L
 O0QecKAP/3WSHGtietgFgkv4dM/ZaSkSQxOSjE5e5hpydsoKouXM4ImP6NaXvgeMMDT1xd5FVo0
 W5nvFcxHCUvcZcsnUaQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a573f82 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=qJcv4byePZYX52udqPwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4-naH3hLE9ZKFw5cPJC2M2F62Bfm2lYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150073

Hi Brian!

On 7/14/2026 2:28 AM, Brian Norris wrote:
> On Tue, May 19, 2026 at 01:05:23PM +0200, Jens Remus wrote:

> I also work at the same company as Dylan and Mostafa, and am therefore
> probably using the same company-maintained Linux distribution.
>=20
>> On 5/18/2026 7:55 PM, Dylan Hatch wrote:
>>> On Fri, May 15, 2026 at 4:32=E2=80=AFAM Mostafa Saleh <smostafa@googl=
e.com> wrote:
>>>> Not sure if related, but after updating my toolchain
>>>> (aarch64-linux-gnu-gcc (Debian 15.2.0-4) 15.2.0), I hit link errors:=

>>>> ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.sframe) is b=
eing placed in '.sframe'
>>>> ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.sframe) is bein=
g placed in '.sframe`

My understanding of above message is that the linker complains that the
input object (e.g. vgettimeofday.o) has an .sframe section for which
the linker script does not have any rule, so that it defaults to place
it in .sframe in the output, which could not be the desired result.

> I've also been hitting this for some time, and I'd like to see if I can=

> figure out what's going wrong. My current workaround is:
>=20
> --- a/Makefile
> +++ b/Makefile
> @@ -946,6 +946,8 @@ ifdef CONFIG_CC_IS_GCC
>  KBUILD_CFLAGS	+=3D $(call cc-option,--param=3Dallow-store-data-races=3D=
0)
>  KBUILD_CFLAGS	+=3D $(call cc-option,-fno-allow-store-data-races)
>  endif
> +# No sframe generation for kernel if enabled by default
> +KBUILD_CFLAGS	+=3D $(call cc-option,-Xassembler --gsframe=3Dno)
> =20
>  ifdef CONFIG_READABLE_ASM
>  # Disable optimizations that make assembler listings hard to read.
>=20
>>> Previously when developing against the SFrame V2 format, I had fixed
>>> these warnings with the VDSO Makefile change currently in this series=
:
>>>
>>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso=
/Makefile
>>> index 7dec05dd33b7..c60ef921956f 100644
>>> --- a/arch/arm64/kernel/vdso/Makefile
>>> +++ b/arch/arm64/kernel/vdso/Makefile
>>> @@ -38,7 +38,7 @@ ccflags-y +=3D -DDISABLE_BRANCH_PROFILING -DBUILD_V=
DSO
>>>  CC_FLAGS_REMOVE_VDSO :=3D $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>>>                         $(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) \=

>>>                         $(GCC_PLUGINS_CFLAGS) \
>>> -                       $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>>> +                       $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(CC_FLAGS_SF=
RAME) \
>>>                         -Wmissing-prototypes -Wmissing-declarations
>>>
>>>  CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tab=
les
>>>
>>> But the warnings seem to have returned after upgrading my toolchain,
>>> possibly due to SFrame V3 or some confounding change in GCC. The
>>> --gsframe in the assembler should be set to 'no' by default, so
>>> perhaps GCC is providing an override --gsframe internally?
>>
>> Could it be that your build of binutils was configured with
>> --enable-default-sframe, so that the GNU assembler defaults to generat=
e
>> .sframe?  AFAIK this configure option was meant for distributors and
>> package maintainers.
>>
>> You can check as follows whether --gsframe defaults to "no" or "yes":
>>
>> $ as --help | grep -A1 gsframe
>>   --gsframe[=3D{no|yes}]    whether to generate SFrame stack trace inf=
ormation
>>                           (default: no)
>> ...
>=20
> $ aarch64-linux-gnu-as --help | grep -A1 gsframe
>   --gsframe[=3D{no|yes}]    whether to generate SFrame stack trace info=
rmation
>                           (default: no)
> --
>   --gsframe-<N>           generate SFrame version <N> information. 3 =3D=
=3D <N>
>   --scfi=3Dexperimental     Synthesize DWARF CFI for hand-written asm
>=20
>> Maybe build the VDSO separately with V=3D1 to see what assembler/compi=
ler
>> options are effectively used (e.g. for vgettimeofday.o and vgetrandom.=
o
>> mentioned in the linker error message above)?
>=20
> A slightly tweaked version of my vgetrandom.o build line:
>=20
> # CC      arch/arm64/kernel/vdso/vgetrandom.o
>   aarch64-linux-gnu-gcc -Wp,-MMD,arch/arm64/kernel/vdso/.vgetrandom.o.d=
 -nostdinc -I./arch/arm64/include -I./arch/arm64/include/generated -I./in=
clude -I./include -I./arch/arm64/include/uapi -I./arch/arm64/include/gene=
rated/uapi -I./include/uapi -I./include/generated/uapi -include ./include=
/linux/compiler-version.h -include ./include/linux/kconfig.h -include ./i=
nclude/linux/compiler_types.h -D__KERNEL__ -mlittle-endian -DCC_USING_PAT=
CHABLE_FUNCTION_ENTRY -DKASAN_SHADOW_SCALE_SHIFT=3D -Werror -fshort-wchar=
 -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -std=3Dgnu11 -=
fms-extensions -mgeneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=3D1 -Wno-=
psabi -mabi=3Dlp64 -fno-asynchronous-unwind-tables -fno-unwind-tables -mb=
ranch-protection=3Dpac-ret -Wa,-march=3Darmv8.5-a -DARM64_ASM_ARCH=3D'"ar=
mv8.5-a"' -DKASAN_SHADOW_SCALE_SHIFT=3D -fno-delete-null-pointer-checks -=
O2 -fno-allow-store-data-races -fstack-protector-strong -fno-omit-frame-p=
ointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=3Dzero -fzero-=
init-padding-bits=3Dall -fno-stack-clash-protection -fno-inline-functions=
-called-once -fmin-function-alignment=3D8 -fstrict-flex-arrays=3D3 -fno-s=
trict-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wal=
l -Wextra -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimpli=
cit-int -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-sec=
urity -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wf=
rame-larger-than=3D2048 -Wno-main -Wno-type-limits -Wno-dangling-pointer =
-Wvla-larger-than=3D1 -Wno-pointer-sign -Wcast-function-type -Wno-untermi=
nated-string-initialization -Wno-array-bounds -Wno-stringop-overflow -Wno=
-alloc-size-larger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -W=
error=3Dincompatible-pointer-types -Werror=3Ddesignated-init -Wenum-conve=
rsion -Wunused -Wno-unused-but-set-variable -Wno-unused-const-variable -W=
no-packed-not-aligned -Wno-format-overflow -Wno-format-truncation -Wno-st=
ringop-truncation -Wno-override-init -Wno-missing-field-initializers -Wno=
-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unu=
sed-parameter -g -mstack-protector-guard=3Dsysreg -mstack-protector-guard=
-reg=3Dsp_el0 -mstack-protector-guard-offset=3D1344 -fno-common -fno-buil=
tin -fno-stack-protector -ffixed-x18 -DDISABLE_BRANCH_PROFILING -DBUILD_V=
DSO -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tables -include ./lib/vdso/=
getrandom.c   -I./arch/arm64/kernel/vdso -Iarch/arm64/kernel/vdso    -DKB=
UILD_MODFILE=3D'"arch/arm64/kernel/vdso/vgetrandom"' -DKBUILD_BASENAME=3D=
'"vgetrandom"' -DKBUILD_MODNAME=3D'"vgetrandom"' -D__KBUILD_MODNAME=3Dvge=
trandom -c -o arch/arm64/kernel/vdso/vgetrandom.o ./arch/arm64/kernel/vds=
o/vgetrandom.c

That command line does not have any --gsframe[-3] (e.g. -Wa,--gsframe).
I am not aware of any binutils release / repository state where the
--gsframe default was broken.

@Indu: Do you have any idea what could be going on?

> I mostly don't know what I'm looking for w.r.t. gsframe features, but
> I'm willing to poke at my compiler/assembler/build-process.

Could it be that your gcc injects --gsframe e.g. via its spec file?
Maybe that would show up if you run above command manually and append
gcc option -v?

Does the intermediate source or assembler source have any
".cfi_section .sframe" statement?

$ make arch/arm64/kernel/vdso/vgetrandom.i
$ make arch/arm64/kernel/vdso/vgetrandom.s

Can you please verify that your arch/arm64/kernel/vdso/vgetrandom.o
actually contains an .sframe section:

$ readelf -WS arch/arm64/kernel/vdso/vgetrandom.o

Thanks and regards,
Jens
--=20
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsra=
ts: Wolfgang Wendt; Gesch=C3=A4ftsf=C3=BChrung: David Faller; Sitz der Ge=
sellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

