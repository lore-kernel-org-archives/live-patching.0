Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26B41B8C3
	for <live-patching@vger.kernel.org>; Thu,  6 Aug 2026 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051318; cv=none; b=ZZMKtw6Sm1/7QZiqmfVcDnlwrsB/V7utngOVgHm0mPsH623fVZtDvvrJ/VB4DbF8ofEWcEH66+iZaNr7XpRKBFb772obhv30TQfk6N8tvJnbWZygD6kt9Wps4sEoNDf/on9t7vwYSQCL/BruynMnU+BgeK1he13oSNzAYeRdRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051318; c=relaxed/simple;
	bh=aGXLZvyQelkPQT3cxfLKxCKRSHoaeyboW4i8S8SEvIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHJ4o/srSMxlpDh62zsk66qoiMQ4cNoZhD/C7Uvz4pVtfozQnC+Q41lHpH48k9A11+LUssWGR5gn/vG2o6LcsOKHIAVYd/aest6oobOyZWaOWaD75lDqUxaqypEdNfdYvaEgz2U0azygFSKa9vilCrLSKMyxx7us+3usbrC0evE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m379iGcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m379iGcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA101F00A3F
	for <live-patching@vger.kernel.org>; Thu,  6 Aug 2026 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786051317;
	bh=I2TwJ5gWdspTnscejso/2PwdAtoi7VMpYmdyEkn6CtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m379iGcyCXIRcdKY1yEAzDFRuSv/TTX9kPUPFaX/8dTcd2FCugXDRhJsvXeueSbr5
	 NE6lIQwSzSF5IVZxBiQcBZO40zE6MbeRl9j0ZW7LLzVTApyJXq4NdodTAafUdIv7Mx
	 ClLJ9B1IM6obBZzePW7U5k65NHwQVBa4MV9kYmop7whGUsGFryNoGmGpmmNSIcfZYC
	 v9kKKkSzclYnJd9lfqTPYQfOoPqzLIPCHFHZV9oN2KDZuF824gl/eMq/dSoIrauD+K
	 5D5AnFz+4uuadosxYdB96Qv9k9ITZPQZUNQEfHv4C/Iz4ZtAmQcKMSNb20b9ShcFQi
	 mQnx0cbQEFlIw==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e50a650a0so149970085a.1
        for <live-patching@vger.kernel.org>; Thu, 06 Aug 2026 14:21:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro2Ur/OUHUZHVb1ssQsnwaLPwUJAa5NAMMG0d0MVjO60voe7LRXrBxDlZ5wz3zrUtIbSrzR5ZoiJ4hR+cQn@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeQ9kUcHBoUp8MfFTWBywLsSUqadSvLmFopb5WiMsF3b1vamV
	OW6vEReqDtMeMwB7uDdl4fGNf4QwFt67ZRlEJ4Pm2YKF4PLeQ1owa4F7dxCgHQxZZnW3gXdF4Za
	trmQ4iEsC6AuFUNnuXPupfUaGznzB560=
X-Received: by 2002:a05:620a:1b92:b0:92e:da7b:561b with SMTP id
 af79cd13be357-93649165185mr1988040185a.19.1786051316432; Thu, 06 Aug 2026
 14:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com> <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
From: Song Liu <song@kernel.org>
Date: Thu, 6 Aug 2026 14:21:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
X-Gm-Features: AUfX_mzFjwnQcUwC3lCRH_Ph_LR2tCAIsoyHf1ype-ho9x4_lwjyfQEXdHzODNQ
Message-ID: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz, 
	jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> callers rely on ftrace always being on). Refuse the write instead of
> leaving it in an inconsistent "disables some, not all" state: return
> -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> unaffected.
>
> Update the docs to note the deprecation up front.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

Sashiko's comments make sense. Other than those:

Acked-by: Song Liu <song@kernel.org>

> ---
>  Documentation/trace/ftrace.rst |  5 ++++
>  kernel/trace/ftrace.c          | 43 +++++-----------------------------
>  2 files changed, 11 insertions(+), 37 deletions(-)
>
