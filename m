Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB74BB5B9
	for <live-patching@vger.kernel.org>; Fri,  9 Oct 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546423; cv=none; b=W43KmD6n2U/sdoeZivGrajqSwWve9Y5KNcYEkRiLBpFmPCiXlQBpgR9tDkVjedZ8LNvj9klH5CQNKt6Gwj5ELGLnEaw7U4x/nPFBu1U5IKGo/eM+mV4eZ0MqcyHQCF7iFV09TfvAViC0bwfOauCK9Nsh0u0f1VIcllfEmkcHz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546423; c=relaxed/simple;
	bh=IVCKVbEUcLS6uXPYQpovFjkXZXV759lJmuP62f1FnX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQN/D/Baq2F9WALgetHIsLu5HhYux8QiCLxxYFwhAEw2i0kQy5V/7QR/9fNh4HKlaPt6koOy90ievHN+zLjHi3uXmxvV0nS58XAS56AE4DNI8M/9W+/ztVr3A67LpZxS+sHh/eLGNiLVBUDNBo0WuKZLjiECYsiPyHsJimlk5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WdD9BS5H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WdD9BS5H"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so27452585e9.1
        for <live-patching@vger.kernel.org>; Fri, 09 Oct 2026 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791546414; x=1792151214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=STdRsGIwUtyFS5Y4KAwVFy5TWYLPZp6VD6PMx7VSdb4=;
        b=WdD9BS5HMT2O7kpAfub/PxBHH1fAHTlMbM03AkmKBjmvXvjCaWJPGZbxy151/yeSMh
         yOOgzEXk0JoLuI2z83ZNANVShgrG+Q8ytIzVMIx46bgSwcxNkEcpq8lYAxhxlIAJ4ns7
         IKkujGotRIhp0KMHzpAFDw2mADWWcSWtN1EXqcUpuzrJTk++kXSK6scyGlUf0g9qHQST
         sBqby4Vjznl2DZGxbxaCxwUMviHB5z+RaxoKOuuOmfhbfnJbtDbmQg2F6STbvcXjIAS8
         xrNrw24MlGJ1VZHAhy5YFTYQ54YK3TlV8cQDC+CtJSVZUWnLto8Vwg6xBE0VRLqOt2iP
         wdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546414; x=1792151214;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STdRsGIwUtyFS5Y4KAwVFy5TWYLPZp6VD6PMx7VSdb4=;
        b=P77wpre9mXpP3GjiQkE9gHoW3evqE7ihN7lS9mKfx91fHQMHk8DPVaC0XHz10ambCF
         sWfagvVHmJrKIMRW1s1C6dZXdgfb8ECvOGZ9RskZpSoPMGN6mRVEUP9wWSSpx1ONfbVC
         Y+Cqrvw/mjFr1cJdqXreadYo+Hdro+ZRANx2k8ZxIZxShFG0w0SwDSDySTNKCGX3HJgC
         nEGf5rstPTxpRU1pbrcTg642RhI0nbJiaHS5oV1yJeFMr9XA96VHnNiV2czI667Cd/v6
         iyIXBm3PoZsGAmLTcueBiuUMyXDIylmtnXWq0tvJfV1YCUC3aEZBQsXzjZ0HQUqrOdgb
         nhmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP5BbPKlRXQe2FdJpq6pO90daCRKHsNlT9aUHI5Wpwjvkv6+uzIxUN+ORI3MyrzaPFyTsICWDO6jFfzrQU@vger.kernel.org
X-Gm-Message-State: AFuF++mXnE2EbuGVCI37+q/GsQjJhuZm9DR0Dsn2voeIX6TlYqhaHe8A
	2A0QRC3Cc4vMigM6XBeWYiLrZ8R+b3p/8y76TJF3fiq85z3IflHOAkOWViSL+AViv4w=
X-Gm-Gg: AYBFou1ndV41PrTSoknC4VDC7FNRoedXQ3qmzOul/cTXok6u1xNq7PNLxTzTZ12Glt3
	++3B5qZdho0LnY+jsURks7V0B+PlGYZTumSEZ9n0aP7EKGmvQvC2Q3xfImWbQumDzCSSmJKUEzY
	sa9AiFP0sU53jDuSMN27HvoxBMVFK8BS1cgLIrX4NHrFvmSPXt9hmEcyZSS+etUw6xHfDB1x3sh
	o643+N+moApvvCZtUUVSlaZLPhqZg8DVjAUkPmwMuDKu9Eu8KAoPoxAE41hkPkD8TL5j3kRENIH
	0if99KF/8PXJEvy+UF+eIXBfKDNIeoOKh1NAFbVCH5VRlz3YcuwQKXrvt5VVCPwhEpXO2zjeJ9H
	u6/TSvrlVpSvxv19GCvLnXxJbwScB0FoSsgWGpN7sUkCcIujv/a1hm5q+fsbkuiKQZx9Q6ixqh7
	UecyNV6ifouX+IJqBySq/tMis50RK8Km+RYeOlUgHtzzszQWj249YFsNIK3xHFRztes9w0/RBS
X-Received: by 2002:a05:600c:6097:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a18e4b8885mr30783615e9.31.1791546414300;
        Fri, 09 Oct 2026 04:46:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beacd2csm58862025e9.14.2026.10.09.04.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:46:53 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:46:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org
Subject: Re: [PATCH] livepatch: remove myself from MAINTAINERS
Message-ID: <asjULDxLNwpcKyE6@pathway.suse.cz>
References: <6pq4rr41-0p23-2oq5-o750-0259410q9680@xreary.bet>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
In-Reply-To: <6pq4rr41-0p23-2oq5-o750-0259410q9680@xreary.bet>

On Thu 2026-10-08 17:19:24, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.com>
> 
> As discussed at LPC 2026 with Josh -- I am not an active kernel 
> livepatching maintainer any more, so let's properly reflect that.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.com>

Jiri,

thanks a lot for all your contributions, especially for being one of
the authors of the original idea and design. And thanks a lot for
giving me the chance to start learning kernel development on this
project and guiding me on the way.

I have committed the patch into livepatching.git,
branch for-7.4/trivial.

Best Regards,
Petr
