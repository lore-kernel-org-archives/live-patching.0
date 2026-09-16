Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3C4DD3B8
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580004; cv=none; b=iRK5q3WIArAql9XHU/ArV1cFVzPvEeqfz2E3k3sil2L8SAQLgoOIlv8B0EWn+/yaI4t637fcHUxSyLXeBYX2SAQbI6bZCw1/Z4kasi27i+RSVztjLNezW4TTsas4BRDa87K5s8m0XDM8PSmIE2V4TO58xb7CUf/buczT1mGsuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580004; c=relaxed/simple;
	bh=oxxLIQJVG9y2hRqf7oYH0gtM4IM2io6qHNr061kuKFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsnUYDqAkNg8IfyRhK9vkyjVH1XaTPXswRaf1iAQmr/ft9mIdglVzgnElTH/BaiLPZZ0H74WHQiu6xBHq/S6en8jYiOzWIhk1eaeqMWQjTEOGqRV8T/yGwzgfQ67Ue5AlzTG+kXWFV53P4cPY80M/bBK9MNOwWzG/6VBbWQPdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhKtSlvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhKtSlvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF1D1F00893
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789579996;
	bh=yBrxvdBI6yoDrciFAtyFfhI7wXGNYhQJ29J3kzW07OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OhKtSlvWiljVbTORRPFWuLrYpVcJlnKE4TVAMvrmniWEXzjFhGStCejKi4+YyVXon
	 DVzphPYdXvbbz7L5wLbXCZH/4FD7Xn8iVjKm4YhLd8wCJtbOHt6Sebrl2x0230rjDn
	 YspujyU9hKXpe95qyFIX2Y6V78noe99Z8yL/lHDop4/Y+f+vJuIuXldh2TDneES4xp
	 9B8Ju71uINI2uOx8xLKn6UVAMaX2IoYeGBoHR+ZdS9EYpBJHgYeQi/+TK7Kmk9b+1q
	 xnJTtxdmR4MQ4NtvBEva9n1PVLA8FJzpDZ5nlB8onXDglffAZPLgS4FdHg0HF2w1zz
	 Lp1oKMgNNNaBQ==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a2dea320fso128662785a.2
        for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 10:33:16 -0700 (PDT)
X-Gm-Message-State: AFuF++kxyijmVi3jImgkXYY+1LxwCgLAwmVcjx1DeUJfe42sx5xtySDF
	4CzYzFETeuV/JK3ld138je2X4bKxCmbb6CeDl8iIFIdRf6UvyNVerJ4oaKBi7o3kHV6MJ0H+Xf8
	0m1cUdILWk575GZxLKC1fmCFmtsEHJw4=
X-Received: by 2002:a05:620a:6014:b0:939:d38:3ab8 with SMTP id
 af79cd13be357-93bb771c4b4mr690362685a.12.1789579995360; Wed, 16 Sep 2026
 10:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915233454.2405019-1-song@kernel.org> <20260915233454.2405019-7-song@kernel.org>
 <20260915235039.29AEC1F000FF@smtp.kernel.org>
In-Reply-To: <20260915235039.29AEC1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Sep 2026 10:33:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5VZ6KiVX2qg6MtJ2vazFTr7+o-RUdhptcHiSCOL_ZpyQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xh24EVB4DXSVfRTpbM1YfbdhYiGwYC_7RVD2TLP0ybZ4xHuYpVRKgLeWU
Message-ID: <CAPhsuW5VZ6KiVX2qg6MtJ2vazFTr7+o-RUdhptcHiSCOL_ZpyQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/58] objtool/klp: Grow the klp test harness vocabulary
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, 
	puranjay@kernel.org, peterz@infradead.org, mbenes@suse.cz, 
	jpoimboe@kernel.org, kernel-team@meta.com, joe.lawrence@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool: syntax error in re_quote() sed substitution
> --
>
> commit d250ad3b119a644d241a85f86850556fd200db22
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Grow the klp test harness vocabulary
>
> Assertions for what klp diff produces, and for what went into it.
> The output side covers the things a livepatch is made of: cloned sections
> and symbols, klp symbols and their sympos, tombstones, and relocations.
>
> > diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> > index 9330d839ff850..ffc1efb06233c 100644
> > --- a/tools/objtool/tests/lib.sh
> > +++ b/tools/objtool/tests/lib.sh
> [ ... ]
> > +# re_quote <string>
> > +#
> > +# A string as a literal basic regular expression.  Nearly every name t=
hese
> > +# assertions match on contains a dot -- .text.target, .klp.rela.vmlinu=
x -- and
> > +# an unescaped dot matches any character, so an assertion for one sect=
ion can be
> > +# satisfied by a different one whose name merely lines up.
> > +re_quote() { printf '%s' "$1" | sed 's/[].[^$*\\/]/\\&/g'; }
>
> [Severity: Medium]
> Will this sed substitution work correctly in POSIX, GNU, and BSD sed?
>
> The command sed 's/[].[^$*\\/]/\\&/g' is invalid because the delimiter
> scanner processes \/ as an escaped backslash followed by an unescaped sla=
sh.
> It treats this slash as the end of the regular expression prematurely, wh=
ich
> results in a syntax error like 'unknown option to s' or 'unterminated
> s command'.
>
> This failure causes re_quote() to return an empty string, which makes
> assertions like assert_section silently pass by matching any two consecut=
ive
> spaces in readelf output, and others like assert_klp_sym consistently fai=
l.

I am not sure this is a real issue. But we wil change to something like

re_quote() { printf '%s' "$1" | sed 's|[].[^$*\\/]|\\&|g'; }

in v5.

Thanks,
Song
