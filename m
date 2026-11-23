Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475055;
	b=wdUDiqCFxEoJMibeOgJ8WkaWDVKB1AC6jH4RZsqMq2Xd7b+JpWl8oJgayXov30cBPjk+
	 dsA3bSvPpL0pdGKs0UgecN0ppUrwRNy2IXf7LY4rW+Wp3/5snNZbQdtIVAQETFAAmzEz8
	 NtkPvQ0UD/uuUAnCX+z44/5F3M5o+gxqtjhq8AVnsGoV50nSH3QZIie/37dlz+LUs+ege
	 /PMRgelANrp49qJQ+I5HUBFkX55VcoefYhfOIU5geHWLTqOQn7HSkBGhPQcTMpRJXxzsS
	 NzKdR0CYt8epUW//CVnf8ro4FDMPrO5QP4qw0ernEiTZWOacEgIcv9HMkHwRRm9rOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=WE1sJAh68uC49K7CZmY8kXCNTGpiMALaZqurYl9Jgro=;
	b=qe1fegU9NM/w7Vmi+7PgFRBEsqJkcI7K9Ta29ZOVuz7/Dd4SOBHUOoURN1seu6LnxIX9
	 2nL6+1sJsUbob7RfQytDO7HIUBOwARJ5aBC4zeWm87+g0wqCfCggPGOTl0Vqztkeoy9b/
	 wnbD7sNaq5l9XCeSgR2Ft5AH17Pq+z6/D0qjCFx6A+JGlsRTKi+tX/oxcuOt1qSCh68BL
	 V1pnyTfFsLqWIJVcjFzlQqAw7c0nOlB2qBEifITvo2sARdfdeO6+BjSpCJR7jaXe3Epub
	 rLqEw3KQUsd635edtyMe4nNApc+XpNaZbasb0fTC52T4RRn1/ByGz7lMJsPaeN2OJkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="PsX/vNR5";
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF3606A321
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 23:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02AF3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PsX/vNR5
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-57489477aabso4317756b6e.1
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795475054; x=1796079854; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WE1sJAh68uC49K7CZmY8kXCNTGpiMALaZqurYl9Jgro=;
        b=PsX/vNR52o18mYaElV2oHksSAO+vlPbFWSJXqY85DN8ZdBmQ9ZPUuGZ1YNonsH3pha
         I+WlZ8o0IMZzPdHIKbS0VLwbkqHrNglWFqI3VEGgWA2XzrWWzdGcROX4+g5ohxdqBJsT
         oYuguEve0catJ1FKDItSIFFh3rfXmdF+scVbYeTyOYklxNZXWyu5pXpKa66suyyKWGi0
         UpLt6zPQuvHlxI+Rvm5yNqzPeyeX7K1P+ReBfOeYvaG0Y3SK9BnifWkNMeFPyWOzjy/x
         VYLQcU9UogwS1spqRuOdPhGDyWoG09+SnguSLKGmsWiuQT+H/6N4udO6/lzrPTAjAQHc
         TYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475054; x=1796079854;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WE1sJAh68uC49K7CZmY8kXCNTGpiMALaZqurYl9Jgro=;
        b=Vjr8HOi3wE1tx1Q4WMzkh3KnDDP7TSIQtRX8fj/OZhfvW0kq9asqGtN55qV4j6zkor
         Cmr9d4n8kY+CclTqg0LodsC1R+Fli8Vm4j6P5O93I3Ohj7dXzC/D0LKViGspZNJV9dc6
         7AmxA6Td61/6eEX0GBE2HSh8p7/UfLI8UBbC9jXDa7Gjy5r5C7eNU4c+wyE6IPzztVjw
         svNkS0oUKXBzKx43asOUg1yM0RM/w8oe0z7JRJyr9SYaBLezHUWDGU4gJKaGX+w867i5
         iSXCA03VW/VEPYwWTzg/vy5JR0zeoF9m/CE+H85u55sYXfPezfaVm750L74sV43kibUf
         xxFA==
X-Gm-Message-State: APuU4Z8H63J45V5BDbYPGlWM3oH4yyClta2y/V1BJaUOJUhbHNcbLQjN
	mtItA6wAftHmxZ7RKtxy5sa+3N5Vq2tPDPTffuHg+0Ta1NfaMUqokBWfaBz42Bxi20R/fXoSzO5
	L0W0rWcvzqQ==
X-Received: from ilej19-n2.prod.google.com ([2002:a05:6e02:6213:20b0:54e:ab26:add9])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1488:b0:578:f283:2471
 with SMTP id 5614622812f47-57a09e0ab1bmr14220527b6e.46.1795475053524; Mon, 23
 Nov 2026 15:04:13 -0800 (PST)
Date: Mon, 23 Nov 2026 23:04:05 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261123230410.3206378-1-wfelipe@google.com>
Subject: [PATCH v2 0/2] objtool/klp: Fix sympos for global/local symbol collisions
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>, Yi Zhu <chuyee@google.com>, 
	Wilson Felipe Pereira <wfelipe@google.com>
Content-Type: text/plain; charset="UTF-8"

When a defined STB_GLOBAL symbol in one translation unit shares its name
with a static (STB_LOCAL) symbol in another translation unit (for
example, cgroup_storage_lookup in kernel/bpf/local_storage.c vs
kernel/bpf/bpf_cgrp_storage.c), runtime kallsyms lookup counts both
symbols together. Emitting sympos 0 for the global symbol causes module
load to fail in klp_find_object_symbol() with "unresolvable ambiguity
for symbol".

Patch 1 disambiguates defined non-local symbols across .klp.symid
generation, klp_find_sympos(), and clone_reloc_klp() (while preserving
sympos 0 when unique). Patch 2 adds tests covering both module (.symtab
order) and vmlinux (.klp.symid address order) paths, including
EXPORT_SYMBOL_FOR_MODULES() exports.

v1 -> v2:
- Simplify clone_reloc_klp() by unifying klp_find_sympos() below the
  export/non-export branch (Josh Poimboeuf).
- Rebase onto v7.4-rc4 (b6a9fa34ce41).

v1: https://lore.kernel.org/all/20261117000835.1992893-1-wfelipe@google.com/

Wilson Felipe Pereira (2):
  objtool/klp: Disambiguate global symbols colliding with local symbols
  objtool/klp: Add test for global/local symbol name collisions

 tools/objtool/klp-diff.c                      |  5 +-
 tools/objtool/klp-symid.c                     |  2 +-
 tools/objtool/klp-sympos.c                    |  9 +-
 .../tests/generic/fixtures/sympos_vmlinux.c   |  6 ++
 .../tests/generic/test-sympos-global-dup.sh   | 99 +++++++++++++++++++
 5 files changed, 116 insertions(+), 5 deletions(-)
 create mode 100755 tools/objtool/tests/generic/test-sympos-global-dup.sh


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1.750.gf70dc682cf-goog

