Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675538;
	b=d8hlSuwZUZ0sflrs7w4EtFv2H/28HJKmoMonCr8WOAEYMdszuUC9IQG95dhX0XgZpu2H
	 cTRhaf9a3+mT5V5OAotpOGlknQwNimNXhZq4BFcU+Rq/iSWq2C5wdgdZh8KN31NjNpmHE
	 x/XbUfUKemhVDwr2tz9A/MbQza/d5YJEakPQyAT5JX5UqOmBkstxANBtar0SAZhnRnFaI
	 eOfQDqzJG3JeAHtlHjSBQvhrg7oTurQRu7ATwpSWmj2tfj13TvzxWvtbK52hX0x0Zwt3o
	 uNaQMdJxx8QE+SA6jb5TsK78Pp9j5rY2FVD8Prs2PIuPvVxfMAH+JMWvNI7XJQ5gzqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675538;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=oEGlizCzT8H8VgGeloXhhkjrEyb3fwnCwNMOv+mnUQg=;
	b=KMcC28u0aUZK7SovMvhMMkHOYKdJy83pGDli3iCxouiMSAuzl8xRhFMeVRWQ3WnvW7r4
	 4yWIwqiLaogBpCDjBxWOXNdW34znz8/UR3zNprAGTxi6MXw/Roigd7wfzpEtphpHF3peC
	 XZdh8EACAWZLb7wSa9sVueW2Z8G+NfBkj65bjjiBfc+s8pdy71I9xYtsjXfktmipI9Vex
	 yS0SGbHKjrZVPAyOqm/zHJYkW8aW1PAbqvI1PcF5Fi3PHuMaSouLuViYHk8Bnu/KU3wFk
	 uAM4G9VdayddLIoQ1ypD3ehKC/gEDIX5kupq2F/Tglb3dKL9+1zVGjKIJOjJ2yI5ptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="gY3NF/cO";
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3F606A319;
	Thu, 22 Oct 2026 13:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C3F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=gY3NF/cO
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C94401A081D;
	Thu, 22 Oct 2026 13:25:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id D6AEE30;
	Thu, 22 Oct 2026 13:25:27 +0000 (UTC)
Date: Thu, 22 Oct 2026 09:25:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <song@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 kernel-team@meta.com
Subject: Re: [PATCH] compiler_types: Do not mark inline functions notrace
Message-ID: <20261022092526.46261360@gandalf.local.home>
In-Reply-To: <CAPhsuW5BhxAUC=OE=mjZ32vtYpsGM2WYw6bKTXF5GrTDh8CiSA@mail.gmail.com>
References: <20261021222255.3124940-1-song@kernel.org>
	<sashiko-outbox-180771@kernel.org>
	<CAPhsuW5BhxAUC=OE=mjZ32vtYpsGM2WYw6bKTXF5GrTDh8CiSA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D6AEE30
X-Stat-Signature: 7mj1wh3udg8mxttgss8xq63tzqqqahjk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+9tqH9bmrYJJKTL1q+fxUkvAWCu4lyPLE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=oEGlizCzT8H8VgGeloXhhkjrEyb3fwnCwNMOv+mnUQg=; b=gY3NF/cOcEXVjvZH57HQpd3JVGQzbQ8GRiVIMRJ7O+2ZRuPejK4+clC9PHmNmWWu+Ow5ZVXKgo2HGZO2n6CkvqLRefGdxhMxep+effr2UMvhiyDu7EXgz4WQ6GmWxXYLAMb7PF4O2RH8tYt+C5VzOihZ0pdk+Ne69zPUkc4ae0Y=
X-HE-Tag: 1792675527-724063
X-HE-Meta: U2FsdGVkX1+h96t4ngXe6gDub4AkVlV5bWzT6c2Z/eo6mOTFIvdwR48MM1Mju5Bz586Ks3vOugrgdoWQhqtf3DYQn4yX9oVDT7ipNfJCEPwdjDUmwuaa9fmVae2U3K3EwG3yixgn4rIq077PaRw0f/1bGtp6zCvkL7721DJFiCSDTbrlSYvivXa0XY0ZJWsSiKdjWUP98WtkWQFquMqZllOmDOv7XLJ+PGpeeBjKToqwHbA2lBjemrfw1l5//wgyNYblqCp1J7M/8Yrbe8nVFfRDvv3s6n7cqrd/qHAHaCAhcsoGMkXodS4HGy5rU3nD0sIRiknMhk1oHWCYPjZy0hvq+akRBeFg

On Wed, 21 Oct 2026 16:38:03 -0700
Song Liu <song@kernel.org> wrote:

> On Wed, Oct 21, 2026 at 4:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 5 potential is=
sue(s) to consider:
> > - [Critical] x86/paravirt: removing notrace from inline instruments pv_=
ops and resume
> > - [High] tracing: removing notrace from inline breaks ftrace recursion =
protection
> > - [High] rcu: srcu_read_lock_fast_notrace() and tracepoints lose notrac=
e attribute
> > - [High] bpf: removing notrace from inline exposes trampoline helpers t=
o fentry
> > - [High] entry: removing notrace from inline instruments unvalidated en=
try helpers =20
>=20
> Wow. I didn't expect this from Sashiko.

Yeah, I was pretty impressed too.

>=20
> > --
> >
> > commit 1eb6626c4a5ab70e5858a8a8f1c9edfca235db57
> > Author: Song Liu <song@kernel.org>
> >
> > compiler_types: Do not mark inline functions notrace
> >
> > This commit removes the notrace attribute from the inline macro definit=
ion
> > in include/linux/compiler_types.h so that inline functions emitted
> > out-of-line by the compiler can be traced by ftrace, attached to via BPF
> > fentry/fexit, and livepatched.
> > =20
> > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_=
types.h
> > > index c5921f1390079..ea7f2a928b4da 100644
> > > --- a/include/linux/compiler_types.h
> > > +++ b/include/linux/compiler_types.h
> > > @@ -230,9 +230,8 @@ struct ftrace_likely_data {
> > >   * externally visible function. This makes extern inline behave as p=
er gnu89
> > >   * semantics rather than c99. This prevents multiple symbol definiti=
on errors
> > >   * of extern inline functions at link time.
> > > - * A lot of inline functions can cause havoc with function tracing.
> > >   */
> > > -#define inline inline __gnu_inline __inline_maybe_unused notrace
> > > +#define inline inline __gnu_inline __inline_maybe_unused
> > >
> > >  /*
> > >   * gcc provides both __inline__ and __inline as alternate spellings =
of =20
> >
> > [Severity: Critical]
> > Could removing notrace from inline cause a triple-fault during x86 susp=
end
> > resume, secondary CPU bringup, or kexec when function tracing or call-d=
epth
> > tracking is active?
> >
> > In include/linux/compiler_attributes.h, __always_inline expands to inli=
ne:
> >
> >     #define __always_inline inline __attribute__((__always_inline__)) =
=20
>=20
> I wonder whether we need __always_inline to be notrace, and whether
> this resolves any of these concerns.

Yes, we should add "notrace" to the __always_inline for the reasons given
by sashiko. I'll look a the other comments to see if there's other issues.

-- Steve
