Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18221A6804
	for <live-patching@vger.kernel.org>; Tue,  3 Mar 2026 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505036; cv=none; b=VtDwEePGMo861gnnqQfKIMDWJ9tSnTWKbAxpfragl4qG0f+/0Gu7Dx933y/7MZVHK+ubcW8wQf9+To/faIvmh9i9W9B6O52tfl2djRuNXcC20y7gTkFrBGcTrd0PG2woy6Pnm6VfTZeO9yUG3W5LafD2dOBDkIyZZGnJohWDfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505036; c=relaxed/simple;
	bh=ehZ61Ma6VBA6gdSQepFCIxceHFAd7KSfjDR4RPTv/aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcTjt/SbUNl9qUqY/ehX0YoY1uNsGrAfDbXi2HLm6l4ALk16ixO1x+lc6/yfk/gH962lzaeLIjTVhE2LLVm+6guvP53pGzoTAo1psPODtEsT9Dhj9F6IlqXc4O0PDZ1pXNgeRH7qtvR26ppbWtdYbbxaWXdyqELFyZx7C8gjb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ic2gT+oX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ic2gT+oX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772505033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ot/6Orw7a5NQZRMs6izEHQUHiJsDarDDF7MWwMUk7/0=;
	b=Ic2gT+oXaUnLWmYhruu/PZwwOBwZJEnio8H+oGJ0F1T5LypkBymGdSewp9CobMnCgtGDOV
	GZqXdz197OSzmemQtL+vipPqeXsw/H8e+QCe6nggG5VnoK/0aPTP2VF3I+424L+0i/qUOX
	cTgnvheMG8iSUR/TU6iqlKPObP1KpSs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-sFFjWBl5P_uA7xj04MsQDQ-1; Mon,
 02 Mar 2026 21:30:28 -0500
X-MC-Unique: sFFjWBl5P_uA7xj04MsQDQ-1
X-Mimecast-MFC-AGG-ID: sFFjWBl5P_uA7xj04MsQDQ_1772505027
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F8E91956057;
	Tue,  3 Mar 2026 02:30:27 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E0DC3000218;
	Tue,  3 Mar 2026 02:30:25 +0000 (UTC)
Date: Mon, 2 Mar 2026 21:30:23 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 13/13] livepatch/klp-build: don't look for changed
 objects in tools/
Message-ID: <aaZHv6YoJzwmZF6m@redhat.com>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
 <20260217160645.3434685-14-joe.lawrence@redhat.com>
 <os3ykxdsfe6bz2b2pd5x5wb76ya5ecogbvjgkcophf55wchv7r@vdp2dzrzrdny>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <os3ykxdsfe6bz2b2pd5x5wb76ya5ecogbvjgkcophf55wchv7r@vdp2dzrzrdny>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Feb 23, 2026 at 01:41:58PM -0800, Josh Poimboeuf wrote:
> On Tue, Feb 17, 2026 at 11:06:44AM -0500, Joe Lawrence wrote:
> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > ---
> >  scripts/livepatch/klp-build | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Why?
> 

I don't have a pithy repro captured here, so I can just drop this for
now.  I was playing with building klp-build selftest modules and
stashing the resulting .ko's under tools/testing/selftests.
Occasionally subsequent klp-builds would get confused when seeing only a
.ko and complaint about missing ancestor object files.  Which led me to
ask, why does it look in directories that don't even include kernel
build artifacts.

--
Joe

