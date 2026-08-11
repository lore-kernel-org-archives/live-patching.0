Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F64519AF
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468165; cv=none; b=Pq3pOTNwfTuL0Hd5M1MxvP/r2Kl9dDvlTEGTg+52o2X5R7FDRpW+kBJsW5QpCKyJqOQB9cGuLSJzo3FJPa3DDfvfqXDGQjqrJlOSPMtf2O5RRtR3gVa928JeTn0FOFxAD5OQHzUKWFA9vWV0ggJpGnQlhdKKi6PJZAS6tlndAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468165; c=relaxed/simple;
	bh=cmNCcTF7j1tMhek1b5ToY5nZ1YUJjYQ1ZB1/GYRD7xs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q963uRKDaGVYRw5mp2AWqfis53dNTvutGV0PAdWoNlkN3P4Qh/QjJoLamKpheP2f0CI/EcEgDtP7ew0sLBCe2jzcms38zBDMPFxlZYkXKyi0+l3TJL5BWsUa/CduPpOLkZ+lMKdnF9V+Squg/vfUtA+Kn7aLSmIw5ZpB1H1Xv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu1rqMC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu1rqMC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588361F00A3D;
	Tue, 11 Aug 2026 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468164;
	bh=vuLc+eBTQsRcHHndOJtc/5UNxFkquB47Vebh+uHg3po=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Tu1rqMC0YY3TBle4xI4qDvvm97eT9c7rCqaamZWMNMo0iqCUcCsWFC49SfTx1SHoM
	 Bsv/WGkoTgGTZEeWXzhplmTRq+THfEH/iOBDN1WNb3jQtd/GPVnLXOQAEwu3zpWx2h
	 5p2XtoVdCQpqRk6m88Vl7Ns0VJHx/wtLNhL/0ZYObWEdE8H4HbexF9em7TEjY+b07L
	 qSQRRzaGbY70K8DP2+Rtp0J/wA9/SdLDCrITfQSZePK73EWgkog2jzUis29QRZAsG/
	 tHkbC4W6OObl/7ENcbd/ZsR0u5AaJq+beHSf0Sp6tNfFrTvVm4JNhc0SowPesNaouO
	 gtzdYvnL4fV3g==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id E68BB1980070;
	Tue, 11 Aug 2026 13:09:21 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 11 Aug 2026 13:09:21 -0400
X-ME-Sender: <xms:P1d7aluzHBpOKT4g1lkWLPwsA-9zC4J1_LKphGI9fsToGEum9VB_fQ>
    <xme:P1d7apTzzgT7xMXErdswtOtew6DB99dW1ZOF9bENt0MCAbS-_geOjnZvltg-eq9DH
    rXXjmF9Oy-7ZkRgO95HTVvo7FWo08pnYT2977EF5OkHbNj8az9r1g>
X-ME-Proxy-Cause: dmFkZTFofdFgFJq0nU6Moe8TviOaDqvGA8zMt6timdp8+AgUPcYdPRc42onFU7azTHwDiP
    9LuwvxeI17UeVWze+z0jCic3+3Lafd6oh7mNIfJ2UmbZhnqcLwQR001qZ1r4TtSvxgCR9H
    FTEbzbDzEUS6B8BkT/nxHlt4+HseYTUAGg1wssOiJUKjjNJNvu87QM62SGN0ayNxoaQb0p
    J/qdoi3M4vgUk2XSNf44f4FB3an1kqdXoylI4HW7mGco9e+Uy+ypK63bWkbdJsp8RPgaOW
    GiQkxEJmVFpC2jo6H1d8s/Wee94SFIJ7WNztrk5RYAw8aSTbJVPXUGxPFpaLiQtKX/cEIy
    YzIBgCHFHTeEZvRZRMqIsQtvvDo9cDdgN+LaU4jHTP7EgAT+Lnd0/ip91k/2geQfmA8Y12
    +T0p8Lx937DoHYJE6SoPxK5DmxsPx4V1v8SIeVwKKRb0ZvpDLmYAKFC/tfb3UQiaSYC6Rn
    cdP5jCG+rOZ5SAcvNnvjrA9TxyMcNWp8LSjVsCZ4DZByTuq8fALLlFEE+pvuo1jTOXNyxU
    Jwb73iYqabgcjO4M9XRpycJ69TbpzdMuHYxJTsHTjd6w2ZyM2Em5qz27+s3aK0zAQ062qE
    LBQ79zVLuo3QZCz+dpRvMcBh6ZSd61oXPbOsOSq7btBw2bvrQwXO50uFdx6Q
X-ME-Proxy: <xmx:QVd7ao_3kU1MNY6wnATbHYSpXZHoTUDsBkLAEizvf8L_hIdhJoH8aA>
    <xmx:QVd7atFhRabESAxN-Sud0Yapvtk27ZIwf5RDPE7QKpxlWM_t9Bo2nw>
    <xmx:QVd7aif9085EiJ7Bif8J_k-MlReewHUmWhvMGekIBCp0GJSnJmTp3w>
    <xmx:QVd7amno3D4vRstjuzpIl-CFPTv5UJyE-qiDo_A4j9j7FZPx3g9zHw>
    <xmx:QVd7aprqbzii9Mf2qVLhK11Wd_Cd4gwgjmJRfUQ-V82sSJ4kdQ_RtTGt>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EC402F8006A; Tue, 11 Aug 2026 13:09:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 19:08:58 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nick Desaulniers" <ndesaulniers@google.com>
Cc: "Josh Poimboeuf" <jpoimboe@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
 "Song Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Kees Cook" <kees@kernel.org>
Message-Id: <e48e0097-34f1-4ef8-a3b5-a6893507cfdf@app.fastmail.com>
In-Reply-To: 
 <CAKwvOdkn1WycY5d1EaOTdWWL-wH1wSeWxDGJJgmt2QW7PoQp4w@mail.gmail.com>
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
 <b4bdf563-274f-4ab9-804f-35c47ab2f353@app.fastmail.com>
 <CAKwvOdkn1WycY5d1EaOTdWWL-wH1wSeWxDGJJgmt2QW7PoQp4w@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, 11 Aug 2026, at 19:05, Nick Desaulniers wrote:
> On Tue, Aug 11, 2026 at 9:55=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
>>
>>
>> On Tue, 11 Aug 2026, at 18:52, Nick Desaulniers wrote:
>> > On Tue, Aug 11, 2026 at 9:41=E2=80=AFAM Josh Poimboeuf <jpoimboe@ke=
rnel.org> wrote:
>> >>
>> >> On Tue, Aug 11, 2026 at 09:27:28AM -0700, Nick Desaulniers wrote:
>> >> > On Tue, Aug 11, 2026 at 7:23=E2=80=AFAM Will Deacon <will@kernel=
.org> wrote:
>> >> > >
>> >> > > On Tue, Aug 11, 2026 at 03:18:17PM +0200, Ard Biesheuvel wrote:
>> >> > > >
>> >> > > > On Tue, 11 Aug 2026, at 14:02, Ard Biesheuvel wrote:
>> >> > > > > On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
>> >> > > > >> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulnier=
s wrote:
>> >> > > > >
>> >> > > > >>> Sure, but let's replace this with a link to a bug report=
 in llvm's
>> >> > > > >>> issue tracker?
>> >> > > > >>
>> >> > > > >> Yes, please! I can apply the patch once we have the bug n=
umber.
>> >> > > > >>
>> >> > > > >
>> >> > > > > I can look into that.
>> >> > > >
>> >> > > > https://github.com/llvm/llvm-project/issues/215547
>> >> > >
>> >> > > Thanks, Ard. I've ended up with the patch below.
>> >> >
>> >> > What's the extent that HAVE_LIVEPATCH will be used?
>> >> >
>> >> > Does this penalize kernels built with BTI in favor of HAVE_LIVEP=
ATCH?
>> >> >
>> >> > For example, with my Android hat on, if we have a kernel that's =
built
>> >> > with ARM64_BTI_KERNEL=3Dy, and _dont_ use HAVE_LIVEPATCH, we're =
going to
>> >> > turn off BTI for a feature we're not using?  But maybe we _do_ i=
ntend
>> >> > to use HAVE_LIVEPATCH, and my assumption was wrong?
>> >>
>> >> The problem isn't specific to livepatch, livepatch just makes it e=
asier
>> >> to hit.
>> >
>> > Rereading Ard's report, let me see if I can articulate _how_ and te=
ll
>> > me if I'm still not getting it.
>> >
>> > Let's say we have code in .init.text that calls code in .text. If
>> > .text was placed large enough away from .init.text, we get a veneer
>> > inserted by _the kernel_ (not the linker).  This veneer has an
>> > indirect call to the destination. No landing pad. Boom.
>> >
>> > Is that precise?
>> >
>>
>> Yes.
>
> Naive question: Could the machinery that emits the veneer instead emit
> N veneers, one for each cross section reference?  Rather than one
> veneer that could branch indirectly to N destinations (that probably
> don't have landing pads), could we instead have N veneers that branch
> directly to 1 location each?  Are the veneers larger than just a
> branch?  Is the destination unknown when the veneers are created? This
> would retain the landing pad elision optimization for .text (which is
> likely run more frequently than .init.text), and you could probably
> put those veneers in .init.text and throw them away with the rest of
> __init.
>

The current veneer code emits veneers close to the call site, so that the
veneer is in range for the caller.

These BTI veneers need to be emitted at the target end, so that the real
target is withing direct branching range of the veneer.

The PLT veneers are 12 bytes (ADRP + ADD + BR). These BTI veneers will
need to be BTI_C + B, so 8 bytes.

I'm prototyping something atm that may be able to address the .init.text
vs .text issue. Fixing livepatch is a taller order.


