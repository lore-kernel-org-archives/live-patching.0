Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67EC51476F
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154917; cv=none; b=hNCmyZMFjN7rgt9B5ilyzLcjpPt7g/UurV6N4ciqLRuAnHCTPsUOyq9A0aYOxXRDiUaEwZuZRUYJUiUPFy/Msg2Xdt32RRzkpKSjnMhZ3X4haLRKBce663AFC/L3INIZuQWX/QoRheVCuuN0IRUIu9Rc/WmlG1Uidblu+ssJS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154917; c=relaxed/simple;
	bh=HfPo/LTK51rX4Bcxg+phwZ21aazsin7tWa8Whmm7a5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lF3mISKcUfw1BCCBmtwcyu1u+X6HQO1/l/GAGOdNDjFmU1FCyFy8SCs+CJE6NRysd8VErZTBalniUE01C7xZrmlY7Pi8MBTefZQF5Em1QVdBDieq0Msb8Qns3YHAiUfz/6MB2aAFYOKlmxe7cdpguCCbSUwFV3A7iyPhdoYNw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeevYVZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeevYVZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F541F000FF;
	Fri, 11 Sep 2026 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154908;
	bh=ZRnJ3dLuRvX8I09qk4P3naru+p9PDufRwa2T/a+7ipM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EeevYVZwyPQL95sFR+5VVukKDVdCaKM/lxBOpfD7XIYWHaU5jM/iIzHZ8Ecwi5iLG
	 +p4JERl2zJC6O5EkjHJGoeV2YqijnvCLckl4dbOJUnI4HFo5ZGWquhoVta+l0+eYKf
	 PUhIkoKjCN/+EIqT4/oLx9EGFJaSPrJ2TkboaxMAMRT1NIRU8/ToDMV45s905ljhSa
	 VMSkAjeorCJEkb1Es31Ftd1bcnG3iMNEdd0GqVAtAYsNvtdJ+b+E8acbsm4d5qP30q
	 GwPH7wgbuytcpV5St3ofpJQYAjiT6cvmKxdbwqi6zvWidshNioY91++Ob1bOSPT7TP
	 Bl8bVuVjZ9VcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 58/58] objtool/klp: Add test for ThinLTO symbols sharing
 a demangled name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: jikos@kernel.org, pmladek@suse.com, peterz@infradead.org, puranjay@kernel.org, jpoimboe@kernel.org, mbenes@suse.cz, kernel-team@meta.com, joe.lawrence@redhat.com
In-Reply-To: <20260911185031.1534046-33-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-33-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:28:26 +0000
Message-Id: <20260911192827.71F541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The file header comment contradicts the test's implementation and t=
he commit message regarding how many helper functions are changed.
--

commit 7c4c07d226394615e86d71545cba54395d452f6f
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for ThinLTO symbols sharing a demangled name
   =20
This commit introduces a new objtool/klp test to verify that ThinLTO-promot=
ed
file-local symbols sharing the same demangled name are paired correctly when
calculating klp diffs.

> diff --git a/tools/objtool/tests/generic/fixtures/thinlto_ambiguity.c b/t=
ools/objtool/tests/generic/fixtures/thinlto_ambiguity.c
> new file mode 100644
> index 0000000000000..4a87bc92ea2ee
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/thinlto_ambiguity.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Three translation units linked with ThinLTO, two of which have a file=
-local
> + * helper of the same name.
> + *
> + * TU_C calls into both of the others, so ThinLTO imports entry_a and en=
try_b
> + * and with them the static helper each one calls.  A file-local symbol =
which
> + * has to become visible is renamed helper.llvm.<hash>, and the hash is =
content
> + * derived -- so the two helpers get different hashes from each other, a=
nd
> + * different ones again after the patch changes them both.

[Severity: Low]
Is this description accurate regarding how many helpers change?

The comment says "after the patch changes them both", which appears to
contradict both the commit message and the later comment in this same block
that explicitly states "Only TU_A's helper changes." Could this be a stale
comment from a previous version of the test?

> + *
> + * That leaves klp diff with two symbols in the original and two in the =
patched
> + * object, all four named differently, which have to be paired up correc=
tly.
> + * Demangling alone gives "helper" for all of them; something else has to
> + * decide which is which.
> + *
> + * Only TU_A's helper changes.  That is what makes a wrong pairing obser=
vable:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D58
