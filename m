Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B284EFFB8
	for <live-patching@vger.kernel.org>; Thu,  1 Oct 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868429; cv=none; b=Phn7IL1z7WVmGQvdPvl0Uiyc71B9M78jxunj/ymMxSg66jxRe7bwTtJOR7ErRONIvgbHIC4qLVJ+6YzCOulwCV3DNkctquLM4C5y0zpMqMPw3laFNfavPQyEeLpKm9562zC2Fojt7VQk9cF8+mzlchKOb2m1znr9xo0h9RBr7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868429; c=relaxed/simple;
	bh=/TQEO4h8BjcS9yR5a9DL4BHnXMPMc/+C3JrS3vRs7rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvZGEDbvUez7jImpwTQ6Enko7YVoOi/KeN3ZEtbYr6BTHsoxMR6qbzX5+J9060KhPsSVp12AWWk3TS9X+2/FOjAVV1+G7Za8tq43yCHx5Qztn+QNs+xTqpn9nd76tshfhyUKvwoW51VpJz5Oi2Bzun86H86AtyymlZurWqfE1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H0moSP/w; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H0moSP/w"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e66390995so38810495e9.2
        for <live-patching@vger.kernel.org>; Thu, 01 Oct 2026 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790868426; x=1791473226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VcFyeo5ST4StGHqndqIMU6BghZiD4Oyx0JOL63AdEvg=;
        b=H0moSP/wMQ6XHlA2TzL6PqrTtU3kgS5xY5i+CICOyE21lD1xK1cZ8qNoJp5HAzkPge
         AOArsA3FWBQx8vgS24wQ2jiCqKfUnbEM6uuzNfaPxu48m4KZcEVj2etaoWdgpYx+UyFu
         cqzTWqh1kYJt+bAC4wbtEREnHMruc8hu2bSvye8PxiOX89klUddb3/IDtKci4oqS49MR
         1POkCZoNtYCOj6ZZd2GqbQV6rnmorLIn69DHr7VhWyTa2rFsZDFJGk/4jwPXIi+jnDNF
         UKrMS6xWFwCecBJMNXRS7BscrVtdmcbfLKiTFMCJUSn6WofhVk5dHyk7lxKAgJmgrjfn
         KZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868426; x=1791473226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VcFyeo5ST4StGHqndqIMU6BghZiD4Oyx0JOL63AdEvg=;
        b=CeIhVRkBy3mGodc5fSvwKQ8jv5nM7uHIQmvScezYdMyUbQfNeZ2I6VTl170iFQlSTT
         lu3htUjRqHbhp3gmgR/bmyWWs60nDg6yoWBj8bJicUlVBqmGHhsg2YDodVUOgfIyEeIv
         181/pV4TNxYvsjGYHWGcl4xI9ui9Q9mWhNyY9+LiD+aUfQJtY07DH3AWoVipilNp/v1Z
         oTKKf/KPxwxABstNCCKMSNN5y2y1AGcnM4/fmxi7aZbr50BihDvid967DCIuc/1aTSGW
         NrtrUxqH7HcssMhdGI1WqmLXJ3qYicDFIspjXCjMUHu6zUey5slOiFwi+mLhp9msScVF
         CIMw==
X-Forwarded-Encrypted: i=1; AKwUvBw5d2vptINadM76tSCFDOZHSueRPCIy2CKvqfMR7YhdLxlDoF/7wHmGd5cIAaBA2HuQM/gqKy5KJXfJdAXO@vger.kernel.org
X-Gm-Message-State: AFuF++lKi0p22gZbYm14MTEnyZLYYWKtgzRnSe48qKcXGHKniGvNuZQz
	oPFaQYPHZfEgWGb6wVVjZznk0AEww8lP44M7CskpG2yk0hdy9iZQuFw2HgJC7skP/Qo=
X-Gm-Gg: AYBFou0Vn6d6mZlF+wsaMKqRfPi3gW46MyicoZDI+s5sQGUw9E/3z36jou+M3qI7MI0
	ffNel9lWLFPs0U0mjKdyDKo1IaiRcCDH1z+by7+AIcg6sgfZm4NWsUVYLHuJ2uW8AKWANcrSGAm
	a2na5VShbZcxmv60bO/4R223BDXIH2RwLeAP9SLC5oM58PhGvzc4k9s8riK+llLlV/MF6YSQdgQ
	F2jfLAUqjzwaw7FSBpML3ghDeOd8LN3v3gZwlpNoUuzC9j6VVdLHO6cgngWcscAYsikFcyEc1Cp
	wHXyBWOQGpADy1V051S9lz5YSoAwUkSW4+b0S42E0l+xTeiCGU7+0zwzlkN0XiGzPWgFaAiRFY0
	YrVALteg9/t/iBi3nqIktrpi8n2isBPMm/7KDOueXLUPounUNKlgoi7/7shjIUTvhvK80cZAn5I
	jGu1+sbPnG5QYm/dJJi9PFabp19/0On0x3diLaBvQiPQZqj6oY5fcjXqFhlgnscMnbgM/XlV8R
X-Received: by 2002:a05:600c:1d2a:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a01afebf68mr103021775e9.13.1790868426060;
        Thu, 01 Oct 2026 08:27:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02720cae3sm3942395e9.2.2026.10.01.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:27:05 -0700 (PDT)
Date: Thu, 1 Oct 2026 17:27:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v10 1/9] selftests/livepatch: Clarify test module file
 names
Message-ID: <ar57x0tKBWCB3uw_@pathway.suse.cz>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930030323.14396-2-laoar.shao@gmail.com>

On Wed 2026-09-30 11:03:15, Yafang Shao wrote:
> Rename the test module files to be more descriptive of what they
> actually test, as suggested by Petr.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

LGTM and passes selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
