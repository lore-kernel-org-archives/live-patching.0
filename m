Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F2397E73
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487821; cv=none; b=ng76TXU0RMjq1yU40if0p7EZ6kVzurViUMcy/3q8ksrKNkZck8KfbltG+hsIZWK0DMxI36c3CHai4KGHhS5krNAV48K4biZrUCnAZqqSfjNVLx0ep9fsbNYKWW/AzNzE9enZf5++yAsuTccxH8hgxMNaRtnSLRTWQ9U9OMqsrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487821; c=relaxed/simple;
	bh=rzMhM3FcIrKHTU357iiMZeXP2RmA9FNJoPPqk3KH8bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e56A1bLtFHPWQuE61PvtnUCBlDj8ZIbZU16gsHBcdnLSU9CJ7QqNPDhE3EJmsLoJbm5y3SdluNFxuBUOaSuCG70S/6pw9itHnKU5fUo/t74w3VZNkjVF2ty9ZscFxXfVmBZid/RRDgxZXCTJjxEfjoRW+YifQ9ADR1kostj7kik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7hI352E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7hI352E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99761F00ACF
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786487819;
	bh=9UHtxr6BoTphw9k5sX3XVfj3ISvPw+UbHGwczai7TkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I7hI352Eukth5ajE1H7cAyMzHJ6s/pQ2CJEztWyKNkLaAtk9qiwneZrzlauwOIVEv
	 SnUUhetMpNG5jiIsn3CRHfzI4pksiIphb5ixlLy7FxKgI+g+RkNCrqDPMXtbnxrfEi
	 l0NVJ2CGgQIUp8VEZ3EY8QEddP06wKO/r+3EroabK5xSZBxVFUHPZwIvIknSS2WClH
	 mc8McUsvQQZtCmx7vwo+PxSLXgjMI8kybvui/+YFdNsPNEF0LL6JvEJIT27gMH/v3i
	 VvivzdckJQM128oWmq5iGWSNTYxYCNwOepQ4zhyraYrOFGriP7CnaxGZ08e9MEDLZv
	 epo0s95OgCU/g==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6391b114so36305885a.3
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 15:36:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpqhbX6axmWVecbRM6O4EWPKenCOhiynhHUZmsPnJdXy3v1zTRsAQ+orQJYesw7wVs5Di1ulj32cVUsVOBB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcd6AQCmD94VpHApUrAJaPxWeSo2vGo2NriBJ3y3Nsxx4Zc+ew
	lYUWhpZXx+Xl+8qYndHG9aaVRSwGJFhZc98BSiOz6C8NBjOlohhMgEFTMiooc1z93QqWF5mbnGA
	cszrV6rpL3awcJZ6TTo6xo+3k92pTzS4=
X-Received: by 2002:a05:620a:3911:b0:92e:e7e0:ea45 with SMTP id
 af79cd13be357-936b3e36a02mr72308285a.47.1786487818942; Tue, 11 Aug 2026
 15:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786138493.git.jpoimboe@kernel.org> <133e16bb0c7cb916f10bbfb017eba525449ad1d6.1786138493.git.jpoimboe@kernel.org>
In-Reply-To: <133e16bb0c7cb916f10bbfb017eba525449ad1d6.1786138493.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 15:36:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4=kHYNU=hy2wbhNAhP1m+-5YoHDi6t+NdHvdH6yis4FA@mail.gmail.com>
X-Gm-Features: AUfX_mwmX7riQmQVeoqYOiFspLFwZGi95ugHIur2R3T0K_7q3UEZxTJK4aEvEZU
Message-ID: <CAPhsuW4=kHYNU=hy2wbhNAhP1m+-5YoHDi6t+NdHvdH6yis4FA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] objtool/klp: Fix line numbers in Module.symvers
 parse errors
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:38=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> read_exports() reports the offending line number when it fails to parse
> Module.symvers.  The counter is initialized to 1 but never incremented,
> so every error blames line 1 regardless of where the bad line is.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
