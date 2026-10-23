Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749525;
	b=sbNMF/9u2/DmIV8Zcte9jWrf7Y9zp8kwkXPUINPyfGsHHfe5Bhxz1J+uCuV7qpdM1e6r
	 d4MzwSyH5Fc5xQgTCfv7drLC4MWOaKnw1U6oRzpgsdSMZ7LlFUWqyOBxozSxx3wQeJi1G
	 x5Fw7oVIQLLiBFv4KGqmi/tc8JOPTzPpGPqiH9U8TcNI2jfzLyoDUbcT8sYxtbskNVBsN
	 mDiJdhq/WBYERq7u5ojgJewPOK0SP+rXyuaeYS6qmbF2mrNF/JNk89bEfH56KCBnoMyME
	 it8BmhCvoaNfTsTse6UhV9zD6mF0CVy0NwimkblkJenL31UW7Kd4FpcR5/oR0agotJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DN9tx4Uizzcau4xSUXntf94U/w5iTH7dEvhNe7KTMIY=;
	b=uyTfXtMdPdEkJBFP97zAAIv7PrZwfRUOUzP6mWuIHdawQ5yJMMMzDyd4julj9+LI/1SG
	 kSYWvlusIErppL5WauHa2uHauWNOsdL+E0X47/uRvuTBlqx5W92Zhn/zk5jgj5w2pE3io
	 6DFyRq419tiaWmU+YQWGc98XWJL2+2tKVW5uFZzg0vmfYZ5zAdFh2sIhXKqqaF5DOo8Oj
	 R4efLTVNxV+f0OltVvFUroGKJ9mKZnXIcojSvDxqpST2F/I//PrTB+qGSdqWcYJqSSLJY
	 hHwKBUkgGcFgHNgYRcv+8u34bYopOLkv+Q+eRaSuOLg0gkc2wiCampvVFDNzm6Rv1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Z0F/jNDk";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5C606A31A
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 09:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E5C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Z0F/jNDk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso6295185e9.1
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792749523; x=1793354323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DN9tx4Uizzcau4xSUXntf94U/w5iTH7dEvhNe7KTMIY=;
        b=Z0F/jNDkqR6YKizDoCm1NZ7+F5wicRP0wJ52z45V3RVil+cVGF8rZR9Xyofa4LmvOx
         QllskeXKXAHlNX+rJY17LfQpWhlbLw0PFVx9LcbxqnktYJVVeS9WY8LLwbqbmp4E7Xk6
         oFAgRM9Pdv1TgeahUBueaTFj879WPmpcppsuwyS1Crew/U6OQRdX6A7rTSJ9ujyNLKXg
         kiiJC6iRNklKCK2hAbVDscA2eJcDfWaVM4i+xNVKETWjPo/GZyaguZE3PhDAs+7VbTr0
         FmoQMnc0g8r/wlq0oVje5CjUQP2fnsrOUbhc3GN2JdmRdX+UaeR/zmgjAwQZLkx6F3EZ
         duMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749523; x=1793354323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DN9tx4Uizzcau4xSUXntf94U/w5iTH7dEvhNe7KTMIY=;
        b=C1vm9MzFA3CGuGGlLJAxjSQquoM1hSYF2y+Rkb8Dl6kpwQuJFuJijQhWnrfHJzIgax
         Zmz2KTKZGTK0dxGjTvy3bUh6QvIwLhMyZA7tXKJh8pl1XQTnmrY3LZOwPlp/voriZM56
         ybEDiamx4f4J1FVkdrFYfDJraeFNCs2qoBb/j5WviD4CyHTE8yeJ4dbydOAaJuU0vJRJ
         rUjLi47X33hL01l5tKYsOFWV1FCM91h13cF5gmeoLwxgQb7EUnW1PmPKUsPPAA9qE2WK
         afmevtS4pFUUUHPYgf6mjY5ltZHM1mEThByYVcQblpj50/s85UOZ8JqsFaaSn3+BequC
         pZew==
X-Forwarded-Encrypted: i=1; AKwUvByr765h4P3tx5XvKfC+7vKIXfeRXUnIklZWfoWgzZABJYpdzkz158JVZVJQC7qN6Avh/KEd7n6R5zQFTgg9@vger.kernel.org
X-Gm-Message-State: AFq9FYKeX3UxbdXlsBEu9OWF8rgdV4PNg8EaxjvnqLYcvCwQC3xTnY21
	uoWo7Kg9Xrt3XOGRr1bf+DHpghR5N6QbTlvmIDkcMwHlaBrq/hHqxH/8gm3YwajCttA=
X-Gm-Gg: AYBFou1mb8UGoEZle0BrzLTYtorO5+eTonRypoCrIY8oSb6j+rq1X/dXk1bDAiHu6Af
	25pm8hgulndjEzg7v8AiW1JKRgxjfqUEdCfnb98BLpfvXWippWNB168Gd7QnTEOwzFJrihwkE2A
	BpF/yorjJZBsYH7OKFlbiq4VZ2bdZZGKhm6Qbeh3tl9MbCo+gCXRR+qpyvmOi47yG8mbndVJko6
	iCVi42OVK+pq5+2GWC/akhJIr2ViBZC7MyFY/6Qb2mzhgmf/IJvrb5KSEzKqpUbAoccpJHwvtxW
	lwOtwU+qnD/xNY7MZcIovji3HwvAnDQBfzYPcH8+YTOhnLcLmvGqrf+CwoDfdv8B9xsENi4WpEj
	gM4wr5bHkx0rv/xhstiWyvcEW/9yRSTh20NAid0d7XvQQVOvDNZPWSiyj7BmexU9uoAih9tjZgd
	syJv5LQ42Fa20SGcZ2RZwzMChmEMQjDaNiFHKh5c041Txls68c883i2DYPGO4AoyQ20dBNT3N0K
	yeZOced754pkYJi1UPx9aCD23NSUSqOpcrgyGhiOKnyYiLxWhx/1tEYbLhr914FV3Mi9dtGLvE9
	TTGB
X-Received: by 2002:a05:600c:4445:b0:4a2:5db:1f35 with SMTP id 5b1f17b1804b1-4a211c9dfe4mr29272435e9.11.1792749522939;
        Fri, 23 Oct 2026 02:58:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2153da673sm29560515e9.2.2026.10.23.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:58:42 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:58:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v12 7/9] selftests/livepatch: Add provides/obsoletes test
 scenarios
Message-ID: <atsv0JECi6tFxEr_@pathway.suse.cz>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-8-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016053708.47089-8-laoar.shao@gmail.com>

On Fri 2026-10-16 13:37:06, Yafang Shao wrote:
> Now that the legacy "replace" field has been replaced by the
> provides/obsoletes mechanism, add test scenarios to verify the new
> behavior.
> 
> The test modules gain provides/obsoletes module parameters, and
> test-provides-obsoletes.sh covers the new replace semantics: provides=0
> replacement, same-provides replacement, obsoletes-based replacement
> and coexistence of different provides ids.
> 
> These tests are skipped on kernels that still support the legacy
> "replace" attribute.
> 
> Assisted-by: LLM
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Looks good to me and passes selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
