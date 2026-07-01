Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2632B13E;
	Wed,  1 Jul 2026 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950045; cv=none; b=BbuzyQBIvTe5hpEwIGH1o1DEtkbNfgJk4Y8ZCeeKxwoa/E8yGoIj/FYYoPChchY43M5AMezrtIx2WFg6OGGAifloQbh5CF/1DQMJIl3k6UlFoKOIgLRdpovvfJxrovVI7Ya9TJaVW6ixbLKqTCwcSUGgqLg4H2pRT5CXydBjMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950045; c=relaxed/simple;
	bh=p3ezXwrNdjRRY7TlGmHhCyhsYIU7/WYzR/e3JIoC/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHC3M6Wq6a9+Wvwl545qvpL6mJYsXod9+6/ZD1E8o2FFDKepYNH9bFU45dge0mgfedEL/MD/vIYP0gvWEpCBoNqIA6sDUbYBKJt+h9jaxagn/GF8DrBoY/QtWjw/XngUP5eHtrFcsTDqNoF7sM0HRPavYAtwMQNl7PkwIExBjyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAygV4hI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAygV4hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF711F000E9;
	Wed,  1 Jul 2026 23:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950043;
	bh=u2PUelh4EikJk8VRL0BrzFZUq8c3iUvAtS1lbzPhPjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mAygV4hIV6YoyWb7/ecIGCOT08GKdyIneBmGL+osXMoVLENJRBm8A+wOpFyst6Nex
	 C6ZuRpozBgYFj0ufvAbUht95C8MqOSp9VKXcvElrSAF+h9vVZ59bR7HxjsiM/f13yk
	 /gxEOJb/nkLghcVsO9W5/0kO2qenjkSOU1tzsC+I8KIpi1+kdvcdLe1mSUyUhIbcw6
	 +VemCi/iIanLDO72nOtYp5iH9Qy4Ha5SK7n35BziIx0zuo/tJNjBg8drT1cjnNuldO
	 81YyQmyyvdaVTXPO4NDhvbBq50R6UT73EbV/DjSeoRicSWUT+G7LnReQDrdvaaVsRD
	 pELSIJqmn1N8w==
Date: Wed, 1 Jul 2026 16:54:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/2] perf symbols: skip livepatch symbols
Message-ID: <akWomlgaxlvkBwkX@google.com>
References: <20260626212140.1380094-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626212140.1380094-1-joe.lawrence@redhat.com>

Hello,

On Fri, Jun 26, 2026 at 05:21:38PM -0400, Joe Lawrence wrote:
> This patchset fixes two minor perf bugs when livepatches containing
> special so-called livepatch symbols are loaded.  In both cases, perf
> should ignore these symbols as they resolve as relocations to kernel
> addresses and not module space.
> 
> - Patch 1 fixes `perf test 1`
> - Patch 2 fixes `perf record --kcore` bloat
> 
> 
> Testing notes
> =============
> 
> ("perf symbols: skip livepatch symbols when loading kallsyms"):
> 
>   Without patch:
>   ./tools/perf/perf test 1
>     1: vmlinux symtab matches kallsyms                     : FAILED!
> 
>   With patch:
>   ./tools/perf/perf test 1
>     1: vmlinux symtab matches kallsyms                     : Ok
> 
> ("perf symbols: skip livepatch symbols in kcore_copy")
> 
>   1. Baseline = pre-patch perf, no livepatch
>   ------------------------------------------
>   
>   $ ./tools/perf/perf record --kcore -a -o /tmp/baseline.data -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.221 MB /tmp/baseline.data (1717 samples) ]
>   
>   $ tree --noreport -h /tmp/baseline.data
>   /tmp/baseline.data
>   |-- [ 235K]  data
>   `-- [   50]  kcore_dir
>       |-- [  11M]  kallsyms
>       |-- [  25M]  kcore
>       `-- [ 1.7K]  modules
>   
>   
>   2. Bloated kcore = pre-patch perf, with livepatch
>   -------------------------------------------------
>   
>   $ insmod kpatch-5_14_0-570_94_1-1-3.ko
>   $ ./tools/perf/perf record --kcore -a -o /tmp/klp-bloated.data -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.274 MB /tmp/klp-bloated.data (2757 samples) ]
>   
>   $ tree --noreport  -h /tmp/klp-bloated.data
>   /tmp/klp-bloated.data
>   |-- [ 288K]  data
>   `-- [   50]  kcore_dir
>       |-- [  11M]  kallsyms
>       |-- [  68M]  kcore
>       `-- [ 1.8K]  modules
>   
>   
>   3. Post-fix = patched perf, with livepatch
>   ------------------------------------------
>   
>   [ kpatch-5_14_0-570_94_1-1-3.ko still loaded from test (2) ]
>   
>   $ ./tools/perf/perf record --kcore -a -o /tmp/postfix.data -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.274 MB /tmp/postfix.data (2763 samples) ]
>   
>   $ tree --noreport -h /tmp/postfix.data
>   /tmp/postfix.data
>   |-- [ 289K]  data
>   `-- [   50]  kcore_dir
>       |-- [  11M]  kallsyms
>       |-- [  25M]  kcore
>       `-- [ 1.8K]  modules
> 
> Changes
> =======
> 
> v2:
> - Move klp symbol check into tools/perf/util/symbol.h alongside similar
>   is_ignored_kernel_symbol() check [Petr]
> - Use KLP_SYM_PREFIX instead of inlining it [Petr]
> - Add similar check to kcore_copy__process_kallsyms() [Sashiko]
> 
> - Note: Sashiko flagged a pre-existing off-by-one in kallsyms__parse()
>   where the symbol-name loop could write past symbol_name[] on overlong
>   entries. That issue is unrelated to livepatch symbols and was already
>   fixed by Rui Qi's 68018df3f55e ("perf: Fix off-by-one stack buffer
>   overflow in kallsyms__parse()").

Petr, are you ok with this change?

Thanks,
Namhyung

> 
> v1: https://lore.kernel.org/linux-perf-users/ajzwjNncrI3Bob_o@pathway.suse.cz/T/#t
> 
> Joe Lawrence (2):
>   perf symbols: skip livepatch symbols when loading kallsyms
>   perf symbols: skip livepatch symbols in kcore_copy kallsyms processing
> 
>  tools/perf/util/symbol-elf.c |  4 ++++
>  tools/perf/util/symbol.c     |  4 ++--
>  tools/perf/util/symbol.h     | 12 ++++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> -- 
> 2.54.0
> 
