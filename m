Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BF347C7
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065879; cv=none; b=pMJKax0yYKqLrPDtoSJfInomlwowAJVDd8fp7vX6TmQFJyYkOI4gDgbcPI8itx3x+Z73qxk/tN/vp18jJ1hV4cxbBCp31Lq/rk77hoErUxNFZEwO2acAHPKhtoMTg+3nVYQ35J19u/M9B1ZJus6Gnq/pDE6ioqetnFiYLdXApJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065879; c=relaxed/simple;
	bh=sDYcfdYmD3QRj4GmluKuDG1bwY3pheQAsFX3ucCp+Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR3pbsFOuXtMz7KyoXqkNCwI1iyrGOvdc32799S2OefhwW5lDUwHZwRckO0G8EKXivuSbxERpsCJY3R8khdKgeaSHeh/MqQsyrk+na119G3Ik9EwJLxegW0CFTAJC79kVKxGl3jS77qUUaCPOWTyAfsJIt9RlWxpsSDpLX1e3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpWPiic7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpWPiic7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3012C2BCB7
	for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 21:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777065878;
	bh=sDYcfdYmD3QRj4GmluKuDG1bwY3pheQAsFX3ucCp+Bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZpWPiic7A5H9NQZTpopCx2mVilMUMTFnlj6i1oAs2avRDJjv8rK0cIGHDGCguZX76
	 nRVktnOzPNzzOlKJPTWuIExhpvYSugdOTGIWSH09DLkiO/qk6BbL/QzJAF+NBnNBBt
	 trdtqiS5w2Zxw3V2Mfy1W1BPeJ5e+mpGBw4iS5RN/ywTvo1dz0xWT8w8SVKn4Ky4J8
	 mLDo5jR8jC54TQMViKkGLoYUjyHp6OPShats/HRc/vsUla3N6PbFPwTTKTD776YK5D
	 E4NLTi2309/4jo2maomfM5VadpXi7BrMLSdfG/lnPGIVRpsDfm+W2kJX5Vf0r4an9z
	 m8vePX7Mwp7SQ==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a154cc6a48so91468416d6.0
        for <live-patching@vger.kernel.org>; Fri, 24 Apr 2026 14:24:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Z/6Px2ZlvObl/laVWKkyILsrQTYZFWJokKD+NEOICvfYQm4hAwV3x/Comyv3v+LQ8uqylv6RwlTK0rmaI@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZ6l3Ebkor1sRiHJyREIkAvW6/YzhBpoAgkoTCWVd2zR6fEGa
	K8onM2f2ls6ilrpcYWuCA2ewr8v7o8Fgr7fkJi3gjXqCEsVntXM8EGkc4HkCvYXypiz+ioufURp
	X2v6lF1I5YvfHK0Et/+510jOyhZ3gyqU=
X-Received: by 2002:ad4:4eab:0:b0:8ac:d13c:3ab4 with SMTP id
 6a1803df08f44-8b0280ffb13mr542963536d6.37.1777065877881; Fri, 24 Apr 2026
 14:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776916871.git.jpoimboe@kernel.org> <2a02cb0d5de7a60f5ef135dac071c93f6303bd82.1776916871.git.jpoimboe@kernel.org>
In-Reply-To: <2a02cb0d5de7a60f5ef135dac071c93f6303bd82.1776916871.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 14:24:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Ot+3QKPW1NCE6agYqSqc7KP8efCNco=bF-gmqSGF_YA@mail.gmail.com>
X-Gm-Features: AQROBzCFAHRxb8bL5PXU-kpU12LKkD7Mc730plIE0Dee41xnRstJ4L_-WXXqyuU
Message-ID: <CAPhsuW7Ot+3QKPW1NCE6agYqSqc7KP8efCNco=bF-gmqSGF_YA@mail.gmail.com>
Subject: Re: [PATCH 12/48] objtool/klp: Fix cloning of zero-length section symbols
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 9:04=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Fix NULL dereference when cloning a symbol from an empty section.
> sec->data is only populated for sections with non-zero size.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
