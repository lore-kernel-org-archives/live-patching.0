Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E33EC2EB;
	Wed, 22 Apr 2026 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867559; cv=none; b=NVsSuCMhaURPrnSbKsjGHtDcmezZCdfNzWBHadUiyhPp4DVeMjZYo6A6GFWDGtKZTHsuSIZT+QcNZOAqIeobLuFBPnx5EJ/tPwzt9rzWoK4EK1s/kLh3+VxDwQibZGcTYq7NCW1kcsWZ3tsmnARZsSjXQcWf3cKrPOQaVzqs2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867559; c=relaxed/simple;
	bh=5v8JtinehSHsTeGnx8VdjNAlWPJ5HTJUA9ShWQQkjzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc7JsmwvuRay4pO1qJhi9Tt63vGxmxYyrIp+gU3Dl19cEGyS/uwgYJBolEdCQKjZ2qYmrvTlhbItjBVhAJMS+aFI7YfBfAFh2iH5OFfFjEOwL/8MktcAK5Za9qraW4eL8ZppfZ0AVPxoaDW6nyK1iwq46Spv/krawDDK7OrEku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I5kB12Oa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I5kB12Oa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MAanN2971309;
	Wed, 22 Apr 2026 14:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jtPDBC
	Xsr6XvdkCWUrDtbXUoWoUx1RYK7FdpAV95iuo=; b=I5kB12OadisF8hkmbZ70Pp
	VVqF9HKvxJdIIpqNVIhVxkKebFfFYJEPu4A18BtRUnBTn0fLN0pQv07XKY23Mql0
	OkBYq09uKrtpAROYKQaiN7R/8w6iJ1cxeBoaxfNzqXsFwK+J6N/bmvOrRw9trSt/
	sCvpyhGO+pRW9euJa4zUovIwTTqXTdvtWNlnd8fl+lJsSTo672/jrKcsLGwQOOOY
	G0w5CQOpySwzbRgMPQeGhvL4tWWVa9f+VbDGaMI/UmUVp3RX/GlLCYXth8HJlxCN
	L4PDCmsybSdolGmXLocplWzMFev+cxa4CTZOs4fZgOUaiJmpzhS+z3vG5y/1OUZg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3kkwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:18:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63ME5LAm005955;
	Wed, 22 Apr 2026 14:18:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky2j3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 14:18:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MEIbgO50725244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 14:18:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 699F12004B;
	Wed, 22 Apr 2026 14:18:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14CB420043;
	Wed, 22 Apr 2026 14:18:37 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 14:18:37 +0000 (GMT)
Message-ID: <6a50cb4a-54d4-465e-9bf0-8419c9f61338@linux.ibm.com>
Date: Wed, 22 Apr 2026 16:18:35 +0200
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] arm64: entry: add unwind info for various kernel
 entries
To: Dylan Hatch <dylanbhatch@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Weinan Liu <wnliu@google.com>, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
        Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>,
        joe.lawrence@redhat.com, linux-toolchains@vger.kernel.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20260421225200.1198447-1-dylanbhatch@google.com>
 <20260421225200.1198447-4-dylanbhatch@google.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260421225200.1198447-4-dylanbhatch@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: n-EqorD4jfKWCCxQL8vbgZkFDo_qidlt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX6WZX6PogNqvr
 WU3ArGqKfZPA9oyav/tcBZ51ToF6a/FPzyTKOiXqKmqkfDQsAzV9yux2IgnNOx8TCIFCiw9hH1R
 9TdG38x/savHXHcd0zfl9fGX2FNPA+d522JmoUNSaK9rf5qmY6E7KEmp+A7GJOkxSqiHycT8Rur
 gMd1WvzVYCjwfSw6/siTEgeExX9LQeMVADbF+isxpQGVLqyBZk+Nt38y08sNsnbTUJysmHyNiyU
 4MXY31Gh/SS1j5RSREz9lExbl3ii6PFVJRrWMY4moRTCsnP3rB2ZrNSGjPHRH/zov8m8sNr+Rts
 mKY4+cA2FMNQDReSycEGH946tE4va3wS54Xlx3696hY4BcyYkcZa68BjdIe9/IdqwdeXpDgu0tx
 lTD5YUtsMZnMTpQmWkKC5/1zV3QD1peUJ/C4IsuReJD5IIC8U+UhEGHUVY3WS1HJ8vfc8mE8ioc
 zD+ovYjNWZ39YB9gtuw==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e8d8c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=Ozp-CAkSXV3980NJQmwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ffjTc8xH74BgYahFIb1_gUBKxG0c2R-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220138

On 4/22/2026 12:51 AM, Dylan Hatch wrote:
> From: Weinan Liu <wnliu@google.com>
> 
> DWARF CFI (Call Frame Information) specifies how to recover the return
> address and callee-saved registers at each PC in a given function.
> Compilers are able to generate the CFI annotations when they compile
> the code to assembly language. For handcrafted assembly, we need to
> annotate them by hand.
> 
> Annotate minimal CFI to enable stacktracing using SFrame for kernel
> exception entries through el1*_64_*() paths and irq entries through
> call_on_irq_stack()
> 
> Signed-off-by: Weinan Liu <wnliu@google.com>
> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> Suggested-by: Jens Remus <jremus@linux.ibm.com>

Reviewed-by: Jens Remus <jremus@linux.ibm.com>

> ---
>  arch/arm64/kernel/entry.S | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

