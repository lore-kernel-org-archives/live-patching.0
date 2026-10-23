Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768796;
	b=ZmltCiK0imKr99jYRK5tQKRbpT9DSKE8lOFYyajSwHOGdnT8DUhdCyupVpiQERSpm50q
	 9af8i2V6mKhiH1BOAlln6jydhO0Oz7JjCBAUBhEGkFuUKH7y+dMIPkjwvtqE5o5d5zMrz
	 eGgM31o4+HhRD6PeLteLOAnwwJZd+JO/Y0zMhagfsM4u8Tu1HT8v6RlebV1ONIsktfN69
	 d4yX5Lqv/LJ5uNX0jlDU3goeiSis5IlciGOfy5qDrxEjyQqOMsSn8m8p+e16YyOysTkhb
	 pRqjEcvmASZeVRAlTqo8pN22Gmf5Mo2P2UFJmWH94sbbFGUcFcmJigDAbt5Orbz+/RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oPXMY7ljvQoOe/x0Rh6FHsqDnFNAF6TLNBIr0QtgRhc=;
	b=0srgniOt50zdGMPJIeyF13fFqZHKjrGeTbUST148IB98lfmZGfSQJc0lwGICydvcodHc
	 sWiRIjqOTG1XDyvhdxuPOUsr5y5/eavBjCFMD6rVfkEWnKjOr4ag/QFULRM366fCa8Kzh
	 3uoa2XhR+1UJ6jQYykbhvGAYDIoTTj7KKHPJtVMsm0Qjdl83zZIbFjwbTBT+I8tJdcr3j
	 HZQzv/Q5a+NfWFW/69gB0MoQ9Y7fJ5KZ9bz0QZ6izzSo7lsSJGzstdDDnvW43ZWBMGs9O
	 l6lKOd+bnN9rWNIyJuYdgHGv1kEDb2GKTUDALrkYVyhk0zlJ1APLzBfIeKW359+Vm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Q+0rIcC+;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0848606A31B
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 15:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0848606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Q+0rIcC+
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so8379565e9.3
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792768794; x=1793373594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oPXMY7ljvQoOe/x0Rh6FHsqDnFNAF6TLNBIr0QtgRhc=;
        b=Q+0rIcC+9gfdAvdIsyHZh2HQLoo+0mT5pHgUsUZ1x7pKcD7aH2255csjurCnwZmPxM
         kOI0YGqmZls5nfFYRmKTcMtJJOM+7W9bXHDGyqOcX6RDLlzn4t+HjoZT0iUXlHeJZPtE
         kZX0PR+dPusqAdbqUKmJr+44kDRr4StsN+bFxsbxC+sGQC2XVwoaB9ugV82+qn92A7Lw
         EHbnRxgn5YlTbKNCD/IeGPgcXkANjBf2FSIrcEIex3Vbw69mX467G+vuUxtcFOOgbLx8
         MMynQ5mb5m+3UL9lDagDfnQV4xjfMfGeXBKHSLvqCUyC/ye1WuBJx0ifrwVAZSqu6TYu
         cjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768794; x=1793373594;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPXMY7ljvQoOe/x0Rh6FHsqDnFNAF6TLNBIr0QtgRhc=;
        b=YP8mk9reTXjcMW3cPaQmD+IMpcXWucfC7WPDANgcqW6Ci7bDB5vM2reZcQhppN58FA
         0ZNX+/IZLpHZaeg9gKFAMWOTY7S+1eLQJ8gEI3exzgXHT2MQB609CsqoQxtquuoSphQU
         cjtaoRH5gGn2LD+RjnhQKyjvIaiFakTvOZs5R1EtNSkOdTCNjNECw5tZ3U/z35zr5JT5
         xwwM+lYCt6v/e0yg+1ENK37a1IWispl8/T5rQrgTexDCn4FO9rmlAf/5OIA77MdHwocR
         LVp9YcLB7dIYrWKqAD0OLLB3GGcVaCSfVa+u+A3W6dKalWVh1qVTLtsa3btCaKckPNFS
         FiLw==
X-Forwarded-Encrypted: i=1; AKwUvBzl35PLVLfOCx5r+3crTws47BHWuULP8JnrjObvOPK0Xmf5BLgdnqNbRZRHE3UDNDn1mqLG6iayOOa31HhH@vger.kernel.org
X-Gm-Message-State: AFq9FYKxCPxPkBlSlsFyU8j75EDpNg8a2f0QucfhL9xSa1l2rWDNBxpG
	etS+//bnq7avS9z+dr87B7uAFVF8G/4DII+k+gp0VT+lE/HDKQO7At0XWGS0JWc2NmQsawxXyLo
	pzFd8P84=
X-Gm-Gg: AYBFou08obC6Oubaejb4/AmDgEpKsLRfXDAv5pWEa6vW8P75v+3tSDAehSyXpx8JuVs
	lElp29MC+5iaUUIepX7cezAaIHLqy8ifWf4zMvn5u0ZmZ8LsGtaATkisufrBTIKdsbfbcAyu12r
	ioUNqIbWU/aGfPm7EGYYa94dhigCAhj9ac9+Y6sse++67dLdm58Zl+lFakSB2jUYMa7j7TsW3VY
	C6R2qT1mOmi6KTsrzWMtMPUtMwAaDeKr/xwwYbZ2J/3Lpc0jZYGZvAi8fotUN+fBcItzK+Do8x9
	cUebsviUlk6aJi0ESr1Ns6K+XKDg0SwKBFDooEZ58jnvFkcrILnJvD6XrXoeDuEjpgHwzO74U57
	AbeGm/byhzH6Ehugb66rLrl4118rcMMC84HBVAvEUwEKm3Ga+Rg99xnyKSo6aglW69IQh/OwzcD
	uh4YWkCnwv+oUYji6A6j+JgTBZNfARa+jfUnHq/HdnAF7rRZ8Sx3O/+an+c3Urud2ecnCUOdGoe
	Q8gGmKmFBCXwMu6ycMe/BcvLKdm9tHlSyLtIlFIsVbZTDXaJVrNh7IRiA==
X-Received: by 2002:a05:600c:818f:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4a312fb201dmr3737145e9.29.1792768794133;
        Fri, 23 Oct 2026 08:19:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2b061ceb7sm9707855e9.6.2026.10.23.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:19:53 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:19:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org, live-patching@vger.kernel.org, shuah@kernel.org,
	song@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] livepatch: Fail object initialization on
 duplicate patched function
Message-ID: <att7GJXA7hK7Ic64@pathway.suse.cz>
References: <20260908120325.299649-1-pmladek@suse.com>
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
In-Reply-To: <20260908120325.299649-1-pmladek@suse.com>

On Tue 2026-09-08 14:03:20, Petr Mladek wrote:
> This is v4 of the patch failing object initialization when it patches
> the same underlying function twice through two aliased symbols
> (functions sharing one address) in the same object.

I wonder how to move forward with this patchset. There seems to be
three unresolved problems:

  1. How to handle aliased functions when replacing two livepatches
     with aliased symbols, aka two NOPs on the same stack [1].

     My take: I would fix this later on top of scoped atomic replace.
	      The aliased symbols should conflict.


  2. Fix the low-level __write_relocate_add() to clean its own
     mess on failure.

     My take: I would fix this a follow up patch.


  3. Better describe the purpose of klp_write_object_relocs_limited().
     Or clean its own mess a better way (code duplication)?

     My take:  This requires v5.


[1] https://lore.kernel.org/all/20260908121744.81D641F00A3A@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260908121810.9577A1F00A3A@smtp.kernel.org/
[3] https://lore.kernel.org/all/att3oHvCpVDjDt-h@pathway.suse.cz/

Best Regards,
Petr
