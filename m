Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2F1A6836
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858266; cv=none; b=IdhPhU4ePpLLpDa0GgQQ/FSYsHxaabNaNzMC4QEmrSviDeGNixh8wv9D84n+SAeWtBAqGBebctIkXBPWNHcFjgMja4UvT/Tlc7l1MtdZun6UTb4JY+CTWJ3TuJBMzIYkum6NPpCpo5hvMQCABYCAGf29MKt+0FAnlHoU8Eyr2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858266; c=relaxed/simple;
	bh=L9wPfTTxt7okj9GilnyO5zinvXN7P+FdglTLAfHtgWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnT2psCySC439JA49AJocEgfUdHW0uOlVAUqiM++Xcx6V0D3yyg7G7/BRJq13O/FLU4qpTUorRIuTJ6Dw1iXPLbHFdiWS5tbt4rnLY3cgABLy+a6Qc6cbFjKbug12Wp9VAFATSlfEyco/CuDLQD7V+4SRyXSpCtnfYIybq7vNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2bp668Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2bp668Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9641F000E9;
	Thu, 27 Aug 2026 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858265;
	bh=Jl9t1jmI7nl0unim0awIxKWLPHj60XWZ13oDHAyb0vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e2bp668Z0OFD+0mdjPa+rOfhf6J5WmhkZnSU7DBBHc3hG9Pbopv4ID6R1dMYY66lX
	 UXaEo+xSA3530OtjazwQbBbnm1KJTX3TBPNncqQGOl/N3cNqn1SWbpONZwN592aBLG
	 wOVoe9EHUnXcQGTlc+FT6rP2RfHHwCjXlEXL2+v825Lhh61eJgj7RSY5mKFPePMQkO
	 n26Imd/oUDrU8Ly/VMgRJxTDWVsZzmPYl9+D1htDK3SLE1JxTxElJZyzaKge671SY6
	 Gt6BYQtvc8tTPP9oG9V2y0ou4HCRM+TkPJ0Pd05c9+X7R/kJ+s/EGyUc6EYLiCwM6D
	 GA57cSCTAMwbw==
Date: Thu, 27 Aug 2026 12:17:42 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH v2 3/7] objtool/klp: allow special section entry size
 overrides
Message-ID: <apCLS5bkx-GF8ffY@jpoimboe>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-4-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826195000.455905-4-joe.lawrence@redhat.com>

On Wed, Aug 26, 2026 at 03:49:56PM -0400, Joe Lawrence wrote:
> @@ -1781,6 +1799,27 @@ static int create_fake_symbols(struct elf *elf)
>  		}
>  
>  		entry_size = sec->sh.sh_entsize;
> +
> +		/*
> +		 * Some special sections have multiple relocs per entry,
> +		 * so the reloc-based heuristic below doesn't work.  Use
> +		 * the arch-defined entry sizes for known special sections.
> +		 */

This comment doesn't seem correct: for the special sections with
multiple relocs per entry, the .o file should have annotations for that
(either entsize or ANNOTATE_DATA_SPECIAL).

Also the comment doesn't seem to match the commit log (that this is
needed for unit testing?)

> +		if (!entry_size) {
> +			if (!strcmp(sec->name, ".altinstructions"))
> +				entry_size = entry_size_from_env("ALT_ENTRY_SIZE", ALT_ENTRY_SIZE);
> +			else if (!strcmp(sec->name, "__jump_table"))
> +				entry_size = entry_size_from_env("JUMP_ENTRY_SIZE", JUMP_ENTRY_SIZE);
> +			else if (!strcmp(sec->name, "__ex_table"))
> +				entry_size = entry_size_from_env("EX_ENTRY_SIZE", EX_ENTRY_SIZE);

I really don't like this because it removes klp-diff's hard-earned
agnosticism about these entry sizes.  And they should already be encoded
in the binary anyway.

-- 
Josh
