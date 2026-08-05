Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6343CF952
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954633; cv=none; b=CHEH4+A2NfQcwOa13TBXdfEACQJXtQp2CbPnlGbvPQcOQGwC7yZfTw/z54Zr7sypdoaCF9Bs5vVZnaDcJo6zMkvjM4nXzXUtNKxQcumH6gtJB9MCdC0Wj5AkqM2MnTzESG5SgS+3ckRwI8dyRy9ZefKIZCob+rmazCxAJnFFzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954633; c=relaxed/simple;
	bh=Z/EbEHAKnDcQ35MsjSxY6yemzAvLtLg+1CPkOJ+iogM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEm0kE+XFKGjbw1iNCeRA9OhU7IDOaNCmj5q+ZNad4X1mjNNzmUmdwmkDfkD/AsW1HCvIwGfx8caVJh/HBg8qWNN+K/oAXi7++K5qebaGlRC20vAZGGtjTzX1BQFKm5+vLeL2IQFWnn/yc/OEVr/FX9AGL7+LieB1Ni8xFoayKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuK1UArp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuK1UArp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B2C1F000E9
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785954631;
	bh=bOuPLCM9kjeonYw340piqJ1pPS7RyuWl0qAWpvUzqDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PuK1UArpYiDO7K8N4h4ctMqlQXD4ThsihiyNARXzf/JnwD6qr+p4E6RcONJWR+A/w
	 HvvHMI0zvD8XzdfnRnPG/q5HsXYcsC7NsRnygOODTomxP9Bzg1HNzBlCqz6tVSp1A8
	 aHnw8d6Tzjd7Kcq1cM3XssfytnhMdhPxSVuW+S4gy8LxQ11c3HNp1Cxt1bBJFD6jPd
	 vHNCeAaO+zxnsCDv3BrHZ+HECxYUmljvmlhYPYwF1IGwFE1ZPPg6NchjWQRWyaQv79
	 dl7Zcv7oqWqPW7dkQZpbNqFXBBaWDqRs+i8gedvDRopzOCGM53KORaLbIKMkK48DmE
	 K7cN+bH7YreZQ==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92edb12cdf2so89708685a.3
        for <live-patching@vger.kernel.org>; Wed, 05 Aug 2026 11:30:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ron1hEVjjoA/jsd1NsKsPTYS2C/WkUQ6vFiFychHW25akgUNNmURBABI3cai3WrOUArZVmSmxkwJd00gcQR@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLLrvrWJCzGvBOJLsU4Y4nrmuq1rcx8uPZiaK12u4G2MiELQF
	5k6oLuvgeROssOKtP48TKbbDjKGhKOJHwWHh3wOWkbTYCg1GoIUns2CPjuz2nbwvjALnKfHxDaE
	mnwKsjrY447cPI6L8IzLoCYFND09koqs=
X-Received: by 2002:a05:620a:90cf:10b0:930:a38d:4030 with SMTP id
 af79cd13be357-9364925a874mr692240485a.29.1785954630667; Wed, 05 Aug 2026
 11:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785939903.git.jpoimboe@kernel.org> <18345294f074bffdf734ee6a523968aa7d64ef33.1785939903.git.jpoimboe@kernel.org>
In-Reply-To: <18345294f074bffdf734ee6a523968aa7d64ef33.1785939903.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Aug 2026 11:30:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4UgkF26GMEmXT5QxJ=SLS3u7JMHZ4KfAQVJeqUEDJkKA@mail.gmail.com>
X-Gm-Features: AUfX_myqbqbxbAhx7v2tLICAsAYtdkv0jZ6fDMiAi7sNwY7NkopV6OVg5PpIUmY
Message-ID: <CAPhsuW4UgkF26GMEmXT5QxJ=SLS3u7JMHZ4KfAQVJeqUEDJkKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] objtool/klp: Fix vmlinux .klp.symid link error for
 .no_trim_symbol symbols
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Testing klp-build with arm64 produced the following linker error during
> the original kernel build:
>
>   `__notrim.1' referenced in section `.klp.symid' of vmlinux.o: defined i=
n discarded section `.no_trim_symbol' of vmlinux.o
>
> symbol_get() puts a static __notrim[] in .no_trim_symbol, which GCC
> names __notrim.1, __notrim.2, etc.  Two or more built-in translation
> units calling symbol_get() thus produce duplicate names, resulting in
> corresponding .klp.symid references which trigger the above error.
>
> Add .no_trim_symbol to the discarded section list so its symbols don't
> get symids.
>
> Note this issue is not specific to arm64: it just needs two built-in
> symbol_get() callers.  arm64 trips over it easily because it has KVM
> always compiled in vmlinux, whereas on x86 it's typically a module.

Interesting. I didn't notice this difference between x86 and arm64.

>
> Fixes: 029223d30162 ("objtool/klp: Add .klp.symid for sympos disambiguati=
on")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
