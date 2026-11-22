Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329245;
	b=VluBhhgvR0rAFRizWVI5Ce0YWjzT8QUJOUtE5lnLEdTFP3/Laf1PWgiQK/C3caVCzlnk
	 kOUrd+nP2xIZKs9nQ7fjAhdBmcCNkEDykh78eHtDC0HnRMASLPQbET6GJX7lBHalGeYIT
	 9/oY0pM/ljSCzJyeFUMlvLbIek952aMlnUzs1RQHtYHZpqQgbX+lKHmZwGBASSe3v1CNJ
	 Z/qGB+gZ0qAtw1sYyIhU0gl+aT2BAd8huL8OrS/6AbteS+J5y0jWvcgeHVmKEI5vCLtPw
	 yALSzQDcer5OSndGMEU/TEDeqQVrGM4r0o/Th1QdXyJ9fGdUpdh7+Y1AI7eE6XN4Slw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=stPO3VWIRXZkgCy3QK4QVfL/1O7xv0UwD94qJWnSO00=;
	b=GZMNAEmyX3J+4R1v06cg9mVfDlUbPqjNIywNsnlsKBdQiDc7XKe20ZntwGjS3yaFGD2I
	 dwPU8B4gOXDmEQnR64pCqi9hAcnG0mTcV0kNMBfkgkH/iB2nJeDoc9Hn5B9+wqBNb8Sep
	 CqoY1Mcv9wOSYj3f4VNtluadukA1nufZShgSOVeLw/0mBVfwHTPKVGkya1hjA1BYu5dp8
	 xEJ73U4ilRjIpsAS/jQJHjdmQSktUfFBgK7BitgbfFdUlto3asfLYIPX9ddKp2wtNafum
	 L13ApJn8yPcmAww7Vz652+ZFQ+NrcHUQpDV+ypf1ov8kfysFEwjUBOwiCZaZFjt/gbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqCDZ58x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5210606A320
	for <live-patching@vger.kernel.org>; Sun, 22 Nov 2026 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqCDZ58x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E4E1F000C0;
	Sun, 22 Nov 2026 06:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795329245;
	bh=stPO3VWIRXZkgCy3QK4QVfL/1O7xv0UwD94qJWnSO00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PqCDZ58xGKzEW/RxbjzXFES3aY5or6RMfb9Nc/07hptXrYmZdsKRARMjHKv5gHFM/
	 FBPxxcQHoOTXnu6HsjNMJ9bteyeIeRlmuBu1vWpums5jfHtvRfb25Mrteadvrkycw5
	 aTGP1leet4aPcR6bUUdV69QgRm4T8NJIhdUFGVt2arTia0/AwQC/b9gsbmEdOjwNAo
	 988X3N3raOUrZN+E1j1FQmrYgI46E5HiJIIPUbkM7mslstsx4X345hDRmNpG8VmGQo
	 SSHUO9DipUaLQfqroBaBk0l6sPAbwsvmd+gNi52v2gLEZfEx2ge+y0e3rgEJ7W8vwA
	 w8Cz5xlOG/Szw==
Date: Sat, 21 Nov 2026 22:34:03 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/3] objtool/klp: Reject changed functions without an
 ftrace call site
Message-ID: <awKMzQbMkVuWjVNm@jpoimboe>
References: <20261022171637.3298443-1-puranjay@kernel.org>
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
In-Reply-To: <20261022171637.3298443-1-puranjay@kernel.org>

On Thu, Oct 22, 2026 at 10:16:33AM -0700, Puranjay Mohan wrote:
> Changelog:
> v1: https://lore.kernel.org/all/20261022122544.125305-1-puranjay@kernel.org/
> Changes in v2:
> - test-special-sections: check __mcount_loc in its own block instead of
>   inside the section loop (Joe)
> - Collected Joe's Acked-by on patches 2 and 3

Queued, thanks!

-- 
Josh
