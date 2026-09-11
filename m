Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAF386576
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153211; cv=none; b=U7bN8fd84MxAZU0gs2A+oDXXKIHzg5WFJ/s5vN2wwZ5hKf8FC3i1OjW722BnKpWpD6XJn8VMjBioG96DM9WKrCpzefeOCd2dEAOo8trujxmFVLFKMUzRbrqpJk236377Kv0jiHR6IGRBC1BtFNxyQdpMTRbsoRbskFkQt4nOxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153211; c=relaxed/simple;
	bh=5txC7jr52ar8jDHEgsTMRiHZjB1NjibkF7v0cKP3bqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LMSkr0AFwX3Ink25Mb0muSCr3nXQoxQ7nlkAJPJ5p8Jow9xmwVVP58dgvgDnMpAoQTGOm7bUP4o6e91FZ3iejwAW1yldZRgil8CYJfo+sxiJfYBT813JzWFM/uHAS4JMjr5uhFpJeiNmRqfHxKLoMXa4ZTbieBoCcarWxlJw1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQs4yc1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQs4yc1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1BE1F000FF;
	Fri, 11 Sep 2026 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153208;
	bh=5o7LHe6Job5a/MC5emuRkANUyeHHo3lzgUNXyKeAysg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MQs4yc1+RnlIoWGww2e6srIMR4BbL9d2GHUCIyYniee1T+/DOG3frNOuT0ysn4nKe
	 Nrt33m5/T3RNQQUzqbWR0fANia8Nw0ezqWx/rLxZ3+MkgDyK9I8FIyYwwz+yh7HwgZ
	 y6u/+StV4Kv1zdkBpdwMWcev/wdPj4IQlrnNn0oOzFwwOVbXYKnBfWxtRtSTXs/y8+
	 ZSuXOoGepfDo8MmwzZY8y3ZbbQqAts7d/2HIi+80mdPDBeo1tePdzwZgZfbk2stwim
	 8XTN3nr2n36NFAQVfpz9KcPWz1q6rAR1JwmMTX2akBeGSs7cD/aawOrmNsucYoJA9L
	 zdXmXn2BgXmVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/58] objtool/klp: Document the klp test harness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: pmladek@suse.com, joe.lawrence@redhat.com, kernel-team@meta.com, jpoimboe@kernel.org, mbenes@suse.cz, peterz@infradead.org, jikos@kernel.org, puranjay@kernel.org
In-Reply-To: <20260911184305.1457308-10-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911184305.1457308-10-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:00:07 +0000
Message-Id: <20260911190007.9A1BE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message references the newly added documentation file=
s with the '.rst' extension, but the actual files are created with the '.tx=
t' extension.
- [Low] The 'Assisted-by' trailer is malformed and missing an email address.
--

commit 7b950355f8a7387d83ee352b14b64773b25d4df6
Author: Song Liu <song@kernel.org>

objtool/klp: Document the klp test harness

This patch adds documentation for the klp test harness, including design
details and guidelines for writing tests.

>     klp-test-design.rst is for someone deciding whether to trust the suit=
e or
>     change it: what makes unit tests possible for a pipeline that normally
>     needs two kernel builds (objtool has no configuration-dependent logic=
, so a
>     test reproduces a configuration by reproducing its input), how tests =
are
>     selected per architecture, and what the outcome classification is for.
>    =20
>     klp-write-tests.rst is the procedure for adding one, and is written t=
o be
>     handed to someone -- or something -- with the instruction "follow thi=
s and

[ ... ]

>     Assisted-by: Claude:claude-opus-5

[Severity: Low]
Does this trailer need an email address? The "Assisted-by" trailer appears
to be malformed without one.

> diff --git a/tools/objtool/Documentation/klp-test-design.txt b/tools/objt=
ool/Documentation/klp-test-design.txt
> new file mode 100644
> index 0000000000000..ec56bfbc2c930
> --- /dev/null
> +++ b/tools/objtool/Documentation/klp-test-design.txt

[Severity: Medium]
The commit message references the newly added documentation files with the
".rst" extension, but the actual files created by the patch use the ".txt"
extension. Should the commit message be updated to match the files, or
should the files be renamed to .rst?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D9
