Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAF3126A0;
	Fri, 30 Jan 2026 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769808466; cv=none; b=a5SXrvvmDLJst3sespmJZ/9THQWlTgCWJ4jJzt+tOmFQLwr665ORDPuDiMvJVLLKV0ytFSJPtKPHfWxwHNzvo1XMOAIki6BKO3Q0RiCCfNHnkcuibgPNrwa9kVzffAcaDPSPHTgwUvedplkAQ9BDhasSOLYPdY0/qykjKOs03Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769808466; c=relaxed/simple;
	bh=FvIO7SYCBl3tVvwkNQX+8vvn5bQFmm/SLM97HfqpY44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLRIemtFV+fz2i12DbfhBdsp+FhXrpUq432dNQcfiukRN7YEqn3xoFp7th36i7Ufmjk3P3wkUZwiQD+7Cr7MalCcgcfTKf8EB+vpfSpNHdptYodqHxjlfEvoNVBlOQ/bXylpWnOSr6kxfJ37JnC+B/Vtayda2XWJyiCpvDruPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ0lv0C5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ0lv0C5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD5C4CEF7;
	Fri, 30 Jan 2026 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769808466;
	bh=FvIO7SYCBl3tVvwkNQX+8vvn5bQFmm/SLM97HfqpY44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQ0lv0C5XECKpcaBoLx02ghfVe4hvSXFUZcywEGIzWyUV9KCcMifA2hJ7zVKCdAVU
	 JeiKpQJEuO88I7C+9TxDZzhq9AidcEhaymufyoMpYBI0QYsxG/D5+PC7AzwRKUBMgv
	 dAMlo2pWhfmffohQZeD10neAFAYaeSSQ24xJxcWSOqHF8wxoqcutolP/zs1apBzsou
	 SoIqUUOLXW2Is2EjgH6CCmug5G08iKcrgeBnU5JaoQb7nOjaw6l+egN8a0xM/KAYDK
	 yd9fQe3AcId4V49kGRAJon/TixhhwFYlDC9JRWloIQS57ztW6Mhi4zkBOJHC2pg/GD
	 Fk/28FZU0TfcA==
Date: Fri, 30 Jan 2026 13:27:43 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Peter Zijlstra <peterz@infradead.org>, live-patching@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Improve handling of the __klp_{objects,funcs}
 sections in modules
Message-ID: <svcwbksz247y5fboeemlvdi5ef62lh5ibtxuz2ofsievsxlyjp@v35zf7qwltlp>
References: <20260123102825.3521961-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123102825.3521961-1-petr.pavlu@suse.com>

On Fri, Jan 23, 2026 at 11:26:55AM +0100, Petr Pavlu wrote:
> Changes since v2 [1]:
> - Generalize the helper function that locates __klp_objects in a module
>   to allow it to find any data in other sections as well.
> 
> Changes since v1 [2]:
> - Generalize the helper function that locates __klp_objects in a module
>   to allow it to find objects in other sections as well.
> 
> [1] https://lore.kernel.org/linux-modules/20260121082842.3050453-1-petr.pavlu@suse.com/
> [2] https://lore.kernel.org/linux-modules/20260114123056.2045816-1-petr.pavlu@suse.com/
> 
> Petr Pavlu (2):
>   livepatch: Fix having __klp_objects relics in non-livepatch modules
>   livepatch: Free klp_{object,func}_ext data after initialization

If there are no objections, I will go ahead and queue these patches up
in -tip.

-- 
Josh
