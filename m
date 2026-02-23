Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C437C0EB
	for <live-patching@vger.kernel.org>; Mon, 23 Feb 2026 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887531; cv=none; b=azX+PjQcDkS5zde33LwPRNBYuVmdcaY2Inix9UpDyGwcxSzH0Y6shPgz/4HSQXR7CUadztj6gH+mhMF+YoapWK9OVZ/DkdQ0leE2Vx1sWD/ljG3lYqA1PXdodUgcdXq1M0OdJjQwLXDqmtdNFyS/e5UHMdCB+xc/ud4+1bcZxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887531; c=relaxed/simple;
	bh=Sczo6DdNQ7rITnahS/qSnssi0MiR66A9njSdQNTYdA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR2rpVFHWu60gTAKCf3nH6nyPcLJxNZi3XAgmT3GK+u3aoP2Yr5NAXq8o0qdmlaQfxX9XdfIeSvj4ERo9fsRHQjPfWfa0IxJJ9X4uZGBYiqX/5qI2DxnuvptXm4D4nfUmvdpir0OB9A1ZSKlKFFYFb233lBL/3uuS1K46b9zdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux2+LVEq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux2+LVEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0356DC116C6;
	Mon, 23 Feb 2026 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887530;
	bh=Sczo6DdNQ7rITnahS/qSnssi0MiR66A9njSdQNTYdA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ux2+LVEqzd3d/ZGa921QRfvQTmpqMqDdO3bMmGL+Xl1M0T19xwOPrx099WhcjFF8i
	 klP4yhfSjxtlm7MllV2+r92H8Ta/9zkb3XKPRDIJQ101UQApQyAaFHHtCEjmtiV3Ul
	 MYsi/pMOm4hf/h3yTZEDDTw3nNtKNwZKOyXvgaN/8IzNOmo7UfM3xCAPNNwA/nwS6z
	 0N54dz05bvHsSABj2NKBpAHJbztRrEHyTIh/0Pm7rrfFfPyqcmrYCZpS0beDaXq1s4
	 g86QGM+D1oScEusZ6CWp/3ux06+HsTVBOpad80xyqMI34J/IDr5HeRkGsglFzjsj5d
	 U92pV31ol8LPg==
Date: Mon, 23 Feb 2026 14:58:48 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH v2 7/8] objtool/klp: Correlate locals to globals
Message-ID: <mkrgmnqv6djhzxvjqzjicenpscwwwz6kojhqeo45qbh7gyr4ar@2fy6hit2kuli>
References: <20260219222239.3650400-1-song@kernel.org>
 <20260219222239.3650400-8-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219222239.3650400-8-song@kernel.org>

On Thu, Feb 19, 2026 at 02:22:38PM -0800, Song Liu wrote:
> +++ b/tools/objtool/klp-diff.c
> @@ -519,6 +519,37 @@ static int correlate_symbols(struct elfs *e)
>  		}
>  	}
>  
> +	/* Correlate original locals with patched globals */
> +	for_each_sym(e->orig, sym1) {
> +		if (sym1->twin || dont_correlate(sym1) || !is_local_sym(sym1))
> +			continue;
> +		sym2 = find_global_symbol_by_name(e->patched, sym1->name);
> +		if (!sym2 && find_global_symbol_by_demangled_name(e->patched, sym1, &sym2))
> +			return -1;
> +		if (sym2 && !sym2->twin) {
> +			sym1->twin = sym2;
> +			sym2->twin = sym1;
> +			WARN("correlate LOCAL %s (original) to GLOBAL %s (patched)",
> +			     sym1->name, sym2->name);
> +		}
> +	}

Try to follow the existing newline conventions which break the code into
"paragraphs", like:

	for_each_sym(e->orig, sym1) {
		if (sym1->twin || dont_correlate(sym1) || !is_local_sym(sym1))
			continue;

		sym2 = find_global_symbol_by_name(e->patched, sym1->name);
		if (!sym2 && find_global_symbol_by_demangled_name(e->patched, sym1, &sym2))
			return -1;

		if (sym2 && !sym2->twin) {
			sym1->twin = sym2;
			sym2->twin = sym1;
			WARN("correlate LOCAL %s (original) to GLOBAL %s (patched)",
			     sym1->name, sym2->name);
		}
	}

> +
> +	/* Correlate original globals with patched locals */
> +	for_each_sym(e->patched, sym2) {
> +		if (sym2->twin || dont_correlate(sym2) || !is_local_sym(sym2))
> +			continue;
> +		sym1 = find_global_symbol_by_name(e->orig, sym2->name);
> +		if (!sym1 && find_global_symbol_by_demangled_name(e->patched, sym2, &sym1))
								  ^^^^^^^^^^

should be e->orig?

-- 
Josh
