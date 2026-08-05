Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5393F39D0
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968601; cv=none; b=AfmQXp1YJ6+aC1CDOsKDdQk1L00QmjBAt02NePMlgO+2HGWiKpC/bFYt7h6pHcvQJmZ13kvkeRDE0m91dw6qkKCbLO9ca4qQ2AE5eR6z0pDL+iZLcFU4Tclmj7FD00EouLwwAsaNg2xSmgyWDdFOC2ZI8Mzs1LAakxwzi7SJJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968601; c=relaxed/simple;
	bh=5wKBaXPO/uDweOyeK3m57ugfEQNN3HGrHV0P8lTct0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzQk/ne2kdpU9YJr3Wosn2nGVXZboAtQc0YKV8ige2lM4xBYLJdmyQEHWqeYWw/4wvtr28EmHQjGkw76ZygosLs2wfNkZxXiqNFfgxcmPYFAyoQxkbwJc1BCDg/LveQ1qxK2qJznN+2gZPJtYPJRwEhjzAHBoFg5jOdDbInyWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSVESmQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSVESmQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DEB1F000E9
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 22:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785968600;
	bh=ysMr1scpvEq7CSugBm+cVOHXNjh9PXqUUvXED4KXxbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FSVESmQNc86AWqk2em7S0qJlVhf3QqKEqVy305oqHC9lxnN2zaWPjHnwnzxbcfT6T
	 1hgm+anr5vftiwd/N123ffDJdeUu+zcUGu6kbj9eTMDRn7Mmd5cPDAOtxuX1xX24B5
	 GOtLdZxd/thLmOM7aZySr/q5NOgdOhET8fEx8U8ATwbQS+uaJmtGZfq/NJLAKy0Mvr
	 t1O2djwLkS+5uG6lXZXVLYud9/ClZgOWzzCN872Jt+30+dHH0909nUqZwU3gTKfwwQ
	 mWFAegXFAZAisWKM0E7wCvSUFtHrGwDEDnx4kuBVxOnmBNIDuuxN8qfYNhOqX+cDc/
	 wl+pAvZeRoDEw==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-930f4e5eed1so98276385a.2
        for <live-patching@vger.kernel.org>; Wed, 05 Aug 2026 15:23:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoHGIjjp2deF6DAZRZdR+vvPTmMgs3nfLwXv0ImS6vFa46L+1STOf3UIQmNhrjIYrfjeaaXyS/oSPazpnUa@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqBxeLW9zSzaEmBvGtRjhDHDQXpIq2fkQrTwG+T6IZ9303YiT
	KAAgnWxtaw65WHoE3VYYmSglg1gnSKVOyMFjXDkphL+jjtl6Fvd5X7qC8YcfA0sQWIjsUh15d3q
	IR93QRQ8BzbM6ScsJfNZPGC37hlmLdZI=
X-Received: by 2002:a05:620a:5697:b0:931:4b6:a9e6 with SMTP id
 af79cd13be357-936492ece30mr740801185a.47.1785968599405; Wed, 05 Aug 2026
 15:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785939903.git.jpoimboe@kernel.org> <e5a665072e9b5b63cfe95d5a4ca1d11dd0a7a96a.1785939903.git.jpoimboe@kernel.org>
In-Reply-To: <e5a665072e9b5b63cfe95d5a4ca1d11dd0a7a96a.1785939903.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Aug 2026 15:23:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5rBsXv6xT1MpvnuCvO_zSeo5vyxSrHJqDCwnjrRkfziQ@mail.gmail.com>
X-Gm-Features: AUfX_mwfiGMY_dbOZcoejJV2OZRljHTF90Z6mdCEbsh2sOBc2cgLy-iZaqWUPUM
Message-ID: <CAPhsuW5rBsXv6xT1MpvnuCvO_zSeo5vyxSrHJqDCwnjrRkfziQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] objtool/klp: Fix cross-module klp relocation
 section naming
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> A klp relocation section is .klp.rela.<objname>.<secname>, where objname
> is the object being patched.
>
> klp-build wrongly derives objname from where the referenced symbol
> lives, not where it's referenced.  For a cross-module reference like
> patched can_isotp code calling can.ko's can_rx_unregister(), that gives
> .klp.rela.can..text rather than .klp.rela.can_isotp..text.  Unless the
> patch happens to patch can.ko as well, the relocation never gets applied
> and the call goes off into the weeds.
>
> Name the intermediate section __klp_relocs.<objname> so post-link can
> read the patched object's name from there.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Link: https://lore.kernel.org/20260720145658.1103243-2-joe.lawrence@redha=
t.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
