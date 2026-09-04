Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F9483BCD
	for <live-patching@vger.kernel.org>; Fri,  4 Sep 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524315; cv=pass; b=SkoX7d5My6eHkbnif5GBIYi4yclo6th+WZMyc4VVYpKtvnCYjSZcElThA5c79xEW/9Alfcg+s918Ekcq19i3V5IbAJvaWEVRNWmVqsAYZCu3+Z8AGCiVZvTucltJ5koeQwEyc7LtMp4BQwhI0Fo9SmjEYTT6VOeMxMQZCRSUPf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524315; c=relaxed/simple;
	bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5YOkYBIuH79IJ80CrgrFuGrGG8TQFGTJXBdWKsOKbEvKMdps42DO+FyqiVP8sS3W11nAH4x+HwB5ssYgx2W5HilUdYI7FJ7K7QU5GanZ4tlaBo7pAz5rmN9ICh6EFlKGAn9etODHoLvHT0n1AEHZitVyIldjlxnDqas4MaMiSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMNauiri; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMNauiri"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccae46de39so1288105ad.3
        for <live-patching@vger.kernel.org>; Fri, 04 Sep 2026 05:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788524313; cv=none;
        d=google.com; s=arc-20260327;
        b=OWq3rXbCPKnsbRZTd1im2N9LpEEPoxeAmSWLUpqX5FrvFYA9oWFFQiYIfJM7gYmUef
         btX/dq7qQ0p6KYWs3qHvKHxNHo8r3vzp5D5v63pJM34uyNuBF9X7x3zLqFQPQzGxyFoA
         uGfD9EXa0/yZBOGo+0j8wAKnlglBAV8mvRQ43q4V0hwbkXy5CCh3G86sjxiFhZxD8Ia3
         FK8PIwbQv/bYPkoP+csNICmVdmGkVmGbmPTnlzI1K8XEecmpykdNnWzI2V/18RZ8yrAY
         cuNmdJbmE00+IkcTT8WKmaRDxL5FO8bG454zV4NDOUHx4sPgJ9qo9Sm5ekkdFXIJMMqk
         hb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        fh=DgwUlj4hR/CJtWpNhUBifuyA0QiZYm03tQDmWlZERzk=;
        b=X+26Mgak4TlcCzmfsC1y/NgdySSOmvM6hu6JYXE3KuNkvhpebnt5w22GhuKb4ux7ZB
         c5y2ubG/D3++U+KWH1vOhWRy80GE+vVmsh4tC0ljze4SlMLlxMm1rOHp3sqAjHek9ys4
         yEFcRRWafHUlpZ0UY0nL8XUynjlis2Q2Ncnng6fh0PCoWil3T02hW1OJOGChwTOU5myE
         Huy2UJCGY4M4QAvEaimH26KA+wJFnrNrjcrNbyrWqnhy/quQ5xJd1bF7Btbg9PF2Wp6T
         nZ/L9HHQ8iWObpOmNfxgV8jfwATVrz/p23wJb0Q7uBVBMSRxqpEOsUlel+oFjykD85KU
         P/Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524313; x=1789129113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        b=WMNauiripi6Md2Q3C3KkcuWrocOGGRafMxbYDlATW6HV68aOBusr3FL4eXVoF4vhsX
         DO7Jgfmeno5zhnwRWIgfHvrvUM+3XTG/xFulQb6uxqGbEytQPlf+GGxxMKD983IfwasK
         JZ8dP4XrZbEY8oiEzvYHXjbMf5wbZHBRAbESh+IxlSqcdT149S3ok0u273lxbuoHsZB5
         x3PySqQZGNcJbPkCUFb2OKLEFffWYo+K3UUed1DYlevwTlbFIAr1+u029uYrVRygQ4ml
         OkrtFQlxk0wYKPBPPf39rZeJx4CxE/88YUpd0GyCLyKaJbRs/qop3EUiAQiviishSpQw
         WkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524313; x=1789129113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        b=lLiFUbOu7i4qtb0q+0GSUsaR+YSJIVr7P3Ja1/HTZ3/U4xeGGksW8eIbrVXJWPBnrC
         A2s8I1swPqfSaHmiMQ499YnbToKBZqXIaETGDOlu1AvPe0BoK6aTzGKormMZ8KiUk3oB
         TyTbFOxOssCkG/C2u06Ha76Ww6FmuhCVLJb6ssqJjeK171ojUWc3VHPFcivOMjWAfejy
         2Ftd1VTepjRdDCGo9Q+wmZoJUcdehJL1ZeqvBTLMCchaoS+w5ttN1SrzlQP2L/nvqLlx
         kaGh7vqOslxcjnEEnPRhqH7GPFvrhoZ2uzrOuR2H+4RCLCOUTiwyrHjsLLIR2pHiBYKp
         2VRg==
X-Forwarded-Encrypted: i=1; AKwUvByJVNP46iat0xlQlN7lnObl/0Lm3VYottRP3phVY+IMwD0vYfgTTfrwfw1prJSWrvqAjL1LdXjDtWlW1H0c@vger.kernel.org
X-Gm-Message-State: AFuF++nx3iSmYXBuqyXzIMjz//GnjYe6DMPVzt1Hp2Gy5TBY7qnXxPZ3
	U7JAJHCoVZ3O8l1EVpLjz/98vJoFlmH1AGGfKx8XhKooiAwqK/TejCzKWTVm8ttKPletTXWmbs8
	MXYw/YQVsiOVN5MX2Fy4OU9VxZL3S6GM=
X-Gm-Gg: AYBFou1aVpeSk1+w0V3nuLyvJh72bflHdS1/BSXsc3hdbThLS0vYO2MmHGLl57nOBlN
	LW4hR5YaOiCn4HIUFBCOLwrLXdE0ZxgS2R2h2ctRtJAQ1Y1bjb+DL5Z5cVAXlMdjD0rePUblltH
	LTSPzAEBQekJWtTeq3iFxiun7k44jzRPs11yD7wrbRjfQX2/FBQsdOop5NxCy3G+qz8yKchsNi6
	ioWBTyKN1pzPCyYq8/elggzkudD9fBqZ+2IoJQoqnnOzGyqVm9t4uvDxQjCA3IMqsRdcjO1GyCD
	Z4hbtL0GnI/B01WyF6tBemwCfNc6dvA5kTigUvA0fMU5bzoDNgBf160gffc0AcIJQb6sH9IhOHl
	r6+O22LjftkZNGLqyOQTmPAusmUo6qT0q64SZbdv9axA+PZ+K/Vsc+JPp1hYJ
X-Received: by 2002:a17:90b:5404:b0:396:d28e:b52 with SMTP id
 98e67ed59e1d1-39b26229b5dmr5722108a91.3.1788524312944; Fri, 04 Sep 2026
 05:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev> <20260904-b4-arm64-callops-kcfi-v1-6-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-6-ce6687739b0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Sep 2026 14:18:19 +0200
X-Gm-Features: AcwNN1W-BJa7t0_HMwRoOS4jQPgmmEa3lTrRn_StsdokzqumkRB4EleU3vHebmI
Message-ID: <CANiq72kg3Z5rB28H4Ck+EzqQgiRSSowBMe3YW6p_iNwOG_dzWA@mail.gmail.com>
Subject: Re: [PATCH RFC 6/8] arm64: ftrace: Support CALL_OPS on kernels built
 with kCFI
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>, "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 3:20=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> Gate CALL_OPS under CFI on ARM64_CFI_PERMITS_CALL_OPS, which needs
> clang 21 or newer and RUST off. rustc has its own flag for the prefix
> NOPs and this patch does not pass it, so Rust functions would have no
> prefix and a different hash offset.

Why doesn't the patch pass the flag to `rustc`?

(Looking at later patches) Ah, is it because you defer it to the last patch=
?

Thanks!

Cheers,
Miguel
