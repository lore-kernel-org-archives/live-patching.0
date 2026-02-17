Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D83EBF12
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353032; cv=none; b=TpDNNaGTgXp86qxVE/4mg5Sn47zA3fSlJ00aU9c70ihNtvIxAKoyvwJLPXKe+eATNkKt7uq0l2Ggm/I7iTBGEU2+CY1lQjBkzH+wl9NEUMC0FlJfJTHcfET5ieb6dWtfHpX+eyNMRXA5scRZfjH/EiiahDv37IGPQBpd24jS9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353032; c=relaxed/simple;
	bh=OZ9ELtz0Ixg3WtBldPyAhCL/PhNxctyCS6K0iwdHf1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uckXTxqKDLE5WY+AWe6HxxHnm2v9ZfQOuGGqoO4zSUzcYliCCI6V9UmGv9A1PkPyr+5gTHyLQbV+i8QtgnUkqPEOWt3ex+urraXP5sNZgb6ukaOTpzYa1AIwLJINYsmAMuUMLxT9B7FxBN2bvOtQ257Wxm6fzhmPGNAQR4YKA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j51yRNBi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j51yRNBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EA3C4AF09
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771353032;
	bh=OZ9ELtz0Ixg3WtBldPyAhCL/PhNxctyCS6K0iwdHf1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j51yRNBiolsAL3DtWWO+AjOLlLs7obpjkearFjcwUjrnM0uFP6iWkw3RHV8HN48gr
	 30KU3EFzeAFqwlB7X6/p94IZC/oX4IXiXpJP9121V1e//6XEhwmo3DbPL4Rfkk/3a9
	 Rq2vNTgBKbcBDp6RmMbAFQIgbgvt0ZkTqj6yPr23mBkZMbGFWNzJDAEuMXViu3epiC
	 tw+eNfNSqWAgMgcyPPfWoPmZC+dY0wJiepZ79hAAdyUfOWY6U0yF/UW458z78ahTkT
	 w+aeWAPyvenOWe0etmxGCG0KAkR2W1+rVK2PPmMuVEY7gurdjTI+HGxlDkyZi9HlAg
	 NUEfYVjN0gYug==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506362ac5f7so42589231cf.1
        for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 10:30:31 -0800 (PST)
X-Gm-Message-State: AOJu0YyVi6e8VtEF0CclmZ3zfE9dTcHf13NRrpiMKlQfg/h2R4lVDFhM
	EPMpx4d37g4EOltOD6YqLbsYnxaJaFfyKcScbkcnSAoxMQVEJTUjXYcVa63xHUm3MZ7PyIU8zOc
	Wgrnzu7TVOUlUlwGtsMnlKShiSOmmDZ0=
X-Received: by 2002:ac8:58d2:0:b0:4ee:2154:8032 with SMTP id
 d75a77b69052e-506b3f7e0a1mr158467621cf.6.1771353031077; Tue, 17 Feb 2026
 10:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217160645.3434685-1-joe.lawrence@redhat.com> <20260217160645.3434685-8-joe.lawrence@redhat.com>
In-Reply-To: <20260217160645.3434685-8-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Tue, 17 Feb 2026 10:30:19 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4fvPbUuAjwCfSTvotNwvu4L2jGyk-iKpUYB0ojDnEvHw@mail.gmail.com>
X-Gm-Features: AaiRm50xmpZb3ZfyDQFptm3mfdzGLYisE7oiApSeRLGErHB0UMK_h0trZPzAddo
Message-ID: <CAPhsuW4fvPbUuAjwCfSTvotNwvu4L2jGyk-iKpUYB0ojDnEvHw@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] livepatch/klp-build: fix shellcheck complaints
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 8:07=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> Fix or suppress the following shellcheck warnings:
>
>   In klp-build line 57:
>         command grep "$@" || true
>                                ^--^ SC2317 (info): Command appears to be =
unreachable. Check usage (or ignore if invoked indirectly).
>
> Fix the following warning:
>
>   In klp-build line 565:
>                 local file_dir=3D"$(dirname "$file")"
>                         ^------^ SC2034 (warning): file_dir appears unuse=
d. Verify use (or export if used externally).
>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Song Liu <song@kernel.org>
