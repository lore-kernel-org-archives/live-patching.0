Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A62E285C
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487590; cv=none; b=P2HHdCY3hgHPKoApJqMkFpSraPUEL/3WTR+WN6BQBIqZNxSXM/EPRHkHQ67OfWZ+Cb3seZF9/Icn1QqDm0n8iMr921Mw3woRLYIAhuFTa516CwZ4luEYoS/HPDW+lkg2rAYLXeSVr14p0VmeoDoa+TRAbbdp57l9dW+me9UTQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487590; c=relaxed/simple;
	bh=slYhFqbe4l11j2LFr5VFZ4bOWPZ46u5rrt1PrrnggPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJgbPRZxDFsh8klGiX0tnPyQrw7Ge57f2sZJIFsfaNcrLxQrfq80FhYq8KjtJ522yR4cIN4U25aoYJoh6o6Tfr4epC7YnjCVtFHlihvbI+V1Ovs+X2L9A/iK4/wnx+bij9NJGNS+Hmcb2IfI++TrEQLt3p8HL9Q9wApMVJlaVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7yzRMIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7yzRMIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F861F00ACA
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 22:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786487587;
	bh=pC3duc8QBvW8C6Bkw/w4K3pIRjigH3gzWsU6Bw1Za4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a7yzRMIl8ebbz0/OnYv9kL7vUSMXbQu8I1ePEV9ToiGjuR/NOkEG3FNCMuh9+7BX4
	 bq1LSmRwn0HjIMg7gevu5Q2K4whsOEQgfly1o4WuUVLStmCg+XzSIcvhKytmqCNqJN
	 fzc43Ha7fPGx+D2Qdlkxjv/rPpr6S2eVQHnjavLHpO4ZWjeax/mcasaUP7uJfrUhrF
	 ACbInD6l4zucKXpZG6uoF/O7rrCC3SQyCUEWS65hVJ/26e6b4r3AiMsnIomuUZQnYt
	 Y4TFUHoeMdPN8Lmp/qr/DT7Cw8AOi8/+wjtJqTO5bK/OK2PAcLLlLgSvWvGmsxSMoe
	 CBa6Jf3c56FBA==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50979c71so44343285a.3
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 15:33:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RohDriqK0IuIYntoeZ4S0geAUDRXK8kh73EZcxFp+1/h0Ij4VfKjRCbGMyCYHfskfgVH5YnKh3ZKbuPHJuB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hRvSk1pEO9u5dptZPeopuq+rAeNCmIWlRP36sT90XU3RrPPx
	UhWHsyfhn00AmQAy3HKSaoND8TWB0KuU3eQLd/uKyqtmXsAEuZ15vHG6jBQxY7nHIVX4wKv+t2G
	83w+LrkpXrkJorkTJpHtyNRgX6qcOIhY=
X-Received: by 2002:a05:620a:3712:b0:92e:db54:a2aa with SMTP id
 af79cd13be357-936b3a86ademr86775185a.3.1786487586969; Tue, 11 Aug 2026
 15:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786138493.git.jpoimboe@kernel.org> <516e14f84cfbffa27dc19d3dcf35097504097966.1786138493.git.jpoimboe@kernel.org>
In-Reply-To: <516e14f84cfbffa27dc19d3dcf35097504097966.1786138493.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 15:32:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Nai-mmXWoh5c-vAU-ELYXOM5FPtM7q3V37ktS97myoQ@mail.gmail.com>
X-Gm-Features: AUfX_mzNK6bgu1PjQ-NNHyiJeIFdqnBH8zG7u7oRcMhRXhoDvT5RBP6PV71GQuM
Message-ID: <CAPhsuW5Nai-mmXWoh5c-vAU-ELYXOM5FPtM7q3V37ktS97myoQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] objtool/klp: Explicitly disallow patching or
 referencing init code/data
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:38=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Explicitly disallow the patching and referencing of init code/data.
> Otherwise it could potentially introduce some odd edge cases depending
> on whether the target object's init section has been freed yet (note
> that the init code still exists in the target module when doing late
> module patching).
>
> Such edge cases include sympos calculation and the patching and/or
> referencing of non-existent (init-freed) code/data.  Not to mention the
> inherent differences in behavior that occur when the init code is only
> patched *some* of the time depending on module loading order or kernel
> config.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
