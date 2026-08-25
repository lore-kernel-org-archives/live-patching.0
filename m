Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF840242B
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659929; cv=pass; b=YdhfK/nQparUI5WEQ0HNrVAafxJsLCQr/x9aY9CQ3qD5e3KLWOHfQp+XGJT4j80AXhuw3McWz3cT+kDzpS3tFFUTLjAKw+FawlJhB/84nI+QjuRQMHhLsNtkATdIKc4hdDdALxyze/GlI3tU/DZU/pbIxaLZzkPhEDUTjhmdw/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659929; c=relaxed/simple;
	bh=HlEC2+CSDfjaRUFWnIqFET2gLvLHwOVvQtLYhsPMdyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUINyMG2X/azigCFYBCBjkKurVomoHdbZEQBL7kx6NhTa5u2aPc5ugQv4QDZmBBw8mWIU2lsUr2L6d3gVt3oM8jjqjTpFI7mckG3CaQnQCJ/QgAj0rfZoNsLJJXKPFGPAlMrb4tTN69v20F+iYjgSASRmuWfdbJeVHRFkhmaHV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIoYma9a; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIoYma9a"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ed2a06b9eso45287187b3.3
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 05:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787659927; cv=none;
        d=google.com; s=arc-20260327;
        b=hagba3BE9XlcnaXpoBzt3xKqXUhdNgS1puqbnmqE+Txs23QCmE9FlXi3mXP89ikfYk
         2yt6vbmM2t8x3r7SeGdU7Jaor+fJlALtjVwsZjiZFflA94F9ZAkmjWq++eCSLnQs1T2c
         SWteb47xa7ike0heZ2TeJxS1SEnDpLyCvL2aSz5d8D4kT4f/3xeESZWPyQ9xMS4zYe24
         wWNjP9+i1g8VjxKuSFOVMTCUQksp2FdCmSB2TUKkamMDccYSNdYNUnE4PiX4W3CD9VB0
         iEaatTUjZmDQV5FVPmeNWpc+WlI7LJ7dqjsNKotEPOBbB0eWq+woiLxAwFS6RV0xYtwW
         aMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HlEC2+CSDfjaRUFWnIqFET2gLvLHwOVvQtLYhsPMdyE=;
        fh=tVyOXhzSJGe6Mgy9KOfS81zishC6D8ZfML7sO1dtJKY=;
        b=WYtMxPwydxy5pjQ3v/iEtUZWsX1sXAgJTJlLA9WkbaF5EnHNkPuw1jmy1P7i2q7sSj
         SaDlqE/WaMoTpQLI3dh78SZNazPaeCAZFkvZaI4iaZXoZGdhOK0l1ay6U40ApZpfPWCn
         Rdu1d1A6i4Qq/dATQPd64IY/lCOSsJOG2rRivSL2I08SrUIMxTXjGoZldZgBzZSKqbsx
         jV5zs4J5HTfrCL+VlR1EtOVM7ybGHodGlfAA3z06D0a/gNS1q43D0ekZ1R8sPjCbHvE8
         iWruudaIW6OEFky80Da0lAQklVi//PUol+51EIkPYlFzsarTk58+J8aZ1+vVK9fvpzGv
         YBcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787659927; x=1788264727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HlEC2+CSDfjaRUFWnIqFET2gLvLHwOVvQtLYhsPMdyE=;
        b=UIoYma9ajEKsZVmbVASHMjozRlEOJ3DA2qV5gIzfjuJsZRB+RoS/I92KlYzgSEzRRR
         Mb35C49X3NOv9o0i4WtejS51UkMK8eiEu+lBlQSuB+Fw6kUByXRSJcy2yPiZUB1PxVE0
         zfngc4sS6r7j+u5cKlbjBMuuubtH0iwd49Y2oAzBnRMqs63GeUBvq0Cwj6suCs7MQfC/
         ngLHDzgUq433unNYFpN5sv0aD7b5303JvGjEbfkjgWvX6huO1xDH6CqlB7OYn5dW3zRi
         EbNyEErMw2Uk6KHVn45h03JLwBZ0pH2OTikcAIS3K6wFJaAqUnTkbaerwrCBYGw/ZRt+
         K+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787659927; x=1788264727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlEC2+CSDfjaRUFWnIqFET2gLvLHwOVvQtLYhsPMdyE=;
        b=gY+OiLiOuA3vKAKQcAYSBAll0ilPAZ3ikJaTCYKnl/+ylGG/ejYKuokhDRsXKsF8ba
         T7WKDmjKmfPL1An7XjOzc5JbePpPKkA+aTUqD24Az5UUaKl5AQFyrWgxgGix3yXj3qze
         Gg+NIMf/N0b/LEJApvyN/K/HhfagXfTR6p+11RcmRMTqT4sTe4HHDMA96aRZXDrQRDUt
         WGa9DAsb36AbuhEIESZTWtfgcL2LNzgnyGu8clQi87qXP5UYxsRKMPzWqS0OJI93OCB7
         uaiytbQAtMzZ6FNL5hEEMQdEYRKuvaRI86tUv/C9zbBfPMnu5Vfhkrny6vbi1e76G0yq
         8gvg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+j0imn7Qr2VXzjLi2MxBUUSOTqgeUQsFkpzGOuRtBmERHi8GOl944VQ0aDWMyNXRbr4ldczw0H3E3qTEv@vger.kernel.org
X-Gm-Message-State: AFuF++nDOfDiQMPFWfa8HRfpEDHiglfata7vfpt1y2Z0+HWbBypt/ahi
	nXUnNQH33c2qqITetqaSRmosXsRaCaUb6QOExZxH20CX2YypLKHlCUrAXR14LfoRVJp8hjFRebL
	p7gbNVvGGx5NrO+utC0HOBYtQEpZbQqM=
X-Gm-Gg: AR+sD105QbHn+xD8l4Gg/LznQCIzuUz+qp/KQq3gUkKNiS+nLU7lj30GU4hbOQTtFyd
	ejAHSy2mbw/o35ixX8D5YaEFkQJ3mcjcVrzzFHI/6wftJbSbA2YfaKu2txMvLLkA17l3I1NAUEt
	vRIi+t0akIbpSKGY1+no4dMJwJN513eZ4PMD+USTao5kRGtuGg+eHOw6gzJtPJbTJBxPqB8B52e
	5JEkiFiKZCPF2dpcqxEORXlC2LccTgB/sgxZxptwFLbdpeTC3s/8yCtCERGLdMv4ni4BIiOa0Zk
	hY72xFq3G+qEP3zNvpzMN3N72SDER60lWrltHMkE0jyndRbIdVUuM5Bd93At9gY+IA/6cnjXadG
	yfA==
X-Received: by 2002:a05:690c:386:b0:81e:8e36:e98c with SMTP id
 00721157ae682-8546c2dbe02mr24868467b3.0.1787659927127; Tue, 25 Aug 2026
 05:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-3-laoar.shao@gmail.com>
 <20260825120608.BAB401F00A3A@smtp.kernel.org>
In-Reply-To: <20260825120608.BAB401F00A3A@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 25 Aug 2026 20:11:30 +0800
X-Gm-Features: AcwNN1VfpEpkFOLcFbdKAaz-F0Fcq7g8jZW7XDimNxbUGqWds47h2Da3KTPOYnk
Message-ID: <CALOAHbDO-Qw+9j2vX9hSgWxxCHXGGt8qF6h1NDqQvE5a9wg31A@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 2/8] livepatch: Call klp_init_patch_early() earlier
To: sashiko-reviews@lists.linux.dev
Cc: pmladek@suse.com, jpoimboe@kernel.org, song@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 8:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Potential use-after-free of kobject delayed work structs during =
error cleanup if CONFIG_DEBUG_KOBJECT_RELEASE is enabled.

Seems you didn't read the "Notes for sashiko-bot" carefully ;)


--
Regards
Yafang
