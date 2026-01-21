Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00458425CF2;
	Wed, 21 Jan 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029469; cv=none; b=DTHmpCX1uobQwFVKi9AgaTE7OVWX4OW0RhCinOwha7wPpRuERVerRwCVNBXIvNadQlpyFzl9P4sCWo73VLkFf3Os/7hKfbymxTc/eMXJhXn8iMrllJGgbcweXx/kQY+SWcldkJV2hel2KQhHVPbkwUaKD68bX8YPxD9/HEhDZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029469; c=relaxed/simple;
	bh=vwU3Ze7jvFloOb/ZR8n9fLTnuD9K06QrgUL8i710Cf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTJTPrAaBYBqZkvJuIX4Tt2ELuIZOkMf6IHzhyMpId7lLWUop5Lf0JAqjgyCpMx0Lp/B+/anxVZxVRSzkBwGU3kIqlP6+e4lWJRzlgd6Mb4dCkTdeL8hZNQxeI1xsWRKDLHe6isF4p3anRx4vS2A/988Yshx9KVX76AvHg3lp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLATTZcZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLATTZcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C081C4CEF1;
	Wed, 21 Jan 2026 21:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769029467;
	bh=vwU3Ze7jvFloOb/ZR8n9fLTnuD9K06QrgUL8i710Cf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLATTZcZQitd2TJ7z7e3UnWY/Zjr03Y3tvoizEbUQKre8ihzrm2rA3Lc4USzULken
	 gw/Q76PJmtCuPL2euuuSdAErqDBKG1s9JIB4fnc6B/mBCl+GBJIm6MLP6WTXc5wGZW
	 dhjiZdtd3ox/8hTrlGqFU1PnKLvERO1Y7aBIOyP0BuLSdeHCYtWNIM9uPJa/Lzq44Z
	 UFWTtIw9KjMl7tTXfBqEw5q68TQ5n3YHdb5WYs4ebETpywDvoiG+PKhsU6vRiausBD
	 tDKMIR7mZA5IWkW+xAau/vCHZYE8SqN/A3kRKz917lMiE4xe9CMModqi6bIlZisUa5
	 MSRHK9C66KNGw==
Date: Wed, 21 Jan 2026 13:04:25 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Peter Zijlstra <peterz@infradead.org>, live-patching@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Fix having __klp_objects relics in
 non-livepatch modules
Message-ID: <okmrns5zlxqkwrou5rspq3zyakuv4gwwe4do7yovjbeaa5eajh@fud5amphpycu>
References: <20260121082842.3050453-1-petr.pavlu@suse.com>
 <20260121082842.3050453-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121082842.3050453-2-petr.pavlu@suse.com>

On Wed, Jan 21, 2026 at 09:28:16AM +0100, Petr Pavlu wrote:
> +void *klp_locate_section_objs(const struct module *mod, const char *name,
> +			      size_t object_size, unsigned int *nr_objs)
> +{
> +	struct klp_modinfo *info = mod->klp_info;
> +
> +	for (int i = 1; i < info->hdr.e_shnum; i++) {
> +		Elf_Shdr *shdr = &info->sechdrs[i];
> +
> +		if (strcmp(info->secstrings + shdr->sh_name, name))
> +			continue;
> +
> +		*nr_objs = shdr->sh_size / object_size;
> +		return (void *)shdr->sh_addr;
> +	}
> +
> +	*nr_objs = 0;
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(klp_locate_section_objs);

How about we make it even more generic with something like

void *klp_find_section_by_name(const struct module *mod, const char *name,
			       size_t *sec_size);

?

I think that would help the code read more clearly.

-- 
Josh
