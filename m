Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684559;
	b=TGOL1FHE2L/A7UM2ZH9RNbsgPfg3neKIapIPczyKrlii2V9Rb0hJmU0obu50wDU/zHfT
	 Oddkb3Uh+skLYZOSUF7nJC4La6ZleTS6cUcg8pDCxU+pIsk0Ts5UGM6I3a8o+NfyrqKsA
	 2cwohfZ92L7O1i1i/oUSMQ2cBGEmTwmJE/J5LpzMJ9p+B1bxhnjWfXPjR+ihX/91lWbGS
	 uOUxKZXt2BTNRriatyklo5aD0DRljU0fFRStsBBYfmO5GqksnWYXQO+RPOToTkwLM8J9m
	 AWqtNuPLePcC6/vMkB1ytLSjIuQXJxPEACXnBuEa9datRixX/NSfoZ+grITXdSiUe+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684559;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=/RmLVwEuB/hNcjUButO87bnfXf8Al3OUHG8uGSv+Vag=;
	b=DoV9We2bSL/maP84tiRpxeUSEuJ0H8t2zAxB0KmOcuDgHyVFe527nhM4feZWfbGQqWTl
	 7iRe88JviRXHhiaFkNbxxFVrVH7TPtQQRTlAi18/urpyuX0t4nw+P/xWwUkFEOu35pmSl
	 l8Mkz1/PlRTehxjNv4M1C7N91/99ZnejEdzPtUW1UOPTzv4d39D4VgelVCy1nOO1lt/cR
	 XBKumQ7TI9Wfev6TI19XpauX3zHmoxBhJ3o3IOdQvyVWtNMWcZRxCSOoIVTDyL+nEp0N5
	 grslZuINyPw8TyzMkkxVcq14njdrO0VoRLgOXGziVW/DFVicebkYuIfSTYZn+X/aXLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0Jmhplk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8580606A31E
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 15:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8580606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0Jmhplk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792684557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RmLVwEuB/hNcjUButO87bnfXf8Al3OUHG8uGSv+Vag=;
	b=N0JmhplkJzcTJwIjp350xxdhy9kbHVeT+xjyda8y7mVPiUkaJA0wWt1q7VDG8xq/RwTijz
	bE7VxqEY4ePnx3ADp/laB3MzLbMhLvn4pPzcrGJQWmc/QA2xJHAzadEZ1nJhm1WT0T4qSE
	BSbSMRP7etf2Hr6NwbWdJ1HVG6JMgL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-m9Z_yb2yPriAIq95ILZlaA-1; Thu,
 22 Oct 2026 11:55:52 -0400
X-MC-Unique: m9Z_yb2yPriAIq95ILZlaA-1
X-Mimecast-MFC-AGG-ID: m9Z_yb2yPriAIq95ILZlaA_1792684551
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A54518007ED;
	Thu, 22 Oct 2026 15:55:51 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C5F230000E7;
	Thu, 22 Oct 2026 15:55:50 +0000 (UTC)
Date: Thu, 22 Oct 2026 11:55:48 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 2/3] objtool/klp: Reject changed functions without an
 ftrace call site
Message-ID: <atoyBMUFX98mr-Uw@redhat.com>
References: <20261022122544.125305-1-puranjay@kernel.org>
 <20261022122544.125305-3-puranjay@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022122544.125305-3-puranjay@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 22, 2026 at 05:25:37AM -0700, Puranjay Mohan wrote:
> Livepatch redirects a function through its ftrace call site.  If a
> changed function doesn't have one, klp-build succeeds but the patch
> module fails to load:
> 
>   livepatch: failed to find location for function 'nsproxy_free'
>   livepatch: failed to patch object 'vmlinux'
>   livepatch: failed to enable patch 'livepatch_nsproxy'
> 
> This is easy to hit because the kernel's 'inline' implies notrace, so
> any inline function which the compiler emits out of line can't be
> patched.
> 
> Make klp diff fail for any changed function which has no __mcount_loc
> entry in the original object.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/objtool/include/objtool/elf.h |  1 +
>  tools/objtool/klp-diff.c            | 47 +++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index a82517a76a0f6..f7e6a652ee788 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -98,6 +98,7 @@ struct symbol {
>  	u8 klp		     : 1;
>  	u8 dont_correlate    : 1;
>  	u8 fake		     : 1;
> +	u8 traceable	     : 1;
>  	struct list_head pv_target;
>  	struct reloc *relocs;
>  	struct section *group_sec;
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 34da55e456097..f8659950ec9a9 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1098,6 +1098,50 @@ static int mark_changed_functions(struct elfs *e)
>  	return !changed ? 1 : 0;
>  }
>  
> +/*
> + * Like ftrace_location(), accept an ftrace call site anywhere in the function.
> + */
> +static void mark_traceable_functions(struct elf *elf)
> +{
> +	struct section *sec;
> +	struct reloc *reloc;
> +
> +	sec = find_section_by_name(elf, "__mcount_loc");
> +	if (!sec || !sec->rsec)
> +		return;
> +
> +	for_each_reloc(sec->rsec, reloc) {
> +		struct symbol *func;
> +
> +		func = find_func_containing(reloc->sym->sec,
> +					    reloc->sym->offset + reloc_addend(reloc));
> +		if (func)
> +			func->traceable = 1;
> +	}
> +}
> +
> +/*
> + * Livepatch redirects functions through their ftrace call sites, so a function
> + * without one can't be patched.
> + */
> +static int validate_traceable_functions(struct elfs *e)
> +{
> +	struct symbol *patched_sym;
> +	bool error = false;
> +
> +	mark_traceable_functions(e->orig);
> +
> +	for_each_sym(e->patched, patched_sym) {
> +		if (!patched_sym->changed || patched_sym->twin->traceable)
> +			continue;
> +
> +		ERROR("%s: no ftrace call site, can't patch", patched_sym->twin->name);
> +		error = true;
> +	}
> +
> +	return error ? -1 : 0;
> +}
> +
>  static int clone_included_functions(struct elfs *e)
>  {
>  	struct symbol *patched_sym;
> @@ -2260,6 +2304,9 @@ int cmd_klp_diff(int argc, const char **argv)
>  	if (ret > 0)
>  		return 0;
>  
> +	if (validate_traceable_functions(&e))
> +		return -1;
> +
>  	e.out = elf_create_file(&e.orig->ehdr, argv[2]);
>  	if (!e.out)
>  		return -1;
> -- 
> 2.53.0-Meta
> 
>

 
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

--
Joe

