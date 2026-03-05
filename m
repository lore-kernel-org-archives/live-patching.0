Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924192F5A36
	for <live-patching@vger.kernel.org>; Thu,  5 Mar 2026 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739517; cv=none; b=hinhISeVRE0ARGNYULyso7tSZ5bqoJe5gGy5LgXQ4/ISbQbDLqTHcDKRCn1X0N5w4ZLXEHtLUNG651rgoL/Kelhjpd1NHekkFffZuaF0t1nxorWunsoZIPtt7xoSiUdW70N5RRIxmETop5UeBrmu6Pknv+/zsWx7qhMRgkJP+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739517; c=relaxed/simple;
	bh=JNL+EcooIV0QgYx9mtEnjcmMpxsPDmd9BeXjcNWIxQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhwLb9qovdROeoeIMPIL7kIHi9yV8hrA7HOJNhZcHF6j1C5Z3tIJID8FO8/usKOztxQ4mRjzst+gphM7zosl9B9CZ1IWhoACOQ2UJEbM75/l2ZxuVh5nB6BrcMruwkHNGSAiVCmRe05bdfrlmR2n7bn26xt68OOoAiuCdrPomyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsSQElid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsSQElid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A93EC116C6;
	Thu,  5 Mar 2026 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772739517;
	bh=JNL+EcooIV0QgYx9mtEnjcmMpxsPDmd9BeXjcNWIxQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsSQElid/2oHztO3iswvVIyZZab6m2Cs9yDnL4KG8fExgp0X7XTzcdBpC00nUs6M6
	 2t5cexs9hgvSgQF4kSSxxVvCEs75YBXYqNkHRYb36vkX1H8h/FtbxMTj7+hU/Ku8Xs
	 IVTbwJmBuXtZlr+Wmv8H2bNGd920cBczyfgMwzAzrZCeL39FOPqmG21JhxikDvTp/q
	 pcH7mYb5vwzT0djrJ+tHYaYhz7l28/zwD7AVJxFQXaV1p4ld9C9nnQa3xagj5pzGRN
	 cJbsSUAcOgVJVtCluQaA1ptXc+qNFc8VKBlKUh33o8uMnrDrRX75aaxV213YYqsffe
	 0St5ZL+SuT33w==
Date: Thu, 5 Mar 2026 11:38:34 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH v3 1/8] objtool/klp: Remove redundent strcmp in
 correlate_symbols
Message-ID: <a5dvhxvye6ix6irath7yvlpm5opuhd3azuldz3vuol4gg5kdpx@ih6lmhuzwyo2>
References: <20260226005436.379303-1-song@kernel.org>
 <20260226005436.379303-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226005436.379303-2-song@kernel.org>

On Wed, Feb 25, 2026 at 04:54:29PM -0800, Song Liu wrote:
> find_global_symbol_by_name() already compares names of the two symbols,
> so there is no need to compare them again.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/objtool/klp-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index a3198a63c2f0..57606bc3390a 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -454,7 +454,7 @@ static int correlate_symbols(struct elfs *e)
>  
>  		sym2 = find_global_symbol_by_name(e->patched, sym1->name);
>  
> -		if (sym2 && !sym2->twin && !strcmp(sym1->name, sym2->name)) {
> +		if (sym2 && !sym2->twin) {
>  			sym1->twin = sym2;
>  			sym2->twin = sym1;

Subject has a typo ("redundent"), and function names are missing "()":

  Remove redundant strcmp() in correlate_symbols()

-- 
Josh
