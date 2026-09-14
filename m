Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A313793B3
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368560; cv=none; b=CpJjSDfdXYKDHozLWMuHD4yp9dj7lKJv99DvDYIZA8b0piJHCbpJs6p5LSEnKVFF31bhTkVkjqYA/Z7GqKuslPUwj5UPpplAbuk6ylv8cWbmwNxogdyP7GF4xCVif67Vpn1TT3ZfkeJyfGS5V4ePslcRVVEpjg52kOHky3PE0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368560; c=relaxed/simple;
	bh=4vmbLsK/9Qa1ovp8a4P8TItXy3iqrTBClv529M4gA5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m0bHW4eUOdu7B8JyoVi1uskPMNT33C5p0/TvGo3vY1oLjG9Ur2ry9yLw8SKGUoXJgfvW0hmhh9re/5TWgU9dsNZtsGGXJnSCMbrp0JS/krclIA2YEwBXDRL1zpWRKinss82d50FM0C0s4K3N6OJRQvR5tbFPYXbDEfoaAdRwz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHYXTTmo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHYXTTmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132B41F00899;
	Mon, 14 Sep 2026 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368558;
	bh=KUzQmjNNDL+avtKik4pUVQbofRc8jdlXamYHQdY6PWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHYXTTmoZTKSUbxrfCXaZDwtPlS/8R6zBPsN5kW1RdrTgxprXoWNdUK1Fmrnyyd8Z
	 es89wr8aXAwKuyIF+mx8r/3ifhdM58mAvwjqhDIfYRusXgeOZ/Em2tSlUlatcKA4wo
	 emONd4kIURvhUMxa53+prfJpPSJaO0bJqWIUbfH3jjaaBoMqpiqtIW5RfDtB7XWaJJ
	 yX9tNNRD9qLqg8qYFD5PjzklNOb3886/KF9KC6zyR1vmsYnpUXYtYpCkrM4E8Nhtg1
	 uAAkbyXsC4Us948enKwqz2SFekIHDXtzD+CqvKqM+Fe0ZpZcXb78tUYXlH66pbavlK
	 HVnFi5xCmDaGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 37/58] objtool/klp: Add test for sympos in module
 objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: pmladek@suse.com, jpoimboe@kernel.org, mbenes@suse.cz, kernel-team@meta.com, joe.lawrence@redhat.com, peterz@infradead.org, jikos@kernel.org, puranjay@kernel.org
In-Reply-To: <20260914062514.926997-38-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-38-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:49:17 +0000
Message-Id: <20260914064918.132B41F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Objtool's klp_find_sympos() for modules counts symbols in init and=
 non-alloc sections, causing livepatch resolution to fail if applied after =
the target module is initialized.
--

commit 22d70a31297d85e4712560a5e8b6e9de9ffd35be
Author: Song Liu <song@kernel.org>
Subject: objtool/klp: Add test for sympos in module objects

This commit introduces test coverage for the klp-sympos logic in objtool.
It adds a new fixture and bash script to verify that duplicate symbols are
correctly numbered by sympos in module objects.

> diff --git a/tools/objtool/tests/generic/test-sympos.sh b/tools/objtool/t=
ests/generic/test-sympos.sh
> new file mode 100755
> index 0000000000000..b71d4930a22af
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-sympos.sh
[ ... ]
> +run_diff
> +
> +assert_klp_sympos dup_counter 1
> +assert_klp_sympos dup_counter 2

[Severity: High]
This is a pre-existing issue, but since this test checks the output of
klp_find_sympos(), I wanted to ask about its symbol counting logic.

Currently, klp_find_sympos() counts all identically-named symbols in the
module's ELF symtab:

tools/objtool/klp-sympos.c:klp_find_sympos() {
...
	for_each_sym(elf, s) {
		if (!strcmp(s->name, sym->name)) {
			nr_matches++;
			if (s =3D=3D sym)
				sympos =3D nr_matches;
			else
				has_dup =3D true;
		}
	}
...
}

Does blindly counting symbols in .init or non-alloc sections cause
livepatch resolution to fail?

When a livepatch is loaded after the target module is initialized, the
kernel's module_kallsyms_on_each_symbol() uses mod->core_kallsyms, which
strips init and non-alloc symbols via is_core_symbol().

If a livepatch targets a module symbol that shares its name with another
symbol located in an .init or non-alloc section, it seems klp_find_sympos()
assigns an inflated sympos (e.g., 2). However, the kernel would only find 1
matching symbol, see a mismatch with sympos=3D2, and reject the patch with
-EINVAL.

Should klp_find_sympos() be skipping init and non-alloc sections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D37
