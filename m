Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40DB49BD69
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516241; cv=none; b=kCpa0EOplm6teGRkEvy2D0lOgnmyJzkdvBXXCciywFT4XYDyT/1PnRvQwMVe3xleRC7f23pgkYzb3CmUmF/KufJSujfH35JY6pk7+cMzF8Kt02CBJLRm88XsFTCGOqPpDFdEQUbTp6FjSgrITsLWrgYZMmUY948FuuyM9QPaBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516241; c=relaxed/simple;
	bh=bvyn/citg+3yTHc7+153W9ifGcs9qRX4QjeMyFiBwow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fra7/eDTnV2nozkA0JP29d9H043AfvRAcEgA9MSGUt8HYai2X/Ly2w29B714SjCfKy7UhJvgkfl+0J2WFGcmjB+zbrdkWFzx2Zz/AK63EBa2qocN27mhJCPzW7g2CRmIlPl4jedF7Gn8IM0ZPdKaepcGuIowmLC3lCDuju+CcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9aj9uSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9aj9uSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AEC1F000FF;
	Tue, 15 Sep 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516239;
	bh=bwFY3lfduxpaSyps9iFop7AHqH/DqaD2DsuyuNC7L+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9aj9uSIhqBqj4fnh3H8Y+z+UqA3mr5B8vfV/hrBEuuF7xDHJd5QsOnR+8T6aTTMk
	 5yhP03JVWLc2pkx39o5BTiZGhkp22L4MQDkJuMPgexUXbCyaECSgiZjOIFMYMKsLPL
	 ZPtaLZoolyp8baa3nE5YbjuywCUHFlSZqzvLTC3NJ9V41T4dE661WyRzkf9LlPuK1V
	 dowiiG9RVvsBnG5YYTJsYxVTwtIOkpSRj2Jw3yuP2dw5tHfLHOYd1exuOQ5mrQx169
	 eaoYsdpLbgFnc0KXlHwX9Wp1c93KTKxT5ZbIBrDFmiSkD08c4ONIZAXoEqexqBTphe
	 1uAZqM2sw8Fww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/58] objtool/klp: Grow the klp test harness
 vocabulary
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: jikos@kernel.org, pmladek@suse.com, puranjay@kernel.org, peterz@infradead.org, mbenes@suse.cz, jpoimboe@kernel.org, kernel-team@meta.com, joe.lawrence@redhat.com
In-Reply-To: <20260915233454.2405019-7-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
 <20260915233454.2405019-7-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 23:50:38 +0000
Message-Id: <20260915235039.29AEC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool: syntax error in re_quote() sed substitution
--

commit d250ad3b119a644d241a85f86850556fd200db22
Author: Song Liu <song@kernel.org>

objtool/klp: Grow the klp test harness vocabulary
   =20
Assertions for what klp diff produces, and for what went into it.
The output side covers the things a livepatch is made of: cloned sections
and symbols, klp symbols and their sympos, tombstones, and relocations.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 9330d839ff850..ffc1efb06233c 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> +# re_quote <string>
> +#
> +# A string as a literal basic regular expression.  Nearly every name the=
se
> +# assertions match on contains a dot -- .text.target, .klp.rela.vmlinux =
-- and
> +# an unescaped dot matches any character, so an assertion for one sectio=
n can be
> +# satisfied by a different one whose name merely lines up.
> +re_quote() { printf '%s' "$1" | sed 's/[].[^$*\\/]/\\&/g'; }

[Severity: Medium]
Will this sed substitution work correctly in POSIX, GNU, and BSD sed?

The command sed 's/[].[^$*\\/]/\\&/g' is invalid because the delimiter
scanner processes \/ as an escaped backslash followed by an unescaped slash.
It treats this slash as the end of the regular expression prematurely, which
results in a syntax error like 'unknown option to s' or 'unterminated
s command'.

This failure causes re_quote() to return an empty string, which makes
assertions like assert_section silently pass by matching any two consecutive
spaces in readelf output, and others like assert_klp_sym consistently fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915233454.2405=
019-1-song@kernel.org?part=3D6
