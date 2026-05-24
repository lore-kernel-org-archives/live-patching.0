Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E43B8409;
	Sun, 24 May 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667148; cv=none; b=SdT0ktYQfJ5FA3Z5weBSX2iy2RiEubMxJul8VQGlEMoYyXUX9eP43/jxSnVRVzoDgF37NgsDYUYS78e5V4lWt0Lf7V9Qhbgd/lfDclrRYv51RuSbFU8RKoaeM9HP+SQD5CTAylM04+xY56wvRGmfMNSKb/irEGXxBBxwbXwZpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667148; c=relaxed/simple;
	bh=6UXC54hRmDwkmXOwnTVNeMmfz3TdEeC5oeTi81zYzxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Il/5ccFwOH+IdaXiDu4n2s0BzOKEWDut1QmDzVpJmDjWUYSI7sXpAyhfCWiwDR6vk++ZYE0fG69V1t1pkST7O32pDUBbpIOecvbmqK4RYPDyd3RpxRgK0S2HvARpPOmUU0D72cM1jTwJHiyvaL+JyKaeUtpY5KT2L9Mco2peWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDpvULPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDpvULPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267EF1F000E9;
	Sun, 24 May 2026 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667146;
	bh=1psQOCO3F0yNdG7quk+/rwu4kIJo/yT0WHmCnwuF1gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fDpvULPyAut1QhJeXBA/HRiI5mmODh/YmrSFp47SnP0Yyu8zUoc/fHe5hoJFRjcQ7
	 5ha3mLxmvqp4S/zp58GBxSPeAA1P6rmS/I5l2vBLtl/qwVIPuLTj/WFFgYiXxh6pou
	 BH6jK/kD50UAODtRvjGQ/8o2Ti3CRR/iAql0rHON3LiC9SaVUbMn5bb5djryIWEvLJ
	 EABb3x1EZ+wvaVDhrzfWfxtZPOcUuFpmIY+SBAVuUxiAC4lHHvwcM4ej6CP50j7+MB
	 +zrTnMBO8YqQEHRpQZQwXZV9RxMNOIkZV54JseidOXnpvr27yJsF7TIVDwSPhuFxA3
	 4KP/QWSW60CpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] selftests: livepatch: Introduce _remove_mod
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Kosina" <jikos@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Joe
 Lawrence" <joe.lawrence@redhat.com>, "Shuah Khan" <shuah@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, marcos@mpdesouza.com, live-patching@vger.kernel.org, "Marcos
 Paulo de Souza" <mpdesouza@suse.com>
In-Reply-To: <20260524-livepatch-unload-on-fail-v1-1-7465de7f741d@suse.com>
References: <20260524-livepatch-unload-on-fail-v1-1-7465de7f741d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 23:59:05 +0000
Message-Id: <20260524235906.267EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `_remove_mod` uses `die()` which will terminate the script durin=
g cleanup operations.
--

commit 7b1591f4e5c3b351136e7fe2821eb2e15ae59ad0
Author: Marcos Paulo de Souza <mpdesouza@suse.com>

selftests: livepatch: Introduce _remove_mod function

This commit introduces the _remove_mod internal function to remove a loaded
module, intended to be used during cleanup when a testcase fails. It also
refactors unload_mod to use this new helper function.

> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testi=
ng/selftests/livepatch/functions.sh
> index 2bc50271729c6..3ec0b7962fc5c 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh

[ ... ]

> @@ -241,9 +241,10 @@ function load_failing_mod() {
>  	log "$ret"
>  }
> =20
> -# unload_mod(modname) - unload a kernel module
> +# _remove_mod(modname) - Internal function to remove a loaded module.
> +#                        Use unload_mod() instead, which also updates TE=
ST_MODS tracking.
>  #	modname - module name to unload
> -function unload_mod() {
> +function _remove_mod() {
>  	local mod=3D"$1"
> =20
>  	# Wait for module reference count to clear ...
> @@ -261,6 +262,14 @@ function unload_mod() {
>  		die "failed to unload module $mod (/sys/module)"

[Severity: Medium]
The commit message notes this function will be used to remove loaded modules
when a testcase fails. If used in a cleanup path (such as a bash EXIT trap),
will calling die() here terminate the script prematurely?

If a module fails to unload (for example, if its refcount doesn't drop),
die() executes exit 1. Inside a trap, this aborts the rest of the
cleanup process. This could skip unloading any remaining modules and
prevent final cleanup operations like pop_config() from running, potentially
leaving kernel tracing persistently enabled and polluting the system state
for subsequent tests.

>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524-livepatch-=
unload-on-fail-v1-0-7465de7f741d@suse.com?part=3D1
