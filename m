Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC636E49A
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352793; cv=none; b=pml98VfBI/ylUa8zh2akSj3oHlaSZnPMNUcGycLXCPw41GqKJkjhtOXPjnacNOLhpstAhvb8uLJ6ToVVrwA04EpVTSd2KztR1lTvLcPx6aT4xsZbL1oEhd/TvEzkHLGACfZfMIMQBZKU9tMTA+l6ExYygSne/+QkdGx9yj0lyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352793; c=relaxed/simple;
	bh=PQDQgHzTnPbSPyVTBEsNFSmLLSIAJYYB6qlnLjhDqFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6J5IMlf3hAxj8xHOS6873fc/lPPB2m4Mb2dsWP/OJQLHmV5ZgcddNUKABkYgugjNST501NM2j50MmJ9HWEU+zEiPe6tZMUbbYzhSEf2aYhE78b98rirMjwYG9m9ioi9utDI4IEle2FDJHIyx90mpOE2Bg7H8IK7sLP9O0X62Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojGEOHrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojGEOHrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3270C19425
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352792;
	bh=PQDQgHzTnPbSPyVTBEsNFSmLLSIAJYYB6qlnLjhDqFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ojGEOHrsnjC9l7ZRIULtDRrUI4VVV55lAsH6WyJpc6UozDHbbDxZPd9NZDBMgpvUN
	 gEqq3jsa4i+o8LoKXJTaHD27xmd2rMNhGl0Us5xoieJAkLvw5XXVmzkoKVE5PFYoAF
	 cmPxS6D49DOKPi8PlxBWFnkS1Ka6fKFXM6/rcnM6EogtX44pQAU6jPT0GHBqckiTqO
	 ewO0sr8b2fmObS7vpjbqJ6qU4lZBrjRN+BID1DWSgnLY7NM6CQ2s+gM2vYY7kKkIMW
	 TB3QfpxFAXfsCyZ8yQumMBwfniPgz/I3JPTRRU8P6yA+fyzJYhyoLhPwYudhNxu58m
	 JdLFIxQScA6TQ==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896fcfc591eso44408636d6.2
        for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 10:26:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yx4pGQ3v4RPWubs0OPVp171R/cvON/mPD0d1q7GPH+eqU4lNG/9
	rQzgVZ1K3Ti/x0H1R5gDqOQXScBI96ruHQQGOdK1Z7qnacWp8WmTl95vNEDPSoBoP+grSUnaHdC
	kKGd7KhzyswoXmuFevIuyKxSCLuOFZpI=
X-Received: by 2002:ad4:4ee4:0:b0:896:f320:b18c with SMTP id
 6a1803df08f44-89734881468mr232374396d6.6.1771352791927; Tue, 17 Feb 2026
 10:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217160645.3434685-1-joe.lawrence@redhat.com> <20260217160645.3434685-7-joe.lawrence@redhat.com>
In-Reply-To: <20260217160645.3434685-7-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Tue, 17 Feb 2026 10:26:19 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7f5LmWSE1DQ1-ncwPE1Cx7j6EzC9pp+K1ijq-+cJopug@mail.gmail.com>
X-Gm-Features: AaiRm50_utqz2pjv8FvIXH4cjtBb5PZvZr3V-aE0hk-KY2qVPsmXJ2CNon-r74o
Message-ID: <CAPhsuW7f5LmWSE1DQ1-ncwPE1Cx7j6EzC9pp+K1ijq-+cJopug@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] livepatch/klp-build: add Makefile with check target
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 8:07=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> Add a standalone Makefile with a 'check' target that runs static code
> analysis (shellcheck) on the klp-build script(s).  This is intended
> strictly as a development aid.
>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

I wonder whether we can add logic to "make check" to replace the
grep-override function. But I guess the override function is OK.

Acked-by: Song Liu <song@kernel.org>
