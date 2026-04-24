Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3737F8A1
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068003; cv=none; b=G67WrSlbbSZb4ETJ5QBDFsp1knYWzPVWMKZPdIwwkNCTzGHPqiN9SACto+VGiwDYKiwGYwfw6sjFvO3PTaDHqls4P16l2i0quJBMF+itGZZVEwsHoAnLn7mgMPKUU+J4OIOuoTZ2ITuW0X+ELfVzdxCfEQa2kfYkBrxexbzW9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068003; c=relaxed/simple;
	bh=/o3/n4i+Z6Ljw2H+7rR5XJCjIUfs9U6NoANcCsKdzOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFTA9TZfmxi1P9J50u0y7WrGsyx7i6JZNfpGDvc2Api/IX/BqbHI+y7eZ/HuCqzi08hMVjonSGt5zeOMyWl0ENtvotiOxAl9nvl1Ie9zzYqjSBfbVUR38L8zs2GV8Rw6PLGoXicw5nmK6w/TYlsOIEqdzK+t/thjWcgkRjvpa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqBCG/rW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqBCG/rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429B1C2BCB7
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 22:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777068003;
	bh=/o3/n4i+Z6Ljw2H+7rR5XJCjIUfs9U6NoANcCsKdzOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XqBCG/rWTLFn5FyeT79qH/koMDfQJBTyOl7GWsapIXOx08GkiA1kuDMhjWdqFN7Uw
	 45gpnxIhS5SToUCS1VAPkhCciNW+ykTE1OFQJRMU2uN9VRFavZCLFoouUVAmYjcSyg
	 9GiIESr6R0QU3qkdrVbmNAsjuuMePHDl/0moV/debAIKXQAjYceB5E6CUutJkbTjFw
	 I9z0hhkXqMhu64lUfOKoswOMHwYqdwxrxyVhzEfE1bSPphkO6sbjjU9SG1TRoF5sRn
	 nqmVhvedGmVU5SsZjwxg4o2EOrDD3bmh0+u+yErcxjzhjUsDNsDU28uttwYg5Xs+8q
	 547mSHlhqijiw==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d560ede296so915950785a.0
        for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 15:00:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8VXQBhLfwT+uLOaSiX9jwzAqGbJGTpVI4+aZYYEUw+ToKNBSM4M98s8bCozuhkxURpfGY7h2kkJghaZ89s@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKhxbZNLHqe+kcpa2THPpD6Bh0nCrJa7tojffi3axsPBAW+ne
	BxwzPvBrkxYlkGOBpQaskzKpuqjg6G48lo3cCxerdjXO+J07hEjii3837ynhgoAiwGMSItFnE4o
	yOweJXPxCgfvVDVM5hWePWv1J8WvsUAc=
X-Received: by 2002:a05:6214:2f11:b0:89c:e4c3:dc1a with SMTP id
 6a1803df08f44-8b027ffca46mr541154696d6.1.1777068002196; Fri, 24 Apr 2026
 15:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776916871.git.jpoimboe@kernel.org> <d9acc0495f258f58703820274e6045ceb2198d70.1776916871.git.jpoimboe@kernel.org>
In-Reply-To: <d9acc0495f258f58703820274e6045ceb2198d70.1776916871.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 14:59:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ohkayYZKfV62bGMM8xhXnog2DNUcUMKvBo2o6CM8gWg@mail.gmail.com>
X-Gm-Features: AQROBzDnML_MHb9_i_-PRjSlwl-Wvx1RPHfhlpuDenDF1W5UUgSVToGbOX8AE5M
Message-ID: <CAPhsuW4ohkayYZKfV62bGMM8xhXnog2DNUcUMKvBo2o6CM8gWg@mail.gmail.com>
Subject: Re: [PATCH 27/48] objtool: Include libsubcmd headers directly from
 source tree
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 9:04=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Instead of installing libsubcmd headers to a build output directory and
> including from there, include directly from tools/lib/ where they
> already exist.  This fixes clangd indexing which otherwise can't find
> libsubcmd headers.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
