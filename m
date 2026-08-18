Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EF1A262A
	for <live-patching@vger.kernel.org>; Tue, 18 Aug 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062533; cv=none; b=qzMRHap/6+aL8h4rDeZ8iwfiXXbkgt2RGrczr9E+jxTE927pepmD3Mq1zHaigzk7R2MtK70QmA8zHUI5totLET4GDdfgD6hiqaA9eWAFkna2MDdkGi8ANNwD8jgmzMfFuWkO1pCCp8su38a9p6icfyrcn01W0Q4MJW5+RbkmJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062533; c=relaxed/simple;
	bh=hi+oUL6zlvqYdIP3TAz0c+KSrjbhmM33fjnAlT6IX1w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LH8wNvV99YLfS/Ml+4sA8+8a3XITpcyV315VvwBAJodNtJBHfPYI4NIu80WMnSgkFdlmEFj/Cm4bOFaMOcyvSMhlQWGg1rp1f6qg5m0zXOujLL3A9LBsuFvpNvIRVUOfdL1hxVmLCHfgKn4ZLuQfhUFNeqFRAW/RYt7mZk0YW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNXifQ85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNXifQ85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B4E1F00A3A;
	Tue, 18 Aug 2026 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787062532;
	bh=3GGCDtHoSJ0Nxzd5K3g4Rn7pndoxkDIAt/HAFcA8P/4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=oNXifQ850ArQgbK9rbE88NYiZtjbzE8DEXS5V/7njNhfsdgzr++/PJvBwR8mrv1cv
	 aLyAVQF6AsiMXZ9VyVNNV0otOLi2it6272rz58KH0YlX8/tR3bMkGA+5pCDyKfjnMM
	 0jH3beESPsSTZSTBbDSqBK7cNd48Qv130gNofeE53vQctgWkiAEykfWweN9m5G765L
	 5nUcvQGwzFReDBb8Btpg3rBV0PApGCKPNQfm306f/ZvtqtYJYBDwrm5jHpcIat9q8A
	 pnaLsVXIvAH/R5gZenYVJBYYZSObHTwfUrCHOoWExJ4bSVnszMWoC3eBRyquchxGRH
	 OAxsUezlY7pNQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id D88FF1980083;
	Tue, 18 Aug 2026 10:15:29 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 18 Aug 2026 10:15:29 -0400
X-ME-Sender: <xms:_2iEaj0o6mlBiAjvLk8xn0dOP9a5sTc5VUO7iKj54BqtU17AKBl8Hg>
    <xme:_2iEas7DpFLD1KqCOSKVYa_nzljAo67zJCIOnXeo2koSVfPEoPVvoTDTUcqbiKNu-
    fc3L5xo8bfk8-aDnFhVRyT2tKymbDBYk3cbn59-DNuAj1Ze_chEkVE>
X-ME-Proxy-Cause: dmFkZTE5+Ljdf8AEVfTUNzLW1bowQTEYVKKlh2mBbWP+x+yNcPAoPfael8/iK7utKXPRjy
    Eq2IR27RmW3cu0Zc9yh/F2marlrsiMXG+KRcczqZPtS4kysaID2bPckkrmQo5wNsQMrFtA
    RjGFJIlHiHiNFSWAA056rvjLUdIU4h3xqdUCZ6fOUX86Y4ILsghXZRe9ZIxQDeWn/dalnH
    GA6nhom5QLsw/DqtdF9LKn0aFwLGBoUoBP+2ce9dgC0h1x2iVTMKbv558EznxZ7LPzFxOa
    HGdguMqXuJdCUkw/b5hwRpwizzBgFT/w5hWWJXoxOWnQajiI+XOEfcU+3N+oKNpwBjAiXr
    BlMyCf+RzZEtZifz5rb7e9jGmEEnC+6EkV/d8iBqUTOkTTGolREX7G1kMBFb1cMgiMmpgn
    HJwdffy28ZBaKIBstNCyrdNc7JsZEZruXZ2NVrY6T/p6Wx/TR6zKbrdjY1zejchvbq5QH8
    2fwVGumWt201CyiEW6RXNPnpM9egiSufIbn/q2YQLt1/p+PvQ8VvKtdj+cmCAs0wi4BX+g
    jIcZV5YzFVjFqnF0aKCaRDj4OOmv6frXJvLKKBP19IE0sytLN6MTM4LSYbI1n24vKoB1P+
    fsBwSazdfQoR5eBB+TKKqI11JCWIvY9PlGpcT9I2bul2kgJHJRQxSsdkAhjA
X-ME-Proxy: <xmx:AWmEap4BBIRi-rCyVjk5J33JNnDLYuCGpJhsRkhD_hlIfToSeX8Oyw>
    <xmx:AWmEagTwNiJhaGS_XNvhhnMqYFJRAprUp1nfOi0PA5V5am0Hw2lDBg>
    <xmx:AWmEao8Ht3ha4T3nlYR7phgdHq7N2DJxOY6W8_Ovck4-yr79EsJdAQ>
    <xmx:AWmEahowxQwD0FuKdb7G2P2okHDL91aC9cw80fE3bqLuIFNvBWm60g>
    <xmx:AWmEauXc0Vt9tffceu_kyzuJLUP1yBaolLYsfXP4MQ9ZoJz1WhOIIbxz>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E0D83F80070; Tue, 18 Aug 2026 10:15:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 17:15:06 +0300
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nick Desaulniers" <ndesaulniers@google.com>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
 "Song Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Kees Cook" <kees@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 linux-toolchains@vger.kernel.org
Message-Id: <efe4a3b6-6511-4c05-825d-d25de72839ed@app.fastmail.com>
In-Reply-To: 
 <CAKwvOd=Vn4L1sJ=8zVk9qcDLtaDYxfxn+0aG4tMrbETsqY5_PQ@mail.gmail.com>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <e5c957d816240e749a92588d4a9bb44da791f8e3.1786768375.git.jpoimboe@kernel.org>
 <CAKwvOd=Vn4L1sJ=8zVk9qcDLtaDYxfxn+0aG4tMrbETsqY5_PQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] efi/libstub: Remove obsolete .note.gnu.property workaround
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, 17 Aug 2026, at 22:54, Nick Desaulniers wrote:
> On Fri, Aug 14, 2026 at 9:45=E2=80=AFPM Josh Poimboeuf <jpoimboe@kerne=
l.org> wrote:
>>
>> Commit e2179a09ab08 ("efi/libstub: Disable -mbranch-protection") added
>> --remove-section=3D.note.gnu.property to the stub objcopy invocation =
to
>> work around a Clang bug where the note was emitted for code-less obje=
ct
>> files even with -mbranch-protection=3Dnone.
>>
>> That was fixed by LLVM commit a48f6079f288 ("[AArch64] Generate
>> .note.gnu.property based on module flags") which was released with
>> Clang 12.  The minimum Clang version is now Clang 17, so this workaro=
und
>> is no longer needed.
>>
>> On arm64, the stub also no longer builds with -mbranch-protection=3Dn=
one,
>> as it has inherited the kernel's flags since commit 8358098b9787
>> ("arm64: efi: Enable BTI codegen and add PE/COFF annotation").
>>
>> Remove the workaround.  This fixes BTI on arm64, and is a no-op on
>> RISC-V and LoongArch where the vmlinux generic NOTES macro discards i=
t,
>> and the x86 and ARM decompressors discard .note.* explicitly.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> ---
>>  drivers/firmware/efi/libstub/Makefile | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>
> I verified the above all looks correct.  Thanks for the cleanup.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>

Thanks. I've cherry-picked just this patch for v7.3

