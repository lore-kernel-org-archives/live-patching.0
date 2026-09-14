Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0E37AA65
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368368; cv=none; b=MROm7ucQR9L/7B3culQ3NJAoWPDE3NLLJ0TwEZYQyKwJHynf6w4cCm/y8EmnnF/2H8/sewyDBN7RYnDR/7dKQftTbRGXUueq27kmYTcEbq87ZmMhBbOdBNPx0dNzLPasdfAjrsm345nw6dZIvBwY+hDFoK5FEwbY2znu9BegeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368368; c=relaxed/simple;
	bh=NsYzt6QJ8S68EdIG3y9k7l0JWxL2vTKQf5xQn1DLbb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bD+Vk4XyzY4Aihkt9jek0lXYpbNYE7yqmrG9R0JjdWh84khGOEeifuVLKsbA1r3C1GVrLaXFqvIWq5/V8pX4uMOMU0COTfG6hrFj2scLPyEiTBWbSQJNKWB43XyYBFZMDfcS4q3xdLVgjeYJeiWBkbEQl8qYkBOn+cxxQitdYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgCLqrzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgCLqrzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE08C1F000FF;
	Mon, 14 Sep 2026 06:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368366;
	bh=4IM3dmc99cwW5R5HbUqFNyY0qm8ZGhevVnilDEzyZ5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgCLqrzGhF7c3ZufW/HJxCA9BMdVsc0KOowGvueOYek/bPkzdZ+O6ou+sDiP4O9Tm
	 gCj8Oy2Yg0Ncd0FZJQS64R0D2ceXT+ll5OQdow24cU1FjfJeG1QZDuRskUnMhr3IBt
	 86iUKHGcLslKx7uk8wMDljVfK0Px+Gp5G3eBzqsPQtwpB2zpexqoD4MLKbHfdXKshp
	 LlYG2M69IiVrpFbtJsu8VL9vCn7jId2kwa8fiG6PU8+hlxsN7EohAtgIZT9u5xicGP
	 BRVnMwx14Ig7Ob+Pa3BCrA/sdh5gt+D/xNCNUujR0U1oNJIOuy5XVKGLfbzR/BOzLn
	 W49/ANi5LwYxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/58] objtool/klp: Add test for jump table key
 relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, pmladek@suse.com, jikos@kernel.org, mbenes@suse.cz, jpoimboe@kernel.org, kernel-team@meta.com, puranjay@kernel.org, peterz@infradead.org
In-Reply-To: <20260914062514.926997-20-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-20-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:46:05 +0000
Message-Id: <20260914064605.EE08C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The jump label test fixture hardcodes a 64-bit PC-relative relocati=
on which causes assembler errors on 32-bit architectures.
--

commit 12aec6304341b6d166d36c18d507d8088ff90b91
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for jump table key relocations

A cloned __jump_table entry must keep a relocation in its key slot.
This patch adds tests and fixtures to ensure the relocation stays
properly populated for both exported and unexported vmlinux keys
during a klp diff.

> diff --git a/tools/objtool/tests/generic/fixtures/jump_label.c b/tools/ob=
jtool/tests/generic/fixtures/jump_label.c
> new file mode 100644
> index 0000000000000..ecd3c06912af5
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/jump_label.c
> @@ -0,0 +1,76 @@

[ ... ]

> +int target(int x)
> +{
> +	int r =3D x;
> +
> +#if defined(NEW_KEY) && !defined(PATCHED)
> +	/* The original has no static branch at all. */
> +	return r + 1;
> +#else
> +	asm goto(
> +		"1:	nop\n\t"
> +		".pushsection	__jump_table, \"aw\"\n\t"
> +		".balign	8\n\t"
> +		"912:\n\t"
> +		".pushsection	.discard.annotate_data, \"M\", @progbits, 8\n\t"
> +		".long		912b - ., 1\n\t"
> +		".popsection\n\t"
> +		".long		1b - ., %l[l_yes] - .\n\t"
> +		".quad		%c0 - .\n\t"

[Severity: Low]
This inline assembly in target() explicitly requests a 64-bit PC-relative
relocation. On 32-bit x86 (which is supported by the test runner), the GNU
assembler cannot represent a 64-bit PC-relative relocation.

Will this cause the test fixture to fail to build when running objtool
tests in a 32-bit environment?

> +		".popsection\n\t"
> +		: : "i" (&KEY_NAME) : : l_yes);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D19
