Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999526158C;
	Thu, 16 Apr 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359272; cv=none; b=hkd6HGbsEJfpeUA0bwFByHr9PYPbCfwRWGmwvhGbCaeSuF/YZ4kRZQ/AI2LVv+Bn4xNbt3CKzXjBUkLOYwoC/LPE/zZPH9Tnsfr9uV1k2A1v+lLmFdlVuw1yXUh5EmeJMEEzWfnfwEs2LMDUVUhSKfu1qSLssyJ+j6M8hHm81JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359272; c=relaxed/simple;
	bh=bKTYZsePcx0swb3cfVwcIdVrgRDkBw9sryMG4NItpUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cem4jQc+HPqIWHHGaWdCOlipAUtCmBpNRlImB7lqZgOZizpPUPFFCQ1Rek1pLOtyZQG/Wxe24GEM330bxqzRk5KmxSPr5gpaTADh4tLv9okGkzmmL4QEhyA3ahcPGamgzucYn6inUYhJBmkbrCTpbumAQOqqSqYr9PrfjV3QGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx8ZEk8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx8ZEk8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D5C2BCAF;
	Thu, 16 Apr 2026 17:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776359272;
	bh=bKTYZsePcx0swb3cfVwcIdVrgRDkBw9sryMG4NItpUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yx8ZEk8lTmxif0qQ3TmDIRTWQRhBR2XB14uv9yR2MyfMJqku2NW1gXxTFJsePhD/R
	 KD6A6aYvTOFcgM6E+ilpSz9yeOEJtprs0Z9ajzReB4oMhWgvb6mFzZ9gt0dMmLzrBk
	 taoK1aAko9u6Fv3tnyXfdm330yV2FuXJx7OvdYy0bwYyUdvzr5snRRRCJjAHVeEXzp
	 pasnjQ42lmasUrtYCcmkQj48Vi+1ZJalTdiAireWL5G9/hFKPj3TEcGne1HiJr1Aiy
	 NfZosJUmS8zqF01jnLqAobD/jG7Qs31DOKqART3fG0J3BX7ybd8x/eDPjB2rg+a8UD
	 1NHP8yAHTEwgA==
Date: Thu, 16 Apr 2026 10:07:49 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] kselftests: livepatch: Adapt tests to be executed
 on 4.12 kernels
Message-ID: <wrecfrmldslvr4dvtb7hrmi3w6joby4qmray3fd3f4dfc2k2tv@ficeojpjxjop>
References: <20260413-lp-tests-old-fixes-v2-0-367c7cb5006f@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413-lp-tests-old-fixes-v2-0-367c7cb5006f@suse.com>

On Mon, Apr 13, 2026 at 02:26:11PM -0300, Marcos Paulo de Souza wrote:
> A new version of the patchset, with fewer patches now. Please take a look!
> 
> Original cover-letter:
> These patches don't really change how the patches are run, just skip
> some tests on kernels that don't support a feature (like kprobe and
> livepatched living together) or when a livepatch sysfs attribute is
> missing.
> 
> The last patch slightly adjusts check_result function to skip dmesg
> messages on SLE kernels when a livepatch is removed.

Why are we adding complexity to support Linux 4.12 in mainline?  Isn't
that what enterprise distros are for?

-- 
Josh
