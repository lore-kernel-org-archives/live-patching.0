Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EBE39B4A5
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428895; cv=none; b=TL8cpbX5ay+FOIyF9BKWOIREjBlKw66g0KU+CvqkcmHysHQt0KwFzqdRUKq9z6F3L1ns81iREtojJz+GoWE/uSWZGEpBBrhRZfMVNbeJWh2MwYHQPiDNydYPJpS63VjDsgQWurIc4bHoB/lrzvC2P1dkAcJQH4WahfmZDoW5jWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428895; c=relaxed/simple;
	bh=6RfAuZFb4oNnQbvxyibhfJzvgwWRRYBQKhhyhLyGySM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t4AjtLKJpz805mqeg6zp5BB5Ei7sKgT/F2gaXv6XUw8CJVFjcRPF4I0yYNwOK+DM3iFQostZcu0IDKb1hoAOkofgN9x5OnnWQ33XiyCh77a/TJaUWweT/S+Ed2nMvpMwrZjohtFXYUzi7CHHdTlp7LxPccmPWT6q69rRtzygU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl7i8C9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl7i8C9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEEB1F000FF;
	Mon, 14 Sep 2026 23:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428893;
	bh=ErAtH42bugnebGfd/iqt2vD4gpt7gxWl7qbptVFO6+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zl7i8C9x0w8MirtnEljEMHiNNC5TyYEQxCi0NbHDI1HrRRQy7WG9z47SPBp+MwZVk
	 cH1203vJNsvn8Ka5eUEbhoKIb+iTgf9pOTzJ042PwLSVLqBUd8ZjGSrw8/ApZPlIA0
	 QZI+DE/5P8ZFw8VPL9Rh6MjwX+0S3pc2+rs58jqEAlrnW4n5S6zgb9a5BGCPaNnKvX
	 gI1DUQ7U+TwAgDFZxW4yk6J1AQFObHRgmVO4aWfTMSnReYZLzNkc5wT/EyNQoy9x+q
	 tcplheIdEgMTuNVliV99A23h5vBxLWF4CaLt01S1nodEK8aWlq8lm7o6kmKOnaY+CM
	 hva9eRwMs3aZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/58] objtool/klp: Give each run one working
 directory, one per test inside it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: kernel-team@meta.com, jpoimboe@kernel.org, jikos@kernel.org, joe.lawrence@redhat.com, mbenes@suse.cz, peterz@infradead.org, puranjay@kernel.org, pmladek@suse.com
In-Reply-To: <20260914230355.3422996-8-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-8-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:34:52 +0000
Message-Id: <20260914233453.0FEEB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool/klp: test harness leaks top-level tmpdir on interrupt
--

commit e3c2fe244875e7154ea4380414b6732281ba9cd6
Author: Song Liu <song@kernel.org>

objtool/klp: Give each run one working directory, one per test inside it

Each test made its own mktemp directory, so a run scattered them through
/tmp among everything else using the same names, and there was no way to
inspect what a failing test built -- the objects are gone the moment it
exits, which is right every time but the one that matters.

Give the run one directory and each test a subdirectory of it, named for
the test and nested the way the source is.

> diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-t=
ests.sh
> index 6b937fc7f5bda..e6f1ac1b5d0da 100755
> --- a/tools/objtool/tests/run-tests.sh
> +++ b/tools/objtool/tests/run-tests.sh
[ ... ]
> @@ -98,12 +103,18 @@ else
>  	done
>  fi
> =20
> +# One directory for the whole run, one per test inside it, mirroring the
> +# source layout.  A run then leaves a single thing behind instead of 39
> +# scattered among everything else using mktemp.
> +rundir=3D"$(mktemp -d "${TMPDIR:-/tmp}/klp-tests.XXXXXXXX")" ||
> +	{ echo "Bail out! cannot create a working directory" >&2; exit 1; }
> +

[Severity: Medium]
Could this leak the top-level temporary directory if the test suite is abor=
ted
with a shell signal like SIGINT?

Since there is no trap registered for shell signals or EXIT, an abnormal
termination will bypass the cleanup logic at the end of the script.

[ ... ]
> @@ -156,4 +167,15 @@ done
>  echo "# pass:$pass fail:$fail static-skip:$static_skip" \
>       "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
> =20
> +# A failure is the one time the objects matter, and by default they are
> +# already gone.  Say so then rather than in the usage text nobody reads =
while
> +# something is broken.
> +if [ -n "${KLP_TEST_KEEP:-}" ]; then
> +	echo "# working directories kept in $rundir -- inspect, then rm -rf it"
> +elif ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then

[Severity: Medium]
Will this cleanup logic be completely bypassed if the script exits early due
to an interrupt?

Setting a trap could ensure this directory removal runs even when the script
terminates abnormally.

> +	echo "# $rundir was not empty; a test did not clean up after itself"
> +elif [ "$fail" !=3D 0 ] || [ "$xpass" !=3D 0 ]; then
> +	echo "# re-run with --keep to hold on to what a failing test built"
> +fi
> +
>  [ "$fail" =3D 0 ] && [ "$xpass" =3D 0 ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D7
