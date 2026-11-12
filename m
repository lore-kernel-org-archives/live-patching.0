Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489726;
	b=zN7s5aEKeMqbfxkTFComlbWbTIiMdaphb41vu7vitdkhf1DbVWAANRBdUUIEcVE7AbgH
	 fJfayvRMdr9Nc96Ea2MCDGHpFBtPOIGQe3JdmNQqHUg3sBZl16gHMqYalDtAJd2I7kVVi
	 7Jc1PXV3Xh2iArFnlTJKE26uIPmbtBx1DJCpwmb4TQLUkvFVwD4rA+sm61FDYz5r+Nxno
	 xZeRDCkdA4Q/R5/JOA7Sq4E2A8rUOm7afAbHHUGIfObMOwOTVzZIqtr1PbcxAxU3jp2SU
	 ZJUulTcfpMDAdxBf80HKcFf2EVXB8F2xS2/362w99JDA9K7Iub5kI6Sj/wS8alEOSqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ptcaQ/mmnVBIFNqVPWzP07HOrBZ4MgjBk8UWEyOzk8M=;
	b=tigR9WBkHp9PKLiORFnH11l4BG1qXoQP2CZ7yCYdSpTLZGjqajy4+CnmdGJCA+jz6UHs
	 9b3bhpDW/5+TWOyH50aNt5Nowe1QlFCULwhQsQrsekYGKxaJ6sUXDb8BPgYRNdtSw23Ut
	 09yBpSfBRWOCor7nvBgQW5pUvVhVNQZ2p15uroSC6l49SCmQu9wc0ZSgJQx14VLEp5aCD
	 TQ1U8s/TKCIQQUJj3abdPj1GipZQ4/IH8c0CrMF29pe62ZxyS7ud8t8npYUTnur4uEQA1
	 NYDFNJU7Ugl6ffnkcq40/IcuwPobctJPCyaNExusO1CL8STJR1mipZf/Z9c1c2kO+3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Fl8rHSU4;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC9606A321
	for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 13:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ECC9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Fl8rHSU4
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so34048885e9.3
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 05:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794489725; x=1795094525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ptcaQ/mmnVBIFNqVPWzP07HOrBZ4MgjBk8UWEyOzk8M=;
        b=Fl8rHSU4VjWIvjTqKm3mv07NYIN053QH09rrgXb21gDXeSAV19IX2FEGejdMnlakW6
         jAZBU2j66p0SGVL/kSbpF3B4hQQEdEsKr8ba9fqR2phkGt4cROZNQVjBDeYiEZd1rt7c
         wd24DJLpwQZCMOYXTemmZ5rN1UDZlbqgucngtWShhcOyT+piSlYMivamx7I+GHrSCKDp
         8MHlinV2bA61Zk8sz1P+75U8bsYh7aHkwv7BUKykTS7L6NPj/3IaMGEG2vpSfqmM6n1a
         XI7MT04UzMAQcNG5W1zXlmvl3ln5ixGwEjPkhgm0Ka7O3n2kNbHBTPvVqUUsTcg/m6h+
         JYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489725; x=1795094525;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptcaQ/mmnVBIFNqVPWzP07HOrBZ4MgjBk8UWEyOzk8M=;
        b=SCzRAo+i6wOdxpBTKhmcDerqTu1xqp1GFKz8OVTto69BBPWOiEIKMp11rwoZ5sGWHU
         M/Cm/v9mRcHTMK//9wh59rTNQjcBUw0IhtrFiFoI4gDvuSv52wkJfbbIoTNuzwQUeVco
         G8EHJFwAkbbbp0RonCabnk2w9moEMgX1kI3I7giYuOX1JJO0HWet/Zy0TwXdxYtUS5YT
         sgQbEtePe3E2vrcJqVx2sVER3G2NhYOsZN4tVC5Uh74CtNJ1XwdgMtMzRgC3qhYrgBxR
         xhiyaYOjOxX5XQ4aAm+YZxSbY8M8zYdqqOgOktYWfcACP5a1psZepOxpTCP3G/GZ47jX
         op8Q==
X-Forwarded-Encrypted: i=1; AL+hErF5PyWAyBRcsrOcwzuFU+wMABKij0P3m0YXIEwkGRkjJk3gG5FU8h4qCXVJIh/hyzZapxS02uA51U9oon5y@vger.kernel.org
X-Gm-Message-State: APuU4Z8/rqTc4ylarZdy8138FHiQjK5FlUd3gXZ1DauooUj/FCvdqF6r
	zl91/r3IPmh8pfrCBZ71ylcbtURdc/koOKjXDFDHBiveqNN4SAwDhB7n3O4g6PjikS0=
X-Gm-Gg: AYBFou3dex2TorOtFode066NC7q7V9gGT/tQXdjna4i9flmgClMLTRp70wVXep06VDe
	X88F8WXIiuPodZnogkMJedPyAkjrdDTjEKZpMfl/n49C+ydWo2Im7ZsV0NBCaCqAHxbR3q1BDqL
	6xVWU0LZyE9tSH31M9sGaXJaF75hrDdeEkMO5p1H3Gyrk9EJNpoqsMNr631pdrjoS7J+UfGjcRU
	fBezgAbBRx28Swhb4uxAQcyriD6KL5eha9bYlnd4XYXaTGArmSl9jHGomv1d3T+y4BbgxhJFwrU
	C9Hxb8kbrfkNgfwC8N6ymq7xuzy15Lt2UyROZEwQsR18XvSEkjrOs00JgX82h7j709rPiIMY2Yr
	Cf1UnQBtu7AfznVFJLM7jqVZ8t+iRGH65NpwwSDMBKLJGl0GMNJIuL+ArSBXgXEAPkFy981L9di
	OVnEuGVlNdrh2GJ8wgxqVBEzDngo0VVH6KCK5lXiBjEpxzOIzuzr3vdJSxQmbQUZKnDSJ91urDi
	Ui6Wy3Bh6WHrzmFeHV1ih95IRUed1EADO6/c9ZCiD/AF8HeZzt7vyI0XbXdQ4ZUiggV0P2PjkDs
	V/20ji9yyXPoKY7rWqn9e6QM3fmuNlo=
X-Received: by 2002:a05:600c:871b:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4ba0938a51cmr105848555e9.15.1794489724983;
        Thu, 12 Nov 2026 05:22:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba09536ebfsm131726935e9.5.2026.11.12.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:22:04 -0800 (PST)
Date: Thu, 12 Nov 2026 14:22:02 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	joe.lawrence@redhat.com
Cc: mbenes@suse.cz, song@kernel.org, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/9] livepatch: Add support for scoped atomic replace
Message-ID: <avW9ehNSLH2zcXMM@pathway.suse.cz>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
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
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>

On Mon 2026-10-26 21:36:42, Yafang Shao wrote:
> Atomic replacement is currently all-or-nothing: a livepatch with
> "replace" set either atomically replaces all previously installed
> livepatches, or - with "replace" disabled - it replaces none. There
> is no way to atomically replace only a selected set of livepatches
> while keeping the rest running untouched.
> 
> We previously proposed a BPF+livepatch method to enable rapid
> experimentation with new kernel features without interrupting production
> workloads:
> 
>   https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao@gmail.com/
> 
> In the resulting discussion, Song and Petr suggested that it should be
> possible to selectively replace or skip individual livepatches.
> 
> This patchset introduces a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the replacement scope of
>   the livepatch. Livepatches that share the same provides id replace
>   each other, so at most one livepatch of each provides id can be
>   enabled at a time. By default (provides=0), every livepatch that
>   does not declare an explicit provides id belongs to the same scope:
>   loading a new provides=0 livepatch atomically replaces the
>   previously enabled one.
> 
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different scopes.
> 
> A new livepatch atomically replaces any existing livepatch that
> satisfies either of the following conditions:
> 
>   1. it has the same provides id as the new patch,
>   2. its provides id is listed in the new patch's obsoletes list.
> 
> A new livepatch that does not replace an existing one can coexist
> with it. In this case, the two livepatches must not modify the same
> function, or use the state with the same id. Any attempt to load an
> incompatible livepatch will be rejected by the kernel.
> 
> Previously, setting 'replace' to 0 was the only way to keep
> certain livepatches persistent on the system, forcing developers to
> disable atomic replacement entirely. With the introduction of provides
> and obsoletes, developers now have a selective option to keep specific
> livepatches persistent while maintaining atomic replacement capabilities
> elsewhere.
> 
> IMPORTANT:
> - this design deprecates the traditional non-atomic-replace model.
> - the behavior of replacing all non-atomic-replace livepatches with a
>   single atomic-replace livepatch is also deprecated.
> 
> The new "provides" and "obsoletes" attributes are exposed through
> sysfs and the kselftests cover the replacement and coexistence
> semantics described above.
> 
> At present, KLP state, shadow variables, and callbacks are not
> integrated with the new provides/obsoletes mechanism in this patchset.
> Support for these features is deferred until Petr's klp-state-transfer
> infrastructure is completed and merged:
> 
>   https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12
> 
> It is based on livepatching tree's for-next branch.

I double checked the patchset and it looks ready for linux-next.

Just to be sure, Joe, Josh, anyone else, would you still like
to review this patchset, please? I am going to commit it early
next week unless anyone complains ;-)

Best Regards,
Petr
