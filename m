Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B633859FF
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560683; cv=none; b=dBlqGAuMHCSgjNFZM9RPQPqL00mHnEKmya8JO4IgrIlogkVJjKfo0hKjwkFGdPqvJdYqROzACncAoWiBA44velWXehSAzDGZdc2BT8/4YBOxTsw51/p6Or8WhgNgFwk2pweXIqH2tHpyUK4c29k+uRACcJVY+B1RsqrTt7H+4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560683; c=relaxed/simple;
	bh=TmiZQJW2bYXEP+nGiUA9vOU5BR/5B6xI3uN30kC+xgs=;
	h=Date:In-Reply-To:Content-Type:To:From:References:Cc:Message-Id:
	 Subject:Mime-Version; b=KG0X6m5wfssKxjUiKJ+Ps851ClLxSa+gaNVNp3kPzU/Dd4zKGXREK/fnlimFysaON6RPr0xZlNHDg44EVHU4VNSg4ofB0ZUZIr7LLNfoesnfR/4u3V9irj0oCDHbNPi9BgIU2YxqQhiZy7bDczVXvrmhP5qf4sd0eo8e/0pKJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LxeMpiqR; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LxeMpiqR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780560671; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DFOSYT+g6gkCESpGC5S0ici3Wsoyd9mVDxkD1wkz7II=;
 b=LxeMpiqRiLRVcRWXxnODLlm4ZOZOYV4WMLrP7cEVfFDaKe9SOqkO+2mHA1+JAhA78KlZTx
 PoafrliLuNmjVUcdA7uuYOieN48TYq4M1w1A4ododcKy8wltw3xZPCK7N6kVWm2SjF5x67
 oyjgyv9oZGebGLT1t/VM3A/zdEKBMqzj30BKOwl5tnLu/bgIU2KXTfz23vhNwDJo8mKPun
 MXJdLajMYqPFZNWaL7UNtPLyXl/yfRjKuw6w9LT8U95XrDxn4cCz7VCx42uPfxlzs5DCQK
 uT3M5poBmnbj+3q+z2ooKkyWoUBK0PGEzl/WSs/QTyFbYIoDnMyX6jrsorg1VA==
Date: Thu, 4 Jun 2026 16:10:53 +0800
In-Reply-To: <178049217756.69035.11980890855635035855.b4-review@b4>
Content-Transfer-Encoding: 7bit
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Miroslav Benes" <mbenes@suse.cz>
From: "Rui Qi" <qirui.001@bytedance.com>
References: <20260602124509.365996-1-qirui.001@bytedance.com> <178049217756.69035.11980890855635035855.b4-review@b4>
User-Agent: Mozilla Thunderbird
Cc: <jpoimboe@kernel.org>, <jikos@kernel.org>, <pmladek@suse.com>, 
	<joe.lawrence@redhat.com>, <shuah@kernel.org>, 
	<live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Message-Id: <070ef555-da56-4695-afe9-e03974113c21@bytedance.com>
X-Lms-Return-Path: <lba+26a21331d+66b2ae+vger.kernel.org+qirui.001@bytedance.com>
Subject: Re: [PATCH] selftests/livepatch: fix resource leak in test_klp_syscall init error path
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On 6/3/26 9:09 PM, Miroslav Benes wrote:
> On Tue, 02 Jun 2026 20:45:09 +0800, Rui Qi <qirui.001@bytedance.com> wrote:
>> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
>> index 0630ffd9d9a1..d631acae48b9 100644
>> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
>> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
>> @@ -109,7 +109,12 @@ static int livepatch_init(void)
>>  	 */
>>  	npids = npids_pending;
>>  
>> -	return klp_enable_patch(&patch);
>> +	ret = klp_enable_patch(&patch);
>> +	if (ret) {
>> +		sysfs_remove_file(klp_kobj, &klp_attr.attr);
>> +		kobject_put(klp_kobj);
>> +	}
>> +	return ret;
> 
> Is sysfs_remove_file() needed? I think that kobject_put() should remove
> it automatically since the object is bound to sysfs.
> 

You are right, the sysfs_remove_file() call is redundant. When
kobject_put() drops the refcount to zero, kobject_cleanup() is
invoked, which calls __kobject_del() -> sysfs_remove_dir(). The
latter removes the entire kobject directory including all files
created under it via sysfs_create_file(). This is also consistent
with the livepatch_exit() cleanup path, which only calls
kobject_put() without an explicit sysfs_remove_file().

I will send v2 with sysfs_remove_file() removed.

Thank you for the review.
