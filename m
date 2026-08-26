Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F94356772
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731018; cv=none; b=aPoUFM28WSgsM0E5+RWAEVsUYRfRAr3/FC0SNPpzVkGzXsSb1pfGswkz5m0t+SulUycVZPW6AvH5En81QfaPkaRkvTJx7EocodSk7Tpq+0blek+B2EmuUD2prYPdT84kUg0jf8b0PEKVNl5wFCoLaDg7yAqIBT/WJ+gAZzFsAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731018; c=relaxed/simple;
	bh=l3WNqDbSK+ktPbtq9y22hnhnIng1jno0kvlrUGxeUaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A08oCNdh8RrC4Kl/Coqhs42W9ZEvjq/6Dw9+K3gvlez+4qdRnc3MduG5O4LcKecnzNr/Eli8icEIHkVTsSFD7S4v66DogZbD21AgPNaVpTOEAkyvpSBHL56RIWnBfUxWtNgda5ENbpWtlvRF9iZFWewPD/gLNrD+Eg2kyJ2HHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T4RZ1bTS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T4RZ1bTS"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so1024922a12.3
        for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787731015; x=1788335815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=485pF73zaU7Lwk8dBsGA5o5YRskUF4VTA6WqqJE8Cy0=;
        b=T4RZ1bTSXcHqiXNQF4jc0C9/HoQdipb6GXSkENPrs6alNj4C6O7iQeGRZBX8ZWquUo
         YIBdXqukYOjGN+JT63TdhQPzu0t48h+sehO7d4zQquY/gICjKvESG+UCy9sQvnWzVQnP
         6XpfRN30xVz8bANJBGIa4YbXhnSyaPap6VAaW6bZeob0/F1lXUQqkdB007cGdULd3l0b
         A7z+JHfd6SRddhF/P67svEobUcdQ2UbsvA6ntmosm1I7dnvtlpgY56nJXInTTcbwoliL
         nnf5Qzksp4cHBtxvYmxw7OQ14jsLbUexWJ1F4jjE2BOAbrpTHuvN9EMgkmRc67n3+rJm
         7+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731015; x=1788335815;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=485pF73zaU7Lwk8dBsGA5o5YRskUF4VTA6WqqJE8Cy0=;
        b=mUD8Sd697G160cn+SqVAHeXQK9N+VOCZ2IE1YxyafZG7B3XiGFS1eOezTbn8oyQ8cX
         BMFmHkOQOnjZvqL+rw0Nd/C4HhO22hmxywSm7kTHrBrELuPdoMXB4vLNjcUa9G7g/I0S
         QbmBIySvPHIsWV/HdTiJAjp1oIDrkkZgvLKZ3pynI8GZDT3aH3XlKEHa8EGvRBMfB9Ns
         jVebHOFGfLdbvRhMVekIWjsRkMWIu2ph7hEXZE8XTbpCNQ1SKoYh/cwhOgoKhW2w1gkX
         Z9rUnS3AAjwdwSljnNJUXPxUDqpmelHQm3ou3QoUgGcXEHArsWTobve65zejobyLG16H
         Zv6g==
X-Forwarded-Encrypted: i=1; AHgh+Ro4GFXMeFh+NioHs38WDMcRhjT5V58hAMFipMphzw2R3r7DK9IPPkfkNWFQuV8ZZoJwdaFIFopFUPRZNcqC@vger.kernel.org
X-Gm-Message-State: AFuF++lBmjtzhQ9ig/kwQPI/G+v6Iyazn8jiM32mO55FEvXX/6UQcc5E
	XKG37CS+I8CFwI/XVxqFs+kTrx/6x363XdExRLhAEUlOso4fmAY0kL9Ycuc7/5Ofm6g=
X-Gm-Gg: AR+sD10oaKikdwNHRcR+s2TO420uj7eCG37NhhEzxThF31fumfpcCFa7dTZawHnMZvj
	k0eYydn7HJkRvpkqZwUQKd0xoPxe11DOWtm6BAIqwqj9YJTIMrkE2zpoRU1q1el2ZOw5XsVbK/2
	ZcmEfZ0O5t4yYI5Z8M9PKD92/MuVDkWxS+9sK+oifuQebSt9EfvPtzHSW5op9hV3eveg1UQT6xF
	93HxOxl3wISj6cbbAMCamaAr16Wmn6Zh+qj8Y/Rujeua2fZlQxFcAVVYVjIjUTyKQa1jDr87Ndk
	jUO9BPlZmyyZIe4+MPSyhUs/odF+3gk5PlBRsoSF26AcV+Qq+CF+Pmd/CeFraQKZ6N5P+nC7eEF
	XDuONDuQQf4d7FKuYNti0OCVD+PbLALaLKqYXAbuRDOgM5hkS3+7yJMnBfNUXE6T5hZ00NhbRMT
	beglqnC9BLpN7vlqqur3tyczJ9z7G3oOh9LOzdWE5vfh1KN9Azs/9DfbLy8m7O4g==
X-Received: by 2002:a05:6402:e08:b0:6a5:c4ae:43d4 with SMTP id 4fb4d7f45d1cf-6a5df5e1cedmr6861004a12.3.1787731015148;
        Wed, 26 Aug 2026 00:56:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8d1afcsm4477812a12.8.2026.08.26.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:56:54 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:56:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 0/2] livepatch: Fix issues around
 CONFIG_DEBUG_KOBJECT_RELEASE
Message-ID: <ao6cRUziIaQUNDD0@pathway.suse.cz>
References: <20260821031648.48195-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821031648.48195-1-laoar.shao@gmail.com>

On Fri 2026-08-21 11:16:46, Yafang Shao wrote:
> These fixes were found while implementing the replace set series [0].
> They are independent of that series and can be applied separately.
> 
> Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com [0]
> 
> Changes:
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

The series looks ready for linux-next. I am going to wait
one week for more potential review. Then I would push it
if nobody complained in the meantime.

Best Regards,
Petr
