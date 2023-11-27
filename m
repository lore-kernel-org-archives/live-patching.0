Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h393ToUK"
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF31198;
	Mon, 27 Nov 2023 08:47:42 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A11122CD;
	Mon, 27 Nov 2023 16:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A11122CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1701103661; bh=PElfCpTsbglocYhm74CbnFUGOn2AgVQ5W+x0cQZ4w0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h393ToUKr/8LyxxGob4vtHlmR2jz5oVauXHvneNcvXAQN2IMSLemP8RKRh6gzIzmz
	 QhayC0Twti6twe4AIx+OEKZJjhUpiJx3oFsPDjOWngKcb59zctYJArtnN3jniq42fI
	 9zbpSelIfR3vabzVJMGbytQajb1pTwAwmz372/CqfuWiaOq3nzqLOdr4s+LaKvHW2b
	 iFZJk0AjwBUQsohnAnREIsehnoRuZAxvWEiwXDiurOzPR4gJkTrs+Yd+j82bLuLa38
	 lJspGVv4xZoFn9YsWBw99cQgdTerUsj3A4FoKn4bQl1RVqFNYLQgh+Ud0Jyur22wyI
	 7n9OIi5FRJ5Eg==
From: Jonathan Corbet <corbet@lwn.net>
To: attreyee-muk <tintinm2017@gmail.com>, jpoimboe@kernel.org,
 jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
 joe.lawrence@redhat.com
Cc: attreyee-muk <tintinm2017@gmail.com>, live-patching@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Took care of some grammatical mistakes
In-Reply-To: <20231127155758.33070-1-tintinm2017@gmail.com>
References: <20231127155758.33070-1-tintinm2017@gmail.com>
Date: Mon, 27 Nov 2023 09:47:40 -0700
Message-ID: <87ttp7ywgj.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

attreyee-muk <tintinm2017@gmail.com> writes:

> Respected Maintainers, 
>
> I have made some grammatical changes in the livepatch.rst file where I
> felt that the sentence would have sounded more correct and would have become easy for
> beginners to understand by reading. 
> Requesting review of my proposed changes from the mainatiners. 
>
> Thank You
> Attreyee Mukherjee
>
> Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
> ---
>  Documentation/livepatch/livepatch.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Your changes seem OK as far as they go.  But please read our
documentation on patch submission:

  https://docs.kernel.org/process/submitting-patches.html

..and specifically the parts about writing proper changelogs and the use
of a full name for your signoff.

Thanks,

jon
