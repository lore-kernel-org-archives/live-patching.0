Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9123ACF0E
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428535; cv=none; b=qCBQBjA0KVuIbs/7Nv/3oWHOIsfW6a0nsbjoa8olO8UFGwV9ZVFylXAV75LuC8SAMnUOgJo8BznGiskn7dmhAnnCjw59UKkqECUI/v7zj4jPKU9PJa+Cwc6Xi7h+OFWzHbmR9lrpz/q2Rom18nxzeKrv7m1LDGrSFS7qM5pR21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428535; c=relaxed/simple;
	bh=tiJ2DBGZlVnEtGnnnmxHwVNwDGFnRzU5GecMvJvXBMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZEjKjNHVCH1jXKq4iOBD3DjIBVfqL3HTudmLoUHVAdYqNPkvmRT0nmOP8JKPEdZfU9i5LlES66O+CML4Ixgb4b5gB1mokJHr9+JxXExOjPk1m5UWQ6PXux6INNwKptInFDAW6s85HLCmapMu3pUbg4Bz9idQHtPE7X7toT1CIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=movitolD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="movitolD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9DC1F00898;
	Mon, 14 Sep 2026 23:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428533;
	bh=FXQ5gG1yAJa9G/g0emzWDHpFgPz73SOHzs/SMHeb1Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=movitolDLGJudEzoZ8grXAno+a3xsDJWHJ+oH6lV7UWGWhxuDzSzxR2+XnHbWLWo8
	 wpbWPzN5prOuT41UrLgVaKVx2ADy1t7Lgrthc6yWSHBcNWtEc/EA2naoBu+EIx2qy9
	 GM/BI4tPcIJbaAc3Gx99vqnyxc0yuqhrEZ8BhlgnzmXzos/trQEyYY6E/MTa6k2zc4
	 PCURqQmVN+5F1QOlRnW8QWjz+I7lAwvjrdiE6pLknM/K+G+DHviAR0QUcleldd/p3u
	 a+QOeGgLvG3xEKXy8Gt/EZBi9NttAxd5O4oj8pQEVkW19AF0ycNKIp8EE136PI14LV
	 vLoBQCqF26Mbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/58] objtool: Add test harness for the klp
 subcommands
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: joe.lawrence@redhat.com, puranjay@kernel.org, jpoimboe@kernel.org, kernel-team@meta.com, peterz@infradead.org, jikos@kernel.org, pmladek@suse.com, mbenes@suse.cz
In-Reply-To: <20260914230355.3422996-2-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-2-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:28:52 +0000
Message-Id: <20260914232853.6A9DC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] objtool: test harness fails if OBJTOOL is a relative path
--

commit a0117b0a0e9e827479f6a5d87a6aea205470f1e3
Author: Puranjay Mohan <puranjay@kernel.org>
objtool: Add test harness for the klp subcommands

This commit introduces a test harness for the "objtool klp checksum"
and "objtool klp diff" subcommands. The tests compile fixtures into
objects and assert on the properties of the objtool output.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> new file mode 100644
> --- /dev/null
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> +run_diff()
> +{
> +	local expect=3D"${1:-0}" rc=3D0
[ ... ]
> +	# klp diff looks for Module.symvers relative to the working directory.
> +	( cd "$workdir" && "$OBJTOOL" klp diff orig.o patched.o out.o ) \
> +		> "$workdir/diff.log" 2>&1 || rc=3D$?

[Severity: Low]
If a relative path is provided for OBJTOOL (such as OBJTOOL=3D./objtool),
the check in setup() allows it to remain a relative path:

    [ -x "$OBJTOOL" ] || [ ! -x "$TESTS_DIR/../$OBJTOOL" ] ||
        OBJTOOL=3D"$TESTS_DIR/../$OBJTOOL"

When run_diff() subsequently changes the directory to the temporary
$workdir, will the relative "$OBJTOOL" path fail to resolve and break
the test execution with a "No such file or directory" error?

Would it be safer to convert OBJTOOL to an absolute path (perhaps using
realpath or readlink -f) during setup() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D1
