Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4733F9F22
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467318; cv=none; b=FVkBSCQ0uNj+MlAhGcBmtH+JOo1Jy4IdGVBFm+iwkAK6lkGuEUA7QdSRNQ8VCXJwsFLN8sf67D8fycXGYQrkXw7HQSmIzarQAi9Op0IfFQ08Zt5loDmvQT49ZIPQlPqn4RASfIICqU9YHYpMPvf4yyF+j+qCCSORzsQsPPKIpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467318; c=relaxed/simple;
	bh=fK158/seF8uqB+NNXTyC3UH8OqZuGnbBo0tzvbIug1k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R+cw02DhuEh9AAdI08yK1KVhZLc6ssyiCYsvxSiJhPTzF9Xu27xRESCnMY/k9zF34ngwGbxgamTi+ljkco/GVu0BTOsbB7+S+Legk4ii6upVCG6gQsFJbBBgrj80R81v/LmTEXT4zfHEtRWDVwvjPR2DuqM+NOnpfjMw7tM7pzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFEEHE9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFEEHE9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC81F000E9;
	Tue, 11 Aug 2026 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786467316;
	bh=K74qCRzxn651l3XaxagRai5qzbIH3fM2gu1tb8jTrx0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DFEEHE9RxfYXtukkdcAkPHl5DR/6wbFCKcIH8xwWm1u+ddiMKWJAVw1USm6fMWNeM
	 rKxmtgEQF2qkpCCKxwSPR9DHWWf6ldC4ntIYoV1R/D3MBZzNnfnIACUCSME2rGZqaW
	 4RqNckqhJJBwkr7DT1MggGBAtRcmDefZiUgOrl2OrMx56qv9oS/odT2L0024rc9HmM
	 RdKqkoaVvrdKm5ocnd0jIzHcIVibM/dBy5YG7jGvyWpkSA5zwxaCrpD9lzy2AObFQg
	 CaaOdxZeX9s/v8ViGMN8SjQG7c9fg/wgR3TP+eb2OBAQDUUGuTs2Xf2SdCkbJ0VNkF
	 V6awNkOWqp/cg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 67BA11980054;
	Tue, 11 Aug 2026 12:55:14 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 11 Aug 2026 12:55:14 -0400
X-ME-Sender: <xms:71N7arl23h6xw1CH1z2nddTAoYbwEJOGVDZNFtujad0vzLpT-zq1Qg>
    <xme:71N7apqWfb-zaLERpc4oN23uRcsxXPVAMnaqpYZcAGXT78g6eY77w-HFTkQow9bwK
    ETuNnBXzNHW3qRCWLhpmSP5x6u6phPZxkQqYiw2Auq9mXwmNGO8FUM>
X-ME-Proxy-Cause: dmFkZTFLc7TJ0dCZCnX8dz/KaeoCy81UUCnt5usIFl0AbbXPkucwxamVid5h2jlpBQ/6LL
    tkmHNiBDJbnaueeGmoN5qhchkdBHK0JaoAv9ua78VI5NXvIlN4AZTsW9oIkre85QvVOX8O
    KG9TOwxxELKxGxQVI5OHhEkppJjUIqoQhBGdlmWrjaChLy54Fo00vYU4mB5CxgH4nLOUnr
    l/HKgI1B45m76zJ2Ilm7k34nZwAS/QrFjzIfD1LSfKbsV8Y+rgioXB3PgLFDWcwwf7TKUD
    a3rMaLk0nBXVC3IEguTnZiQbUt7dwuCcq8aQ2uaHyGkjuT5aH59w9EChvazhf7QBSPjDAZ
    btPY06AHFTIIm9P/l8h2EtOIV7gp18ZxiSvgrEzMl55Ixju9io10JfX1dlBhj7o9eP75fp
    imKHBSS0JKfkxL7SM/rPBjzjB3aCrZJOfxK8kPujWtJmLcFJRrLHkhqF3k00hlNWvDl+U8
    qQnwknKwLkDTDNb4U+cOX8Z4mBFfbZcKHY8B4Hxv1QAFrN8HO10a/nv0WV+lirE0FP9WhV
    EJ1Snv5EEvBqNmZSQoZS0ON+ZCmU+UIWmy05UW+4gTRXyQRrFqt2ygjTU+cAmFShxQz07+
    HxEl3mtTcAbaQtydmWg52Wezoed8gLO6FO7KGtd/o9CqQQjdbBDHfn+q538A
X-ME-Proxy: <xmx:8lN7ag2mfx_pCrSL36pe2INckIFMJ1pTV5vmN2elIR3KGU2eun4XeQ>
    <xmx:8lN7anfhZbPkmbtb8wQPNV6waarKDNqj81uDEPgLT_RTywpMGIzJXw>
    <xmx:8lN7atV6YTk14TC5s7fVrGJYHhmQomRCm3j0tj9mudk0EwHRL_Jszg>
    <xmx:8lN7an-_bXx9f6Q216lbEvdQbb26eryIlCar6LR1zPCjlU0F1iIDyw>
    <xmx:8lN7avhCoeyxuTy-8toXIKtulM7nStebFLgRcoI6hErv9u2XfZIVARFt>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A4453F8006E; Tue, 11 Aug 2026 12:55:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 18:54:51 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nick Desaulniers" <ndesaulniers@google.com>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
 "Song Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Kees Cook" <kees@kernel.org>
Message-Id: <b4bdf563-274f-4ab9-804f-35c47ab2f353@app.fastmail.com>
In-Reply-To: 
 <CAKwvOdkS5ZaBGaoiLwcXqCBjcOXLXE88VD3bj5ES1sssKFf4HA@mail.gmail.com>
References: <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
 <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck>
 <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
 <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com>
 <answWdRpVQLtIzIj@willie-the-truck>
 <CAKwvOdkrxJ_9qjaBNQS+o=+_m_f3e9k6jMEmXB-S3+nXGoLV7w@mail.gmail.com>
 <buq25tpmdjlvskzfvlit6swc6tsjuzbdnjfix4w6af6247zads@ka44wuolomci>
 <CAKwvOdkS5ZaBGaoiLwcXqCBjcOXLXE88VD3bj5ES1sssKFf4HA@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tue, 11 Aug 2026, at 18:52, Nick Desaulniers wrote:
> On Tue, Aug 11, 2026 at 9:41=E2=80=AFAM Josh Poimboeuf <jpoimboe@kerne=
l.org> wrote:
>>
>> On Tue, Aug 11, 2026 at 09:27:28AM -0700, Nick Desaulniers wrote:
>> > On Tue, Aug 11, 2026 at 7:23=E2=80=AFAM Will Deacon <will@kernel.or=
g> wrote:
>> > >
>> > > On Tue, Aug 11, 2026 at 03:18:17PM +0200, Ard Biesheuvel wrote:
>> > > >
>> > > > On Tue, 11 Aug 2026, at 14:02, Ard Biesheuvel wrote:
>> > > > > On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
>> > > > >> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers w=
rote:
>> > > > >
>> > > > >>> Sure, but let's replace this with a link to a bug report in=
 llvm's
>> > > > >>> issue tracker?
>> > > > >>
>> > > > >> Yes, please! I can apply the patch once we have the bug numb=
er.
>> > > > >>
>> > > > >
>> > > > > I can look into that.
>> > > >
>> > > > https://github.com/llvm/llvm-project/issues/215547
>> > >
>> > > Thanks, Ard. I've ended up with the patch below.
>> >
>> > What's the extent that HAVE_LIVEPATCH will be used?
>> >
>> > Does this penalize kernels built with BTI in favor of HAVE_LIVEPATC=
H?
>> >
>> > For example, with my Android hat on, if we have a kernel that's bui=
lt
>> > with ARM64_BTI_KERNEL=3Dy, and _dont_ use HAVE_LIVEPATCH, we're goi=
ng to
>> > turn off BTI for a feature we're not using?  But maybe we _do_ inte=
nd
>> > to use HAVE_LIVEPATCH, and my assumption was wrong?
>>
>> The problem isn't specific to livepatch, livepatch just makes it easi=
er
>> to hit.
>
> Rereading Ard's report, let me see if I can articulate _how_ and tell
> me if I'm still not getting it.
>
> Let's say we have code in .init.text that calls code in .text. If
> .text was placed large enough away from .init.text, we get a veneer
> inserted by _the kernel_ (not the linker).  This veneer has an
> indirect call to the destination. No landing pad. Boom.
>
> Is that precise?
>

Yes.
