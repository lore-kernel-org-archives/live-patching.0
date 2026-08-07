Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2363D668F;
	Fri,  7 Aug 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142505; cv=none; b=WnH9pBnTk7Qj+7cSe0G07tQcN4IGGmctsd+wMwk67ao4CdrIwi0VkDvAcm7hoCipbToZxx9tSQ5Q438kUJ7gkZVbCxvF0br0hXXSPS9GLPmR229DpkLtHjIoT9bsiICjGVAjX6s98PUKYU7k1/bbhXpAxTnCf09BC7C6kBiXk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142505; c=relaxed/simple;
	bh=rwu8ziDflqaAo9tcfStfkPUnkKcF92J8OHVKfh2yNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUmskn9c3aBDXtuyzIB6lkO7GaL8wCzRPjAvJRM1nsd+9TBAKIuUIUAc3dy/GBbjKEn0MF1XFFwrX1J9J934xQ/VaMqtBZHBVLPSCpl18s7CunRL23IbUl2oFMUvONskLumhZR1PlsMEy6/Tkz/rKMFf414RO3mn70sBCGm4D3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAEbHJcu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAEbHJcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A004C1F000E9;
	Fri,  7 Aug 2026 22:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142504;
	bh=1ltPkPRcOEcmiZJZYZ1L81HlsO2xE3TBDMrD6BDUdto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bAEbHJcuOp+h+oilLLZYqqore7+dtKY4Q+dhmcok8le3vKwhqB90ibK72Em2rYbRY
	 m8e+yxibo8G8XYI4yIl+hTKqfYkeqsLe0Y0rnNz8xHmCn3qkgsHAFWEnBjJuj93/AZ
	 2vFm4oyraBmHiKCybhziZPzz4HoWuj5Ko/tXYX/+yiNUvqkwyy/9asF+9tn3UKQyh8
	 GOxu6/n+ehSZSDnqHp/HCksD0byyyScKuQCW76ZTsC7Q7ueeeT1pPEKmAwKxokWngs
	 M06Fig8cnPFY5oc2FBn+/hrQeWyD8jiE/5rNFB96VQUsfU1RfCaR79xZvf8BzTaG9T
	 ZXvXo0lrJj0wg==
Date: Fri, 7 Aug 2026 15:41:41 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Song Liu <song@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joe Lawrence <joe.lawrence@redhat.com>, Will Deacon <will@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Nicolas Schier <nsc@kernel.org>, live-patching@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 09/21] kbuild: Only run objtool if there is at least
 one command
Message-ID: <4bjd5d6sbmhorxcmzoaswr3emdhybswtjo5nbdsgtb3sxe43ip@eayelnnw6fi7>
References: <8699672b82fef17e73a5f2e5528478778dbdab31.1778642120.git.jpoimboe@kernel.org>
 <20260514222516.D2437C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514222516.D2437C2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 10:25:15PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Leaking objtool options into vmlinux.o validation causes a fatal build failure (`--cfi requires --prefix`) and silently alters validation behavior.
> --
> 
> commit 68e454f3a8ccd3d638c67c092eee264996286695
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> kbuild: Only run objtool if there is at least one command
> 
> This commit splits the objtool arguments into commands and options to
> prevent objtool from running when no commands are enabled.
> 
> > diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> > index 527352c222ff6..09af33203bd8d 100644
> > --- a/scripts/Makefile.vmlinux_o
> > +++ b/scripts/Makefile.vmlinux_o
> [ ... ]
> > @@ -36,18 +36,13 @@ endif
> >  # For !delay-objtool + CONFIG_NOINSTR_VALIDATION, it runs on both translation
> >  # units and vmlinux.o, with the latter only used for noinstr/unret validation.
> >  
> > -objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
> > -
> > -ifeq ($(delay-objtool),y)
> > -vmlinux-objtool-args-y					+= $(objtool-args-y)
> > -else
> > -vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+= --werror
> > +ifneq ($(delay-objtool),y)
> > +objtool-cmds-y					 =
> > +objtool-opts-y					+= --link
> 
> Does this code unintentionally retain the options from scripts/Makefile.lib?
> 
> Since objtool-cmds-y is cleared here, commands like --prefix are dropped.
> However, because objtool-opts-y is only appended to, options like --cfi
> remain active.
> 
> This causes objtool to fail with a fatal error: "--cfi requires --prefix"
> during vmlinux.o validation on configurations with KCFI. 
> 
> Should objtool-opts-y be assigned directly using = or := instead of
> appended?

Indeed, adding this on top:

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index dc0a5d19f383c..729f82eb85b35 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -38,7 +38,8 @@ endif
 
 ifneq ($(delay-objtool),y)
 objtool-cmds-y					 =
-objtool-opts-y					+= --link
+objtool-opts-y					 = --link
+objtool-opts-$(CONFIG_OBJTOOL_WERROR)		+= --werror
 endif
 
 objtool-cmds-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
