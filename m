Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8B2931FF
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810198; cv=pass; b=cYLd9LuUSoCKiBtMHnuSoxuVbv2EOFA4qRrsTO3uKZn0cFrgQr6MEZuu2JMQZPC9APzBxFeOY+SkWT2PwqkQEDDM6C5uG6DCYcOy6VceUfguDt5TJdeUSFHwzW4FbT0ZuXtRz3VekvKIbecnP1TtfAu7xkIXeKuupyDJPsJBmME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810198; c=relaxed/simple;
	bh=CxcXj76jR+WQB7i08B+cFsigwknf8iT2zP28LU9H5Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJxQgmqH4RtJ16wKG/PIVESN3bL61BXiP1KMNoUEjifxh9GMZntaeWrAP4kgM5h8aLwMd0p7GrTKtUHfcgILl4aHOJgld9ZtCwicFhRy4eQfLFG7QNHkZKEyG1UiqVa/latOlPVKNtENLE/1gZherq5l1KcYm+h6HBkvr4ItXzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmmWQJGl; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmmWQJGl"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66d116f0de8so367279d50.0
        for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 22:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787810195; cv=none;
        d=google.com; s=arc-20260327;
        b=El3zoL/pS4Buk4re9/SXU3s0IBVQlXurMq42MZCDkMU5kU4f2qMfmGX5fpLdKgfDJN
         GVhAC6g69x3PycWFPOzxMQJ7vRXhHdvBvbwgv2sHnc1UN2pwZAYWjwkqCgZqVyB31JMI
         pxH5yanbVgO1ewjQDY7Saaxfc1YUrIREbOovR98ZlNg3vM9P0P0di8Nmf5r7uH3QN+Pq
         R7Zlm6m3RaHvD7NM32oB8jyiXwlWrIwG4AjooSVponYi1TS3JpzJM4mtm+N1wyb3Rd3N
         CpOruULktKe+BNMdhLD4CoKwWmIQPHuwBDVsIeOQZVm1Chi1d5muUa1dCCQD2+4tPTza
         QNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VF+3kaTNlIWeLSDYEsr2dsbWCEPSDO0kHkoRUfL0TU4=;
        fh=oQYcxmb+tD5/ImVpwrv1Xi1ptnVa7FgkyIMw2XQssCw=;
        b=jl3ajSg/8Cx70Bi+4zejRrlvB5zqH5wXxAzBS7C6SAymgOT3GsyHdG5C+S4xy/R/1P
         +rIf1WlwrKWwPe40uND1JZzWJ3dV3sF+9sbHLW8MkPaHgRkFvJLVm9Dcl6mVpX8OU+Ou
         fxWJDKgPFR/EiXOP7BmMzKrfHvxeiN1T2vCd+7SPiAdQW6g9RyVL4Czu4+SD+79h2W2r
         xkh8vkrHpmPfG3D6efhBA+I+B9aYJG43xq5UAWx4h43qbk9K8NTtsHre0i6w1hBrv+Ic
         i7CmKIJvouqI7V9rdYjqzrE1ArOZh5kZtPqZTazJE/RgzxSNJ7npPMCrs1fNp7cVoN37
         s7Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787810195; x=1788414995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VF+3kaTNlIWeLSDYEsr2dsbWCEPSDO0kHkoRUfL0TU4=;
        b=VmmWQJGlulk9c8wIl1YG+TCtU2lQJQmK23E+k0lNOr/+jCLrlHnBk3q7s1uR/PW+Hf
         6vplILVnVPcfNJGYhZaf6tozie0D+CRqsDkP9yOEr4MkuhbdMjxzZdDwDmHeUuYverFL
         5qN9pNeh+UyQDYu4P1SX83Kjiz25IjoN2wIbxNxubVcUoWYWZ0fii5khSYyoucw26hfe
         SU85rqR0AXGNRpC69f3t5BHt0kF5NdBn1SfreBCERFFwXXJP4KsypU+I53oIrMfbuWTQ
         vfCxaoxPr1m9gqQwCKbo1le9nf1f2lAtMH4UlU57ipDWq8scjkbBku/RegGg6yPgwr/7
         X0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810195; x=1788414995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF+3kaTNlIWeLSDYEsr2dsbWCEPSDO0kHkoRUfL0TU4=;
        b=M3PG+UVW0xFnGwqd/Zs6/t2AJd56OB1L/rqiK475DkduySfZRkL4ODcxtR3Wj+wTNT
         KRAItBK9tRSiN7MOvny/V0vg7mq7zisboMGzTCNfE4YkCHBDrl7AA7n7EGN9ap1Qf1k4
         CVzWTnGnY31XKkFTDa6SDewu4PjyBOTWnzan5IAaOVO7FbcA407Ls3pBeStmHC5l0xJV
         u6ABqaqhnnsWdhfKe0ZMp/VcD9oCOcnkHOUct2RRMVS+k4+YpXYG25J6bOQ8N7aNGQiB
         GYg1NWU8SkHqj+Vb2ttvP03AsgCb2+XXg8Q+Tw7SZAjdtNWK2fiWFpnW4CV9KqCZe5j5
         E0XA==
X-Forwarded-Encrypted: i=1; AHgh+RpEPc50+/OFyBdpczL79iYFAYsCbLL7M3sHG1IzSZmF9HIA7gME80SmB+V9vE/FaNfK2uA7FyWmsxMFQHX4@vger.kernel.org
X-Gm-Message-State: AFuF++mJGR7n1z4z1hjgUb8AwmokI2a1GVxfPfs5Rv2XWS53eIVDIFXD
	25+B6fzV4SYMLX+3IQAaph2dB1n4O4dHpQxmB38m25+8KJ8UQxcHvd0qyebe96IJ6BIu2ZdYJ1T
	5pgn59Ql1AbU3tuhoyZxP3NwdR77EPqg=
X-Gm-Gg: AR+sD13bI04ag1Z91/cimbCicHV1HNn3mli7ABcSyGNaps7Wr5TXmP5tFoVDoniTuNT
	L24ftRN+ApDzT2MR7/ccpeTf2W7dpiluLN3Y+tovdgKNFf6ZkVqEstmzd5g9Fj7e+dpBAzKfOvB
	FDv+GEA54pOTWnsvphCOn/imH5U1tKA6BBt0hIkLSxt3IRU590Mwd7rGixrV2dRL6AXznZsn7a8
	mRpWcmCLF7ACrzHb1O1UCSaq64jN4S+DL6eRaZJEe1n8PqOTErgFbdumpT9CANJ+HipokMXSPnr
	xguEkDS7Qe2BRo4k7iGrlkspN0KK+2zSxDZL0X310qqqJDOs/2OcfMfcj21fibL6zjRdcRvuh43
	JnA==
X-Received: by 2002:a05:690e:bcb:b0:668:9230:e269 with SMTP id
 956f58d0204a3-66d257a464amr4243278d50.41.1787810195339; Wed, 26 Aug 2026
 22:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821031648.48195-1-laoar.shao@gmail.com> <20260821031648.48195-3-laoar.shao@gmail.com>
 <ao6bxf5D9O1U-JJ7@pathway.suse.cz> <fb7ed056-00d9-4484-9cb6-159cba97eb75@redhat.com>
In-Reply-To: <fb7ed056-00d9-4484-9cb6-159cba97eb75@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 27 Aug 2026 13:55:59 +0800
X-Gm-Features: AcwNN1U2G02Jp4LbcF9p9LOWnWC9lND6NqAo1KqZEeNgde1hwakoN00cYeVJIro
Message-ID: <CALOAHbAHezbPHo=+tEByF-t9W_rf=9KT_DX9feCPe9L80AnsMA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/livepatch: filter debug messages in check_result()
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 4:27=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On 8/26/26 3:54 AM, Petr Mladek wrote:
> > On Fri 2026-08-21 11:16:48, Yafang Shao wrote:
> >> CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env(=
),
> >> fill_kobj_path() and friends emit pr_debug() messages, and
> >> CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
> >> for every delayed kobject free.  All of these carry the "kobject:" pre=
fix
> >> via pr_fmt(), e.g.:
> >>
> >>  # --- expected
> >>  # +++ result
> >>  # @@ -1,7 +1,13 @@
> >>  #  % insmod test_modules/test_klp_livepatch.ko
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_add_inte=
rnal: parent: 'module', set: 'module'
> >>  # +kobject: 'holders' (000000002856f0ae): kobject_add_internal: paren=
t: 'test_klp_livepatch', set: '<NULL>'
> >>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_add_inte=
rnal: parent: 'livepatch', set: '<NULL>'
> >>  # +kobject: 'vmlinux' (000000007b8837e6): kobject_add_internal: paren=
t: 'test_klp_livepatch', set: '<NULL>'
> >>  #  livepatch: enabling patch 'test_klp_livepatch'
> >>  #  livepatch: 'test_klp_livepatch': initializing patching transition
> >>  #  livepatch: 'test_klp_livepatch': starting patching transition
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_e=
nv
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: =
path =3D '/module/test_klp_livepatch'
> >>  #  livepatch: 'test_klp_livepatch': completing patching transition
> >>  #  livepatch: 'test_klp_livepatch': patching complete
> >>  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
> >>  # @@ -9,4 +15,17 @@ livepatch: 'test_klp_livepatch': initial
> >>  #  livepatch: 'test_klp_livepatch': starting unpatching transition
> >>  #  livepatch: 'test_klp_livepatch': completing unpatching transition
> >>  #  livepatch: 'test_klp_livepatch': unpatching complete
> >>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_release,=
 parent 00000000f8785d63 (delayed 2000)
> >>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_cleanup,=
 parent 00000000f8785d63
> >>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): auto cleanup kob=
ject_del
> >>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): calling ktype re=
lease
> >>  # +kobject: 'test_klp_livepatch': free name
> >>  #  % rmmod test_klp_livepatch
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_release,=
 parent 0000000052e5c022 (delayed 3000)
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_cleanup,=
 parent 0000000052e5c022
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup kob=
ject_del
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup 're=
move' event
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_e=
nv
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: =
path =3D '/module/test_klp_livepatch'
> >>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): calling ktype re=
lease
> >>  # +kobject: 'test_klp_livepatch': free name
> >>  #
> >>  # ERROR: livepatch kselftest(s) failed
> >>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=3D1
> >>
> >> The livepatch test modules' kobjects are named "test_klp_*", so these
> >> lines match the check_result() grep for "test_klp" and leak into the
> >> result.  The extra lines no longer match the expected output, so the
> >> selftests fail when either debug config is enabled.
> >>
> >> Filtering out every "kobject:" line also hides real WARN()s, e.g. the
> >> one kobject_get() emits for an object whose refcount was not
> >> initialized.  Filtering with "dmesg --level=3D..." is not enough eithe=
r,
> >> since the tests enable livepatch pr_debug() through dynamic_debug/cont=
rol
> >> and expect its messages.  Read the log with "dmesg --raw" and drop onl=
y
> >> the debug-level messages without the "livepatch:" prefix, plus the
> >> specific delayed-release info message.
> >>
> >> Suggested-by: Petr Mladek <pmladek@suse.com>
> >> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >
> > I am not much familiar with awk. But the changes look good
> > and selftests passed so:
> >
>
> I translate the awk as:
> - read through the steam, print nothing yet,
>   - when the last_dmesg line is encountered, set the p variable
> - continue through the stream and if p is set,
>   - print a line if its initial field is "<7>" or "livepatch:"

right

>
> which LGTM.
>
>
> One dmesg nit: years ago someone complained about BusyBox vs. selftests
> compatibility:
>
> https://lore.kernel.org/live-patching/20200710183745.19730-1-joe.lawrence=
@redhat.com/
>
> and my google-foo tells me that its dmesg only supports -r and not
> --raw.  I don't know if it's worth using the short option without
> testing it, but -r would also supported by util-linux's dmesg, fwiw.

makes sense.
I will update it with -r.

--
Regards
Yafang
