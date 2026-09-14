Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6223E638D
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418260; cv=none; b=u6Z/ABcROOgiWtt+KzKUZEchzg1wOSOjt/jaUI+52Zzvg86fihruAUSS2hGasjpGefz70lTpnXas0GvBJw+eKJCgNGw5y+m4quORc12XjlLj1B3MZpcWOhdplLMI7aCRMQKNmaxzxmCN7ePKVhxysYdmZJUY3Cm2U/QAVys+GQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418260; c=relaxed/simple;
	bh=b48asTn0wdvaGkrugHyVu7XhE9anx3Kqyy50V9PpMlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjTRXt5LG7DGarf3STOhnVshMhIr5jpmySNMl9t/gM0mmYK8kXv/ueSYeT5YqYkFsNUZ4vYSXyyzajBld8/vkaYsd2w73nrPEDHzlsk4qmNd0zMhAeNb/vUw5z6oJQABFEcmfHUGAzbU7B6UyefwixD6o3jQnX9JR+zBIhwV1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c44NMlO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c44NMlO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872051F0089C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418258;
	bh=lnqw0YQ3/1MlDRL6yBeuiYQoFqnQKMVeC8u5gpTWh2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c44NMlO6ojhQW0cH9DZH7VbmvQh2GfaioarIAsdc2CsLIaBaE3ydCHy+Vmje03PxL
	 sCxbef8mo1vT1jhYHrsgU4ZHOPPNvFvqtHu6Hj43c6CaWPLzQmySkjh7zNToJH98Ou
	 QhckDIg/7gUfyVQQHF704Z6tTqPEUtLO4hyCVOP+08yVXEZYWHZOR4hKs+uTo1BKdX
	 WFSik4VGgTxLspA34dKv/E5BT4/1dMunK2gQA3CtzKwhNpBDfpizSlNTACmaP6FeCH
	 HrhUsO0B4d/KQmqlnZeqKHsrUua92404mu2kAtxAN3VCn2V5IeQhxkvI3DsSXPcddU
	 gO4VOcoZuizUQ==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-939e59ff27eso355807685a.3
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 13:37:38 -0700 (PDT)
X-Gm-Message-State: AFuF++lT25ZvXSnE8f9KJ8XJZm1ISsGS5ZIhVtBKTEBHdiUt+1q733gT
	98PsfQC6WTtYkHScqyMB299a2yz9470jYUptY7lhJvMTF3ya2I+P8RXMXTzhIplsu7iiyFyqGnR
	fXNfyYOPm0LtAJENlq3erxKrewXsXymU=
X-Received: by 2002:a05:620a:6892:b0:939:8ecf:6025 with SMTP id
 af79cd13be357-93a297bbc66mr588336485a.20.1789418257585; Mon, 14 Sep 2026
 13:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-7-song@kernel.org>
 <20260914064106.D54991F000FF@smtp.kernel.org>
In-Reply-To: <20260914064106.D54991F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 13:37:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5V4cxhYJL9awK3yO3Kz8QW3Od0gUhVCF8QTg=vQ5Z=mQ@mail.gmail.com>
X-Gm-Features: AcwNN1XtYcpY7ablM23GzcNBZ7WvJnmvycBM08szbQiy-jYr9xvfQyDMqzdcN5k
Message-ID: <CAPhsuW5V4cxhYJL9awK3yO3Kz8QW3Od0gUhVCF8QTg=vQ5Z=mQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/58] objtool/klp: Grow the klp test harness vocabulary
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, joe.lawrence@redhat.com, 
	kernel-team@meta.com, jpoimboe@kernel.org, jikos@kernel.org, 
	puranjay@kernel.org, peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:41=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Regex boundary matching using `grep -qw` fails to enforce exac=
t symbol name matches because GNU grep treats characters like `.` and `,` a=
s non-word boundaries.
> --
>
> commit cfe07e1e9cf1d7d13ada28e3a4fcdc25e8dd8672
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Grow the klp test harness vocabulary
>
> This commit expands the objtool livepatch test harness vocabulary by addi=
ng
> assertions for both input and output objects. It validates properties lik=
e
> relocations, symbols, sections, and checksums produced by klp diff.
>
> > diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> > index 0a9da178f4dc8..40fe740821582 100644
> > --- a/tools/objtool/tests/lib.sh
> > +++ b/tools/objtool/tests/lib.sh
> [ ... ]
> > +count_input_symbols()
> > +{
> > +     in_symbols "$1" | awk -v n=3D"$2" '$4 =3D=3D "OBJECT" && $8 =3D=
=3D n' | wc -l
> > +}
> > +
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
> > +
> > +has_input_section() { in_sections "$1" | grep -q "[[:space:]]$(re_quot=
e "$2")[[:space:]]"; }
> > +has_input_symbol()  { in_symbols "$1" | grep -qw -- "$(re_quote "$2")"=
; }
>
> [Severity: Medium]
> Since GNU grep treats characters like dots as non-word boundaries (as acc=
urately
> noted in the comment for count_input_symbols() above), won't this allow f=
alse
> positive matches?
>
> If a test checks for the symbol "target", couldn't this falsely match a s=
ymbol
> named ".text.target" or ".klp.tombstone.target"?
>
> [ ... ]
> > +assert_reloc_sym()
> > +{
> > +     section_relocs "$1" | grep -qw -- "$(re_quote "$2")" ||
> > +             fail "expected a relocation to '$2' in '$1'"
> > +}
>
> [Severity: Medium]
> Will this assertion mistakenly match base sections like ".text.unlikely" =
if $2
> is ".text", because grep -qw relies on word boundaries that do not stop a=
t dots?
>
> > +
> > +assert_no_reloc_sym()
> > +{
> > +     section_relocs "$1" | grep -qw -- "$(re_quote "$2")" &&
> > +             fail "unexpected relocation to '$2' in '$1'"
> > +     return 0
> > +}
>
> [Severity: Medium]
> Could this negative assertion falsely fail if a similarly-named dotted sy=
mbol
> is present? For example, failing to verify the absence of "foo" because
> "foo.isra.0" is present.
>
> [ ... ]
> > +assert_symbol()
> > +{
> > +     out_symbols | grep -qw -- "$(re_quote "$1")" ||
> > +             fail "expected symbol '$1' in output"
> > +}
>
> [Severity: Medium]
> Can this check pass falsely if only a tombstone or section symbol like
> ".klp.tombstone.foo" exists when verifying the presence of "foo"?
>
> > +
> > +assert_no_symbol()
> > +{
> > +     out_symbols | grep -qw -- "$(re_quote "$1")" &&
> > +             fail "unexpected symbol '$1' in output"
> > +     return 0
> > +}
>
> [Severity: Medium]
> Similar to assert_no_reloc_sym(), will this incorrectly fail if a cloned
> function like "foo.isra.0" exists when asserting the removal of "foo"?
>
> [ ... ]
> > +assert_livepatch_sym()
> > +{
> > +     out_symbols | grep -E 'OS ?\[0xff20\]' | grep -qw -- "$(re_quote =
"$1")" ||
> > +             fail "expected '$1' to be an SHN_LIVEPATCH symbol"
> > +}
>
> [Severity: Medium]
> Is this also prone to the same grep -qw boundary matching issue, potentia=
lly
> causing false passes on substring matches bounded by dots or other non-wo=
rd
> characters?

Replaced all the "git -qw" cases with awk or other git commands in v3.

Thanks,
Song
