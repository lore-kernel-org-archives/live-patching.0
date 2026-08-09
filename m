Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE11A6838
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267909; cv=none; b=BHHESvRhkrMZtbVHylAsdzhT2I7+uj42yV+coURpk0CDvVlX13W74ygxq2ZY7WcmMyFBbIyGcxPeceBt6NhsLKFYPI4XSQfWZydYBk/7vBz9Q6Bbc/o+Su5PXnrgnOXmFTiw8eSYfzoLT8ekPqU1r8mYQLVqOW0plMqELWeiWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267909; c=relaxed/simple;
	bh=41XFBGmOqhZYNd2NhWLfJK/hLDiPV13hZ8V+NCV2YsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqP9ofRYTLkz7PzhZKFkZjCefVoutq7h3casIkK33kGqYBhD0ad1XNKsyetlwX/JFEeRJ07JUxm18m6mJ/A/AmKWoz6VdHnDv0qPt/kLeGq80ITwmVRHDoXZ2qXBWiAykVgwDSXMbqZHjKwKENH3XncmFtfIGL9ajfJR66Zz1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa4iPITP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa4iPITP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9081F000E9;
	Sun,  9 Aug 2026 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786267908;
	bh=JgCCjsDiDbFkmuq4WVjGkHe5HSub7r0Ty7KKuwZtrUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fa4iPITPYF1Znnr+U9ShjZ1t7IzxY1NHUOaHnWfLQ0ofqYBV3ixMQtLboV2BJ40tt
	 ifQegACNPWNRbWHi2yfYt9AGA+YyTvoH0iin5AKXwN8MWD6ukiBw+WoclzwiKGr09n
	 VL4aG6ZQW3v85/t6LfcSQLA0//ANjeW+FgpLQV+9kqt2R2HSd1WXwKLqdLhv5eZhCP
	 05ia6Ui2rp54DXLFVNEk0UoPZ5jKGbVuVKI0bttBw8+DIEMUev2OgK/L30wCT3tJEB
	 zO061Vi2zDjhm6mc5RYmgSg3tzNzr+FhmbLKh1/B7ADTxSE6J3WeaFAOPnOLLUTvAX
	 8YZBT9zxLfQlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] selftests: livepatch: Add provides/obsoletes
 test scenarios
Reply-To: sashiko-reviews@lists.linux.dev
To: mbenes@suse.cz, joe.lawrence@redhat.com, jpoimboe@kernel.org, pmladek@suse.com, song@kernel.org, jikos@kernel.org
Cc: "Yafang Shao" <laoar.shao@gmail.com>, live-patching@vger.kernel.org
In-Reply-To: <20260809091954.22930-8-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
 <20260809091954.22930-8-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:31:47 +0000
Message-Id: <20260809093147.9D9081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition in test-provides-obsoletes.sh leading to flaky te=
st failures.
--

--- Patch [7]: [PATCH v5 7/9] selftests: livepatch: Add provides/obsoletes =
test scenarios ---
commit b45263c641deb4b2b48bbe22a1f0bf862b20a22f
Author: Yafang Shao <laoar.shao@gmail.com>

selftests: livepatch: Add provides/obsoletes test scenarios

This commit adds test scenarios for the new provides/obsoletes mechanism in
livepatching. It introduces test-provides-obsoletes.sh to verify replacemen=
t,
coexistence, and obsolete features.

> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh=
 b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> new file mode 100755
> index 0000000000000..c740d463f556d
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
[ ... ]
> +start_test "provides 0 replaces provides 0"
> +
> +load_lp $MOD_LIVEPATCH provides=3D0
> +load_lp $MOD_ATOMIC provides=3D0
> +
> +mods=3D($SYSFS_KLP_DIR/*)
> +nmods=3D${#mods[@]}
> +if [[ "$nmods" -ne 1 ]]; then
> +	die "Expecting one module listed, found $nmods"
> +fi

[Severity: Medium]
Could this directory check race with the asynchronous sysfs cleanup of the
replaced patch?

When load_lp returns, it polls until the new patch's sysfs transition file
reads '0'. However, in the kernel, klp_try_complete_transition() clears
klp_transition_patch before scheduling the asynchronous work to free replac=
ed
patches (klp_free_replaced_patches_async).

If the test checks the directory count immediately, couldn't it sporadically
see the old patch before the async cleanup completes, causing the test to
flake with "Expecting one module listed, found 2"?

This same pattern appears in the "same provides replaces" and "obsoletes
replaces" test cases later in this script.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809091954.2293=
0-1-laoar.shao@gmail.com?part=3D7
