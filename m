Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4E3FEF
	for <live-patching@vger.kernel.org>; Wed, 11 Feb 2026 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770768648; cv=none; b=T3m1eCe0ay9CcjwURpPlozqwCm0O8ZY8uvZJcnRuaztbspSIedL9Axhxv/hdYYJ1olFHabEbVDnqAxJkNohdCkvbbgcTI1bJ0kLLlmaEOqt4jcX5Asf6wpRnur19EGOjS43N/bm5zgSJNyt+ZAekjDArDf3l+fVX3ybbpu/0hWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770768648; c=relaxed/simple;
	bh=PwjZHGcIs8Qzpzk/MQatYxcchlK3nPVhNRVa4tCkhqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2BPI+TEA7KRN9V5muw3IN24XiFvDnxcjvdnwltn7r+0aoXg0ThFFTyug5uEnS2fU7FQqjDiie78tj1c5N9d39oc1uaCe8wn06V05i8MHHV84Ryg/VZXks8eKj3cYzXCBkc2K4kfiYIl4tRv4CW/psKG987v8+D+59UvudLnm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAf4TUUu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAf4TUUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEE5C19425
	for <live-patching@vger.kernel.org>; Wed, 11 Feb 2026 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770768647;
	bh=PwjZHGcIs8Qzpzk/MQatYxcchlK3nPVhNRVa4tCkhqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MAf4TUUu4rapwZpMYxxGXgXFpChauTB0T4PJwATOvW0dzdKjrpPCyYNV9K4VINuhY
	 FRDFow4ZcuBEzgxAtZ7h/2tDKw5PQNyPD/Tj5ps2gChxCiB9C7zjp+wyDkNO1QljeL
	 V18d/165BpaqDhJiqhq8iM5IQHb/uGV8iqXzWn/v2xX2Wln2OH3OlZ9WIqJXkZ8fVL
	 qs/vDrHcV34ixU5JG+AAz8zSAMS7ORxt/kB8Jj+47RJVCjlrjxOzK1nOyhx8DZwfIx
	 fi8kpq+m7brkaEX9q5qONyFJV3NqtXRuvgikzRk29WwJk8PbryjHyTrkICnePNoZKj
	 Bhpta+tawOsMg==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb20bcff5aso113788785a.3
        for <live-patching@vger.kernel.org>; Tue, 10 Feb 2026 16:10:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUwLPuA/U5BpTCL1bWYOcrBP9uTBXpi/NLllFVamQzK5sGPu48aouexJgWtT1pe2uq2z4njrozQZdx0IYy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0D3hIcvVCWFEWy/Nf/SGJuCZNFwDxjhH3EYUoNn2t+PTnff4
	YePFCq6Yx8LUoRrAqoIT5l8I0fknnjC4I3et1130MDVSkMW86mjXczDcV+mkS0/+S+qgNY9/5rH
	CXjdBu96+2/u3iomMdeVl19mX0AZYGP4=
X-Received: by 2002:a05:620a:480b:b0:8c7:1106:1a44 with SMTP id
 af79cd13be357-8cb1f72e35amr514143985a.79.1770768646922; Tue, 10 Feb 2026
 16:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770759954.git.jpoimboe@kernel.org>
In-Reply-To: <cover.1770759954.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Feb 2026 16:10:35 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4DsTHn_zqpHGPTaRL1aOsbcqugyDF11pyQuD8dLencRQ@mail.gmail.com>
X-Gm-Features: AZwV_QgJPnHipYsBLRukC9X-XYpMjA5LO4JqzrUD7zgazzmaav-Wseina3-fZuM
Message-ID: <CAPhsuW4DsTHn_zqpHGPTaRL1aOsbcqugyDF11pyQuD8dLencRQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] objtool/klp: Special section validation fixes
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, live-patching@vger.kernel.org, 
	Joe Lawrence <joe.lawrence@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 1:50=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Fix some issues in validate_special_section_klp_reloc().
>
> Josh Poimboeuf (3):
>   objtool/klp: Fix detection of corrupt static branch/call entries
>   objtool/klp: Disable unsupported pr_debug() usage
>   objtool/klp: Avoid NULL pointer dereference when printing code symbol
>     name

For the set

Reviewed-and-tested-by: Song Liu <song@kernel.org>

>
>  tools/objtool/klp-diff.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> --
> 2.53.0
>
