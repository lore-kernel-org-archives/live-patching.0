Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15323D7C7
	for <live-patching@vger.kernel.org>; Mon, 26 Jan 2026 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453086; cv=none; b=QpPmU7bPWkiZOc/9HzzLcVQ48ay3g8RcA2TCxHP/2XXL9aYq69WPO//TszUtwi3XOSzD1rrLMsxu5q49UJXNiSTcYzrYJAZlPvUN95N/zLzIbBavhWsQ66XbgxMVjNOQoTlfP06QIlMt5SmjhZDHcFXwHDcwe9DrPKLU3/2ir48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453086; c=relaxed/simple;
	bh=7Ih2lgaMzlKdVgYfqwaC9IZB9z0aihS4c37Fiys7+YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxYjm3b6ncaw+HcTrJMiLJrR2GVtXPW26Iyqn1Ys1O7FcnDzJNAj+zNh8BwwZVnDxJm5SR+lfFlH77r+QW2dztIw7oV62DIiUBYgHy4tIvNVS1MYGMZIu97+HBIZOodlIGdMUq5y92Z0MhxpqUHGWdO4PTVtceT25wN6saD/U/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHgubXZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHgubXZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7947C19425
	for <live-patching@vger.kernel.org>; Mon, 26 Jan 2026 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769453085;
	bh=7Ih2lgaMzlKdVgYfqwaC9IZB9z0aihS4c37Fiys7+YQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CHgubXZS31xjbNfWAWlt7x6pP9vtA98y4RZdyQPzV+/kmXalE09++S3p7a4soNB61
	 BM4UxFSAl4JwuCuO7Ov0lZ4lWMU1RfOgDCWsX+1le/bDPu9Kt87zdfaBjMqBqgvC3k
	 SPWhiKAoA693mkCcnn/K2aogNO8PEZZDdHSvmOOYEDxjlj2K4i8O90tjA+b0MUXuAu
	 QD2sZAckH5NROFU800TLq6bxRGibjMalKc31eoloBXNPjRb/k+/9GXGCiOcNzWHg6s
	 m3+bI/tn+OOpH2bb9mFss+BFLF9622obdD6PvwLhZjFWv/4Sam00r/uXb4xce2Ri1p
	 9T5U6h/BkUWnQ==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c07bc2ad13so327490385a.2
        for <live-patching@vger.kernel.org>; Mon, 26 Jan 2026 10:44:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD9g/F0Fd6/nwaD0jUId7R++ea2TSKJw/08b6dHs0YOEGsSiLBjyNtT8qVREMntD3bLefjxhmI2zQR6+Vq@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCyE4RPj9/wtYBA8Kn4DBkieKQP+KeYPoq8NC7MX23IvM08X7
	yzg7utgBnsvnwFj2H6wuwhG7JTCMKnz4nWbK7Oc1fLUfMYExFYpZckg0iSfTVRXo7K/pxzD4nU4
	jfNTcL6sCb2SRQ8JEZre6SaCwp9r1B4E=
X-Received: by 2002:a05:620a:1706:b0:8b2:2607:83d5 with SMTP id
 af79cd13be357-8c6f96546d9mr649228385a.75.1769453084952; Mon, 26 Jan 2026
 10:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8e0a714b9da962858842b9aecd63b4900927c88.1769406850.git.jpoimboe@kernel.org>
In-Reply-To: <a8e0a714b9da962858842b9aecd63b4900927c88.1769406850.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 26 Jan 2026 10:44:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6=+KCiOTeDT=AnR2tTF+ROnmCF5oZkBxxgTF8W1RyXwQ@mail.gmail.com>
X-Gm-Features: AZwV_QgE9I9JAiSrw4kWTKITQKrxWq8sjlQoNgYVUIgaJrjCmEcpxxyf8zHh3uE
Message-ID: <CAPhsuW6=+KCiOTeDT=AnR2tTF+ROnmCF5oZkBxxgTF8W1RyXwQ@mail.gmail.com>
Subject: Re: [PATCH] objtool/klp: Fix bug table handling for __WARN_printf()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 9:56=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Running objtool klp-diff on a changed function which uses WARN() can
> fail with:
>
>   vmlinux.o: error: objtool: md_run+0x866: failed to convert reloc sym '_=
_bug_table' to its proper format
>
> The problem is that since commit 5b472b6e5bd9 ("x86_64/bug: Implement
> __WARN_printf()"), each __WARN_printf() call site now directly
> references its bug table entry.  klp-diff errors out when it can't
> convert such section-based references to object symbols (because bug
> table entries don't have symbols).
>
> Luckily, klp-diff already has code to create symbols for bug table
> entries.  Move that code earlier, before function diffing.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Fixes: 5b472b6e5bd9 ("x86_64/bug: Implement __WARN_printf()")
> Reported-by: Song Liu <song@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Tested-by: Song Liu <song@kernel.org>

Thanks for the fix!
