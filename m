Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD73CF977;
	Thu, 14 May 2026 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797518; cv=none; b=nIK4UstiNwdyTsmw7ybNJwiRXM7OVldMDT1l47Rvzqm3YWDjKGhpwn5/JHz+g32BdnZ4OzUQ/IDNc7a6ngC4uQaU3cCEZqqGW4zkUF/e7rUsHFrH1+QxeWbhp9D75kvAffma45jnUj+l8eQCxcJkSftg/GZ9ZlGUPMygXZoao50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797518; c=relaxed/simple;
	bh=l4n1GCkss3HdumT9TYk9D1dQsWaT9kxRVhMfzwbcBDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPktk+Xq2expxcEFDWSwNwqdYXZAeL0RqmZNOpFRMhiIbylsJ0ONzEG2dAq8BSe+6YpOxHQtLtAG8MF9myk0trnewkP3iXnWM3MfucscVMpQPZbzPE1ofOW3ahSJuKn5BGIAtXbX3YMKvbCfUe9LTE3vDIEwXesD9aVJYHlSaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA1BYrod; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA1BYrod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2437C2BCB3;
	Thu, 14 May 2026 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797517;
	bh=l4n1GCkss3HdumT9TYk9D1dQsWaT9kxRVhMfzwbcBDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AA1BYrodfUHXEl65jh+fNAg+8mo1kGu/2Jn7U16Af+p0xZjpjjeVcVypmIjHWFAeN
	 NnX0xWg4UulKnyi0CdfCwAs9eWf9S5L0X6UIFX2sMn423HC3Rfgah3UHGleTMxMMgu
	 wHo46egB7gv6NCD3PGDz6yNNbhODIuqC5joMUFqdE04QYrwL/80N7Qtxgju7vL+Tih
	 romzAo6uuFLMuDRDQm4hvE3Afz1z+lCcFMdnYrDxQd+ipgmKqZqVIu/3TVhelVNBl+
	 cUVEivtUcxAOpJLOzi/OKwFLkM5o3YzYnd9OnELchlN4+yrLgyXDq/GP4eyAyvTLsk
	 6tEx23VluLYGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/21] kbuild: Only run objtool if there is at least
 one command
Reply-To: sashiko-reviews@lists.linux.dev
To: x86@kernel.org
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Song Liu" <song@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Joe
 Lawrence" <joe.lawrence@redhat.com>, "Will Deacon" <will@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Nicolas Schier" <nsc@kernel.org>, live-patching@vger.kernel.org, "Nathan
 Chancellor" <nathan@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>
In-Reply-To: <8699672b82fef17e73a5f2e5528478778dbdab31.1778642120.git.jpoimboe@kernel.org>
References: <8699672b82fef17e73a5f2e5528478778dbdab31.1778642120.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:25:15 +0000
Message-Id: <20260514222516.D2437C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Leaking objtool options into vmlinux.o validation causes a fatal bu=
ild failure (`--cfi requires --prefix`) and silently alters validation beha=
vior.
--

commit 68e454f3a8ccd3d638c67c092eee264996286695
Author: Josh Poimboeuf <jpoimboe@kernel.org>

kbuild: Only run objtool if there is at least one command

This commit splits the objtool arguments into commands and options to
prevent objtool from running when no commands are enabled.

> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 527352c222ff6..09af33203bd8d 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
[ ... ]
> @@ -36,18 +36,13 @@ endif
>  # For !delay-objtool + CONFIG_NOINSTR_VALIDATION, it runs on both transl=
ation
>  # units and vmlinux.o, with the latter only used for noinstr/unret valid=
ation.
> =20
> -objtool-enabled :=3D $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
> -
> -ifeq ($(delay-objtool),y)
> -vmlinux-objtool-args-y					+=3D $(objtool-args-y)
> -else
> -vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+=3D --werror
> +ifneq ($(delay-objtool),y)
> +objtool-cmds-y					 =3D
> +objtool-opts-y					+=3D --link

Does this code unintentionally retain the options from scripts/Makefile.lib?

Since objtool-cmds-y is cleared here, commands like --prefix are dropped.
However, because objtool-opts-y is only appended to, options like --cfi
remain active.

This causes objtool to fail with a fatal error: "--cfi requires --prefix"
during vmlinux.o validation on configurations with KCFI.=20

Should objtool-opts-y be assigned directly using =3D or :=3D instead of
appended?

>  endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778642120.gi=
t.jpoimboe@kernel.org?part=3D9
