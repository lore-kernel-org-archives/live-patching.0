Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795848712;
	b=IsxsvMqRXNqIEZggGuTHwaqz3WQ5UvPwPOJSts7l/KiNSrYgF/W6QMNZFy+Y0S0j4I5V
	 FwN0KKkxk4UvUvtxN2ztxuGRlT5TrnEq2eIVMKEg8W7pEi/lSBklEmVNYYJ/qq3EETJXb
	 Jbk0HsmnyanFbRSwu+3JMSLnzDFDLq3tgNduPnzrnfYTrlmjMBgEQRsCDFbBtRzuGrR/7
	 d/aEIskMN1ar0EOw5RtAHp7hWksP3av8OLa25oRqvkuj0TkQtL1fkyDxjib5j6d2A1giP
	 ul4tiC8UJTUNY4pXUS5wqjwyUqykOl/QvFbqRTAAxWCcj30ZVUzfytZMkxOAiMzBD2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795848712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
	b=H3MU9Uw8L9snddeG3tlmeRmf820kn0Mzsfr5aHq9NLIXZnbHwFBfH+j7OWyIj7jBrKvu
	 MrRP6fROzkqwes2XueUGzJuAHiL0udTD2Sg8PQhAvGY8MAVDlxGtS/faoWlyaYnkOg2El
	 eZaO49sWMSBJG24SaCgLLSJyuK4vK9DCv2Ih3T8MINi56vTSkwjmbY2HaYc5aaNZBpwXo
	 YFGJdwxlC4gYQqShEt1JYnDNBs0CoybZQsiYUABXHMsI+yjuvITzZBikDTljwawzV2nBa
	 y2XZLCPtdk14UjFv6Wxjtzk9QMUpMsmA5FCkhDbO1hy8tyMIrqFQgXSf4jvRjSZkp0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stkmnyeX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED33606A687
	for <live-patching@vger.kernel.org>; Sat, 28 Nov 2026 06:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ED33606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stkmnyeX
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b2f59de176so6326437b3a.2
        for <live-patching@vger.kernel.org>; Fri, 27 Nov 2026 22:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795848712; cv=none;
        d=google.com; s=arc-20260327;
        b=fD/cdkJgfvGB1Ft10TTrdcasWg+a4SkD8DemnxiPvheE5QSF/dFQkDaDrYvHgneHMN
         2hjLnKeY6KyemD8j4V+DkvXeZCU/P7VxsbS57pyNuzMewxgdHXVKzhfxju5rQJu65UZK
         oYtXm2/nuwgFEhoJ9YsWO0YJRwXwGOchZqRpCeJMF0DFfctGXYjUcAIgvvPuMF2qsZn9
         2MBmPQ222BFCIuF0sqULA/sEDNkvMeo8KVVxbae7Hirswzbj0Z26lgiQnkKzK+i1nO66
         DB/H9aFxVS4HsJ7QZjbFKLSFKn+c/pe/g4+UmVv5DsG6nYstRR0tKvEgpd0AAcDaiGy8
         Xofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
        fh=hnOeZszqqN3V77yC8SrbP32gt7M2955wygBa+8vvEGI=;
        b=S9HdW5ctSkLIU7uQjpkZHbMRB9lRtQQdN5GItwZEiNxHVtISgxI6mNlXllFGy4kbc6
         kJkD7oSViE4ImRN6Qj5RBNSGk4xFWACs7I44DAlYjp96Tr3HSlciNKw/1Ay0b1HcafLP
         W4+Rg5Zwciy/12AqCrTVucN7UuXld816ziSuYr9X+po3NljDpjubeMVSLYbI34E8ZdED
         IVhYv5FyYRblWFoNctpLqdqIMa68Sxof8S5AdQdDuHthgvuySdciuykwjho7zrLeq6wH
         +DhfkzLN17mUYhK4eEBKvbWYXbtk/AWC5VolELj2nolxsW/iyIVIMDZpsQuTuOFov5cr
         BHhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795848712; x=1796453512; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
        b=stkmnyeXjXrGO8ucfQh5p3r2ucwellPf1M8PDcbW5zkWf2pVteUPNRDWiVLkWb1zcb
         XpQki5J1T71HXR8TgxpWzBkSMvbsf+7RRpfg3iPuOYsVDQKoNQiJiqeJxpcPQHV6V6pJ
         euR/x1DYOzLSyUlsz4HtEnnqNMofisZmhVrJu/n/1LKzXUrpz0pNXh8zZWRHfESvQ8Zl
         Jq6v8fCKpCKYBOndAWvtIca1h0BMZ5IB2BJfyJzIqsJCBGT2b6BJJtblUIC/bOjTocIk
         PLOhgfuNlQHxmiOC/Ef+vgaxlcT8gVeid0VPgobExn9zilYuZbdQVa7IxtOLitWe0eRd
         ad7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795848712; x=1796453512;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5fkBnBJw16iOwc8lo9gOdGyRkiJlq6Ez/w9c3KR1+bw=;
        b=zjEywpDxwJGVNPU6SllR9S4gkfeXRdZl4OATMEyRIjmXSkgR3de/rQfv/19GZeZiG3
         4CtC0MLm7cieM5ebLrDasx6UGimUSBsVVnfnShtW2GVdO0G5IT7nPuITxsoZeo9iOuG2
         8tbiAv3E1ZmklSg61V7uArNLChg+3t0oL9IvUyVM17Tbr4lYOXnzUGxXD+V8kB6Abyyx
         ZhPbjyZVi0nblZ7Dlwm+LIsbwq2qjzRoM3xAT6/BG7B+nzLicxSqja2dFk9r2GqXRSNu
         Bzy+wEcuKd8PPTTGs/NeweCKpARi9SPeHmdMmL/8MR6Rou2atYAWukVu2dl2JtVyMii9
         L4dA==
X-Gm-Message-State: APuU4Z/S2u3CPEMjWe/ixkDuZQqOpulTzjIw2uZI3+JM3iq8nqVTBR8j
	S0+kAyNlGgGnGsg95JJpTM/B4qD6HfOPdeouzpkzBlFnQ3XU5GiWPRyqfqRCT/lLuQ0bYDnJqZj
	Nc2afgpvt2/exf+BumwFLRr/WJ+F30RCZIoIO3fTNhw==
X-Gm-Gg: AZFdTZeQRmQz3DM+3xJMch8V0HpkDznGdYTLoNSest2YKj9wz7AkZBBgvkFWtj5tMPI
	CWjzqoBUsU8t7zy1GL9FsnP4DV4wq2+5CHwcii7tzf7AyFup63uBMj/kpX/NwlmRf3ddHydLlSg
	GdWUXF2OpE0AkO7Uy86tBDBl5CL4v2ElVUP4jbPRPPIU/JmOLd5iIeQqGLewB2DyP7f9WDA86AK
	x9faWULY93/fhVkr73AALkgB5q3MjGBpUl7H3mmoawKtBnGy3Q07VdH5gmk2wddEHp9aTpuj0P0
	pVGBIb0LIscTiellYflVdCIZIWvOnie9sMK6e/it0gUukrG7yKaQQLv52JQin+sobCiD988CqsJ
	qTHrCsItzlF2bIqsIdZ8wvS7S/AXy9iI8ZiaAbwunmsD0TEqJ/hgfAGq52WryAlBCZ4PzMTqrbq
	pRLUR1oZfKGheIodDTMO/lIiNQ9V3OIpf18zm6UcQIVBp5y/U3pW0=
X-Received: by 2002:a05:6a00:10d0:b0:8a0:1c79:b442 with SMTP id
 d2e1a72fcca58-8c876736f60mr28100627b3a.0.1795848711653; Fri, 27 Nov 2026
 22:51:51 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Seke Kazuru <kazuruuni@gmail.com>
Date: Sat, 28 Nov 2026 08:51:14 +0200
X-Gm-Features: Aa3M54pZRibgmL1LzEnhMVNXmlmV3PoNLAziDiqM8EwF269XopiVH8PkrMvy8O8
Message-ID: <CAJATrkz6CgsaAFjeGT_1TuUTxrpVYEo=9rGuobnhpU-LPxv_dA@mail.gmail.com>
Subject: objtool/klp: ___bpf_prog_run jumptable is correlated to the original,
 fix never runs
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org, mbenes@suse.cz, "pmladek@suse.com" <pmladek@suse.com>, 
	"joe.lawrence@redhat.com" <joe.lawrence@redhat.com>, "song@kernel.org" <song@kernel.org>, peterz@infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

A livepatch module built by klp-build for a fix to ___bpf_prog_run()
loads, reports "patching complete", and lists ___bpf_prog_run as
patched, but the fixed instruction handlers never run. The replaced
function dispatches through vmlinux's copy of its static jumptable,
whose entries point into the original function body.

Setup: Linux 6.19, x86_64, gcc 13, a config without BPF JIT (so every
program runs in the interpreter), klp-build from the same tree:

  ./scripts/livepatch/klp-build -T --no-replace -o lp.ko fix.patch

The fix is c77b30bd1dcb ("bpf: Fix undefined behavior in interpreter
sdiv/smod for INT_MIN"), which changes the signed DIV and MOD handlers
inside ___bpf_prog_run(). Those handlers are reached only through the
computed-goto table:

  static const void * const jumptable[256] = { ... &&label ... };

klp diff refers every static local of a changed function to the
original kernel's copy unless is_uncorrelated_static_local() exempts its
name. "jumptable" is not on that list (6.19, and still not in
7.4-rc4). The module's ___bpf_prog_run therefore carries a relocation
to .klp.sym.vmlinux.jumptable.12 (R_X86_64_32S at +0x40), and every
dispatch lands in the original handlers.

Test, under KVM: a small helper module runs a three-instruction
program through the interpreter (r0 = S32_MIN; r0 s/= 2 as ALU32 DIV K
with off 1; exit) and prints r0. Unfixed code returns 0x40000000,
fixed code 0xc0000000.

  boot 1, klp-build module as built:
    before load:              0x40000000 (6 of 6 runs)
    after load, enabled=1, transition=0, "patching complete",
    /sys/kernel/livepatch/<mod>/vmlinux/___bpf_prog_run,1 present:
                              0x40000000 (6 of 6 runs)

  boot 2, same command and same fix, with "jumptable." added to the
  list in is_uncorrelated_static_local():
    before load:              0x40000000 (6 of 6)
    after load:               0xc0000000 (6 of 6)

The build prints no warning, and every kernel signal reports success.
Any klp-build fix to ___bpf_prog_run has this effect on kernels that run
the interpreter, that is without CONFIG_BPF_JIT_ALWAYS_ON when the JIT
is off or unavailable.

Two possible fixes:

1. Add "jumptable" to is_uncorrelated_static_local(). This is the change
   tested in boot 2. It covers this function only.

2. More generally, do not correlate a static local whose relocations
   point into the changed function's own text (label addresses). Such a
   table describes the code, not shared state, so it has to follow the
   new function. This would also cover any other computed-goto table.

I can send the helper module, the program, the kernel config and the
two klp-build logs. I am glad to test a patch on the same setup.

This came up in a study of live-patch module fidelity. Of 70 klp-build
modules built from real stable fixes on 6.19, this is the only one in
which a changed function's new code does not run.

Thank you for your time.

Regards,
Seke Kazuru
Independent researcher
