Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4383C4565
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032746; cv=none; b=EhbUJxjG9y4/QZC6yuQtyRNMy/O3SI14ml6f6eOItl5zeNXy87NwJMLF8dctDh/emtiJRCmQMJVjpjXfD1gwSR33GA3tjQtV/uZiatuHZo8toVsxWQMApRa4+aseIDiXU54uuqZKI/fsLH9Ex/RIxxdium3ZHnnILUyxsI2wCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032746; c=relaxed/simple;
	bh=mNViGZ7yxzB8+8ItmsiT3QQGyqYZhT8Te5fHGZVLVhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tipy+g/nzwHh3onpDDeNMJtM1NWbAo72dyguNpfp5vJhHILeOmaQD/7aKvqVmO1WounQFTfseGH+7SdpzSz2oWpI6QhlL4dypLPxy2XLmHx0uEFHkVkN4iKDDtit9f8ZMfwwVVrLqGUv3e4Tre/k43ADcfG5NLjsysb6lnoXxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+2PUUHD; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+2PUUHD"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so8754505ad.0
        for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789032745; x=1789637545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xb297vAYZsYBQ8+FvK+mZugedKKuZrnvDZwoe982/E8=;
        b=l+2PUUHDRABh+h+TUqMPVVlnMMlZg9zICgaAN4mzsYNoejKD0Q4WzMtuMSy6W/lrpX
         cyzFze/PzDoG/9lKX+KrqO29qO3TZMjMEHFOMZI7BWBQkr0LxreOh9ZJRK+rGLYCd54r
         YrOegc26HpGbvrbYSTKreeCGj2IaQgT8JP7AqHPgIYlElvo7/9xYOHNoxIk8lVU0MA8H
         k0X1RNu2gR5CP9fsOo4eriL7cpJH41t06JC+p8f2gPQYljDBj543n3V10Mkvs0afjkCI
         5+0PmNI4bHra1mYrF+jpDOJ5nKoX98+aCu50EDSCUx3DMJZhn7+5XXsx69MCzp5YNMQF
         sNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789032745; x=1789637545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xb297vAYZsYBQ8+FvK+mZugedKKuZrnvDZwoe982/E8=;
        b=ffEa5FTGBSfPiXZccYopJODWIu6oVqoRJxkbB/PFXUS575PtIMC7RYi6N1a4ONml1z
         2S8mqD6e99++KipPB8Mw5xGbU/7JnROGY0ys3hEau36ocxPn3ugkTEsTgUzWXB8Z1t7s
         mpqb4Dw004ufYWqtP15kJeTxLNrg/dv7W7DZQALGOSMN4ZGKWr08knHw3vAD5oGpTV1N
         cPQBhCsovMOkIQZ4lHKCwyfhStQB22xTNH+doRInnAH7/NrvVAjOTsoElGATOPpLMaQ7
         OoHnfhq/bzUF7ROp6qRxfQkvoN3HVruxUMzcPX3mB6RQ0+usukXiGvrsLk342OTMDFv/
         VHpg==
X-Forwarded-Encrypted: i=1; AKwUvBzaQjd6PjWHSf5wwyzNEZm8WuqBVfMBHpdzOE9E44mS68hy2eX4aScdJzksnBSFcW8qSw2EJuCgCbML3RHW@vger.kernel.org
X-Gm-Message-State: AFuF++npUBFs5gVEnerrioHLZ7dmZ7p6QWTDkFV7DIqAgQjPznVD65Ii
	cyiyIq7BIOfNqgrrTLDgIrq2zsxv/Kf0MdvHkTJFbDSqBsIi/Yu/vScL6hUsQYHfT4c=
X-Gm-Gg: AYBFou1IrDb18/qQimhiZG7q2Xw5pElnuw3ZLMgHhSBP/DPqBkHYztgrCS6iaG1eN9E
	oidjOhMxRmYdovopKxFRyWtrawVXsi8Q/mJ/8OqvJ7p+aCGDl9StICSCKEL9eH+wn64G+RmSMIS
	oBlFVB6wF96FjZE53Rw/zna/024vVxqXKEIdhFVhu2Xp9TDQULY7mK9yk348BXawAw10b12oNCV
	qNMaNe1AxaSj4XRtWzSNz0pGw+h5ymKbxh+ixxRgHuLhoJYS0YxYq17u50pyNDqOwFHsRlQahpr
	QirR49iDy9PHMsJfF9o0TcRg+p7N0hEUIKgdmjfaJWq1iOsMnrujf1ktGu35HhH5UQg0yrV5NpA
	ZN0P9NwsAA/qyScnmH/K2S2rUcZYhSkP4j1rRTQ9YiI+Iy2D8UwwsFovB2Hg0HPYaLuKqk/3g6T
	RtlYQ26daNpHtWvoQ8XcZDuUGbCR2rVVA9faDNPkjNVo1aBt558C0qOxBohrUQHONSt0IZWuPOM
	QumYKRPgOEltZH6q4dJfCKueveTCwRPzWsA/aYe
X-Received: by 2002:a17:902:f64f:b0:2d8:d4d3:da4e with SMTP id d9443c01a7336-2dd07dc3d74mr101752395ad.18.1789032744570;
        Thu, 10 Sep 2026 02:32:24 -0700 (PDT)
Received: from ANATASLUO-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1982c63fsm82958125ad.42.2026.09.10.02.32.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 02:32:24 -0700 (PDT)
From: Longjun Luo <luolongjuna@gmail.com>
To: sashiko-bot@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: song@kernel.org,
	jikos@kernel.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] objtool/klp: Fix missed changes to same-named symbol references
Date: Thu, 10 Sep 2026 17:32:17 +0800
Message-ID: <20260910093217.85336-1-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910090204.B58EF1F000FF@smtp.kernel.org>
References: <20260910090204.B58EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Before this change, __checksum_update_object() received sym_offset but only
> used it for debugging output without hashing it.

At this patch's base commit (50d05c7c76c9), __checksum_update_object()
begins with:

        __checksum_update(sym, &offset, sizeof(offset));
        __checksum_update(sym, data, size);

__checksum_update_object_symbol() preserves the same offset handling,
including the unsigned long type and sizeof(offset). The difference is
how the referenced symbol's identity is encoded.

The same &offset/sizeof(offset) pattern is also used in
checksum_update_insn(). Any host-width dependence here therefore
predates this patch.

Thanks,
Longjun
