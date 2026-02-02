Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD502DE71B;
	Mon,  2 Feb 2026 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056373; cv=none; b=ODUWZHvvJuMG8VxRoRLJBVBbfc20hlhai63Y3zoi27gy1FyIJTl8fBcgxlbhpiOs/SePKywU1c+nQTRWNvQOd8M9oyf3v3XkyhEuBTGS3vEHvI+ErKHbzAG3jZpyVVqGoDehUYyTKLKil5RJCA0fR8dvl6QEj2kAiEF/qftQwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056373; c=relaxed/simple;
	bh=J6Pdx4sD9u0QU1u0keSf2ZQUpI6TtEGLSO7C8QAvu/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGKj3ec8mGu6vigj9e3o07jgyOPpmChNd7z1r2kASaRrPoxXCgpVfsyEF29KZzhOgdCz6nqiz4c66jXeL68LktOsBLsu2VUSSl5kGEVtc0HtAPc68GV5YBRQgsuRC2thPRWf77RGmct2AWPwXnadCEp8KAD/d6NxsTQ9j1Kipvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyX1gAtM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyX1gAtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAB0C19422;
	Mon,  2 Feb 2026 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770056373;
	bh=J6Pdx4sD9u0QU1u0keSf2ZQUpI6TtEGLSO7C8QAvu/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyX1gAtMR3HaqbriNGL/nVyhTkbCLF7GIs4gg74CIvfCAgAEC874NNzbZ+6hVOHZT
	 oNCgfeLa7J0ffW5QoSAqCc/FRQFQ2ILjoxQBqRSw0Hp6xS8f+YrRf4w/YXiXdptqC/
	 v9LUJqZNM5ZVK7BHlvDSjT7x4/+wQD7bQ1EF+i10GYxbpn5JE/glfK5SR90hhdaAw0
	 elbgRrIPKYO9qhqCdjvl3kHHzltvxkL9FBIbelAZrgZpxpNa803xCh2wQLdDLW3geI
	 ONE9tbI5W9b8beMm+HvF5qg591+turFECwBKOTIRlPNacWvtwM08QN3P3n+TqzYAeE
	 /qR2wEFK2u3dQ==
Date: Mon, 2 Feb 2026 10:19:29 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: objtool: static_call: can't find static_call_key symbol:
 __SCK__WARN_trap
Message-ID: <dbbcybceshl7xlj2qujmo6s2vha7oqvp6bqcir5jfjae7h2z7b@iy4uzb2ygunj>
References: <99f7cfd4-ef1a-4da6-842f-19429b1fb2d2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99f7cfd4-ef1a-4da6-842f-19429b1fb2d2@app.fastmail.com>

On Mon, Feb 02, 2026 at 05:18:13PM +0100, Arnd Bergmann wrote:
> Hi,
> 
> I see a new objtool related build failure on current linux-next
> with clang-21:
> 
> samples/livepatch/livepatch-shadow-fix1.o: error: objtool: static_call: can't find static_call_key symbol: __SCK__WARN_trap
> 
> I couldn't figure out what exactly is going on there, this seems fine
> with gcc, and so far only one of hundreds of configs has this issue.
> 
> See the attachments for .config and the object file.

Ah, this is CONFIG_MEM_ALLOC_PROFILING_DEBUG inserting a WARN() in the
sample livepatch module's memory allocation, triggering the following
warning (file->klp is true):

		if (!key_sym) {
			if (!opts.module || file->klp) {
				ERROR("static_call: can't find static_call_key symbol: %s", tmp);
				return -1;
			}


So this is showing that the sample livepatch modules (which are built
differently from the new klp-build way of building livepatch modules)
will fail to build when trying to access a non-exported static key.

I will need to stare at that a bit to try to figure out a fix.

-- 
Josh
