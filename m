Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379340D576
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153642; cv=none; b=YbbwzM4sfS5hHfwFPSlD8G3TK7lb0Fnl/R2MzvqWEC95Ow9ZtIegSeUgNp8Fud+sjaT+G4C77pxRXtBAAqyaUIz6cIsBx+GnLFtijhYOdDVc6BPOmJ+qyOKK9jduXmn4jfP3EJ7w0KWnIwRwLmyYiaoi96T3OR8NtngMduL1TsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153642; c=relaxed/simple;
	bh=VzQml3guTlJhpzNV4qDvJwa3pwqLbjE8D7c+1y/5Z3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gWoK+2OB6B4y51gHCQzozvGX6X1G+zFPg2gbVV4HscFwm3FClJmFRsRUe+mno0awrg8Az2kc8xmvEYLuUsuADTZP5+jTQ2tkJMaP6DwIhPQgFZNU2MzZ9zCyxkbARkWkKQm3m5bET84FRLcg8kUkfwmsZ6kGSsfj3acKZJM1JjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuDJYLUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuDJYLUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2651F000FF;
	Fri, 11 Sep 2026 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153636;
	bh=JzOnMh36gt+PELftDEDIKkqtNvrDDUYEiFT6Q/B60wY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DuDJYLUXws/T7C8HAFDZV6lcZ8915sOIUI2X/EmMfRow2Y+0JQ3JoKpPVdvnTUi9I
	 ktH3C1BUxqlJhsb3w7JFcMSFl+LzEktAveAn3+lVdOejCADaj/5WI7gDViR6Zze13G
	 4Ka1//rIaoklPOweVw0FyQooTtX8KFAW8wQC+95+tjbQSsliJcHe20dupGV+uunGoq
	 OB/iWWt9RPCLal6ngscjvtBh21jvb42BJxepZNcKO2MBhyrMCR21mBm9k8xa44ilDn
	 72+u9aP4K4EbGgyUJ85OAum3HMCwYyL8vL2KFoIpPga8L5YEk66zU2G1wzNmbuLz5h
	 KxsrKzRYmppmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/58] objtool/klp: Add test for cold function halves
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: peterz@infradead.org, kernel-team@meta.com, pmladek@suse.com, jikos@kernel.org, jpoimboe@kernel.org, mbenes@suse.cz, puranjay@kernel.org, joe.lawrence@redhat.com
In-Reply-To: <20260911184305.1457308-17-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911184305.1457308-17-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:07:15 +0000
Message-Id: <20260911190716.2F2651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script uses an unanchored regex that will spuriously pa=
ss if the tool fails to carry the cold half into the patch, masking the exa=
ct regression it intends to prevent.
--

commit d68806991ec6b4cf8d30b1b6025cc1b8ab0a7deb
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for cold function halves

The compiler splits unlikely code into a separate foo.cold symbol. GCC needs
-freorder-blocks-and-partition to split reliably, which is probed rather th=
an
assumed. This test verifies that both halves of the split function are carr=
ied
into the livepatch.

> diff --git a/tools/objtool/tests/generic/test-cold-function.sh b/tools/ob=
jtool/tests/generic/test-cold-function.sh
> new file mode 100755
> index 0000000000000..315f407d9ad70
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-cold-function.sh
> @@ -0,0 +1,30 @@

[ ... ]

> +run_diff
> +
> +assert_patched target
> +out_symbols | grep -qE 'target\.cold' ||
> +	fail "cold half was not carried into the patch"

[Severity: Medium]
Does this unanchored regex risk masking the very regression this test is
designed to prevent?

If the tool regresses and erroneously fails to copy the cold half into the
patched object, the hot half (target) will contain an unresolved branch to =
it.
The tool might resolve this branch by generating an undefined livepatch sym=
bol
(e.g., .klp.sym.vmlinux.target.cold,0) or a standard undefined reference.

Because the regex target\.cold is unanchored and does not check the symbol's
type, binding, or section, the grep will match this unresolved symbol name,
causing the test to incorrectly report success.

> +
> +pass "cold half carried into the patch with its parent"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D16
