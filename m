Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD8274B58
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777066522; cv=none; b=nW1jOP4VFFTqgi91zSUjQo3zov1OZWGAw7twmHN5XCaVjTwQYJhwTug6lssCxrI4Aqv9mVvNOyebUS8RoZ+1TKjMlU1gmi1lctlrEFPp9JqQoc7By0SOSXMtbSZaKFc14h6cyVfMg5cPb3/4dvHKtF7xiiLWhDzfOjkrI9D5p18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777066522; c=relaxed/simple;
	bh=nD4T1MTXy0xYIij28JvuHsTGU6uaoJPS3AyJyXtoQvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gk8wJvlnnynarbZyLcN7cXbeUNU9iBQO21Uwjd/AvlJQs6N9IzCoZf10wPczpBeueIewYPvti12OXsK4/P7Be+ABJQCdYuO31u9zunbbRRklVPSRxBScN0IePCFaWi94m2bUO2q7TVWMBaGc+QuQOx+m2PPZD2tl1jyX0ZNdsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY+f2Oc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY+f2Oc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F1BC2BCC4
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 21:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777066522;
	bh=nD4T1MTXy0xYIij28JvuHsTGU6uaoJPS3AyJyXtoQvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CY+f2Oc4Qjj+8b2A95ZKf48gDjEsabqlbTK0s0gxmHhEApNcBv1TyQT6MluragIRv
	 ugTfsfQXWSS/ULGTClEsFu1WDiM7v9qFmcnPC5EUeZ9qFzerwsiTh9ezIhIvBTRfRv
	 OWncCnSkLUMJpZarAARE8lHBWG3ayiCLiX5k15Ge11FelRfi/GqOsMqK+WGdlOZq6Q
	 gdTgq5fMRR169Mr6VWMCOz6hqTeMwRidU0HsCuoNSZFUVHzInYPyfB/ByXD+/MsFCP
	 NBopceL/42wzLH9SK6l5TfC6vCFqKOPHwKnXA7ByQeDwmGTt6aSYmvGGdx24Pb47K0
	 ORsoOdiMZwi9w==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so115425986d6.2
        for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 14:35:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9GTtsp5UWWW0ctEyMcsEKjuLhRklTt3aPIs+/d5pierlHYLDamtpt8A7q0rGHP/5mMsxEJ1KJuaDuSOWNI@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGdPfjNFbzEc6rt+iC/jC+j4CtrsN5UaLtacKHLNZI2C9DajR
	ggmjZL65cJNlaYI2TArvF9ejpq9gmcX4ZKPFpw8BBcJN/sXmnW+4jlp/G+DE/euekwqyui0ln2k
	LOgCsS14/8cc9gd9WndaFXizbySR26Qc=
X-Received: by 2002:ad4:4eef:0:b0:8ac:a689:34ce with SMTP id
 6a1803df08f44-8b02818e4bcmr558937846d6.45.1777066521315; Fri, 24 Apr 2026
 14:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776916871.git.jpoimboe@kernel.org> <2779114efd74a9dd9f1e78076e1b9e3a5273de73.1776916871.git.jpoimboe@kernel.org>
In-Reply-To: <2779114efd74a9dd9f1e78076e1b9e3a5273de73.1776916871.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 14:35:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5EN1Yd-RdodN9OTN0zDdPi4U20=H4uqmuKeXC0i455Mg@mail.gmail.com>
X-Gm-Features: AQROBzA3r_CdmvOGOiDqbVg3H3Iu9ca6rrLs5SJ86HqLzhgHpVbklI58yIAbBRQ
Message-ID: <CAPhsuW5EN1Yd-RdodN9OTN0zDdPi4U20=H4uqmuKeXC0i455Mg@mail.gmail.com>
Subject: Re: [PATCH 16/48] objtool/klp: Fix relocation conversion failures for R_X86_64_NONE
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 9:06=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Objtool has some hacks which NOP out certain calls/jumps and replace
> their relocations with R_X86_64_NONE.  The klp-diff relocation
> extraction code will error out when trying to copy these relocations due
> to their negative addend, which would only makes sense for a PC-relative
> branch instruction.  Just ignore them.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
