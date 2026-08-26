Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595931353C
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787127; cv=none; b=VGYir4ktsN3adh/0+WdlVi6TX/WHh9PbfAd9iAufAt3dq0AXeRjXVRm2e7ytQg0Kwczh1QyZ5x0WnjA5NPezorNf9YDAJGq3/Br8Nf+G3JoornoPfBVfPBx61Y/rGdGQNnBjNUEr5deZ10WvMqBXnvpGiU92NFewTzHVRX2ODiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787127; c=relaxed/simple;
	bh=O63XNLGrQoV4DLWWv4oEyWXvve2tdDsgeaGJCsacHb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyFLXAEg9lqVoiK+wIOz7cf/RP7jTnoe3TQpftpxOwHyuG6n8YdsB/Da3LPvkiuWh/2AtNAGfANtrCRZwmuroUjccMH72Z9DG8BHsCtyEG8pz4umxDu59S5svlsPrArnF1UKCZJOr4ec0urV/CaxHc4JrPC5akxgb16E419X4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efXblITD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efXblITD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109C61F00A3A
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 23:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787787126;
	bh=ESLaiYcxjpay9V8Zcn193dTNj8VFrHhzny/lNRsafV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=efXblITDLHAdHHtSGxODk6vyNlTFBL+mflrTKbw1wOGSMCrQcGw5oc88wSL/2U8lM
	 pNHryWkn2m/Zjvawh+cZ0hmvEDJS0XuZa1MyiVC81jmnK7gyaAWL8+FhnbaAkbomU5
	 hwEZnS2IH2O5tAoiJwGr35Ac2YtXlo67Z4FFgEw2s1sISSHy+0tn7BVT1XLC+Irb0N
	 4EgUXaaoWvwXf7OWX7Fjw7RMAixC0A0mF/n5eKl2dGF7lFXWG0NMB+vmQI+vJE+I54
	 stvvTQJDR22JFa35WxY/Twm6YWoikXDOow0OndA9DlltVFK3SeQHuzQ1WG10QJB78x
	 wqBLFNX6TRg8Q==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92f0b5ed131so136797585a.3
        for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 16:32:06 -0700 (PDT)
X-Gm-Message-State: AFuF++lpXx38ccmjpWsoehbApj09qaB9wy06xPtzuU90JRNF7MuqzN+c
	U7pytVjtx3x8XqWPatKPe8N1/6HWhsb0bkJzUIZtOLHPAEPCdE5mLSBDryeY7Brjs5xIn57ragB
	w6gSQBSMlDrzJJRdGIiJ+0pYizKtNnJY=
X-Received: by 2002:a05:620a:5236:b0:937:6c0a:9b65 with SMTP id
 af79cd13be357-93780186a21mr820149685a.7.1787787125344; Wed, 26 Aug 2026
 16:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826195000.455905-1-joe.lawrence@redhat.com> <20260826195000.455905-3-joe.lawrence@redhat.com>
In-Reply-To: <20260826195000.455905-3-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Wed, 26 Aug 2026 16:31:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6x-XrjYMUH_EJb3tCcKTQxyoAr2H3+H+e5FezFWQi83Q@mail.gmail.com>
X-Gm-Features: AcwNN1WQZMfZfiTjdNUCktdYUvhQ0A2fNE9WQiS2EBwPf3e9FiQY2uyeKalgC5Q
Message-ID: <CAPhsuW6x-XrjYMUH_EJb3tCcKTQxyoAr2H3+H+e5FezFWQi83Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/7] objtool/klp: add --symvers option to klp diff
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 12:50=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.=
com> wrote:
>
> Add a --symvers (-s) option that accepts a path to Module.symvers.  When
> provided, it replaces the default "Module.symvers" filename used by the
> auto-detection logic.
>
> This decoupling helps to enable scenarios like out-of-tree module
> patching and unit testing of klp-diff, where object files /
> Module.symvers live outside the kernel tree.
>
> The existing auto-detection behavior (try cwd, then top_level_dir()
> fallback) is preserved regardless of whether --symvers is specified.
>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Song Liu <song@kernel.org>
