Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED813B774F
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429279; cv=none; b=chL0dRktyX9R4I/5wup7j/o/Sk8Mx/V+MYqqpdG4vVAKB6MqnB1k8Z48Uo9ntgICBB2pIx1dDZon/cyNqum/hmRMFCmWhdXBF4d0R99foTVobAWxAAiRdZKuXckVAgm5upQ02Czlz6VFZHTYpScryeAr3acWzCqTbVyt6VcCjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429279; c=relaxed/simple;
	bh=Tst70YFC47gg6Hx97GuUJ/61R/sohzZatEUVtjXS/Xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QXWAwkg7JMNi2M7tc8QCySLtaeJp1up3KFFFo5BNRtWzKI2VSiw5ZGRlOTIaE6ym35/OtLU3S3/nBKSy+I/Tvr06BbP0J6xJUZ6Tm2hUGMLp1jjdb3OBoN6eAuLNGlGXwX2Ni4rXvTQR+Pqtmjcuhr8yksxw3+5p2gnJIHdie5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bweUI3iV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bweUI3iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F551F000FF;
	Mon, 14 Sep 2026 23:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429271;
	bh=qr9TaeAox/KxfzyexIIuerc4MVOQ3xNxkv+qN2xoHEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bweUI3iV6Gsx833QplD9rb3vIt7opVr2O3I2Y5DqocvO6JeZZg4kfwSvnyU7Bwl4l
	 YZfAMbR7YrNvTf3fObS7zq7A4Qni7nO64Y2x8SJNasyIbT96RJXr7gEdtpU9ImYdOG
	 5Zw4RYrVW2l05/wQQF2//5NIE81ecgQWi71yKsCzGYOfNOhzjfXBWE6JP0oNrEpqWS
	 45+cKrUlNT1kdSo+MUUg9goOJ9oetepMeTDGhxarG/pFOjGplDKh2GDget/sUiFsRY
	 ZMJzlvNlzyHyzDPyotK384uzIm7qqy8YhmORZU1ekFPhVGwgx93vuWiyTnB8WF3rS4
	 K4hblayMQdmFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/58] objtool: Keep failing test workdirs by default
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: joe.lawrence@redhat.com, jikos@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, pmladek@suse.com, puranjay@kernel.org, mbenes@suse.cz, kernel-team@meta.com
In-Reply-To: <20260914230355.3422996-11-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-11-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:41:10 +0000
Message-Id: <20260914234110.97F551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool/tests: misplaced artifact removal warning in KEEP=3Dnone=
 block
--

commit 6a850bca1e88fd95f7b038a701cf95c2d9700c66
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool: Keep failing test workdirs by default

This commit modifies the objtool test runner to keep the working
directories of failing tests by default. It introduces a KEEP variable
that can be set to 'all', 'none', or 'failed' to manage these artifacts.

> diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-t=
ests.sh
> index e6f1ac1b5d0da..81dd33f1819b5 100755
> --- a/tools/objtool/tests/run-tests.sh
> +++ b/tools/objtool/tests/run-tests.sh

[ ... ]

> @@ -167,15 +182,44 @@ done
>  echo "# pass:$pass fail:$fail static-skip:$static_skip" \
>       "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
> =20
> -# A failure is the one time the objects matter, and by default they are
> -# already gone.  Say so then rather than in the usage text nobody reads =
while
> -# something is broken.
> -if [ -n "${KLP_TEST_KEEP:-}" ]; then
> -	echo "# working directories kept in $rundir -- inspect, then rm -rf it"
> -elif ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
> -	echo "# $rundir was not empty; a test did not clean up after itself"
> -elif [ "$fail" !=3D 0 ] || [ "$xpass" !=3D 0 ]; then
> -	echo "# re-run with --keep to hold on to what a failing test built"
> -fi
> +case "$KLP_TEST_KEEP" in

[ ... ]

> +none)
> +	if ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
> +		if [ "$fail" !=3D 0 ] || [ "$xpass" !=3D 0 ]; then
> +			echo "# keep=3Dnone: artifacts were removed" \
> +			     "(re-run with KEEP=3Dfailed or KEEP=3Dall)"
> +		elif [ -d "$rundir" ]; then
> +			echo "# $rundir was not empty; a test did not clean up after itself"
> +		fi
> +	fi
> +	;;
> +esac

[Severity: Medium]
Does nesting the failure advice inside the if ! rmdir block prevent it from
being displayed?

If a test fails but successfully cleans up its individual subdirectories, t=
he
rmdir command will succeed and return 0. This skips the entire block,
swallowing the intended "artifacts were removed" advice message.

Could this also fail to report test leaks if they occur alongside test
failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D10
