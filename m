Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F42149C6F
	for <live-patching@vger.kernel.org>; Thu, 25 Jun 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394712; cv=none; b=KonpkNHdQ2IzjM4LSHZG9K6lmFFVeh4t5oERmqSP2ErcwamawybU8lGY/jEsJPRaA37oVh/HKAvO05pXerYoFgRIzoBtqsV6ftPqTegssl1b6YVAiU7EwSKf1WNmlcqqt21ipSKlZ+det4C/FEVmQgRfRy9QghRXNHa0h3I08Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394712; c=relaxed/simple;
	bh=wFXJXyjIF713HNl7t+kRh7pXUgEaBkR0qNMWhjeSUYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcCIk7ztIaeLGUpOLwtxnq3VZ1QMNPYdJKa9iAbkHNxc/CFIZvFNxYRlwjBAfLxJyF2oChugBBC80jTF8M7zfcw2HdsZ4Nge94+d10d1Cz94G0P1sIvRnVHaYsmOWi3Yx7KqYgyCK7ySYaAjjPwOcWuZGh/vheY/0ar3A7LgoWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wf5WR9IW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHDro/Xx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wf5WR9IW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHDro/Xx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782394710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaCzQvqF9EyoToa3q9gbO26x06tkprXQ/66sr7Yqq54=;
	b=Wf5WR9IW0YzkrM4vhuinIXCxx8bHWRlGKjNEbsChJqU540CpsVVkEez6TZ0Fn856pc35lH
	6MCBgr8ENCMwFfa+aPzNHPEvO0WXgNeteF8OEaoY3D9iF8hb7kQ7WwtYUyXwSOfuEicL8o
	K0Gyd8nNEAVr8ejmipai6sn26ZPqXls=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-5AsmxJOWNfSXwaFcHe87Pg-1; Thu, 25 Jun 2026 09:38:28 -0400
X-MC-Unique: 5AsmxJOWNfSXwaFcHe87Pg-1
X-Mimecast-MFC-AGG-ID: 5AsmxJOWNfSXwaFcHe87Pg_1782394708
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a0d024b84so22656951cf.2
        for <live-patching@vger.kernel.org>; Thu, 25 Jun 2026 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782394708; x=1782999508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EaCzQvqF9EyoToa3q9gbO26x06tkprXQ/66sr7Yqq54=;
        b=bHDro/XxsukMawsHPSC1GeiubVgd1TSARZvEVf3zR0E6dmOZNIniFotTsGGvoodc3V
         oLYRyMppYfoH59ydaMZWqvqp81EIkaiK88+uyF2FUt+Nbh6FzWgSNwaEF4AZTOZh0YIS
         8Ols1ywn2Ul5SaJuseXSIcMjdMedNWAYnjsJn9hnxu7QeCMoeF0e822BAJFW4XNI0I8+
         v4BNbSHcX8tlALKfq9xXGONR9J0cHvpLIKYgOFhMsU+YF3tK10Cu5ctiMh0ToYFoR9zS
         KgFbiDVY/syfvizXkGNH7CZnhRVu3pmvk3vmoufVrGoM3CXJ4NWjY9h4dnn0ByfP/fLy
         CSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394708; x=1782999508;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaCzQvqF9EyoToa3q9gbO26x06tkprXQ/66sr7Yqq54=;
        b=rBZsJpSL4ytY78USv4eZF4nihfcZXfhQ3e8uRYDRE+eMLrwKdJWIM3q46ciTyEz/c6
         wfBWvqQLmPQEHaAMuLow7GAp63gZ8ThICQkmIc7Uojjq/NliKO7Py06iMmD/VdkVd8cd
         JxRKsnyKS/6FTIvUgoOtTXNsJwS4tBUMLM8tfa8OULJlWkRbLtGW+v+c4UioHSkrBryg
         4+CTDNN2NQVvqAIRyDySaS/5E8HFBII3hqu6J6X7kPR7WYQC2SNFxnyxMbPq2huNW0vq
         6R4U/GZsxQEu3POUwBLamiDzAOAlERtLx6cDHjmuuSfNx7do/xuti6s8aet3qzOhtJNv
         e0+A==
X-Gm-Message-State: AOJu0YxOOIUFtKM+4sq+FCYirPJPJbimbHNLJ/baaoNLZ+GyKY6446AB
	KnirkvoLqlgPK0NWz/rrZGvUyeBeGNNRJ1SF6bA0xNmGV01bkfBDdLZUNKNLdMkNXtNd2bLw7bF
	fGEtJWQbaNfSq4VqgJAY9p1FESF92KhI9q9JLnMjYrZ1gpmo6wnRKWAfqwPKWd2rpRcnbApz5IK
	k=
X-Gm-Gg: AfdE7cnXQF4XU0Ae7fmDfA9kVgwQUoHiqHnfLSxF54YXrSLjQh/QWBSsWZQbLdiR5a4
	MWQeIzfcFQVuNA2lpwbXb5Tikmim5bo98MayJQ/9CjZgpopg7LQP5Y0wGDIbXc6z/j7BF3Jhp2V
	Rl/am0aCWwKbO/pnPifuCMl9m/3td+NHJEutG4JOyc6+WaICkHtdNB5TWneKnZM6SKFbLW1IY4Q
	xHvwqQMxKDFJQMnJOUZ6dtKXQxcp0NOZEMt9JCYkkszWrx8ck8A7JOk3I76l73IEIcW9rteXS9z
	WKgbiLdUSGA0tumF0docX0qXsTo+ax+Yo9JrY7F5rXl786eCbW95tlIDXRK18GvzyhaxhG+Actz
	sAFlE/RFW0D643vSrD1cogm2Lo/ItCG5CWobETW+svD4sHckTJSnFQ606BV3d3A7QC/w=
X-Received: by 2002:a05:622a:5144:b0:517:5e32:af20 with SMTP id d75a77b69052e-51a726f922dmr33833221cf.6.1782394708031;
        Thu, 25 Jun 2026 06:38:28 -0700 (PDT)
X-Received: by 2002:a05:622a:5144:b0:517:5e32:af20 with SMTP id d75a77b69052e-51a726f922dmr33832141cf.6.1782394707193;
        Thu, 25 Jun 2026 06:38:27 -0700 (PDT)
Received: from [192.168.1.26] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51b07812sm70683211cf.28.2026.06.25.06.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 06:38:26 -0700 (PDT)
Message-ID: <6815ffce-6ae3-4b6d-9118-f8e4dc8a5122@redhat.com>
Date: Thu, 25 Jun 2026 09:38:25 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] klp-build: simple OOT module support
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
References: <20260512221102.2720763-1-joe.lawrence@redhat.com>
 <CAPhsuW6YGdh4xFcsfUiGtVzLg2nR_cEiQpvmyEN+Ffyf_O53LA@mail.gmail.com>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <CAPhsuW6YGdh4xFcsfUiGtVzLg2nR_cEiQpvmyEN+Ffyf_O53LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/26 7:30 PM, Song Liu wrote:
> Hi Joe,
> 
> On Tue, May 12, 2026 at 3:11 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>>
>> This patchset introduces support for patching basic out-of-tree (OOT)
>> modules.  The primary motivation is to streamline testing for objtool klp
>> diff by providing a flexible and stable environment.
> 
> Thanks for this work!
> 
> I would like to add to the motivation here:
> 
> It is actually useful to livepatch OOT modules in production.
> When using kpatch-build, we (Meta) generally do not patch OOT
> modules. But there was one case where we had to do it, and it
> required quite some manual work.
> 
> If we can make building livepatch for OOT easy, we are likely to
> use it regularly in the future.
> 
Hi Song -- for your production OOT module use case(s), do you have a
skeleton example module that I could use to test?  (For this RFC, I had
only verified it worked against the very basic OOT module structure I
was using to generate klp-build unit tests.)

Regards,

-- 
Joe

