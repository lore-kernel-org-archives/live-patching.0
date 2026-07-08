Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C23F58C5
	for <live-patching@vger.kernel.org>; Wed,  8 Jul 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518882; cv=none; b=FAPNohk+M2NE5Lp2ORw4FQcqZDAEx9RQY+fJJPsI7o2yZ18A3kbjrnhDxhmJtXkn9lhvf8Nfboo2E2l3EqouFKaXcg8R5vejMP39JTcO7BI52gC+20xUJshpN2ZaVvabOtJDay4gR8vjo+7mVXvhjei1lVPIEIiKkNaSFagyXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518882; c=relaxed/simple;
	bh=SjiW6ERHS9Z2yaDAhoQdEShUzxO6v2nFKQKuoJ2Vge8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Rfgkos8Ic8V5ZM5lzSU7JxgAUa5s2PzTl+HJcbQj/YA4AKxsLJbSXFdRB24SBtUb5pjtURunM32uAj2Bp/jL9lHv7d31t/yQ7W9jsoGRGWhGGcrtSHhowpwMsmaJq5NxVc+B8y8SRSxzSOfqFnxToNUc1XbrQyCI4mDbVEz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuNSH5ky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuNSH5ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783518874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDn+ZB5QDmMZlAymNbimx46tA1OJX7SIC3YtbFxxLtw=;
	b=IuNSH5kyQ98zEW0IGbDxKfPLVEcdAuyAsVEpeHLtjgbq2duvrhPHqeWdakx0C+SjFwmVtB
	bIFRY+6Lywon+f6GkSklJq4J5fNQdThz8qQipJzgyGRQlPOJMpRDbj70emLGjzC/VUqKfU
	vLENwyC0w0iVxE/j35TcpAF7D1r8bIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-2nD2FG_uMEybatzCU5d3YA-1; Wed,
 08 Jul 2026 09:54:29 -0400
X-MC-Unique: 2nD2FG_uMEybatzCU5d3YA-1
X-Mimecast-MFC-AGG-ID: 2nD2FG_uMEybatzCU5d3YA_1783518866
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 838B01800EF8;
	Wed,  8 Jul 2026 13:54:24 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.46])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98BA31800347;
	Wed,  8 Jul 2026 13:54:18 +0000 (UTC)
Date: Wed, 8 Jul 2026 09:54:16 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
	kernel@xen0n.name, rostedt@goodmis.org, ardb@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn, jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn, guodongtai@kylinos.cn, xry111@xry111.site,
	wangyuli@aosc.io, loongarch@lists.linux.dev,
	live-patching@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/12] LoongArch: Fix EFI linking with -fdata-sections
Message-ID: <ak5WiNb51kGB1p2f@redhat.com>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
 <20260707072031.231066-6-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707072031.231066-6-dongtai.guo@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jul 07, 2026 at 03:20:24PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> When building with func-fdata-sections, the .init.bss section gets split

nit: s/func-fdata-sections/-fdata-sections

> up into a bunch of .init.bss.<var> sections.  Make sure they get linked
> into .init.data.
> 
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  arch/loongarch/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index 840d944c2f73..dc5fa017db94 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -96,7 +96,7 @@ SECTIONS
>  #endif
>  
>  	.init.bss : {
> -		*(.init.bss)
> +		*(.init.bss .init.bss.*)

Both arch/arm64/kernel/vmlinux.lds.S and
arch/loongarch/kernel/vmlinux.lds.S contain a "/* from the EFI stub */"
comment documenting the wildcard.  Might be worth adding for v4.

--
Joe

