Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F003624AB
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580767; cv=none; b=lHAVR17u3ZootiglCQJVwXU9tsLiNhgBZ5rPEPRJ4iEFbA3NnMvrLppxsKnXiBf6+fcMicTHcosqsO4uavE1kd2uU7wlZVfQY90rQ16Ph51KuAMtFJESaTRczzQF8PpADkwnnCXN6DtJbwcsnoAy2ZAQGZF78mJwFSDIyWHA8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580767; c=relaxed/simple;
	bh=J9I4W4syJttUssc9Gjyd0UYaE5oBcDY4kx83hR88588=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnacIaevpm3yquqb1ZOvq1xK2OWE6+08Wy4yjUzcDLGxRzLREmHB7eZmFw/76XDerKscqqE+c6AFYXnYikSTXOlofk/10w12e5Rtfd1jwGgAfNd2BarEaC06cYj+rZ5tlfdeL9A+bBP7POG/xn5CliI2Nmugm3/W8ddvGo599x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqZ8qUBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqZ8qUBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8B71F0089D
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580751;
	bh=+rwpGXn9NJeXI3YQ/A7Bo6Q3qFMGQsSSlSyzOmb7/5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EqZ8qUBD7JZ9CYL+YSmDKYkg2iBQx3p8xr6UMmkOKm0O1kz03/3DlPxlqz/GfSCMJ
	 7FRIOAt5rvhU/koOoRzlvj4gK82VDi9CM3Ug55eiknZ+PR/pdGHrp8L5nnjtTv3Too
	 4mq2gUWxWz4d/xMECCZb9s0sh1UyKlRgR5XXUpoqDb9SKBaMqZIXHAcHVSvN3iA0M2
	 vShIqXSA8ql6Eh4LmAqVKf5TWQApNSgc1JRet6NXpQT9+VL+KHGxwSrI6V4L12rF3R
	 NvsnMt5g3RRJ6ujhliWV6R51zocBJjEAkL2w/JwSNZC9u3CnarCYWYL/ZskyrKjMJ2
	 nGuqxLt80bbag==
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76906adso15572481cf.0
        for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 10:45:51 -0700 (PDT)
X-Gm-Message-State: AFuF++lUMScw+I9l9JEgC432tLWYiJvq5errC07wA4d/rptEvasGTxdU
	0eg4wTLqnumTqCsAWFnaF3jN0sGSbf00XNrJaxhUPXHAoleUpe0duyc/O0mLKd2rn8qeFsLDIAt
	8e5De+wyZd/mRIyjHf9YbR8IBhz+yAyw=
X-Received: by 2002:a05:620a:2904:b0:939:4a44:5f99 with SMTP id
 af79cd13be357-93bb76e4399mr556960785a.10.1789580750342; Wed, 16 Sep 2026
 10:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915233454.2405019-1-song@kernel.org> <20260915233454.2405019-16-song@kernel.org>
 <20260915234621.C2A301F000FF@smtp.kernel.org>
In-Reply-To: <20260915234621.C2A301F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Sep 2026 10:45:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5GSoWKt4zD45gnffY=59OaQV0-TKN_YK8ensy4Le8q3Q@mail.gmail.com>
X-Gm-Features: AcwNN1XwG_rnJpT-xk_U-H6kZGp1qDDDzZjheDtVtVIQm0nQhIzed-WQReOGzmU
Message-ID: <CAPhsuW5GSoWKt4zD45gnffY=59OaQV0-TKN_YK8ensy4Le8q3Q@mail.gmail.com>
Subject: Re: [PATCH v4 15/58] objtool/klp: Add test for static local correlation
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, joe.lawrence@redhat.com, jikos@kernel.org, 
	jpoimboe@kernel.org, peterz@infradead.org, puranjay@kernel.org, 
	mbenes@suse.cz, kernel-team@meta.com, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] objtool/klp: test script grep matches file path instead of symbol=
 name
> --
>
> commit 8279e7aebe31fad0b7cca275957a41207409ca61
> Author: Puranjay Mohan <puranjay@kernel.org>
>
>     objtool/klp: Add test for static local correlation
>
> A static local must be correlated with its original rather than duplicate=
d.
> The replacement has to reach the existing variable through a klp
> relocation; a fresh definition would discard whatever state the running
> kernel accumulated.
>
> > diff --git a/tools/objtool/tests/generic/test-static-local.sh b/tools/o=
bjtool/tests/generic/test-static-local.sh
> > new file mode 100755
> > index 0000000000000..d57efa64dfd92
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-static-local.sh
> > @@ -0,0 +1,24 @@
> [ ... ]
> > +out_symbols | grep -q '\.klp\.sym\..*\.counter' ||
> > +     fail "static local not referenced through a klp relocation"
> > +
> > +out_symbols | grep 'counter' | grep -qvE 'UND|\.klp\.(sym|tombstone)' =
&&
> > +     fail "static local was given a fresh definition"
>
> [Severity: Low]
> Will this grep command inadvertently match the ELF file path symbol's str=
ing
> instead of uniquely matching the static local variable symbol?
>
> If a developer checks out the kernel source tree in a directory path
> containing the string 'counter' (e.g., /home/user/my_counters/linux/),
> GCC populates the ELF file symbol with this full path. The unfiltered
> grep 'counter' command matches this path in the readelf output. Since the
> file symbol uses the absolute index rather than the undefined index, and =
does
> not match the .klp exclusions, it bypasses the negative filter, triggerin=
g a
> false positive test failure.

FILE symbol only contains the base name, not the full path, so this shouldn=
't
be a problem.

Thanks,
Song
