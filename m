Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945153C945B
	for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669634; cv=none; b=Sun5QXV+0ocauU/uoDH8lV8UiMwubSG+WznBVhVpYouJqorqizNd8beN5OCSydPftW59qcMx79bfgPgiBNUJAWwiPUZYJE/QkARmqAX2XWpMbOloON8ojBIgyJqfBYZfpBb0L2FFk729aX//TOtliBIT0Kk0gIybdPY6jQaaJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669634; c=relaxed/simple;
	bh=e9b7s/MJ/pK6CknYTC1TBjZb12JwoLLMzcbxDwaP2Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac5d+EujI5wsviOONDtbcMX6cQrTBDoTN0CqD+2Bi9jYquKLy8KmIxETnmswevJfVoGIshUcm3u/xu6rXQyCb/COMVz06FGsk7i8AFld7NYMwuJwSEKKaNa1imWhBXleEundlYqRP9m1Or/kGbIWHem1XhD5hqLezAeRVGIRMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o2WG+44B; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o2WG+44B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783669620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9b7s/MJ/pK6CknYTC1TBjZb12JwoLLMzcbxDwaP2Tg=;
	b=o2WG+44BIkkS3thmCKDyGG3TIshOx+dgmxs2/dJet58r6CMJQ2JHYtwN6K5GGlBooGE0t2
	5NJQ3EnVB5UU1oCWDPJbvlgF3b/58jRrfGq4j+x1TdMg34GRga7WKcXbyG+NcCbXJ4eI1G
	XAlGEsf1ILvmpAP01QC3OsIRLV+RtrI=
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
Subject: Re: [PATCH v3 05/12] LoongArch: Fix EFI linking with -fdata-sections
Date: Fri, 10 Jul 2026 15:46:51 +0800
Message-ID: <20260710074651.27483-1-dongtai.guo@linux.dev>
In-Reply-To: <ak51uLgw09N8gCqQ@redhat.com>
References: <ak51uLgw09N8gCqQ@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Joe,

> nit: s/func-fdata-sections/-fdata-sections
[...]
> Also the commit message says, "Make sure they get linked into
> .init.data," but should that read, "... into .init.bss"?

Yes to both. I'll fix the "func-fdata-sections" typo and change
".init.data" to ".init.bss" in the commit message -- the .init.bss.*
globs land in .init.bss, not .init.data.

> Both arch/arm64/kernel/vmlinux.lds.S and
> arch/loongarch/kernel/vmlinux.lds.S contain a "/* from the EFI stub */"
> comment documenting the wildcard.
[...]
> ^^ typo: I meant the riscv version as well

Will do -- I'll add the "/* from the EFI stub */" comment next to the
wildcard, matching arm64 and riscv.

Thanks,
George
