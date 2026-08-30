Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1E3AE6F5
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788112305; cv=none; b=m5bS53BORSyV6tvKBeipDsPULuZIAH+RmbxcgfqZDlTf8PDm6Y7+hl9J0ZHLEmrQA1D8ool1IWrMbF0jpedpzX1QzNx4BSI9ACFuqA/w5WpYcNKS4gcJnfj1iAZnTQOMnyalxXCY65HNg50Qtz7qrblL35E4XuVx9OGejLmFvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788112305; c=relaxed/simple;
	bh=6yCNyhnmBUg8bR0oCM+iXyo1UOBNa8u47k6g5GntGRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAqfxeEqC54/9kxf31hrnMt1iZ5UmHSE3wS3OW9mU3Mcf3Q+YWxQjWa5h4+FNgwl6hyDfxzaa6DgXDeOAj4jN1dOAA6/H1zN22u3Y/3hQtNF5ATNAPNNeBXY4SnkMxDmuoFSMR/JYk9shPXGTjMOPL0DiGldqiidZBvojM3H8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0Wx7/SL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0Wx7/SL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d712281f8bso30139605ad.1
        for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788112303; x=1788717103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6yCNyhnmBUg8bR0oCM+iXyo1UOBNa8u47k6g5GntGRM=;
        b=U0Wx7/SLuGS7jnsHJYvYjVFehYWG7aW5gZnI0GEelsBxnBPD+aG53s433X9p5/BFJk
         XThFwFTlNhtvNf4EZFMlccdYTJb/vEC2F3CRR/bk0xI9j+ZHF7LoLP4N2Id2r4o/siJ5
         VQzkIn/iYWvlxpu3FzrOLL1Bcm8PAZgnCtWI3WlKGn+QMYhu6hRRYLePV8JBCVnaEQJb
         GXOPnKnPoeTmAoSdRZUrhnThR0k2sLpcEe5hz7c41d5byeDxPKt9H5qR52qIlkkI48C/
         9tWdCiDDdBx2+ORni7We+dkNU6Gm/0w/8CaDwL5HCc8SC/hIJy4lxsOmGMlcRHNGcL3G
         Ceig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788112303; x=1788717103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6yCNyhnmBUg8bR0oCM+iXyo1UOBNa8u47k6g5GntGRM=;
        b=EuemjefkT81EqtiqbfUHRCbBeAQU8EN9rinx/y3wnI0IcyhKCdVQatENWZby5F4j+L
         hSZi2AZQmoLKBO9/a5ObkFCffyBajaDK0dgaMF7V6mh43H1imH7QaiiCENJIZO/95aLh
         IbplTW3SA+EVgog685qT9siDI2Of8HGEUGImltuDMScV6FbL7DAwfIP9SF9avn0BQshN
         o+K5DyvP2QH21ekEbRbmTvUZF2vbGuGQYIunG27QbrJTYCwVfUrICuFPimHmGFgQX7uT
         2sQOlQu/SJqA15q6cOB0Rrk2AopCXVLTjt5kP2lQVCd/HeyHXAjVa5BcU4fouVCI3dMJ
         VHtw==
X-Forwarded-Encrypted: i=1; AKwUvBynRy86crZIQ6scubb4eW24EuY6otNE1eHn5axZ96TC1jjD/yf/IsOftCWtf2Z2mQYDCfeIhfg9vfwhpOnm@vger.kernel.org
X-Gm-Message-State: AFuF++lkcNUhHjfIkqwZABMSE6T6h8DT8vvde/pfEEBGEOcVwz1Mh2Bn
	MvUkJEDSGdeOg0VxtQYgYgrbFC4rBlm4MYH7C6W5aBCjjBarYKlUX4cJ
X-Gm-Gg: AYBFou2LIcDFi/ve8jvCZht6G4oI6HoI0n4H9/98m4pfs2iHQtu9XctpZkFYSHPrARC
	K2wohxgOsudPHg38AzTGnbyVoG5WayOLdAa/nYJjSAIoEIBGSUNuTRcH4dbqVBbQWZCeEvny//l
	xWY16OBC/DPXHM3kFswlSQjvrbThS22koVd8UaSmGvQ4JUFHebTpvpAmIrMbLbngkhHaXZ6mfr/
	zjx5J1IUH2P+VaZ0Ov+ZKpWlulhr0+wq7zG3LfXAty+0LYYFTAD9opZqMzlMrXEP7gdI6AWAhDF
	kQZCWIjd4pgGZEiVVbjd9yPM3fOHUjWdBJf+SOyB6JmMDDdmw+gm2LJggD5ofRMbufu91rUP42X
	1xWQy7oWZZAMaLRVo8MMbqBaRP4hjpBxyzPoJfPj1Ylndc7FILZ/6CPcqdfYGG+qIiXC+/LLgkE
	b4424pe6adhou8DQZnh4zoKOIgnoBxqKdFfrdBskAb+Xh0Zzc55TX4r6PXmN3hyOJnyAjQgp/JP
	YeUdR4pure52MLxKfy8
X-Received: by 2002:a17:903:4683:b0:2d6:efc5:c82e with SMTP id d9443c01a7336-2d74dc10522mr293583655ad.1.1788112303561;
        Sun, 30 Aug 2026 10:51:43 -0700 (PDT)
Received: from localhost.localdomain ([2407:4d00:6c05:13e8:a91f:d3ab:5c4:f6ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d90e6e10cdsm8752045ad.14.2026.08.30.10.51.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 10:51:43 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: song@kernel.org
Cc: pmladek@suse.com,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: Reject livepatches with aliased old_func
Date: Mon, 31 Aug 2026 01:51:38 +0800
Message-ID: <20260830175138.59014-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPhsuW70RpkZ1ciioSjt6qkQePWyeic_L+98d0h-Ao3ze-TmkA@mail.gmail.com>
References: <CAPhsuW70RpkZ1ciioSjt6qkQePWyeic_L+98d0h-Ao3ze-TmkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 9:17 AM Song Liu <song@kernel.org> wrote:
>
> Acked-by: Song Liu <song@kernel.org>
>
> Can we add a selftest for this case?

Sure, I'll add a selftest for this. I'll send a follow-up patch
within a week that exercises patching two aliased symbols from the
same livepatch object and confirms it's rejected with -EINVAL.

Thanks,
Harry
