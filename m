Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B974AD4A1
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154740; cv=none; b=jp6NAaqd8mDKAh4RYUdxABWPWnpaH6QzAsem7yyIRU+4AruFRq3bgPR7YWbkb4X5pjD+K/Z+ymJxcOerivpbXOAMqCiTuGzc8rgPTKBBshi8+mHesRibk0y7KIfLtiHgiZDPXPUPlieBzd8MPBZOZS/D6JlmvRV1ooHnlFifkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154740; c=relaxed/simple;
	bh=vcg/I59KyzvJZK8JLDesMoaPu43coQs3mYAxB4LBuFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNUwJYQLQdO07FNTZtCXtDMXRIaYRVQEg8Q4jS+CGZ74gIHfLnZocpsLTF9CfXgd/zA7d/fzeDEnygOQJs7TTcRUw6MuEpUCnj5of3kFEzRyq32nppc9hjxDE4LzbYiUuT8mrNqhR1N5XaUvLnYIYOBde7nVGDjwMFZyTW9Zm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgrU8EZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgrU8EZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98DC1F000FF;
	Fri, 11 Sep 2026 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154734;
	bh=vcg/I59KyzvJZK8JLDesMoaPu43coQs3mYAxB4LBuFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GgrU8EZjOWWAynXCjmlDb6Kzn2gxo0LEUS70Qy+IL2zkQGIQqdsF0KMe+HafOrLtX
	 U3cp/LI/rA2XGR9jOeKCVPUNd1qoDDtZEjA7DOW/hMXyBd7KpOKWopLqQuhEovO0yE
	 SqvDM4FUQ+qd4IxQ+ElAa0/Xs7EDuuQcuO4cNlv8UzwtacnHxwrjB7d/hNaYgM++RC
	 GCLX4+1N7jhg+JpJcaZqwExO5VgCK6xrr+hJeJgU+5qid5lqA9EFUddHLXX2QmSbq7
	 HMCSHB6JvGjtuEcqwkzjrhpgQNHxg1Y3KooeRt4Nw5J5gFxlNl18/tBkO9ARc3uSi7
	 pxEl7wSyPwzLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 50/58] objtool/klp: Add test for a static call
 introduced by the patch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, jpoimboe@kernel.org, mbenes@suse.cz, kernel-team@meta.com, pmladek@suse.com, jikos@kernel.org, peterz@infradead.org, puranjay@kernel.org
In-Reply-To: <20260911185031.1534046-25-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-25-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:25:33 +0000
Message-Id: <20260911192533.A98DC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message inaccurately describes the patch by claiming =
it modifies `test-jump-label-new-key` and drops a vmlinux export, which doe=
s not match the actual patch content.
--

commit b26ef30fbd576efdbe08e0ea26b0bf01b92ab1b4
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for a static call introduced by the patch

This commit adds a new test script to cover a case where a patch introduces
a static call to a function which previously had none. It verifies that a n=
ew
vmlinux key is accepted while a new module-owned key is rejected.

> Extend test-jump-label-new-key with the module half of the same question.
> That needed the vmlinux export dropped first -- while the key is exported
> it is reachable and being new changes nothing, so the first version of th=
at
> addition passed for the wrong reason. klp-build unit test corpus.

[Severity: Medium]
Does this paragraph belong in the commit message for this patch?

The text describes modifications to test-jump-label-new-key and dropping a
vmlinux export, but the actual patch consists entirely of adding the new fi=
le
tools/objtool/tests/generic/test-static-call-new.sh.=20

The description also ends abruptly with "klp-build unit test corpus."

Could the commit message be updated to match the contents of the patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D50
