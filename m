Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A73451C6;
	Wed,  8 Jul 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517405; cv=none; b=F8MklljX4jIxEezm8CzRQ1j3UmSN7N7yO6cDRGI+kltgIjGo2MJn0ilbk21SM7nyKz4rJe9utw9/muM1u649juPTbwfYXuzwSr7UORLMmLyv7IFTEdQfs7PG8nlRHOwd17XpUkHlL95O+KS6zVc6y4xzq+0hi6uLBm8hwNJPqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517405; c=relaxed/simple;
	bh=M03bABgfeH1vQxaRx91yzwdNJMV3GDWiz437kVa1sM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBdvcyvH//YHBsm9rhRkX0cw061/DOgtCJI5RdLeZ0QMi7PUUzG/247u/wQj+/WJFfKceYtsn2kbNmq9DKpMzdnG0H/psduSj+pSpgWyrHjNyxU0cVArHNakurNLDk0juwZUrfvnPypjBWKNoQWgnBbm6J7iq6eUhY/8jfyfOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=eyeorHBz; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="eyeorHBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1783517394;
	bh=0lsf6gGfCY3XhTEU6LMoC5aiZhuoVlhT4fXzJilHE54=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eyeorHBzJEORaM3YlQMfELGV8ZwrD5OmxmzXnx/2jbHdNOpc/JlU/Pzga4pmsjYoE
	 KMiml60/VVobuG+Kqx29FrZBBhN7W1G6IeEhfbJSG5BSi2SDDnQsDmmuxqPSovhne4
	 0Kn03tXoo+kZJSQbabxS1baL5Mxvk9UJJyf8YcwM=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 830E765B57;
	Wed,  8 Jul 2026 09:29:48 -0400 (EDT)
Message-ID: <d89e9c660f06489c59c2f1f7fae0547abbefac71.camel@xry111.site>
Subject: Re: [PATCH v3 12/12] objtool/klp: Fold LoongArch paired ADD/SUB
 relocations into PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: WANG Rui <wangrui@loongson.cn>, George Guo <dongtai.guo@linux.dev>, 
	chenhuacai@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
 jikos@kernel.org, 	mbenes@suse.cz, pmladek@suse.com
Cc: kernel@xen0n.name, joe.lawrence@redhat.com, rostedt@goodmis.org, 
	ardb@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	yangtiezhu@loongson.cn, jiaxun.yang@flygoat.com, liukexin@kylinos.cn, 
	guodongtai@kylinos.cn, wangyuli@aosc.io, loongarch@lists.linux.dev, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Wed, 08 Jul 2026 21:29:46 +0800
In-Reply-To: <20260707072031.231066-13-dongtai.guo@linux.dev>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
	 <20260707072031.231066-13-dongtai.guo@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 15:20 +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
>=20
> On LoongArch, the "key - ." field of a __jump_table entry can come out
> as two relocations at the same offset, R_LARCH_ADD64 plus
> R_LARCH_SUB64.=C2=A0 clang's integrated assembler emits this pair when th=
e
> key symbol is not defined in the same translation unit (for example
> __tracepoint_netif_rx); GAS, and clang for locally-defined keys,
> produce a single R_LARCH_64_PCREL instead, which is why GCC builds do
> not hit this.

Hmm, is this a flaw in LLVM?  We have

config AS_HAS_THIN_ADD_SUB
    def_bool $(cc-option,-Wa$(comma)-mthin-add-sub) || AS_IS_LLVM

so we are already expecting LLVM to emit R_LARCH_64_PCREL always instead
of ADD64/SUB64.

--=20
Xi Ruoyao <xry111@xry111.site>
