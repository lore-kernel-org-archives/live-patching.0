Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653C2877E3
	for <live-patching@vger.kernel.org>; Tue, 14 Oct 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461104; cv=none; b=GXGtZbcBeRLPVscmD/gMrGRAcsgR+GztzrBL41wAZm1h5sspefxLCS6F98CE0DxS0E/elfAY07OURzT4NeCCK5QfkOqZq3h9KrU1ApKfnpZew1ueAYEwIlFIF8uWlQW4FoOzJmcwvpWi8uAhMEDE24YPbG+4wqvJY5EyzUMzWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461104; c=relaxed/simple;
	bh=vEdZhxV1Qb9eXYP7qtOtEix+mxqaX1G9KW6H3+3K1Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbw2gixgQEvod813AcTGH5sL3jLG3bUwSKmbJrI4SV59TJjDjleyUuPPMaiPwAjG+jDXec2m+JHxmK2xgmo2zHFb2S/DTkB9Es6ZrxokPRe9/EwaQaJbZfpZWKs4omYUQ9mMH6Hx9KWNoCW6tyNxHSsOdcOgsiIV3FxZPQL3qMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqVTWurZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqVTWurZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B7DC4CEE7;
	Tue, 14 Oct 2025 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760461104;
	bh=vEdZhxV1Qb9eXYP7qtOtEix+mxqaX1G9KW6H3+3K1Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqVTWurZMLf+rLZOBROQDo/t2bDgnBoiN7xdYtv84hYM7irRsgsKXXLh6UvQUSbqT
	 WkPFgPn4htYbEgtWmmrlP6ijO6t9wZiqOybCqYfStfGvJYJVWrm/BjDP45dW8ZY0Na
	 N88nmWfn6mV9Y+g0NxqSG1xQUWKWypV+GlejeJYH07+WdVGgNrim82SFafQbsSdI/J
	 epOP+T4FpYRcxlXfc9DbzdMnbxsu6J4PrDvYJ0XPmL/CY9y3gVMzQ7WVF++LQu+3jo
	 bisiV2xsLnw1dMUphrjEJY+B1dDrgLXjN5GnLAUwmjg/FAQeVylirmlSbjX918oPx0
	 N/rWLzEl+AzdA==
Date: Tue, 14 Oct 2025 09:58:21 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH v2] livepatch: Match old_sympos 0 and 1 in klp_find_func()
Message-ID: <ukc76s4riiku7m5g2buokuy35de5luijb5ijtwnqs3h2ufjv5j@dl2syurz5k3v>
References: <20251013173019.990707-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013173019.990707-1-song@kernel.org>

On Mon, Oct 13, 2025 at 10:30:19AM -0700, Song Liu wrote:
> +++ b/kernel/livepatch/core.c
> @@ -88,8 +88,14 @@ static struct klp_func *klp_find_func(struct klp_object *obj,
>  	struct klp_func *func;
>  
>  	klp_for_each_func(obj, func) {
> +		/*
> +		 * Besides identical old_sympos, also condiser old_sympos
> +		 * of 0 and 1 are identical.

"consider"

Otherwise, seems fine...

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
