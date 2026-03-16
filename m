Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F81DFD96
	for <live-patching@vger.kernel.org>; Mon, 16 Mar 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699796; cv=none; b=nKZ2dTKRk6f3mecQUsj3ij0uKFuuI+UDrOj0XijNT1Uf7zi68cAEFV8h80f9Gj7lqF3HbnlsXtmvVj0WPefYmCKLWml4+/Qpv9bE2bgCMEqR4OvGH0X8OE1bNKYfSGpy52CaFhda6lCBLN+C5FfaUmgI4KYHrMI1WmLtcA2aobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699796; c=relaxed/simple;
	bh=06+dd58IHxduJ/H+Rtu5irujo08j+vwkcatt06JwGmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAUd4YQvWlYEarwlZAdnSQVbOqAqgz+SgJCc7N2J2gwFkTtZ8qGMVO12W39ThRrLjQ9AdZ+NaN0lk8eBMvPzwmtNKVB2r5F7DkXRzViDWzLdmCQGD9Slb5mAOIidGXFKddqcZG2gxyxauvgIkxByfejbEWnQQqQY3hDb4rTMh9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDM745e+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDM745e+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98335C19421;
	Mon, 16 Mar 2026 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773699796;
	bh=06+dd58IHxduJ/H+Rtu5irujo08j+vwkcatt06JwGmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDM745e+gxbQQ5g4g0yWko9GPo3uH/5va4DL37vMMRaj9tdm2kmsGoq0P7L9S4FJy
	 L8ZaqaiQnP5E8c0dCMd0xjk+G4CYD3EY9lmHE1tqZ5XFHvHzuTwfVT51JRMRICctvG
	 BVkgwfKBwFx+O7kJOITRjAxnz19yWsp4zzH+8ubtp8Pu4JQYJG4nj6JWDbFsH3O37u
	 1NOi6qS22qYLVnx/qcgns7y5zsRdiP0BUZpxn9NrTtY6TVJJZGXHEV6nqP/yum54Wd
	 8/qvkCIXSkpKwBCpZBCFKz1lrdRSWrdPIYs+jTUBYf58Apg8qngal1eJyo5+Ow5aYl
	 G6JntkxngNAYw==
Date: Mon, 16 Mar 2026 15:23:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 00/12] livepatch-klp-build: small fixups and
 enhancements
Message-ID: <lyglpt5dwtkb3zukm6ldpw7wzq2sruqa5r3mlxiy4sh7wpprhp@b73bde7abcsr>
References: <20260310203751.1479229-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310203751.1479229-1-joe.lawrence@redhat.com>

On Tue, Mar 10, 2026 at 04:37:39PM -0400, Joe Lawrence wrote:
> v4:
> 
> - Rebased on 9a73f085dc91 (tip/objtool/urgent)
> - Dropped elf_add_data() fix, added __clone_symbol() align fix [Josh]
> - Adopted Josh's kernel version fix [Josh]
> - Updated friendly msg, "foo.patch: unsupported patch to bar.c" [Josh]
> - s/warn:/warning:/, trap_err -> die, and commit msg clarification on
>   colorization commit [Josh]
> - Use "fuzz" instead of "drift", adjust output ordering, and send patch
>   cmd errors to stderr [Josh]
> - Dropped ("livepatch/klp-build: don't look for changed objects in
>   tools/") for now
> - Added Song's Acks [Song]

If there are no objections, I will go ahead and queue these up in the
-tip tree.

-- 
Josh
