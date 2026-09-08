Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994205328A8;
	Tue,  8 Sep 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870350; cv=none; b=qxw9U08t//VZ+ge1sQXwvF/x3l2q3F3zDcS3qCrkO8EsRyLitCZjlhJslM0tN4asg89CGxVF5IWjxJtb33QdTWv3GoGQlYppxQhtnxJXoJ6y9XdtfRBEI4MTlKTy1uU+sRdTgbvP83KV4UrJ+/KRdQsazIK8CKePoFn8YlxWFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870350; c=relaxed/simple;
	bh=4rFBA3HKDb+638PqkSiiH+hYUtCnA8lUX2rhTsukyFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RyUGQ9uzFny2MMl6Wbf54sQb6H8EzYEfzIe+SO+WBk31HuDKqzBw4t+6+aIr5ww0mn+j1gXeARXT5PCXXJc8pjeOAZl34ir1xYrdob5itFYEnDQ4SFJm2aFI8S9tlDB5hHOLn+nevR5aQqaglxLaOoiIRggc1bu1ijFHt6e59sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1NqRal/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1NqRal/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F41F00A3A;
	Tue,  8 Sep 2026 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870349;
	bh=0rtUs+O/l71Yeg+5z6gmxu3148+6wPm/5qkpJWj68dA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1NqRal/WD62Owvz2WzfbhtEbObyyYUCbsVEiRo/a3h1lMvSosI6PvHRFxd7oACrd
	 h12fD+3zSnM9ARa90hFPJN9NyzKlpwlnqcu4zltGVpgNwERdtVx1oDI/OmZm3H4Z2H
	 a6kQkY7uXa2st9olvX6ycVtsDNlB/JiH1pQHiQXwD49y95NvqozLTH50ybAHT4R2nC
	 b0W9z4LYCsD47hAXej9FrWiSh/V0sC5pPwnoxfAcTIXqk8bEz8SLxAteKD8Ki6wr2O
	 z0PDYoS9gq/TcKwlVWWP7hL964r2UU68j3VYM+0jd4CgAM/YHw6xvNXcSyckbopqmV
	 Ou6uStP6sxFRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] livepatch: Clean up klp_init_object_loaded()
 when fails
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, joe.lawrence@redhat.com, "Harry Hsu" <x90613@gmail.com>, "Petr
 Mladek" <pmladek@suse.com>, mbenes@suse.cz
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org, live-patching@vger.kernel.org, song@kernel.org, jikos@kernel.org
In-Reply-To: <20260908120325.299649-6-pmladek@suse.com>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-6-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:25:48 +0000
Message-Id: <20260908122549.193F41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Partial relocations are not reverted when apply_relocate_add() fai=
ls midway, leading to permanent state corruption.
--

commit 3f6df1b4ed699e839abbdc8919a6c7de5d1850c8
Author: Petr Mladek <pmladek@suse.com>

livepatch: Clean up klp_init_object_loaded() when fails

When loading a module, klp_module_coming() updates all enabled patches.
If an error occurs, klp_cleanup_module_patches_limited() cleans up fully
processed patches, but skips the patch that failed midway. This commit
updates klp_free_object_loaded() to revert all and only changes made by
klp_init_object_loaded().

Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.o=
rg
Closes: https://lore.kernel.org/r/20260830175608.4BABB1F000E9@smtp.kernel.o=
rg

> Next, klp_init_object_loaded() has to clear its own changes on
> failure. It just returns an error when relocations failed because
> they clear their own mess. It could call klp_free_object_loaded()
> in other situations because all relocations were done and other
> values are just cleared.

[Severity: High]
Does this actually clear its own mess completely? Looking at how relocations
are rolled back in klp_write_object_relocs_limited(), which was introduced
earlier in this series:

kernel/livepatch/core.c:klp_write_object_relocs_limited() {
    ...
		ret =3D klp_write_section_relocs(patch->mod, info->sechdrs,
					       info->secstrings,
					       patch->mod->core_kallsyms.strtab,
					       info->symndx, i, obj->name, apply);
		if (ret) {
			if (apply)
				klp_write_object_relocs_limited(patch, obj, false, i);
			return ret;
		}
    ...
}

By passing i as the limit to the rollback function, the rollback loop:

	for (i =3D 1; i < limit; i++) {

will terminate at i - 1. Doesn't this skip the rollback for the partially
applied section i?

If apply_relocate_add succeeds on relocations 0 to k-1 in section i, but
fails on relocation k, these partial relocations remain permanently applied
in the livepatch module's text.=20

Subsequent attempts to load the target module will fail immediately at
relocation 0 due to non-zero target memory, converting a potentially transi=
ent
address-space layout failure into a permanent -ENOEXEC on retry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908120325.2996=
49-1-pmladek@suse.com?part=3D5
