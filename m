Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56396156E4;
	Mon,  7 Oct 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323246; cv=none; b=brQrh3b+Vh9hT/VIhPbJSJeYeXq0tE3OEVnDhMkrS2dAzp1luMruhdvG0eDMYFW9xgraBFl6S8gNhRAeJPk9x68oUw2HWXePmoTNvYW3yEoxWJsvOd1P2rc+NOJy8ZVaqFdb0v8SbafddxMsDKFWsM9e4ZlsLiwjzmzC0YPwP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323246; c=relaxed/simple;
	bh=ff/z/zigLFkYNhiwnWrYtLR5miZ/jrOnAhIs4aV92IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/LO1EKPap5BRbeJKHZXRr3T2HJKBqOfoh2IygYQ85oKAGIDKjx8ZgsqbMxPvkhoLTaJQJI71l4nMU7BT9RNfbesaNUTfJ0rtvi0rAMX1/ZzvdI3J0fMAgT3VzVQ/CFznIJiwGq5GjlrHs08lmwiayqdlBS+MM+lajmuyFBzgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8JKvt1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8JKvt1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6509C4CEC6;
	Mon,  7 Oct 2024 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728323246;
	bh=ff/z/zigLFkYNhiwnWrYtLR5miZ/jrOnAhIs4aV92IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8JKvt1TCSsK8vqmTbTfMJBIkfrAZS6sGeF7zk7k3iCg+TvMtbQviUpJKdObRCmD+
	 yzKpWnDLNVTByG5YtGieRrkIYVoKno9/XmJm/1FXjbY2aVVSfikkScB2YFa80EuvIU
	 UfSspsZABPuaLhqBRmVvPL2KVObH2u66WAczG1pny9TOf514P6gvy151lxqgqXqHOu
	 zT8rJ+VgdgPDEL1bs67ygqE1IcafeubtrDoLgCSM5spDvXmaLLWVJ3rLxQZSvfFuV1
	 U997c1FW2v1/DGEdgzMgqaUPWjTuzhcrm8vc8MfgYmwjB2GscVmaiGsjgZeSd+AWcg
	 jx9jwzIuMkTUw==
Date: Mon, 7 Oct 2024 10:47:24 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: mbenes@suse.cz, jikos@kernel.org, pmladek@suse.com,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/1] livepatch: Add stack_order sysfs attribute
Message-ID: <20241007174724.dxzm3vooewzkke7l@treble>
References: <20241007140911.49053-1-zhangwarden@gmail.com>
 <20241007140911.49053-2-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007140911.49053-2-zhangwarden@gmail.com>

On Mon, Oct 07, 2024 at 10:09:11PM +0800, Wardenjohn wrote:
> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> @@ -55,6 +55,15 @@ Description:
>  		An attribute which indicates whether the patch supports
>  		atomic-replace.
>  
> +What:		/sys/kernel/livepatch/<patch>/stack_order
> +Date:		Oct 2024
> +KernelVersion:	6.13.0
> +Description:
> +		This attribute specifies the sequence in which live patch module

"module" -> "modules"

Otherwise, looks good to me.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
