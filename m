Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40437BE75
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368312; cv=none; b=gqoCCjgHhWuYg9psHDrRaeZwU36w3rmvMjbX6Zqhn3WPpomyeMNJQ8S+YSxXVleqhRKkxQlJe4p3bZawvNM+j5aVwdZwQtFeYYKKts6VwtnbjKlZSSqM06ZdHgIyjlBoDWVGzvB1Hv5ivClbG251l4dNohragvH5x83OFvVeQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368312; c=relaxed/simple;
	bh=udAyRVEiVkSpMG4kczXJuQzWbqh1oeeKjgu1CPVeIPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NAAgg70RuTCK43eq4Lmpig7BXVejAa+sgZ4svxOa70LH3pVKPs/fWIWL8TmRM2ojk+wNBQlEnPKcHpLyuuAXb4YTVU8g2EYvp2PRbCKd8fBSZD6ElfXYOBw7nDWqXxs8izQWLrCeJzuZOWFgbji63gzEDnjBU22O943Z7yB2URc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv1TFvIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv1TFvIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D941F000FF;
	Mon, 14 Sep 2026 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368310;
	bh=udAyRVEiVkSpMG4kczXJuQzWbqh1oeeKjgu1CPVeIPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hv1TFvIo2hOKXv5YXeOkivKMU2KrM7bFurGJzePXZmBViDXZ4RklamcfuPNNprzdm
	 YSfJwB4j6NcFbBWSHZzhSGZ3gHuP3NkXuBkVMoOFgcUZtGhJJB2LUx+ORtuwruAUek
	 0BwVD3DTPBa/3G3hEMqMLzprIbQnlQvVZQ8qPRIj+atx0z8WiGXqv14Aa0Yjczi1nZ
	 noIDqCyynGkyVmEl39UtbTb6dByJH+kC9yX2OI2wQ0e/92VBkjnLQXjSVxq6zuOFQi
	 hDsqJPbe+r0CkWuoKgqaHOoCAg8LVznlSSQAup6uVcv94N7mtwRoc6wdlfLu1lTYLu
	 rVcFCzbdSicYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/58] objtool/klp: Add test for
 EXPORT_SYMBOL_FOR_MODULES references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: peterz@infradead.org, jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, puranjay@kernel.org, joe.lawrence@redhat.com, jikos@kernel.org, kernel-team@meta.com
In-Reply-To: <20260914062514.926997-33-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-33-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:45:09 +0000
Message-Id: <20260914064509.D4D941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script claims to cover commit d8a2860b4a36 but fails to=
 exercise its logic because it patches vmlinux instead of a module.
--

commit 0018f6f310cd6d22138d9d2b74d24fb1f9be4ab3
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES references

This commit adds a test script to verify klp relocations for symbols
exported with EXPORT_SYMBOL_FOR_MODULES(). The test aims to cover the
behavior of previous fixes related to klp relocation section naming.

> diff --git a/tools/objtool/tests/generic/test-export-symbol-for-modules.s=
h b/tools/objtool/tests/generic/test-export-symbol-for-modules.sh
> new file mode 100755
> index 0000000000000..7e7bdde6a7aca
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-export-symbol-for-modules.sh
> @@ -0,0 +1,39 @@
> +#!/bin/bash

[ ... ]

> +. "$(dirname "$0")/../lib.sh"
> +
> +setup
> +build_pair cross_module.c

[Severity: Medium]
Does this test actually exercise the module-patching case fixed in
d8a2860b4a36?

By calling build_pair without a -DMODNAME flag, the test fixture defaults to
patching vmlinux. Because the patched object is vmlinux, the
__klp_relocs.vmlinux section is generated regardless of the logic introduced
in d8a2860b4a36.

That commit forces the section to vmlinux when the target is a vmlinux
symbol, overriding the patched module's name. As a result of patching
vmlinux directly here, the test appears to pass even without the fix it
claims to cover.

Should this test pass a module name to build_pair to properly test the modu=
le
relocation behavior?

> +
> +sym=3Dother_mod_func

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D32
