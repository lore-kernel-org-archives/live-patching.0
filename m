Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6B3ABD8F
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889445; cv=pass; b=nFaj8UY32pj/MWGyYLSnkxXOPRtfu5ZF2Iv1K22UQ9llwveKh99kKEGZD4h5TfRnXs971TnNVPfCNlpeQXyHV5a65e9wJywXoVu6kvnM+teGTm+MyZ5eFyKmICVR0q/2QR+fbX/MAuY5mh+GyyH9HKHiilI7JgxWTsHjIx5ysc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889445; c=relaxed/simple;
	bh=8uWLmljlNfYvQm6qTnH2avwR1I2zHzrOgmwHcFlkuqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3Mq3wfLhDQ8xRuTAxvyyi3VuS+U6ewomzTOlSC9lLWOerqdz2cXaXqYSC8PmYjlSYA4tt2RBCwIslJleUc0QPGORBUCJFuAzeoEiALMvmN0KmOSn5LabsK+nXjODIkld5LqN7LbgqU1XJBtimIW8dCrPeAzlaaT82RbwHInjzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7G2bpZ1; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7G2bpZ1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ecf499af9so5564727b3.1
        for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 20:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787889443; cv=none;
        d=google.com; s=arc-20260327;
        b=ao4YbZ9uwQ4/262DW6ldHnJRLSnqWdOZcsKzCLFHB/CMWzoiw1GitpWLI85HSP2ere
         PcgwkzZ8gO4ypRSVk4bzyzqNBjszyGMYmOwrb9c+q2Sha4EmZSaefSKcdCKRjIVgUzx3
         rP8LQ+gZDV2/6RIuqnlcikgeGy+9Xs9Bk0ELxdhyetPl1FkSP0XKT0B+O8Yo7iCWP9x4
         h4yG3UOirf7dlrqgHljfEgb9BGY49bDqS6loi27QflbOFqH3NfhxRHLCwplpQyTDwxwT
         L2lPiUCgVnNSpDFAtOzyCS6QZnbmsrj9S5G+nEms8TCwCSX6rdAAwsMiCqGL4LUHtQOe
         Ltfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fDm9k4RVmOxYe6WzgQyeu2FFt5xJXTx4k8V9FIhjDA=;
        fh=qk6JM5OYB4zvQpqo31mIXpVp5cHmxWo31Js5aKWg1AE=;
        b=qYt/FuAVtCLJU31JF6hBy8IESbfjBB38GdZyvpGkyQ6oERL7HW142A/nsnuVttSUiF
         fBoaPSiRpRNtSYkwMgYsy9fbaqxm/OstQG+z3RkXLL01ClptyL0gc1ZwJnQFGo76p3jz
         SmvjjlsmEqvpxSAKy0mrzqC4Q0DA0qAi4Ng9wU5zatzihYpKt9g84Q04uitvkNQz0IjZ
         gREwzMHV9pSnu22gs/50BKZGAz7n1GmfrjwmdtYLJRSQBzb9qJgNoTkF39ZSF5kuTyB8
         xtsiWZ+DxYp2Vg18mT8ki3CPV8PPS16JwoV0vrwY3pga4b8O5Kf0WB3+/E2LVc8UJBG2
         ZeDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787889443; x=1788494243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fDm9k4RVmOxYe6WzgQyeu2FFt5xJXTx4k8V9FIhjDA=;
        b=i7G2bpZ1vZxr/5Rg5ECrJKEwIhjfRnQfNhEpj+iLr8altfN2YMQ/vdc10PkB7XZ8bv
         +4EcJHEvoVLu/dMdYGXvOvxMKttfZj9IrrVqCtWY2oPGqMwjupEPvElA5pwY+xBDOziA
         14Cn92eEo2N0fo23+6UWg4cRLigaJZ7YxLT33efRI+BNP8lKHLrCy+7GzmTw/jV7gNRk
         fgSh/7FrnIzdpMfNzxIaND1+X0M4pIb/3KJVzJKN1xLJUhVGNb0/3k4cetW3boaCzZT0
         p5L7MKrA8CsWlVhIVdRtICmDxBl2XyuSEhWexspFfQG1tMNEaM2BpQgWA1iuTPR32XhG
         Wo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787889443; x=1788494243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fDm9k4RVmOxYe6WzgQyeu2FFt5xJXTx4k8V9FIhjDA=;
        b=P8frqziYEv9IYb+kBSm0dG6zf/23UdIBgVpjr5WDfu317tQTLb85m46UBbehdp7DDd
         GtwWjgc8+aMDioNFL1kWW9BqytkEP7eoszKmExdjdW/bREuJMxPG9VvlxXdM2ybCpSLt
         bpzqXeda7XPIBBiv1d+W9kcPbphJuHAMGe9wvd+IQC392FSxL8hzdkUJiwa2ReIJ9wy1
         /v+sk7kU6ywLQZLN7tAwNLxjdKv3MSCmo5KqgxK/kApwa8Zv92VuQiniPppHNvuxwtEy
         Pu6oD3O7uE0Ru9mj4QgGGeLKii8huY3qVSYptaj8ddZj+jZTKZhPRI/iLX7T2uZb7pn9
         Ywow==
X-Forwarded-Encrypted: i=1; AHgh+RrFnvVX0H2XYZ6HLbtpcPPDsFFO749knIoFQ+tY+YWbHpeJnLTnSaqmCdLOZq+WX6v+TNPIjLEEa3dIyYnM@vger.kernel.org
X-Gm-Message-State: AFuF++nhgBqcoFkntWO2/CLQgJjJHE24vKrP0kIyJqUApIovJfdjHWrX
	k5wKMa4m40G13RdHvknNUKF/bqF271eY/KjYIwPQqPU1JpXZeDC9DxLYcwNVyF0yWhh+gsvY7tY
	HpyhpIndq8ouj2KK5PpNYFMhqkIYlhkWY9OQK
X-Gm-Gg: AR+sD12CxJq3nq6d6rt6XO0GLe4RN9nj33VerSuAM+CXd/fe8e8O1Ddd06tSPcd7tqo
	vFCq/q7z0yz5YdcNJCM8gv9rMr5nLzuNxaCZCap3bjDdSJ9BL9YxxW1sgzkyyd6dDwl/clJ36tV
	etYOyWC+WEoTN6tNy5WXSaucnLukJPZj4R1/1bDYpHg6BlFkcoNWkXd1T1mnklSB55ALUApNhHg
	S8zTnhJTAXgJjG1lrmq3pIxTJZJiAoBFHWlS4P9yLn96T7iXCX65nJc1vgGkgPoYFcSlasi4f9S
	Sh5lypxTQYSPnZXvdgUE/mtbXVDCaermKjEApy7w84NG82OBfOeuyPriv3K+VZ6eanlLXxl41lN
	W6vDX1eGQUMPr
X-Received: by 2002:a05:690c:e157:10b0:821:1288:f820 with SMTP id
 00721157ae682-85d660d9648mr15082497b3.4.1787889442861; Thu, 27 Aug 2026
 20:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-6-laoar.shao@gmail.com>
 <apDWrUoBBc5RLjK6@jpoimboe>
In-Reply-To: <apDWrUoBBc5RLjK6@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Aug 2026 11:56:46 +0800
X-Gm-Features: AcwNN1W_bq1GMg8xeNmoYSOsePTvyugygtTI4vViK1i7gFhvp2RuH5BRu7B6XHA
Message-ID: <CALOAHbCzHPOA-agju06SrBdnQQQA-Csuv2NJrQR8WV471PHL7g@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 5/8] selftests/livepatch: Adapt atomic replace
 tests to provides/obsoletes
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:31=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Aug 25, 2026 at 07:46:38PM +0800, Yafang Shao wrote:
> > The legacy "replace" field in struct klp_patch was replaced by the
> > provides/obsoletes mechanism. As a result, the atomic replace
> > selftests fail to build against kernels that only support
> > provides/obsoletes.
>
> Then wouldn't the test failure be working as designed?

Agreed that dropping the legacy field makes the old tests fail to
build - that is the expected consequence of the API change, not a bug.

The point of this patch is not to hide that failure.  The suite still
runs on older kernels that keep the "replace" field, and we do not
want a new kernel to take down the *entire* livepatch selftest set
just because one module no longer compiles.  The #ifdef keeps one test
tree working on both kernels.

However, the current patch skips the replace scenarios silently, which
is a real problem: a green run would hide the missing coverage.
I'll make the skip explicit: print a SKIP line in the log when
HAS_REPLACE_ATTR is not set, so the output shows exactly what is not
covered, such as:

if [[ "$HAS_REPLACE_ATTR" =3D=3D "1" ]]; then
    # ... atomic replace scenario ...
else
   echo "SKIP: legacy replace attribute not present; replaced by
provides/obsoletes (tests to be added later in this series)"
fi

I'll fold this into the next revision.  If you'd prefer the legacy
scenarios dropped entirely (and only provides/obsoletes based tests
kept), I can do that instead.

--=20
Regards
Yafang
