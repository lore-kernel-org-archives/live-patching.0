Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A327280A
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069546; cv=none; b=TVuW3l4fMyQNa1PbVBYv4B3ZRwpS1g+4UnbmOisrYGu4KTdVcHn+4J261YRcJP5UdabSuO39dXjgBJjLC68H54VjvUMtehyiutqiaYWHoZA1mW9Cj1E+7DHUdHuup7lv7EF8PfDolCHiyaL14gBvzxL5+Gjx9qSpA6zj/6+1UDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069546; c=relaxed/simple;
	bh=P8TN1Hry9ra5GqyT+peO0TWVmnGCWgS0o6HxtThv/Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehqMECsa4H2m/NJ6uz3VKyLC7e/w7Fi16GFsIhBJuHONW3w0WEd5aQHg0H821UsgEg+leDkzuUiW7F49VmJYsMNQ0g5cwcBEExt6HnQW1U/aEFida5aX1zq3m3A6SUVvBB5ZaRCGAauAlXS0CI6eQahxpGen+38lI/EPTRKr4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j91tgzdX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j91tgzdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930B7C2BCB6
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777069546;
	bh=P8TN1Hry9ra5GqyT+peO0TWVmnGCWgS0o6HxtThv/Mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j91tgzdXAeJwD/zx7ehZG3PYkUXG1VXDUl6vQAtTOcvFx9BIBaYUATF4qK73WCaHl
	 mSqgSErrV7J2iRmegVmW1LjlWBxIRCv1z13/kMh/fwUPXV2jRlXm3Fko/dSXFncEJz
	 BWUwhRVIyhlSypSG5MQcpCG+yyXwX48Rj18WfnSMUwkh/6HEhY9YPZM7yahjCoM3sS
	 grc5Y3B8cWdWnr779cHKe9kQnvt7t6FrNnZKKdH6+YkUlaWFEB0LNqk67mhaFTT0QZ
	 u8RiFHMy3AwES3YUnRzSJ2gO5+pM66luYIiUlLz8sJfWhCFeKCa7kTAp0NQNw30maN
	 llOEYfRUlDB6Q==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8acae26e564so96040056d6.2
        for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 15:25:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ80WNSl+fAAcak6JbtVFRBWUtKqALoo3b0BZJcBVcv3u5YfU+E+hOJM3oen/yhC6zDORkbyJSEdqzwbimMA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5Jt7LCCoCHdz7xd68y0x8l5fOWTIeYCT+AxQrdjcDRv7OFQB
	itbS8t4rDEJbIGpWalSrJo3tCYQu2h5RuXQZM0K/laBPaq/C7IuyJ0iy+H6cXBq0t8h9SOJiQay
	7IawyfsX7fMx4jSnXpGvgnh0RU/Quwgk=
X-Received: by 2002:ad4:5cc4:0:b0:8ac:a92f:cd05 with SMTP id
 6a1803df08f44-8b0282395a6mr544878396d6.48.1777069545694; Fri, 24 Apr 2026
 15:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776916871.git.jpoimboe@kernel.org> <d11a2f7a57690fc4b6a8a02414d07b41dbebeb2b.1776916871.git.jpoimboe@kernel.org>
In-Reply-To: <d11a2f7a57690fc4b6a8a02414d07b41dbebeb2b.1776916871.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 15:25:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4JQ5NuTX0g5KwAt7vpsa4X7eSNVKUONDDaRw+DjTggqw@mail.gmail.com>
X-Gm-Features: AQROBzBKsFNQnRwwweXWUO7NmRpGWmlxlO2YeflE0WIscp8vqULFViXDVQE0ovc
Message-ID: <CAPhsuW4JQ5NuTX0g5KwAt7vpsa4X7eSNVKUONDDaRw+DjTggqw@mail.gmail.com>
Subject: Re: [PATCH 37/48] objtool/klp: Remove "objtool --checksum"
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 9:04=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> The checksum functionality has been moved to "objtool klp checksum"
> which is now used by klp-build.  Remove the now-dead --checksum and
> --debug-checksum options from the default objtool command.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
