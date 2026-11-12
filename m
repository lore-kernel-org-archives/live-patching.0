Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507548;
	b=AmyDboYb+vssFABJfR7L8AtZdSHSjQjkV8hhbUJtmdBeqt3v37HEu0ETLuCgYZv9K0Ja
	 HJn9Za10ult4vQ+usbop3UJjmHjAR55eawb8FAKsQVo/OF18SnJDQ+2tSjC4MTT6pvIvE
	 nMX5LxAofhUMalbKmYWOty2I6ENjj28KLbvcV5D31BZQu7sqQQKahK+HZNjn0oMhj51wl
	 4+iq23LjGLF/dM0qwrbse/qBtKs+wpR4wutHlulJPeQ1fjNwyvbcOoZqN6G7tHmkg3bqK
	 bdqr1m/3syX7CFNXWXVb0aEsUPn45J83jA/QHspEDgK3A9cOwDH0bbUYoqIgDClka9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hB0gGU6/Wvj6DY1CIjnvdF3luMseLxUER3Q6hRYFMuA=;
	b=WCnSJK284eYl3tjZNQekZlecjnD2vnSGAxNIezY88QcLASL13ft+IarVt35aNHXeVvGQ
	 ItYeyejdYmyJrqyWjenFS6i0h+nrzh0BFD0xAaNzJWPRe+bpbw9KLPGzDHJgeUc14Wj3G
	 xt6X/HFo9tuigGopmKthpm1h6EVzeWf8y6kzfTj1w+vREiPp4axYubcOFCDOOblgM2dWU
	 TdwkG/Eg+jRZL1Xwvny/iYkkJhyVSKgLLhvqH1xg36NvadOD/EL4j/l8pyupBuNUJ0H4n
	 QbxSwipVG24PIFfhJrPNH0TD6nuDWvPdfCmIaGOP0vUDiKs17B0ddHZYgyBtppINggQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEzGzzhe;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCF606A327
	for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 18:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CBCF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEzGzzhe
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so1322255e9.0
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507547; x=1795112347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hB0gGU6/Wvj6DY1CIjnvdF3luMseLxUER3Q6hRYFMuA=;
        b=aEzGzzhe6EMFNOvAc8cfQlCBSeL+1K/zjWgyK5EZg0KOfXRvCTDR37DN6Dvaxui9Jy
         kEyTMJCIJoM3sImYaAyUCu/k9QIQwhVdoS90OalO4Hs4hhRPcJEvLB09db+cU40pUXV5
         drlxgDiARYvqvqh1fag3LhNQw1dMaZ2wnvqMS8k1R13dcPnLeiOXlKWwqjtgWblmifpq
         y/WADavmJRtrqONZx6E2ynDb0r5XYhApsRbz2dpQ8JMe4c6RiphErUvuVS4pd0LxTRK5
         DrMPuN4QUkEl1rpwRIn6qwWSb1mJQz2GPIgQboD3O5JNtxt137JkEgUXNCiYp8pr5GPs
         d4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507547; x=1795112347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hB0gGU6/Wvj6DY1CIjnvdF3luMseLxUER3Q6hRYFMuA=;
        b=0V/49rfl435+OPeJ+ntIV07BIfpbIRXPDDeoIIzdkjWVBEDiw/m6cZAEZ3JDCeBQae
         PQBPl1WDDQxrl24znOBoGVYH23lJIITb26+YlFgrMjXM3g1k00k5Y3FDMJ4f30R/EBpL
         XmtlPumk+Eyb8r0YGpdz4GrWWcH6lCAnTNhYxkiTkgrJ42WOx6LbWQX7Z7Jpm9eSR3JC
         VADs6bWmAuIIJ/n+9rFtCfBAOG92aYooDrsa0KKy73cD+8bgbx4N1dImj7prmFR/7W9m
         C3Lo8wWj5Qq4vt5HenEMioa/ysCTTJVeIJjqfPX2dlWuqd5uHhiP7ZyQQyscYGzS5xrA
         hOaA==
X-Forwarded-Encrypted: i=1; AL+hErFUxF32YBdvayI4zlkabkTcf9q9aiVnLc/Z1QC2eSdlWOLxO6YXloI7Uj16cGZLEVJLnPxKNMhMKEAwwBqu@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bs6dYbOkvTYuLjhhx/9HA5TlPklcqbT7c5z9VsKI1yzikpy5k
	gwVQjxZOXgZOAcoJbbxUc7siRsLBQd56srHgTaNs1oXDHybC/LtJR2TQ
X-Gm-Gg: AYBFou2X/ip1MtYNFETpGNEw2QHAXsKTr/51NrUy+g83YJNd/F5LI6tU0aAZOgaJTOp
	/IpYjJXdl+hdpkf+x/qoLbnGfalQkmkcDsBXZG7tAyki1JkYe/9r0vwUBy00n497w9jmipdZOLQ
	Rs74A0up1PkjsAo2LQwXq5dLk9LOEStrSnC2azZJ8TstFObkLOq8yZFW2DW+x4DqJ4uK/+NqwhU
	M+GRUejUFV7zietGZL5xnBbyxbJ7JXDSpTiJ75fstMOIWvCQl3MFalbcSa3B5Q6WidY/gyU5Qtf
	MqxT96+hA+7ryTz7szMuaqqYLRslntWl7N3wL9hoZDya4768cQ99z0PItWkhot67DU5KbW44Ks5
	73b1NKzUiTXlcgeGSMhoc+2D2tAir5Vp+damIrJ7YU5wu/oxNwQAbA+TSxiaBYmYkBCQGP+ubIp
	lHAFfkhm84DULicec8UTjqbkmH2CgbsYvq0khqdOktHZpS77dzNhR0rVmWjAWsHr89d8aNpO5Ay
	QgXVB/DM2ZdSge8/W9+ne5uEuz9oWsE4tUqukU3HulUlOLozG2fbL1hz6ZskmyolxvtecgvlUH2
	Rixy4DdKHW5TMCKoJJwITyiMxy7+F6tkrdmaMZtkATw9FXEZGMmY1GQZnkGTlNcckJPOCYVAIzE
	Z5w==
X-Received: by 2002:a05:600c:1912:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4bb55ad45admr76185e9.35.1794507546798;
        Thu, 12 Nov 2026 10:19:06 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.56.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e27a8b0sm87629935e9.15.2026.11.12.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:19:06 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: Fix races between stack check and module load/unload
Date: Thu, 12 Nov 2026 19:18:55 +0100
Message-ID: <20261112181856.234172-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avX8UWAA4DN44p6o@pathway.suse.cz>
References: <20261022134433.3595212-1-parri.andrea@gmail.com> <avX8UWAA4DN44p6o@pathway.suse.cz>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr,

On Thu, Nov 12, 2026 at 06:50:09PM +0100, Petr Mladek wrote:
> I am sorry once again for the late reply. I hope that you still might
> be able to handle the feedback and eventually test the simplified patch.

I'm not planning to pursue this further, so there won't be a v3 from me.
I'd be happy to see you, or anybody else interested, pick this work up:
please feel free to reuse any part of v1, v2 and of the reproducer.

Thanks,
  Andrea
