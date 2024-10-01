Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3771ACDE3;
	Tue,  1 Oct 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767760; cv=none; b=pXIdhQ3a4jkDiyWNXciq46CyKhTl0lGy/L3FAjFmlGN29FwF1/wrjNAU3Pu/rUp2P77WzjmXV4XVxmSzfgAOeji59EAjU8iEGlZgckazJhgOYfdw1LRGVoirl9iUiUPPVwkG37+moXZob4255uMYFKp/7HLCy89+3+Z5Hb40wzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767760; c=relaxed/simple;
	bh=0W9UV8CdEjjTR2oX4DpQNMNnRgu++fVJZiVsFgEDEig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbXjFc0EPuFmAcRjgbUjFV3EoC5wGBzNYYuHUA4p0T1r8GsZjdl6xCUKQUrWyQYpUoXem7FvziJjolc1dERgnOus5PfsGPGWqd32CPwKEXSxVOT8jI2sMRiowMEe1auxZgbmBxkGjWvgqwQK+JEoq2QVL7jzIV5oga3xfl3GXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IqqNLdh0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IqqNLdh0"
Received: from [100.79.128.42] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9662D20CECB9;
	Tue,  1 Oct 2024 00:29:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9662D20CECB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727767752;
	bh=oV+M8wTtyeUDKHVuDlLOCywe4WnbTuQpdcGmY6cn7Hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IqqNLdh03H/R51q3QfpE0H8PUqNmomH+qr62Ryq9NuZ4mS8YysC43EVW1zlupjvaW
	 9dECyKJKuljYipEF1KTRwpL3qLsTx2TbaOJ3JGVUJLYZhaBKqHPPrUuAuNMVl25dnq
	 TdmlN6m+Qd4shboaK9W7nhK0hazpTlGAWeODULak=
Message-ID: <5221728d-df48-4539-adb6-8c637c7596f2@linux.microsoft.com>
Date: Tue, 1 Oct 2024 12:59:04 +0530
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM64 Livepatch based on SFrame
Content-Language: en-GB
To: Weinan Liu <wnliu@google.com>
Cc: broonie@kernel.org, catalin.marinas@arm.com, chenzhongjin@huawei.com,
 jamorris@linux.microsoft.com, jpoimboe@redhat.com, kpraveen.lkml@gmail.com,
 kumarpraveen@microsoft.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 madvenka@linux.microsoft.com, mark.rutland@arm.com,
 nobuta.keiya@fujitsu.com, peterz@infradead.org, sjitindarsingh@gmail.com,
 will@kernel.org
References: <8e02ed1a-42a9-41ab-b1b4-cb5e66bf4018@linux.microsoft.com>
 <20240927074141.71195-1-wnliu@google.com>
From: Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <20240927074141.71195-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27-09-2024 13:11, Weinan Liu wrote:
> We from Google are working on implementing SFrame unwinder for the Linux kernel, 
> And we will be happy to collaborate with others for adding arm64 livepatch support
> 

Good to know Weinan!

Happy to collaborate, please let me know what I can focus on and help here. Thanks.

Regards,

~Praveen.
