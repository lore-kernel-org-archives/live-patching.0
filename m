Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D782D8DD0
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876947; cv=none; b=kC1CLz3hEKQAXHYL5QL+nWSRUfYughOxhOl6XwdXurjCMhexROjBr15EEMn+e1vHJqpxwOF4UDadmlRraH1BDUi+6AP/xNGOX/XUnneEaq+j0ja40MtY3NfZt0jcYw3jq9dVF/jZ6lpqz6zDHhLZsJxsDcz6+O+nKB5MsV+/KCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876947; c=relaxed/simple;
	bh=1sLzkIrSDqq3qQ6C8OPjKuZfwTRHa4o5MysblnjKj0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvr5F9qPAWvKJBVpwEuizfSIEYuV4UmhxrtI8/V8LhRSa2tZ+A4jRR9C66Vs0IKgIVuAw7sU1Xxm7U+rFnRnl9yNkvN2D81BQOFleYWq3V9PkpCI0V3HndAtmo3erqsZUD1HKgkBylNm+UTcJAEL22zSq1rTU0SHultX9z7K7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CixGLY0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CixGLY0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B771F00A3A;
	Fri, 28 Aug 2026 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787876945;
	bh=MFdxzc/5jES0WloQW2hlKdM1NRFeCQKlv4BFgfx1rA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CixGLY0Mg7++0bDZa6TRYOCCikcGwQnLJpNj6IYkIv+7276zsgxMKMpIG8kz02rUL
	 PE1LpnXI6IifWTTGcNQVuPB4djg54caDThVa7jM/I0ue5r7ZhM7yZcdxotY/hNk/nv
	 QJz45uqy3PYzEOIwl9x0BkmyMVp9h6sNJ3uyNuqWObaIuzY1M1Ova8nr90WBBRTyVU
	 jHZcWm2Lk2By0zpfjgnYT9rmEEK2wPPtdtSYqTdIXt7NtOn9xXxzIWLzYaeukFmvOw
	 xg0t8ESyaGIy6a6NIv3J4WCh6OVzdBPrk9csojqWlPREn1hU4Bu93BRhb10/VxDYH9
	 f8CCcmHJ6wy8A==
Date: Thu, 27 Aug 2026 17:29:03 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
	Wardenjohn <zhangwarden@gmail.com>
Subject: Re: [PATCH v7 for-next 4/8] livepatch: Deprecate stack_order
Message-ID: <apDWJIGt7utIr2oA@jpoimboe>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-5-laoar.shao@gmail.com>

On Tue, Aug 25, 2026 at 07:46:37PM +0800, Yafang Shao wrote:
> stack_order is no longer needed for atomic-replace livepatches, as a
> single function can only be modified by a unique replace_set.
> Since this livepatch sysfs interface is mainly intended for kernel
> developers, backward compatibility does not need to be maintained.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Wardenjohn <zhangwarden@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  .../ABI/removed/sysfs-kernel-livepatch        | 16 +++++++++++++
>  .../ABI/testing/sysfs-kernel-livepatch        |  9 -------
>  kernel/livepatch/core.c                       | 24 -------------------
>  3 files changed, 16 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
> 
> diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
> new file mode 100644
> index 000000000000..fb6ff9c3b43e
> --- /dev/null
> +++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
> @@ -0,0 +1,16 @@
> +What:		/sys/kernel/livepatch/<patch>/replace
> +Date:		Jun 2024
> +KernelVersion:	6.11.0
> +Contact:	live-patching@vger.kernel.org
> +Description:
> +		An attribute which indicates whether the patch supports
> +		atomic-replace.

This part belongs in that other patch which removed it?

-- 
Josh
