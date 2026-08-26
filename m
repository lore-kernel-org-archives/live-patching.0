Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410D3B4E9E
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774275; cv=none; b=vBdQgwpr+W81xuepewUWXQJ4nrae2mXBh9o5K6k9QsgXwZA5VBm7+4N0f9DFy2gWXQLrK4SIAj5kV+XaoF53s+oeImUqNDSZCkii1q61aKiXeJya3FKZ+qMZqgiyeotgVZa8bO4IBJRVpLTVtjUbfLrh5URZJ4aWYiCjc9J8dBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774275; c=relaxed/simple;
	bh=uxXxAvfkDFlI8TRTnTBsa4zpZLePn6rb0itxPnE00t0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LwLZ5NPW+oZGNatjVKSDEf1a84ZeGGgaFqOOnf4NwcKet+LffWzzSXCNZ545RtIifSwSEXAV1ihf8naVfUN5bXNon8BQjjgvBtLsdyJtJaL574SMQjK8sxR/vJUEmIChbbagQqhn54gLlRjZ4IqFN3tn3RRTECLg9w42V8vj9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkauhUrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkauhUrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA291F000E9;
	Wed, 26 Aug 2026 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787774272;
	bh=XzhblqCdZZ9Anzpg4KbDxB5gWuaoQ4l3bzaCDI+Dz5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mkauhUrLPmpjcBoVF2UQtb/WfHyepVtUySRmSXpf3EwUeAmxS0dXZYZQcNUVz/mpJ
	 LiUzjT7qzTTjfL+v+1uvNgVdLjnpxxLp3I/nSWHk9QP+OPT5MNdOAe9Jse3fI84+qn
	 eD98DUgVxSDd+3A3q/cyjlicvZwtDnFuV4UbdrPmopy46doRr40lKzR4QXfigxCvPw
	 XsZWSf3Hpzicol+Nq3N9usjuTOG249GCSnZYgW/VmTL5G5qiP9sQD3b7CaJr6KHMk+
	 Zdn6cRPZlFgzHejkDNaRws1W44MGKdU8liNo/HKPL8kd1LDG3tOYcPvfSxrvWMkoXR
	 nwCIbQaGm5mEQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/7] objtool: add target architecture to usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joe Lawrence" <joe.lawrence@redhat.com>, live-patching@vger.kernel.org
Cc: "Yafang Shao" <laoar.shao@gmail.com>, "Song Liu" <song@kernel.org>, "Petr
 Mladek" <pmladek@suse.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>
In-Reply-To: <20260826195000.455905-5-joe.lawrence@redhat.com>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-5-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 19:57:51 +0000
Message-Id: <20260826195751.CDA291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unintended macro expansion of architecture names during stringifica=
tion results in an incorrect objtool usage string on certain architectures.
--

commit d81c5c3b288ffe16035a8655c9eb901dce1a358a
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool: add target architecture to usage
   =20
Display the target architecture in the objtool usage string so that
users can identify which arch variant of objtool they are running.

> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index a4484fd22a96d..c73c80af5ef3d 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -61,7 +61,8 @@ INCLUDES :=3D -I$(srctree)/tools/include \
>  	    -I$(srctree)/tools/lib
> =20
>  OBJTOOL_CFLAGS  :=3D -std=3Dgnu11 -fomit-frame-pointer -O2 -g $(WARNINGS=
)	\
> -		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS)
> +		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS) \
> +		   -DOBJTOOL_TARGET_ARCH=3D$(SRCARCH)

[Severity: Low]
Can passing the architecture name unquoted here cause a regression due to
compiler macro expansion?

For example, on architectures where the target name matches a predefined
compiler macro (like powerpc or sparc), OBJTOOL_TARGET_ARCH becomes an alias
to that predefined macro, which the preprocessor might then expand to a val=
ue
like 1.

[ ... ]

> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 75b11dc85010e..64651d90986fd 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c

[ ... ]

> @@ -23,7 +24,7 @@ const char *objname;
>  struct opts opts;
> =20
>  static const char * const check_usage[] =3D {
> -	"objtool <actions> [<options>] file.o",
> +	"objtool <actions> [<options>] file-" __stringify(OBJTOOL_TARGET_ARCH) =
".o",

[Severity: Low]
Will this usage of __stringify() introduce a regression where the help stri=
ng
is incorrect on certain architectures?

The __stringify() macro evaluates and expands its argument before convertin=
g it
to a string. If OBJTOOL_TARGET_ARCH evaluates to 1 due to predefined macros
as noted above, the resulting string will be "file-1.o" instead of
"file-powerpc.o".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826195000.4559=
05-1-joe.lawrence@redhat.com?part=3D4
