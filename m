Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0942AFB1
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513934; cv=none; b=rrpKbHjUL12l+4QVafH/h6zJv5eGb1LPE5X2r+/gcPCMfc1AKI0rolaH4d3e38M8y0Mfjc0jx+I955A+Bra+0rK29IrdSHuk6a9/cd1IE8Qxn2iTt+af88He3hEskNGY5BzC5xKj8XKLOqrr4YprCmhCrJdkfgu1PC53FgRG3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513934; c=relaxed/simple;
	bh=5y89yViajF6E5sFOGF9VRWfKH3F2v8hmhVSzIiCTHd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZURhrrr8dNsBpZ7r+XBPQZjFAv+IUnXWgRCfBnn1eZE5mD7bkhAOsq3CcW6jewx/eK9vvygh/VH1iBW6x7/suzT+zG2JWsBVTolk13M3nIpXKT/wmHObKVybw6h4TSc3blHn2esRQcioXSU5B3TbRdyFT89DU0NtIXv9tAMxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu8Ga23L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu8Ga23L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2441F000FF
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513932;
	bh=HdE+Ntll/c2YhvON/Aio6I+tStN72YxB0IDBbOZNqsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Xu8Ga23LuggFH7LqYrADx+WkWyUQ8tNj8K76Oqf9E6In16u7hk641gUA6xNkY4CDC
	 Om7O9o9Tz+V7qjl5+0kR6/rqGG1snezliHS6qnH6g9QXA9KnBbvW9a0slUjswVTkXz
	 9gaDalRIoFUjwYub+fG0BsHqpCaYOsG1jmKkAh9chu81moDyzt2t5G2JdwllhzZHdT
	 3sDEjHCn/KeCDAcB8TKSj+hpYMYUZ7b1+Uz2M86M9i6S/sx0W+I69SU9oCknZio/FD
	 rzCo5p4qx9riHp0O3P7fz1d8FTtO7fqUWTee20YXnJB/dzgJ+gUsfOTpjjGFhqc7XX
	 OxpfJXH6VjTVw==
Received: by mail-qk2-f20.google.com with SMTP id af79cd13be357-939656ff6d9so30854285a.1
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 16:12:12 -0700 (PDT)
X-Gm-Message-State: AFuF++l3k3CxqRCJQiKxZeBF+y7ksATVInRhlt1WsrxGyS16p9fT4Iux
	94WiKikudHXHzdUYUvP1uGi2Wx9bCqwejNCMId+OyydwV54Rfq2p3jiJb4b/+vk2Kkd/+JB4sjt
	eYaA+6Q5o8L86GpX301HhaPUmwN3uRJI=
X-Received: by 2002:a05:620a:4542:b0:92e:5d44:73fc with SMTP id
 af79cd13be357-93bb7668b19mr54909885a.12.1789513927735; Tue, 15 Sep 2026
 16:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-24-song@kernel.org>
 <20260915000712.120901F000FF@smtp.kernel.org>
In-Reply-To: <20260915000712.120901F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 16:11:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5xdsKWuXRmAUgVDLgg8Zdx6LQoO6SrNA27w720ZLN7iw@mail.gmail.com>
X-Gm-Features: AcwNN1WziJh66MCop_MAQk08v99qEwXeSvsKmI0G-Em0C0Rg-OWCQZcLJ0snBzw
Message-ID: <CAPhsuW5xdsKWuXRmAUgVDLgg8Zdx6LQoO6SrNA27w720ZLN7iw@mail.gmail.com>
Subject: Re: [PATCH v3 23/58] objtool/klp: Add test for rejecting references
 to init code/data
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, kernel-team@meta.com, puranjay@kernel.org, 
	peterz@infradead.org, pmladek@suse.com, joe.lawrence@redhat.com, 
	jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:07=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] objtool: test suite aborts due to fragile compiler assumptions
> --
>
> commit fa8e7a87126e5978150272fd5c3b8728c0d8f68a
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> objtool/klp: Add test for rejecting references to init code/data
>
> Init code and data are freed once boot finishes, so a klp relocation
> against them can never resolve.
>
> > diff --git a/tools/objtool/tests/generic/fixtures/init_reference.c b/to=
ols/objtool/tests/generic/fixtures/init_reference.c
> > new file mode 100644
> > index 0000000000000..51b2a57dde14f
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/fixtures/init_reference.c
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Patched function referencing data in an .init section. */
> > +
> > +static const char __modinfo[]
> > +     __attribute__((section(".modinfo"), used, aligned(1))) =3D "\0nam=
e=3Dvmlinux";
> > +
> > +static int init_only __attribute__((section(".init.data"), used)) =3D =
5;
>
> [Severity: Low]
> Can this static variable be constant-folded by the compiler since it lack=
s the
> volatile qualifier and is never modified?
>
> Modern compilers compiling at -O2 may constant-fold non-volatile static
> variables or use symbol-relative relocations.

Added "volatile" here in v4.

Thanks,
Song
