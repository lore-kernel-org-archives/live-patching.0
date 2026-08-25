Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F4463B82
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663550; cv=none; b=EG1BfaTah1O4DUW/bcQRiEXWRhMvx5IMTD0/C7t5XBHLtLUkAucScEmrx0Ps1ASPQnEI7WMo2pfNkN6bhF6Ru/ZFEGKV6fzSU461fKly3MQMe6J1MJ7lklGyoCIDyOdB6iZ0n92InrwNrlfaHbl9ZWOPGOUazZkAERcB+CNo5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663550; c=relaxed/simple;
	bh=Px5HaiRLFHtGk9GEgSeiRjA4kI4KfbcMyMMT/utFXMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXe+jPRUpEmLQHVrEmXUdSfLznzRENpcNxKMZalzXip7bv/JrHXYfv7Ms9ngzJf1GFT/TOwxZi6WeMLFs68TcYsmbNSeYg8T21X1OvpdnMsbU1t3H4EiMfYF2dGXcWsbnluTQxnSRQuCuxFhuc26ITbGp+2LSwk5Rd3Gz8l0R+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A5icUvDl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5icUvDl"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c20ce3c118aso162877566b.0
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787663542; x=1788268342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=A5icUvDl8cVYbS3wB9rMX+oQXhVYYi6D/clcs6h9sVqO9VnBqgeOoMft8E3M0cpbu3
         sigIo34DNkQ9l0TdGVwG6H+iv4Mk4SFIqc3O5p84iIXdobF0Pt7MUKIIOEXzTwKOWlcp
         ygcKredpDhPdnDZOShBDiGNUO7IVvATmQ44J3gBOb62eSZtXyZ2ajAKln0y20Hl6gyOw
         wDWaWM3kVh8djP6VLG/TD2W+CYGRWAk/4fak7v3QK0TE7p5oTqho/F0BI8bs7eFtAB7z
         Kavzv0RXvYaLMaDm0uxk5PiAnYrRPVxYWWgh3qcBj1jTFWtmt6fqbxwyZkvvuHxE0BUe
         k8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663542; x=1788268342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=bG266pvij5dFSGmtic9RGVeXD/YlsN3SNBGuel//IIikIzYc9ixYXE4PWHJhbz/Oxc
         RtFtAYiud6LhvPWUVMbggt9pdDnP4V3PdH0TKtoikblW9vdAlmNBCbMvcx2U5WP8bve7
         8TBp/TW3pcsVOUBCtfkooP8jfHHY+MudRalFPFkyjQIMKAfJ4kTq84mh9IoUDrxFXh6W
         xj4Uz1pzxB5W43477PdD0ub9SskYj9QmBXFBA8UmkYmL3lq7QJFBDAvxCGnDm0zNyv59
         LhcKKOztq//dGJhqjZwMQ7kFUuEu14B1G3rD8kvK5FSR/stWuyoJTpECDVVvPA8lhktj
         fq7Q==
X-Forwarded-Encrypted: i=1; AHgh+RosdzGvINbh6BTjAXSV7XEd8FfchEmssOYNhAZU8M75bC8spuVzqRvs9EW8iKhPCSP3iJn/Vh3YzikdZhUo@vger.kernel.org
X-Gm-Message-State: AFuF++mQSi5sz/cZeUPjsSobMMjKqGzRv6uNvIF1h0JPQxS1MbBl8cCU
	nYGOXuM2ylmCw7POOvfSo/GjIQloYYhZbv6/fYN1Emyk2uMVeRYp7NG3y0o47QOC+TU=
X-Gm-Gg: AR+sD114sPaaxBD3/1Cg5yCFnwmgKVf1nCwpbG0gvFMM/5tYIRwq7Z7Bq+gB5bgaQ83
	bm6savfHaZFuVoFZWBBKaqTZRRmSr7j7ZG+no4WeOCFrlCMMnACN7g2Pqym3RovjIyhYQ9LxlA0
	1JcJQYwqQn7bCKyl49vP1eUO7bi1PpYWXhviaWXHzfQlX2y+44VUkNIBBiZM5IHaBE1BcStOEF4
	NY9592tD4XTZ61pfHTf3z/cDMILJJsvGL+Lrx5t/785Ye6i9+LBIX6iSopDbgns0b1iTtlBwTEA
	cSrUkobZ6tBeotFbmqLHLc5M56ZebQRJ27dtIm9EJWx8Tei8xtFjiDmOgNhA/3uuMMfmIRKoLch
	Y4aNlF6sjKQ9Y2/j2d/KiuWOEuv0xKKEhcCy1xugMPin90/dpW1HC0sFUqMwNnrowuSnQ77KZjZ
	TByT+UzVopqCq2Ah5REw3xndBiUHO1Bra6xBokURsMXJOfSZXZ/Viem3pIhtSBicbcCKI+jfaf
X-Received: by 2002:a17:906:5147:20b0:c25:58e:8d64 with SMTP id a640c23a62f3a-c25058e9f37mr109537166b.12.1787663542583;
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496866c4csm1922258666b.54.2026.08.25.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:12:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
	jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <ao2UtL6-HHTZ6trp@pathway.suse.cz>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>

On Thu 2026-08-06 11:30:00, Andrey Grodzovsky wrote:
> kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
> knob, so the old disable/reload flow no longer applies there. Probe
> for this with ftrace_disable_supported() and keep the full original
> scenario (disable, fail to load a livepatch, re-enable, load, confirm
> disable is refused while loaded) on kernels where it still works;
> otherwise just confirm the write is refused.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

It seems that this has already reached mainline.
Anyway, for record, it looks good and seems to work as expected:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
