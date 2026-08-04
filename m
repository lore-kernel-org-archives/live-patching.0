Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAA36E498
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826596; cv=none; b=o3VQwLvPz128i44MflUqb4LeKYfVZvatEBWKBVe6ZnRG/jhSo3pBvdafvA05IAXcs5rkUdxKe11NhSqu3t9Sgi+bWa78UYBAraTKoPdgncTIQP4YEJ4mWrYSUuUtwj2dt+8cJEXgHWo3iR7voyF1qpjhrjwX06jjzjl0PEHBxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826596; c=relaxed/simple;
	bh=3YkMQQRxk7CKeuXSdVNEGTPmAAva0P21Z/1QrqkGYHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X8AOxErueWmov0pbzIg3rUBMfQp8ETo5qkvsywcfeYGCTSS0DQkuaTx7cuUqXhFi+rkCrcZOX7e7Gd+RDtFDgn5aYvOoUpj9EQJEJbxK9ftvClHK2y1H+Q+s1MQKXhuZwpxmB/y/tlwlgA0by/91Zolwcut/QAkVj7tffrRW0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxrHb/jK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxrHb/jK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A31F00A3E;
	Tue,  4 Aug 2026 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785826593;
	bh=kkpKpYnhtAJGhq0jCqi7bs6/iRGsdZnzTOZW+Q26WCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxrHb/jKGoWE7HVlUGxG6xrisAh3UinyhHmWeoWnTMe4ljXPQmFiNABSIB/WK6wLZ
	 zHPn/PW9Ns5vXqpSy/gqw1UxvfgcpE/z6Lz6Mb35cQon3oJXGeQu/8Y5q5xM1gb6xe
	 0uwkjV12tIqfYbpEcQnIQtA4+9u5fPFJW/W9sIprbZBgnWIc6sz3TCkhN08xOHD9yQ
	 K+tSqIMvrr5W9V+UBC9xGMbh1ZGknIG27tJW6JyuIl0bF4W2sSpeqEw7sXmtZmrPRH
	 Cxakn7K7gcfHPpTdoYwUW82gac4CeP54ZaHEJi9J1zcGaOaeJ0kNDwd40rKJGXnIMH
	 aRPF8bd3BDkzA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/4] livepatch: Make klp_find_func() non static
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, joe.lawrence@redhat.com, song@kernel.org, mbenes@suse.cz, jikos@kernel.org, pmladek@suse.com
Cc: "Yafang Shao" <laoar.shao@gmail.com>, live-patching@vger.kernel.org
In-Reply-To: <20260804065010.44922-2-laoar.shao@gmail.com>
References: <20260804065010.44922-1-laoar.shao@gmail.com>
 <20260804065010.44922-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 06:56:32 +0000
Message-Id: <20260804065633.0D6A31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] klp_find_func() incorrectly returns the search parameter instead=
 of the matched object from the list.
--

--- Patch [1]: [RFC PATCH v4 1/4] livepatch: Make klp_find_func() non stati=
c ---
commit 59916304ff12f7685cb556f7a7c1f4a1c5a25b00
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Make klp_find_func() non static

This commit makes klp_find_func() non static so it can be used in other
source files by an upcoming patch. It also renames the old_func parameter
to func to better reflect its generic purpose.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26d..e07c41a0f3ac8 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
[ ... ]
> -static struct klp_func *klp_find_func(struct klp_object *obj,
> -				      struct klp_func *old_func)
> +/* Check if @func is present in @obj. */
> +struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *=
func)
>  {
> -	struct klp_func *func;
> +	struct klp_func *obj_func;
> =20
> -	klp_for_each_func(obj, func) {
> +	klp_for_each_func(obj, obj_func) {
>  		/*
>  		 * Besides identical old_sympos, also consider old_sympos
>  		 * of 0 and 1 are identical.
>  		 */
> -		if ((strcmp(old_func->old_name, func->old_name) =3D=3D 0) &&
> -		    ((old_func->old_sympos =3D=3D func->old_sympos) ||
> -		     (old_func->old_sympos =3D=3D 0 && func->old_sympos =3D=3D 1) ||
> -		     (old_func->old_sympos =3D=3D 1 && func->old_sympos =3D=3D 0))) {
> +		if ((strcmp(obj_func->old_name, func->old_name) =3D=3D 0) &&
> +		    ((obj_func->old_sympos =3D=3D func->old_sympos) ||
> +		     (obj_func->old_sympos =3D=3D 0 && func->old_sympos =3D=3D 1) ||
> +		     (obj_func->old_sympos =3D=3D 1 && func->old_sympos =3D=3D 0))) {
>  			return func;

[Severity: Medium]
Will this return the correct object? It looks like this now returns the
search parameter (func) instead of the newly introduced list iterator
variable (obj_func).

If a caller relies on the returned pointer to access the matched object
from the list, they will receive the search parameter instead. This could
lead to incorrect state manipulation or memory corruption for new users
of this exported function.

Should this return obj_func instead?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804065010.4492=
2-1-laoar.shao@gmail.com?part=3D1
