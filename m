Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D846EF9B;
	Mon, 12 Oct 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795969; cv=none; b=rCUnugnJlu1C78iv0J7uMFBbayWhgpUsPTCOdkfmL32DbHp44fL/+IfjQmY8H/5vYIHQugHWR3O/akrbxFzkOBZ3uUDUFsEvg6ib1t+i0LwK3DzxyptNN1oBiHD+xnotnRSpuRfypS0dM3sqURKp48yt39H+Ff8X2N3Qi4n/XWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795969; c=relaxed/simple;
	bh=YtH4w+hmlWfzXcIEUofEsOogUN5x6fIlGU/dD0EI/5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlFESnV2A1Vt3c06frMo9SDWta7g6Jp8ykXeVD2xR967B5RKV2QVTWvjXXoJS69AH3fb2yCFo4drNiy9Gd2i0rM7QwfkES9NwSpFa15U8uCYMPYRD0cLyb6kgSm50KTWNh36jQ6HLVvYT9IRdEG5jFQ9J/LvNLGZFHBws9E9R6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1xGBeS-00000001fgc-3r88;
	Mon, 12 Oct 2026 10:44:56 +0200
Date: Mon, 12 Oct 2026 10:44:56 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com,
	shuah@kernel.org, mpdesouza@suse.com, oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 0/7] riscv: Add reliable stack unwinding for livepatch
Message-ID: <asyeCD1xaIuKv3nl@akranes.kaiser.cx>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <artojcJftbMIgPrj@akranes.kaiser.cx>
 <fbdb7b4c-0f80-41b0-b6d8-a4501ff3e820@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbdb7b4c-0f80-41b0-b6d8-a4501ff3e820@linux.alibaba.com>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Hi Shuai,

Thus wrote Shuai Xue (xueshuai@linux.alibaba.com):

> It is great to hear that livepatch works both on a standard rv64 QEMU
> and on the rv64 CHERI system. Could you share what the minor tweaks
> for CHERI were? If any of them are generic -- for example frame-record
> size/alignment or pointer-width assumptions in the unwinder -- it may
> be worth folding them into this series, so the cheri-linux tree has
> less to carry downstream. If they are purely CHERI-specific, a pointer
> to your tree would still be a useful reference.

the cheri changes are simple fixups of data types and assembly instructions.
This isn't something that can be upstreamed at this point.

Eventually, it'll end up in the cheri linux tree at
https://github.com/CHERI-Alliance/linux
but there's more cleanup to do first.

I just wanted to show my interest in getting your patches merged.

Thanks,
Martin

> +Palmer, Paul, gentle ping on this series.

> It has been under review since late May (v1 on May 27, now in its sixth
> revision) and the tags collected so far are:

>   * Acked-by: Miroslav Benes <mbenes@suse.cz>             (7/7, livepatch)
>   * Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com> (7/7)
>   * Reviewed-by: Martin Kaiser <martin@kaiser.cx>         (whole series)
>   * Tested-by: Martin Kaiser <martin@kaiser.cx>           (whole series,
>     rv64 QEMU and rv64 CHERI, livepatch working on both)
>   * Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>   (2/7, 3/7, 4/7, 6/7)

> v6 still applies cleanly onto the current riscv/for-next
> (52318cf0fa6e). If it helps, I can send a v7 that folds in Martin's
> Reviewed-by/Tested-by tags.

> Could the series be considered for the upcoming 7.4 merge window?

> Thanks,
> Shuai Xue


