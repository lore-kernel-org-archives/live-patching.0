Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641433CE8A
	for <live-patching@vger.kernel.org>; Fri, 19 Jun 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880139; cv=none; b=CVGVla2hdKOZ+8KTVULZzGUJm5wY0DjJG+lYEy3ehcYueE+Pl38k184XP0C3R7qNhBvSz/r35ekvkWlj34iHOlGrV3UWgRYY0FnfaGP6iZFtLGcbcvq1T4ZePIcDedbRebTlFR7mwfRS5/UbRi5WnNk8XBHc30wC35KOj32GXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880139; c=relaxed/simple;
	bh=BsjyVrh5IBOdEAVmCPie7y3wWX1zTELeL3z2l31eYHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cf8Dwtj+dSQF0CSP4XUQaNEMMQPPqj3HLb6+QXcXwBgaCwH/0sbUxWACXZW3zJfQxoIGqieQ5YecfvsLFhT29innDlJ0QwhXsbL8GOv16K0hxUKA7BDjamn+vqO9kD4fqo6tCLeeGAPMreyI1HFkPvwDBfazZJOyc8ehaeuTz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v08hG+B3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2xns5UPd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQce0LCG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MhdL7hfj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v08hG+B3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2xns5UPd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQce0LCG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MhdL7hfj"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBDE46DA16;
	Fri, 19 Jun 2026 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781880136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxz0IpyIFHtsobUtuHb7rASxPKxTLhdGWNg8to+Ycfk=;
	b=v08hG+B3zlWPjUzSVd2Q2M6a5+Fiv7NB0H+AHrua3Cxu8SqMO+FgGKWSjYScJA74Cp1yd+
	oa3BicM7xPn5H7OxfeZsiQbb/GQWWPJuPVu5loYSpn11NSEdzFL2XAyqw5ktBkh21oy8XC
	+XT9KFzxPYf5RBt9NEtJm7F4Nj1p5vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781880136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxz0IpyIFHtsobUtuHb7rASxPKxTLhdGWNg8to+Ycfk=;
	b=2xns5UPdUTX2isHPw7k3i0G+1MTGcHzQh3r/lrpBXLuHp3PHzKGXoyba+537f4+hQiq9CK
	Wc/JZCwZ5Vug7bCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781880135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxz0IpyIFHtsobUtuHb7rASxPKxTLhdGWNg8to+Ycfk=;
	b=mQce0LCG7PrM4j9pyCLK7aUPRqWfk+el31FULS4hqjUyU/U2kh9hjXl1gKEfOw5yKmr2Qt
	wAEq5I63lQZFZjUCJidopo2HSkHGPLvJ6Z0wdFUSS1AAyJBQIOPvTj9wmLyLVfDhUIxAP4
	6tdmeGQe6SrGxS8hsB4S/P3bham9Bec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781880135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxz0IpyIFHtsobUtuHb7rASxPKxTLhdGWNg8to+Ycfk=;
	b=MhdL7hfjoetfXX/NW0107/QVRKICKX0XNw/D4YU+pypKElWp4FvKfmNAp1ZTZFVR4uOHKg
	h/O7e2euoYtRb6Dg==
Date: Fri, 19 Jun 2026 16:42:15 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Zelin Deng <zelin.deng@linux.alibaba.com>
cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
    live-patching@vger.kernel.org, mpdesouza@suse.com
Subject: Re: [PATCH] selftests: livepatch: unset sub_make_done in case top
 level Makefile be overwritten
In-Reply-To: <20260525083721.27857-1-zelin.deng@linux.alibaba.com>
Message-ID: <alpine.LSU.2.21.2606191638540.26638@pobox.suse.cz>
References: <20260525083721.27857-1-zelin.deng@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.973];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Level: 

On Mon, 25 May 2026, Zelin Deng wrote:

> After I did: make kselftest-all in top level of kernel source tree, top
> level Makefile was overwritten by auto generated contents by
> filechk_makefile:
> [root@emr: /home/shiyu.dzl/linux-next]$ cat Makefile
> export KBUILD_OUTPUT = .
> export KBUILD_EXTMOD = /home/shiyu.dzl/linux-next
> export KBUILD_EXTMOD_OUTPUT = /home/shiyu.dzl/linux-next
> include /home/shiyu.dzl/linux-next/Makefile
> 
> Top-level Makefile export sub_make_done=1, leaks into unrelated re-invocations
> of the top-level Makefile when recursive descent through selftests -
> building test_module of livepatch. That causes KBUILD_EXTMOD setup to be
> skipped, which leads to a relative/absolute path mismatch in srcroot vs
> CURDIR, falsely setting building_out_of_srctree, and ultimately overwriting
> the source tree's Makefile with a generated stub.
> 
> Clear sub_make_done before re-invoking the kernel Makefile.
> 
> Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
> Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>

Adding Marcos and KLP ML.

I cannot reproduce and I do not understand it much from the changelog (I 
am by far not a Kbuild expert). Could you share the exact steps to 
reproduce please? If I just run 'make kselftest-all' in the top level, it 
passes and livepatch test_modules are not even touched.

Miroslav
