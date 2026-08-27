Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0D361947
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858615; cv=none; b=L0ntygKe18ihSSgwWhBJizBAsEnhiJ2IMR18pqx/UejuHf+TIkRNqtD95qDeexTkk+hGXL9aP53hlgCHSsGMBe3OuaFpZGcF5mSvIH+X+c40lGnHiu+dc+2YjRHPbi7nnIAycXprq317oC0nB+fxgpnY2AcKDce1oGnj29Id0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858615; c=relaxed/simple;
	bh=Wf522A/L0nRgKkhFC0rLmrGayA03uFv8v2PkYgCCLMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjakPWEPwFqtF7RUwNeaYO/ZJC2uyZI8KBBEuLUjDctvm3tc/IUeTgQpO1LcuSaeRLNknPciEgwgVIl6mk4w1wsgpVQGlXBhm9PY8vKM20gLEHwnATI5XQNNayhoD1t3NKXrMpnXrk7lGM2FxPuvTL8i6GGkFIZMU823AWSEgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CspS9sCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CspS9sCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D295C1F00A3A;
	Thu, 27 Aug 2026 19:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858614;
	bh=abmkoYPEyayR4cT6+ao49juNFxLE1VqKoRYPb6KccZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CspS9sCFP0iHWMPY0V6rHofioJ7WLE5CZME9yTRpWr+Pk78wsFSx2KwFk69TohiiF
	 q8bZsZr+UNPNDJaozCZ+tXPlnhtibHdOhFpIzsysqwMVat7T2aikyrePVv5XrAHdIX
	 QAtUY08Ww2O0wJAXVrGsw9gf29VxUD1CrbunSNdZ/tbJTkNZFtin0idqKjJ9lTxLPz
	 XZBmoaeGBZj5QPN2VOZWI/7Ynovg+tvKzAtX+sRJyfOMCM9mx9r0IQYAxCGjHz6742
	 dG4T2U+L7Y94V9X7Tuzk49XccxLDIWcy8c9v/vovPPXDQ0ciU2Dz/6sXIK3UhorKly
	 K+tr6H6Y9zl5g==
Date: Thu, 27 Aug 2026 12:23:32 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH v2 4/7] objtool: add target architecture to usage
Message-ID: <apCOnsZAwbn4UvH5@jpoimboe>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-5-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826195000.455905-5-joe.lawrence@redhat.com>

On Wed, Aug 26, 2026 at 03:49:57PM -0400, Joe Lawrence wrote:
> Display the target architecture in the objtool usage string so that
> users can identify which arch variant of objtool they are running.  This
> is useful when cross-compiling and automated testing.

Can you elaborate on why this is needed?

-- 
Josh
