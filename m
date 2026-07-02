Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BB38F92A;
	Thu,  2 Jul 2026 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976281; cv=none; b=IErz6h2lBfLFF2KV+2QizbpcN4IA07z+ng6yXeHwrJDffqP8f8V6wFtFYIKzykLsxzD/OtkfUHhPL6U62y2MiiPHV6ZSzBY0L8Qefftftts77rrvKvVlFJFQfJiRKfQH26/KRrD9z2vruvD4U1eVaiaYZcFXvpGOzIIwdHAAP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976281; c=relaxed/simple;
	bh=ryQ+/9WSBoxIeE12cWLb2E7hFjV2q9TcaCgJgnCt6+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt5GPCPjWVO6WDvjMlQk/seSWXV/CIPsLfO/TWnE3oXuIQrNuFa1ybeuiB5oJIuHOEfnkt8aUyXCjj7faYrpije7L54vXjhnd/HoJB4ayQXCssHro8zgRQIpjUSyY8X1SjnO5IhjsRNK0CuFeguj/V+G9h/atZlrttLPpEM0Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zuBVLDKQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJ8QKkjN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zuBVLDKQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJ8QKkjN"
Date: Thu, 2 Jul 2026 09:11:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782976278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEVlPZpnyQaxZeVTQhjq1fHlGmzV7NkcyeGTlWvZMLg=;
	b=zuBVLDKQl19fPGCv2VyQIj6Ju+IuIrLQTHdDWP2kFohNaOLOBDxuOwIAZ8EhngxKR8aKR8
	ofDQV+OoY5yAq3d+1t9/i1K32IQ2lcySf23EPQ83dcx1OfVx7qiZaNKF1oerMPQd68MJEL
	vfok4Jw9NpeoNHsxMsOJ8uFefqROYjWOpXIt5hYV3AfhyQ+aEDLGkbqGT+f14GBjgASKuJ
	G6xObcH8r3iYv5XMvuRr92KjzZ5y6M2ENQiaJKfihQKLXoMCm7JQ4Z02iQNREz943NDCkP
	pyqLJFCCcbg+Of/nezHxfcLE7rFilvKFQdn4kSvhPGfnNMdZjcAoIiUvuRbUVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782976278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEVlPZpnyQaxZeVTQhjq1fHlGmzV7NkcyeGTlWvZMLg=;
	b=gJ8QKkjNYtS/6jtfDnl4HAVt6OTPvQDImvDnfZNhujLimJMD4vUQcFrthOj7QuIKJHjVwS
	t76Q+A97BZZ9BrDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Zelin Deng <zelin.deng@linux.alibaba.com>
Cc: Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org, 
	mpdesouza@suse.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: unset sub_make_done in case top
 level Makefile be overwritten
Message-ID: <20260702090852-9fe31739-3a7c-4604-9afa-805a6dcd8755@linutronix.de>
References: <20260525083721.27857-1-zelin.deng@linux.alibaba.com>
 <alpine.LSU.2.21.2606191638540.26638@pobox.suse.cz>
 <ccfed9b6-9a73-4299-b305-da7b593a52fd@linux.alibaba.com>
 <akPTcJjrIAI1ZNyH@pathway.suse.cz>
 <20260630181125-a7a41726-4270-4bb7-92fe-17ec28cbe176@linutronix.de>
 <akUu0DEYrhd9cLCL@pathway.suse.cz>
 <20260701171713-7dd2f65f-abe2-4ae6-bcd4-e0bcdada6bed@linutronix.de>
 <ec834cd5-27ba-4bae-8c19-f6b97f098139@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec834cd5-27ba-4bae-8c19-f6b97f098139@linux.alibaba.com>

On Thu, Jul 02, 2026 at 10:40:21AM +0800, Zelin Deng wrote:
> 在 2026/7/1 23:19, Thomas Weißschuh 写道:

(...)

> I had verify your proposal, it worked well - liveupatch kmod was built
> successfully and top-level Makefile wasn't overwritten any more.

Thanks for testing!

> Petr thank you for your Ack, I think Thomas's proposal is better than mine,
> we don't have to do the quirk everytime when new selftest kmod is added.
> 
> Thomas, so do I have to send a updated patch or you will do it by youself?

Your choice. You did most of the work, so should be credited as author.
If you don't want I can do it, too.


Thomas
