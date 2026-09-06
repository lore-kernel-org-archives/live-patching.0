Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929035A93C
	for <live-patching@vger.kernel.org>; Sun,  6 Sep 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713823; cv=pass; b=LAZxcp4YIRTpiJ6hNgAdVPO+flcU6A0IvOLTj9R4BgAOKFlpC9M6WxRr/93WVeUAI0tMrzpEh5v5eTRsilg9SF+4aCzyMJDyYNmHCbnwlwVMUUB7u3HEH/6JSrwf/3Gv6BObu0yaVh9q1gmU/bPTqHmChu1DHgaimdljg/znXbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713823; c=relaxed/simple;
	bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpc0LCwIZDKd3XbsZESIYyhtYWCyiJTkw/d7h2RUr/9Bm0M/NUIBKu8AbnVmVIjHuNSkwE6KjSJV0HY/Vx29GMo141/qs5ce+Q2ZurVVNS5TRSCZJNja7WW4BSTJVFtD/HOWjNd84sNNbkYeTC4Yk7QTz3/BLCfPB3FybvwSSOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjHPtZQt; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjHPtZQt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666e7c9edso172209a91.2
        for <live-patching@vger.kernel.org>; Sun, 06 Sep 2026 09:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788713821; cv=none;
        d=google.com; s=arc-20260327;
        b=qXfBgzNqHsFbmq/5Dpyx8JobHHZz8WdMYcgf6kmVm54H+tccgiyBSg+3fjV+Ecrkit
         PG0cXoWdKH5OhTCFSWWenCxmSP2gjXO2rLnTuBLTGIrRYSY6tJLD5JhosXiKi/r02B5H
         tZTWOiYM9+T+vUaKq/TcXHbNZ84xQiHkRp7U5DXjbQcIOYpoolE5PGUgOKkma4GAMhj2
         piZVHQTpscuy7AOoqSradFxj/xBjo61LVBrO7FpTPZppYGtILMWw+Q2yRbFeD66vz9AA
         gH53XIZherw7ngUhYTrT0lL4m7bzIM5nqCqwHDlb/w+u1xDyeDRqMlwh9btdSGtPuFFq
         aQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        fh=L6/Lctk/jR6Zgk0R/sB00ZGrrNAd87V6p7suJk0mHWk=;
        b=eRk5av9b22eYYGrYwSqTiXG8EsBIfVFOZWRK0fbknEKq/iXGVgrm/RF6940imYrzyu
         Oji/+VgpBiCRgr1H7D/v19KsRwaSHr/ij8kAq903B1+og4KPJr6FaCr6mN7JVNbNaQ/k
         vHsE/rij4bWbZ44kC5nlgBmKfur/m9XeGlSJEkMiQlupT6elGPmZ2Oi4P5zVk7b9WEUe
         QqiXc0FdU8N7Kk46eJSrOzbEyFiKVme8xOM3wbXl1d7j6TeBRxJuzQEhU92tF/0c+fBp
         H2f29DN2QSkAfKltWcBkIox/+961s2rh5W2TW0qjESObpwLM8EahyZOYVr1Cib1Nonga
         Q2ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788713821; x=1789318621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        b=UjHPtZQtZlfn+jMBdsesbKV9hhN0VxB45TUW8NF6jsIj/u6sMjuVZl/S6vNiEMAdHB
         Te+UXjaLTopyZrVKblQ6F2RdO17BiDzp8YSjJWd1LjGv8/lpVMX/mJq6tjMcQBGE+lh3
         gkbl212FSvMq4hzn08kjNsXAWfz8CFVxj8DwBvGDcA2V9pboEq4SigdRgrpS5P3lbPAR
         WaeQlpczdSbYO4EXZkRcm/d2DFhfIccQOCyUcacVGnAtc0aqHvm4nD/lvAQStGw+ys2S
         nEMr3QPCYz3NCaB4lrh+lVRBv1NLXl63CMfDijyK5BqBSV6Pp1fy8GFAFtzsiR1Bm/Qi
         cjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788713821; x=1789318621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        b=MJQiS+vasBZHRp2xZ4BqLehzsxGUwUYSlYRdyT9pAEoGfz3J6zX4CcGRvpilvWPkop
         6+WrWHh2RQISnC1Mh4cwQI97ZMLwVWlFdVppAAFtWkBFJkbUbMQJFgbtv1IhITTMmz/0
         vyoKJdE6sfdGQGnCUj7PlbYmVMWeQCg+o+0KdObMsIV+7AyZROVuxJdIuBnlVUfOIE+h
         jLOC7//UtUnkxNLWuFs1Pn1ascuO/m3GVJnSesVVvqhVIVX0BgTvbhz7Asw4yQm2AGEA
         U/ggC9WS/xTk4nWVhFkRe4jnhPN7wlc3HO/1yByKgzJGWXwvJf0UkojFpMndNFYlMqHz
         mtOA==
X-Forwarded-Encrypted: i=1; AKwUvBxNo4izJTZ9/+x7xo7kWTLLV8LkBEkrEq3i/jS7t9TLT8an2ZYC1AanBInz+my6OdNCIRzj1CO3ufn38oyR@vger.kernel.org
X-Gm-Message-State: AFuF++kct6m1DLhVl+yp1Eh6ZaKa4NptQCvS17RZ9G6sE2JOlXGgmsn0
	HmUSeIR/cQ4XkR7eu9zXSl5E3z+uV52OyrkMKjyT+0l1EZipe1GFKDhajGjDu8CL8BoiHnTHADy
	5ccZf3D3nl16AKDwoxupKub6Ui5E0zYo=
X-Gm-Gg: AYBFou1IYGCHmB7t7kiMNU9/jcvHFAL82HsOfykCQ078zrftLmqc4IODIg6J51VNium
	7ju0nw/JhJ7DxVuWmg0wJa5qPNoSuriDF3NGKF8vO17BvEfOD9U4+pRAO2rIR6f/b/2UDXP5Xtw
	9ZV9uD8XZt1An3aYwX9xQYtDJegBMTLWODo6K8n9GRhSuxFfBK1hSld77+iSHpMdHbv2y2OLKmI
	fYE42kUFQ0GK138QtazACJE45b676uzroHPwpMuyKqdxV1LxgsA06FJpmOVx3LcJhG5zqcV0opK
	16aZ9ZiujJiF5XIWNgMyU1zVo/8JDF+d+6/De0pKVXbI/rCrh6sz2xY7ReBdlz3N9URMOelDSGx
	LOoD7Lz9+X+dHmV+YY9aBxb6ehOiEvqjW2fYvyYgHkYxtZwVsL8gDsAPyiKQEszVSj5L3xoSE
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr12050791a91.6.1788713821151; Sun, 06 Sep 2026
 09:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev> <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 18:56:47 +0200
X-Gm-Features: AcwNN1Vz7OHfpHx7W0dFC3jg8glvxcm1hmRiClFLpwy0F6DpBbL1JHHuwRxDDvo
Message-ID: <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] arm64: ftrace: Allow CALL_OPS on kCFI kernels
 built with Rust
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
> +# bindgen generates no code, and its libclang may predate the section
> +# argument of -fpatchable-function-entry that a kCFI kernel with CALL_OP=
S
> +# passes on arm64.
> +bindgen_c_flags =3D $(filter-out -fpatchable-function-entry=3D%,$(c_flag=
s))

In general, one should be using the same version (we warn otherwise
early in the build), but yeah, it is just a warning for now and it is
nice to try to remain a bit flexible.

Now, if we are going to filter this out for Clang, should we just
filter it out for GCC too? i.e. outside the `ifdef`?

By the way, "generates no code" sounds a bit strange, since `bindgen`
generates source code...

Thanks!

Cheers,
Miguel
