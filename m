Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DA32572F
	for <live-patching@vger.kernel.org>; Thu, 14 May 2026 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797345; cv=none; b=lbwNS+FdCt7e2211rJBrddJ3/+VBPRfmDJPUa275ONlEHohE3xbif7n8fNaho6Cd7YQJMYJ+/U2evSX+DCSMzmxbkTfQ5+ELxAFB54JDwQVhEoJtgqC2iNleEPq1GnyLh0pZXg2Tkdk8RdLEpcvTAUBfgMzykXiocppNRxY/A4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797345; c=relaxed/simple;
	bh=SIUMPPhLYQfebcU6ulCxa3RhFobg1UPAw8B3rsPpTcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrtenjENbO6OXE43ojnMfbkUytqfrKrQ15FQ15TRryBm3Xyxe8+VLGmj5gAHTpGaLrMtOPHiXF1pPkceflfUgz8fhNAc5VuJRuOtOtgNm37Fd9Q821OlA8UC4LSKzmC91V04Bdb/poSJl5YPm/RyJcps6wFedFofo9Nl7WKUEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu8VggiG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu8VggiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29879C2BCC6;
	Thu, 14 May 2026 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797344;
	bh=SIUMPPhLYQfebcU6ulCxa3RhFobg1UPAw8B3rsPpTcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zu8VggiGg24KJjmYJo7EdQdeFdT7UWRSLOrTVvox0o82j+PFiiX/82bQadNaa4U8V
	 dJzKgdUNU0RzLuu1cB34K4Y1biCCPHb0pPUNmsDFod8XLHvpqhu5hhT8Ke2QYUEYCt
	 I96W3JfEEJMh2OhaqihrhjD2v/QiY9XM5Y6xzae4ET7owZE7Mt9/Y53qXAENmHMr5q
	 WHurnmSqUnzZZ+Fee71Yq2YzgBst9IyOvMMjB16inBPCb31j3H6WC5yu2Q957ekOLv
	 qUCWqgwwyg7lsVnyPfdVuLjol4uGWwIZQR0cqB57WbsSvP14an17TCz8scHj0pD888
	 AuJUWZtBxab7Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] livepatch: Remove "data" from struct klp_state
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, mbenes@suse.cz, jikos@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260513143321.26185-5-laoar.shao@gmail.com>
References: <20260513143321.26185-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:22:23 +0000
Message-Id: <20260514222224.29879C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing `data` from `struct klp_state` breaks compilation of th=
e livepatch selftests and leaves kernel documentation explicitly referencin=
g a non-existent API.
--

commit 792ddcf269c47d4de395b3873cfd5f02cbf282ef
Author: Petr Mladek <pmladek@suse.com>

livepatch: Remove "data" from struct klp_state

The commit removes the data pointer from struct klp_state since its lifetime
is tied to the module rather than the state. This pointer is lost during a
livepatch replacement, so shadow variables are recommended instead.

> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index fef0c2f970838..56b7e4fe01bc8 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -152,14 +152,12 @@ struct klp_state_callbacks {
>   * @callbacks:	optional callbacks used when enabling or disabling the st=
ate
>   * @is_shadow:	the state handles lifetime of a shadow variable with
>   *		the same @id
> - * @data:	custom data
>   */
>  struct klp_state {
>  	unsigned long id;
>  	unsigned int version;
>  	struct klp_state_callbacks callbacks;
>  	bool is_shadow;
> -	void *data;

Does this code removal cause a regression by breaking the compilation of
livepatch selftests?

For example, test_klp_state.c and test_klp_state2.c actively use this field
to store and transfer state.

In tools/testing/selftests/livepatch/test_modules/test_klp_state.c:

allocate_loglevel_state() {
	...
	loglevel_state->data =3D kzalloc(sizeof(console_loglevel), GFP_KERNEL);
	if (!loglevel_state->data)
		return -ENOMEM;
	...
}

Additionally, does Documentation/livepatch/system-state.rst still reference
this non-existent API? It continues to provide instructions like:

In Documentation/livepatch/system-state.rst:
  - Allocate *state->data* when necessary. The allocation might fail
  ...
  - Make sure that *state->data* has all necessary information.

Should the selftests and documentation be updated as part of this change to
prevent build failures and confusion?

>  };
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513143321.2618=
5-1-laoar.shao@gmail.com?part=3D4
