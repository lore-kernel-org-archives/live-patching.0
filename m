Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79C3F822A;
	Wed, 26 Aug 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747510; cv=none; b=vF5xCv3ZZFbAyynQQh2btByIOCF1U1AmHgaeyt5fVukXREpZVjikxDNui2CJdRtIfuCmaR2MPeehANUsJacRJjtvwC5vP22+wiB3LYeCcdIsRSXAT/XYrnByBrMOTYXogu8kMCiDmaRzbstufTWtOy0iCLu9XdBravoy97b3j+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747510; c=relaxed/simple;
	bh=3R4U9U3LOQcVPjm8gFeqKN8zymsv4hvRyJVxXwif1qk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NbcQi3sOgOalVtmi8gfhiFIn3QwmsIfV37NqLQw5lDTB0YTkdiphR1Q5YHrYm1PPtt/QCBpzcdftJma1sxtiCyKS+raygFwXO90f0642+P1TGQbuNYt/XE5nk/UZ7i/9NGTTmXnp9TGRoVbwXhNyfSmA0lvxWgbcYwJlQR6UHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JjO/JJpb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtXoyWTP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s6YMpsXp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3rRqRllx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JjO/JJpb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtXoyWTP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s6YMpsXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3rRqRllx"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3DB3F87356;
	Wed, 26 Aug 2026 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787747502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w60MUEPPZZbvYy8QQ4yVOi1L7uwwFMmDPTTTaGxo5h4=;
	b=JjO/JJpb/8Wfqqzx1cI/6gFvp/xzHc80uqkN+i567O1EAgIE/vCtToER7AF+ibCVPRuMo1
	c/D11PLEAnKdQk+K6dUUmUxIjhDLlLuLE60AxWIXQelP2RaSOUwrCzSgw64BBWTgZ3SV4q
	5BzNofWMjyjRt1Ab0SQwFK9IDzNuEOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787747502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w60MUEPPZZbvYy8QQ4yVOi1L7uwwFMmDPTTTaGxo5h4=;
	b=rtXoyWTPDMbXjHFu72LfrYZfl3rQD0tGHtgtWs9ZNyb2EHMybfJJtBB2DU73UPzFx/cSkG
	4RhNvCY2lDg5EAAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s6YMpsXp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3rRqRllx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787747498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w60MUEPPZZbvYy8QQ4yVOi1L7uwwFMmDPTTTaGxo5h4=;
	b=s6YMpsXpEULDXFWfejACdaOtBcEISjW86Qjl/fsLX0v1jtNQU909v0FRQr7cv7SXMHTJsK
	DoP7FjtGvhh6w/fhDMxYd69bYj4FZBAPAX5+UGz1vfYOk+LVqOQvr8e1vTS9dzj/mv7s1O
	H1fzEdHnk0Nf9e9N38edioAkOQCLRRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787747498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w60MUEPPZZbvYy8QQ4yVOi1L7uwwFMmDPTTTaGxo5h4=;
	b=3rRqRllxzJU+Zcuc3dcoMsc4W3ek9SN9J8rJlIeAFVIFPQdbNuT/Lv1xx5XECDSbMPAkZ7
	yaJNiGm38NjtwFBw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 7/7] selftests/livepatch: Add RISC-V syscall wrapper
 prefix
From: Miroslav Benes <mbenes@suse.cz>
To: Wang Han <wanghan@linux.alibaba.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, Oleg Nesterov <oleg@redhat.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, oliver.yang@linux.alibaba.com, 
 xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com, 
 jkchen@linux.alibaba.com, Marcos Paulo de Souza <mpdesouza@suse.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20260804103626.2803112-8-wanghan@linux.alibaba.com>
References: <20260804103626.2803112-1-wanghan@linux.alibaba.com>
 <20260804103626.2803112-8-wanghan@linux.alibaba.com>
Date: Wed, 26 Aug 2026 14:31:33 +0200
Message-Id: <178774749311.159175.197938017149793901.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=520; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=3R4U9U3LOQcVPjm8gFeqKN8zymsv4hvRyJVxXwif1qk=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqy+O8vnqEukLZkoF3nULnnRwzVdzxet08tb2n/u//Pji
 2wC5VqrOhn9WRgYORgsxRRZXu91ljOckmugWf3uLswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6BgxcHEKwFQbsLH/09PfUWOQGdS2gvPIl4Rjuw2KWK/fMVqQmM7AP0lpzq8wXs5P6pY7Zz5
 tjtj3I9xqsdgaSUZW+8UM1mptHiXXmJzbJM92B32433rv1/SLy0Md/s5zUyp7trZLJapBcOX65/
 uklsmmr2/br77B3tvv+Ox3aS832wTEMx5OZjI9XKRzxaiENduL/bVNlYxcktR8K3tHq+D69dvKD
 jbtfF11Q367uri1zpzaD1NmVsZr7jwaWWTZfuZ8m+NLkz8sVsdetPNHKH0Q2Nhy5Ijt13eXQ7Im
 tdmdMV52X4Vtqf7itIk1q9UltnzwYbx5/kX933kajNOrrl2cd+aPqIdMdM+/jAP/xJ4ve3Dj4Me
 gkk5JAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [17.40 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	BAYES_HAM(-2.99)[99.96%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	R_RATELIMIT(0.00)[to_ip_from(RLsioq18c1iinsph8nfbxhofki)];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Spam-Score: 17.40
X-Spam-Level: *****************
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 3DB3F87356
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam: Yes

On Tue, 04 Aug 2026 18:36:26 +0800, Wang Han <wanghan@linux.alibaba.com> wrote:
> The syscall livepatch selftest resolves and patches a syscall wrapper
> symbol. To use that test for RISC-V livepatch validation, add the
> RISC-V FN_PREFIX definition for ARCH_HAS_SYSCALL_WRAPPER.
> 
> Without this macro, the syscall livepatch selftest cannot resolve the
> RISC-V target symbol, and the syscall-related livepatch test fails on
> RISC-V.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

