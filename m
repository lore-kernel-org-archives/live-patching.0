Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F730C34A
	for <live-patching@vger.kernel.org>; Tue,  3 Mar 2026 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504452; cv=none; b=DQdmIameSRV/EO3RV32sYkPEgU42aEd6tS3ctJa2MsH1Y0L4pGejTN3nm2HwkXYkd2lAnKMs/6mXTiOkLSGTTQD6vbXoO1lJgwGxxVhvFzfMW6xHQQJpJz43j7c2A4ptYbosFtkJHLncmc2nF+D7GbZkQ+w0oWYkJAsKlO5PHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504452; c=relaxed/simple;
	bh=zcbO+OORas/v5OmTPl2IpSIhGVS0qfKBCjubOan5xMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSD9bIdfR7iIfpxCOe1T5SIQ7kUSGAfEJM7dQtv6Tv/ogfvG329E9GInE3cILPC3lExTBfzm0d19N4WnlMIeOySoDSVJjNKUKhGuNSORGN0VrNP/xrXaDuZ7Oq0vQXu7cHKtDoQvRh5ArRsgO19vdxK12AisKnPrDP+KNXmj2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFq1pvwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFq1pvwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772504450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpv8yO1Ck+YjshUVFO+73J4zai+Lp6Tloogb3UGfUbE=;
	b=RFq1pvwXNAyoBbLRrxfZZqs5l8XKRksaBWOnSGSSt/aLCy1Itm4MBcNuySYcT8hYQZBd8e
	Q2iZ+6NzfQhyVAYVYTpT5OcPgj4zm42XaYvkWxMi9uNUJif8JwaoklrVOrCHqA+KghFObR
	WXdc7cuBq/jmfLMiBjiP2s404i7xuz0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-6i09qu3aMrmCuTMAYJd57Q-1; Mon,
 02 Mar 2026 21:20:47 -0500
X-MC-Unique: 6i09qu3aMrmCuTMAYJd57Q-1
X-Mimecast-MFC-AGG-ID: 6i09qu3aMrmCuTMAYJd57Q_1772504446
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51B351800378;
	Tue,  3 Mar 2026 02:20:46 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C27BB1800370;
	Tue,  3 Mar 2026 02:20:44 +0000 (UTC)
Date: Mon, 2 Mar 2026 21:20:41 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 10/13] livepatch/klp-build: provide friendlier error
 messages
Message-ID: <aaZFeVWhiBh0-Hga@redhat.com>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
 <20260217160645.3434685-11-joe.lawrence@redhat.com>
 <g27qxnginju67wz2eqhfy4mnaerydaw5mh3tbtlb5zo5pj5unu@th5y2kq7xokf>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g27qxnginju67wz2eqhfy4mnaerydaw5mh3tbtlb5zo5pj5unu@th5y2kq7xokf>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Feb 23, 2026 at 01:15:55PM -0800, Josh Poimboeuf wrote:
> On Tue, Feb 17, 2026 at 11:06:41AM -0500, Joe Lawrence wrote:
> > Provide more context for common klp-build failure modes.  Clarify which
> > user-provided patch is unsupported or failed to apply, and explicitly
> > identify which kernel build (original or patched) failed.
> > 
> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > ---
> >  scripts/livepatch/klp-build | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> > index 6d3adadfc394..80703ec4d775 100755
> > --- a/scripts/livepatch/klp-build
> > +++ b/scripts/livepatch/klp-build
> > @@ -351,7 +351,7 @@ check_unsupported_patches() {
> >  		for file in "${files[@]}"; do
> >  			case "$file" in
> >  				lib/*|*.S)
> > -					die "unsupported patch to $file"
> > +					die "$patch unsupported patch to $file"
> 
> Can we add a colon here, like
> 
>   foo.patch: unsupported patch to bar.c
> 

Good idea, will do in v4.

--
Joe

