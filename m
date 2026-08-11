Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E642C51D
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491716; cv=none; b=TvJrKE1pWLW/XQ5Krz7bqwhG0iyOXu7uVLYcxAlrWgJFb7Q5P0X5eZ9fCTt4NkoM/sdxm69cegtUPW9JZQ+OhhEZMsj2z8eXBck1wklHVwsFT5IWSG1aaSVHFkwKuq1GRq7XnYDUylNYBuzuuNwibK/0Of5bjZVmuiBykeOBK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491716; c=relaxed/simple;
	bh=O/9e903qUMdvwzKlZX/oTl9f6vS+kM+wDwOwyVMZXF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rc3sOjFGi9TrywmxL8fCDI73BlMeewS2+EfgmJZ6DoEwSDFyPtvm5+RI+na8ne8Lq7vrdIA4bhUUqESQ1WM586U4Ot4/+FJYpPrCFy/QOfWc9dm7MGastpujEOnzHx6pXD0/9V3EEwcqcYBMcwdjppyq4ogi1QCNVE9r5r8dILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsw1yCqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsw1yCqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E381F00ACF
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491714;
	bh=rWFHqHoDhwv3End6vOaA9Q9bQECLobuBCE6XcECOx5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hsw1yCqIiK9PM+9LiC9i55v/7XqxN1vcbbVSsfSXSJCeMe6hNBCZ5iTyqexoi36sN
	 UvaBu3REmnni8sgpliNdKNQkCYqPPlwc3E6EOaUtWPD4d2zFFu4StOCrsvIIlmM8U5
	 I2U1fJqTNrY4ZsSYGqkuJvzhBFwtXW5BRoaJoAGQPWHmpA3RP0QNkHgaQrSFINi+/d
	 GB8t5A4VK7cvrUTmw9rJtlwpYMO8r7KCSMwjm7knEPHtOyaqPQb1KbflJCMG2myxbo
	 9I95iGalmEu3AzndKJUB1/uXwfYglCds4K7ZEdUAsPr8OTvCpJY/L8mrd5zjOzDDHH
	 uKydF8uc0NCKw==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5b048375so9988085a.1
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:41:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoYobLRHOKNLAL6HCUYM3bYNjl70VNJIM3x+Oy5E3TeL20ZRba3yX2iPtySd1h2+sYvYSSgApX33FhHD3Ft@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQ+uJoT0SVr7T9w6jEGdPbardbxKvc80UYaaTrfWgBolCt3qs
	lkfJCTudAfXm0BbSn0gNr6wXInrLKbyQAfSuNZVYqW31b6daxOD6o4yflj8N9oWkVA+nqqEbpN+
	6eS2e2H3PSObzXBoIh2Ptwl3zsPdDBOA=
X-Received: by 2002:a05:620a:3902:b0:92e:6c15:24cd with SMTP id
 af79cd13be357-936b3a725b8mr99308985a.15.1786491713775; Tue, 11 Aug 2026
 16:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <13cec0336ae0e9ad4bd605bf34b1236de85d6243.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <13cec0336ae0e9ad4bd605bf34b1236de85d6243.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 16:41:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7NFEbrNHJ7WLitWZmoX0k4_=zL9MzzdzppLGtWOymoAg@mail.gmail.com>
X-Gm-Features: AUfX_myU0Cpe94E_C9w_Z6BblVsJt1QBk1Q5hgBLrpa5-RTlSAw_WF2sBWsttQ4
Message-ID: <CAPhsuW7NFEbrNHJ7WLitWZmoX0k4_=zL9MzzdzppLGtWOymoAg@mail.gmail.com>
Subject: Re: [PATCH v4 12/22] objtool: Ignore jumps to the end of the function
 for checksum runs
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
> Sometimes Clang arm64 code jumps to the end of the function for UB.  No
> need to make that an error for checksum runs, which are only run
> manually by klp-build, and for which caring about UB is out of scope.
>
> Such UBs are still reported for normal validate branch runs (for arches
> which do that).
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
