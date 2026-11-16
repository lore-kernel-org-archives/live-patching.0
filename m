Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843301;
	b=3vYFNqLLnt0XYeY/Cc4ii1Y1hfKOZ6zf73cBw32IOnjEX+lhluBfhrBoWdFQf42VJdJ9
	 3LpvuaZX6Jz03vRGqxvXh6fHmwqhX7RS6eQEeuIBGnvUwLDM5f5cVtdWyEg8UI3NgHBz4
	 81GYFDTIFqik/g6oU9W/KQUIiB+rnS0gvZ/lKXfH0TLyBVPUrMIl51hcL5/uaWPruDVRj
	 1FO3aItHsHdaZTjGKPL56oKuY4lcY6tRiHKlxlmUKjSpIxaKTn50jyT3VjNzlUgSEZ+CE
	 4+rQ2ylgFkophE7xkWlxLiV/QikxFIrC48i1oWTfWq2FDIUO1WfApeHPp4yeR7+PFmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843301;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=fbxTxlVd+uVhJASLdAzyK6UAyh6+fjwIt3spRNPcd/4=;
	b=HmD4LMhI8NXjmmG+au6c4dMZWSn7m7eqzfpYcgd1CA+wfDMBIMIcRlR3zz7G9y/FON1r
	 icYWPycW96DoO6b0DgOXTxs3xWBd0d+98QLpNTKCRRAxF2M2ubBJ6dsXm0f8aI0BG0pHR
	 ZV08EKd0P5rnS19D9znB96ua3gCAOeABgeFHUvSVLSTU48NwfrOHPZOF8Irc3ZJLazd2V
	 NkYc+SN0KE+9z0N+z8hKe/aFK9eIYhYTt6akkI8rifuWaEN1mA6/EKFIdEVPCKyaG7grS
	 xjIJ3fpvfno1LDlvNL9avxBRuPKzLg1V9jxC+qBGt5dv/111oacoFh9SuXqvLrl1sMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QPnWo2OA;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA265606A32A;
	Mon, 16 Nov 2026 15:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA265606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QPnWo2OA
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D6A7812014C;
	Mon, 16 Nov 2026 15:34:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 096E53D;
	Mon, 16 Nov 2026 15:34:51 +0000 (UTC)
Date: Mon, 16 Nov 2026 10:34:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 kernel-team@meta.com
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
Message-ID: <20261116103450.4575d61b@gandalf.local.home>
In-Reply-To: <CAPhsuW5t2OqERqVm5LDCGDjae17LNpijqRgB3mbi8Mmv41P2RQ@mail.gmail.com>
References: <20261023011049.1164625-1-song@kernel.org>
	<20261023011049.1164625-8-song@kernel.org>
	<20261023093256.20d3e300@gandalf.local.home>
	<CAPhsuW78w86tV3gwRWQMOdWUK7Rcc8dSsp==XypKdB5BMP6QiQ@mail.gmail.com>
	<20261028210844.105c431f@fedora>
	<CAPhsuW54Tco1Y_khWHeomq_ZTxvDoHFuX77w9cqojuXCrhGKWg@mail.gmail.com>
	<20261029134721.66bb584c@gandalf.local.home>
	<CAPhsuW5t2OqERqVm5LDCGDjae17LNpijqRgB3mbi8Mmv41P2RQ@mail.gmail.com>
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
X-Rspamd-Server: rspamout06
X-Stat-Signature: m185ocok44yffeiw317ru69m8dnfh96c
X-Rspamd-Queue-Id: 096E53D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/CLaBGFac+wOUf4n5koLZBa+3VG96c2CE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=fbxTxlVd+uVhJASLdAzyK6UAyh6+fjwIt3spRNPcd/4=; b=QPnWo2OAFe765QZ3Dkre7L3vRamihQipXkGhvp/w/3zCvVCorn/9/j0Y085qQWLyRl+yQU14qt6Cp712ft783XunkGMuWrzg8P/jN6ABrH4bZtlIphqXLAOU+Gz0Qlesgqci+RMmUBn9Tuvdlbr2hUhsAwViYVaXO85zOiLXIEs=
X-HE-Tag: 1794843291-662085
X-HE-Meta: U2FsdGVkX1/a8ZJeQga2chop/pZQoJCt9NQZdw4dBlfaxs5Vzeq60J1gQyTIeCOxSeBI5qt4cMRb+6i/44AsTmGwahwcaK2c0hQsVS/DebXVvP9EySQzVe4cSdteB7M3rT6jMKAwblSwiZ+DZLhMukhsrJiu1buceNyJHmZpRwGx0u6GhodHhLihsU9k47mPbDttMq4QOVfevP+EfuJBgMkUya6zzVZAcT6pVhe4T2H2qcgcv9KDausA0Ee0gbMxBmTmd+SIl9mngO9l+w/8qCPbU1DF9FCZ/3VEW+LVYimzadpE5rcq1Fn742ofEkx5D5EZG9nK8/YTV0fluVLn7SebO+fabO4PaER6KW8OIp+Ik6+aQkWKVwPgKyBYAVddL+0M9XDPj+XD+FdYnZ/hFA==

On Fri, 13 Nov 2026 12:33:28 -0800
Song Liu <song@kernel.org> wrote:

> Hi Steven,
>=20
> On Thu, Oct 29, 2026 at 10:47=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > =20
> [...]
> > >
> > > I think this should go through the ftrace tree. It has very little to=
 do with
> > > BPF. We discovered the need for this change when building live patche=
s.
> > >
> > > Regarding ACKs, it is a bit tricky. For the code we touched in this s=
et,
> > > there is actually no behavior change at all. OTOH, the real change
> > > happens to "inline"s that we didn't touch in this set. If such a func=
tion
> > > was left out-of-line by the compiler, it was not traceable before, bu=
t is
> > > traceable after this set. How should we approach this? Maybe we can
> > > just ask ACKs from the maintainers of all the code touched here.
> > > =20
> >
> > OK, I'll just add it to Linux next around -rc2 then. =20
>=20
> I haven't seen this set in linux-next yet. I guess we would like to queue=
 it
> up soon so it gets enough pre-upstream testing?

Sorry, I've been traveling. I'm trying hard to catch up on all my patches t=
his week.

-- Steve

