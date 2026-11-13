Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794542325;
	b=p/af/OjFN2+ODdlGM0lxYbL5+iPTxlfg8eJa7rCXWmWND29fy5zE7nTPHZxoZ8dFvXuq
	 Eg+JqTfoCtH+7p+75/a8ehGiGzergO0PpB9cOUcGO9evGd7u3pVBUHlVZJ2YjgnC36ekr
	 1W9xxYHYVxck98T0TPiljQ89carULqAGi/FdSOT0xHbyTsNmxoiP1f/5NYHkSGd/E/m10
	 igj0hiwmTOCI51KzkEeSS7tkOWc1lS2PU2JglS02aW6J2S7nnvzbD9Bdf7zawGjJLXnM2
	 LPjL1WoMvU3IYzq3ZJtVXhUr4vaBkpmEY1qUY37cFTe/d4ltY9bmGbYgZs82Qzah1gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IyGhQCaD7T7hQLHD/OB5uRedIyEFI/0GcnFaq+FrCgw=;
	b=ZTxauDstYL/wo8S90EtrZdeLHhBY5SIOYdbVfMaM12L02+XvVvwKxEW8H22HhFpdBEJG
	 hCPpeF177H9vF980JMFIpl3T8UEkJ3AuiBo/jC5dcyuy7mJQdm++FJmpqGqBWlkJ2Nr52
	 vWX/+Pg08eSCTT/y5o77QbE+WKVIO4KCu8qUOtY2fLekmGqgLJDHNhuVPbSzpsPA0RzPD
	 deLw1q0tFKtyQcsrTF4SQqjsXrUCK2Qb6owv4f4+DLcORoJ5mR5eSh+L3xtYU+vOOSMV2
	 fbb6Uwu1YGkjkhIFWcYbesihUxQOum5QsNFMeynF3/VD83934dh8ZoUA2210v3GB/sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pK1kehAz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74F606A327
	for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 03:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF74F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pK1kehAz
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b3a332105bso5074897b3.1
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 19:58:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794542324; cv=none;
        d=google.com; s=arc-20260327;
        b=X9vQ3mjSidKv1UCF+QJiIltvQBkQrF/d6hGUf1HNOL63PeSFbkqRkgtasLEV+mVQCe
         0bFsaGNzf//wN0cuGWeTSbd8CDzipxWFvqJzONeRiJvHZkT2k/4Z1F1ucavgsarlovz2
         r+R/SCK9i+BEVKDmNPX8evDKg1ehhJkRCkV8+YrhF8DjUBOY2EbznxViXLBXXQxNJDVK
         nFpNjBZH215WjY7kgzjBl7QlciVbR1OSLYu0ZzgxNAoUIJZeBlxgS8Td3VAhKwGUJ6u+
         9Hz5CMI7z5g77eZKLrSWJ/GjdN7ucVL9WyzoXwx20FhkQFeItWiFezl55IFsCQdoehBN
         KTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IyGhQCaD7T7hQLHD/OB5uRedIyEFI/0GcnFaq+FrCgw=;
        fh=9G2jXFpBgX3ARCZDJAaVQ4QAPN4ehKA1on/cRAIQZkY=;
        b=QDOGdxfp2OL9tCd1lVTI5Aigg5kqpOzZznPQZX5cdlY3mvWuKRcB/xESFZMjgzdLyr
         Y3u16hHkPUhHpxew8i6CFjeV8EfmNCsuhpir6DRyFsbnN6xHN8oU0eCZ9a0aWIh9Jaj1
         hdQYjHC95mFYJ3yw/8lHJZWNon4HspuLcMg0TzI1LwTGsX41JeHrzGda6E9kOh4VaNLm
         418SERkZBv8/xx+gDKICvTihxbMAZfDHvxPop+vLUf8av6kx7UDTzoj6W2dtttVBVImv
         P6GEPpe1qkXf2loa1LnzanbKkBmoumskOEgZncWEG5mgKkzz6qcHOER88TgHUZKREx6L
         uuJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794542324; x=1795147124; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IyGhQCaD7T7hQLHD/OB5uRedIyEFI/0GcnFaq+FrCgw=;
        b=pK1kehAz93mmZLKsczKmcKZ957T8YBm70nxhF2OoziKISxf/zC8rFz1EL4ay5Jq7o5
         ex5aaaN9QPyPAeSC8SUQM9TeVMAvxybV3C/DRPfF6DLhmgTti7JBHSXyB6UDNUEFRXt2
         A3aelOOxb9TaAYSUAiTLHXwiFWwAjNqFIWiWyHHc4tqHKaJ/qRx/hiJgS3BM24AI9ugt
         5IFJmonBsrpCp2SDkR8BILxRydMF3Gy7jYTbr5QqkHG+F8+L624d9XtqtUEg+IibhScr
         tgZF0wmAFYd8PxT2otnunvBZM2Lj5lY+MQtZI/SuFGuYT9OvUCGVKgRAKDosvqk5c0eF
         WFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794542324; x=1795147124;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IyGhQCaD7T7hQLHD/OB5uRedIyEFI/0GcnFaq+FrCgw=;
        b=F7n5Ve8UErfccn8suYNZ/D3Vr1TnYK8cQdaXDMWwtyZ81TrzpGshjoaIyqalnFu+Ko
         5h8oMbCJYwzc1fsPvCkBW7LPTEyxBYEab+1rK6EIJ+Y5/lIF+xDUc3cVWPXhgtjDvuB5
         QnvCc9n7PExZzJ+K2oTTTJHmSjUs6zPoepuG7oXiZKnqzunIAkXgEqVg4RW/CNMJk+gK
         C2Fntx/gF3mRHgDK/VKaPOVvR4gtxsBbejb++72Yvc4ZZLECNotDUIkf4nQ2SkfBpQZ9
         R5oqN4NfTP2irlrx2d5juyIrnYLeinc+S9gfaK98moD4rqW29fqjcqANkTdi4yza4nVj
         QEoQ==
X-Forwarded-Encrypted: i=1; AL+hErEhJVThw0+fdttzQdynceVDD52Hj1xH+0mJKJHw+NPEQJnydqKfH43kVPECgL2soSDbVSV0R2tMAFhSMYIl@vger.kernel.org
X-Gm-Message-State: APuU4Z9XKkOpd7QLe3zSo1IrIgou5C1z6MBAVLKEcsnPmpZmwFnTVINE
	Xh3Rh+fC90XgnXcvpbStK8MkSYhjqjo2/bE+1tz2rUWUJ8d1YHuQNmZqG6f2Bx9UtE7f1jkT6jR
	C//8oMCwtx4VFuQZh5f9aHyTqPqp1Urc=
X-Gm-Gg: AYBFou0ReGINCa8UU42sW4eGtrCg2PX5FLar66/71P6WXj0RPhaprU39A/mTKOLyJV0
	HhFpMjZ/CaBnsGa9SNZ4MzcR37PV10+vbkV0lT61UaAuQZznZaedLwWMNOjDymFYaH8lKot0LqP
	0Od3cwjRqKzEPJxZxy+5peZijWmGV82wr0OfY9Vv3OnZPr1ZnA9+fbqti03WVqEFBvr+u16n9ab
	kXY8Re52h3wCnn1yqJO/wPubWTMRrGo1iiqR2nr4IgdM2K8H+lOh7CA+/Wq6CMqtsg9QlajMFXb
	/4B0dVPnrsX+5oD9FoHHS5h6VTNbUaBk7Ca8FmIGG7pmZ3bZ9MSUAastQXAXIkEntCdKN7P9Suh
	MUS6WxbOvrE0yMYWpxd1bouYGgg+vFrDL5WyeCg==
X-Received: by 2002:a05:690c:4990:b0:8b3:b31a:203c with SMTP id
 00721157ae682-8b3bb1dd781mr31064937b3.19.1794542323529; Thu, 12 Nov 2026
 19:58:43 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104133158.3187525-1-luolongjuna@gmail.com> <avZ9Ku61M8z-2axF@jpoimboe>
In-Reply-To: <avZ9Ku61M8z-2axF@jpoimboe>
From: Longjun Luo <luolongjuna@gmail.com>
Date: Fri, 13 Nov 2026 11:58:31 +0800
X-Gm-Features: AclHuK9vVOZUj5qgELVIIKNjLnGByl8-yGoOG5ihuzJR5hbFOyoI5OJEqSJb2Os
Message-ID: <CAKL4jwXA4OBVLFGAP4DWw6i9d5bneU=Ur=D58FnrssOt7ygm6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] objtool/klp: DWARF-based cross-build symbol correlation
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, live-patching@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I understand the concern about readability. Since English is not my
native language, I drafted the content myself and used AI to help with
the English writing before reviewing and sending it out. I'll keep the
information density in mind going forward.

Just to clarify the background: this design comes from my practical work
on userspace livepatch, and v1/v2 were meant to present the two
layers of that design as a whole. While dealing with LTO in practice, I
ran into many recurring correlation issues, so I tried to abstract and
model the problem systematically rather than hunting for corner cases,
and I brought that modeling process into this review.

As noted in the RFC, this patchset is intended to validate the
feasibility of the approach. I wanted feedback on the overall design
before deciding whether to take it further.

Thanks for taking the time to review and share your thoughts.

Longjun
