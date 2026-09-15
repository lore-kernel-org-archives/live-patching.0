Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10E4BEE3C
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432353; cv=none; b=D/5ZzZd0JhihZ9NGr6c40acSZZ9JnXGsD2dQQNwmDyu26TaGNp+OFZYjKZ1r5vykZFpEhOXP6V8alNvgvo3qFlOzFYUqmGb5Lew3FrUVZYPq6iUmB6zcKFd/T1RrGOLBUYHhV5SAZzdntnCSiU8h++8NNO4zncIQKyHBvmjznjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432353; c=relaxed/simple;
	bh=2XTQP5Y/PoUak3tWm4Y+DUdVmUmq0lTG5rAbrstfjKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=algoBm6HYhDwJ6Z/nu5K4qj9wU1qrjg5w+ULDog/TzK17k8eNK9jf0nwER6p9RARmdPrW5DlDswF811iD5GG0LOu177ykYA2k0z/oshmMWtp/J55u9Mvrj7jy+ZSZfdQ/kkHnlD2v2knrnFgN0toM0+4S8bOQEIDX1ClrLoC8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0cFIj3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0cFIj3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C7F1F000FF;
	Tue, 15 Sep 2026 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789432352;
	bh=p4F4aKsFXIvJzHxjn7xyBWEQCKDeAnzFnEFZt7wTcIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0cFIj3blKNhCM0eIee3NE4yh0wFyszyaSzW4ndVXYUSzi5D4kLkBCAPC05afUNjI
	 wPK8HqS0m10wtnVPoaF85fBcWSPRuMutkTbSp52eslQiu4OOnhfO9lU5MdA/5MYtKp
	 wk/YNUR3EMJloaTKcqu/QeS3ysxinDW381wqlvpaZDoeGlMgq/LguA0fvUhXt3dDMB
	 NqDf3FWWXStFWGAQjIDiyJ8rIGbdMAAN2WXXRjGrCQsqkR498XTUrXH5v92BRWpH2l
	 +elPcwNxPRIO9V7B3LFm5FGI+zroee6ItvCq2Vsft+iR9f7izKrDqbNDuLpgxaC4lu
	 CHnEt2FcYJBBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 49/58] objtool/klp: Add test for tracepoint and
 pr_debug static branch keys
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: pmladek@suse.com, joe.lawrence@redhat.com, puranjay@kernel.org, jpoimboe@kernel.org, mbenes@suse.cz, kernel-team@meta.com, jikos@kernel.org, peterz@infradead.org
In-Reply-To: <20260914230355.3422996-50-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-50-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 00:32:31 +0000
Message-Id: <20260915003231.95C7F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] commit-msg: invalid format for 'Assisted-by' tags
--

commit 641f3be7c093928796cb03fcb5282e5083806dcf
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for tracepoint and pr_debug static branch keys

This commit adds a test to verify that tracepoint and pr_debug static branch
keys are disabled with a warning rather than being rejected. This ensures
functions containing them remain patchable while avoiding unresolved entries
during late module patching.

>     Assisted-by: Claude:claude-opus-4
>     Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
>     Assisted-by: Claude:claude-opus-5

[Severity: Low]
Are these Assisted-by tags formatted correctly? They appear to lack an email
address in angle brackets.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D49
