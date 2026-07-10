Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ACA194AE6
	for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669140; cv=none; b=LkeQosTsjJZCShZTVHYRx8VFUxKx7x21a58o1IiRONy8YTEiVlzrgrYDJqxuSyVQXkZtwUkhDNjsSlP8XJIP5RuO4B7KWcNxq0i67D8CD1QInIILyy0lzfTdxAQuQGjQU5iRe5vDxWdSOXKkSRImLs8QHX0LQqa8Of47b/GqyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669140; c=relaxed/simple;
	bh=xSNIeyQeUHQgZHGjLA322pu93/7oHBT7D8w6q7YwSZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfchZ8op2OGOcvK0FyQoMf4bFLRBEJipIlYOBZ9Kb3NEDSntK3ZXWgYeSV4YZPjlppUWCgwFfisRGpyJknb8e4RfF71ZF7MmQ2cRyMJCvz3FjdfZ0Otmh30BuKM1Th15ylb3Vbw5TALZUE9YDrMnqaqHCgkZ29LIFA8pXcXVSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KCdmfVNq; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KCdmfVNq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783669127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSNIeyQeUHQgZHGjLA322pu93/7oHBT7D8w6q7YwSZU=;
	b=KCdmfVNqyUT+aXz3av1Mlph3kPfUMFvt9IgSgl9i9QJvbLNnPzbn5BL/edpQDexUYk5Hsd
	foiRM5fDCMMMM50djFYVXvJXBq4Jqc6CAfYRiBVdkmkv81vVneipr84BsiWqiSPCTiqm1t
	32MvIDJjIvV1wzIg9suxmuSZ+bGKH1U=
From: George Guo <dongtai.guo@linux.dev>
To: joe.lawrence@redhat.com
Cc: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	kernel@xen0n.name,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] livepatch/klp-build: build LoongArch with -fPIC to keep GOT-indirect symbol references
Date: Fri, 10 Jul 2026 15:38:27 +0800
Message-ID: <20260710073827.27064-1-dongtai.guo@linux.dev>
In-Reply-To: <ak5nH60j4Rdn50n-@redhat.com>
References: <ak5nH60j4Rdn50n-@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Joe,

> This might be my personal preference, but I think it would be quicker to
> review patches: [...] if they were squashed into one patch.
[...]
> the combined commit remains complete thought, i.e. for LoongArch
> KLP builds, replace the arch's KBUILD_CFLAGS_KERNEL (dropping -fPIE and
> -mdirect-extern-access) and add -fPIC via KCFLAGS instead.

Makes sense. I'll squash patches 03 and 04 into a single patch and drop
the forward/backward references from the commit message.

> I'd also pull out the configuration checks into validate_config() to be
> consistent:
[...]
> and then build_kernel() only needs to adjust the cmd / flags accordingly.

Agreed. I'll move the CONFIG_RELOCATABLE / CONFIG_AS_HAS_EXPLICIT_RELOCS
checks into validate_config() and leave build_kernel() to just set the
flags.

Thanks,
George
