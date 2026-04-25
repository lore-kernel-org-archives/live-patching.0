Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC6481DD
	for <live-patching@vger.kernel.org>; Sat, 25 Apr 2026 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077047; cv=none; b=szTUdhYVUfo2KLlY0uv0f+vK/dZbzO5rIn4CFy6ABLwIPkq8OEYE2PIA1uXW1WAEuisAots1GUEHdlfDenmCajunNF5rb2Ha6iWGNK7elXSiPgnbB3LtWQLR++WTibP6vGmfkXpPmQQpFWm6bJAXeC1eBiXlZsUhimd0V36szKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077047; c=relaxed/simple;
	bh=VctFBaAbZpb0ct22/tZpEzdYheNXu2jlBkgoyOp/IsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue5oZRLHoym8gjqq9dkuxId9LEB4ayAQ+3ebr42fpaIWOeHVtskeKT+zLgQbYg/9BQw00Y6VPdstt6YwwDj198OIIDlRo1AyoSHfko00bXMjnfrmUKzwoBOjplqbNrYIh8Esdn3chFSronC06t2CuZSqs/Ws4xDKvk9z3Bnu0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=At4Xrkop; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="At4Xrkop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0FCC2BCB8
	for <live-patching@vger.kernel.org>; Sat, 25 Apr 2026 00:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777077046;
	bh=VctFBaAbZpb0ct22/tZpEzdYheNXu2jlBkgoyOp/IsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=At4XrkopsbUVMaDCcjd5XNw6q65E1a9CFvjgVnOsDXeWTqPrQyk7cVxlBMtOhWOvA
	 QML9BYFEDyF0/VzxK870Z7aCVdpU98Wr1QPM7WnNwXsAZpREeo21SKPLkJgmCTFIK/
	 AnTkY8mXwnq2lF02u4sOVwEVpi3dSYWi7fh4jK4dMsilKTZ6KExllLFdFqatQHNswa
	 gVx9H1rx51n54YEcH295pMlUwYjnXQM/aHOj4vSghhzL1hOJDZy/BD+0KMl359zxWR
	 Ihfu5jA8JtdqotLtFAavavSwpuC+z1PyQkuLCZuBY3PIsxuQReTsdYwHfVzzKKJ7Yu
	 MS4pbQvL9yJ3Q==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50335b926c2so65478801cf.2
        for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 17:30:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/lJZ7SJhWN1dkUxJIaGavvbum+MMwcJNIn0GIWoSa+zJxkzUU0ZdimOpx3ijC0Be8YcOVogMQtraMkfRjD@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLsn2KDVArMsvrn4bC4WQ+vgrEHuQ9HW9ze7D/YqHUZtHFYd2
	Et0baGLetuNVwqIjxVZjyauYqsaSgYpGOHLD70CnUGBKEpk16BH4Mwo7kdMk1RZXQLMq4NNGN9m
	wcDrIgn+qkjvYSglHYifD7lDew82QFZc=
X-Received: by 2002:a05:622a:4d96:b0:509:35d1:ca3c with SMTP id
 d75a77b69052e-50e36b86abemr531444221cf.5.1777077045773; Fri, 24 Apr 2026
 17:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776916871.git.jpoimboe@kernel.org> <44757e0c259e4651275e24b49dc9f7220ecfe16b.1776916871.git.jpoimboe@kernel.org>
In-Reply-To: <44757e0c259e4651275e24b49dc9f7220ecfe16b.1776916871.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 17:30:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7dNoh4uhQrPWG8T5BpFT+VNgrSevrFyg8mQLk3GxJgdw@mail.gmail.com>
X-Gm-Features: AQROBzBXfd4ntieSjUlMg8ebmYpIgr5r4UlHtpEjNJ3tH-Vg3g7_gEOWBxqfIa4
Message-ID: <CAPhsuW7dNoh4uhQrPWG8T5BpFT+VNgrSevrFyg8mQLk3GxJgdw@mail.gmail.com>
Subject: Re: [PATCH 42/48] objtool/klp: Add correlation debugging output
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 9:04=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Add debugging messages to show how duplicate symbols get correlated, and
> split the --debug feature into --debug-correlate and --debug-clone.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
