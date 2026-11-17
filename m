Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917528;
	b=27KfpCs61by+vNZoIHyTZA9NEw/ky/Tg92kX3dqODUucBF+SSk2d7HPOBwYo5DOkF0wE
	 VOjShDsz0BO4qkVAC40kMMVS9wILM49S3Z3e4J8w84ulrGcV3Ck5r00079JnAFlytsGBr
	 eN1qMEwIYh6ifCEzqILVJGDqLv8QXIYO4s15M8rcU+WBdcPAoChRNRLnUfCK2ciJiXF/J
	 mo49Nzt3FCclbVsjvHrd5ooRgNORjv5XxQZvq3H2idiShnhoRPmGM4flS/hkQQaAh8A44
	 jjyXwUTouZ1Gm+75GkJJy/PnvyETJalCawvdBFDRGqDvp3cuc0aKG078l+vpqrSr6Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=lj9OagPSRJNvuPdGLWpYCPjIPPY/8eEyHeaFsrygvcA=;
	b=1mYgvOWmZyyCvs9L2rAioyJstoc6rh0cu5MOCtZL4nPGNo0BdmrplB0xfqeNgO4+0I8c
	 OdlYQuLtfWmu9nbvSvQsxKYl2g6AHpiHsZA93LnH87HxImR/n3otHcHL7LraX9uKXa7Bq
	 CDFVYqPNQOCfp1Bf4iFdhZZRLb5Jwxq+ts+Td3v1vKPso1tRK6bBhrxlGexHqCdvGRYdQ
	 QdS7NmobtUtuhWpNU4Hw7WFeyGSW+WSLxrnRQWlnc9bRGQvwCE+tSWN4O34dyg/Ba3IQU
	 37s2QWLOE/FknLHPGyBb1z1CR21p1eppvfgy/bsS9NwH/n56gQAsm+rNyyKSSboFPAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=jlgRi2Cz;
	arc=none smtp.remote-ip=212.77.101.12
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125F606A323
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 12:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D125F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=jlgRi2Cz
Received: (wp-smtpd smtp.wp.pl 8210 invoked from network); 17 Nov 2026 13:12:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1794917525; bh=lj9OagPSRJNvuPdGLWpYCPjIPPY/8eEyHeaFsrygvcA=;
          h=From:To:Cc:Subject;
          b=jlgRi2Cz/vVIwgREakUwVS49sHWLB7aN7h7CfhjIj8hgRoJdvFDpuemdEJaaQWwiy
           dv6H+g5JUTUe7bna0U+ZEuLGGD3ivvaHT5aYkCLA37aVE0naYwhKWc+fMGMbJqvn4n
           OY3PoxhoDsCkSAYYOx9wcabMT+LCqb6fRUmuLcF0bgz7bhUcmZa39D2UcyEuFwKdBj
           gnKIWHao6SFiQh4sbj97f1n7eF9nY1RfajMxe/2eXHHo4MfMt0g85h6FC4grEYgvBz
           +MT/z8JqAEQJ7MKF8RGMb5Rb7h/bmkkGJjN+aLVkyklihZhinWd3LFhUgRN4GYKugV
           GP2gKmLvNH+aw==
Received: from localhost (77-236-5-223.static.play.pl [77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <pmladek@suse.com>; 17 Nov 2026 13:12:05 +0100
Date: Tue, 17 Nov 2026 13:12:04 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 2/2] module/kallsyms: sort function symbols and use
 binary search
Message-ID: <avxElFF4GY1Jhk02@wp.pl>
References: <20260327110005.16499-1-stf_xl@wp.pl>
 <20260327110005.16499-2-stf_xl@wp.pl>
 <afnhidn7K7dZ_cPh@pathway.suse.cz>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnhidn7K7dZ_cPh@pathway.suse.cz>
X-WP-MailID: 53ea68bc8316ef981b297076ee5d6f3b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [sTNU]                               

Hi

On Tue, May 05, 2026 at 02:24:41PM +0200, Petr Mladek wrote:
> 2. Livepatches _rely on the sorting_ of symbols in the module.
>    The special relocation symbols might define a symbol position,
>    see
> 
> 	.klp.sym.objname.symbol_name,sympos
> 
>    in the documentation. It defines the position of the symbol
>    when there are more symbols of the same name, see
>    klp_match_callback() in kernel/livepatch/core.c.
> 
>    I am afraid that _this patch might break_ this when it moves
>    function symbols before non-funciton ones. I guess that
>    the symbols of the same name will not longer be groupped.

Thanks for pointing this out. It took me quite a while to understand
the issue, but I finally got it.

> Idea: Is the shufling really important for the performance, please?

One reason I wanted to shuffle the symbols was to also speed up
name-based lookups, assuming that most lookups are for function
symbols. Moving them to the beginning of the table reduces the
number of entries that need to be scanned in the common case.

In my benchmarks, this reduced the average time spent in
__find_kallsyms_symbol_value() from 16 us to 6 us. 

>    I would expect that binary search would have a good performance
>    even without the shuffling. It puts aside half of the symbols in
>    one cycle. 

I'm now going with a separate sorted index table, leaving the original
symtab untouched.

I think the name lookup optimization could be revisited later by
introducing a new function that uses the index table to search only
text symbols, where appropriate.

Regards
Stanislaw
