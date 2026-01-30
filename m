Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BB311964
	for <live-patching@vger.kernel.org>; Fri, 30 Jan 2026 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803778; cv=none; b=EO0d+9yixLcBX/WcEqtQWc4xOJypwtZTJIEdMEgl7Q73WPOYzOXyDHpEsqqn7nS6C6KFhmlkDz6winqZ1yXfzVZhkSTiItCWz+uFCOw3W65wG33H1gNqrhFxU6CUm5ZRVQEBijafhtcgORysbgARbU6G4J71NBxP3i5LOXc6EZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803778; c=relaxed/simple;
	bh=laDDcedekiuyorAM7msZ5Y67n/K9jtFg4IB0Mc9qFZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbSx8B72Bwybgn6j30zyVW69m7cS70vVJMjsvCwwYlXPkedA1HC4jyGNBByJZUKjbOtbi1QSOIB4F3yCX3tPvRqqYP0vr5Vxa284y31Tpcl5v98D9GrBbEriTkinnXfwcamRCH/xeJWU9cTG4WZf6R95a3W+yLCbFYJSnU7mqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clnriwho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clnriwho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32339C4CEF7;
	Fri, 30 Jan 2026 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769803777;
	bh=laDDcedekiuyorAM7msZ5Y67n/K9jtFg4IB0Mc9qFZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clnriwhoDwWogKG8xjEZQryJIXob3Yx8seU5ZYiWsSypsd9yDZdtqYU7VttcjlQIj
	 ZM1QqjqH4WSMN1pBpl1KYmzLeuIlhwsqVHTcLOiInJG6sc2jR+N2qz45/dX5H/Elci
	 liMsz0ym1ct8/GgORAWTuDbchZLqhEOPrKPC5KsczIALeKiOY1xMNcB8vsu0ruD7z5
	 SBw/HXRSyVYPZuoNe0wNg9atj2BEI7fQtmnOTacjH3QBwJocVS/1FK1JvBfvmb5wxu
	 gM3TsD/o0du9OUZ0B+xf6dKHDoRSEFdmzlMiAbDlllVYXF9DntDJCYg6rR60BVQoLC
	 d549cQ71nZTuQ==
Date: Fri, 30 Jan 2026 12:09:35 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 4/5] objtool/klp: add -z/--fuzz patch rebasing option
Message-ID: <fayrtgx5l5wvcwkuxqc4it3t4ft3o7rbn4uojtmzjxq66nniw7@v6om4zyepshh>
References: <20260130175950.1056961-1-joe.lawrence@redhat.com>
 <20260130175950.1056961-5-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130175950.1056961-5-joe.lawrence@redhat.com>

On Fri, Jan 30, 2026 at 12:59:49PM -0500, Joe Lawrence wrote:
> @@ -131,6 +133,7 @@ Advanced Options:
>  				   3|diff	Diff objects
>  				   4|kmod	Build patch module
>     -T, --keep-tmp		Preserve tmp dir on exit
> +   -z, --fuzz[=NUM]		Rebase patches using fuzzy matching [default: 2]

Ideally I think klp-build should accept a patch level fuzz of 2 by
default.  If we just made that the default then maybe we don't need this
option?

-- 
Josh
