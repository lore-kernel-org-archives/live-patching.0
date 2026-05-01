Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F94414
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637818; cv=none; b=hzDXGBQaaTdEI6CQ1CV47tq4X5H6mgWCn660+b8xjnANRJuogchf8N5NbNES+ub4/7jy/g0cOWFNBA3BkCyx8LzZ7Qa6ZabvMjETfFZM8NG00qrNkYlimkKC9jfjvn8i3Ps45QevjBIeFwXjzD7Tybajpst8L2/yePRP7EaP+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637818; c=relaxed/simple;
	bh=hvuJvU/eQ6dJBBSjptOkaqOU8Ya9HRA2qoW0htR1Q04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQFGyoaAvqi2d3DmTkjxMq0PQeLIjVNfC3YaSwB5ikl2oVkA3lrEsE0JSt0IwBm4b3KygukSZUWFS0ajoqNvNko/mRFTSc+tMFB0eLdWY4LHBgOhrNNPLSj1djOqobaPTH3+KLE5G0zV74SnlXzmDJukG7Yv9a26IDGl7KDSIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUaIJ7ja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUaIJ7ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2503DC4AF09
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777637818;
	bh=hvuJvU/eQ6dJBBSjptOkaqOU8Ya9HRA2qoW0htR1Q04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DUaIJ7jamYs5C16DeiPLQTZ0it3EXt0eKrTB4gRFhF74HlirfzCukE7d4yW2ukgNm
	 qF8AsfFREhoMUKsDK68Z+/ghcGIjO7h+lQ93E/JTp8sNcnOEtqGpvcSfYIMnkP4Oht
	 Ac9XUcPdWo0arUwEXMZEboKOHIFIOREusL7dne2/Bm5xOPMCukU7tMSVDGRk5AdyKz
	 9HOa4itQE5jBBXGRLXxbo0vpart5K3is60wtuAvuJ0lVdxoXUNI6orTidXY9Lol+e9
	 46P7JGUHf0+LsCI1ZEFvAWgfy0DouMMZLUXYtslwOYk8y6gyd+o7CN0iyKqiLB7vcQ
	 picu/7HUzh5xA==
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-956948531a1so553510241.2
        for <live-patching@vger.kernel.org>; Fri, 01 May 2026 05:16:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+C1JT/HScheY1kQ/KyoGwyD5t0t00YPb22Oa0fBjYwpx/jbPzSSOwCMJOXGE/IEoLWBb62uYtjtoGJqlb+@vger.kernel.org
X-Gm-Message-State: AOJu0YykW4FijfVsQIwR2nso5UBWx+hZ3AWoogHhOQJyO53nuvvB+Y5d
	1wyee8rZwY3tFV4UYl1u1XXvBbyiOrlkxHzLlTqOF0XVxJcw6GrmTXWO6kWiRgLQPci7Jbkypfk
	Zf3TqwonC0Ju8JTZY8sU4YVgyJmShCzA=
X-Received: by 2002:a05:6102:290f:b0:608:8fb9:9102 with SMTP id
 ada2fe7eead31-62ace7c50ecmr3584122137.0.1777637812866; Fri, 01 May 2026
 05:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777575752.git.jpoimboe@kernel.org> <b9fe30f891bddaff919e48bc2f620f7f66fa98ca.1777575752.git.jpoimboe@kernel.org>
In-Reply-To: <b9fe30f891bddaff919e48bc2f620f7f66fa98ca.1777575752.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 1 May 2026 13:16:39 +0100
X-Gmail-Original-Message-ID: <CAPhsuW74eXpt1fm0PkdGPvg40UOqNHMnqLHmVP8gkoNj6GKVCA@mail.gmail.com>
X-Gm-Features: AVHnY4KXD0BvNwptT-UQ6FVjV6SrsuCT_f6SxvMRMTM2ZGwKPB8vEgzunMhkYQ4
Message-ID: <CAPhsuW74eXpt1fm0PkdGPvg40UOqNHMnqLHmVP8gkoNj6GKVCA@mail.gmail.com>
Subject: Re: [PATCH v2 49/53] objtool/klp: Fix position-dependent checksums
 for non-relocated jumps/calls
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 5:09=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> When computing klp checksums, instructions with non-relocated jump/call
> destination offsets are problematic because the offset values can change
> when surrounding code has moved, causing the function to be incorrectly
> marked as changed.
>
> Specifically, that includes jumps from alternatives to the end of the
> alternative, which from objtool's perspective are jumps to the end of
> the alternative instruction block in the original function.
>
> Note that 'jump_dest' jumps don't include sibling calls (those use
> call_dest), nor do they include jumps to/from .cold sub functions (those
> are cross-section and need a reloc).
>
> Fix it by hashing the opcode bytes (excluding the immediate operand)
> along with a position-independent representation of the destination.
> For calls, use the function name, and for jumps, use the destination's
> offset within its function.
>
> [Note the "9 bit hole" comment was wrong: it has been 8 bits since
> commit 70589843b36f ("objtool: Add option to trace function validation")
> added the 'trace' field.  Adding the 4-bit 'immediate_len' field now
> leaves a 4-bit hole.]
>
> Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-=
function checksums")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
