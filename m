Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786A316199
	for <live-patching@vger.kernel.org>; Thu, 14 May 2026 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792311; cv=none; b=AT3D2McI3RxWZSJ707Y2tO3qYNi77DQw0I7bFeLy+Z5R4kopdHrJzBMxEdlOj7AIluSABwTUYz/3i5bpj/s5Ugc7rACy3MkLhJDzsPo75YwOhrXNELPWBMwpdRUUCjcamMdsOdsCOuw9s+Oj6P4/o6tu5PaGHvpgwcmOUBAh5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792311; c=relaxed/simple;
	bh=tDBB0k+YytDrmOF8vWafRFGugSLmmHiVaS+C+f3uK0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pLLY2atFNAkk1V4l+WZffIFHjtJhLUAIHtWdazhVWNz4F55sm9eGMZv/klaOysXtT+WbHt3SUSQY6vPpMMfOz0dfbBXnSWEBCt0z8OSNOIoahgy82kQKbcQjTfc1cX0MXiY3xCglkRJsI2igu2pPcPaHAuzQFMOYQtimGbRD8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvaRsR3k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvaRsR3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEDCC2BCB3;
	Thu, 14 May 2026 20:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792311;
	bh=tDBB0k+YytDrmOF8vWafRFGugSLmmHiVaS+C+f3uK0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IvaRsR3kR3bOCFyVjzzrCXY6CCqWeNi4Y7nYMrRADlgxk3A/rNQ/IV33VJ098BiAC
	 ip2/BBxDEHqixvcfqesx85P8I7IJZV4Phsg1KGJKMA2X2uDS2aMI3L1rbqQbFsUA9W
	 TwH6NTA4jmNYnA9EXngWqrGOLGbz+dtriprcULm0O7EWm/rdl8KqVF0BUSL3dy+Ndp
	 0DfiFhuOp6aEvSRIzEEspbtr2yxK801NApNo0gDcfKDSSYaIskmC5qkbmGCS9D6G61
	 Y4bXIfAsKdAWDHbdlEMGmwiiaa3dfSSFuS0GxxFSlZmZoxcPTLNHB/4/3h6k+3aVjj
	 H6BkZDuUTKxww==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/4] objtool/klp: allow special section entry size
 overrides
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org
Cc: "Miroslav Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Song Liu" <song@kernel.org>
In-Reply-To: <20260512221102.2720763-3-joe.lawrence@redhat.com>
References: <20260512221102.2720763-3-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 20:58:30 +0000
Message-Id: <20260514205831.0AEDCC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The custom entry size logic bypasses section size validation, allo=
wing the creation of out-of-bounds ELF symbols.
--

commit 07468f70445bbc595d50f5edb50b5c394dc62f05
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool/klp: allow special section entry size overrides

This commit allows users to override compiled-in defaults for special
section entry sizes via environment variables. This helps process cached
unit test objects built from different kernel versions where the compiled-in
sizes may not match the actual entry sizes.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 0774ab312d033..84c00b673085b 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c

[ ... ]

> @@ -1700,6 +1716,21 @@ static int create_fake_symbols(struct elf *elf)
>  		}
> =20
>  		entry_size =3D sec->sh.sh_entsize;
> +
> +		/*
> +		 * Some special sections have multiple relocs per entry,
> +		 * so the reloc-based heuristic below doesn't work.  Use
> +		 * the arch-defined entry sizes for known special sections.
> +		 */
> +		if (!entry_size) {
> +			if (!strcmp(sec->name, ".altinstructions"))
> +				entry_size =3D entry_size_from_env("ALT_ENTRY_SIZE", ALT_ENTRY_SIZE);
> +			else if (!strcmp(sec->name, "__jump_table"))
> +				entry_size =3D entry_size_from_env("JUMP_ENTRY_SIZE", JUMP_ENTRY_SIZ=
E);
> +			else if (!strcmp(sec->name, "__ex_table"))
> +				entry_size =3D entry_size_from_env("EX_ENTRY_SIZE", EX_ENTRY_SIZE);
> +		}
> +
>  		if (!entry_size) {
>  			entry_size =3D arch_reloc_size(sec->rsec->relocs);
>  			if (sec_size(sec) !=3D entry_size * sec_num_entries(sec->rsec)) {

If entry_size is populated from the environment variables, it skips this
validation check entirely.

If an invalid entry size that isn't a clean divisor of the section size is
provided, could this lead to an out-of-bounds memory access regression?

>  				ERROR("%s: missing special section entsize or annotations", sec->nam=
e);
>  				return -1;
>  			}
>  		}
> =20
>  		for (offset =3D 0; offset < sec_size(sec); offset +=3D entry_size) {
>  			if (create_fake_symbol(elf, sec, offset, entry_size))
>  				return -1;
>  		}

For example, if sec_size(sec) is 20 and entry_size is provided as 12, the
loop will execute for offset 0 and offset 12. During the second iteration,
the fake symbol will extend from 12 to 24, which exceeds the section bounds
and may cause out-of-bounds accesses during subsequent objtool passes.

Should there be an explicit validation check to ensure the overridden
entry_size divides evenly into sec_size(sec) before proceeding to this loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512221102.2720=
763-1-joe.lawrence@redhat.com?part=3D2
