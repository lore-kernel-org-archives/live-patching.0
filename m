Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF131619B;
	Wed, 12 Aug 2026 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494198; cv=none; b=ek4/K0foZigCg4APjTvHickhQJN/l5hTwBV7MDsmNyrUnVIgkCDuHtOUitbFpyFjkObdbL7htAnc5iAFGUjxgLQrG30spx98sa/5ng6FKBOd6G6V2OXc2/vCYvdxaOYqSp4/asoMPYwtEJzQeNeL+gu85j36FIwy7v+Ocr3WVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494198; c=relaxed/simple;
	bh=BfUVxfBq9AiNKdwz2/DArCcvNRDKsYKj3DVmErfmFzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQnpFjBrFFh8UIfHXfsn6fMsaKyqcg840e9zye9USpZZz423it13nNsSafYX8H+gQ2GD87F0z1AEvWvc8ArBcrA6rNY9B70KNhrdorMfmjPTnofFhrX0uKYoVXN29nA1rHy/22KyGoFWIPhsZD4FH6UFbGMrkV2Rw3tNF7U97QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv6ul+a4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv6ul+a4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEE61F00A3D;
	Wed, 12 Aug 2026 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786494189;
	bh=HVqfjQiQHCa9APiBAYTwHxe0w4t0H0mT5QhnLN7jra4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jv6ul+a4EGrYnKqOsRMwHpw8/KSOgGmlSlk/Rke8ZBPg6CCZco8iVgFsPMlka6+3d
	 pM99tZFn06OVlT5TqpgWl7HuhhTBrim8JyhhlGZ8Ktmo3gsnVbpbXyh7OtctQDftTk
	 9JJ5/ezVGMponksoHDYaKv2Jhva4ibS7IoADLik4MSi4LyfzvbaF/MW/PnMj60fu1Q
	 R5hOJAg59PWZJdBM8IU2bcG/Cp2c2bN2AUKutcG/9NXClIJqwUVOqx0RKl8bxaT3wy
	 XAnYoBmUyE5JSG3kBQK5D8xnYoTrM62lDC2bhWJbeNywWTQF0IzGeVCoKdmKdxvY/n
	 LAToTCpxMlvtw==
Date: Tue, 11 Aug 2026 17:23:06 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 14/22] objtool: Reuse string references
Message-ID: <anu8su4kuf3eUF3c@jpoimboe>
References: <cover.1786230311.git.jpoimboe@kernel.org>
 <e0856be4208a6bed2b22dffe2bf8e010470f49cf.1786230311.git.jpoimboe@kernel.org>
 <CAPhsuW6JgV1a7jMxQ0bknOpQ7WQNSqYbAHWss18GCrzGZ79OcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW6JgV1a7jMxQ0bknOpQ7WQNSqYbAHWss18GCrzGZ79OcQ@mail.gmail.com>

On Tue, Aug 11, 2026 at 04:52:51PM -0700, Song Liu wrote:
> > -unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char *str)
> > +int elf_find_string(struct elf *elf, struct section *strtab, const char *str)
> >  {
> 
> elf_find_string() returns -1 for error and positive number for addend.
> It is a good idea to add some comments for this behavior.

Ok, will add a small comment above the function:

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f6219f495efdc..f9a4226f115ef 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1410,6 +1410,11 @@ int elf_find_string(struct elf *elf, struct section *strtab, const char *str)
 	return -1;
 }
 
+/*
+ * Add a static string to the strtab section.
+ *
+ * Returns positive string offset on success, -1 on error.
+ */
 int elf_add_string(struct elf *elf, struct section *strtab, const char *str)
 {
 	void *data;
