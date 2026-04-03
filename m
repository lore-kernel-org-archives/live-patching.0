Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252593C455E
	for <live-patching@vger.kernel.org>; Fri,  3 Apr 2026 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233175; cv=none; b=KMNiRvaCiPunPiJk741aa7ZQ+TmdGs2lANUPyu7Mi+P9X7j8PYIXjyfGMX8gYRqdkGblel35XnUwaDk5RabMhm6roZdFgOQQoFhoyTCopB3O3AmDl5PDQI7+DA/YaJCxYR5b1WCZGbxWcbjNUFIhL6PYBkPyoamBklD60AnRh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233175; c=relaxed/simple;
	bh=NeRUS0mlQ0BUx8C1CFgVHQPP6mbHEHN9+svmX2tF2a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZ4a1rF0UL8xbxJOSoyv3UgbINPyA2ETXAhLXBU+EDinq5vRtEogeDH9U7AgaUe2kX2c7Z/4kzz/s/YjLykw9UqFpLWhPib07n3P/7xJgIdjq9vL5RK8g9HK6MKbeivjAMS6MTP97mpX/CcJ/deI7QpfeuQCm/PCCIWo0j4E/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+ed0xMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+ed0xMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0FDC2BCB7
	for <live-patching@vger.kernel.org>; Fri,  3 Apr 2026 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233175;
	bh=NeRUS0mlQ0BUx8C1CFgVHQPP6mbHEHN9+svmX2tF2a8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U+ed0xMfSiFpe3BsjVa0Aiapk7CiGy5FU7qZoH3MBE+6hbZcis4vcMr8dLvcXIBfX
	 oZw+9C8OKAyKVuAwQjfC896W3dZ2+o1RS0eOE30ckFY9CW3eYVUz3sWcZ1mi9zkflA
	 bhdXD2+bYybFMc9EmPTF5pOgh6fp4Zs5KWZh/V1nT5n1ZWGy4JrSP79ODCeN3UfBkb
	 C4BNZhdBOCIspcWmVM4DMPdOrKkTE4FFmnT/YdAWKIGlikIPWRfSqqlDXRI4zxk8ag
	 grFHzF7/CkidGZ6YZEXIu+syDrzHO0Tzy2acznkdMWpDbKHeRuVqBjJIvmTXLgoXLr
	 106lR7xdDZODQ==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb4136d865so270816985a.1
        for <live-patching@vger.kernel.org>; Fri, 03 Apr 2026 09:19:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+A+hN75TtS5tsOe15atiuQgyWHAqMM10HEOATcTeoYOnLZl2uRNpsPxbQChzcvt35JPI3N0sn8ElTuZok@vger.kernel.org
X-Gm-Message-State: AOJu0YydQIzcHb4585T2Z2vwmJ82ptm09JUaBFlTdRIe4oCm/1MVA1FQ
	NyVJPaXEsn6foxngQX5GIYsFfLtvIckSXeFTybRznATaW/PX2lSlOpTzudBm22DNFSqjE9fOdKR
	0mb6R3tcT6pYnxMYIP13HchLv9RlEZLA=
X-Received: by 2002:a05:620a:448f:b0:8c7:f79:bd70 with SMTP id
 af79cd13be357-8d41da56c25mr522980485a.44.1775233173869; Fri, 03 Apr 2026
 09:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-4-laoar.shao@gmail.com>
In-Reply-To: <20260402092607.96430-4-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Apr 2026 09:19:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
X-Gm-Features: AQROBzB_Kb5Pvx8Y-KgoHLBUvvCPfURQUM5KHCLy0CPv5s3H3joA7FSpJ0KtftY
Message-ID: <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Add a new replaceable attribute to allow the coexistence of both
> atomic-replace and non-atomic-replace livepatches. If replaceable is set =
to
> 0, the livepatch will not be replaced by a subsequent atomic-replace
> operation.
>
> This is a preparatory patch for following changes.

IIRC, the use case for this change is when multiple users load various
livepatch modules on the same system. I still don't believe this is the
right way to manage livepatches. That said, I won't really NACK this
if other folks think this is a useful option.

In case we really want a feature like this, shall we add a replaceable
flag to each function (klp_func)? This will give us fine granularity
control. For example, user A has a non-replaceable livepatch on
func_a; later user B wants to patch another version of func_a. Then
some logic can detect such a conflict and reject the load of user B's
livepatch. Does this make sense?

Thanks,
Song
