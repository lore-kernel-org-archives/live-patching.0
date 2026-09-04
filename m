Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E743E48D
	for <live-patching@vger.kernel.org>; Fri,  4 Sep 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517607; cv=none; b=OUKQpLvDvbMe918rslez1Y8sVCXaEt2WzkmeBRNk5QnrQTh7WMqQOXyDOS+Z4joBVaz83J5iY3njpSIYoxpYF5uvtUFGlwvsnm0/Dei8n5qcoSDJZ0qAy+UinGHM28+e+s4nvtBPMyYo4Z4X/9pso+Fuc/ck41o6DmbQyt6katI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517607; c=relaxed/simple;
	bh=wzohwlBAoyl+rPZQ6GA5hqoQUxcvUXRIuzUKR+DKkpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8FPIpPHy+W5gw67/r07aWv4nucfiaDOCq8J2vCrP4i7KXx6WlN995PvnZAlRUynJbQ8GV1jtn8m15dSj1A0I8mzQrih+qmPyJ0w9kiaMS0p7BxVFs/ft9NEG8pYZ5Of2lwzG+A9c6VvDG+ACvsjCIa9HdGRcn2JLeTkjHM/7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XIhYQ9LZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XIhYQ9LZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so9023345e9.0
        for <live-patching@vger.kernel.org>; Fri, 04 Sep 2026 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788517603; x=1789122403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZEcZ868dSYcJDoVrt6bSieNB54bJy3X6WsPbW/gCJA=;
        b=XIhYQ9LZdoJBTAXL8q+idyGoIRcisr5zhVdIophQYYJV443NvC9gVgESCesmZOsyNP
         4wAcfpmdKtgJOtWsuXou6G+VdJ4NchUooki+0LP+PM3TeonTiy4AJEJ2NNkAj5L2U4FW
         Nox5KGnj7qQiiIksjJO3qWaY22HHkv/UVwXk1s3QhONFIPFT0abvi3awlqPVvt5gzz0U
         5n+r2PKT21GEx4EypKJrtyk+vph34AR8Q86V0QZ9rio/2zE7Kg1qDBnzsUSq+gKr6YsU
         3JMXUq2uMuwe8u3HpKcR947j1eKSXsHz0HrhW2ypw0wR/eBqpa+NlmI2F3cJsuhvWO51
         8NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788517603; x=1789122403;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZEcZ868dSYcJDoVrt6bSieNB54bJy3X6WsPbW/gCJA=;
        b=mS8CbOQfGyXodp7Z4ZDoKqeLk+8uziJrK7HmcRyA4i76QQVy+jTRyPM4/MI/FiozU3
         uIBAg+Z+8kgfEbmV+N0T2GINVtgfDz/Y8MGIJWT4f5ICES3sP9dlAZftNdbdKl4MGgwv
         6dhr0T90D69wz6/tHkYiHt+hle97IYOILll9wWmWvZkVfQXpb3SS8r0Hfjthm3dzBS2/
         cR/S2MJTi120fVjDyQcRpddN/+KTsbhgSMpSRRgS2zqLY01KecXUm+8z4k4a2lmPV7BP
         MVgBsHa0mbyeo5ZoFylYN/dfbPHcEo1BDmO2YF+sY1Wwz9LlvgiqhStREfk4y1yckRWt
         +DZw==
X-Forwarded-Encrypted: i=1; AKwUvBxpQ9zqWtQDVOWqtsf4q9Idu+xGsMpn4CscinFkrBk7Q2rAYJoet9uBFRx0lv1femjnCvOTOTffzPZLQ7zX@vger.kernel.org
X-Gm-Message-State: AFuF++k91gJByNBe9ojxG22g9uCElIVvHA2WNR87zuFrKtnjZ+yuiCQs
	M64Vq7QyarSQzNEZLMKqG65z03qbrgS5K4yi+4unyyElkst28jKDK/vRgYkQA1ZyIFo=
X-Gm-Gg: AYBFou0hy/YrSJYFVu2f1rZPeWkMZ0jbTFSRttKa07C/GRzJ+SYzA3Ox57jJFwoDQpu
	Jw+elF9vJfcM6psl0sAe2d5aljxmlE41+h6uxTQWa89xG8xfiR70Am+MDQO3flHrW/STLi86vAW
	NORoKk6nwyTYSu2abiAOzwAkcGOiPhtVo7DFDoUvruUoh//+/xYxnCtw3Fq0ZOK9Wiv71hbMNpF
	hWFN46KQTqIEhH8HJ8W+dGvcUjuX34nOFGhJKI5xMa8Wls68wnxj1E9s+2037Tfmw8PXeYsYS4B
	ThrbFsvb8MDfXQio51L2U4JPnyfFzHgrCmA3yf8pZkNARxLKeCR8WefiCK2ds8ijFyh1EefZ6eV
	F2PH/VPH9hThg+H7qUvyV9ffGXx6A/eoc3yF0GKKo+rt58F9qIgtH66dxCY1iEjHfl+UzUjuekP
	Cbel//baYSvT5thy/elj9IHEj7xIafDCWlzhmfTf2axoXvDKLWpeyodDrW0k4eLA==
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cf8267a36mr54039005e9.12.1788517603067;
        Fri, 04 Sep 2026 03:26:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm139607705e9.5.2026.09.04.03.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:26:42 -0700 (PDT)
Date: Fri, 4 Sep 2026 12:26:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v4 0/2] livepatch: Fix issues around
 CONFIG_DEBUG_KOBJECT_RELEASE
Message-ID: <apqc4J_Ti7iEgwhs@pathway.suse.cz>
References: <20260830054857.64758-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830054857.64758-1-laoar.shao@gmail.com>

On Sun 2026-08-30 13:48:55, Yafang Shao wrote:
> These fixes were found while implementing the replace set series [0].
> They are independent of that series and can be applied separately.
> 
> Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com [0]
> 
> Changes:
> v3->v4:
> - use "dmesg -r" instead of "dmesg --raw" (Joe)
> 
> v3: https://lore.kernel.org/live-patching/20260821031648.48195-1-laoar.shao@gmail.com/
> 
> v2->v3:
> - rename the subject
> - include the selftests patch
> - exclude the klp-build patch
> - use kobj->kref instead of introducing extra counter (Petr)
> 
> v2:
> https://lore.kernel.org/live-patching/20260816090442.18128-1-laoar.shao@gmail.com/
> https://lore.kernel.org/live-patching/20260818054629.69246-1-laoar.shao@gmail.com/
> 
> v1->v2:
> - minor improvements and acked-by (Song)
> - fix issues reported by sashiko
> 
> v1: https://lore.kernel.org/live-patching/20260813030408.9761-1-laoar.shao@gmail.com/
> 
> Yafang Shao (2):
>   livepatch: Fix UAF of unregistered patch kobjects
>   selftests/livepatch: filter debug messages in check_result()
> 
>  include/linux/livepatch.h                      |  4 ++++
>  kernel/livepatch/core.c                        | 10 ++++++++++
>  tools/testing/selftests/livepatch/functions.sh | 12 +++++++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)

JFYI, the patchset has been committed into livepatching.git,
branch for-7.4/kobject-release

Best Regards,
Petr
