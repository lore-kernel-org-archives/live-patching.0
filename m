Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183653B0586
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776024; cv=none; b=dRqE35uj09eUX/jR3T7+xDAqZbIKDhfkp7AEvfxm61kTNTVEH0M6OOUsDWgf2VZr/iOs2Jhks2O2AvCa9jXgPRVMWc78qiWFtpcO/utm+MpZlae8jMg9kEv+PrgxpDCpFlPYtCyvOI4NSOlfFolwQR4d2TzUwo3UN+7WaO4IkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776024; c=relaxed/simple;
	bh=aboO16Pb92q3RDX3ECE9BIam7ioBc7qZR/BD6b8/V4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4xv6ycHpJoTDLvSBtahgyWd8Im0X9OTJzPrUBRRbwEnjx3j44yDor0QGkiUQGMC/wR9xEBL47+YuWFfaxMRcDdpfie/gmZlr0x5u6NR6Wd+vRbZGK5FW+lj7RUdjce4dVhvPuthBZXb+cL79quWzobLOuNHmtbWmmoTKsRVGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfuroAHJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AODSiNIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfuroAHJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AODSiNIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787776021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQ1iqkKDirGZtAdROMCq1IisiGJOSwZHVS/ME5WAJVA=;
	b=DfuroAHJOvvFGkKKCNgkolclmKnX6LCOvPF29latw3TwVJM/BYKWac/ualqhCmIsQnsQhD
	nVhkLSyIebdHScJn9MQWdWVP4CRZOpVCwz4KuvYGmsA5AirM86AStLfCygR/LOGDhZGnfr
	qwreUN6tp4epyaQBHjw6jyEa6NrxEKM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-LzbgOqz0OHCkPURdDWFYIQ-1; Wed, 26 Aug 2026 16:27:00 -0400
X-MC-Unique: LzbgOqz0OHCkPURdDWFYIQ-1
X-Mimecast-MFC-AGG-ID: LzbgOqz0OHCkPURdDWFYIQ_1787776020
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930b571432fso31274485a.0
        for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787776020; x=1788380820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQ1iqkKDirGZtAdROMCq1IisiGJOSwZHVS/ME5WAJVA=;
        b=AODSiNISsJB+GJKKfMKaUvuGMfVTK6aSZcmTypIYAzpPpxN6VG9vSWqyWv1voNK792
         LP0ukWbyms8xhByr6ugPCbXsD/DURpm6ik4z69F6b2N6jmf2oZNH7BWVjuKuDBiQv0i3
         LEMU9ABo4hl0wfWS4NnojSN5gB87FSdCiwbu8p0OYV5z8mac4dq2ebzIWunWE7jI+GIm
         RiC03BTWSgr2cqIrkyYuxtT//T9N9iJTxZmr28wjeXJy+rkG823BFJdBsQSbEgLxLPAM
         O/TQvXzovG0ooHaxfTBZNnsdEg+hSScq8zFZq6WTQd8BpuHPMLPV3OosJ3Kd9JJNU8w5
         qVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776020; x=1788380820;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQ1iqkKDirGZtAdROMCq1IisiGJOSwZHVS/ME5WAJVA=;
        b=OXfK8SZRaepF/8hFk8PVm7FQYLRfN+3YX3JLYiDY16xPEAnag5QxMZvpsHYUeQmKJn
         hYsHbr8Xli8YHBaUYk3cooHKGRidsTumy0qCXoa9CnpORCkb2khZI+ZsaIUkNT3vrQtU
         k6sjcK2cI0O5/VFhNmNLYMfLtRWq6+1nH5V/bXM6XOrZqFbJoeWxlGu3T9W7la4e5+AT
         77zB/8zHWeYLfwprqTM3EF8auSUcGd9qZt/inHIUxkp2LbDrJ6oeCFWrYFJ+dWDcl14k
         Q1Z9Vit/ZpbRdcauxlStV8sXOHx/xYitgIK35kUXh0prOfu5kK0CvGYoOphsc4EHzySh
         WvjA==
X-Forwarded-Encrypted: i=1; AHgh+RoKSoseQgPjTQS30aB321oamXpV4QMKpegAX5sMhD60M8EOtSRqqmmc+Hw7V7Ut6iU0oDQhikVfl5g/88eT@vger.kernel.org
X-Gm-Message-State: AFuF++nmD1fIoyCA9kiibKCeaPK80kgZoCPOW8gg3dtciVRQlJFUXBoe
	7OoDBBwaDGFPc63O+V+5d/lOg6Z2sK3FVcAzR0p+muKxnp2c3G2Qr0v3J2AwjzkFEyjAxhYYW1S
	ifW6TB3CEs8u3XUF/WESAyg/ir8fwO9mpaemyhYg43CaLC4w0mE1UQ/g7Ogn5fPepbJg=
X-Gm-Gg: AR+sD12rMv6uMXTyZMoDKdhA1VLPxcGbHkoz4b5X7A1lGdAT+OiJvhCbZC7xfitchUk
	iYb9xQ0ZCCa3TaRePhFzPMOgN+GbNuFy9LOhHDiT3OLalmWYonQ+9f3WVysUM4nFuf7MZVYBE2E
	29tAGtRSiuyhwMEQYGk2ETocgwrI2fevQAVa0tNRtTL2rOBwZtZhy11gt9McMjYj+IjPpOoy9HU
	/85WEcFCmY/aCUyd7BFjS0GA85DH/tTwKLceIUqVMaPWXefmxvVQaMPrypTtFOuKd53TeQKeMos
	H/2IbO1T4utyb+6kEjZViOurSe/0o5lGFGte832YEfBPuE+e/cXyGpD2g+0zQIRQ+hUshlPI/Nf
	m7NNg3KFwZ6nAY4nSH8eumr9HGAz5oMiW4hljr9TkyyKWr87ieR5hSiUJ
X-Received: by 2002:a05:620a:45a0:b0:936:9253:897a with SMTP id af79cd13be357-939001a9769mr208558185a.9.1787776019661;
        Wed, 26 Aug 2026 13:26:59 -0700 (PDT)
X-Received: by 2002:a05:620a:45a0:b0:936:9253:897a with SMTP id af79cd13be357-939001a9769mr208551385a.9.1787776019107;
        Wed, 26 Aug 2026 13:26:59 -0700 (PDT)
Received: from [192.168.1.26] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e616605sm295795885a.29.2026.08.26.13.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 13:26:58 -0700 (PDT)
Message-ID: <fb7ed056-00d9-4484-9cb6-159cba97eb75@redhat.com>
Date: Wed, 26 Aug 2026 16:26:57 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/livepatch: filter debug messages in
 check_result()
To: Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, song@kernel.org,
 live-patching@vger.kernel.org
References: <20260821031648.48195-1-laoar.shao@gmail.com>
 <20260821031648.48195-3-laoar.shao@gmail.com>
 <ao6bxf5D9O1U-JJ7@pathway.suse.cz>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <ao6bxf5D9O1U-JJ7@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 3:54 AM, Petr Mladek wrote:
> On Fri 2026-08-21 11:16:48, Yafang Shao wrote:
>> CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env(),
>> fill_kobj_path() and friends emit pr_debug() messages, and
>> CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
>> for every delayed kobject free.  All of these carry the "kobject:" prefix
>> via pr_fmt(), e.g.:
>>
>>  # --- expected
>>  # +++ result
>>  # @@ -1,7 +1,13 @@
>>  #  % insmod test_modules/test_klp_livepatch.ko
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_add_internal: parent: 'module', set: 'module'
>>  # +kobject: 'holders' (000000002856f0ae): kobject_add_internal: parent: 'test_klp_livepatch', set: '<NULL>'
>>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_add_internal: parent: 'livepatch', set: '<NULL>'
>>  # +kobject: 'vmlinux' (000000007b8837e6): kobject_add_internal: parent: 'test_klp_livepatch', set: '<NULL>'
>>  #  livepatch: enabling patch 'test_klp_livepatch'
>>  #  livepatch: 'test_klp_livepatch': initializing patching transition
>>  #  livepatch: 'test_klp_livepatch': starting patching transition
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: path = '/module/test_klp_livepatch'
>>  #  livepatch: 'test_klp_livepatch': completing patching transition
>>  #  livepatch: 'test_klp_livepatch': patching complete
>>  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>>  # @@ -9,4 +15,17 @@ livepatch: 'test_klp_livepatch': initial
>>  #  livepatch: 'test_klp_livepatch': starting unpatching transition
>>  #  livepatch: 'test_klp_livepatch': completing unpatching transition
>>  #  livepatch: 'test_klp_livepatch': unpatching complete
>>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_release, parent 00000000f8785d63 (delayed 2000)
>>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_cleanup, parent 00000000f8785d63
>>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): auto cleanup kobject_del
>>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): calling ktype release
>>  # +kobject: 'test_klp_livepatch': free name
>>  #  % rmmod test_klp_livepatch
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_release, parent 0000000052e5c022 (delayed 3000)
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_cleanup, parent 0000000052e5c022
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup kobject_del
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup 'remove' event
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: path = '/module/test_klp_livepatch'
>>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): calling ktype release
>>  # +kobject: 'test_klp_livepatch': free name
>>  #
>>  # ERROR: livepatch kselftest(s) failed
>>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
>>
>> The livepatch test modules' kobjects are named "test_klp_*", so these
>> lines match the check_result() grep for "test_klp" and leak into the
>> result.  The extra lines no longer match the expected output, so the
>> selftests fail when either debug config is enabled.
>>
>> Filtering out every "kobject:" line also hides real WARN()s, e.g. the
>> one kobject_get() emits for an object whose refcount was not
>> initialized.  Filtering with "dmesg --level=..." is not enough either,
>> since the tests enable livepatch pr_debug() through dynamic_debug/control
>> and expect its messages.  Read the log with "dmesg --raw" and drop only
>> the debug-level messages without the "livepatch:" prefix, plus the
>> specific delayed-release info message.
>>
>> Suggested-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> I am not much familiar with awk. But the changes look good
> and selftests passed so:
> 

I translate the awk as:
- read through the steam, print nothing yet,
  - when the last_dmesg line is encountered, set the p variable
- continue through the stream and if p is set,
  - print a line if its initial field is "<7>" or "livepatch:"

which LGTM.


One dmesg nit: years ago someone complained about BusyBox vs. selftests
compatibility:

https://lore.kernel.org/live-patching/20200710183745.19730-1-joe.lawrence@redhat.com/

and my google-foo tells me that its dmesg only supports -r and not
--raw.  I don't know if it's worth using the short option without
testing it, but -r would also supported by util-linux's dmesg, fwiw.

-- 
Joe

