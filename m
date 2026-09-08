Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396E545DBF;
	Tue,  8 Sep 2026 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875523; cv=none; b=bO0ttPLRuhfICot/WZSXqcnvcJSGpakXbgPayaQcPJxz4qhvoddyAmGbsEHrOQBFL+hPnHvBGSan67wYcfur7IdJs1KvV4r7pcde/jCZ7qs04JCDZWDsyunmdYm25M+cLlx13bss4PL/Yh6+Yjoj7U2Rq5g+rMnw5fhf/CE2IrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875523; c=relaxed/simple;
	bh=c8Gv/tOmnBsoRpMKP0BTnBqpL8Bhf2gTxJwPTe6abXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M010ui3vZO1AIXJxaMoctqtXdt6gttzS9BFb2Dnmr4zSfG/gtHstME26dtcpqoYLI4pTH0JqQE56btz2oa7NyT5ovcoLRr6XRHjVqivmu+vx02nsoUCkNNh6MO92hhcPJp2FwYCpFtmi3gbSmbwfct7jBWa7Jd1VhIeReK6xHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=uTc1rGyi; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="uTc1rGyi"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 297A31C27D3;
	Tue,  8 Sep 2026 13:51:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id BF43420012;
	Tue,  8 Sep 2026 13:51:39 +0000 (UTC)
Date: Tue, 8 Sep 2026 09:52:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Ard Biesheuvel <ardb@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Sami Tolvanen
 <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Leon Hwang
 <leon.hwang@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, Josh
 Poimboeuf <jpoimboe@kernel.org>, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, Ben Cressey
 <ben@cressey.dev>, "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Subject: Re: [PATCH RFC 1/8] ftrace: Let ftrace_call_adjust() reject a patch
 site
Message-ID: <20260908095253.520c278c@gandalf.local.home>
In-Reply-To: <ap3PYIdhL3ETmN0Y@linux.dev>
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
	<20260904-b4-arm64-callops-kcfi-v1-1-ce6687739b0c@linux.dev>
	<20260904084728.6d2ebcc8@gandalf.local.home>
	<ap3PYIdhL3ETmN0Y@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: x457bex6yki4ewxmaioc5ood1sdccp73
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BF43420012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18nR2NzFrPVTBxdKw6aYNAKXDfxBb2FKIM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=zmEISpUYs3PxDYsmwRf2tNZx1Ic66nQ4OS2YYg6VWuk=; b=uTc1rGyiax3d1heQBZvkqpESgAHTDt6puNzDb1kcaIw4IkVtTy8A1ipxHVxbFEoTotD5HI2HsR4MrblNpcB2tBhZCY5+By0G9i36l82d2hxFXEU+61IX5LsNnB8IYnbFlV+Hdk8lzxWxarrR31+5z6ELIXFNLi1siI+bPwO90hs=
X-HE-Tag: 1788875499-703192
X-HE-Meta: U2FsdGVkX19G2BzycxCMNywV55nFSuOsSuiCbrC27AdqLgblO/sjNWn8yFEVA1Pp4o54M56CAWLIIQPWiVbjNfHhKlkV7l9KH/m9cY30zHeFrqCV8VhxxkqgYRPQd0XdnDR29QpQjYtYZgEHDCk6F4UR4PhSZraMLTC0xijKFy1vc0KkipbPR7rWejQrGl0csG0VWcKwTFPmYo+8Mz/gKTw5i6SQwge1PHx9dHxhXncKI6vPabGOBRl5yQN6P/57/0gb/tGzPJdwg8IvwUXMxizGUE136mn9rXBG5BXLbaHmWF3w9OZI7xiwx2sAB2Pm

On Sun, 6 Sep 2026 20:40:59 +0000
"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev> wrote:

> Will add one in v2, thanks.
> 
> Today arm64 returns 0 only for a mis-aligned patch site. But patch 4 of
> this series replaces that check with two: the two NOPs to patch must be
> there, and the ops pointer must fit in the prefix NOPs (which also
> catches a mis-aligned site). How about this to cover the series?
> 
> 	/* The architecture may return 0 to reject a patch site */

That comment is fine. I didn't really like the specifying of mis-alignment
as it did appear to be too specific, and could change.

-- Steve


> 
> Happy to name the mis-aligned case in patch 1 and extend the comment
> in patch 4 if you prefer that.

