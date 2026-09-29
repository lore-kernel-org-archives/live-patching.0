Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A70439320
	for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671388; cv=none; b=hJAaKf/DxuziNSthKP+oTZb+zf8/ilbgzNExYOL3OCQ21vpLdy0qsNDj+1tsW+TPXnnU/hc/NlDgMW/DBH414KDblscfvCv8unyYvofe/A5AA3xLZ9ALOKTYGkc2r6h3iNxF1s1fT7oIaYqg7dExHx8//ap7m1NqTC3yLG2swXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671388; c=relaxed/simple;
	bh=S0NI9rXc1k7HMes6Nipbmr1I9Lfikew6ccWoc7Ddmu0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RwY16QEcCpD7A77BFQ7/8xPT04U3jkwGE5dYM+H2rHEL6ZrUMbfuC5vn/wbz1SeKhcf6KqqW5HM35l0LZqbnFbNbpf/GtldiSpGvjXh+Y43RERano3OeumRicwqKVfd8U5njqHclBDOQ0jVo8YSE/ts0HPdw25YxQinXy+dvjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCdtUIDB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aPqdR2r9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zq+kRkRk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GA8PRf0o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCdtUIDB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPqdR2r9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zq+kRkRk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GA8PRf0o"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 377DE21D02;
	Tue, 29 Sep 2026 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790671375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrcG7DlPch6apjXfI+V6Q7u+OQ+TIr9sEt+cLW825C0=;
	b=wCdtUIDBP9NquuMZhb7rcAyqlLhEMxeQ7VNz08tmq8cYqCioO9E8WEWp4tcwvZdZCC53g7
	yqi7E/XXzEJJo+Ors0cjaRPpgc8sWRToL3H/YhbEKCdpLjXp3UoAmW6quvXZQywRhX2IWc
	zl2JKHRInMIAGRVQ67TV8Iun/5IbMIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790671375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrcG7DlPch6apjXfI+V6Q7u+OQ+TIr9sEt+cLW825C0=;
	b=aPqdR2r9kJ+3hKWfQ4MtEohJ+Dor36n0ET3SmpKh3vE1sDth4rT6kApMbBhlD/djiuLCXx
	YzyFC8fVSEqmccDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790671371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrcG7DlPch6apjXfI+V6Q7u+OQ+TIr9sEt+cLW825C0=;
	b=Zq+kRkRkep22XgpwR3uq4HCSNGdsrjQyeHqYls3WL+ehchKr2H9K1wxFox1Pnbrl9dIWI/
	xAW+sNnR8Xxpn7WlWD6YIgAvjg4/uCF6BYuwWFxAaj/2YbCUtMQR/f7vcfAJjamiv72A/H
	CQ6fbiBqkSSQ26rg83QIoTtagNzVh6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790671371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrcG7DlPch6apjXfI+V6Q7u+OQ+TIr9sEt+cLW825C0=;
	b=GA8PRf0opIllHjHdu14smT+9sNFSWtF2nFybP0EXICBVkRe/oD25GBaZ7RImrXFzJvcSDX
	d/vXMcn+RJd8ERCQ==
Date: Tue, 29 Sep 2026 10:42:51 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: Song Liu <song@kernel.org>, jpoimboe@kernel.org, jikos@kernel.org, 
    pmladek@suse.com, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Subject: Re: [PATCH v9 2/9] selftests/livepatch: Adapt atomic replace tests
 to provides/obsoletes
In-Reply-To: <CALOAHbBQyCNyvWtv3r+7mgScGuiZunfDq-+CJgKYGVyZDxcB3g@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2609291040330.18161@pobox.suse.cz>
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-3-laoar.shao@gmail.com> <179032647206.68715.855492643431181079.b4-review@b4> <CALOAHbBQyCNyvWtv3r+7mgScGuiZunfDq-+CJgKYGVyZDxcB3g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

> > >  # check_result() - verify dmesg output
> > >  #    TODO - better filter, out of order msgs, etc?
> > >  function check_result {
> > > @@ -365,6 +374,27 @@ function does_sysfs_exist() {
> > >       [[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
> > >  }
> > >
> > > +# detect_provides_attr() - detect whether the running kernel supports the
> > > +# livepatch "provides" attribute and set HAS_PROVIDES_ATTR accordingly.
> > > +# The provides/obsoletes based tests are only run when HAS_PROVIDES_ATTR
> > > +# is set.
> > > +function detect_provides_attr() {
> > > +     HAS_PROVIDES_ATTR=0
> > > +
> > > +     if [[ -r /proc/config.gz ]] &&
> > > +        zgrep -q "CONFIG_KLP_HAS_PROVIDES=y" /proc/config.gz 2>/dev/null; then
> > > +             HAS_PROVIDES_ATTR=1
> > > +             return 0
> > > +     fi
> > > +
> > > +     load_lp test_klp_cmdline_lp
> > > +     if does_sysfs_exist test_klp_cmdline_lp "provides"; then
> > > +             HAS_PROVIDES_ATTR=1
> > > +     fi
> > > +     disable_lp test_klp_cmdline_lp
> > > +     unload_lp test_klp_cmdline_lp
> > > +}
> >
> > Why is there does_sysfs_exist() fallback? I mean, we use that currently
> > for exactly this purpose. My understanding is that
> > CONFIG_KLP_HAS_PROVIDES is also used elsewhere in the code so using it
> > here makes some sense, but do we need both?
> 
> CONFIG_IKCONFIG_PROC may not be enabled, so if /proc/config.gz doesn't
> exist, we must fall back to an alternative one.

Ok. Let's keep it like that because it is definitely cheaper than loading 
and unloading a module. Could you add a comment just before 
does_sysfs_exist() fallback about CONFIG_IKCONFIG_PROC, please?

Miroslav
