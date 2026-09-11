Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1944BCA1
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154847; cv=none; b=c65wzAoORM8QzEVCW6N6K7ziGhRDaEGNShppM1Cu7geY35nAYBzskmqHjIiqm7oBXq5NUTy4LitEv0O1hGB/ANI54jAI0h2nAdn1cLxuXAlgdRZkD3/TA1uiNhyacRmxGex3yfJuHG3H3QJYvfMMdrdm2HNScXYJSagvSqk6Pj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154847; c=relaxed/simple;
	bh=kh84xA5nZMn0/CmqtkYvpMrMRUvWpnwM9HOiA2xgBUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMIw94IHNSlucYmQnJ2WiMf4gaWatGSjQVyQTee7odtgI9RZGHM1xC3EpUujtIBRkkG94pvzXPJQKSP95LhA5iAaYKxPFIlQxW/MpIxKDMUW69GcU66P3fdG7fMUBkihDHxCofjscryjayL4t+XblXB4Z/RI1BDjTasz4yAO8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFkMHkHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFkMHkHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461311F000FF;
	Fri, 11 Sep 2026 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154846;
	bh=kh84xA5nZMn0/CmqtkYvpMrMRUvWpnwM9HOiA2xgBUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFkMHkHXp1khErHxUWNLc6jyKyAnoBalN7aPcxSxdPpL2nDMby9pkgUeTx6/CsyZY
	 ko7pAdr5709mPKAd6ssPWZRMNuv6+AXtVGiaLT+S44fovzg2RoZ4/McPU7N1pKI4j9
	 ttzrGttpIhyzAok8oVHH57HjF0tSYK+wek2lDfKumJEK4dP5arU6jSOfeHAHTw9iuG
	 ZxTOmWMX4F3eJPV1RPguLypzNX45lvVclLK5FAb+MiYaH3/g3bQ5AbArPeCtIlSnFb
	 4XHz+ZFk9hlfZ2yR+u2+45Z5sCjN0SlJquVTMUVk7fUnws95LrXn9zS8944TpWGIw1
	 WlyBmrqHpnPjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 57/58] objtool/klp: Add test for Clang switch jump
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: peterz@infradead.org, pmladek@suse.com, puranjay@kernel.org, joe.lawrence@redhat.com, mbenes@suse.cz, jpoimboe@kernel.org, jikos@kernel.org, kernel-team@meta.com
In-Reply-To: <20260911185031.1534046-32-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-32-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:27:25 +0000
Message-Id: <20260911192726.461311F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to fix a leak detection bug in the tes=
t runner, but the patch completely omits the fix.
--

commit 5c4ab407591b68fa95b718465323f3522b8813cc
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for Clang switch jump tables

This commit adds a test to ensure objtool correctly handles Clang switch
jump tables in their own section. It asserts that klp diff associates
the patched function with its .rodata..Lswitch.table.<function> section.

> Also fix the runner's leak detection, which this test found: a run in whi=
ch
> every test skipped before creating a working directory left the
> "$rundir"/*/ glob unexpanded, so rmdir failed on a literal pattern and the
> run reported a leak that had not happened.

[Severity: Medium]
The commit message claims to fix a leak detection bug in the test runner
where the "$rundir"/*/ glob is left unexpanded when tests are skipped
before creating a working directory. However, the patch does not contain
any modifications to tools/objtool/tests/run-tests.sh to correct the
rmdir command. Was the fix for the runner script inadvertently omitted
from this commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D57
