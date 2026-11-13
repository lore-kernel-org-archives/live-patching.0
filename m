Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794540355;
	b=y9B8Je61qU5zbitNjPKlfT4UI8r/qiy+HTgLWMGWljHRYqAcOZi4QouYSsXkZUBpqHUG
	 toM0TiGcgzsaODlzMGA4UzjonJ1MtGhiXIywM2Nn8yL788D9r0ci0deR04uwh1JxfJzw6
	 HQVtlaNZ9oEf1H6aYBxrYzog4LFv0bW1j6khsiPbo6j9TZfkOvJItB9LWNIgX9uYbkevy
	 o6/AbnTQ5zZctATcKzscBpk6EG1AtnLQMycpuNUN/sBwSNQb5tpX0f34bIqSzWdXX7Ixc
	 hLH7I4MboNzQpgAtN4AcPOLmSrQO5mhu9AoaUhniRIu3669Cxdv0EmYu/Fk1RduelHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=aXCJsCYj0PyBwLDRuwVNDFBGr1fh79IyzXO5yeZz6ng=;
	b=b7/UdUIHZAIcz8SmGD4+WsbJvk/JdTuGMLqoXafRWOCMfGMrQTZFsmy9eOBABSS+EUC0
	 0n2zq6tMQSeKub7FB1brARU+P61X4lUZsz/Obpt2nAJzbtQEpbreh9y1L7JuU2kF89CqZ
	 v7I1wQHY1Qbg+qPPoyczXSF3Ql2AAi+XbVQO0YR6u40a55h3lHkjfl74pBOJmCkBfDBWy
	 0vMJHSkY7QA7ajNm5uJAioDmjwnUUyDcrYT6bL5xeBlxocRRNRBNlR6iwyoeKJc/sjKCu
	 8kjhOcMpxVSHR6UQNOwzmZs2M5Sfp13LfnvjU4r8HQJvYfXT6q3bNRFMGKxjMaiCpsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWyuZh9n;
	arc=fail smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C1606A321
	for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 03:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053C1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWyuZh9n
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67bef25eb92so651870d50.0
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 19:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794540354; cv=none;
        d=google.com; s=arc-20260327;
        b=hjkLMe5StswW/zCpCZAYsAIcoo8o6pYA9ANCiu6jgGqmz2xA8qgUBP1dpQypjFrC1c
         QMQ3GDcNYJCFa6XbUbUHtoCvuE/noACyUOeSp+kYDe9buw5bD+nZJIvQDenUPMt8j5V5
         idO31AL111v2yxX6HUlIXDeI24ZaRKYi55qllek3Wm1mhrQ9+7jPMnRZwKeVJ9iW4Krx
         g4Ynbey7Tlt8lmzPXMheX43un5kcxSvgDinIxV5HoncasXzq2Wtd+/TLuqBzfEu03qIF
         NS4CSOTvWpmARnZo49YFmAr9RiKLic7vCbKXnUAn1xqfnIJ/M6hBeSj6ccli166MU3lp
         knDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aXCJsCYj0PyBwLDRuwVNDFBGr1fh79IyzXO5yeZz6ng=;
        fh=5l9AiWqiWX3wBrJBkKAEqU91eJC7VuFIeBf742he4QE=;
        b=oSVOWJhBHKNZ2vcBw2fX7fchzj/e4KoAKF08D/wmNdYum46mlgzG/L6rm/75gSsa0e
         +1lUBWal3WmFnWj08IYtegRIvH4DFsxhdZSXqXyS716NMC7o1OATfEWHchV3hm6S9rRm
         G1JibwxfBlK/I5FVCcDPY4G5OfMimKd4IkDqrXVyehp1QCCiugPUmXWW6qZy4Z2sFynw
         CzcSF1VQUtH3l6fw7mz0kMgnlUsQaKUTwwjImEJUQwGOB2qhereUPcGrL6BwT8smP767
         R3ljZfmkYtUj/VEgDv3RKYWcQgr3RTK+CrgdHBy4RU6ZDJoM09OX3hRosygMhfVw3HAl
         5/dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794540354; x=1795145154; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXCJsCYj0PyBwLDRuwVNDFBGr1fh79IyzXO5yeZz6ng=;
        b=rWyuZh9ncAL9UrhsASQ33vhsC9Ry4vF1V+wyYFaYkPdLxpSxFJT5vlO1kb2cmssnUI
         +faioBCB0OiH3o/HudNp3OTfkizChiyGZyGzBVvYLXsg22Gq4vrSVZEGAHmQH8hD4vhc
         V07kQEQPCQA9sJS5vKD+3KvPKRBDBZXDDO3bema3tcoFKeW4U2Ys7NVZ1EZZ8+tjnzIX
         4tsLv0VFJrV0XC6WtW//Uy2bVQcjI2+cASO5GvUWtpyws5pFR8KqRpiGdmVqcL1/bKIi
         olv0lPnC5BhDkUSceZxB9PL7zYP3cY1CpwmqmE230RE/mdwWfpU2tl260lHyw3yKC0wF
         p5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794540354; x=1795145154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aXCJsCYj0PyBwLDRuwVNDFBGr1fh79IyzXO5yeZz6ng=;
        b=FdnAkwd2QZAtSUIA0vTuarIR7xyD8vpVr6Vu2PUk+luWtC9uPt6jhtNuJlzOQP/QAT
         2LN7PYjUcE9cTk+BVE7EUT5aEkuqAXiXbv9O6aB3z1A4GvW1xEf9JVSMw+4o9v1fjY2O
         vzVHPbmCQQQ1A3d7wouCI79Z087vM4YPE8xDEsES8LVLjxKi2YQKm//58kMOVeXmMZ0p
         K9UDpvs3FoxTH0Vnm3lETnwDKiTCapHsTHwDX1TnYs2JKkrWo2SQg5fIadwh4jCAxmRh
         epr1DdWnTMcd7w9W+kQ3D7kOKaUbiQtVN6DS0DAznQHGPuJxoLN2Dcd+8Ap5WdQlGqno
         dNOw==
X-Forwarded-Encrypted: i=1; AL+hErGVO/DHaAZRRNVTAWgEWigSzlqDQpP1zwQWJxnZgEzc4/q22CqWiMslpcfzBAKwXhqo4x346Jqa4wK/Nf3C@vger.kernel.org
X-Gm-Message-State: APuU4Z/Mf4jofrN50dYWrFkEJ6HTCNlAsy7pTZX923HhDnIYhvXY4bfm
	lV7ARzNqqsPnJUnADgeAeboGL8oMBIJEJ1c38RBSukILBISJzUZXg6tVfkfuD7s776IE0M31K3J
	GxuANciSBMaiyAGxlEE2AXwmgFFmzim4=
X-Gm-Gg: AYBFou1XKad2b8QB/Es8Z8sikNdcvPrpvJMVB8Jv9Xpl+Xivw91tOXYIvGbRoT3QPgq
	fj0oN67SUW1RpIVBKEiHO52uIQrXLBPJrtdFnybRDc6fMBJSsTdRz4sd+0WWjt6KLZFgFyC/Oxh
	B0BYk0RSyqmTrxguEq8ncvO1nkQ4pc5LLEhoub78cM35mNL0rgja8t7GkVwxvkh0lpyK7RmNR9i
	edYOTpb+uoyhvdITPJuIiQV6D/vhZkJdhIzXTf5fPpALhVnjf6krrrZTe6li3qQEtc82KI4Lj/+
	8NADSQ9dkIiyvjVxlql0yof3J7daqyrVX5J7yl/O2WQyj2Ka+yIOTGiGM43WpB/X7kJPaqmT0nK
	OfdfSqbsMamGn6v9wzh91FWjeUm8gxwiEnJJ5iFhrZhTgUic0BkPsPo5p/6o=
X-Received: by 2002:a05:690e:1697:b0:67a:6b2b:b851 with SMTP id
 956f58d0204a3-67c7907e144mr2968859d50.40.1794540354022; Thu, 12 Nov 2026
 19:25:54 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104133158.3187525-1-luolongjuna@gmail.com> <avZ20mdxRnzTPY4c@jpoimboe>
In-Reply-To: <avZ20mdxRnzTPY4c@jpoimboe>
From: Longjun Luo <luolongjuna@gmail.com>
Date: Fri, 13 Nov 2026 11:25:42 +0800
X-Gm-Features: AclHuK__CJ53_9mRKoHEMyp5nR9AtpphyE9a9Wbd0i2YCf9S8k8HQ6zn3MAuAnQ
Message-ID: <CAKL4jwXwgsjrA2d64bh1iUD6nZAwy5NoCyL2i+EEmBB=dKu2jw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] objtool/klp: DWARF-based cross-build symbol correlation
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, live-patching@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Understood, I'll follow up inline on those threads directly.

I sent v2 out as a new series mainly because it covers the next layer of
the design: v1 introduced the (source, scope, name) identity, and v2
builds on that to do the actual symbol matching using checksums and
reference context.

Longjun
