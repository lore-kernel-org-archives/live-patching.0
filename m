Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A194405C26
	for <live-patching@vger.kernel.org>; Fri, 15 May 2026 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880035; cv=none; b=pDw59rZ9EZ6Tz+sAcex8x9w90US+hOuTt6N/2/lhd0amHiUDDV1gYD8g6Y6U/YmnCoqjk39Ga027NRufgJP72X/52WHNC1LJiIkTwm3u5dkuTPDRWbZjJ+Cy3lSVG65hVYB0fk1euIyF+FeWlnFxWHeMqaxKdVjrqY0WLjtWbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880035; c=relaxed/simple;
	bh=pdmef4fBgIAbfqgK4jVS0fI/dYehx2orZtpEc9nD0JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtlskaxhVMu3o0o29sTrQt7LDeSQZ08L41Yvobtn52xYUyyUBekAPADXlb5AJAw6TiuEqUEkyTPKS1vlOSBKkes9SADsYdRmXTIep1CxJLP1pd0gacuOcgluULCPmZnUVJu+1jH1z2EEiser3XLLmitaQiIX4xmsiidornXTkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYOY24OW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYOY24OW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E1BC2BCB0
	for <live-patching@vger.kernel.org>; Fri, 15 May 2026 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778880035;
	bh=pdmef4fBgIAbfqgK4jVS0fI/dYehx2orZtpEc9nD0JU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IYOY24OWX6ceCGsHtAjp6Wvo1cIMp9hgQ/9aKGF7NTGTeSz+QxXtMpRfNtF+8N/1I
	 vbfJWf+yHy6VoG7E08uKcdz3YUDN4bO4jZpTE8K11oT2TYwPEvqXzBzVcZgqU+WTuI
	 ZpgOTuV8+6ulfK6z12BiiWZo0kuz3otSiPECpO/hi1xFbYnt5b5ouBQk0Dm28nYjRz
	 dG5UGYsyPjrvLcwkkmTg7QMNTks54KjV5yeUIddpFeY9cXZ8BNydEWpo997iIYOxqb
	 nrkHuKZ/qyZyrT0khwC+bxD+uW1227kxfE6N+so/vdHdjAHlFppic5OSEotpaKKGVl
	 XOqBC7HsVZuqw==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b6dd874471so4774886d6.0
        for <live-patching@vger.kernel.org>; Fri, 15 May 2026 14:20:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+xuCiTEd5WxpwFWFZ9GVbh83+9YQ/v72SI1qeznQMLrz0WXzOg25hbDum1hae3c9RdVLpfZRKpOoGzX5Yj@vger.kernel.org
X-Gm-Message-State: AOJu0YwJC6RlrZQxgBDAC17yvjwohIVLV3gQFNvtv1kKYNtiMYoHdtyr
	BiNqI9AumH5kd5zkU+Eue/nEXv6QiPkwNfOpfrKak/V9AFR+SujWiOhZDQ9PRkUYI1tx1njm7f5
	AlfaGqgFxPHeSnRMHh4VODHyJi5t7tMA=
X-Received: by 2002:a05:6214:5c42:b0:8ca:16fd:7297 with SMTP id
 6a1803df08f44-8ca16fd752cmr63903586d6.30.1778880034532; Fri, 15 May 2026
 14:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778642120.git.jpoimboe@kernel.org> <236050080db7b2462fdb13a03ed48a8efb2415a4.1778642120.git.jpoimboe@kernel.org>
In-Reply-To: <236050080db7b2462fdb13a03ed48a8efb2415a4.1778642120.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 15 May 2026 14:20:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ZrmF+5kPn=SqSvG_9hMYg90Oxp=JNZyEGXvU0KvJQbA@mail.gmail.com>
X-Gm-Features: AVHnY4L9sdxUgUXVbcL56ZDtdzvOBRji1QMIemxm16TDxuJg2SXmVG3dhNfVWn8
Message-ID: <CAPhsuW7ZrmF+5kPn=SqSvG_9hMYg90Oxp=JNZyEGXvU0KvJQbA@mail.gmail.com>
Subject: Re: [PATCH v3 16/21] objtool/klp: Filter arm64 mapping symbols in find_symbol_by_offset()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:34=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> ARM64 ELF objects contain $d/$x mapping symbols (STT_NOTYPE) at offset 0
> in data/text sections.  These aren't "real" symbols so filter them from
> find_symbol_by_offset(), consistent with the existing section symbol
> filter.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
