Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEE44C64D
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585278; cv=none; b=hPUEewaG8D6rpHqcMDRm/nEs6B+hD6QRFhIdf8P4jxkW+vPSYf57fZEf/zjBxBMEwmsleoVk6OVWYsy7A8r5asSHthYohw4CDWGdQQkSQ4EsIiK64AQswJjuzvzoAjI+3bkMR9Dqg2PQYjrcnzQwZ9dC2ExyPAgNAi8EZeope2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585278; c=relaxed/simple;
	bh=cD6OfgE4VqNhf61yXklKHKpp4xk2WmLvgPR0SjGzPJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lzeL1Ch1AOr1UvWJeTjkw2ZmUfccK1qPkioxCOX7lkFPrR40+RUUGwZW75DxvWBbyg6vrol7UDHtbiqZgcBLn9+rnNmDXwZlfHPLhVs244+z4bLYDgEi3e3OTB5MpD5c68wbRPJcPmpbTp1qGUNT/pjYaI8bPQFmEMQrmUeppLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPVFGjM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPVFGjM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41211F00893;
	Wed, 16 Sep 2026 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585240;
	bh=cD6OfgE4VqNhf61yXklKHKpp4xk2WmLvgPR0SjGzPJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VPVFGjM8y1XJznVGNuqKOHwjR7cy587uHtwA+d5SNP7R4BWMemvEUEpQ+mCOg5AnP
	 bOu7i5GHmA4oCGB26bI1pTncvGdr6kBzbWyt+MeYDAGxE4eybzuFP56l2dzsrIuCWb
	 n7X/83pj87Zi2qYpgseJjUitZwqlrotWLa+Pfq+PKw45OpafvJOsq8bveDkp/aP75O
	 HStcXqlLXvIKjvmqlrEFBDPqd7OGAeTsK/MEdjb+DQotyRVSOL6GkatFQRZVpXnVuK
	 can+TPZx+iG9ZU9FJ8TAW9wCCLlADiHACg97/ji9QVY3AuBjitZvXIHxXx64Ac37Pg
	 yieWh3gwGR7KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 43/58] objtool/klp: Test rejection of a file-local
 static branch key
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, kernel-team@meta.com, puranjay@kernel.org, peterz@infradead.org, mbenes@suse.cz, jikos@kernel.org
In-Reply-To: <20260916184351.2720310-44-song@kernel.org>
References: <20260916184351.2720310-1-song@kernel.org>
 <20260916184351.2720310-44-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 19:00:39 +0000
Message-Id: <20260916190039.E41211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] invalid AI attribution tags in commit message
--

commit 31c30fc01ab7bac006cdecfa960b5321f80c4604
Author: Song Liu <song@kernel.org>

objtool/klp: Test rejection of a file-local static branch key

This commit adds a test to ensure that a static branch key owned by a
module is properly rejected when accessed via a livepatch relocation. It
adds a knob to cover file-local keys and verifies that the input references
the key through its section symbol.

> Assisted-by: Claude:claude-opus-4
> Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
> Assisted-by: Claude:claude-opus-5

[Severity: Low]
This isn't a bug, but the commit message uses non-standard Assisted-by
tags with pseudonyms and no valid email addresses. Should these attribution
tags be removed or replaced with standard trailer formats before submission?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916184351.2720=
310-1-song@kernel.org?part=3D43
