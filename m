Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD53B47E3;
	Mon,  7 Sep 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796147; cv=none; b=kWs2i1Bk/rETq7g5YjASQPV99HZZe+GQXVrpSdPqTgKC5V5nCO5rWkVWVOT1XhyxQvuB32dpbHs1w827c9Arn6BbcWW/eA2Bpi2TlgiPaPE7aIh+y5gzmIIWxBqbY6pXX5w5tSKoYD5VnhgTK2z7hT4HHUUHkdPj3EfJXk2S3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796147; c=relaxed/simple;
	bh=v6ki3sLEXclKhCTx40Fky8HfYTI66o+KgUb0UIMh10U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHDKYwgOxhpiIPUXwpFLsCIouS7zIm1rnJ2nD/8p+OiDo0ESuodhC2+/XRXVK1+/546VOdfwJ41Hcgjb5jChfVKsxf+LAG7UM+yStZ5No5ILdSSb/KBJQDwfo4Z9GoKP1vbh326gYpkZGv9xu700fs5ulhUwnaz8H7hYWAPWARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oTUI7f3j; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oTUI7f3j"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 77083408FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788796144; bh=FsU1Etefuc+O2vZ49Ew/1OoJYCW/kyHw9nQAtrDPdHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oTUI7f3j0nSZ9UfEbKS8+5zhh1f3EZLwOk25D+KOJMBiWy7X0rmJlhaCamGUcmceI
	 iQbcn5nf/lw3Fvtp+2ITaDcqZMYWdjJJ7lT1eSvSg8YAlT1WJ/FFHsZwqPOw5OZNFc
	 4scxxkDCXmO/PYEvhAPF+IBHuhWrokjOq850nuBtc0dxfvrBk1aJ3Nl/UjgL8WoTHV
	 ReiRZzA5qVoLb7huYdqV9yFy6czW0tb1kL0tm+fGcDYUMBcy+YbcuwkHoSzY7Xw9H+
	 6JPoQrhEMtRDuwjIMHp5WuiPm/Dikh1lKWKPpnk57B2/5sLBIOWWnIVlrtr4ZkAbgQ
	 WNnPFgy2A4plw==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 77083408FF;
	Mon,  7 Sep 2026 15:49:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karl Mehltretter <kmehltretter@gmail.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes
 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Joe Lawrence
 <joe.lawrence@redhat.com>, live-patching@vger.kernel.org,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: livepatch: Point klp_callbacks
 kernel-doc at livepatch_external.h
In-Reply-To: <20260905085438.40349-1-kmehltretter@gmail.com>
References: <20260905085438.40349-1-kmehltretter@gmail.com>
Date: Mon, 07 Sep 2026 09:49:03 -0600
Message-ID: <87tso1vz80.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karl Mehltretter <kmehltretter@gmail.com> writes:

> api.rst asks include/linux/livepatch.h for struct klp_callbacks.
> Commit dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for
> diffing object files") moved the structure and its kernel-doc comment
> to include/linux/livepatch_external.h. Since then the Object Types
> section renders the other four structures but not klp_callbacks.
>
> Add a directive for the new header.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/livepatch/api.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/livepatch/api.rst b/Documentation/livepatch/api.rst
> index 78944b63d74b..2a98c517da9d 100644
> --- a/Documentation/livepatch/api.rst
> +++ b/Documentation/livepatch/api.rst
> @@ -27,4 +27,7 @@ Object Types
>  ============
>  
>  .. kernel-doc:: include/linux/livepatch.h
> -   :identifiers: klp_patch klp_object klp_func klp_callbacks klp_state
> +   :identifiers: klp_patch klp_object klp_func klp_state
> +
> +.. kernel-doc:: include/linux/livepatch_external.h
> +   :identifiers: klp_callbacks

Applied, thanks.

jon
