Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684746;
	b=1X4Kw+/y5szxMA8tB6TL4StuCAyL2oN8QYeZOWn5Z2bfcMIQj4SUUjHw+bBfNarwi05W
	 /g+g/ALSa8ziGvj6rDCZ9rRmagLnkPRpufb/GltiO6MfFu962SQyCCjha0RWgMyzxK18k
	 YdgzbXz1S5XYZ1Rb1pYjO19LYxF/TRZQtyQZRtt5tgVUyqMqqxQjsUrkG4hWzvtw75aLJ
	 56zeEzf2tFm2w/GBnm1JP0XQQZhAcpSenrm81VlJtTZ4BPIF6OWOS+yaPLtoy1esM2Wd9
	 af61n6VAcZhRLqqImFXMT9b/z+/3pjFrDzNSKWNkoynXCMohjElI8Wjgcx9PD3SbCdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hZMUDK8b1yvClCIF9+OTNq91IdHD+Okctj94fvLS0gk=;
	b=mEXOElBACsbJn+D/mWS8iEe+u7TXi36oVkPMaCLf3FSZyrqqbQpqYQ6u9zfdKr5Dztv/
	 +XVaYEVguNitSS2A5UG1YyDwZT5zn+vsKNvfarojE1dI5zi+mOlvzELnMjzmkjoORQLn5
	 FaBCzUMHsoZOp0SJa/WankIZkScT+ADlI3OCYdLtyJShDssLOeCYvuzR5sYQZ8T15Kl9W
	 wYp5r55fHpOoBdQKamD5STEO7+4Ifs0HTmdo/bouQID3VJJxbJ7/qS74rglWGNFIMJrJ4
	 9/bo2O/nmvYgEAc80HpzZO18Kra4DtTrVEw5TsK2DGRM0UqK3N4cRMkBY8WgocT4prA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JJC4QT1V;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C7606A319
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 15:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17C7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JJC4QT1V
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1443134f8f.1
        for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792684744; x=1793289544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hZMUDK8b1yvClCIF9+OTNq91IdHD+Okctj94fvLS0gk=;
        b=JJC4QT1VvXgNultHyqSKvnobr6eTYW4AU8Ex9RwneghXYoL3nr1NZHc+xLJv+Or+bu
         DE2mQSiJW4/DI0vGrLd9fTgFz19/+BGdfG5qjlhYExc7/ID/7+Y/mDvySh2iE5ZaUtDl
         eHXqu9Y400IiojnvUk68Y9iIJkEyZvatgxq6277s92bdcZUJCnjBvRT8ND1Ly2hzO5/c
         ajThllCmMIU5g13Ts9chRAuG/3BVUfFQ/WYfSf9S41/VhY1y3UHLmLoNR2lyue38+yiT
         As5Jm1Uw/p66BargJCphl8qrUvPzNYQhph7z3l0HoRemKvdgqZbRuTs+WRBopcblT1nB
         YHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684744; x=1793289544;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZMUDK8b1yvClCIF9+OTNq91IdHD+Okctj94fvLS0gk=;
        b=XCYfhl5SC16Wx96xcq46HP9dytn0lRMkjG8ZDmRjq6oXItzeZEIuJDtON2jLQlmnCB
         HLTpaByOapJ4qzvnCYNx1zPqL40psaHmj67YvzPCkrNZXwrykoYMNCQkQL4hlbVw6sB9
         d07obHWes/I9r4b+/BlSxvs2hKH+bjvaM6Pf3FU+i89xYbrAg//eMXzWczBCLGztas4Z
         utNl6gTzm89d84albv0EzgiGXzNN1F0ZWqTlohBIcoUoo+KbZd6OB3XdYqfLj1pLMdyj
         8Yw3Ou+TJ+CZ7rXnXcPoKdo+3qvuI+/O6bptI6qTMrQQ0MLuAmnk0vkleun8S5UHXH6g
         BqIw==
X-Forwarded-Encrypted: i=1; AKwUvBzGfPv0qzuAMfJIdJU4AVp1tD75uXtRHXMcXwX+BUVl6xH56tXrT/gIS5twuEXyogChjEnrS+nhY92SmdUD@vger.kernel.org
X-Gm-Message-State: AFq9FYIaK8NNlxtU89nb2iSUPwn5IAyxJT5ZVk68rhDUpVh+G37EBgfF
	yVXT0FbvODMJq8uxjitcX2es6rvtpVXoUbwDDnHx/+j6LfvQXWVPdN0whTVCAORchbY=
X-Gm-Gg: AYBFou1OUV2FrJznKk997k0ot3I94rJvLzPg2yW10/B2X4eqniw+3NMwn+2w4XgviA0
	OiR1AO6xZa8sHC/k3PJEpxrgg8xQdPP5x25bcjGBdk0Udn9WcBGHoaglKRf/BzisiyKzKxFFHjy
	Q0YwRpm0s07X5VLWFxjZ3mqg/3ZiQy8Cb+chJ8CSdtCrkx6C/dWyKfHaKh2Sep7pQHUkbgg2px2
	nBKHBmh8P1btUJ+4Sx53rC9yGk4AQe/eh+RwuxqPoqKeOruV5JqaeplgfE35QonNQGUc7rhfqxY
	TqqkG+/f1cvWkv/m2WetVpK6dexGWFp/1mEv64N6re4aCaAQhD7l3sUtNemG3kd3TihGNUDtPD7
	9pbkjcmHansqT7+xrfDRmuUqbbJ0hdCGv8HZ6VJ7OTJf8d779wBD7cxkejvr5KhPkeqqpWEjxhx
	nDKkmxPnH3hBOu50PrtvUUE+oaxgStQzNvAEwJokrHGRZ8XxtFTD4XPpYPKQ3Zn6dvW/0CWWG6P
	DQEi9gdlpr4nAf5GXEXHKhUmtjbCfS+JbpZXDc0TCto2Y4c0224eheNMRG9csbisshBMrcb
X-Received: by 2002:adf:efd2:0:b0:48a:efed:ac97 with SMTP id ffacd0b85a97d-48e264f06c6mr8640591f8f.33.1792684744491;
        Thu, 22 Oct 2026 08:59:04 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm12033197f8f.14.2026.10.22.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:59:04 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:59:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v12 9/9] selftests/livepatch: Add function test for
 provides/obsoletes
Message-ID: <atoyxoxWSVqZvHUE@pathway.suse.cz>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-10-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016053708.47089-10-laoar.shao@gmail.com>

On Fri 2026-10-16 13:37:08, Yafang Shao wrote:
> Livepatches with different provides ids must not modify the same
> function, unless they share the same provides id or the second
> livepatch obsoletes the first one.
> 
> Add test scenarios that verify this rule on the combination of
> patched functions and provides ids.
> 
> These tests are skipped on kernels that still support the legacy
> "replace" attribute.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Looks good to me and passes the selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
