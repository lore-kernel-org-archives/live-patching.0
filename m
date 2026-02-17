Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC636F416
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352558; cv=none; b=avMd7HcBx/f5l5iEOWHz4bb6Y7pJbsq9O9EdgFmoz8096DujBCQvMiqUd8c53prOtQAuPX0Cs1sIwQ1buMxLiAyr5c29W73CIOmPMwotyJ+jTX+Qh7shlV2Ug/vknAJPZYKn6qYfYTXp2lS1n8bWbr8hNkH0bKcJli3us2BUMjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352558; c=relaxed/simple;
	bh=eJegjciZz2CZK3hGtVAAVzygyORfPDWTn1ASZVmvX+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyaZPMv0+x4L2hFb/sbBdHFBowe8oL+bNmzZUW8DITqpWDBppwhEdXMKt6NZrHY90Tc5TuP2PUEnGuSXMlz3gx3qJM1fgib8BUnn1wAJHsI1v3xlHWcp6IRMtCgDbZ7c/xTXtSYNmKvn0CwyvzEMrSwL4tlS5MKY5ft8peoTaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EADOOk0D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EADOOk0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A35C19421
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352558;
	bh=eJegjciZz2CZK3hGtVAAVzygyORfPDWTn1ASZVmvX+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EADOOk0D00+W1YRVVQ/j9s5Ya6e7IU45Svj7LG9CFe7d0YlG0hBbI+mNlI+xvvaBf
	 ZgS9hEkKCH9rYEywuj/z5wtD88z30GZa4zpJLHtjkmYSuNjupHVkYkJvVgTYLykh/H
	 cMaVp4Qrw3YMIe84vgI5KfiuaTRnCBQOmrqd4E/REQg6E6Ee0NfEY8ePQhP4NnyZKx
	 RH8WvZICTtnc4kwKRwNxcxnSWCkPDfkOoPc4efbcAMdZGnPwhdf9IS9Fp0AAsJ9790
	 rJPmJdw0EB4rhnRFffk/ggQ0OM6SdU96bMPc8eRiH7SaMCTExdZt/P8wywA2rNv26c
	 T3VRfTaObLMcA==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-503347dea84so48398101cf.3
        for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 10:22:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yxo397hRWoo5A0es3qSNY08rg/Kzp16G+eJtPUz5ru8DD7tvfFT
	OxJzo5GoAotiJv9c42qyY41qWlTexosFIXubxBQfA99UY0H55ljxzXVSAxF5oBLQUQb1hgsjPKg
	lfNi3toQeXQZdKa7e9QLymHoMKMc3PwU=
X-Received: by 2002:ac8:7f4f:0:b0:506:4507:e65e with SMTP id
 d75a77b69052e-506b3f97d1cmr159109331cf.19.1771352557762; Tue, 17 Feb 2026
 10:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217160645.3434685-1-joe.lawrence@redhat.com> <20260217160645.3434685-6-joe.lawrence@redhat.com>
In-Reply-To: <20260217160645.3434685-6-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Tue, 17 Feb 2026 10:22:25 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7UjagyRD9NACwwOMMcASSUBa+sxTLJ1ZuYy98jrSZTjg@mail.gmail.com>
X-Gm-Features: AaiRm52Wu1Fdm5FX6WSvhcZPoBMMZ72Nxsy5NGzCbTZAQV-cmZOqpItjtGsxtLs
Message-ID: <CAPhsuW7UjagyRD9NACwwOMMcASSUBa+sxTLJ1ZuYy98jrSZTjg@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] livepatch/klp-build: add grep-override function
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 8:07=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> Provide a custom grep() function to catch direct usage of the command.
> Bare grep calls are generally incompatible with pipefail and
> errexit behavior (where a failed match causes the script to exit).
>
> Developers can still call grep via command grep if that behavior is
> explicitly desired.
>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Song Liu <song@kernel.org>
