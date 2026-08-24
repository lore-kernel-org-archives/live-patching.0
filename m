Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154B3AE1BB
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591874; cv=none; b=NwGyDj+Q0XsaJ6bVMPYf+1vV9TK6a6CzjrpGytnjSm6x1GadMi/GfZ7gtc00Te/ipKOKhbbENUTcO3M8Piu2JOXFGFBlJEG1vNF8TLAF5FloVSXt08V6A9GZFW02ICZwzy4tjQ8WFfLwtZJyu52neKesmBFHQXe9vdcNCzph8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591874; c=relaxed/simple;
	bh=J0mkFcBK6FK76SBWnSLgSRW5G6jbg3DH9jZmd1APEmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmBYsqzm7/Ox8SU5/rnqU9D8NyrqjX+yuCs9G8UwVC45JX38mSI0avbSnwyU3J4qD9dBqqA2P0/+I0E5w9JFzXSO+nUp/HD/IjE4Qe/g7/J3Q1tbBYjgjYLxYRFlQ+A1GyqZgon4xTGjZYKSp3sgHeDNmeZoIy0gi1bCG2fS4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1zzJY9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1zzJY9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E491F00A3D
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591864;
	bh=J0mkFcBK6FK76SBWnSLgSRW5G6jbg3DH9jZmd1APEmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k1zzJY9RQ0afFK+ZbOvlHBLLtUgbbJHNotBcLE/hYtOiIFV4OTAe7vJD4sa2hJlrf
	 ULcScKwzPi0/XvATktNs/6OfvFsbW0Iz2vO8OMnD7JNBhxIl7ikVL+Ichl+J95UAZt
	 WOHCySiAahnDVoM6rdxvChCADVFfDGZJDqG2ypY2y/U+MCihbQZzoHeXkcTfhl59fW
	 yhub2yUQWOuD7FEg2ynEv82uCGlv6URm5MKoWUgIZ10Wk1or86q3whA9Xr400o2Cz9
	 k+k7ztzrl+aouypZuZyk3t98PPizK8WiCyf1WV2y3BSIRJrsS06241XU6VFh5QE2lY
	 UAEif2ASakTaw==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca80d708489so112390a12.1
        for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 10:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoUtCwaJOBYR4WWr0iZpYdkZ5m7CNRpVHM87Jyjp7+U6nSrrVh7aMuPvr1oq0lqfkXN+Q8l3yhpKPMU7MYj@vger.kernel.org
X-Gm-Message-State: AFuF++lp7axv3v0jcOAosz6Xe5Wfxxh7e/Wjfndid6A1Gz0QsIwJYzFB
	qlHU3hpQg+WAvfM3g6aD1U4y3TuMkAMd0Hh9F2HVpiSb/Co+VI3HcdOC65RzYJ6nUZVjyKG7RfI
	XJFRo6kSyK7Mx7QJw5x+Km1cHgtnT9bc=
X-Received: by 2002:a17:90b:1344:b0:396:44ef:ab64 with SMTP id
 98e67ed59e1d1-39645b70506mr842923a91.21.1787591863932; Mon, 24 Aug 2026
 10:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com> <20260824032732.56686-3-laoar.shao@gmail.com>
In-Reply-To: <20260824032732.56686-3-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 24 Aug 2026 10:17:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7xUUxejnnh9HQFcxLuM2UBbpHUvbpK+L5+WdrGOyq50Q@mail.gmail.com>
X-Gm-Features: AcwNN1XCh3UbbIvkAoQGR_iTYLOSg1nt6loOiw9PgbWQFIJC4i--89iMk9xtMEE
Message-ID: <CAPhsuW7xUUxejnnh9HQFcxLuM2UBbpHUvbpK+L5+WdrGOyq50Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] livepatch: Call klp_init_patch_early() earlier
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Invoke klp_init_patch_early() during early initialization to avoid
> mixing for_each_() and for_each_*_static() variants later in the code.
>
> No functional change. This prepares the code for an upcoming patch.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Song Liu <song@kernel.org>
