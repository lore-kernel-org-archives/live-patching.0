Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510325;
	b=kZm+W8nHA5AIobYGrL8Xhy7do/UP1+45BYVbFt7sjx34QAKMRFnlg+5HbEnwCaACDmuC
	 s7i/uzFDoVKxht7QdQ4rk9SjAW5/fMJv+BBacL5B/lEAFrc+OWfA+TEAjWuyOETZ1f5js
	 Ar1b7nYuiul/cjYmlSPK7nF+aDnytqySMcTbr0krj4IS34jFXVHTzxQfGa70Y2DWecznw
	 M5GLG3H9DYt9J4P/k2qdIDhE9Befx/ywao2XtbNzHTIymlEIimUKuPuH72P7QGud9NBf7
	 rR0ihg+4ct8hbDfBiLOw6Kv1epyhMwu3ATvsn8lxUps6k6RDy6X3nzpoMSZyYM0bs7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510325;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Nnokj0ICH3uGpo1u86kSYRVQBh/oEWA/5hlPVPpx1Bo=;
	b=jRjaXluIlOaq5dSSx15OQ5Pbc2s9qWH7pMNd/B3AdNNYe1LgL+VEyFVuO6Ujh0jgF62g
	 vfbhb9xQHqV9VnA+dmttkIfTK1Uo0EvQKXsUazzDiFY+Z5FE9SUm6mHD2RTwB21+iOvsN
	 Fh9Ggg5cd13GE4C+cg1mw9j5IHir3xj1MhMQk6VOJTOTiyDf/Wpcdgci0azsVhC2hc6Rk
	 rD65IZ7LT79mDX0S9AVrGdRuKhObYa/qvXTu2kD0jyr4shbwSrF6pI8tLRbomVDlB7dtD
	 XZXQKVBl1ofOLbCnEhHgKYe0TUJOXQA2GWC892i+yDBk+XSgljEuHyZi+yIt88t+59g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEZfkWFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536A606A335;
	Thu, 12 Nov 2026 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEZfkWFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468031F000C7;
	Thu, 12 Nov 2026 19:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510324;
	bh=Nnokj0ICH3uGpo1u86kSYRVQBh/oEWA/5hlPVPpx1Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HEZfkWFFCRZdCy2X9fu+huBtUW7UPG86kTDcuEL9UWHPYq17kmPnqJl47skk97Z2I
	 q3Omi70f6J6u0U0eR1VBlgC+DrNs2u/GMxSEEjOVEc6+lKBRY3xDYZjhUAQNRGXJCc
	 HGtZEYnDF07qpdFlu3lA3PMUO0ZPfJGajuCTwLRjdt1uNxvq5WcrFDyjD+0LEgHvqB
	 +tHB0Zy/Ty8Jo5iWTZ4xhs7jbPq2MBdNsRc+5v+3C7oDqTwmvMSIynS7BUIGTD184U
	 v9eKLFL1eRLxrBAS9BEHl7NQuh/SW4KbvMDLUP1VBU+u9bZ0NFGSLXAH8dbQrZDjY+
	 vG++ZAbBgs45w==
Date: Thu, 12 Nov 2026 11:05:22 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	song@kernel.org, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/9] livepatch: Add support for scoped atomic replace
Message-ID: <avYNu60V0spG_xIf@jpoimboe>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>

On Mon, Oct 26, 2026 at 09:36:42PM +0800, Yafang Shao wrote:
>   selftests/livepatch: Clarify test module file names
>   selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
>   livepatch: Make klp_find_func() non static
>   livepatch: Call klp_init_patch_early() earlier
>   livepatch: Implement provides and obsoletes for scoped atomic replace
>   livepatch: Deprecate stack_order

s/Deprecate/Remove/

>   selftests/livepatch: Add provides/obsoletes test scenarios
>   selftests/livepatch: Add state test for provides/obsoletes
>   selftests/livepatch: Add function test for provides/obsoletes
> 

With the subject fixed on the above patch:

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks!

-- 
Josh
