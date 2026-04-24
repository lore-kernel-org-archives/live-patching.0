Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E634A3C5
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068596; cv=none; b=OvUuP1Xpmvoryo/5u1MhOsz4MAME1KUxLSrC5wLey9CiNtFdSNRBWQd4r5rKGGZwwR7YAiMbJsVV07MHw1J9Avn3Tn8mhS15F++7GibXgLsgkDuNX175WzsaXJCHkyBOIZB2b7kybP1TFpVqyuPBCGs+2JGDnjB9dr1MGt3oSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068596; c=relaxed/simple;
	bh=qprXUrP9faDT4wd293/ZL/uj5S2XM+z4MG4WPDOICYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDRrBAKRtG5LsW+WMkSdRYzOiRv30CIdNxtlo3rxhPBPOdDENCX0nv0LQ3cMX/rqX94NllEt+hlBZKUmqW12WfztH/4DGRNM8Y36G1Lv71Y4DZZ/jBy1viCk96c94NTKqvdEq6hMLAk55fG4JSl1iKXmYLHP6FxNp0zYv6qUarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crQo7z33; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crQo7z33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60569C2BCB6
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777068596;
	bh=qprXUrP9faDT4wd293/ZL/uj5S2XM+z4MG4WPDOICYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=crQo7z33FCo7RzYQvFrotjIf9bcHlwzI8DrPbt2yEqgMKR5p+ffWKnfvBvNSumB4w
	 7Yns+og0kU6s5nYmKOFG0xmplAOpCnKMo9SOBdui3NBWCMmjYQZAP23V8z4q7oEZH4
	 43a+gynLXMqFNG29fdpTtVWl5b1gSOV5S5uD7m4eGodOefexiLcB5IUJ+tH9hFod69
	 hHGtzmcFLrjUzOHmlMTevdR8hRHQGt337M1kwigPh1HfDSVHzbwuuLKOC86kBQpG1s
	 ejmF+z88grgyYgTsTNGriBD8+Bw8McyXpw5L9Cn5DuTo3ARPFRS0/PZ46KRYSOMJTR
	 iyjx5IQL82sMw==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso128922646d6.0
        for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 15:09:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+8H7bS/j2ZINk3WVYtlnmzbNLkyADEcm21UkZ4bZw9Y5dFChkZfxduAgTHtlUMu/4sfQyiDt0wC/L7Hc6Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yydih661DfOsmCflbbOS9UHXNlJkqVC34x5n1r7CoESwObs370Y
	/0lKO46snE96AWGrEuV+83QjZIUErNJC/SNF7hf6e2DKWyyg8v6FlU21SLX+Z+M2f5o3WhZw5AT
	uMdmKVQ99Syi8U2NfQUvBR1lM5hDMthM=
X-Received: by 2002:a05:6214:518d:b0:8ae:672d:36a5 with SMTP id
 6a1803df08f44-8b0281a0fbemr495022486d6.51.1777068595596; Fri, 24 Apr 2026
 15:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776916871.git.jpoimboe@kernel.org> <11a0af398f5ebd591e87f3f8627bbf512260549a.1776916871.git.jpoimboe@kernel.org>
In-Reply-To: <11a0af398f5ebd591e87f3f8627bbf512260549a.1776916871.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 15:09:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7tR9jk9AWTgM=gtBK9MkR8q2UHQj_vWSB87ftXWqbsEg@mail.gmail.com>
X-Gm-Features: AQROBzANmTWZpCG-2gtphCn0UjJSGzelHcrQNYsqrNi71MOOnjQoGa_Ew5Pb-dY
Message-ID: <CAPhsuW7tR9jk9AWTgM=gtBK9MkR8q2UHQj_vWSB87ftXWqbsEg@mail.gmail.com>
Subject: Re: [PATCH 30/48] objtool/klp: Handle Clang .data..Lanon anonymous
 data sections
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 9:04=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Clang generates anonymous data sections named .data..Lanon.<hash>.
> These need section-symbol references in the same way as .data..Lubsan
> (GCC) and .data..L__unnamed_ (Clang UBSAN) sections.  Without this,
> convert_reloc_sym() fails when processing relocations that reference
> these sections.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
