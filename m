Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43538418357;
	Mon, 10 Aug 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379986; cv=none; b=m8kL/hlyjn3byNbEo/KRQRruqakguolyaXNNJdylVmTr+z4ha1/KlSi2cXU5i52bgxaVSDz5QtCSnK8A+1MjopiXbTyB6aP9DwbRy/vt58/0R/2gvMoti3wIXC3PAmZ6VTcV2h5SGf1iVlAEdL75ywHUgffTobkZviprzNO81WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379986; c=relaxed/simple;
	bh=uipurMZBASlNLrVN2OvJLmszN9NkURq4gwkL2qI+MBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvjBAOu3bR7AiJ5sGtYWKfVB8MBolApAvCUcqovSJ/URgizGjzvhyp9h1BU/vq/QEUiAdi6SGhjCY0/je6/XWXR7vkXMLN4idlZxRTMnOR2PElFtBY/fUVougKZIDmxoNL6Y0C2jWBOL/Z3UTJD67uvcfj+fxBN44X/Vhu5ghTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBRNfr36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBRNfr36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44DA1F000E9;
	Mon, 10 Aug 2026 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786379984;
	bh=CVu92b+yPVxa19m3thLaljXsDLfDZDCzX7siE8A8W2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jBRNfr36CLRBXRGKnpuWdJPv37kp3N+9mo1FWp7sRheDxVIpLJcPrZFG7rL3q5QHQ
	 Hq13DzQEdBqq3e/gbqzEql+D5kJX+SKNBYNHMG95TN3S3IrXwEIQhjb/kcRCIbd56N
	 r82rrjkr7wzLpO81u+iDQ2WR5ywFByxTXvpiDfWNzS2xKGZlcH4hZWZJxGqc4DRo+x
	 xP4pQdwKP5bJzSHhnGqHNBT9226ur0j95DxgwkcbEy5UPtV3PWJ5x1lF8sPjxJCd+M
	 L8nVakOrg96xnClA/049tCtkRncYq5LP7BFAI+j0wjzTeOglGfGcLJuP0o+i9BlH7I
	 7t4W30VXKMQWw==
Date: Mon, 10 Aug 2026 09:39:42 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Message-ID: <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>

On Mon, Aug 10, 2026 at 06:12:10PM +0200, Ard Biesheuvel wrote:
> On Mon, 10 Aug 2026, at 17:48, Josh Poimboeuf wrote:
> > In which case I think to properly support BTI going forward we would
> > need two "veneers"?  Either that or remove BTI kernel support
> > altogether.
> >
> 
> Yeah, it seems we did not argue our case convincingly: their assumption
> that veneers/PLTs can be placed within -/+ 128M of their target does not
> hold for us. But I don't think it holds for .text sections larger than
> 128M either, so I'm not convinced their reasoning is sound even for the
> general case.
> 
> I suppose we could special-case the PLT logic to use direct branches
> where possible, which would probably catch most of these (assuming
> .text and .init.text tend to end up close to each other also for KLP
> modules)
> 
> For the remaining cases, we'd indeed need a second veneer at the callee
> end (i.e., inside .text in this case) that is emitted when resolving a
> cross-section indirect call to a function that lacks the BTI landing
> pad. But that would be its sole purpose, so I don't think we should go
> down this route. Instead, the 'address taken' check should include 'called
> directly from a different section'. Emitting veneers to work around a
> compiler optimization is just plain silly.
> 
> I'll try and poke people on the Clang side of things to revisit this.
> I guess that leaves kernel BTI broken for the foreseeable future but so
> be it.

Ok, so for now I suppose we need something like so?

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 06b30924509ac..972988238f367 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2117,6 +2117,8 @@ config ARM64_BTI_KERNEL
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
 	depends on !CC_IS_GCC
+	# https://github.com/llvm/llvm-project/commit/7af2b51e761f49974a64c3009882239cea618f2a
+	depends on !CC_IS_CLANG || CLANG_VERSION < 210000
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
 	help
 	  Build the kernel with Branch Target Identification annotations
