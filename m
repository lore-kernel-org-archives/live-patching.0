Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC832375F96
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739650; cv=none; b=e9LN4Yoe1L0Ozwr86f4sUV1l0Y28OTpE0/a2OBhTqA9rwgqwSQugjXkPhCXrjdoKnhkpPzxW8PiThQ9oNF8Lc2YUJe+RLGT3DsNUQv435TGNYQwcJoGbzD64T5r+8x/E2F8bAKX49MnFwS6lm07GpZXNlCgYyv/UqO9FHtr/6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739650; c=relaxed/simple;
	bh=i7ebWu5neqf7RLUCKIA9RW/PHFOCxdTv5SlwwwlE5ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igp4nyrNB6uqxGXDdkOT6UAbNM+166j9ic7mSi97a0ShnX5HtB02eYV5cPSswV3ix76VDYS2uLeP1KrXKuZ2O+pjkXceVMcDpzCuNKXpRNH9mJU912VV1vRRvveE5npXQyfKj+IIzjFm7Iw16/rwXAnyOv99jbQTvGX4cuBPjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN2mW19m; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN2mW19m"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148b5c829e8so3115438c88.0
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739648; x=1791344448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ul06C4LtbXWTeJtLnxK0/yhBu3TUuBbCo1BP3NaOSWw=;
        b=HN2mW19mPP+uG09jadHnrFwd/H9YTJlI1d92WkJDyMzuV3vnVdtxLGk/bKC5GGl9i9
         /tkSHbT3q8bwFVEcyl2k2uRVhvs1KYUQtj2VhXfEnLyAYcMi3YRQYmeCwxYRzI8JW9LP
         AAT3XVy6I2YscRUBTFqwOV0+oTsc8fy++DOhU+QrYFUNLFYw4Ho+tIf8suPCFJIbcudm
         fn0UTdfgnGTLVDRJ8xflu7ZHr3AIzWzyyOXQgO/qA1n1f0VAJCSDacYkK4gzZvXN2+68
         yUcZ22O/iAZ5FAItiZ1buq/sUT1mpqVsXOl0MKK39RQdjeymts9nShbRi0aK1fa7dped
         MNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739648; x=1791344448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ul06C4LtbXWTeJtLnxK0/yhBu3TUuBbCo1BP3NaOSWw=;
        b=pvJlz2Zc70I6BZh4F0qFgmUOtTz6hnbw/8pyrdAoRUj7Ko4IB4PWjeqeY1fccfeWPO
         htzk5hZI3phUwweo1KHanP24FWO57Cf02Fzf0i07bTri41zl3NmKWuVwmDa+e5HI9Qmo
         G7/HvVMhUMeLLYeoZJzFbN/08jE0hAumC5i2P6UZFWocQa5rOTaBlF55QXwR+McOQwEr
         48IOzTGhxNIFDMWs+p4gvz6WJWN+E7qTGYzPdumnQoMoprBIleAjDKr1ULk0qEYKUEYX
         CZeG4nnoi8V1ArNUKoL80gnqJS5wii36lUUR+g5Z3KeeB1Y01Ox6+qHxK6vTlNfcVTyt
         as6g==
X-Forwarded-Encrypted: i=1; AKwUvByUrtayPUHYykktuJhmykesjn85TSNohxp3aI+3FNVwzY5XmDgMzAsGRbrrEtmSW4cXt0tGm9awgATblL9S@vger.kernel.org
X-Gm-Message-State: AFuF++m7l0tKp993vgUD9t7hkpZ7+dWQDP5BRzPflBuAmBsFEMUpwEKt
	mVh5jUQNmhO10mEwuao7TcGHV+gFUFjO/gU28N3DoQYykDIgcsPMX+7F
X-Gm-Gg: AYBFou2u46Cchlb/Dkl4eSHnRD1ya20TKreHReM2PcvtyLRvYHdX5I2Jwi0QsUKJQ6C
	TXNIoiN/Oz9nirm/vwvzEKhvCLZUKTpovY02SNut8csU+QOeKiSI3DsGK6XR3npP+YIAfxo+SbZ
	FCgnGmRKMANCzL2lq11wi7YcatOf/muj5H0O1KRDZrRXyoBEahSxKXpOn2LUz34IR3NzWwQfaGq
	7WdtdClGm4Rh5bX9TcRm0PIz1MWs6JOQcQYH0EpL+DCxcdy+5HW4sWY9YmeoAC05JUQby6B06u+
	t4dFdUdL11fZ4cTGDN33DjybDSl7KfWc2dCCScinFJAP2nKzFR8E9G9MCkB7AaOyFepQg7gCjJC
	xhOnKYOqV2kRqgOh9KlnVDZDgbofy+vmL8m61vkumi1E0SxtscFyzHj/ql8sOwKWsztvmFHXbkY
	3Zd/6m25kXDVuTrOMhsbzcWFJQ5GdGuBybhpQMGp544H/s3ToSA5GxaF7dimkwQ8fznRx+9Stbr
	IZ9r9/JCODVXZCuRGNWDsEo8ggJSXKTNcZlxqGCPv02/X/HeYS6cJH9AiRmw9qu1IOGFmVbRZEl
	Fw+0cYzZw9heaWsi9Iy6IhnIFjr9Ph8x4KSQ7DGm2kVr3JlXtihg8MEG3Sg=
X-Received: by 2002:a05:7022:3b85:b0:144:c113:77bc with SMTP id a92af1059eb24-14c9f40575cmr1947557c88.27.1790739647612;
        Tue, 29 Sep 2026 20:40:47 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d0967e43dsm412621c88.16.2026.09.29.20.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:40:47 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the livepatching for-next branch
Date: Wed, 30 Sep 2026 11:40:43 +0800
Message-ID: <20260930034043.176822-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <alpine.LSU.2.21.2609291211090.18161@pobox.suse.cz>
References: <20260926055219.3678061-1-matthias.goergens@gmail.com> <art_zcXuSXahklz3@pathway.suse.cz> <alpine.LSU.2.21.2609291211090.18161@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr, Miroslav,

You're right: please drop this one, and sorry for the noise.

The motivation was Sashiko, as you guessed: it used to review against
the default branch of the tree in T:, which for some trees is far
behind what patches are based on.  Since 28 September it no longer does
that when mainline already contains the default branch; it falls back
to linux-next instead, which for livepatching already has the two
queued commits.  So the patch no longer buys you anything.

Thanks,
Matthias
