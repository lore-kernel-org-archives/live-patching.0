Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF52771E
	for <live-patching@vger.kernel.org>; Sat, 25 Jul 2026 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938152; cv=none; b=MwHGf5ZX1MgVOMfdQfUzsPas+pGJZPGS1NoCtsNIISWmfqVv2tXflHge+MBuHInFtUIwUDOBGQNAKDX0YcvZuyZ77VSOYaQ2sfF1RC50RANcV7kp/Tbor6+fs0KmxbKKAJOrA2R9mT41CWGHDLgv5mElJUMJ4UUpDvw63FZaytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938152; c=relaxed/simple;
	bh=98VBDgRgJWDkuibSUsGbiTA0qMXmNnj9sYMKI8O7fLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsqlZ5BnCy4dkt2NKf8sg1TrMS5wrlqNENE9Frn8QjZBCGdXmtVdoJ2c1a5rcYSpotVK3VK5vg45XSOlxRsRGZawGbWGWaBzUSwsKOPmZaTP5Vc2dEmvIRryv+JUOO3JzaEYGiSVcDOetQhXBjdQEsIjz68ZJ6Kxjl8G+OoKVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPO2o6qF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPO2o6qF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01701F000E9;
	Sat, 25 Jul 2026 00:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784938150;
	bh=wPe/eDFO6XEcfsJZN4U9XhNe1JzaV7DpH+fOwciF8Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPO2o6qFmNYijPCf5IvlkkKEmRYmAbnXxWzHDq6jQA2Uo47QyyC4KDQFqKF8AQYk5
	 Uh+MUhzpaJT9JVatB8dKSOu6Ff0zUHgUUN9D+PNLGeGhgbKsdip8wmvHbo2HfaG9eD
	 eOlCdwpGBbXBrHOJo3YuHB2Mn4E1PZUXu8JdM4M+qBb8bkVeFO6DPjQ3Plsnp+7CZq
	 hOjIjI1l5BXvfKfBeZ8keCCk+eqIJ0Pu/o8/Td3711HURvf3aQEKAXUH6hnoE8Jt6Q
	 WBSLbUkg/FedXFo2d+b7VwXSRLVNg+utJganhI+hm60ulqZr/L1joRr0v6Nw8WgvJI
	 wBUcCnUyOrTHg==
Date: Fri, 24 Jul 2026 17:09:08 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Ben Procknow <bprockno@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>, 
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/1] objtool/klp: compute sympos during checksum phase
Message-ID: <upsllhkhwyezml3pnq7fv7j2ulawp3avj4ftoh4hnzu4yieshs@bwnbzzeac3c3>
References: <20260724221730.3126529-1-joe.lawrence@redhat.com>
 <20260724221730.3126529-2-joe.lawrence@redhat.com>
 <20260724222745.5B8F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724222745.5B8F81F000E9@smtp.kernel.org>

On Fri, Jul 24, 2026 at 10:27:44PM +0000, sashiko-bot@kernel.org wrote:
> > +		/* Match our compilation unit's filename against sorted entries */
> > +		sym_file_name = sym->file ? sym->file->name : NULL;
> > +		for (i = 0; i < nr; i++) {
> > +			bool match;
> > +
> > +			if (sym_file_name && entries[i].file_name)
> > +				match = !strcmp(sym_file_name, entries[i].file_name);
> > +			else if (!sym_file_name && !entries[i].file_name)
> > +				match = true;
> > +			else
> > +				match = false;
> > +
> > +			if (match) {
> > +				pos = i + 1;
> > +				break;
> > +			}
> > +		}
> 
> [Severity: High]
> If an object file contains multiple identical local symbols with the same name
> and from the same source file, will they all get assigned the exact same
> sympos value?
> 
> Because the outer loop processes each symbol independently and the inner
> matching loop breaks on the first match without tracking consumed matches,
> it appears all identical intra-file duplicates will continually match the first
> available entry in the sorted list and be assigned the same position.
> 
> Could this break livepatch target disambiguation if multiple identical 
> symbols in the same compilation unit share the same sympos?

Indeed, and not only are there intra-file duplicates, there are also
*inter* file duplicates with (same STT_FILE+sym), as STT_FILE is just
the basename, not the full path.  And those duplicates do exist.  So I
think we will need a more deterministic way to correlate vmlinux <->
vmlinux.o.  I think I have an idea how to do that, will write something
up.

-- 
Josh
