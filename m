Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32559282F29
	for <live-patching@vger.kernel.org>; Mon, 17 Aug 2026 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985617; cv=none; b=blLDYntS15IFfBZXu/aJg3wjOSsUPNySeBrkLeN5ljyO0xKn+cqb68iJbQ3spAXQe1/ocYNLuY/1N0TwdOyhPhZYX/80n3XLRY3cHFoiuAfLp9kPSfDIu7xKe8vBs4WJUnWVEi5CE22KDZ6peeNohUT5iaLrAGEFAvOeVN3P3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985617; c=relaxed/simple;
	bh=asRMw8WjcsCwAeJV4SmVF5zMdThAXCu7hy3C3bu35RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hu6oV58Tgq6r6+FO8y4EdBUhI0LV5k+yBFrGsl/M8jf4fTOWhs83bku7/qS9l9nwtkPQpqO3dADwi1C16Izku602rB8/56G+XT4Xu1jN7z2hR2aX9bGd4PXTev2V7u+yfX6+OrGypt3aYR8V30xfRdfnXrFlpiWXDf11y3TyF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRid71nH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tmEiI8Tf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRid71nH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tmEiI8Tf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786985608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3WX6LysBd+7CWucEaqFfHvbjj7UPWp+DHEZXI34FT2M=;
	b=ZRid71nHSJdyWlrZ/ToNYsbYbjLipAM2BZGwH7w5A+oQdfrHOJ9XY3i+N2mLeSQJt1/PqF
	JgP+p0pRryyYU7naxw9USsPu+AbKsMbJBj17A0J4bWGf6wUc2cP0er8aqtdyiVQLAr9dTL
	anQ5Egr+0A1C3XQjhFj7zInVGkbu8dA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-fcKAyiNVMjikm7HO3z8m6w-1; Mon, 17 Aug 2026 12:53:19 -0400
X-MC-Unique: fcKAyiNVMjikm7HO3z8m6w-1
X-Mimecast-MFC-AGG-ID: fcKAyiNVMjikm7HO3z8m6w_1786985599
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8efad04d884so67084826d6.0
        for <live-patching@vger.kernel.org>; Mon, 17 Aug 2026 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786985599; x=1787590399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WX6LysBd+7CWucEaqFfHvbjj7UPWp+DHEZXI34FT2M=;
        b=tmEiI8TflWgPLjcb2k1BUVmKMM3lTu8wGiGRV3zBp65yYQnPIh46vycF5EbesLGPG6
         Rpd6eXB4clOxsWwRD+DrDpbXMn4Y7H7fFNINbj9q2qwPj6ESiITeCEoxos/++2KJgSHP
         Nund6PoBjfpuAmefKH+n5+Q6uDTbgq0mX5o3fSqPiB+abH+BiztQphTUw9CM74hWJTny
         6EXOYEcKTCqvXJ6Tbq5nfoeI/UH2TH+Hes7M9KYfltaJ0B6d4th6sa12lwW2FiV9D5Gh
         WtLruqpYgIjZS02LGJyUlZhXvLwzpvW5MIaGG5Bv18LWTsjMd7EVhvzTlcK0TcSMbhs+
         u8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786985599; x=1787590399;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WX6LysBd+7CWucEaqFfHvbjj7UPWp+DHEZXI34FT2M=;
        b=DkKzP/Y0HOk/emmMDzVx77VvXUGdEqM+M56xAe1uCzA8rKs7VQ1UcB9x4bDRNHLKkD
         D7IoIA7Ir5rIL69F4OZVRqLMy3M5UGHxMYGvSRRX54xx5uYfvpBlFUdYoHaGt8SvqDeL
         7EG2Y6zIZYBVT/8hAI/c98/l3yCphy5pnNbdycySF7Y8hw4+WHHPOi5B1SOzu348LWKA
         oH8dKlN67e/5miYeyT4kntRJWwgt5YAkT6xF1+OlJgC4h9boHb7Z8o1VKkEVL1StfnBZ
         s2JJfaOA3FMgjL+YUGxWWPcGYo4efVD3oLdms1bv6R0XYy0TIVmEls5k/iDVHinBwygj
         mMPA==
X-Forwarded-Encrypted: i=1; AHgh+RoKvLUCfs4bEzzlQAYw28BfTf9ZZp7om0AfE4L8coUPc/+nl8Mfh2I5913/zEgPrrVGsOiUx7VBOivCsHTe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0lABnAUCYB8VZ9LwuHjp48hV7qLyZmR8ev8eAe6NJ/mJE3CKU
	Eig4a471CTB59KAY3UAcVCXZIP/a7pT/1mKoQLpCG/BkTNm09RDrA+WybhD2Jj4gup4OHxewfw1
	0hg/kdZ2NXz3vQn+zcAQThKdNG9RE4ytVa7FWh8A7wXn/VG2hmrHeTIAowMEgqqA+rxk=
X-Gm-Gg: AR+sD102v0fPKYtPy0fhhIoKKmmRgrtrESnZzUOqdZqxzU2MStL8yYN1g9DyKsKAAtI
	zBK0Pdkc8Iv0AE0xGg5WCWem0uJVEZh380stvOYL2UKVKp8LygrP76ZddGG5khRaPwuE1cruClh
	u1zCRnbiKtC6gRKq0AwTeLEMycNa/DkrqbC1PrTEUa3/7lg66DnhnUKOUFBTy2nblWwUFJZ95YA
	EJ8ZEI5/fQXJXQtbcjDcPi2GlkqCd+xwXCC0cPEIHAMiMBFo1uPNrrZ7z/giG99iANbZAahJmEp
	UyIEDbSNx62daidNxu+v2ikPDKdmvU1J4r6XZU1AaNOkxk37kNoMynN/gZ4d6xk6aoHQV1dMGHn
	Acnl0KM6IyYSdnA/WR0zyEdv9o1+04RTUL0W9/QabnNbb5PvN288DpZui
X-Received: by 2002:a05:6214:458f:b0:905:6e01:b9a3 with SMTP id 6a1803df08f44-90a91e0b9cbmr325694336d6.31.1786985598861;
        Mon, 17 Aug 2026 09:53:18 -0700 (PDT)
X-Received: by 2002:a05:6214:458f:b0:905:6e01:b9a3 with SMTP id 6a1803df08f44-90a91e0b9cbmr325693576d6.31.1786985598345;
        Mon, 17 Aug 2026 09:53:18 -0700 (PDT)
Received: from [192.168.1.26] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45936724sm13335226d6.27.2026.08.17.09.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 09:53:17 -0700 (PDT)
Message-ID: <83199677-691a-4060-bc8b-79ae0d8c7bed@redhat.com>
Date: Mon, 17 Aug 2026 12:53:16 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] objtool/klp: Fix vmlinux klp relocations for
 EXPORT_SYMBOL_FOR_MODULES()
To: Dylan Hatch <dylanbhatch@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <f8e3b9fae109903a6aafb2a33310e4afdcebf58e.1786761327.git.jpoimboe@kernel.org>
 <CADBMgpxZYtSGi=SPRCJ_zOG10arL3uax+fyouctxi5tLLWPE+Q@mail.gmail.com>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <CADBMgpxZYtSGi=SPRCJ_zOG10arL3uax+fyouctxi5tLLWPE+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/17/26 12:21 PM, Dylan Hatch wrote:
> On Fri, Aug 14, 2026 at 7:36 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>
>> When a module function references a vmlinux symbol which is exported
>> with EXPORT_SYMBOL_FOR_MODULES(), a patch to that function needs to use
>> a klp reloc.
>>
>> Currently, livepatch fails to load such a module:
>>
>>   livepatch: invalid access to vmlinux symbol 'get_task_policy' from module-specific livepatch relocation section
>>   livepatch: failed to initialize patch 'livepatch_test' for module 'testmod' (-22)
>>   livepatch: patch 'livepatch_test' failed for module 'testmod', refusing to load module 'testmod'
>>
>> klp diff puts all klp relocs in __klp_relocs.<patched object>, so
>> post-link names the section .klp.rela.<patched object>.<secname>, which the
>> kernel rejects for vmlinux symbols.
>>
>> Commit 07f14d6af9d77 ("objtool/klp: Fix cross-module klp relocation
>> section naming") changed the meaning of objname in the klp rela section
>> name to be where the referenced symbol is referenced rather than where
>> it lives.  That premise only holds for symbols in a module: the relocs
>> get applied when the patched module gets patched, and the module
>> dependency guarantees the referenced module is loaded by then.
>>
>> A vmlinux symbol needs the opposite.  It's always resolvable, and it has
>> to be applied when the patch module loads, before the module loader
>> initializes the patch module's special sections, which may reference it.
>> That's why livepatch rejects vmlinux symbols in module-specific
>> sections.
>>
>> Use "vmlinux" as the section objname when the referenced symbol lives in
>> vmlinux.  This moves such klp relocs from .klp.rela.kvm..text to
>> .klp.rela.vmlinux..text.
>>
>> Fixes: 07f14d6af9d77 ("objtool/klp: Fix cross-module klp relocation section naming")
>> Reported-by: Dylan Hatch <dylanbhatch@google.com>
>> Closes: https://lore.kernel.org/CADBMgpz7iWC0=t=_gE-tfvv0mTPq4kg0qQ2zgPH8DVPE6eQ9Kw@mail.gmail.com
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> ---
>>  tools/objtool/include/objtool/klp.h |  5 +++--
>>  tools/objtool/klp-diff.c            | 35 ++++++++++++++++++-----------
>>  2 files changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
>> index 646d8e1f12eff..c57775d78c71e 100644
>> --- a/tools/objtool/include/objtool/klp.h
>> +++ b/tools/objtool/include/objtool/klp.h
>> @@ -20,8 +20,9 @@
>>   * SHF_RELA_LIVEPATCH, nor does it support having two RELA sections for a
>>   * single PROGBITS section.
>>   *
>> - * "objname" is the name of the object being patched ("vmlinux" or a module
>> - * name).  post-link uses it to name the resulting
>> + * "objname" is the object whose loading gates the relocation: "vmlinux" for
>> + * references to vmlinux symbols, otherwise the name of the module being
>> + * patched.  post-link uses it to name the resulting
>>   * .klp.rela.objname.section_name sections.
>>   */
>>  #define KLP_RELOCS_SEC "__klp_relocs"
>> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
>> index a66049e0726a6..16681a76f13d0 100644
>> --- a/tools/objtool/klp-diff.c
>> +++ b/tools/objtool/klp-diff.c
>> @@ -1344,13 +1344,14 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
>>                            struct section *sec, unsigned long offset,
>>                            struct export *export)
>>  {
>> +       const char *sym_modname, *sym_orig_name, *sec_objname;
>>         struct symbol *patched_sym = patched_reloc->sym;
>>         s64 addend = reloc_addend(patched_reloc);
>> -       const char *sym_modname, *sym_orig_name;
>> -       static struct section *klp_relocs;
>>         char tombstone_name[SYM_NAME_LEN];
>>         struct symbol *sym, *klp_sym;
>>         unsigned long klp_reloc_off;
>> +       struct section *klp_relocs;
>> +       char sec_name[SEC_NAME_LEN];
>>         char sym_name[SYM_NAME_LEN];
>>         struct klp_reloc klp_reloc;
>>         unsigned long sympos;
>> @@ -1441,20 +1442,28 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
>>          * This intermediate step is necessary to prevent corruption by the
>>          * linker, which doesn't know how to properly handle two rela sections
>>          * applying to the same base section.
>> +        *
>> +        * The objname decides when the reloc gets applied.  A reference to a
>> +        * vmlinux symbol goes in the vmlinux section so it gets applied when
>> +        * the patch module loads.  Everything else goes in the patched
>> +        * object's section, applied when the patched module is loaded.
>>          */
>>
>> +       if (!strcmp(sym_modname, "vmlinux")) {
>> +               sec_objname = "vmlinux";
>> +       } else {
>> +               sec_objname = find_modname(e);
>> +               if (!sec_objname)
>> +                       return -1;
>> +       }
>> +
>> +       /* section format: __klp_relocs.objname */
>> +       if (snprintf_check(sec_name, SEC_NAME_LEN,
>> +                          KLP_RELOCS_SEC ".%s", sec_objname))
>> +               return -1;
>> +
>> +       klp_relocs = find_section_by_name(e->out, sec_name);
>>         if (!klp_relocs) {
>> -               const char *objname = find_modname(e);
>> -               char sec_name[SEC_NAME_LEN];
>> -
>> -               if (!objname)
>> -                       return -1;
>> -
>> -               /* section format: __klp_relocs.objname */
>> -               if (snprintf_check(sec_name, SEC_NAME_LEN,
>> -                                  KLP_RELOCS_SEC ".%s", objname))
>> -                       return -1;
>> -
>>                 klp_relocs = elf_create_section(e->out, sec_name, 0,
>>                                                 0, SHT_PROGBITS, 8, SHF_ALLOC);
>>                 if (!klp_relocs)
>> --
>> 2.55.0
>>
> Tested-by: Dylan Hatch <dylanbhatch@google.com>
> 
> Tested with the reproducer patch I mentioned earlier:
> 
> https://github.com/dylanbhatch/linux/tree/mod-ns-lp
> 
> Also, are there integration test cases kept anywhere for klp-build?
> And would this reproducer be helpful as a test case?
> 

Hi Dylan, timely question: Song and I are planning to talk about
klp-build unit/integration testing at upcoming LPC.

FWIW, I have some local test cases for exported symbols, including
EXPORT_SYMBOL_FOR_MODULES, but not the specific case that you ran into.
I'll be sure to add it to the suite.

LMK if you're interested in more details or have any suggestions on testing.

Regards,
-- 
Joe

