Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794357781;
	b=eyHQoZcuFVb7CLMf5ekfkwLyx0KiFKrqm03jOfFEW18HjaGDMOG0b/GTmZEL48AFsrB7
	 5tMzdsATd+xS1IHClN0EgYn1tlEjOqXLaFGD/VA5Np1KC62KFi8zSfBWfHOPG7Mqf8JOP
	 q9VppLM5hgBVrEpRZY4/RA3nfgtJIR6BGf8Pvw0xvREIK6vGaUserOIq6eh4o8/6QLqYr
	 r5VPG3IuhEUUrinHqhYMjJDO46l6RTDrbzx2JMjz6mfX3yIhRdBw2f956/OOj7G73xAxw
	 FqOhvqiGRB/KcHbikx+ooksX6EgvZv9mfT4SiM5k+4g5+bcFzKf5OB3K53K0GFK80Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=c3NqXZkZbKGw3JC6mkweYll+c++WAqjqo3wZC+1QKlo=;
	b=OkBLUYnYS+wFKebneGA6jeqORRT6i/8XEjHIsU0zKl2bVP/YUToRr6LsRYIXCK1DQOAa
	 1J1ijmyRQyxzWb7WJ4xNmjat0AFpvkfbXSt4a0pBecfvOy+VvHCc10nXL8wKazGkcYiKb
	 434Y0q8DCfpAfhO+y1UBIc/+FnkKZR6p+v/XjY2qX2Iby0h99riy8Lhu9eS/aa+ChLLY/
	 920BwSb4s5lqYf+izhrskETRHcBzJSjPHtxn0kxiV3Ngmzn+jjextIIidgLrbIuCFbBVY
	 FYHxfC47NeQsxelitEOD+V5LOViOVVjl+mPrSGD78KZiFQ6ouLoeD13u1hR8Ws9zQlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gavT6zB7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3899606A31C
	for <live-patching@vger.kernel.org>; Wed, 11 Nov 2026 00:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3899606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gavT6zB7
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b335eeb340so22358917b3.0
        for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 16:43:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794357780; cv=none;
        d=google.com; s=arc-20260327;
        b=jzuY1Hy85rBNHXnrBDjnkvAISd3K0WFSkLAs9v7rmwolEfnE+lFHvW7hrvSDZjMUgE
         1a/v8Geu8P9IFzKYs4XsJfd+3QfWMK1I1tDQ8pBLmsD1SP5esNSnjZxzbwKhaXGYARPu
         0hRajB+55dgcckyZW8n7unyoIC9EKR1L1lcxpBbgRmzZzJ4jkD8Cp0lIGp5Dlbg+nxmg
         dryFehz58+QHhX6wFqCzl8Ew6X9z3un0b+LHpszwavVz6S2+PYZDo3EaSrD2rv9ErgF7
         bi/xkxAorB5B7NWGBJXckDTPBDmdTiazN6g++ZpPb0IySBW6wGqg1jVnpKXct5uSaIYz
         8BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c3NqXZkZbKGw3JC6mkweYll+c++WAqjqo3wZC+1QKlo=;
        fh=a2iL9fIbKM5aeUq9e56+ep/1gCvD417t/KoFgbnuV6g=;
        b=OSW75Q00JvfiX0hrT3vSBPPegKRBVE4XESOiKMlA21LAaov4onCwjyHOpcD/gerHe3
         bfPqidkpclyn1K24Jy6SzlnZz/47kGxn4CMuw23BcDss9hcWqWOZsACz8JC19k98LPl9
         p524g92wZRhJXXeuM8UFprRJQdCK9uEKSp6qt2CkxMvPgD9n3wGqRjs95Xo+8I6T7rc6
         I7VUwnl/hgiJ1RfiV+AH5ZEyJU/p1Y6pEuybIpCK2xGpP/i0q14qlAnWuzMS8lywtZSo
         cYtXduRbp8VfM3fCT0RFJN2n6Rmi5Ex47nb+744Xlf1F5dJFBHekML+i9gzH1qQrTd5u
         z5ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794357780; x=1794962580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c3NqXZkZbKGw3JC6mkweYll+c++WAqjqo3wZC+1QKlo=;
        b=gavT6zB7Ced+m1M9YKMM/kNgjiLYaPq+uP27b5UroESrfV4Xa5ZkNdowfNFEk2ENi1
         PzceXHOdyNXssAZSSblGmM+NpWL+pg3xAcvmrqVSYLWsR+ikPLvx8zZMZaKJdU4iutoN
         J3QwfRGBCtkqnfJIw9x2uATO8CXDc2JU0XLtdtYF2vVL0w7aoURQbeuEpixh5khgAt/z
         5dWtQc/KZTRtRB2hIYV9x0ntylJTqXM/w7CWGXpWN3bVfrp/DbPuOAwiXj5C/ulE37l2
         b6K9V4Mk5lQLPiBkp6/cU5cf8gAYrcT+FYDkM99pCv30n6WU5/c19JcFr7SmB9ErNX/r
         99lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794357780; x=1794962580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c3NqXZkZbKGw3JC6mkweYll+c++WAqjqo3wZC+1QKlo=;
        b=JkBcZCd4NDsUVedZm8BXjlY38FHYr6amDathRvjxFY5NOB1uQC7kkrMREWqKcD4YGo
         pUj8Jum6yDq1g8dyhTc8ckcDxI7uXRNlYGhAj8An31Bgf/gtGjK8H2vJ65e8syHEwWCi
         VsfhtQgr0rWnOkfnnxYi6cl+efPgGtmbB8yXljl7hv1Xlf49HgbNnrq1EWdj1bKFaXa7
         IRikTLSQyncnBkJ13woi/6CxitEwmQDFqGIWL0Old0c6/d4l9Mqz+CSchE0oGLWBZlCw
         hwAimwLcmU4oCcjs9kDllyivvj6E4WLKNbp0WRqHpSQn018KyfWwWZnizEKcz8l4Gyd/
         9OGQ==
X-Gm-Message-State: APuU4Z+YaKuPjY+idAZsS6DLd2X3jkJMGHxZ6tR/+Ij5+k6vOeT+8n/f
	EyZorNwO9fJb+TZjPtx69Q2NjEOBW0175Wh9z9ZdWmrhKjjaEU8X9U9/8/NjBIsBGI/JNLi0f94
	4xR69FsLnLVYMiZA6BTMl2oQt34H8g5yy18JZTe1WDyszdZCySrXtLDpKuXM=
X-Gm-Gg: AYBFou1gaf/nL8UHdZNscJymjW+dCnfalKyvnUvcQbuT6tGYNZGsgiPewy+dtGmeS/r
	LJuyxKlv1PgotXEk8Yd0jcwHq6cej8ZspBu6DcvcMvoXb8nqnnAhLOeJjeU2/W8nl0/nu6s9FAL
	1UzBIIvfacOIVXeTjWBoLJ6AR5mT8Cka5RPL6R7OFJwMp8fcDgDjowopAkr/poC+OAje6bQbaKN
	DKSLw7ry0Qcrqgn/dOPWlJsQktD0rlbgAOx4QGK+F5qd83BZN52PMaCAxkOVSI9HBjx3tPx0lUc
	CAeTzC+juUUhD8S7qHSc4rQDmk1ls8xlzk/CXcWOSbOzRq9+Wafo+4jfv0r98iYjqZ7b59pbvD/
	ofml7whlP9PhIO+C915r2e+H3e2RUaPJxybmIEsoN3kAKSwIAU1YGxEu9AWn0JRVz6i+67jGBAe
	b4KlIiN6psMXZf
X-Received: by 2002:a05:690c:3181:b0:8b0:d468:e9ee with SMTP id
 00721157ae682-8b3a816adf0mr6153587b3.72.1794357779171; Tue, 10 Nov 2026
 16:42:59 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028214534.1919398-1-song@kernel.org>
In-Reply-To: <20261028214534.1919398-1-song@kernel.org>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Tue, 10 Nov 2026 16:42:47 -0800
X-Gm-Features: AclHuK-0KLQUOFaipVD5nVJPEq1dS14yAA31ZsSQdOg065mPf1YgIqvWrXbDoNo
Message-ID: <CADBMgpzvSnbu+ZzPYd5_d5Hx+1d1zAyU6sk27EZ0tnH7_JGMdg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] klp-build: Fix dependent patches, add selftests
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:45=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> klp-build fails when a later patch in the series depends on an earlier
> one, because it fixes each patch against the original source on its
> own.  Patch 1 fixes this by combining the patches into a single patch
> before adding the #line directives.

I'm curious, what is the advantage of using separate .patch files?
Since patches can require changes/conflict resolutions for older
kernels, we commit all patches into per-target-kernel branches and
generate the .patch file on the fly at build time.

>
> Patch 2 does this while validating the patches, before the original
> kernel build, so problems with the patches show up without waiting for
> a build.
>
> Patch 3 moves the patch processing into a new script,
> klp-prepare-patch, which klp-build runs.  It doesn't need a kernel
> build, so it can be tested on its own.
>
> Patches 4-12 add a kselftest target, livepatch/test_klp_build.  Each
> test builds a small source tree, runs klp-prepare-patch on some
> patches, and checks the patch it prints.  The tests compile nothing,
> need no root, and take about a second.  To run them:
>
>   make -C tools/testing/selftests/livepatch/test_klp_build tests

Ran these tests and they work on my end (applied on v7.4-rc1).

Tested-by: Dylan Hatch <dylanbhatch@google.com>

>
> Changes in v2:
> - Patch 1: describe combine_patches() without "refresh", rename
>   fix_patches() to process_patches(), keep the combined patch in
>   $COMBINED_PATCH rather than $PATCHES, change the status message to
>   "Processing patch(es)", fold get_patch_{input,output}_files() into
>   get_patch_files(), and keep tmp.patch in klp-tmp (Josh)
> - New patch 2: process the patches while validating them, before the
>   original kernel build (Josh)
> - Replace the --patch-only option with a klp-prepare-patch script,
>   which the selftests run directly (Josh).  The intermediate patch
>   without #line directives now lives in klp-prepare-patch's own
>   temporary directory, which is removed on exit.
> - Make the dependent patches test a case of test-basic.sh (Sashiko)
> - Name the selftest helpers and subjects after klp-prepare-patch
>
> v1: https://lore.kernel.org/all/20261017002441.716615-1-song@kernel.org/
>
> Song Liu (12):
>   klp-build: Fix dependent patches in a series
>   klp-build: Process the patches before building the original kernel
>   klp-build: Move patch processing to klp-prepare-patch
>   selftests/livepatch: Add tests for klp-prepare-patch
>   selftests/livepatch: Test klp-prepare-patch with dependent patches
>   selftests/livepatch: Test klp-prepare-patch with independent patches
>   selftests/livepatch: Test klp-prepare-patch with patches which cancel
>     out
>   selftests/livepatch: Test klp-prepare-patch with created and deleted
>     files
>   selftests/livepatch: Test where klp-prepare-patch adds #line
>     directives
>   selftests/livepatch: Test klp-prepare-patch with unsupported files
>   selftests/livepatch: Test klp-prepare-patch with patches which don't
>     apply
>   selftests/livepatch: Test klp-prepare-patch with offset and fuzz
>
>  scripts/livepatch/Makefile                    |   3 +-
>  scripts/livepatch/klp-build                   | 137 +--------
>  scripts/livepatch/klp-prepare-patch           | 277 ++++++++++++++++++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/livepatch/README      |  16 +
>  .../livepatch/test_klp_build/Makefile         |  26 ++
>  .../livepatch/test_klp_build/functions.sh     | 149 ++++++++++
>  .../livepatch/test_klp_build/run-tests.sh     |  68 +++++
>  .../livepatch/test_klp_build/test-basic.sh    |  93 ++++++
>  .../test_klp_build/test-cancelling-patches.sh | 102 +++++++
>  .../test-independent-patches.sh               | 124 ++++++++
>  .../test_klp_build/test-line-directives.sh    | 175 +++++++++++
>  .../test-new-and-deleted-files.sh             |  94 ++++++
>  .../test_klp_build/test-offset-and-fuzz.sh    | 120 ++++++++
>  .../test_klp_build/test-patch-not-applying.sh |  73 +++++
>  .../test_klp_build/test-unsupported-files.sh  |  30 ++
>  16 files changed, 1366 insertions(+), 122 deletions(-)
>  create mode 100755 scripts/livepatch/klp-prepare-patch
>  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/Make=
file
>  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/func=
tions.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/run-=
tests.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-basic.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-cancelling-patches.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-independent-patches.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-line-directives.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-new-and-deleted-files.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-offset-and-fuzz.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-patch-not-applying.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test=
-unsupported-files.sh
>
> --
> 2.53.0-Meta
>
>
