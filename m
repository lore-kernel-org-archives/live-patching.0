Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C837F006;
	Thu, 27 Aug 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870981; cv=none; b=mQPRs/1mLYYK7lLCznypWHkKJ2Q3Tm7x+4TrPGaUYYhoSasX0VaqmUeiqoiAkGS20zPnxUUCbJ7YBLum2FUpfJI+fQlPCpTvaegxLjIAogH994cvvopLjaD713hJwPuE05N/a2ZrCkxXCXdtQZE2Sl3YqkVlvjOUTUMLEUCXkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870981; c=relaxed/simple;
	bh=AsAJimASckofigolyEI58UqX0qWhCl6ynCHTgiBJiZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKKe7wO6PQhUGrgDXhCCi8leFZuNtJgWTehEtUqOqucR0AQdUK2cXap61QEyvp3x4ZKd96nAxvLAoqmuirgjt2xbkCl1qoiWEJ2wA/yChiHZpIJrNVNBaEHxqaJFRabCwHctGk9LaFZeBY3u7SEGXBMdbozJBfDUPy9hOD81DTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7owyRTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7owyRTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08251F000E9;
	Thu, 27 Aug 2026 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787870979;
	bh=68syJxZkjpSLZN3n1r5s9zsJAZnVmmg6kz4DLqjyf/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O7owyRTYg/3Ns9qDNGKlo4sy57A+oQ40gBWUwI+dXh1iTNmReTjVuNOWn5C/KQDcL
	 uUePHTDmOY1ZaKlRGsEcTu65xIcQux8oJ7RlKQfG+YF3ohizk+ZvPO9qpKZYmAgfm/
	 rhXOCKKyU00QJdNjfcUArs1T4+Gw0L2H5sEW86bPA93ybUPQC0RO0xJTHK1r2KOlun
	 kQtoh8cIBoRyEd/P1EhdrltF9pz4rgh/yq1v23teYyUlnHs8xBfD4YEdCiZx8M/DnP
	 CQzVXEbLYTumFuITITX8XZGGpIImr9N8IhwojJkLDrnojUTYdhWoSDMmYFCcUQMtjp
	 PP2YbEfUqHLFw==
Date: Thu, 27 Aug 2026 15:49:37 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Shihao Ren <rsh15355756202@163.com>, pmladek@suse.com, 
	jikos@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch/klp-build: Fix wrong index in error cleanup
 loop
Message-ID: <apC-XG-jCLJHvcil@jpoimboe>
References: <20260701060655.2343093-1-rsh15355756202@163.com>
 <akYnGv_tDPouw8nM@pathway.suse.cz>
 <alpine.LSU.2.21.2608241541220.17149@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2608241541220.17149@pobox.suse.cz>

On Mon, Aug 24, 2026 at 03:42:46PM +0200, Miroslav Benes wrote:
> On Thu, 2 Jul 2026, Petr Mladek wrote:
> 
> > On Wed 2026-07-01 14:06:55, Shihao Ren wrote:
> > > In the funcs allocation failure path, the cleanup loop iterates with
> > > 'j' but frees objs[i].funcs, which uses the outer loop index 'i'
> > > instead of the loop variable 'j'. As a result the just-failed (NULL)
> > > entry is freed repeatedly, while the funcs buffers already allocated
> > > for objs[0..i-1] are leaked.
> > > 
> > > Use objs[j].funcs so the previously allocated entries are correctly
> > > released.
> > > 
> > > Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
> > > Signed-off-by: Shihao Ren <rsh15355756202@163.com>
> > 
> > Great catch!
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > I assume that Josh would take this together with other klp-build
> > related changes.
> 
> I do not see it merged yet. Josh, could you take it, please?

Sorry, I missed seeing this one, but I do have an identical patch
already queued:

  https://lore.kernel.org/aocdq0hr_iQTimG0@jpoimboe

-- 
Josh
