Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FA405C35;
	Fri,  5 Jun 2026 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647075; cv=none; b=n2mpJkiHwhIZnpdPd6+Dvsxqusn+XuxdunNTCkA4UuMYhVH8vLAkXRxf9yftFP1d4JH1oXGjYbmoSKd/l3ly6/yFtAJ2+v29DlVyj7jLa9zwPBIb+LWSbMdGKvF+aoY9xkMkmElqZg8KFF/Vm3E+pulPzowYyLAEvuZEzziuybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647075; c=relaxed/simple;
	bh=1P75YSe2hDvmC1O+S+75qpdiJlWGlVpjjab3TK9N9+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e89TIBEpYTR5ICJ60dIG9mfe+jIcIvmZMkQ+CaQ8Qj+Z3wPoUk53uxtf4wBQqRDH1fXpO01LuDKSntGrGXEV8OAmcjkOLeN5XHpsPwpEereOAPfv+g9VJ7kWEBxPyYPf+ncqBoAJfYrztbMz6Mfp2IkgW7SLCBljQdbc5mI9rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=alo3Vano; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="alo3Vano"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780647064;
	bh=q77HunASJP9ggqwJr7W+b5k7TC1K39oK1QiKtyFMGzs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=alo3VanokqDGJ5qOPkRx2f7xt8vyzPi7DaKgWDmHCliAyIbuqnaffUl75Cx7/VwsL
	 IWoeAGYFUdyzQZZQEpN1oTHU1G/Zvt+K6Jf9ynHrBMXTMvaiIFOEdezf7vNujZ+rra
	 OTulVux8/FM8YuEEKOHhSwWdGgN/4zi1pMzk9v3w=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id DC1A065982;
	Fri,  5 Jun 2026 04:10:59 -0400 (EDT)
Message-ID: <046da9c8886dcb35d6427b7467ce551ef1426480.camel@xry111.site>
Subject: Re: [PATCH 5/8] LoongArch: fix kernel panic with -fPIC for
 same-compilation-unit symbol references
From: Xi Ruoyao <xry111@xry111.site>
To: George Guo <dongtai.guo@linux.dev>, chenhuacai@kernel.org, 
	jpoimboe@kernel.org, peterz@infradead.org, jikos@kernel.org,
 mbenes@suse.cz, 	pmladek@suse.com
Cc: kernel@xen0n.name, joe.lawrence@redhat.com, rostedt@goodmis.org, 
	ardb@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	yangtiezhu@loongson.cn, jiaxun.yang@flygoat.com, liukexin@kylinos.cn, 
	loongarch@lists.linux.dev, live-patching@vger.kernel.org,
 llvm@lists.linux.dev, 	linux-kernel@vger.kernel.org, George Guo
 <guodongtai@kylinos.cn>
Date: Fri, 05 Jun 2026 16:10:58 +0800
In-Reply-To: <20260604065317.219777-6-dongtai.guo@linux.dev>
References: <20260604065317.219777-1-dongtai.guo@linux.dev>
	 <20260604065317.219777-6-dongtai.guo@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 14:53 +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
>=20
> Add architecture-specific -fPIC compiler flag for LoongArch64 to prevent
> kernel panics when applying livepatches containing references to symbols
> defined in the same compilation unit.
>=20
> Root cause:
> In the KLP workflow, when a function is livepatched, it's extracted
> from the original object file and compiled into a separate kernel
> module. When the patched function references symbols defined in the
> same compilation unit (like 'uts_sem' in kernel/sys.c), these
> references break if not compiled as position-independent code.
>=20
> On LoongArch64, without -fPIC, references to same-compilation-unit symbol=
s
> use absolute addressing that assumes fixed memory locations. When the
> function is relocated into the livepatch module, these absolute addresses
> become invalid, causing kernel panics.

This is incorrect.

With GCC and Clang, -fPIC does not mean generating position independent
code.  It means generating position independent code *suitable for SVR4-
style shared objects*.

The kernel has nothing to do with SVR4-style shared objects.  The kernel
modules are not SVR4 shared objects but relocatable ELF object files.

If you only need position independent code (without the shared object
stuff) you should use -fPIE instead.  The kernel is already built with -
fPIE if CONFIG_RELOCATABLE=3Dy.

Thus if you only need position independent code you should make live
patching depend on CONFIG_RELOCATABLE.  On the contrary if you really
need to use/abuse something mechanism designed for SVR4 shared object
you 'd at least need to fix the description above.

--=20
Xi Ruoyao <xry111@xry111.site>
