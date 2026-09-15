Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE33BCD0B
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516132; cv=none; b=Net3nBIa4yUec7/CpvuY/9nfQIvWQLfY+o2Z+Y6JgM51C5b1NhmV1Cpu4IZ16bwZ0YfdqKCj7He4rBGCVBj7rizDupLNHoGX+LWqW/iilWzRSybfmqsxpG+WEfg3Gn82+L1X7r4dYlSZZP0XGsxAoVfoB09flMsi7C0fFJX9m5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516132; c=relaxed/simple;
	bh=zfWzaor3QUlxihDWCMBYLDWfJToiNjecxKAZ/BLTWw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Me73VlY4rn885vuSSUcK5K02WAb7jkgKrOmReF0msP30drNaM12OKRGuDx6L4b13bbv+WpWlfH6zXdycsF52aNlhI4bzrhblIroNIxiwx3cRU3bFl+ObmPB+gLEbyTo1yoFrqsMSDPWcDK0pmZF6CpkDfpatcH+tIZOi8JBzqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIq/CtSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIq/CtSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5841F000FF;
	Tue, 15 Sep 2026 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516128;
	bh=7fOd+YN9+yumAxfoNDGuU6UnoNc8wlmQkcIPhycpXuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QIq/CtSi/tbepgIqA3xlWSg3+sEL37tWRES2plC0X1OyJNsGSUU7MHQ2yUcq73aSA
	 uFGSYfz/rM80eiNb0ro/ectBS0k5zLOe/E2oA9FMUnOWgP7HfgGlVyb6+2cMsYATZH
	 qCaHbQhPJ7aB3jpMJWnxLC2/g/VY5brRCQgnc+qcYrGq7+qsWcUguqKhW9hc2Pe6AU
	 dxx7IpGCkmth0rPKYFr+nsDVcWg7Qg8bqrpoqFj1GwtuC9Qv5m4GDKozR3svgjYaRm
	 enkUEe0ck5keKpjF/TUrBoy2sjvzabaQCTdB27+2PCPEHCzdyn9go9oXkDgQk7dD8K
	 kQ5oInqrWRMgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 33/58] objtool/klp: Add test for new references to
 exported symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: jikos@kernel.org, mbenes@suse.cz, puranjay@kernel.org, joe.lawrence@redhat.com, kernel-team@meta.com, jpoimboe@kernel.org, peterz@infradead.org, pmladek@suse.com
In-Reply-To: <20260915233454.2405019-34-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
 <20260915233454.2405019-34-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 23:48:47 +0000
Message-Id: <20260915234848.1C5841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool: test omits allowed module dependency case
--

commit f7100fa9cd984257015aa5ab4b28f4c57a67cb53
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for new references to exported symbols

This commit adds a test to verify the behavior of objtool livepatching when=
 a
patch introduces a new reference to an exported symbol. It tests both vmlin=
ux
exports and undeclared module exports.

> diff --git a/tools/objtool/tests/generic/fixtures/new_export_ref.c b/tool=
s/objtool/tests/generic/fixtures/new_export_ref.c
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/new_export_ref.c
> @@ -0,0 +1,20 @@
[ ... ]
> +/*
> + * A reference which only exists in the patched build.  The symbol has n=
o twin
> + * in the original object, so what klp diff may do with it depends entir=
ely on
> + * whether Module.symvers says it is exported, and by what.
> + */
> +
> +static const char __modinfo[]
> +	__attribute__((section(".modinfo"), used, aligned(1))) =3D "\0name=3Dvm=
linux";

[Severity: Medium]
Does hardcoding the object name to "vmlinux" in __modinfo prevent simulatin=
g a
module patch? It seems this might make it impossible to test the allowed mo=
dule
dependency path.

> +
> +extern int newly_referenced(int x);
[ ... ]
> diff --git a/tools/objtool/tests/generic/test-new-export-ref.sh b/tools/o=
bjtool/tests/generic/test-new-export-ref.sh
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-new-export-ref.sh
> @@ -0,0 +1,34 @@
[ ... ]
> +export_syms
> +add_exports other_mod newly_referenced
> +run_diff 255
> +assert_diff_log 'undeclared module dependency'
> +
> +pass "new reference allowed to a vmlinux export, rejected for a module e=
xport"

[Severity: Medium]
Does this test omit the allowed module dependency case? The script asserts =
that
new module exports are strictly rejected, completely missing the scenario w=
here
they are allowed (when a pre-existing module dependency exists) as describe=
d in
commit 72d76d0c18eb.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915233454.2405=
019-1-song@kernel.org?part=3D33
