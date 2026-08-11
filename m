Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A584476CF1
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491632; cv=none; b=PiKpaOglmUtl+aHI8IU+wwp7U5z/7j7im8kUSBD4EyxBETWiLiCR7ujedi/pQmp2gtShA57AJS10bGGx9Ktv4wNN2Xgk1VPAChOt2oXswkzS6dslHr4dwbURZ5Su2t/HCPT/b+buUCHeTXvA8FHIMl4G3/fQ6MN0dVIzy0OFvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491632; c=relaxed/simple;
	bh=oQFksCzI9ITgXg079LIF1ia95IZFV+xgemlTOZzX8Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iip4DSlbYwMzUc9b2LzpzHwyFuIHepNSdbsYa2CAtI5R84VEKu2DaI9GUV6v0HJPMakcZd+sYH1AaNlWyWg5Ha9+AJu76aZasR0XUsRRa/GzgYutP+jq6V6/1mMHp4iqUMFRQokkBCWzUTOUakvhaBYia1j7bDQSZQqy6+gLkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYQ6PBbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYQ6PBbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3681F01567
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491630;
	bh=oQFksCzI9ITgXg079LIF1ia95IZFV+xgemlTOZzX8Po=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kYQ6PBbg4Wye2kBWqrUrJ0lFgIoR3UdrHYZI6b+78DkQHgNZ2YFYoaSe9rZnP+hBs
	 60r3jRYuz+a6wpCs8DXCWJb1ZmHI3CeymXhy3mMVMnpuXOxeG/oEmN+0ZYH8Aj4aal
	 Wj7v+loliIJ7G4Yx/HXWAXcPgOg/ANTl7Hs+igOl+eMwOQ0+c1a8WF7LSj4ZxqdLMn
	 LKKTJO4iSdKhrVbxJQbxhOYGHd5FpgFD+UdK3FTFqtkVagIHQkXi4sf6w/eap6Jlns
	 YDMfpjYPOny1/sfSRFGdaFy7pzgi9kheGWB8+7iih0FO2h6PCU/ME2367xdvtpjoAq
	 Ml9nPl7iRm+TQ==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93108a3c326so100722185a.1
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:40:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rog57hnbfgkv6tjugT3XtsIxk1esEZV9RGLJVs3HfrbfTu6mGxAfSFy3tSsrRXFwPxW8Crv+GS7GqBg2LPa@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2kzn3446nYHxNsQiF+NXtZXrhBHdR70V5u/22uFbSTjTEgzH
	ToZCIQ7zZuzKcBpn/MGWv/YGUg/fIcZJrJal31pz/XhScV5cF69zTP+U3EMIZfDVhDIBIsplChq
	+DRZNEh94xhZFY7xdOguMjgKjSqd3PN0=
X-Received: by 2002:a05:620a:21cc:b0:92e:551d:f1a3 with SMTP id
 af79cd13be357-936adcdcb43mr310015385a.8.1786491629947; Tue, 11 Aug 2026
 16:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <8adf966b340ea38ef1df845c7af0c794df3a7bce.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <8adf966b340ea38ef1df845c7af0c794df3a7bce.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 16:40:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4PRaUoJY-AV7A=Zj8trhUgNN-QGnN9JViDPMeNNuRvJw@mail.gmail.com>
X-Gm-Features: AUfX_mzfV5u94ssaoc1DwPzAKH0PnNP7yL6H3gKwaQ0xQ736PSRCu5sRlHc87ts
Message-ID: <CAPhsuW4PRaUoJY-AV7A=Zj8trhUgNN-QGnN9JViDPMeNNuRvJw@mail.gmail.com>
Subject: Re: [PATCH v4 11/22] kbuild: Only run objtool if there is at least
 one command
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Split the objtool args into commands and options, such that if no
> commands have been enabled, objtool doesn't run.
>
> This is in preparation for enabling objtool and klp-build for arm64.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Nicolas Schier <nsc@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
