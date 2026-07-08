Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E4414A31
	for <live-patching@vger.kernel.org>; Wed,  8 Jul 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526861; cv=none; b=uxxNiYGaJZnmYMTYyyiK6DNnshJp+Z93pwfhDMs+SdXgFEjVcduIJnwCENatkD4KpPUP0sS8iwUr0Zb5Hmiw2IPE9jY3NE+Xnh0+WqbLlbNhcy+s0f/Vo13Q+3PHZKu2cEvmdQlIL6r4Byp7R6wXgS2ZdftkaZj3Svyq6MSBu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526861; c=relaxed/simple;
	bh=5yyIDddQ130JfzRDQqOGfDTnzMapL4KsOGQiNwYnIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFixqTJr54bdacdLo+mbOhGphru5/VDLC2caEbOSJlYmnarvrL09D9XGGihv+SI6vVjXGryXOd3Pb0zZIkBe+1UvStBSkupfI7Nwc+0ACAGjXf6Ppzdy24i0LiYJyc0O4iiPodWkpWb8qj3oSiadlSStOHNkTUWkOyrlDgjd2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tj0Ogx27; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj0Ogx27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783526859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pT4s58Ja3ICOTpX9Abz1gYYrYRAssFWhDyT+DCkKwyw=;
	b=Tj0Ogx278/hk+vjcBgYmVe4h4gPbgmqt6s5VhP6Fy7dbPeb+Q98JhYn9bcN7cAyk5ORx31
	akUOph+TBg/yQNGCIVQ4zsySiCrLjjsm6Vx6bbrOdqvHvaGxxrjlf3NTrZvD2UvexFZBKS
	610NY8UTPCPehQs21j8y+KSJy9SY+G8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-djR_dbNLPkSNDJ4oNMlB2Q-1; Wed,
 08 Jul 2026 12:07:33 -0400
X-MC-Unique: djR_dbNLPkSNDJ4oNMlB2Q-1
X-Mimecast-MFC-AGG-ID: djR_dbNLPkSNDJ4oNMlB2Q_1783526850
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66B391955DA1;
	Wed,  8 Jul 2026 16:07:28 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A2763000B4B;
	Wed,  8 Jul 2026 16:07:22 +0000 (UTC)
Date: Wed, 8 Jul 2026 12:07:20 -0400
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
Message-ID: <ak51uLgw09N8gCqQ@redhat.com>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
 <20260707072031.231066-6-dongtai.guo@linux.dev>
 <ak5WiNb51kGB1p2f@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak5WiNb51kGB1p2f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jul 08, 2026 at 09:54:16AM -0400, Joe Lawrence wrote:
> On Tue, Jul 07, 2026 at 03:20:24PM +0800, George Guo wrote:
> > From: George Guo <guodongtai@kylinos.cn>
> > 
> > When building with func-fdata-sections, the .init.bss section gets split
> 
> nit: s/func-fdata-sections/-fdata-sections
> 
> > up into a bunch of .init.bss.<var> sections.  Make sure they get linked
> > into .init.data.
> > 
> > Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> > Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > ---
> >  arch/loongarch/kernel/vmlinux.lds.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> > index 840d944c2f73..dc5fa017db94 100644
> > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > @@ -96,7 +96,7 @@ SECTIONS
> >  #endif
> >  
> >  	.init.bss : {
> > -		*(.init.bss)
> > +		*(.init.bss .init.bss.*)
> 
> Both arch/arm64/kernel/vmlinux.lds.S and
> arch/loongarch/kernel/vmlinux.lds.S contain a "/* from the EFI stub */"

^^ typo: I meant the riscv version as well

Also the commit message says, "Make sure they get linked into
.init.data," but should that read, "... into .init.bss"?

--
Joe

