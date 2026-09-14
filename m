Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648252D7380
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367856; cv=none; b=NidcIgeeB2w9/e4AwhH7us9EGrt9lPEwNnRhjF6KL1dUnpdnKo4ayqz5c8JqHDbSqx0+FpyT51f5ian+B8oYTgufezRUjuTRUhMyNMAEBiqgMTxmA9orURV5zqtniixkbs7qAFd2JkJb1iiwr2mu6FKbU2TWoAawpEL5m1djOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367856; c=relaxed/simple;
	bh=XwwHGZYDGdiTdAaeN7vXDYfKG6PkjOZlV+8XZeGE+vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DhbqnxKz1SEOiQQF2inezIBEbVyRIGlU28jtRRBflHEeeKYxMqgiKi87mkgP93y0/E75g5kqICgIzD6QkfsM3nqjm3QvRgee02rc9A1O9Y5K+4qd8HaJTEE0NyTWRhykr2mzlcfsP9fls+QrNsOx2B56CrmlSoG25lzSVRa9mHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hw0IPKEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw0IPKEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E531F000FF;
	Mon, 14 Sep 2026 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367855;
	bh=vMx8HGu159w51fjFBXUHzM3qkQGazYpcIxbWs/9hkks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hw0IPKEXIZYzYmhumnApxlL6flGf2xTjCWSo1ognq/gnLWmFiavVepOWPg8lIyW/e
	 sVBNaJZHWlg7XKtO0GVxskX1EhNO8fXHgdOFrgjkrIUjVfLg9RfAHtyzsL3dpUQNMP
	 soPwmtCMs4ukkfOfWhvFInLGdTf2SLtrbCunzXf92U1f7NZhiPW5X+V+35DK1R5Rpk
	 cL4TmH039FK1M37n31wMy95ka1hoJcH9+2+Kp3N1XVm2guHiQ4UZIUNsAGgn5CBfmU
	 tdbgBXzpxBdKqKsVE54BmWAOagxsrj+TVgLpiHAUaqlr5nDYfY7DQcY3UNVjCspgq+
	 khrTsQPftPt5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/58] objtool: Keep failing test workdirs by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: jikos@kernel.org, mbenes@suse.cz, kernel-team@meta.com, peterz@infradead.org, jpoimboe@kernel.org, pmladek@suse.com, puranjay@kernel.org, joe.lawrence@redhat.com
In-Reply-To: <20260914062514.926997-11-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-11-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:37:33 +0000
Message-Id: <20260914063734.71E531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect shell logic nesting hides failure hints and masks leak=
ed artifacts in KEEP=3Dnone mode
--

commit 3f45b4f5eca60d068a16adeda22b98b456f84450
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool: Keep failing test workdirs by default

Change the default test behavior to save failing test working directories
instead of deleting them. Add a KEEP Makefile variable to optionally retain
all or none of these directories.

> diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-t=
ests.sh
> index e6f1ac1b5d0da..81dd33f1819b5 100755
> --- a/tools/objtool/tests/run-tests.sh
> +++ b/tools/objtool/tests/run-tests.sh
[ ... ]
> @@ -167,15 +182,44 @@ done
[ ... ]
> +none)
> +	if ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
> +		if [ "$fail" !=3D 0 ] || [ "$xpass" !=3D 0 ]; then

[Severity: Medium]
Does nesting the failure hint inside the ! rmdir check in the KEEP=3Dnone
case block prevent the hint from being printed when tests successfully
clean up?

If rmdir succeeds, meaning tests cleaned up properly, this entire block is
skipped. Also, if a test leaks files (causing rmdir to fail) and tests
also fail, won't this logic print the hint but skip the leak warning due to
the elif statement? This would effectively mask the leaked artifacts when
tools/objtool/tests/run-tests.sh is run with KEEP=3Dnone.

> +			echo "# keep=3Dnone: artifacts were removed" \
> +			     "(re-run with KEEP=3Dfailed or KEEP=3Dall)"
> +		elif [ -d "$rundir" ]; then
> +			echo "# $rundir was not empty; a test did not clean up after itself"
> +		fi
> +	fi
> +	;;
> +esac

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D10
