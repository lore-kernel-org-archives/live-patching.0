Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF82D0292
	for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229089; cv=none; b=lFqfFnE9j9G4NSiVparuZ+5xsqoeMctu086opxgkqrS6Mj3HKfg6ehHqrGMnTZkDwkITacX95d0j9P0pcAtkc885CvKrjosrrhf7l5O2+YWfzrfgE0CtUJg/29KUNRQLwYXj+g1BAd+H/rb6Kquibx4fFDeMkjDVR9y4WoSmmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229089; c=relaxed/simple;
	bh=FCEzsIXBghS5pYM3SSh/7ZmMhDGxyAcjhXTJuUNCKV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atlURs5xlNEs5XO7nqaokr4QdDCK5VZt21YWrQ3bG4mLzZulhPlbrNcyUicIzQgOQ0qSXUpH47O6UIjeml9tb+2PstbqXTX5ECY034wRCfnqZGfm0SfJ8Gm8AXlkW4i1o4I65pR7U3nAj7o3OYN9KGgLnqiFmd1m/mCJxD+E1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fomPAoVH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nkyZ2BrR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fomPAoVH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nkyZ2BrR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782229087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zPPgBEZ3YVKIFnXxioyaHZ7uquM2rHxpd0BDcr0ttc4=;
	b=fomPAoVHtiUVYTtLn1XpalfI6O2jUoZl8Z7AH0m/rzZQXPChhQOYruVYidVFSP5FwUqakT
	H7hY5cySA37LjSSSEE15KJ5kzB0M5Z69siI1pub+IW9JfDbwBk74RNJFXLQaQCHyueQiN9
	+2zOSBZloydwcBYviDOEoUUsR6YpRjc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-BTFwmj1QN3qUmeX4om-dvQ-1; Tue, 23 Jun 2026 11:38:06 -0400
X-MC-Unique: BTFwmj1QN3qUmeX4om-dvQ-1
X-Mimecast-MFC-AGG-ID: BTFwmj1QN3qUmeX4om-dvQ_1782229086
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517e054fe07so135808191cf.1
        for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782229086; x=1782833886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zPPgBEZ3YVKIFnXxioyaHZ7uquM2rHxpd0BDcr0ttc4=;
        b=nkyZ2BrREYEzGiSglFc7259Om2qq8C3/VEzg1gXMb9w4AfeATld+H8Es0KJm27rn7e
         qvcVLFEHMk3+1zOyCoIA+/Dr/OxD+FwDkp9c35r953+D5ksN/YZXUQy47N0JkNDJ9H2F
         n5kdbfFmfBkVroIfoh6F57+irBMxLltV4rNHEORCF0CjNLqYJAbrTHXYJztGCQe7OVHX
         2Rz9yc8b8Hzy5ia5jbfFC4h+MXtxf7zDXNA+s9Kj+9JIcv1QgyNJiFyi8DZ5A0U7LbVN
         5bTrcSPmLBwNy58gmLKMYAWSTE8Lh07aDk8fTKq1NkpPEVZFVFkP0vbM2PkhYvx0QtRm
         U1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229086; x=1782833886;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPPgBEZ3YVKIFnXxioyaHZ7uquM2rHxpd0BDcr0ttc4=;
        b=Xde15m8jg8pyLv7LfEHGYym9+2K39t0Qpc+030JXWByY78+TlF0HIZIceQj8/pDTVF
         L74KEIUF02MUYEtPfwNIQSimamPondjjWVsEj6+xQxU7++mUNPaZHehZ/mRjhbDI3sTT
         Ad2ev/s4bqXsJJR55NV0/mXWkemfH2DsbBwWaza0WwIl2/Nc9ejQLRYvANoBIQbsNH2F
         XYHzRb8avHAfsOM4vwzmZ6cStR9mPuN4FSA3w1TrLa7ELyJa1fKfO21laZrxGqkZ5a6r
         aL3AGPwgo/Pr2AmQ5kYwsKwePWWOjtWXHmtFyqSbwLyvGK3J+NiCd2brqxVukjzw7V4D
         5fVg==
X-Forwarded-Encrypted: i=1; AFNElJ9WhmooJYs1hJIAqrLepcBQ14a+JI6rMK866SXRWKtSj7qlLWLpxOEy9LrLXHEFrL36pdlSWqLhmGXl1B8S@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+W4Eh01F6WnG8SiDSoi/p3kap/vlJrwLUFnhLTN0pnsiHs/Wt
	MduQzg+Vc6NOeYKTtLR1Y8ibYuv7+HpnAjbWRAQyqHaVi18iOqXKRhgVJxZkrtUxtX7Q7B/tOWf
	03zTzcKde/yKS8fLJzurtE2hFIO0tmys4wtQPugi/YwZJ0s/WNtdTjWPNo72aDr/WgNA=
X-Gm-Gg: AfdE7cna5/LYtPRgpQKOKJllJPJ27VEKhOMmK6p7Ngl0DoKBM/ejl8KyIqGunPzINuK
	LC+1DFHF0CEMwb9IRG23NEPgf/Edjowcrpd05yklDKITZ6pexOwVTST0cV6CXuc5wCIZu+gDhYQ
	QEu28o1567asPZUMAKVDTsYHXuXDeDQEHXDXtbh7ONt+K3y5TuCal7XqFmnLNpmjAeh5AxU3z60
	p1Dn+veAJv7kqRLXqlwHWrKeADpU482DIXv33lMUie6BxAGVErgVFqIQMMdGqyZtZYFpjBz33ev
	ZtOAGO7EDn7KrsGfCypp2QOTQI8r2TYqFgBDiGXTAXooytW9ovfyOm9WMyMqI8xOs6r572V4eE/
	Evhqfr1T/RxKqYghnizEkd19vItFNm29y0Dj/eJeFvYWE9Tqs1Gk4lmGTc8pE+qAiqbw=
X-Received: by 2002:a05:622a:15c8:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-51a561493b2mr42716471cf.37.1782229085677;
        Tue, 23 Jun 2026 08:38:05 -0700 (PDT)
X-Received: by 2002:a05:622a:15c8:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-51a561493b2mr42715871cf.37.1782229085085;
        Tue, 23 Jun 2026 08:38:05 -0700 (PDT)
Received: from [192.168.1.26] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51b07812sm25809881cf.28.2026.06.23.08.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:38:04 -0700 (PDT)
Message-ID: <89a92164-3c3d-481d-931e-d2990a8a92f6@redhat.com>
Date: Tue, 23 Jun 2026 11:38:03 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org,
 mbenes@suse.cz, song@kernel.org, live-patching@vger.kernel.org
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz> <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com> <ajKmm5GIkvRUlJ2c@pathway.suse.cz>
 <ajL-Y3dapC1FiAwx@redhat.com> <ajPsvHv4t3gyGOit@pathway.suse.cz>
 <ajlwY8K3l4N49eVS@redhat.com>
 <CALOAHbBVjTX76u18jMQb3R4H+4=ipT4ybfjxq6tBFQNF4ALNQg@mail.gmail.com>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 xsFNBFgTlmsBEADfrZirrMsj9Z9umoJ5p1rgOitLBABITvPO2x5eGBRfXbT306zr226bhfPj
 +SDlaeIRwKoQvY9ydB3Exq8bKObYZ+6/OAVIDPHBVlnZbysutSHsgdaGqTH9fgYhoJlUIApz
 suQL0MIRkPi0y+gABbH472f2dUceGpEuudIcGvpnNVTYxqwbWqsSsfT1DaAz9iBCeN+T/f/J
 5qOXyZT7lC6vLy07eGg0uBh9jQznhbfXPIev0losNe7HxvgaPaVQ+BS9Q8NF8qpvbgpO+vWQ
 ZD5+tRJ5t85InNiWR3bv01GcGXEjEVTnExYypajVuHxumqJeqGNeWvx26cfNRQJQxVQNV7Gz
 iyAmJO7UulyWQiJqHZPcXAfoWyeKKAJ37YIYfE3k+rm6ekIwSgc9Lacf+KBfESNooU1LnwoQ
 ok9Q6R5r7wqnhCziqXHfyN2YGhm0Wx4s7s6xIVrx3C5K0LjXBisjAthG/hbPhJvsCz5rTOmP
 jkr+GSwBy2XUdOmtgq1IheBFwvWf08vrzNRCqz3iI1CvRpz0ZYBazmkz924u4ul6W7JuCdgy
 qW3UDLA77XlzFrA7nJ6rb77aZF7LJlkahX7lMaKZUzH+K4aVKTdvZ3szm9K+v0iixsM0TEnz
 oWsZgrkAA0OX2lpLfXvskoujQ84lY989IF+nUwy0wRMJPeqNxwARAQABzSZKb2UgTGF3cmVu
 Y2UgPGpvZS5sYXdyZW5jZUByZWRoYXQuY29tPsLBlgQTAQgAQAIbAwcLCQgHAwIBBhUIAgkK
 CwQWAgMBAh4BAheAFiEEXzkJ3py1AClxRoHJx96nQticmuUFAmF2uf8FCRLJJRQACgkQx96n
 QticmuU69A/9FB5eF5kc392ifa/G6/m8q5BKVUXBMWy/RcRaEVUwl9lulJd99tkZT5KwwdIU
 eYSpmT4SXrMzHj3mWe8RcFT9S39RvmZA6UKQkt9mJ+dvUVyDW1pqAB+S6+AEJyzw9AoVPSIG
 WcHTCHdJZfZOMmFjDyduww7n94qXLO0oRMhjvR9vUqfBgEBSLzRSK96HI38brAcj33Q3lCkf
 8uNLEAHVxN57bsNXxMYKo/i7ojFNCOyFEdPCWUMSF+M0D9ScXZRZCwbx0369yPSoNDgSIS8k
 iC/hbP2YMqaqYjxuoBzTTFuIS60glJu61RNealNjzvdlVz3RnNvD4yKz2JUsEsNGEGi4dRy7
 tvULj0njbwdvxV/gRnKboWhXVmlvB1qSfimSNkkoCJHXCApOdW0Og5Wyi+Ia6Qym3h0hwG0r
 r+w8USCn4Mj5tBcRqJKITm92IbJ73RiJ76TVJksC0yEfbLd6x1u6ifNQh5Q7xMYk0t4VF6bR
 56GG+3v1ci1bwwY5g1qfr7COU7in2ZOxhEpHtdt08MDSDFB3But4ko8zYqywP4sxxrJFzIdq
 7Kv8a2FsLElJ3xG7jM260sWJfgZNI5fD0anbrzn9Pe1hShZY+4LXVJR/k3H01FkU9jWan0G/
 8vF04bVKng8ZUBBT/6OYoNQHzQ9z++h5ywgMTITy5EK+HhnOwU0EWBOWawEQALxzFFomZI1s
 4i0a6ZUn4eQ6Eh2vBTZnMR2vmgGGPZNZdd1Ww62VnpZamDKFddMAQySNuBG1ApgjlFcpX0kV
 zm8PCi8XvUo0O7LHPKUkOpPM1NJKE1E3n5KqVbcTIftdTu3E/87lwBfEWBHIC+2K6K4GwSLX
 AMZvFnwqkdyxm9v0UiMSg87Xtf2kXYnqkR5duFudMrY1Wb56UU22mpZmPZ3IUzjV7YTC9Oul
 DYjkWI+2IN+NS8DXvLW8Dv4ursCiP7TywkxaslVT8z1kqtTUFPjH10aThjsXB5y/uISlj7av
 EJEmj2Cbt14ps6YOdCT8QOzXcrrBbH2YtKp2PwA3G3hyEsCFdyal8/9h0IBgvRFNilcCxxzq
 3gVtrYljN1IcXmx87fbkV8uqNuk+FxR/dK1zgjsGPtuWg1Dj/TrcLst7S+5VdEq87MXahQAE
 O5qqPjsh3oqW2LtqfXGSQwp7+HRQxRyNdZBTOvhG0sys4GLlyKkqAR+5c6K3Qxh3YGuA77Qb
 1vGLwQPfGaUo3soUWVWRfBw8Ugn1ffFbZQnhAs2jwQy3CILhSkBgLSWtNEn80BL/PMAzsh27
 msvNMMwVj/M1R9qdk+PcuEJXvjqQA4x/F9ly/eLeiIvspILXQ5LodsITI1lBN2hQSbFFYECy
 a4KuPkYHPZ3uhcfB0+KroLRxABEBAAHCwXwEGAEIACYCGwwWIQRfOQnenLUAKXFGgcnH3qdC
 2Jya5QUCYXa52AUJEskk7QAKCRDH3qdC2Jya5awND/9d9YntR015FVdn910u++9v64fchT+m
 LqD+WL24hTUMOKUzAVxq+3MLN4XRIcig4vnLmZ2sZ7VXstsukBCNGdm8y7Y8V1tXqeor82IY
 aPzfFhcTtMWOvrb3/CbwxHWM0VRHWEjR7UXG0tKt2Sen0e9CviScU/mbPHAYsQDkkbkNFmaV
 KJjtiVlTaIwq/agLZUOTzvcdTYD5QujvfnrcqSaBdSn1+LH3af5T7lANU6L6kYMBKO+40vvk
 r5w5pyr1AmFU0LCckT2sNeXQwZ7jR8k/7n0OkK3/bNQMlLx3lukVZ1fjKrB79b6CJUpvTUfg
 9uxxRFUmO+cWAjd9vOHT1Y9pgTIAELucjmlmoiMSGpbhdE8HNesdtuTEgZotpT1Q2qY7KV5y
 46tK1tjphUw8Ln5dEJpNv6wFYFKpnKsiiHgWAaOuWkpHWScKfNHwdbXOw7kvIOrHV0euKhFa
 0j0S2Arb+WjjMSJQ7WpC9rzkq1kcpUtdWnKUC24WyZdZ1ZUX2dW2AAmTI1hFtHw42skGRCXO
 zOpdA5nOdOrGzIu0D9IQD4+npnpSIL5IW9pwZMkkgoD47pdeekzG/xmnvU7CF6iDBzwuG3CC
 FPtyZxmwRVoS/YeBgzoyEDTwUJDzNGrkkNKnaUbDpg4TLRSCUUhmDUguj0QCa4n8kYoaAw9S
 pNzsRQ==
In-Reply-To: <CALOAHbBVjTX76u18jMQb3R4H+4=ipT4ybfjxq6tBFQNF4ALNQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/22/26 11:08 PM, Yafang Shao wrote:
> On Tue, Jun 23, 2026 at 1:27 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>>
>> On Thu, Jun 18, 2026 at 03:03:56PM +0200, Petr Mladek wrote:
>>> On Wed 2026-06-17 16:06:59, Joe Lawrence wrote:
>>>> On Wed, Jun 17, 2026 at 03:52:27PM +0200, Petr Mladek wrote:
>>>>> On Tue 2026-06-16 16:15:17, Joe Lawrence wrote:
>>>>
>>>> [ ... snip ... ]
>>>>
>>>> I can read replace_sets two ways:
>>>>
>>>>   1. Positional: { set [, eviction_set ...] } where the first element is
>>>>      the patch's own set and the rest are evicted on load.
>>>>
>>>>   2. Flat: the patch belongs to every listed set equally.  But then how
>>>>      could klp-2b load into set 2 without replacing the entire
>>>>      cumulative klp-2a that also occupies it?
>>>
>>> I understand it a 3rd way (similar to Yafang?) ;-)
>>>
>>>       3. Set: the patch replaces the given set of replace_sets.
>>>        Where klp-2a is a cumulative livepatch for two
>>>        replace_sets: 1,2. And klp-2b hotfix would need to
>>>        use a new replace_set, .e.g. 3.
>>>
>>>        I see "replace_set" as a set of modifications (functions,
>>>        shadow variables, and callbacks) which is supposed to
>>>        replace/update/downgrade the same "replace_set".
>>>
>>> It would have the following consequences:
>>> -----------------------------------------
>>>
>>> First, any newer cumulative livepatch would need to replace all
>>> older hotfixes. Let's extend your example:
>>>
>>>    Wed: klp-1a: cumulative    (replace_sets={1})
>>>    Thu: klp-1b: hotfix        (replace_sets={2})     <- coexists with klp-1a
>>>    Fri: klp-1c: hotfix v2     (replace_sets={2})     <- replaces klp-1b (same set)
>>>    Mon: klp-2a: cumulative    (replace_sets={1,2})   <- replaces klp-1a AND wipes klp-1c
>>>    Tue: klp-2b: hotfix        (replace_sets={3})     <- coexists with klp-2a
>>>    Fri: klp-3a: cumulative    (replace_sets={1,2,3}) <- replaces klp-2a AND wipes klp-2b
>>>    Fri: klp-4a: cumulative    (replace_sets={1,2,3}) <- replaces klp-3a
>>>    Fri: klp-5a: cumulative    (replace_sets={1,2,3}) <- replaces klp-4a
>>>
>>
>> This is making sense so far: hotfixes introduce new replace_set(s),
>> subsequent cumulatives replace all sets that came before it.
>>
>> Quick question for you or Yafang based on his thoughts on my other reply:
>>
>>> [Yafang] I support the flat mode approach. The hotfix should be assigned to a
>>> set that is not currently in use — for example, klp-2a should select a
>>> new set like set 3. The core design idea is to set replace_set
>>> dynamically. To determine which sets are already occupied, a
>>> user-space script can inspect /sys/kernel/livepatch/*/replace_set.
>>
>> How would Petr's 3rd way handle such dynamic replace_set enumeration?
>> Using the extended example above, without considering user patches, a
>> vendor could hardcode the replace_sets values at build time as shown.
>>
>> However, if a user patch has already occupied say, replace_set 3, then
>> klp-2b would need to skip over 3 and set replace_sets=4.  But then when
>> the next cumulative patch, klp-3a, loads, how does it know that it
>> should replace_sets=1,2,4 and leave 3 alone?
> 
>   Wed: klp-1a: cumulative    (replace_sets={1})
>   Thu: klp-1b: hotfix        (replace_sets={2})     <- coexists with klp-1a
>   Fri: klp-1c: hotfix v2     (replace_sets={2})     <- replaces klp-1b
> (same set)
>   Mon: klp-2a: cumulative    (replace_sets={1,2})   <- replaces klp-1a
> AND wipes klp-1c
>   Mon: klp-user: cumulative (replace_sets={3})  <- coexists with klp-2a
>   Tue: klp-2b: hotfix        (replace_sets={4})    <- choose an unused id
>   Wed: klp-3a: cumulative
> 
> When loading klp-3a, the user can inspect the currently active set IDs
> by checking /sys/kernel/livepatch/klp-2a/replace_set and
> /sys/kernel/livepatch/klp-2b/replace_set, then dynamically configure
> replace_sets to {1, 2, 4} accordingly.
> 

Ok, so the kernel only provides set ID information and userspace gets to
manage how it interacts (or not) with that.

A livepatch loading script could know to look for
/sys/kernel/livepatch/distro-*/replace_set to figure out it's previous
dynamically set IDs.  Local livepatches the same.  This would even allow
for groups of sets (vendor, customer1, customer2, etc.) if someone
wanted to complicate matters.

> However,  I don't have a strong opinion on this. If you both prefer
> the positional mode, I'm happy to implement it that way.
> 
We'll see what the others think.  To catch up with the thread, I'm
trying to run through these thought experiments to see how they play
out. :)

-- 
Joe

