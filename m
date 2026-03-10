Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6E38D6A8
	for <live-patching@vger.kernel.org>; Tue, 10 Mar 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160493; cv=none; b=XPrC18hjpjOazPqnSClETrxnxxg3nKSQkz2XaOdj2IuKtjhBz2jOpm7rkcAqZkRka7tK6VE1QwZf08v2rSvhWWsDZqhwM4g+iHyR7D3qHnC0H4oGR4aG18GPyr8+ZHHK4Gf1Kc08eEB7t8ynTknZXz1GARcJbgh/0WRAvlHiHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160493; c=relaxed/simple;
	bh=FyukiUYkB43YwTfKEKpnLcJ1GYTYWfdScMIHTFirHGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj/EjR3TrQXh3cez+s/cx8Y4oc5hUrsa/EVYMxF/YZGO/vAuEOdpp9qvwDvL6c4LXVQONoKd5KelULex4SIcSSe3JTS7DhqO48Jpt6kwSfuZoQf4GftWa9vntLwnHXgYDq92rI66tH4+j8ikafy1MpO3xUNK8ch585SVoghAlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRh8N64C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRh8N64C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA47C19423;
	Tue, 10 Mar 2026 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773160493;
	bh=FyukiUYkB43YwTfKEKpnLcJ1GYTYWfdScMIHTFirHGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRh8N64CrS4jKAVP/bfOHdmCuyOU1B8uOkFgkScV79N6MSjxFDN7UtpbnMg1PbGek
	 uOJXzcIieDJCUeSdR7yxVDDoPqOZP89FoHLePmmIhbhErs96cLLbn9XWlolVJRCXyD
	 H9ucU56BEG19dbCh13TqA/9E3alvBvdYZ4TKyWo5IcrCb4pj3EFIAucrzKPLWsWmTQ
	 Ds5Aww/ToHSGPd3qksVHyHqIaFzEid1H0ltzQV+zPVNbvlJVRunQomYkH+kg23jYtM
	 PVZeQDdy2IO4UhcG6tFV88thjzHEECT+niRaogWca7lXozTkslQjuJ95JB9Y8VCsYc
	 wQXxMzMFk2qeQ==
Date: Tue, 10 Mar 2026 09:34:50 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 01/13] objtool/klp: honor SHF_MERGE entry alignment in
 elf_add_data()
Message-ID: <shxycktqzuuv5ye6t255tsytczjcynvi3kv55iig2rbq77hasz@5zg4caq2ozhn>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
 <20260217160645.3434685-2-joe.lawrence@redhat.com>
 <aZST2WmYD-B_o0oc@redhat.com>
 <p67ixebt5ufjed44j6wrufwihmsh3ufhbdog7767ro6tygleaw@lvp55v6brjxw>
 <abAkkrWoTao_tIi7@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abAkkrWoTao_tIi7@redhat.com>

On Tue, Mar 10, 2026 at 10:02:58AM -0400, Joe Lawrence wrote:
> LMK if you want me to update the patch in this set, or drop it here so
> you can update in ("objtool/arm64: Port klp-build to arm64").

I actually already merged that one into tip/objtool/urgent (356e4b2f5b80
("objtool: Fix data alignment in elf_add_data()")), so please create a
separate fix based on tip/objtool/urgent, and make it the first patch of
your series so I can easily grab it.

Also, FYI, I'm starting PTO today, so I may be slow to respond the rest
of the week.

-- 
Josh
