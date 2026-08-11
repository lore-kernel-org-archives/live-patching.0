Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779238D01B
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492111; cv=none; b=LThCuGAj2khYA6UoUZVaX6Sqfy5NclsNubbhHFMBp/XPFUj3XQaWbRUHZJAfAoRpixZq7/9rnnK5c8ulxkmjAveDY94U34RTrEx8zlVGXjuSnCB1agLgWO5Yb/FZ9CAG+rMNnp2L0XlSosxr3icsnhy27KdWNKgbrjxuTP7wCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492111; c=relaxed/simple;
	bh=ikcxj6SHN3sVCruA83BzqEfCpM169W3arl0JAL9WDpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMpBf7WjvMJXB0WwZjg1QKB/FOic4S9pTFglYtcRro9bO5ZAnzpDnwdC08+5BkelYUBbijUerts4THrdBikkXxQIJmPKhqlPrhLO7rzXIS+a2RjjuupWkjI3dR9ohGRdelyfYDPWepunQo9ORmFsWNAcZGdcGQLbGGJ7/+8K90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iapUpz8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iapUpz8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7651F00A3E
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492109;
	bh=ikcxj6SHN3sVCruA83BzqEfCpM169W3arl0JAL9WDpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iapUpz8ejqkcpdE87vY7E3JarlsiWxLFD8dM5LtD+C7MaZLPl6aLiYSPKEDRJ1s68
	 P9GiOzZHW2upQ9iiYszBlViNB5wFkZ37lHEYJrPsD2Nr8C6YL27Um15uYpVVjn6xBC
	 h10woQxbYhIzZjd4bWzyx/p+lE5BFiYOMTvA1smgazco+eV/i20VKzwL9KPaT+0lGS
	 PUltnbwtiqxvbF/WBAmwnXUYCggc8OaPqzwbSztm45yK9MG7GVXoffXBfRKBWaeWsx
	 T2ZdWKpt4y/4juDI9KwTIRL2hfbliobNsiMtRfpbWzMCK1akoCzi9AiPneum6vVQag
	 6Rpp62unF35vA==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so1516696d6.2
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:48:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqSsixsOi6G3jmy+JExDOnXma4gwGx3B2adC95AOpAMInb5bl0TdBmG9ganBiMrJDF0szeHb1btkMTFrXgf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UhNANO7iORd24m4MZXwIwC645jOGzbQLwzjKcHK2U/lk4Ma0
	YO9vSCNZOVf3j2kiRIVBroCLDQVa4fVMRTeaqthEgQqeURY1in+EZPZ7/MYdNVIdmUJnw7YZrXr
	0+1dtf3Z2Hqj9FGSNICG3pvfbtF6l2pM=
X-Received: by 2002:a05:6214:5014:b0:8f5:5866:161d with SMTP id
 6a1803df08f44-90a6fef979cmr8295456d6.2.1786492108807; Tue, 11 Aug 2026
 16:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <3c65abcb71c23d04470f45862523b0363ee4d709.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <3c65abcb71c23d04470f45862523b0363ee4d709.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 16:48:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7RDPw6TSAc0f44P9bm58DK=5Q41gdhVoy6Z1s9UiKn3Q@mail.gmail.com>
X-Gm-Features: AUfX_mwVcdAxqF54qkAocwB8JOvtQSEYvvnkAztsUnfN_9WEZHGTqqpAoPTqEa8
Message-ID: <CAPhsuW7RDPw6TSAc0f44P9bm58DK=5Q41gdhVoy6Z1s9UiKn3Q@mail.gmail.com>
Subject: Re: [PATCH v4 13/22] objtool: Refactor elf_add_data() to use a
 growable data buffer
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Instead of calling elf_newdata() for each new piece of data with its own
> separate buffer, keep it all in the same growable buffer so the
> section's entire data can be accessed if needed.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
