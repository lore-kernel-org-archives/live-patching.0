Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C337188A
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414521; cv=pass; b=nHpjFIEDeFXqLqr17fAgPh2HF4LLjSpI2UcuzU9C1ReJvYe1p0wUnTFC3pM1VOQAiC23U0A1qBqUp9+4KL/wYLEjSVpi9JDb+ramk20pF6TNgAxzE0gMtHhUH9ripz23R6KZ53J+j16yuXqMSxfHklbTysN2CPad8VaT+emiFSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414521; c=relaxed/simple;
	bh=BwN0v0ISME7+uRzXI+Ig1sKkAbLZ2YkXkhqGyc9gLd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snwnbU/sn3hPvp+KeZy5iQKztDfH+9a4GY9cAH/3Rubne5s9FECAZeA3iB78mJvSe4K62GsAONW9YZf5e0+ctfgUUPJzGi5FuV8V7wZ9A+kbA18czw+B8HGuqps/+wn3OMF8x2pqmZc6CWmABBLkXjWHn6QVQJbiepsGs9Sjsks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PidN1zRf; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PidN1zRf"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8200b55dc47so24836207b3.3
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 22:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788414519; cv=none;
        d=google.com; s=arc-20260327;
        b=X4k8dp41YEYjWlBaYd7+kvfxI4/UQ/t5acidCASZWyrCpMOyaHG4d5YL+plEWGZ0Iq
         PCdpOp1lVPC0OXP2E5qFhuTMB15JWk8yyBV6ZYHoyIBiZ8C23HQJnp6FIb8RhVnUcp15
         8ddCjWkackdgIcWkkUBisLSrDN0xxY/9CSIrJ8OaYnq2W7zbyEIYdvsGxrvlsZIQ+pDh
         NOx1RcKHSqJx4WQ86XIZIIwE35mnDY99Uwaujl9p0brvdmsBMfyMYNtVwy/oLR4vABkz
         mSrNLYNWvEqt7LkDOJUiZspwuQqf1ze+ig47fdXIst0YV0mV0zK8XiZnqgj/X69frfBn
         GnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pVD3Ul7TDR56+hhWprTXacwmkXG8ltct5NfdLC6T+/M=;
        fh=pRgsO/uX+vFnq0AcgVN7JT7DnFvkOTQJ/sv+Z3JKrwA=;
        b=HuCpt2pEeW+2xt/E1Rq+F+jEOxq2FNSjOplncskUm4j6ZiVNtMy3NhCYR75gKcKWrk
         q3oHrUXpIfMkh8VzUQpT2Jy43hyppz4puWvcKX4ZCHOq4JG1eq/pRv/51WoFMgqGPHxl
         zLCpJ0vZlcMe6apDtH6Nux8d5DVemElRP66btM9+6/v0Y3TdsBtrdKeOX/j5no77D2F4
         0iJ8NSXs+fSqwojnhwAsrsjyGCa6LK7kphRUi/aMG2qBZeJ+Vm620qsRl6H9AhDaRdeB
         dEGUD3rybXYRzo7fJq8KGRViPKJ1oRWwx/Go7VPy+6r8aUWC+utl9cMN3tvBiLRT0ZTQ
         0Yrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788414519; x=1789019319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pVD3Ul7TDR56+hhWprTXacwmkXG8ltct5NfdLC6T+/M=;
        b=PidN1zRfnElfgEkciG8ZlK1f7ZtVaT8bwFkJPHtjGAtjuCRDl5nBkK2H/PRZqsxkla
         5EFjae8bBzAiWUVySSOXJMdp7mQHlhAWHxMKoHtxSuhEv/ytCFBY0lEIPMpY0fa2GzCf
         +/jiVw+7/E2u4Y2fGOcJ8DBtG7FY8BJlVs6fl+sydTxzeooyLHKKLglGaoCvXxWVZ8YV
         9JAl9NlbUayUqsQi8RvLsDiZd7DvILvVn8E0Sh54BF7h81qD5GsrOzawrvXyhulwpCWH
         jBra2Uplbg9lupuc9VqXNtHDioAdlF+xpiXaxOrn6dE32esHdUMGbkHoG6Wss1pPqCMO
         XLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788414519; x=1789019319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVD3Ul7TDR56+hhWprTXacwmkXG8ltct5NfdLC6T+/M=;
        b=DDv5u+jsid7NKzy5C/+cr5qOzeKFgECUjvjfoizd7rA0ySSR1aA5Jqa4wiuwuvi2m6
         /V2lM5ZFhTcg2qBie5jWiqflRWuiVMpOlgvDJ9e336BdA9DW5pOAUVm7rP7CwsNVq/bQ
         Azw+uBi7EiBIW7oQN5NQPPcJlVq3RGZd28JBxd9K7tsGm+4eEKAnXYndc0vEsJhmiPkJ
         a7fF/yOtiHop+lRYJJm9M0yoe79hJm2GlSLYjCUf04ayK1RDk7Yj3bzvZUrXTV0vXm9Q
         Oio4qM7o2BJljx66TSn9U2FH9W0jM7BL1YhvIw9PQyOnB67pcjtwtccgU02Hg+HIJCFG
         gAvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzr52cLLReHJcyL54eORQMTNh8B7dTV+3ndy4sjxadH326irD9gdwDt5MgJLhK5uqik2w/x81aRWKke2qwV@vger.kernel.org
X-Gm-Message-State: AFuF++l8W89lj6Zh6BuShFVSx7JANfvt3Vh+lmEou4+DSr3V9VxWhFm0
	M+088ltDvAdJ44P+iFQPXHlJC0PNBndm34C2f7WuYj+xuA11ZpO/Y0Ab1OajmJtHIFVbLF/MDRN
	DkublK5Wb5RMiEMThMrbCJzQvA6Hqt7o=
X-Gm-Gg: AYBFou3S/dXo7AKolZcrL5dh1C3NWmvRUdekw3e2KfFNctZdEiCreQdZWQ4vRERokG8
	CCmroU88B9ZrceqyhRhFJ9gAFIVx4kcC/JpdaF+C0ziu0jJQSLLXH7hOZpeAPT/z8jx5Oig/E2i
	O2W//Hj6gx7BdaInitlBDOn7e5WhBJbWHTTb+cgzSZxSIFeWGoRbQS0AslYbokbhSnHadrZ+h6q
	CehlGlMGF4vQ84xeSiDEbKBaTvfqdc/5YApoJ2T5p7UEGWFQGafqJagmjysceeL0yiBpgWWVi//
	1WBbgGVE2NCOWNZQQR34ydhHgPriKuwb5DVQ8+5PWoRFkEYTojEu2VcuoTjsxm6LBmhFvasPBRr
	HEfvvrcj1D11l
X-Received: by 2002:a05:690c:91:b0:81c:89a2:dbce with SMTP id
 00721157ae682-86c4d652716mr50577147b3.3.1788414519278; Wed, 02 Sep 2026
 22:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-9-laoar.shao@gmail.com>
 <aphGEn8RDWQx_yEA@pathway.suse.cz>
In-Reply-To: <aphGEn8RDWQx_yEA@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 3 Sep 2026 13:48:02 +0800
X-Gm-Features: AcwNN1WU29NyAtuYPP3_Bcr93Nc64I5daT3XcMSZUoHEiCoCnG2aNOtB9jRbk5U
Message-ID: <CALOAHbAm20jD2odE9afK8wwpqTymwv+TeGM9cD4E4i=xYWTbGw@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 8/8] selftests/livepatch: Add test for
 function conflict across provides
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:51=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2026-08-25 19:46:41, Yafang Shao wrote:
> > Livepatches with different provides ids must not modify the same
> > function. If a second livepatch attempts to modify a function that
> > has already been modified by a loaded livepatch with a different
> > provides id, the loading will fail. If the second livepatch shares
> > the same provides id, or if its obsoletes list contains the first
> > livepatch's provides id, it will load successfully and replace the
> > first one.
> >
> > Add a new test module test_klp_provides.c that patches meminfo_proc_sho=
w
> > (the same function as test_klp_atomic_replace) so that the two modules
> > can be loaded with different provides ids to test the function conflict
> > detection.
> >
> > Add three test scenarios to test-provides.sh:
> >
> > 1. Function conflict across provides: load test_klp_atomic_replace with
> >    provides=3D1, then attempt to load test_klp_provides with provides=
=3D2.
> >    The second livepatch is rejected because livepatches with different
> >    provides ids and no obsoletes must not modify the same function.
> >
> > 2. Function replace within same provides: load test_klp_atomic_replace
> >    with provides=3D1, then load test_klp_provides with provides=3D1. Th=
e
> >    second livepatch loads successfully and replaces the first one
> >    because they share the same provides id.
> >
> > 3. Function replace across provides with obsoletes: load
> >    test_klp_atomic_replace with provides=3D1, then load test_klp_provid=
es
> >    with provides=3D2 and obsoletes=3D[1]. The second livepatch loads
> >    successfully and replaces the first one because the obsoletes list
> >    allows it to replace a livepatch with a different provides id.
> >
> > Assisted-by: Comagic:DeepSeek-V4-Flash
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  .../livepatch/test-provides-obsoletes.sh      | 110 ++++++++++++++++++
> >  .../selftests/livepatch/test_modules/Makefile |   1 +
> >  .../test_modules/test_klp_provides.c          |  72 ++++++++++++
> >  3 files changed, 183 insertions(+)
> >  create mode 100644 tools/testing/selftests/livepatch/test_modules/test=
_klp_provides.c
> >
> > diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.=
sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > index f9a9f9b28490..be54e8d2c889 100755
> > --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > @@ -8,6 +8,7 @@ MOD_ATOMIC=3Dtest_klp_atomic_replace
> >  MOD_LIVEPATCH=3Dtest_klp_livepatch
> >  MOD_STATE=3Dtest_klp_state
> >  MOD_STATE2=3Dtest_klp_state2
> > +MOD_PROVIDES=3Dtest_klp_provides
>
> The new module duplicates test_klp_atomic_replace.c. We want to avoid
> this. Please, create the copy module by using
>
>     #include <original_module.c>
>
> Also it would really help to use a better naming. As I suggeted in
> the review of the 6th patch:
>
>    + test_klp_proc_meminfo_livepatch
>    + test_klp_proc_meminfo_livepatch2
>
> or
>
>    + test_klp_meminfo_lp
>    + test_klp_meminfo_lp2
>
> Then it will be clear that these are liveapatches and they modify
> the same function.
>
> Then it would be more obvious when they should succeed and
> when fails:
>
> # same function, replaced by provides
> load_lp $MOD_MEMINFO_LP provides=3D1
> load_lp $MOD_MEMINFO_LP2 provides=3D1
>
> # same function, can't be loaded  in parallel
> load_lp $MOD_MEMINFO_LP provides=3D1
> load_failing_mod $MOD_MEMINFO_LP2 provides=3D2
>
> # different functions, atomic replace works (nops)
> load_lp $MOD_MEMINFO_LP provides=3D1
> load_lp $MOD_CMDLINE_LP provides=3D1
>
> # different functions, install in parallel
> load_lp $MOD_MEMINFO_LP provides=3D1
> load_lp $MOD_CMDLINE_LP provides=3D2

Thanks for your suggestion.
I will update it.

--=20
Regards
Yafang
