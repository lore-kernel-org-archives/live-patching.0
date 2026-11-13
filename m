Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794544353;
	b=x/0QqRgGyLaAZi8brkIvCE89phGxVE8MSsMYMnOQJ9UVP9iMqd1ksw4NtXFkyrNXDZh6
	 ZFXKxkshR64xPqCfL2QizkE1ikYDsNRyth9Z+wrVj9JN2qp8AqBTFj19AASX+RD6Si16u
	 RCfrHmI1wlcaTlATFJdmf1FLwiWfup+gwdXAvikcQyLNA3mh/Q25r8tW0i0npjvDIo6vf
	 o6ImM0G0C9CfmJ1wFCvsRry0p9yW8iP5BL1OmHWLf4Mo25rruEpxyj6mE71SRn7IL9TgO
	 1OKtUzoHqOkmx5BPV+gwMJlBijqlfeAP8jW9mRFyqexqPzIhTI9EsD9lnb9/cI6laUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=sCCLjXvB4SGerpvauilZuDN1HnIkE/zMTqJ1S6MMnw4=;
	b=NL9WOm/QkJJrQyZ2aduxTGuRciMJ5zguYr6UlDEXMwLbTK5v+4iZDAExHwVihtgjLlBr
	 0PdvVs23jmMLa1nDBtNhASVNMuYHIPIreTq57dxCYGtSNZODb40QLn4Q653MXFTwPmuNM
	 XtILzcMAluLuMXZ8xAQJqWoDNAyWEc0Zm/qjBnbXfmEm13Q/O292lEH88XtswvVMTw46I
	 tUFd2x6PHQ5WVm0Y4lxc37rBpuwby/7ZC0ERv9ihpGlJj4wh8uRCa/bHV2CcHg2N17wKG
	 yOpCF+5MttJe0ygImk064/vwoo2wik1fitC7rsoXNtt8xaxxzflZ05nhQ64GR0l4tlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KU3XcFIo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3146606A31C
	for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 04:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3146606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KU3XcFIo
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b305e10ac7so6644777b3.0
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 20:32:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794544352; cv=none;
        d=google.com; s=arc-20260327;
        b=QXtcWFnE5zTOw8A4TS8TpN2lt5OODslzBPnbB0BQTVKNTr75RTf2mBRnrR3HJCiMLZ
         4M5Pw0AYK5+QTlioMhKXlkzdRgMIp78dTBFh0ECfkRzVvNDZ4aKq81Ob2DfzqAMGwLnQ
         GPkGUyxf4X+znNdqca2HFIqVRQxAyxKTx4SHzSkOSb2nZmjfbHiNIzI216opviqMNPsV
         Th0r/VleevajhxHvJ6ZI0XDBiSDGk74LnoXlSgJD5t6Kdsy1A7ABmltK+FIzG+7ztCg5
         ExatNBNpCTE4dggapYpYOuK+OjEWWI4ju91UZB8QrVmo0NWVyd2WQH/R2s58/5hmsvhX
         LPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sCCLjXvB4SGerpvauilZuDN1HnIkE/zMTqJ1S6MMnw4=;
        fh=VKnHXQH6VDkNPrV3oTIqMOITJGNE1ucms+xpBz9ic8k=;
        b=nBxTRuhOQg1bMOyow71ADuQlyURZonYe+iRBnQ5FhGRLFUbr46e7gxIMoBFNXDvcnE
         p05NVs8HT+YJ59jR2ehpL30IkAuBKjivlMmQZ240QgDQZPdDAJ5GXlGo534FLS4Hw130
         6tATnObn34IgVNgYfc9zYkqtNNlWSnsPMg7Br/+u9ci1v2nsVPXMAJjcNgKwugcP7d0b
         pJUcb6t0hq7dcm12k+8Y005TO4hQX/yxpZrxJmRE8tHCyTAYR11+BY/DzwR7yDcuKIrg
         Hsp4MALyaU8AaVC45jXqoZfcF102xrMQ6AouCMmWS9Bd+Qgs86zGNPvE2uq55YSilC4R
         yusw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794544352; x=1795149152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCCLjXvB4SGerpvauilZuDN1HnIkE/zMTqJ1S6MMnw4=;
        b=KU3XcFIoNDQxcQQek/1dH6Plz2KpqOXYhRj9EXzcxqX7s9tHT4sD/cglVKgEh0Rks0
         apqZzfgBLirbKySdWWar8mMIUxWPQz/1yfVow0++xQiLP3azkquvrjvaon7RRQNqkF/q
         rPNN3oTLT22JLejm5lhkror1tB7sC4uZQ9/cBWad0Wdi/AViynz3F26j1F16Urxswxjh
         4HicNjm5oYyKdnT14kpUmKI6EChYVmW7ai/BlVBIsRO7lRtFp7DLESKxWU1kY/T79lPq
         Nc5BLk+KlmrkaL5xC6BFlBGZI0yntpCK4XQYNpOmH3FoOPoWujb6Z/RmiB1IYWH5oyMe
         zmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544352; x=1795149152;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sCCLjXvB4SGerpvauilZuDN1HnIkE/zMTqJ1S6MMnw4=;
        b=Go/Y8AVaVAk8lKqxc4FGu93xg9eQCi+Qwf4uU/dcRzEfVTpM0YxuLeWkGfL1Q9Ul8O
         BcAMly/CNmBu0vGgtcnLVNPJkrL7xCO2aAdOoQAHdf83Aoznp0gVl7kIm9T+qxQSg8PQ
         TLCnBQ2+arye1mg8dVAJwdvrcRk3dkyCBJxRrzwdT4PsXR+tfgWcRDt5uvBJrqoeS9DL
         7lE2MzHwsRaVmJsLblDM9iiXKbWWj9dECD69/XEhMb9Zwo/Qkbe1bu2y5HH2j/HC6TRC
         d6+Grou6j/g3AbRPw60zFWItQjvce9u2TPf3TSiSmhEORy/WkXaDHhXl6L63VAxI8+5n
         k7bA==
X-Forwarded-Encrypted: i=1; AL+hErEr6Cx07pGurgk/XYX1lF9PaQg3MyCUEi1GIJhDqujJwmCi1Q0vlcukdmMSNVbKxuU2IcNzQim4mkyK24qK@vger.kernel.org
X-Gm-Message-State: APuU4Z8DZMOZRnV19rZCOKI+7hVd31YVXWu3yT6A/4CpdKZfXomS2JC2
	QJ8xaPpurImoWST6t4do1n+QWD56vxKoHM0dkk3gDcYmPjz7fh8/ploPBWlcohkLU2UeACvrffN
	0eA2u6vxFU6IC6zE7Q0zaH1W3uQRK5G0=
X-Gm-Gg: AYBFou3VpUP9IAubjuhFLkCxQrh9GrMXtskjvDhvZUMPyBztoHrHk1psbOeY8lYIpQn
	9XaCLYRU8xc6vTTRcUuBbuyH8SYOUdFgTmRgnf+5HRAZvRo3otXaTWRjO5whJkd5drrvrWiTAk3
	hH0csKXNwUcgv4fV2IM5nF+UWmnEgnzMuIdt8MMLWsRG0I4oKi33SfZj9EpU79JrtNYS6Q+zN0x
	Qh7V2b+AYh4h68XrH9Rzgh8d++hyWkPYjji9MLQUVB7HWkHAnIs/N8NTHhhrzvO7ZdNK5wz447N
	dFvkEEpbogqbIQEo8NPP57A+EAIAy3YTfOGyF+YGTUYs9+b1JTYNqO/0r8rYdCTWIJY4QyMRnMb
	58odv1dU/ONM8CMFeJ7udDxGkJe6/yU7jeDDksQ==
X-Received: by 2002:a05:690c:e3ec:b0:8b2:e0c3:1f4d with SMTP id
 00721157ae682-8b4aa31790cmr11872837b3.37.1794544351872; Thu, 12 Nov 2026
 20:32:31 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-2-luolongjuna@gmail.com> <avZ3jEbnuVu5Qv2G@jpoimboe>
In-Reply-To: <avZ3jEbnuVu5Qv2G@jpoimboe>
From: Longjun Luo <luolongjuna@gmail.com>
Date: Fri, 13 Nov 2026 12:32:20 +0800
X-Gm-Features: AclHuK8qY8jjtI7qXkHC9b17eYQlt9s3RT5E2Xs4WB3O8zx_JowBcXEsuGQNeh4
Message-ID: <CAKL4jwX=ctyjXmm=Oz_+HXe89vOHWHgT_-KGyL47fOBEQTYJiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/11] objtool/klp: Fix checksums and copying of
 wide strings
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, live-patching@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry, I left out the debugging context here. Both comments refer to
specific kernel build artifacts:

On Thu, Nov 12, 2026 at 06:42:36PM -0800, Josh Poimboeuf wrote:
> Please give example(s) of such "wide strings" in the changelog.
>
> > +/* Wide strings, such as the u16 PSR setup table, end at an all-zero element. */
> > +ssize_t elf_string_len(struct section *sec, unsigned long offset)
>
> What is the "u16 PSR setup table"?

PSR stands for Panel Self Refresh.

Source    : drivers/gpu/drm/display/drm_dp_helper.c: drm_dp_psr_setup_time()
            /* macros expanded */
            static const u16 psr_setup_time_us[] = { 330, 275, 220,
165, 110, 55, 0 };
Section   : .rodata.str2.2 (SHF_STRINGS, sh_entsize = 2, Clang ThinLTO)
Bytes     : 4a 01 13 01 dc 00 a5 00 6e 00 37 00 00 00
                        ^^^^^
                        220 (0x00dc) contains a zero byte at offset +5

objtool   : strlen() returns 5. The checksum hashes only 5 bytes, and
            the copy includes only 6 of the table's 14 bytes.

> > + /*
> > + * FIXME: GCC's range_string() uses a one-past-end string pointer.
> > + * strlen() reads past the section; preserve the string base and addend.
> > + */
> > + if (entsize == 1)
> > + return strlen(sec->data->d_buf + offset);
>
> I don't understand what this comment means either.  Please make sure all
> comments and changelogs are written by humans, as LLMs tend to write
> nonsensically.

Source    : lib/vsprintf.c: range_string()
            p = string_nocheck(p, pend, "[range ", default_str_spec);
Section   : .rodata.range_string.isra.0.str1.1 (8 bytes: "[range \0")
Reloc     : range_string.isra.0+0x9a: R_X86_64_32S .LC22+8

GCC note  : Uses .LC22+8 (one-past-the-end pointer) as a loop bound without
            dereferencing it.
objtool   : Passes offset = 8 to strlen(sec->data->d_buf + 8), reading past
            the 8-byte section. Fixing this requires tracking the base
            string (.LC22) and the +8 addend separately (left as a FIXME).

I came across both while testing on full kernel builds rather than in
production livepatching, so I'll leave it to you whether they are worth
addressing in practice.

Longjun
