Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8422EF653
	for <live-patching@vger.kernel.org>; Fri,  2 Oct 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956745; cv=none; b=bVzq88/4pzNuDzpcNPA7+S24rPJt1fQ1j2mhbkm40MLNfVHNqZ/z9y9UkeEdh3/sSGW45dsGKmBLUy/9h5mEGf9mN6mkK8psmfrtv6XxbTEj3VJklPfcfIXEbExxaSMO2Xq2M+vCTjzdUbk6xacfF0JWYjqUi3yP+N4FNS5sHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956745; c=relaxed/simple;
	bh=DSdp4X8GGk6h10v1PrpKDkfDsEGKgt8NMl1GuDEa/yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX6LzWQH8JXQT/GyqzWonYpRLFIkpHPhwJvwuICd9vwVt7KnLMajVavTRBX5HBggwWLeRLgVVXGgIV8KN2J7gUlOjcRdoDdMAxvn56fA9bQfYHVx0FAnwXWJH0/oteA3caBFR9fGQMaKUfTACxNRpWhAYtE/ymJWjk09jR607A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ve5rgLvf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ve5rgLvf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso267495e9.1
        for <live-patching@vger.kernel.org>; Fri, 02 Oct 2026 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790956742; x=1791561542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ttsDGs30QbkD9dY7EqFkLiEbqyIF4idyRlrtBF5rffo=;
        b=Ve5rgLvfkX/Mmz4GzMMZ0eSLP0d6oTUGyBLKrACjnnCRbT4TpJTUgzsvxGDTO9uNp5
         CTd7yTgV0qDJCw+Wu5u/WFhSlQdluh/geugD+tUzxzp0rhDEXryDzMyLTxjn/y0Xia6M
         4QZidmSAr276xhLSi/nIVyllYlDgqhX9bhoGjvDaMYOGnoadqoNL01tLsY+7hsISzGA+
         UOhtTbZfLV3O1rPetdX1N85PPEtnsKYILfjnoyuesxGdbObN9KO0/1xb58f543SQ6uvt
         K0aeyqkqhxE6fedzXrrei7mjtXh3RySf7VlJmmPQGSorIZJ2K5S8omrjyTheb8mfqc8K
         rxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790956742; x=1791561542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttsDGs30QbkD9dY7EqFkLiEbqyIF4idyRlrtBF5rffo=;
        b=RT3Su+wKeqvK+Pw4DmMpg9VRaG2SOodbpW9/MX/PxftjmL+cp4x0g2dRCMIy1SXn0E
         lSzvsUaCunpnTIOTubTgRUtyoZ6UvCU5edXEutUqIEtThqNvmiODvuJGkYv5KG4e2yxY
         NOZDZcb74JDbr5A08bbclIt0UIzBRmDRRHF69V8S7KxQqFzz5tIPUUGQMECBlu5uhPt7
         WEHSRujcajdzEQsjLVnyZuT6JPxNccc9YSuG7l+/trCwp6dyILJ5KaSyVCza3jPAv4ow
         OZArxmkDSVJgb+DpQzdTP+sd4hvMJUjavbMaDdr5UXGAvCkvDCB0VxJM0Pr5AsYweR/d
         97Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxZYX5hBrZb/5YYjd/Sr1t1846dZELq6IQwpAbj6dmin3DKgm0bu33jckhEuFoEwq7+WZTmh2By8g1abXgP@vger.kernel.org
X-Gm-Message-State: AFuF++kLL9qMz5BZxN+adoU32QNZXn0c8JLDqaeZA3HJ31wTe21RyZ8y
	CYYFty8i1rElbWnp+Uv4cHgrZD+nfZFVRvPAQE0QzXkuYa/DvYzl2qO1yTmcckLpOHo=
X-Gm-Gg: AYBFou2isfXy03xrOVMqg7iw7DJrfknmf3fSkIv7H3LAW1CWWmtMfrbJ1kS10uJnJAF
	Ue9GuQKEmVUJXCtDmgu8iY3madTBXkFTJ1uBZHCWlrM6rxk4+idmTQldezdT2jsGMrRvcyHPI21
	Qgh91tYHrYnQLlKzmdahQLJ+zXCmmmuQO371L4ZQOACBmY7eWK3Qh757LikWH0wpmgluFlE38IO
	bJC7WaeY5g8lBKiNrwpS0DiqZsyYZnsueuKgoBZwJJYV7cvs79gxB13yVufQXcA11NIEG4/wez6
	ix/egORVYwW+2FPPH/TOduO9INgGsbLCm0Zw2IUGDTTFdZbUi9hkt4TJXZKZJiVagsaWKmcOieG
	CgAu2kWqLkV/QlHEaxRV8e6fRzM8/NWUnRVtjfUpw2qcu6D67MOz6NDBDomNZpUVVoLswc5zSJ5
	JiXPEOsq+t+6UTW0q6kQJhTM8VaUJSP0994DqNiPF3PziBQQcECKFpd5zaSIVQTpfbbCttJ79p
X-Received: by 2002:a05:600c:3e19:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-4a027534b98mr55941835e9.3.1790956741936;
        Fri, 02 Oct 2026 08:59:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm6260487f8f.35.2026.10.02.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:59:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 17:58:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v10 4/9] livepatch: Call klp_init_patch_early() earlier
Message-ID: <ar_UwzWy6cAt-_iK@pathway.suse.cz>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930030323.14396-5-laoar.shao@gmail.com>

On Wed 2026-09-30 11:03:18, Yafang Shao wrote:
> Invoke klp_init_patch_early() during early initialization to avoid
> mixing for_each_() and for_each_*_static() variants later in the code.
> 
> No functional change. This prepares the code for an upcoming patch.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Looks good and passed selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
