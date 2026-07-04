Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38926150997;
	Sat,  4 Jul 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130355; cv=none; b=qny7DuvXiwdTGTj36bbaXRdduWKWBqtq7TcVDLr7qQwjaA6IMzwkTg8zHfxR19a52F/ILhJJ7EJ/TtXdZgzotADp4kAEUQ3NROBUqqiXUTGrIDsIJIpdwOeBCYgM3IsedXFTcgjxTnsX1iUSQ8zEg2Xvo/+W6YJ7vXI7q5RT1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130355; c=relaxed/simple;
	bh=/2mJWVfJjfkfle0EVwSRjRz/Tdc1zDZfT9UWeRyszhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/iS0jOBrRE4TWinQeY9H2dYvYwPI7lDbWIS4Phn/tKUjAfX8B3W0b2YfvGi4lZ2ddYfYTYYeNUmao5DUlJreB0HIqffLsWSp7MTbAVdXhK5ZwyYHKRspz++w0oowsxvJxoi1Rg0nhpaEEIabPfFIqjIT8F9Wqcuz2Dxo7e36IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jOLkkEqz; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jOLkkEqz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783130343; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ODlSjJH8+4SRzCaSNrFMVGFA6u+Rs1hlD97twS6n6t8=;
	b=jOLkkEqzlo+SeD/rRsm9PQ/VOFIqLVL3MIFC1jYLXukbBr5m+wXlsKZv1THh+CcgHDAxyxE+slkyS5szod7j98oWg5Nsor20ia881DM/ty7dC+dRSWgf0yk1v6Kno5aiB4dblD6O79mNU+M+RFIVLAqANzRrTAknpIuAUGkFeeo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X6KR50J_1783130342;
Received: from localhost(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0X6KR50J_1783130342 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 04 Jul 2026 09:59:03 +0800
Date: Sat, 4 Jul 2026 09:59:02 +0800
From: Zelin Deng <zelin.deng@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
	live-patching@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kbuild: unset sub_make_done before calling kselftest
 build system
Message-ID: <akho5uXVYWGOI5Y2@tdx.gnr>
References: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
 <akdx6xWTuv5Ga0YY@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akdx6xWTuv5Ga0YY@pathway.suse.cz>

On Fri, Jul 03, 2026 at 10:25:15AM +0200, Petr Mladek wrote:
> On Fri 2026-07-03 08:04:08, Thomas Weißschuh wrote:
> > The kselftest build system may recourse back into kbuild when building
> > test modules. In that case kbuild needs to parse the new flags passed
> > from the command line, instead of using the ones inherited from the
> > kbuild invocation.
> > 
> > Force that command line reevaluation.
> > 
> > The same was done for scripts/install.sh in commit 14ccc638b02f9ec
> > ("kbuild: cancel sub_make_done for the install target to fix DKMS")
> >
> > Reported-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> > Closes: https://lore.kernel.org/all/20260525083721.27857-1-zelin.deng@linux.alibaba.com/
> 
> It is great that you added references to the related commit and
> the original thread.
> 
> > Fixes: c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> I believe that this is reasonable solution:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> 
> Zelin, could you please provide your Tested-by, please?

Sorry for late response, I just started a vacation.
Sure I had verified, and
Tested-by: Zelin Deng <zelin.deng@linux.alibaba.com>

> 
> Best Regards,
> Petr
> 
> PS: I could take this via livepatching tree. But feel free to take it
>     via kbuild tree. I am going to wait few days until the discussion
>     settles down.
