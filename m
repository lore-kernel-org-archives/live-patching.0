Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF54B0483;
	Sat, 15 Aug 2026 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786753101; cv=none; b=ZrGnQOs+RD6pQ9jbAo3/HkxL6H3JJqufYllb9FjDAMCx4ePBldnsQ7P8tnULHhm3AXbyHs60kkSDOsvtmV2lUMKBkYwcISpnt77Qx7Utaje1y/+GNdHYbQDAAXFwMFtVnufvz77WKrk/GcYIft0M71n61juLvet+oHbNBR5hPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786753101; c=relaxed/simple;
	bh=GRlo/VwvLaWMaECxtYSDovVt7utMWnIl8RYDLE9qPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwVTJWbtuRlzB5tKU38daFZgk7zr78RllCedwpqVuiNq3t3TkDNk0AvSJKZMHxKlavwer6rOYSheqRVi8H6V3yzMRuSRh5QV04isTULE9rPsgDnWbn7z9kY33p4A5aiMKhySNjtxEoAkK9t5VjrjKy2Owjjj9w3SuqAikBE8MKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW4795MV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW4795MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8795C1F000E9;
	Sat, 15 Aug 2026 00:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786753099;
	bh=NjTpRHK0ECdep4W+Ks0JC3Cu8rmYgtS3bM8274EkGks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lW4795MVAUFyZEMMPF/x69CmZdCGxdW+fHzsX0sRXiHzWUHHpKu1dcFP+J6lt48Gn
	 Q6nMrVuutdWUPsR0N5PMjKAAt4SH9kHpQhb/WdschspAatQcn07MPJQ5r3OIVKA0Oj
	 g6fBchmN/dSa3pfIFBvV59DeHXcvcb0NrSH4yW3ufWEKpTYpyOzk2JiICH4ll+A0Ok
	 Uw0QZfYI+pqaw2diqFE5UpXNhbyLAJEi9y4SXKsbyIvMPYJ0imPGryVMCqZCZo0y4F
	 1lYO5BIUIEOWccybx9lP4M+FTqPt2m6Wf8LWA4KZk1uPKtuwmp/5rP764NX+TaMs9L
	 taocCq4BaY/pw==
Date: Fri, 14 Aug 2026 17:18:17 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 8/9] objtool/klp: Fix relocations for
 EXPORT_SYMBOL_FOR_MODULES() symbols
Message-ID: <an-wHwTNX1xDxlRC@jpoimboe>
References: <cover.1786138493.git.jpoimboe@kernel.org>
 <fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org>
 <CADBMgpz7iWC0=t=_gE-tfvv0mTPq4kg0qQ2zgPH8DVPE6eQ9Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADBMgpz7iWC0=t=_gE-tfvv0mTPq4kg0qQ2zgPH8DVPE6eQ9Kw@mail.gmail.com>

On Fri, Aug 14, 2026 at 02:05:48PM -0700, Dylan Hatch wrote:
> Following up on the other thread [1], I noticed that when a patch is
> touching a module function with a reference to one of these
> module-exported symbols, the patch/module is rejected because KLP
> relocs referencing vmlinux symbols are not allowed from
> module-specific livepatch relocation sections. I was able to reproduce
> this with a simple module/livepatch combo that depends on one of these
> symbols [2] (see samples/livepatch/testmod.c and test.patch):
> 
> root@debian-vm:~$ insmod livepatch-test.ko
> root@debian-vm:~$ insmod testmod.ko
> insmod: ERROR: could not insert module testmod.ko: Invalid parameters
> 
> With dmesg:
> [  655.596876] livepatch_test: loading out-of-tree module taints kernel.
> [  655.600961] livepatch_test: tainting kernel with TAINT_LIVEPATCH
> [  655.605436] livepatch: enabling patch 'livepatch_test'
> [  655.609119] livepatch: 'livepatch_test': starting patching transition
> [  656.653454] livepatch: 'livepatch_test': patching complete
> [  738.777872] livepatch: invalid access to vmlinux symbol
> 'get_task_policy' from module-specific livepatch relocation section
> [  738.784899] livepatch: failed to initialize patch 'livepatch_test'
> for module 'testmod' (-22)
> [  738.790371] livepatch: patch 'livepatch_test' failed for module
> 'testmod', refusing to load module 'testmod'
> 
> Do you recommend a strategy for working around this, or is this
> something that would have to be fixed in the kernel?

Ah, this is another tooling issue, let me work up a patch.

-- 
Josh
