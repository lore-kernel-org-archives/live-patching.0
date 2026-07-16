Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C56431A22
	for <live-patching@vger.kernel.org>; Thu, 16 Jul 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223598; cv=none; b=aViiF2YswRwW5gWdtEZcLJYoTqYjVaPru2qNUjrThPzhfsajCtfvZS6cN2sxQnEbi5HWnO9EmwGuYj2YAsWDkkUEpHA8lDVeK833cWmVpTDUuf+fA5YA8wbx4eCsLSFsheLF0fjS1Zw6YSnf/ARSMhVPbm07EnApOroaIa5Ysi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223598; c=relaxed/simple;
	bh=9PG9WScnfia3OwP9KGvORIwkC5o9j6BLODaiyqj/MUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufSjea/tZSUNzqh9BrVKY8Aa8B7Pk/7fh/fAKQ1fRhhTUWDG25uNiR+Lq7FEBz1iLRVap+lyOmuF7NluxFyATqKeTSMUj+jVkGNSzWnYIswD0uVLbIxq56AUI7rJiIcvEIyIkSiSRr8/QWSHr5All2/EeZdSbNw3cv5kysmLwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hbfcd1zw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hbfcd1zw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so1426074a91.3
        for <live-patching@vger.kernel.org>; Thu, 16 Jul 2026 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784223596; x=1784828396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=chN8aLVvFGWQ+JrcCF2Cd3o3W+9FD6vs9BxYNNUH/BE=;
        b=Hbfcd1zwWg8TOTA5QT+Ff+ZI5XwrQ5yY7j8GiDqQAmcjfgvjoaEonGYfeaP2mQjKWd
         bPstZKeYt1mh1WB1JW+Ul5GOgXeZ2Cb4nb+pONuhcxyutHNoXVDappmaCZOSFkGQLIyZ
         6bF/Q8ob7M1I4EEGvcizQqWOH4UYlBe2BXguI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223596; x=1784828396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chN8aLVvFGWQ+JrcCF2Cd3o3W+9FD6vs9BxYNNUH/BE=;
        b=RjgCwYbuNCmN4zL04xGVykcx47XlFjGK28TJd3HRTP8vgA/m381U4l9OowGAtnAcxA
         2nnyDHB64InUUXn9OpB4nbhlMqAOvzMU2swcGz/toMZkZEtYgI+4qYKkb67djWVmqaUW
         tYn2pbzJdwd/YxVR0f43IWjjwtle/qcJYncsxPr1/Wwt6dyr1u0m6rXSZp0L4ESjTCQo
         Rh6YO9r3ZF8VGGZH4f2Elacg1inHEEFfvZYGCLIjArRFe9X5O/AhBuU38pZZmnruiqlv
         qjlBcnNKsK2HOqnvTEg2b7AtpNMzDorL/kco/oqPOYLWOzUjhK3t1D/rvuRnSRLd6PSO
         4Vcg==
X-Forwarded-Encrypted: i=1; AHgh+RphmJMMlIGkt4sBl6ObSdszbYBSg3te0H7741J5ir0mtBsWssQUrHGYMbDC3m+UsQ1Jq0n1nd5sMSfErLRb@vger.kernel.org
X-Gm-Message-State: AOJu0YytJFs0FqlDFEJgoIxlIwV6Z1/+2BgxiXwo35muROtyaqRypBU4
	Kti8l34S2hKsVdh43aJmKxRBrv/yWVVlYWUdX1H77w4+ng3USnqEBhC45x6eRp++fg==
X-Gm-Gg: AfdE7cl8IoIV1PB1uBq5K7wgonnfKHqAAGaIF5PxR+kWZiWdv0SzAUVx69BYq6nSUBb
	PhfrbyDl7TnPTAeA3m8yI9hzuDYj3qyNJ0u2Z7YzvyejTo0+KG9lxp4kXDI7EL+IZAIMB4ESJwF
	cnF0cwHwPlQhsBQ71zFliZTJb8YlU4IkN1d1m9xbWLA3VmyJlz/oLk0r8m7XMDlYsWpStXr+Lq8
	IBRa+/qR0ZQINsspxeBrrjM7hYe8Mgtz22GsHPoC2g6jW45VsRCNUWxN9V8RzgxM6SbVnj7Q1d0
	ZCaBM1cd8cbWGbbYexEew1z6DorO5DBqVF4S26sLW6uZ6sCiKalsoYl4dZcrS2uhI00GC389A86
	WhTdcKNDW4zbDI8d7oKwVjhKgCOFlv6w3SsOus7vq7pp1EtQ/5sLYOARBjgj0YG7zPiomsuzUmQ
	jC59kwDzznjSOBDKuId2Ob/6WLHG6wfgX9lRd4YMUm
X-Received: by 2002:a17:90b:1a89:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-38e1add8ec6mr9675333a91.8.1784223596017;
        Thu, 16 Jul 2026 10:39:56 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:53a1:1e69:10ef:bc65])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3140e5647aasm13360547eec.13.2026.07.16.10.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 10:39:55 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:39:52 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Indu Bhagat <ibhagatgnu@gmail.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Weinan Liu <wnliu@google.com>, Will Deacon <will@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>,
	joe.lawrence@redhat.com, linux-toolchains@vger.kernel.org,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 0/8] unwind, arm64: add sframe unwinder for kernel
Message-ID: <alkXaGJpP5BhU1a_@google.com>
References: <20260428183643.3796063-1-dylanbhatch@google.com>
 <agcEMEl-QR0g6DgF@google.com>
 <CADBMgpx38SUUuYYCm612STqh01jqv817WnJeeXYTD7Uc1r-fug@mail.gmail.com>
 <4f429a50-df5d-411f-b40e-048d3cad5133@linux.ibm.com>
 <alWCuAA7r1otvROg@google.com>
 <6e0d0afc-8a54-4763-b25d-dea122c4cd12@linux.ibm.com>
 <alezZ6tDIXSBY-v9@google.com>
 <f2be839a-07c0-4884-9cc2-afd37d025f9e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2be839a-07c0-4884-9cc2-afd37d025f9e@linux.ibm.com>

Hi Jens,

On Thu, Jul 16, 2026 at 01:03:35PM +0200, Jens Remus wrote:
> This proves thet assembler option --gsframe did not originate from the
> kernel Makefile, but was supplied by GCC for the assembly step.  I guess
> it gets injected by some GCC .specs file.  Please review the output of:
> for "sframe":
> 
> $ aarch64-linux-gnu-gcc -dumpspecs

Thanks for all the pointers!

$ aarch64-linux-gnu-gcc -dumpspecs | grep -B 1 sframe
*asm_options:
%{-target-help:%:print-asm-header()} %{v} %{w:-W} %{I*}  %{!m16:%{!m32:%{!mx32:%{!ffreestanding:--gsframe}}}}%(asm_debug_option) %{gz|gz=zlib:--compress-debug-sections=zlib} %{gz=none:--compress-debug-sections=none} %{gz=zstd:--compress-debug-sections=zstd} %{gz=zlib-gnu:}%a %Y %{c:%W{o*}%{!o*:-o %w%b%O}}%{!c:-o %d%w%u%O}
--
*distro_defaults_asm:
 %{!m16:%{!m32:%{!mx32:%{!ffreestanding:--gsframe}}}}

I looked further into the bug trackers here, and I see that:

(1) it seems Debian testing(?) and Ubuntu may have enabled sframe by
    default

(2) my distro is Debian-testing-based

(3) other people have already requested my distro disable sframe, due to
    issues like the following:

      https://github.com/rust-lang/rust/issues/155704
      https://salsa.debian.org/toolchain-team/gcc/-/commit/bd33f862a3f93c3d3b1fbc8dfb6b0366905d7ab4

I'll follow up with these to make sure #3 is fully resolved. Hopefully
that resolves this problem too.

Thanks again,
Brian
