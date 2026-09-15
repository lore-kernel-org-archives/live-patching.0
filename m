Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD823BB4A
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430834; cv=none; b=dF6aJN6vw3JqWTUc0LFEwxlpZS/K1IqrDDwtgQBaMGyYMfpa8wg40ZBRvp5lXVxPXtvcgjyiRKZ6IFIXdBtfoMZUi+Yp+HR0husPaX8jD069GvSfJJjV5VyibnIG6A5iqUHurrMLtdnSh9eZ9esCohAWZu0I56VvPrIbkaGpL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430834; c=relaxed/simple;
	bh=iOYhsWq3s+qRCmUYKx8uNQQ4AUGIYaz0iXFC7Xwyk48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N7euSn27VDaaS23hQRsPTJs+Tp1aYFMUyqaG1ZJn221d4oSM8HYEuEZrz/FQlCPOa7jUGDAtiNQEmPD3cWjap6hXyvk2VrthKSPIEm80b4jAX2yr+vP1Qhjz9iVEBbVFQv0YpC5IWDzDnHEa/v7vbajZcDMR9ye3VwDcoxLQidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf73kcNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf73kcNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120901F000FF;
	Tue, 15 Sep 2026 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789430832;
	bh=zFDF30uL3OQGdVZTK7qwXSwBPXEDyyOrHREtgTMtahY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cf73kcNpJkVIDy13wAigPYtMKUYNdrMRiMBlMVodI+4Bfu9+3FWePbuHzIQsechFC
	 6o+1WWVqxiUx8JFO5OalE6Ea5uyZeSS7VNxT0mWwQdlyywQsT8f9pYWUNbevA55dc6
	 5POfeKCyQ71L/WFil0qGxN3Ply+ElgBfAoe3/8ss7d/4iRHKJ7FtEFb5dC5fqrx/Pq
	 U87hzuGYmRRumJFxAsASwbJhJMbAStXUpYYnVJzyhi3y2+lUNaIa4pYUA4fa5FQaKu
	 elcwmD3/9IPg4gxj1KhSQ+QGVdE1wAWYpQ3F1+99K1aAeAUN0lFn9s4pfZVeD51oFA
	 c53S4bb1yZHyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/58] objtool/klp: Add test for rejecting references
 to init code/data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: kernel-team@meta.com, puranjay@kernel.org, peterz@infradead.org, pmladek@suse.com, joe.lawrence@redhat.com, jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org
In-Reply-To: <20260914230355.3422996-24-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-24-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 00:07:11 +0000
Message-Id: <20260915000712.120901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] objtool: test suite aborts due to fragile compiler assumptions
--

commit fa8e7a87126e5978150272fd5c3b8728c0d8f68a
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for rejecting references to init code/data

Init code and data are freed once boot finishes, so a klp relocation
against them can never resolve.

> diff --git a/tools/objtool/tests/generic/fixtures/init_reference.c b/tool=
s/objtool/tests/generic/fixtures/init_reference.c
> new file mode 100644
> index 0000000000000..51b2a57dde14f
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/init_reference.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Patched function referencing data in an .init section. */
> +
> +static const char __modinfo[]
> +	__attribute__((section(".modinfo"), used, aligned(1))) =3D "\0name=3Dvm=
linux";
> +
> +static int init_only __attribute__((section(".init.data"), used)) =3D 5;

[Severity: Low]
Can this static variable be constant-folded by the compiler since it lacks =
the
volatile qualifier and is never modified?

Modern compilers compiling at -O2 may constant-fold non-volatile static
variables or use symbol-relative relocations.

[ ... ]

> diff --git a/tools/objtool/tests/generic/test-init-reference.sh b/tools/o=
bjtool/tests/generic/test-init-reference.sh
> new file mode 100755
> index 0000000000000..16df80a112cfd
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-init-reference.sh

[ ... ]

> +# The rejection can only happen if the patched build really does referen=
ce the
> +# init symbol.  Were the compiler to fold the read into a constant there=
 would
> +# be no relocation, klp diff would succeed, and the failure below would =
look
> +# like a missing check rather than a fixture which stopped posing the qu=
estion.
> +# The reference is relocated against the section symbol rather than agai=
nst
> +# init_only, since the variable is file-local -- which is the form klp d=
iff
> +# has to recognise anyway.
> +in_relocs "$patched_obj" | grep -qE '(^|[[:space:]])\.init\.data([[:spac=
e:]]|$|[[:space:]]*[-+])' ||
> +	fail "patched object has no reference into .init.data; the fixture test=
s nothing"

[Severity: Low]
Does this strict check abort the test unconditionally instead of skipping i=
t?

The check relies on a section-relative relocation and lack of constant fold=
ing.
If the compiler does constant-fold the variable or use symbol-relative
relocations, this breaks the CI/build instead of gracefully skipping via
probe_skip.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D23
