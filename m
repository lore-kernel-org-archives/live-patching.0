Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F9395AF8;
	Sat,  5 Sep 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628126; cv=none; b=C/w71ToFIE4pgIC05rN3fqitDiUGx3m5pOz6jQbUiLdjySj69r28zztshWk3/c2pHwEI7Nf4pChz9iqO/FTVJRQSaF/VO1MVIH26a8IM+e5ucjVd8NZa4FAhycgmUg+OdO7Oc02AolRidmIc2BFnsIKiLj07NQylAGAcoLUkSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628126; c=relaxed/simple;
	bh=EdAxOOpQq9ozvd2y1Ks7iMCL914L8VwAwNcOo1YHp30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgZ04oYa6GKEOiya4zfFUW4CNebpY5KBSEX2Q74dmE518+1X+8+2YSwcR8jQbTAqm3TgO2bMncZFuo7gR9L4ZkgcGa4cEPW/1mhzA78QCyOF2Rh8I47T2nDAhKAysvEwjiVJ8/QS7BtN1lKAra+/xJ9Xs0Hzjzi7nJIZAsMQjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RnKysDyR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RnKysDyR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hrII6WX3kOVn23Mg1jbtIoQRCj1SZnekAZCRj+Ycfjs=; b=RnKysDyRFdVz9cnZJaPn7lCBUv
	sUGx+0jmZAErJ4tPt4RvqpLHY/0A+Ol+rHKb2Ev2glT+Fmf0tfShUDz9EBQn7ZusnRc906b3X0NfP
	LJWydB2F3qe8W0uT0l+15XORhvAa2KkkVEg7iZ4SHsjAiCmXeme2wsNiwa3phQCCiGHnMD1Y3n/FW
	qNET9lF7dxUuLH9Zmjn/gCoEIFOuJVAUmiXSKY8+XdOb26WKDR+cNUTgUcjMKMNT/lXSABcr+gBCI
	1Oh+v5U+d/V9F2Np8rR8JYtipnfzBqAaHHrNvHC1A4PS6oFIAezofcMAREpFznhWlNCagqdTal407
	5KeyRHLg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2tse-00000004HPx-2kIF;
	Sat, 05 Sep 2026 17:08:40 +0000
Message-ID: <845297c9-7eea-4057-be8e-c5e34a104a02@infradead.org>
Date: Sat, 5 Sep 2026 10:08:40 -0700
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: livepatch: Point klp_callbacks kernel-doc
 at livepatch_external.h
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Joe Lawrence <joe.lawrence@redhat.com>,
 live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260905085438.40349-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905085438.40349-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 1:54 AM, Karl Mehltretter wrote:
> api.rst asks include/linux/livepatch.h for struct klp_callbacks.
> Commit dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for
> diffing object files") moved the structure and its kernel-doc comment
> to include/linux/livepatch_external.h. Since then the Object Types
> section renders the other four structures but not klp_callbacks.
> 
> Add a directive for the new header.
> 
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/livepatch/api.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/livepatch/api.rst b/Documentation/livepatch/api.rst
> index 78944b63d74b..2a98c517da9d 100644
> --- a/Documentation/livepatch/api.rst
> +++ b/Documentation/livepatch/api.rst
> @@ -27,4 +27,7 @@ Object Types
>  ============
>  
>  .. kernel-doc:: include/linux/livepatch.h
> -   :identifiers: klp_patch klp_object klp_func klp_callbacks klp_state
> +   :identifiers: klp_patch klp_object klp_func klp_state
> +
> +.. kernel-doc:: include/linux/livepatch_external.h
> +   :identifiers: klp_callbacks

-- 
~Randy
