Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749506;
	b=S/2mjDMb842bn854HYn2bvqByrwRtJ5lWKGHB6bHSZM2hrwbDARCq8tku5JeakyT+y9b
	 10wiF3Clfo3cHqOmNp93w4o7LgbjxW+StBtaWnVGxFCW/mdh3HFvwZmtnridmsGDexxc8
	 K5u05c4Yys1uWfwwAnClMK9LE6R3prLq+1rbD6Iy82SGu6GpPTW20jQbI7M8zw0JTKM7X
	 svoGHOyVEXCQ6lVQFXgf0+g3yXq/Xb0WrqZp64UjwKzSaor1D9JRUYlPykA+f05UHncju
	 eNpLZ/sLCjjX0ZAahG4YbvXym1ywD3EN5po5P7DhGsnYUlcKLfYPc8VRuhG+sPj3KzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=snW072KNISLzfNyG0xCv+Aa9zQinW5pDSocyaHrbTf0=;
	b=yK8mRt578KAWuKc0hKB0mkUC0LPh+179UF77QdC9KNkY8zx8SNs6lsXdGatg7o2jpN5r
	 msKhBrssqVVSatmqbhE1ALD9n8vUz+QwaSCK5vKNQOVSZDgb8yM/a/nNbI30u1smWtziO
	 ChWG8gL2WJ9A3gz9uLI1GGIxTvzdwDigc0mVPC6FARldvor/qY9QNqU+SvOdhOn+X8ua6
	 M3LdBXYgg/tcO8h86x7nlY0cRmMdvD2VHhT8rmiYAG4bCLJzFOdE3rYzRblnabEk74y6I
	 TqQSiPnlKC/Y26+rkbwGfj+fnWVWDJc6RTPOlImPI1F3DgG09YHtgNMErw10TTpwukg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UYYCR4kx;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD37606A31A
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 09:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UYYCR4kx
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c5358fc28so550083f8f.0
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792749505; x=1793354305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=snW072KNISLzfNyG0xCv+Aa9zQinW5pDSocyaHrbTf0=;
        b=UYYCR4kxgiwsUCTWxOOd2eFe14u+pRntIuNhfkdWojdaxys9h/wsVu4vZWynoXeHAw
         Xat3GFeJCYRG1njQJ3TsETZwNHFwgi3dE5rueSWcGYJHr4ov6JCz0uOjaBFtOvy9yKYZ
         lGA4eIq0zrcbisiN2H2R3CHIacrbk2s9y7iEEGxSMP0vgrjlvmCR+kT0ByvbcZmbFZsI
         j9VtU4liOGVkWefShi5osQQhDAAIXuZCeRY4qXoHdjz6AqsHUp/tOmDqER5P5mZCD1wa
         wjd+lC/ADoSrGXrlM2E3KuXPrbg+g69fDzTAa02dG/vQef+AEzjPSvSjxa0YseXgFyO6
         cM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749505; x=1793354305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snW072KNISLzfNyG0xCv+Aa9zQinW5pDSocyaHrbTf0=;
        b=W/uLbwy5ACUr07Pb4uLLe383N++lz7U1PG4iSaT7uSbrVZClz1vV5C9fF9AU8K6nuQ
         VxH8jGT3ySgQC1ONFdVJJPOxqiZse01NffU3CHwJUcq8172CUASIIHsNK2eZyC01A6Oq
         aHJV/Izy78iAWEnX2Czf0ERxSI5ubA++62l5g0zEfWwCr1RmvCmlxxvLylx7Viawbx4e
         NNI4tCuO8k0zcqb8oxSrg3tN3v3c3XgugYQuw/NL3tgis7JRcF4TQISPcN4O9M9h9KGi
         IojrQm3DNaEGsHGZ7bgb3NYLcOYuR0JrOOfuKS+ntxbEcmdQeNWSanjplGKLQECAacCo
         ElZA==
X-Forwarded-Encrypted: i=1; AKwUvByRD0VhlQLPAIZ+u2q6KqOJGeqmWaTm6myWluSNiTi2MMue/uQpW8FlK6I+OH67GUG0AkfUz52eoHXlcwrk@vger.kernel.org
X-Gm-Message-State: AFq9FYLec3wHQsdCI1b1CG9ZLohZNnjE+8LSOGsYvPih1q4zzNN58hHe
	fkfJrKM7/qQcYnhz+LqlLu9xnV5qHxICKXX1hdWVFc0psSdb+RfvadO9gVw5t7EE2Q4=
X-Gm-Gg: AYBFou1Ipa5NogwBaWvRR56B3p7/XGCtcbSfGoXlPaqkIaSacwitTPMANiaSAi3cp5W
	OYr2gVmFG1RKPykBH9mtW2Gf0iM5IGPAXfsfAzHDww+7dXxWjBPgQ3mhxfOYOgZwre7Lv/Wwc5z
	o1McvancJWO3IE2iCYWoA1gxaH3mBX6sDMre4FVruF406r/Xh1DGnM0s6WXqNe5Pgkhb3OyARoC
	FRAOCKu9LemMZsbPIaMROgqm/K68Oyvp/NhSsOL0jOvYGBW5fTTPSQ0TrYD5mE9kDK21A4gA9UU
	GudPBFgc3lDAf6lrizF2BIpCNthpVywBMKfjfLtbA5jQSWTDzuJ2PilDLV2mXSO5jdUYX+QGA3g
	JV2CSulhTtwoGjwmPipqdwtl/gyaIadApf/hhIYdQ25Ff37kVcWZqC2iFgQ747RK9bAfB6+PQsE
	R58tDBfB+kDveSvJYyJTbqIlhQzkJludtpfnDS/HA+BdIqSoBzPje3DOMR4ksy0J7SOYkTx2KI+
	0p9wkFqo7j/JCVdUQqmHEw6e7Rh4D7wxBOWOSzDeXXrCYQ8Q+tP/USnIg==
X-Received: by 2002:adf:f290:0:b0:48d:deaa:4dbb with SMTP id ffacd0b85a97d-48e3859db5dmr1960335f8f.40.1792749504759;
        Fri, 23 Oct 2026 02:58:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e380575d9sm4369785f8f.44.2026.10.23.02.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:58:24 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:58:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: temporary broken selftest: was: Re: [PATCH v12 5/9] livepatch:
 Implement provides and obsoletes for scoped atomic replace
Message-ID: <atsvvqPJk-413GzJ@pathway.suse.cz>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-6-laoar.shao@gmail.com>
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
In-Reply-To: <20261016053708.47089-6-laoar.shao@gmail.com>

On Fri 2026-10-16 13:37:04, Yafang Shao wrote:
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the changes made by
>   the related livepatch. Where the changes are a set
>   of modified objects, functions, and used callbacks,
>   shadow variable ids, and state ids.
> 
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different scopes.
> 
> A new livepatch atomically replaces any existing livepatch that
> meets either of the following conditions:
> 
> 1. It has the same provides id as the new patch,
> 2. Its provides id is listed in the new patch's obsoletes list.
> 
> A new livepatch that does not replace an existing one can coexist
> with it. In this case, the two livepatches must not modify the same
> function, or use the state with the same id. Any attempt to load an
> incompatible livepatch will be rejected by the kernel.
> 
> klp-build gains -p/--provides and -r/--obsoletes options.  The two
> parameters are not validated in klp-build, since the compiler and the
> kernel handle invalid values.
> 
> Enable the CONFIG_KLP_HAS_PROVIDES compile-time marker now that the
> provides/obsoletes interface is implemented.

I tried to run selftests when rebasing on top of this patch.
And test-sysfs.sh fails with:

<paste>
# selftests: livepatch: test-sysfs.sh
# TEST: sysfs test ... ok
# TEST: sysfs test object/patched ... ok
# TEST: sysfs test stack_order value ... ERROR: Unexpected value in /sys/kernel/livepatch/test_klp_callbacks_demo/stack_order: 2 vs. 1
not ok 6 selftests: livepatch: test-sysfs.sh # exit=1
</paste>

The livepatches are not longer stacked and the test should get
skipped. It is called only when:

	if [[ "$HAS_STACK_ORDER_ATTR" == "1" ]]; then
		start_test "sysfs test stack_order value"

But "stack_order" is still there at this stage. It is removed
by the next 6th patch.

It would be nice to fix this to do not break bisectability.
The following change might do the job:

diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 32d3af0097ac..e48bf33207ca 100755
--- a/tools/testing/selftests/livepatch/test-sysfs.sh
+++ b/tools/testing/selftests/livepatch/test-sysfs.sh
@@ -13,6 +13,7 @@ HAS_REPLACE_ATTR=0
 HAS_STACK_ORDER_ATTR=0
 
 setup_config
+detect_provides_attr
 
 # - load a livepatch and verifies the sysfs entries work as expected
 
@@ -154,7 +155,7 @@ livepatch: '$MOD_ATOMIC_REPLACE': unpatching complete
 % rmmod $MOD_ATOMIC_REPLACE"
 fi
 
-if [[ "$HAS_STACK_ORDER_ATTR" == "1" ]]; then
+if [[ "$HAS_STACK_ORDER_ATTR" == "1" && "$HAS_PROVIDES_ATTR" != "1" ]]; then
 	start_test "sysfs test stack_order value"
 
 	load_lp $MOD_LIVEPATCH


It should be merged into the 2nd patch which prepares the selftests
for this change.

Best Regards,
Petr
