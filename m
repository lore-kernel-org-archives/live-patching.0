Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E646AF17
	for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635465; cv=none; b=me4fLuVZNVZLYJE8ssbcO8VpnK9tNyE+iKQTh9ca4CjxsPOZVN/zNZZjU+s0rPGjC/Mw+5smKz/1bsHMsSB8nlRA1frapUfItInW0pp5+Jtrl/z6z5UepK27ijCd2Ha/9d9xbGr1Wvi5/mcMWGX+6EBeuNH+9bdqXimIWmIkzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635465; c=relaxed/simple;
	bh=1LlnXPMOM2/1Qii1gXAQ9XDxV4ppxfLGsHsPqQaPR0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA+Hc+WdOozCyhxzZxgIPglBzqupKpzv/wMX1JAfIMov2Fd1uXzPKlvXAZkSzLIXnhRK1pp+L7z5PrLN4BSh95yE+5eY8PXf0c2HwjBkIGmgs1Eygb4suQlbs1j1QsTzdVd4DAlEkQfERKyfnuwaX+XGBmxUDm7EnMVfTAxfPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMyhYD40; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMyhYD40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781635462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOxJ4DzGtqQGeQOmGQE8zNSw+nekEripNHk1o38LV6g=;
	b=SMyhYD40F6G7QcAP5++MAAELqgXPiAyEfIPVMr41/vMpCO7ZSz6+Ff2Y+DuSlnlAMyiSPa
	jPVFoCZrd3k0f9p+wBk9KfRQQOtnbZexv9mppgwWdBmnR9+Jb4WA0Dght7peLMYFGtpwmO
	EqO50wxKXn1ZIQvyBxGjsPCSCaa7VNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-7IHQ-Xp-OFm57Y-2HQTPnQ-1; Tue,
 16 Jun 2026 14:44:18 -0400
X-MC-Unique: 7IHQ-Xp-OFm57Y-2HQTPnQ-1
X-Mimecast-MFC-AGG-ID: 7IHQ-Xp-OFm57Y-2HQTPnQ_1781635457
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D10B71956053;
	Tue, 16 Jun 2026 18:44:16 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.115])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00BDB180056E;
	Tue, 16 Jun 2026 18:44:14 +0000 (UTC)
Date: Tue, 16 Jun 2026 14:44:11 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, song@kernel.org, live-patching@vger.kernel.org,
	Wardenjohn <zhangwarden@gmail.com>
Subject: Re: [PATCH v3 4/7] livepatch: Deprecate stack_order
Message-ID: <ajGZexm8Q6MbtA2r@redhat.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-5-laoar.shao@gmail.com>
 <ail-mQ77SQR7WkiM@pathway.suse.cz>
 <CALOAHbDgW_4fPktGHNnY-eqYRqg+d76EPTLgH-=twYOtwqA0vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDgW_4fPktGHNnY-eqYRqg+d76EPTLgH-=twYOtwqA0vQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jun 11, 2026 at 11:21:09AM +0800, Yafang Shao wrote:
> On Wed, Jun 10, 2026 at 11:11 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Sun 2026-06-07 21:16:56, Yafang Shao wrote:
> > > stack_order is no longer needed for atomic-replace livepatches, as a
> > > single function can only be modified by a unique replace_set.
> > > To maintain backward compatibility, print a dummy value, as suggested by
> > > sashiko-bot.
> >
> > I would personally remove it completely. I believe that there are
> > only few users around the world. And they will need to update
> > the tooling/strategy for the new "replace_set" anyway.
> 
> I will remove it completely in the next version.
> 

The kpatch-utility uses it (thanks for adding zhangwarden@gmail.com to
CC), but as I understand this patchset should effectively eliminate the
need for it (as per Wardenjohn's original use-case).  So I'd be in favor
of removing it from sysfs as Petr suggested.

--
Joe

