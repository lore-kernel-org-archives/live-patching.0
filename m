Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3290372685
	for <live-patching@vger.kernel.org>; Fri, 10 Apr 2026 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859563; cv=none; b=jv+rI4Av5AiUHrVIeoAgyqsro1WYiX4C0D3NnpZXJqGAdBU9eQGT2SkJ9rMfXsSkToSNIDhIz4FV1dQW/8DKyz+y3SEUFrflSicSeNDuZIYJdjsrFi5nLVfQ3aq2rodg3LEgSDLWEd0Isw6H19FM6Ji0laTgS4BH6vlbqvXx2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859563; c=relaxed/simple;
	bh=/SjYN4ND5bZIAhGX56F5pLWszT1julbEWaPr3KULX5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKF/tf2ZTzV7D5w8nhuwwdcoVfVU0edc4qsfrhMzK2632m52GGvo+JeJSEpDKQE8bUgmL+a74rkD85jS3OWhJmKdsebpB1qF5ZqUAgWtfmJdl0uM0Ibdg15gWc0K+f1FPek9GOp/5wwUNRS5Fz6cSeD+crVesvaxzPhzMH0eJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoLhR1bQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoLhR1bQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E35C2BCB1
	for <live-patching@vger.kernel.org>; Fri, 10 Apr 2026 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775859562;
	bh=/SjYN4ND5bZIAhGX56F5pLWszT1julbEWaPr3KULX5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DoLhR1bQHrIHcLfN6HISnNhexgbJ4hus8v1eRRYKbwm5thj5F/oao1ggm3B+59zEC
	 M/THSynB/a6rEsmEXMAgcdwsYBFH/CfcX7uJ1uJKU5WpWMPxngdwVUQ/AIYGhlrrek
	 fG9LezrKATY5hGxrRwX0av5mvpb/v0Pja4H1UIvlxJmAPsOeFqRaDHzL0a8Ggrua3G
	 t7gOFJdoE46C3JccX50WSNVcuDyEVi5N8NF4nLq518b7D6dfiwnum2jYQE5rpHHqxJ
	 6DEPL1aZ7qkbsntb7moiauKRlFogc5wFL+57/iz77KHslZ3JZMsx1/UmXsdWhx85fz
	 LRkn4nxvfQbWg==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a3342d301aso25770976d6.2
        for <live-patching@vger.kernel.org>; Fri, 10 Apr 2026 15:19:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhpy93Yvi+OX5lITq22y7fVsv0PXi3j8AtOZhyRZDkIboAvt5lNHTsGnPPMlpVqJUxrC/LpNZYXrKj0Jxs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OE1ngmE2KlRPB/vlIq0AUDZdxe4xcoLeauEZjmtcKzdrBb6+
	vAMBIHw+cjQ59fDmpFI4lrjAtNJTEoXndiJkVhn7jSYepdpRVjX2xgORBMCo0YcPxSCN+j6hy/5
	D4OTV1ezan4BEFs9zRPRI4J5doennVY8=
X-Received: by 2002:ad4:4eaa:0:b0:8ab:4ab9:bb50 with SMTP id
 6a1803df08f44-8ac8849104cmr69713516d6.37.1775859561815; Fri, 10 Apr 2026
 15:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408144919.3825518-1-joe.lawrence@redhat.com>
In-Reply-To: <20260408144919.3825518-1-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Fri, 10 Apr 2026 15:19:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Vt5Ra3Zq0ZjNYoUTjQVGkyfLWWGOMQLEyGNt6bUndJA@mail.gmail.com>
X-Gm-Features: AQROBzDbG5oAfrqEX3CV09LYhvRNe_9O6Jy9BzWpTy2ccPEQSn7vEeG0YupWg34
Message-ID: <CAPhsuW7Vt5Ra3Zq0ZjNYoUTjQVGkyfLWWGOMQLEyGNt6bUndJA@mail.gmail.com>
Subject: Re: [PATCH 1/1] objtool/klp: Fix is_uncorrelated_static_local() for
 Clang naming
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 7:49=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.co=
m> wrote:
>
> For naming function-local static locals, GCC uses "<var>.<id>":
>   e.g. __already_done.15
>
> while Clang uses "<func>.<var>" with optional ".<id>"
>   e.g. create_worker.__already_done.111
>
> The existing is_uncorrelated_static_local() check only matches the GCC
> convention where the variable name is a prefix.  Handle both cases by
> checking for a prefix match (GCC) and by checking after the first dot
> separator (Clang).
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

LGTM.

Acked-by: Song Liu <song@kernel.org>
