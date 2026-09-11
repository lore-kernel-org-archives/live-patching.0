Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FD3F86EE
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153639; cv=none; b=gsV+ujfpl9fEacbG168nXmfez3rPdFlYyqJf0zK5m+nUHKuc5svRhvx7lkMvjEGfLApvDRly1MtB4ZYK5ALZv6vmOFhH7nbu0R+5UABN8oe5sY0qE7sTlzXs31jypa0mHMFIgqWXzfewGKnej/6dsSQbxDilNV4gfMEa61ZKqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153639; c=relaxed/simple;
	bh=u0CyDhDHnOlh7xRbg4xHj2qN16CPslq23B1rqD8c0YI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hmQMRFH4R9H2yyBFEUyPlWVQkZb7UldK7lG+qkM8SnRQzXV5pzWYSxc4VLjJJovB9BLIILFJFHkYopwRWFJjcZGDnSOoKvOTn/42wWmOyQJ+buxNSQKncZV926OvyZfO3q8/CkJtJQ8Vnh0wZvdEoLDf1NMk9xDRteHHx9dOpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R02kFer5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R02kFer5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248B91F00893;
	Fri, 11 Sep 2026 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153625;
	bh=n1psJ6VwQBx2FaHKh5i2fRi7QJvJxjiO75GW1tpqptw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R02kFer5wPEz0O1uzBzfK9Qo1BLrzU5EK1jtqtQ9XL2WCNtqTAXWwFrHKcruBTMw+
	 +YSgzL2OiKWKCW9TGpWD3gDCxsddWsrZ2sZhtbcZN7rWGOt9WpoxIDD6RHNtNQRX4u
	 Nhesogk/OCYJPYMbxhO0ITTVrJRE5S+tFzhBJlNkCTCB3zrmIdL2Hi58eXdyL4LTGT
	 zKTvTcEfqOY34eKZgNVSu0y9TlSmGUDnQ1jzNWtBNmMsxN+8Sj7SmiNtuFd1rwuk8S
	 P7H0cIjVSvtXjl4NupO5rfPdmzRl8CiyrRy96bWyAjhPnv4PQhcmDeqXTyD5lKS0zk
	 E3cfgHalcGVpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/58] objtool: Keep failing test workdirs by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: peterz@infradead.org, jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, puranjay@kernel.org, mbenes@suse.cz, jpoimboe@kernel.org, kernel-team@meta.com
In-Reply-To: <20260911184305.1457308-11-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911184305.1457308-11-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:07:04 +0000
Message-Id: <20260911190705.248B91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Tests that fail due to unexpected termination (e.g., shell error=
s, signals) or undeclared skips have their working directories incorrectly =
deleted despite KEEP=3Dfailed, while the runner falsely claims they were ke=
pt.
- [Medium] When a test is executed standalone (not via run-tests.sh) and fa=
ils, KEEP=3Dfailed silently leaks the temporary directory without printing =
its path.
--

commit 14c7ac654e8638035a6ea9f8c26ee25df0293be4
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool: Keep failing test workdirs by default

Change the default behavior of the klp test runner to save failing test
working directories instead of deleting them on failure. Provide a KEEP
Makefile variable that can optionally retain 'all' or 'none' of those
directories.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 4d8401ee8b412..6c607a0435023 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> @@ -186,12 +187,14 @@ cleanup()
>  {
>  	[ -n "$workdir" ] || return 0
> =20
> -	if [ -n "${KLP_TEST_KEEP:-}" ]; then
> -		[ -n "${KLP_TEST_WORKDIR:-}" ] || echo "# kept $workdir"
> -		return 0
> -	fi
> -
> -	rm -rf "$workdir"

[Severity: Medium]
When a test is executed standalone (not via run-tests.sh) and fails, does t=
his
change silently leak the temporary directory without printing its path?=20

Before this patch, standalone test failures using KEEP=3Dfailed informed the
user of the generated /tmp directory path. Without the print statement,
developers might not be aware of the leaked directory location.

> +	case "${KLP_TEST_KEEP:-failed}" in
> +	all)	return 0 ;;
> +	none)	rm -rf "$workdir" ;;
> +	failed|*)
> +		[ -n "${KLP_TEST_FAILED:-}" ] && return 0
> +		rm -rf "$workdir"

[Severity: Medium]
If a test script exits unexpectedly without setting KLP_TEST_FAILED=3D1
(e.g., syntax error, shell error, or signal), will this incorrectly delete
the working directory despite KEEP=3Dfailed being set?

> +		;;
> +	esac
>  }
> =20
>  # setup [exported symbol...]
> diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-t=
ests.sh
> index e6f1ac1b5d0da..e7bd25097ea58 100755
> --- a/tools/objtool/tests/run-tests.sh
> +++ b/tools/objtool/tests/run-tests.sh
[ ... ]
> @@ -147,16 +162,16 @@ for t in "${tests[@]}"; do
>  		rest=3D"$rest${rest:+$'\n'}was: $result"
>  		result=3D"not ok - $(basename "$t" .sh): undeclared skip"
>  		result=3D"$result (use gcc_only/clang_only or require_input_*)"
> -		fail=3D$((fail + 1)) ;;
> +		fail=3D$((fail + 1)); failed_dirs+=3D( "$rundir/${t%.sh}" ) ;;
>  	"not ok"*"# TODO"*)	xfail=3D$((xfail + 1)) ;;
> -	"ok"*"# TODO"*)		xpass=3D$((xpass + 1)) ;;
> -	"not ok"*)		fail=3D$((fail + 1)) ;;
> +	"ok"*"# TODO"*)		xpass=3D$((xpass + 1)); failed_dirs+=3D( "$rundir/${t%=
.sh}" ) ;;
> +	"not ok"*)		fail=3D$((fail + 1)); failed_dirs+=3D( "$rundir/${t%.sh}" )=
 ;;
>  	"ok"*)			pass=3D$((pass + 1)) ;;
>  	*)
>  		# No result line at all: the test died before reporting.
>  		rest=3D"$rest${rest:+$'\n'}exited $rc without a result line"
>  		result=3D"not ok - $(basename "$t" .sh): no TAP result"
> -		fail=3D$((fail + 1)) ;;
> +		fail=3D$((fail + 1)); failed_dirs+=3D( "$rundir/${t%.sh}" ) ;;
>  	esac
> =20
>  	echo "$result"
[ ... ]
> @@ -167,15 +182,35 @@ done
>  echo "# pass:$pass fail:$fail static-skip:$static_skip" \
>       "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
[ ... ]
> +failed)
> +	if [ "${#failed_dirs[@]}" -gt 0 ]; then
> +		echo "# keep=3Dfailed: ${#failed_dirs[@]} failing test(s) kept under $=
rundir:"
> +		for d in "${failed_dirs[@]}"; do
> +			echo "#   ${d#"$rundir"/}/"
> +		done

[Severity: Medium]
Will this instruct the user to inspect directories that have already been
wiped?

When a test crashes or skips without setting KLP_TEST_FAILED, the main loop=
 in
run-tests.sh correctly detects this as a failure and adds it to failed_dirs.
However, cleanup() in lib.sh will have already deleted the directory because
KLP_TEST_FAILED is empty, leading to confusing instructions for the user.

> +		echo "# inspect: diff.log  readelf -S out.o"
> +		echo "# one test: $PWD/run-tests.sh <name>"
> +		echo "# cleanup: rm -rf $rundir"
> +	elif ! rmdir "$rundir" 2>/dev/null; then

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D10
