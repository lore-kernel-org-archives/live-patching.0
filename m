Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211220D4E9;
	Mon,  3 Aug 2026 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737536; cv=none; b=fbsje81W/AGTHSybdvRlm33WGR1iXFCawgqW3/dOOkaBESMdtdOTmiQ8LsT/IgVMmQSeUj7INLpvlP1ldo9ug4qKtlZ+2D9756I0hrY9da73WSdhIVi5eASVYaEuj2C22fxfcEOShhoDEjoKVsNcw7zsoCUgRPrzgnv9zA18AGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737536; c=relaxed/simple;
	bh=gCMlGDaM9vfs6uE3jvclbyogGXBIGhgOUok/wY4ejTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nTpTIH9Qr6hgBpWAjQzHtwW1g6C8SN0FdnOkojYIGY3TzRy4d88eMfRsjy44yN/2IsSxJ1i5IsiwljjcGFKFb5pLJAIBj90NSK7p6FvPEcFcxkP7CrORGbSx40JE38DzlmXRQtlHABgD6jLOJ4hIXfm7mFSzKX0JHZGgIC+7V4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA91U3k3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA91U3k3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C206D1F000E9;
	Mon,  3 Aug 2026 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785737535;
	bh=krOdy05UyoHdCNYWNW0BgzTSpaA9o55a/ECp5bmP1X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CA91U3k3MR7T35ckeL3cuUXZWRq3R+T+Yctlht8/n8JOXcBXHndw6pOkMGKo1AyBo
	 nbSOXz9ZeUltDjYo6p/j4tPZDk/w3YAmrdhVb5Qn6u/DYZzemXONNW452x/HCUdUih
	 3l5gEsTmuHKyDSYD5VPRI1FULy5w06ojkwwBWiCyI+nweFnpLBqOKrOCU+rBlyKQtd
	 NEVvpwits7m6e3sFLAyxgQZH9SaQknFspnAW2anM7t4vH00FgC6HWWdXCRVxrIf7w8
	 T1w5illbNQhg6Ufo8zYTVoDxqjOSa3sNNEgrDUTzXrUTtkfv62kwdEyxG/TkqWJF44
	 afqsH/oOJe80w==
From: sashiko-bot@kernel.org
Subject: Re: [tip: objtool/core] objtool/klp: Add .klp.symid for sympos
 disambiguation
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-tip-commits@vger.kernel.org
Cc: "Ingo Molnar" <mingo@kernel.org>, x86@kernel.org, live-patching@vger.kernel.org, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <178573617913.1210945.4137827646322421739.tip-bot2@tip-bot2>
References: <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
 <178573617913.1210945.4137827646322421739.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 06:12:14 +0000
Message-Id: <20260803061214.C206D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `.exitcall.exit` section is discarded during the final vmlinux =
link, but `klp_create_symid_sections` incorrectly generates `.klp.symid` re=
locations to duplicate static symbols within it.
--

--- Patch [1]: [tip: objtool/core] objtool/klp: Add .klp.symid for sympos d=
isambiguation ---
commit 95a71e72a77916e00e9b21eb4e2fc9a9e4c3258d
Author: Josh Poimboeuf <jpoimboe@kernel.org>
Date:   Mon Aug 3 05:49:39 2026 +0000

objtool/klp: Add .klp.symid for sympos disambiguation

Livepatch identifies a duplicate-named symbol by its position (sympos)
among same-named kallsyms entries, which for vmlinux are counted in
ascending address order in the final linked kernel. This commit adds a
new .klp.symid section to bridge the gap and correlate symbols between
vmlinux.o and vmlinux.

Link: https://patch.msgid.link/64d50f077b569f47883c015cdb7079edb068efe8.178=
5727106.git.jpoimboe@kernel.org

> diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
> new file mode 100644
> index 0000000000000..cf188cdfa6079
> --- /dev/null
> +++ b/tools/objtool/klp-symid.c
[ ... ]
> +static const char * const discarded_secs[] =3D {
> +	".discard",
> +	".modinfo",
> +	"__tracepoint_check",
> +};

[Severity: Low]
Does this list need to include ".exitcall.exit"?

When built-in components use module_exit() with identical function
names (like sm4_exit in multiple x86 crypto modules), duplicate static
variables are created in the .exitcall.exit section.

Because this section is missing from discarded_secs[], symid_needed()
generates R_ABS64 relocations in .klp.symid to these symbols.

Since .exitcall.exit is unconditionally discarded by the linker during the
final vmlinux link, this can cause a fatal linker error: ".klp.symid refers
to discarded section .exitcall.exit".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178573617913.121094=
5.4137827646322421739.tip-bot2@tip-bot2?part=3D1
