Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4F3AE6F5
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788112294; cv=none; b=QNaIU8xpHMk9hKiE8KrtUk62yQ+Iyy/KTYQM1QzTdLcXLkrIQqJhnrpDkFiHAUWQEFr2OS+KM5gohANeNtdqW69s8uMWSP+SHMKv+xB6lvaPbEaJkITSLoURZ1o7a31+36KlhCL7P2MfmjBu+vD4ok/5u0oF2dmamhB97wbUWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788112294; c=relaxed/simple;
	bh=6yCNyhnmBUg8bR0oCM+iXyo1UOBNa8u47k6g5GntGRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfPokenr5afIqU/uzHOGhaDeWX3TR60NOM6j0RMPPalohgNGHqvC7+ZURMknhHuyAfCiA0x+fUL7WSRrzWDD+thRKmzUJut65tcgKCslB16YfIL+hoq9WzQCvEBd6P0ZhCuRK9M6kK3g+Zid4UDFV+K2XuNhdLEl0HnN+JzOO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGGUDNze; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGGUDNze"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2197184a91.0
        for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788112292; x=1788717092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6yCNyhnmBUg8bR0oCM+iXyo1UOBNa8u47k6g5GntGRM=;
        b=rGGUDNzeWqIr++yoC+zL/BDiwAahFHtySac4XdDXfweXL4YptzloLBEz+v7IvkIM0G
         HKCrXZf+6Z4ippBovL0FqEN24yb232Aa9QBuVBqmf/o3pAVu0DlzuRVC4WcD/C77jX5E
         gDtL4/AcVYQlh4fLXgQ+i3+7uZ63i1TGM15S3yYoYtEvGx7zsWwX/xBei1EsSeSsAyMn
         HJ14APNXIl2SZa/Fx1XBbWYkHvdAy2TSKR6/oCpbBJoegH2GO/928bookvbe98pxoG32
         5TfAjwnMR4DrC52x6rY85KZymJaf1/YOVoy/ATWJYOFCyxeVH5eLXrUgbHuV7hGDmd0U
         KKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788112292; x=1788717092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6yCNyhnmBUg8bR0oCM+iXyo1UOBNa8u47k6g5GntGRM=;
        b=HwcN2/Tvj/LMIM2RuPNkrtkDoxDE3nSjF6I2t5d5p2wHW18ym2ah8mpafNFPZ37Mrv
         t9TqNryj5JaGY3L8B5m74abOV8tKswLFcNfh9Pz2w9Xnok1yE2ozmgrP3FV8wZ3KuNea
         86eWbOUmeywtVhN5anttjDIOxoIsP0Z2BMu8iwKD7LCMrlIGyOujYse5w7AMD7Vx7ocT
         yO4sELaheLk2PTCk99sxWELT79fuzBHomk+1QN9+frcsimOxgP7yMAskOBhz+ciUSpC2
         aM4pbBWuPE5CyVpyjcZ2cPV5pmEntn3+UItiETeUjaxpWiXLM+1vQKnkS63GwanwXqzY
         ojsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNBtdSZEvBVDuD00+/Zkk7sRKgfZD04eQemDGlSZL20XUrHWQktG9EbBTNiNtnVlBDBDH2yyRHhCs2HcHA@vger.kernel.org
X-Gm-Message-State: AFuF++mAJToNCWhvQuSUGyB3lZTm02qLTgp1oPu5TJMJVKFzBtOzrxfJ
	Ne5e0fqgy+kbW0z3dP0NM5Ki4C5B5cZtTePArHsD8qvL3hM2miMQRAbm
X-Gm-Gg: AYBFou0XhmUZnziA0m0+M5vQUUnZN90bCnwPFC0KnOe5CA+NBX9TGp+EdjNaJ53dY1U
	RhxZtJDxDHt13q9Msu++oh7F6QCB3ViWgeNJ8GOBSUcy4bZPKxN/x/am+k2TK7RhIqjczcWEpRI
	KquoIlUvsHeDTbaPaTInX7+WR/2L+HMc5X5mEAxIOkfewJ4v6BR9PhsuxrHalZvY8wPHGJOZ6xg
	gSDbt7oFiXC8p2S/9s07v+1vHuAnEp8Lfk+9cyvF17zoONrh90ltoFBpj9UHZsFMDceM2Cpjlmj
	8Fn2PQVYFnLzJY9gywkPnQjGH8OYwySgb+QivPJMmw91BLLIgdlPMmA4KDTl6hviPX537x7dAbp
	Cf9z20bFA/2lsAKMlP07MVZCn3Yd2Pnu9rG4m+DpEWEDQMcjLZWOQKotYg6N2J0Vv2XlCiUhsGJ
	w2DIBatSyhyYywcc3r738f0hBQZVTpikyDW4OyWIYVU6SRyhea9qfcHfxkVb+d2bsYmXbUhMKZJ
	7OI6tQEAcfh0oYU5fMI
X-Received: by 2002:a17:90b:5287:b0:398:9c07:8907 with SMTP id 98e67ed59e1d1-3989c0797c7mr20332628a91.24.1788112292515;
        Sun, 30 Aug 2026 10:51:32 -0700 (PDT)
Received: from localhost.localdomain ([2407:4d00:6c05:13e8:a91f:d3ab:5c4:f6ed])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d6d29de3sm3686145a91.2.2026.08.30.10.51.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 10:51:32 -0700 (PDT)
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
Date: Mon, 31 Aug 2026 01:51:28 +0800
Message-ID: <20260830175128.58926-1-x90613@gmail.com>
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
