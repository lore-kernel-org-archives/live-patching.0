Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31163B3BE2
	for <live-patching@vger.kernel.org>; Fri,  7 Aug 2026 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087066; cv=none; b=gn2mvyMsKvA9jitGl2cNGsBSQag+e/plqUFNrB5kgy58YC8eRN4vZ5c7FmE5bhvax4tqVPxP2J4csVYWnpLrtlfWbmKYiUdDUJ58sYR0/v17IFUwstvBxLigzjf3Vvy9GSe2A0dN/RPcyaRqErQQbSWdgEtBVaQEPS74IMu11+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087066; c=relaxed/simple;
	bh=0rQKQIltbIAZKIRq8kaIlE+FrtHIwl8xoz/sXhNxEDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7bPDzg7p/cjM8fYjKJ4JR+wOC8KM5Dii8ZBqfdclyWFJJNLllGNsnNwOvEMfpn/J0B8+jnMxGkKZg3nUDbqka2V2l2uPTGu4S5k73avuStyCdTvYqPTqJVRp+tnD8nUNDNksnAmKTcqLsgIn8XPl3kHJWQnSjjYNFPRSmyREbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/cUGoTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/cUGoTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0B11F00A3D
	for <live-patching@vger.kernel.org>; Fri,  7 Aug 2026 07:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087060;
	bh=hpa3u0YmlFumR8mctUr6wUSRc/RYVbzYOgbFmpN/tNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K/cUGoTNAkR36KQOWA/Ql+DALRMQupi2mTsELOw0XI99m7460VeDfRnJX8umeqP2c
	 VXb/VGQMip/Y4dEROX0F7Aqv6l5q0BZdmh6Fm/m/SdvJZ7W0oHN04/d8SseArUxTsr
	 TbsDM3txG3/WRaYl88xXHvbVRfZt/w8LxhfE/R1O2cE5x3r86JMSVozjT5cm7XD8iD
	 XOoGlIl97SoiA5JGgGQW5KEvXI5zrVvnyhGnT+PWJwZjiJec745vduEX80fGPBiPvb
	 hIDFVJSa4HGVfElOPDpUfota+84IXfCnIpsoQzDeMzs1UpD6Vy6BCkdX1DDpTOvsMI
	 2UNy0Jvv+Kg/Q==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e6c4a867cso206885485a.0
        for <live-patching@vger.kernel.org>; Fri, 07 Aug 2026 00:17:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrPHblMzMs0Gv8Tzho74vnzJnIGlqedQq4M1hSnQuEk+phEUQMUfco+Lz9mRDGuJnOcWr8bnMBoh4locAEq@vger.kernel.org
X-Gm-Message-State: AOJu0YyS79Rpl8+/xzdr+1A8NylSEhWbg+C7VawzloHT3ljzx+dW38Z7
	/VP490ZStt57s37ovdnT+cDLg5ODt1k/5m02Q1dTG8fPzbq2+Y+nyQeC68HX0AuXNjdtVW1eriz
	fsagLsLuquiCZvfe1s2sY8JQb3LYBcvI=
X-Received: by 2002:a05:620a:1723:b0:932:dbf6:6f9 with SMTP id
 af79cd13be357-93671b4e94bmr98597785a.9.1786087059837; Fri, 07 Aug 2026
 00:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
 <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
 <CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com> <20260806205144.743c45e6@gandalf.local.home>
In-Reply-To: <20260806205144.743c45e6@gandalf.local.home>
From: Song Liu <song@kernel.org>
Date: Fri, 7 Aug 2026 00:17:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7vPwX-BGWmtMhA8dYwDOQYQLVXOUddZPbTvoazMpaKgA@mail.gmail.com>
X-Gm-Features: AUfX_myRIr-UWYzu2Qobo6IwbXH7Icimgcg_mdavjanIG0MRPEY15jsJ-xL4Uew
Message-ID: <CAPhsuW7vPwX-BGWmtMhA8dYwDOQYQLVXOUddZPbTvoazMpaKgA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	mbenes@suse.cz, jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 5:51=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 6 Aug 2026 17:45:00 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > > Since the selftests are shipped with the kernel code, I think
> > > we don't need to handle backward compatibility here. Instead,
> > > we can just assume disabling ftrace is no longer supported.
>
> Incorrect.
>
> > >
> > > Thanks,
> > > Song
> >
> > I tend to agree but I think here[1] Steve and Miroslav asked for
> > backward compatability. V1 was actually the way you prefer.
>
> Right. We test older kernels (think LTS) with newer testing environments.
> We need them to be backward compatible.

Alternatively, we can test the LTS kernel with the selftests in the LTS tre=
e.
I guess this alternative is not preferred because the selftests in the LTS
tree didn't have as good coverage as the newer selftests.

However, requiring compatibility in selftests has its own issues:

1) It makes writing and/or maintaining selftests harder. For example,
   shall the selftest for a new feature fail or skip on older kernels.
   Either way, some extra work is required to handle this, e.g.,
   someone need to remember that this kernel-test combination is
   expected to fail, and it is OK.
2) It delays the actual deprecation of a feature. IOW, the feature will
   somehow stays in the selftests for much longer time.

Overall, I think requiring backward compatibility appears to be
attractive when we go from "having very little selftests" to
"having some selftest coverage". However, not requiring backward
compatibility will help us achieve better test coverage in the long run.

I hope this makes sense.

Thanks,
Song
