Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C8171BB
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432020; cv=none; b=M77N+1jyaOfGEASOwZzYhNPAEkSyTXIJWJZebx7Dxmn0ETa6O+4zdepdDV+s3gl+PDmAtWE0BUQnujPXWCCBGyfuODZ13gy3SGZSXGYfrWIZVGtrK/N7GyJ3c6ZdPrxxhhhLKNSgdZrflOQf2/AdsI0dNypWiVlgjX2sYNhA2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432020; c=relaxed/simple;
	bh=kbzlSb7TjFLaxeNCsSJTKc9TmHTX8aI/h0U+OLF0/U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uV3Q007BI021BqC138+yVkYPS0rqSeqwvxN0dOWOQxMaOvc8AGADb03HICniOVKrlTulcwLjrjtFpHgBUmh//+tUeu5nDOBUkP+cOJWArLarIxe52Nqyp9XHtHjqXCeeRb9iglSok1z3B3XzMG6eQxgJml9WnO1aJUJyizArX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7QMmsLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7QMmsLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B5C1F000FF;
	Tue, 15 Sep 2026 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789432018;
	bh=WJUcWRblw+SDBJwUQk00hWuH7rlhAoyXnHHEatvNt3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H7QMmsLqGZqH9/zu/EptfRkNNfj4vJLDDHQyYdmwr/Wx9BiEkcs2Xsqz9FTLtd7hJ
	 u3+b7rc1veS5b65Z3b5Otf6p3yNEwABSyPX1uKEYioxb/xYCs2MO1vBgJL0bvBTzrs
	 Eht6OtXoSecp/9KogpeYFKLderK87qmAU1zsrShPbvfZTv7Mb/Zk3vyJYG+6P8rhLx
	 ahHQGrQM4kgBhE11PQc/gN+d4StHkb3A0MoMo2FDY4chf0H341oP1lUTOPAGMCv7ak
	 3ZBMqiXIAbZM0mVOtip8aSeJfejIgqtMcke6mpYGr9ViPQL8A5kVbXbEpz8Nvuw2wZ
	 Sb5iw4sWBiDrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 40/58] objtool/klp: Add test for __bug_table,
 __ex_table and __mcount_loc extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: puranjay@kernel.org, jikos@kernel.org, kernel-team@meta.com, peterz@infradead.org, jpoimboe@kernel.org, joe.lawrence@redhat.com, mbenes@suse.cz, pmladek@suse.com
In-Reply-To: <20260914230355.3422996-41-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-41-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 00:26:57 +0000
Message-Id: <20260915002658.69B5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool/klp: temp directory leak in test script loop
--

commit 9f7016f6d159ad52d6af43f36ec58a96806eaf3b
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for __bug_table, __ex_table and __mcount_loc extracti=
on

This commit adds a test to verify the extraction of __bug_table, __ex_table,
and __mcount_loc sections by klp diff. The test uses a hand-crafted special
sections fixture. The test script repeatedly uses setup and cleanup to run =
diff
checks for each section.

> diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/obj=
tool/tests/x86/test-special-sections.sh
> new file mode 100755
> index 0000000000000..8dfaa4fc9a360
> --- /dev/null
> +++ b/tools/objtool/tests/x86/test-special-sections.sh
> @@ -0,0 +1,42 @@

[ ... ]

> +# section, entry size, relocations per entry
> +for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; do
> +	set -- $spec
> +	sec=3D$1
> +
> +	# A fresh workdir per section: run_diff caches its checksums.
> +	setup

[Severity: Medium]
Will calling setup() inside this loop overwrite the $workdir variable with a
new temporary directory without removing the old one?

> +	build_pair special_sections.c \
> +		-DSPECIAL_SEC=3D"\"$1\"" -DSPECIAL_ENTSIZE=3D"$2" -DSPECIAL_RELOCS=3D"=
$3"
> +
> +	assert_input_section "$sec"
> +	run_diff

[ ... ]

> +	assert_not_patched other
> +	assert_no_reloc_sym "$sec" other
> +
> +	cleanup

[Severity: Medium]
Does calling cleanup() here fail to remove the directory because it
intentionally skips deletion until pass() or fail() sets KLP_TEST_REPORTED?

This appears to leave temporary directories in /tmp/ during successful runs
and clutter stdout with spurious '# kept' messages.

> +done
> +
> +pass "__bug_table, __ex_table and __mcount_loc entries extracted"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D40
