Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367822F49F6;
	Mon,  3 Aug 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738275; cv=none; b=amRpu8efTGJpl/hQIY9X5fYoTPWAdj5e1/IwSudMYC0pgc+rj3Lglictc3l17vf2+yONDpz7PqBLzSmpScA4hB/49G1+Vro26i56UeetSUExf52eTdGyV7QF6M7sAsrTsEL/eBRKR7s7QdvS9iTp4oivxb2YLAlAkZZr0IC1UYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738275; c=relaxed/simple;
	bh=+qpl5A4qedpzD7nqclH13TiUNbNiV1T4qnKKpDgaLLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYMWUlAWwEii4IDnGfGyLER67P0r0mwFJranrIoqLGu+DgaW7IgtdtXOmOFIXDvQQs66PN2Ql+is/ad/3JInZzJf5ZrSMkitTAm65iDqhk3gNcD5d6kQw3DlkEqvPxWOsHjE3GgYBRcMIlO/0drSr34TcvFKz8l2I3EPjx4Rmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh7QtTJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh7QtTJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2021F000E9;
	Mon,  3 Aug 2026 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785738273;
	bh=0SUlHOvzvNtuHEL4jHvhZn+t3I9LqS3+mLNP8h+hNRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wh7QtTJHZQ7aG7QdujC1tYwNHtEnXVTncwlawayK+55bt7AaDJHR258hpzAMghaa9
	 a7N5CF5BJLrN+vOOqnYRFQXvVWtybwrGnGexd2zKY/tJ194VlJU9kw8vDUlOkIxxld
	 NsL6OW57h//6OwlI8W68Bsp2SA46kGklxZcTLOlxUnvFYQGa3Lj6tpabo1yIARUegq
	 X3yYUnTuOJYXbBIiFZtRpvpL6R4pwBb+rN65FNo6s1pr/eOV6dXSB+PcUTASoIMJH9
	 xxL2bRfEccXz4T66xj+QOnO3H6oUsQ7JXCO3MbylVrbSg/c5R7R3M4dxIFPq6xHwRg
	 OQLW5b77VhdLQ==
Date: Sun, 2 Aug 2026 23:24:31 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 07/14] module: Add module_kallsyms_on_each_core_symbol()
Message-ID: <uujknkk2vlo5fwud2piiyt7iqjic74rx23hcqulsv2eksbse2o@4ukhz52awr2z>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <9ff8d9f0ad20a9a5cdbab3fe650d3532688065d4.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ff8d9f0ad20a9a5cdbab3fe650d3532688065d4.1785727106.git.jpoimboe@kernel.org>

On Sun, Aug 02, 2026 at 08:24:29PM -0700, Josh Poimboeuf wrote:
> module_kallsyms_on_each_symbol() iterates mod->kallsyms, which points at
> the full init symbol table until do_init_module() swaps it out.  The set
> of symbols it reports thus differs based on whether init memory has been
> freed yet.
> 
> Add module_kallsyms_on_each_core_symbol() for callers which need a
> symbol's position to be the same before and after that swap.
> core_kallsyms is fully populated by add_kallsyms() before the module
> leaves MODULE_STATE_UNFORMED, so it's readable on both paths.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

NAK

The Sashiko comment made me realize this is not worth adding kernel code
for.  A duplicate symbol name between init and non-init module code is
somewhere between exceedingly rare and non-existent.  I'll submit
another patch separately which will make it a build error for now.

-- 
Josh
