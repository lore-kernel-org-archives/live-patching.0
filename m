Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A22E736E
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936542; cv=none; b=VZFgbK2O+xQvnfzr0RRdUJHBwNDjaY9uwNyJjCNmtc5VGqmWqa8XJg0c3VbHVs7w4xuAshHHO0glP2tS3RXG1bgtsIo6jB04Ms+m9+0osgKlB0xzsqX2qKt9vp7w06q1r9cs1LNdJWIp6JUv94wxe7tt36gCGnp6NkCOmjqy9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936542; c=relaxed/simple;
	bh=4P+4WBuuMaomVWGYFoCxfxbJZ0sz5pDIVNe3FrkiFfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQig/GOY1RIRkH9fqGmVIvu4reVJezawWSwo67lE6ynkSA+8Sg2JSaXRo5uwmGz/1JuxummK6UmWJ4wTAyaWeUi6ajo0YsVGDVpdGzw6mS6+8z/8Ge/ZnFSY4O12DY4kLFmGak/MaGLRT8sQXdJgKXCsSJXQaqT+JVNRffNKVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG0KOzDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG0KOzDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233001F00A3E
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936541;
	bh=4P+4WBuuMaomVWGYFoCxfxbJZ0sz5pDIVNe3FrkiFfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KG0KOzDek2Zl6xHj/D/YxxFRiODe/fstyZODPwQ/Fe34qNxlkw8dmz/YXeuln42Bm
	 WtmDxtg1dutUzieVfrdMkyteYAmHxCl0rk/ZpY5+Y2GpxOuQP8icmYT4dtwx7wkgCQ
	 siDgjzamQZoQZRYrpaTqu5wsWyn4UFMyLBFoZiFOis0ml3Wxbci0htQiEuu08Nx+Ef
	 Q611F6GoBtIKxlFjNJNIGvmjHj7Fmjw45oeXEBrpd0Ye1VZTSMJOpDn0kVqR3kOgaR
	 XyxVtKBufq3OoGCUE/zOKuVXppOpIYInwW2zS7Xg21A7khIvzFjDo+x9d3+HAXKskA
	 rmkggXScRX9uA==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-938cd95b06eso98293385a.1
        for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 10:02:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpEaJvh0RnJVgIN/wHgziO5APgYlqHzq01QJJy2QonBAZA6SDe1BFSmZkEw7a9kS9E8yMVgR31sSun200ME@vger.kernel.org
X-Gm-Message-State: AFuF++lFEmY6vBiFlyGYyWyuhQAq3R3wd5FAyEDe9jWSzXllri+4qGPW
	k48iX0sHmeNJTph9s05IRjW6GeDT47DKI/AoHQ2c1G7onLwd3HAybbPD+d97/Zhcg1srzpgKnwo
	bbtslZxCQwmDvYduw+8B1Q/eTHsZvHmk=
X-Received: by 2002:a05:620a:254b:b0:937:6f98:c68f with SMTP id
 af79cd13be357-9390012fc40mr1524566285a.1.1787936540325; Fri, 28 Aug 2026
 10:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apBbjoEHJ98DWN_W@pathway.suse.cz> <20260828125244.509977-1-pmladek@suse.com>
 <20260828125244.509977-2-pmladek@suse.com>
In-Reply-To: <20260828125244.509977-2-pmladek@suse.com>
From: Song Liu <song@kernel.org>
Date: Fri, 28 Aug 2026 10:02:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW72hqxThCfDWY=gXffwcGvGL62pwhwMgE-39AGEv7DvCw@mail.gmail.com>
X-Gm-Features: AcwNN1VhySuqFnzIDQ9ghe0KLQ-LFN-aMnh78yxjejMcMGXI-F1Wj_CA5ySBQSg
Message-ID: <CAPhsuW72hqxThCfDWY=gXffwcGvGL62pwhwMgE-39AGEv7DvCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] livepatch: Move code for updating livepatch object relocations
To: Petr Mladek <pmladek@suse.com>
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:53=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> klp_free_object_loaded() is supposed to clear changes made by
> klp_init_object_loaded(). It should call klp_clear_object_relocs()
> which is currently defined later.
>
> Move the code for updating object relocations up.
>
> This is just a preparation step. No functional changes.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Do we really need to move them? I think adding a function
declaration is cleaner for git log/blame, etc.

Thanks,
Song
