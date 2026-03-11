Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEF33DEF3
	for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267796; cv=none; b=e54JwG8YOf+ttGBs1UgPl5YAPdFrwhdwZLfmg7Rsd1Vt3aynJFR0palxwGGSqlQBjRxNkXld3sgzbTQ0JyyTeZnSHvuFu0h8SGfdTyQEjbjo2WvftoUZjppHSl8fidZvGwjB0V67UyqA1Ph6+7g3YqvX/4LAv6qp1F2YeCNooJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267796; c=relaxed/simple;
	bh=127OsXp72ltArJQOzAOi76gs1zOjbT1cWoA//sVab0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoTJGw+gAG/gOiRqUy5ggggMWHK/FcHYXiULNHy3dsYFFOzoDPOScVy55NKtIbZN8Bd1cd16Gsf4z06qt3QtzNVk8a6sZClsEF+u9kUWllB7UOCcSA10odytzTx/5hqpqjkToeqPThNHL81iddmUkaLRFSXrrb+gG4bKnTpda2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dazRgTym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dazRgTym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F900C4CEF7
	for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 22:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773267796;
	bh=127OsXp72ltArJQOzAOi76gs1zOjbT1cWoA//sVab0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dazRgTymf93WtSmlnm23JVBtNqt0QzEAHspOgZ5aAl/0kPQXFJk27vOCnFRFMlZHh
	 6dcNflDEq0X2k/j+BfRXK5e6D0WIfAP5FvfzjguvtQH1hEQ6gIGHL8qgd9rNEbC59V
	 MBYawUupp7FqGZZDXYzqHV2cOP5QxlLULeibCCETbbAKcWleoppvIEFQjJEo5Guiir
	 BeMJxim8Wx00UJZkNobgqQgCOoooZZCWVYFdjBAbCk66ltPjxTXODQPzc/xArDNugu
	 t56p1QvyQ+AOESikM2C95UOmCXfEwNpK8Z+xrITMTmF7nRp868JEGQ6jURA+dYPxY5
	 ZnmCk4DyVG/IQ==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899d6b7b073so4687826d6.2
        for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 15:23:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz/vCeAOcZVQiZOJ0QRBSw2ffgLEFrtmumZ3BzTjBwgETuokD6M
	8OHayF6aujODAnzJYTyvVeLsq7wru9AWl4vE4QpTUne+Nbt71e+fB0MjnN3kRJHHGdxs2wKXf8y
	TNIvTHRFOO0LTAYuIkhcvjgwn7Gl4kGY=
X-Received: by 2002:a05:6214:d65:b0:89a:2fe7:91d2 with SMTP id
 6a1803df08f44-89a66ad7034mr63880246d6.57.1773267795357; Wed, 11 Mar 2026
 15:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310203751.1479229-1-joe.lawrence@redhat.com> <20260310203751.1479229-10-joe.lawrence@redhat.com>
In-Reply-To: <20260310203751.1479229-10-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Mar 2026 15:23:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ksu-e17WPCOTggnQ4C9XE-ZsZY72h4f0jC=JSYVrbsQ@mail.gmail.com>
X-Gm-Features: AaiRm51YxG4OWLT4Q38XxLsaLHpmw3jwqhok0s04cH9DK1Ax_IkTqCOIgKkyw10
Message-ID: <CAPhsuW5ksu-e17WPCOTggnQ4C9XE-ZsZY72h4f0jC=JSYVrbsQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] livepatch/klp-build: Fix inconsistent kernel version
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:38=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> From: Josh Poimboeuf <jpoimboe@kernel.org>
>
> If .config hasn't been synced with auto.conf, any recent changes to
> CONFIG_LOCALVERSION* may not get reflected in the kernel version name.
>
> Use "make syncconfig" to force them to sync, and "make -s kernelrelease"
> to get the version instead of having to construct it manually.
>
> Fixes: 24ebfcd65a87 ("livepatch/klp-build: Introduce klp-build script for=
 generating livepatch modules")
> Closes: https://lore.kernel.org/20260217160645.3434685-10-joe.lawrence@re=
dhat.com
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com> [add -s to make ker=
nelrelease]

Acked-by: Song Liu <song@kernel.org>
