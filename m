Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537345;
	b=KT3EBTjcts79C/YRP9Mi0KwB00TuhOp9geNojBpxrmXd6p8KmH2A7VUf8I2mvLMUWtuh
	 5qKFn08kSzL1nr0vYB8EKkGZ7nmVWGoFplMmK00fEQc0nbVu16qrDS+J7X80mzzjEkNWp
	 S03qKXSnWI4U9pYFvtxkPNw7mO//TsaRcBc6tWfZTHbNbS9UsGXoBPoY760RbvMejDUPw
	 jXQcx/Tdss5pJlA4KSIcgSyBD4JdVDaSBSXHJOGcu69+t6k0wEBBeIftbZ6ukN4om8a39
	 1rf1Fld9RkJwB0ED8f6pco+FFvHj0MmmmPt9DdWSejaTvTVqZShdkLTZhz0cnbY2Muw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537345;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1AxAtbzl4o18Dc8S2gGBClHTTNXWSJfjlQEN5YnJVP8=;
	b=Db0VN68I6iw3I7AV7fFER+DKByI405Jndval1z57jKb25V9mwSsJGKFOnPmVU540ho7z
	 FaraepMBThYGP8YIaVvy6Hz3mbe+qxETvDvbwL204UivxgHjgy6S1lODFwyOlZWvcrBbV
	 urxq5WoAZLr8rdEEmQAeyOYaWQeTDT1vevwcg/679bw/qiEUpZg8CN/ElLI22GUc75/gY
	 pjJrbjTnDnHoq6D76S0JbS3vErx7XCAJhiaHYgIsVtzN12x2GfDtc0C0ZGB/AirF1tquU
	 kFrDcjSeyecm+MXPbKJlrYdVTVf8LhC3VbFJXwZAHJTme6VybDZJHEv/ah/LiKtL6hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XNOj/6KS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F52606A31C;
	Fri, 13 Nov 2026 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNOj/6KS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7E11F000C4;
	Fri, 13 Nov 2026 02:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537345;
	bh=1AxAtbzl4o18Dc8S2gGBClHTTNXWSJfjlQEN5YnJVP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XNOj/6KSTfv/2SzV949emJkrw8rux9axLtj3Zfxm/nA34D9iEQTAAnJDKTWdEoQo0
	 ZyUXBNwMqXX0/gR7BileAWjtPyAj7gUskaJZe4zVxfABW97qVOOF+6dfRz/zCw5a5G
	 aJAtXp3Y2sL29Y/mlKgpO0O9hrzN6sBo4mhtLhVZ3EpJxCyRXQUR2iIpel1ze5KAmr
	 H0tSEROneypuQUXkAt1Mn/SmAM4ryM+222HGqdbEDT+G6MUhnq7KGtlYQy59VO1tR0
	 OHRmkqcXZrCB+aw7vQM8KpjloNZ31J59+BivSgyJT2ijdwpfQXh/v0AYyJuFdGW2l2
	 FuJUGeka40kUw==
Date: Thu, 12 Nov 2026 18:35:42 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/11] objtool/klp: DWARF-based cross-build symbol
 correlation
Message-ID: <avZ20mdxRnzTPY4c@jpoimboe>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104133158.3187525-1-luolongjuna@gmail.com>

On Wed, Nov 04, 2026 at 09:31:46PM +0800, Longjun Luo wrote:
> Responses to v1 Review (Guide)
> ------------------------------
> 
> Thanks to Josh for reviewing v1. v2 responds as follows:
> 
> 1. `CONFIG_DEBUG_INFO` and split/reduced DWARF: as suggested, `klp-build`
>    now requires `CONFIG_DEBUG_INFO` and uses Kbuild's debug flags
>    (Patch 6). Reduced and split DWARF are supported (Patch 5). See
>    "Compatibility Limits and Build Requirements".
> 
> 2. Repeated macro statics and the one-line test: building on the
>    referencing-function idea, unchanged-function references resolve
>    repeated statics (Patch 9). The tree-wide test reduces v1's
>    `no correlation` warnings from 682/764 to zero (GCC/Clang). See
>    "Evaluation and Performance Overhead".
> 
> 3. Upgrading `no correlation` to an error and explicit annotations:
>    following this direction, v2 rejects ambiguous data references and
>    allows verified new data (Patch 10). See Case D for the
>    state-inheritance boundary, its kernel-wide impact, and proposed
>    annotations.
> 
> 4. Referencing functions, ThinLTO naming flags, and Full LTO: in ELF, the
>    referencing function only approximates the defining scope, and
>    `STT_FILE` and `.llvm.<hash>` suffixes only approximate the defining
>    TU. Definition identity distinguishes inlined helpers' state and
>    survives LTO renaming and `STT_FILE` merging; see Cases A-B.
> 
> 5. Toolchain reliability and performance: v2 cross-checks DWARF against
>    ELF and measures checksum/diff costs, including a separate memory
>    prototype. See "Design Overview", "Evaluation and Performance
>    Overhead", and "Open Questions and Next Steps".
 
Going forward, please reply directly to the review comments (including
sashiko reviews), as threaded emails are much easier to follow/discuss
than a summary like the above.

-- 
Josh
