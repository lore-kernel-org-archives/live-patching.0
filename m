Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01986388397;
	Thu,  6 Aug 2026 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993119; cv=none; b=qbdNopoWZTxCqsWKhJkOL4lSSPa5brCBq6jl88ibs3iWIhmmgNERmolZh1UMD9+Yi9xFU7Sj0M+L5Q6cKGC0CD66dv3hcfAygDsx5pbfnDCUlHRnc3ZRdZzpAig4wVPwUZ9IR0TxsNRFoPHuAfc0r/bNoUDqJqhoBe5pjnbmovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993119; c=relaxed/simple;
	bh=WA7dCon8CQpEqGcsTutXNKml9HEovh4hp3JvRbzTDwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipKFPT3X+o2pOT5/u6c1OR1EMTCgG0R+HLb5Bpic/0WwqTzNSbLZaFLAoxk7TMI4kazI93Ssj8WSuxVSFuQSBBJtJRVM/ylkTFi3FnWsp6ei7SgrgGzG4G3cUCgd4jFHylkOGSiUi4AWMsIyoaei4hY2kOkcCMwLmyRr0NroNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aweGhOmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aweGhOmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CF21F000E9;
	Thu,  6 Aug 2026 05:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785993117;
	bh=wx7sxRy043u28HXEw62TTCtYApnWdd/OunIHDVJdeAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aweGhOmQoGK//hRIba0yRj7uroPKdAX8+L++eQg8joMEQUShDyeP9OQ1hUo1ELzyN
	 LIUBP+87UYEterg9iR+wcXSvjQJmG77QAmeWc7XpwSU4teAaHGImOxuDj2fwrfVj7d
	 W+nqvF51CVQ+AWMVVoqufQl5umFD420lXHMrtqi91uhSOwns95Lp6NMMgfMMRB3pdF
	 rxKwR7F+4lg+c5+b08BBojouY0I2JjhV4tmNzM8da+ssU7H0RO3wF6hvVdlyCwKGwN
	 ZLLW5oXVL4k02D718KlJfRbMnsyKk1s5KbpuqrAGj/2S/83NvCi6rPeU8bO2JwiuNg
	 U1uEU+rZGv88w==
Date: Wed, 5 Aug 2026 22:11:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 2/7] objtool/klp: Fix size of empty special section
 entries
Message-ID: <a7ljeflolo25c22ay4uawzwmqueimkio452fgyf47turjmbvsh@qzc3coik37yq>
References: <cover.1785939903.git.jpoimboe@kernel.org>
 <d9debc941bd06c1a606ed7a366bff73d1680f0f8.1785939903.git.jpoimboe@kernel.org>
 <CAPhsuW69pBfEzN=apAzQkSgY+FJvxeukgydNZwYSrpA6+kQ42Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW69pBfEzN=apAzQkSgY+FJvxeukgydNZwYSrpA6+kQ42Q@mail.gmail.com>

On Wed, Aug 05, 2026 at 01:36:26PM -0700, Song Liu wrote:
> On Wed, Aug 5, 2026 at 7:30 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> [...]
> >
> > diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> > index 492d7a012cffe..11e8f3ddbb0e6 100644
> > --- a/tools/objtool/klp-diff.c
> > +++ b/tools/objtool/klp-diff.c
> > @@ -1627,6 +1627,7 @@ static int create_fake_symbols(struct elf *elf)
> >         for_each_reloc(sec->rsec, reloc) {
> >                 unsigned long offset, size;
> >                 struct reloc *next_reloc;
> > +               bool last = true;
> >
> >                 if (annotype(elf, sec, reloc) != ANNOTYPE_DATA_SPECIAL)
> >                         continue;
> > @@ -1641,10 +1642,11 @@ static int create_fake_symbols(struct elf *elf)
> >                                 continue;
> >
> >                         size = reloc_addend(next_reloc) - offset;
> > +                       last = false;
> >                         break;
> >                 }
> >
> > -               if (!size)
> > +               if (last)
> >                         size = sec_size(reloc->sym->sec) - offset;
> 
> Some comments about "last" logic here can be very helpful.
> 
> Also, with the last flag, "size = 0;" before the for_each_reloc_continue()
> loop can be removed.
> 
> Other than these nitpicks:
> 
> Acked-by: Song Liu <song@kernel.org>

How about this on top?

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 11e8f3ddbb0e6..38fae861d12c7 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1634,7 +1634,10 @@ static int create_fake_symbols(struct elf *elf)
 
 		offset = reloc_addend(reloc);
 
-		size = 0;
+		/*
+		 * Find the start of the next entry so the fake symbol size can
+		 * be calculated.
+		 */
 		next_reloc = reloc;
 		for_each_reloc_continue(sec->rsec, next_reloc) {
 			if (annotype(elf, sec, next_reloc) != ANNOTYPE_DATA_SPECIAL ||
@@ -1646,6 +1649,10 @@ static int create_fake_symbols(struct elf *elf)
 			break;
 		}
 
+		/*
+		 * If no next entry found, this is the last entry, so its size
+		 * is from the current offset to the end of the section.
+		 */
 		if (last)
 			size = sec_size(reloc->sym->sec) - offset;
 
