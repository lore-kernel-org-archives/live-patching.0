Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1881215161
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449749; cv=none; b=MWCmVmAkdeIBBnbrv5BLhgdPrQWFIf1oHqXytiKkfWVD1uzZWWymXjzQmmgqlqc2TKgnu58qPLtSV3wfKWf/dM6Uu7XbUEEvFjhzpfiMXHt24O8ozugHaagN6sKIEb5jPNH8RBvZkOObZti1FbO8pJmEhP5Ybk6iRKVuQ3Mi8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449749; c=relaxed/simple;
	bh=zwphYJ1xrn2R49LbIW+60BAY3dMAjsU1OcBiJKmRCAI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NRBriKRBsIU5zGoifykBnfxucwO+T1e4mh5ilcMfRhxllddBzrntOs3STDAswATfNtF3dopxENtkWhl0FWIXDQnuek7Z6ZOKlHAoQz0LcyzICEEUl2T8cPTK8uIwouLknTJ6W8bT91901h5PnMQ4E7a18LCOx3sTd+wtDhF12QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqpxGeW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqpxGeW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D91F000E9;
	Tue, 11 Aug 2026 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786449748;
	bh=zwphYJ1xrn2R49LbIW+60BAY3dMAjsU1OcBiJKmRCAI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=UqpxGeW8QFJ21zgq1eXGNj8dqipCjtSFaP61uzVQFCtsN3Rr5660Vjp62xzBBAqll
	 S2Xu9hl2Ba/BjC7L45ZM/XEILqYyN2r1ktVyPKHIjawhK/gcAVf2uyyFXGCdwMyaIx
	 E4ANYwjVPXnZaiSDmYtTDjtP2Cz8lodbNKTLecE/3JWFknc/9mALDUEZgr9qBqjQP8
	 7DhWvef8ebjtDByb8jxL7mkLqN24D30aqyNnzy234vrhoBkIRrwaeTQXdALdjlvDtp
	 DjoCw3GmKUKf8aBm/mtbB4gR2I6RboKARJRyfxz240ZCbqIi5hQZ/ZaHiqrd/2dCkh
	 tvwFKaEcJ4Bew==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 38641198003A;
	Tue, 11 Aug 2026 08:02:26 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 11 Aug 2026 08:02:26 -0400
X-ME-Sender: <xms:Tw97akBcZO3noPhHlKZXJ6TlqWlhZp6jGlTb_fseV8X0h7KBOqZ4mg>
    <xme:Tw97ahWbK6U0VChhjl4YnC1c1jLtL2ntKAjHqjBzsZbHrdk5FW0q7zz1Czrn5io4s
    mltjcZEpo3GXD1J-S_y8HPw3ZJTcygRXEqW-6wtQQGNTKELUEQm-cM>
X-ME-Proxy-Cause: dmFkZTEyB7N7n6QM0Uo3Fugkx0WZwpgnnYkOCEIKtQcEYUqJPHieMBMoFgezVcrXKKV7hd
    xWZH74le51w0J1e43JssBhL/DpFYP6adM69IhvYR6He3VZj2kqrmHmaas0+tKDozPK6r0Q
    Z4zQ6PqZpYektv9tEVBYYTO1DO5IoRAnqKDtBkEE2TKmKtzJjwjBQ/x1lwOgRkKCG93Z2a
    RQCU9ufEeCkraBehAgx2QEAfiF5jfQj3coMyC/kVB0tP2ctqZ+lrm0Rm7YVDlOpyPqNgg4
    c62CUJeGpkoXSGuovSIbHPOUb6hZdcTuvd6NjioJ/SCyrfGXYNkTPag0aPsnQRVWyIMumF
    o/7VIdxIgEe28JBfoGgbeIlvc1u8Rzxl8QRwveHFNuGKZI1pctrvDvqt+pEtWeqeIIPR9y
    p8OwXsjS9jDR6vrcorF1o2jPW+ErPy7PDefp1eluDIjeQ2I5OUCzWH0daOzdI/hMu7RD5d
    ufIoKKjBsm5xaND6Ljn76nI69bi4aF4RkFjq4AZPdZNIa7SmrvojWxUVgW0foRB33KW59J
    uLWPYIs6dbO82vXrsNi3HUu4ICxP4OOjwWolZno1YvdAzyT73UJPGLQisIfzUxpHYyOROz
    G28IMdyhxmYRg/ziti+j/0li/MQLrH7fxGd5Ktr2eL+6137awdMdMECab/og
X-ME-Proxy: <xmx:Ug97asJo80jiwGoVYyVAieysZnqNfTPGXcp_OLDIx0NyF-j-4xG61w>
    <xmx:Ug97asR3VdH-QkDJg0ZLwjqLxERpJL0YLzmBF9rZwWbdzSrJsiGlsA>
    <xmx:Ug97akIr49It671AWn1SuOKwQu83sjXLQYhKjm-s8ONS4sFUaJGpRg>
    <xmx:Ug97av9WNa2NfL4zX_vibxK_D9NO2kYnuAa1XSIwHPurmFwsgdOGJQ>
    <xmx:Ug97arJIWhzNw6dUMlljVxhTOnM6pl_mr4T4qU_igFZwZXvyWNGWhcKf>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 28EA8F8006A; Tue, 11 Aug 2026 08:02:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 14:02:01 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Will Deacon" <will@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>
Cc: "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
 "Song Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Kees Cook" <kees@kernel.org>
Message-Id: <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
In-Reply-To: <anrvDIWMNGIa4WPK@willie-the-truck>
References: 
 <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
 <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers wrote:

>> Sure, but let's replace this with a link to a bug report in llvm's
>> issue tracker?
>
> Yes, please! I can apply the patch once we have the bug number.
>

I can look into that.


