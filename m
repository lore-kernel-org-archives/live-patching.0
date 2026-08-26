Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967931353C
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787098; cv=none; b=o43et25wS93zO7umKf40cKKJlFtt9oGT4ngME0+sGOsa+FnIien0A/LR2l8fJboW7UAGhB0fJUUXxyOOawZduEEXGH8ITJUnW6dpKXMrhMGXvNS6RzetQur+BI0+1VCAcRitRuoP9Zs1vxFjliNis4mbXovg1E/4+o75rdlhm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787098; c=relaxed/simple;
	bh=P4wznal8n/Cirl71uHDCokYJkfBG1z/ig9yk4W1zKCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pO0aJUxm1kPgt6yDIcddCjhX3Ewpf2eX19eGxSXyM5b/RB7qFfLh6QHwiCQkR0w4R62PSktX9Me9yZOzU5IDmB1rnGmTiiQCYrVDIXzAEdu77gHxMujaJDSNv/tSn61IKxszbEGkjG+JlPojW0N+QlJocd1eNMLrGZq0CU+khB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq1YsKUB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq1YsKUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2D41F000E9
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 23:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787787097;
	bh=P4wznal8n/Cirl71uHDCokYJkfBG1z/ig9yk4W1zKCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Tq1YsKUBLQ0HzYQ4OM5orseXSFCexdK+P3D4cPaJVq2D3Z79QBSFehEKz2fOfJ9ql
	 1RmXIiICXeBFunvjMtNXe4FtAGg/3Ypl2WEiDg0mcXSnF0Bv5UVsJIDiPLz943U8Sx
	 aZw3qGB58WtlmFdLOwNZdjusT2OhMIit76g+y8yow5CwVkNXCn5A6dYJrBrhqPuzL3
	 /lkT2O9JxVzrT2Y3kfOwCGg7T3/ECRnXUSrmlyW+VqgzkRcguOHRvTM/LtBiu/l3D+
	 71YJRTdCXfIxt41DR0qjh0rif+cyNK1sxZ/Pyyzw/Xef4h2DOrqFaEfg+8uU19XCeT
	 kAI9Z2/3X2POA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930c0f9c1b1so75796585a.1
        for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 16:31:37 -0700 (PDT)
X-Gm-Message-State: AFuF++n8/oILsmZz1RxTTIhhYdq3UL/vLhJ0c2EvSyg7YeZHRvkOOBsb
	4372Zl4kS4pZIyNNz2hYPQLOBv8zBL+W+G75rox8u55LOoLnwsyDzNWoMUkA2C00fuOuvtjk/BG
	JaIfn7E4whMD3BKB98txPNV7B8nwYCOA=
X-Received: by 2002:a05:620a:f0d:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93780130181mr1049912685a.12.1787787096472; Wed, 26 Aug 2026
 16:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826195000.455905-1-joe.lawrence@redhat.com> <20260826195000.455905-2-joe.lawrence@redhat.com>
In-Reply-To: <20260826195000.455905-2-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Wed, 26 Aug 2026 16:31:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6vAp5cZtVnAPRNdO5zgyztypuYeVQWsfT69+tde61CoA@mail.gmail.com>
X-Gm-Features: AcwNN1X7LYX-_3EIUd7k78W-Ad6xcXI4GHwymXZwYsCmxffocxoxmPM6ELgjDyQ
Message-ID: <CAPhsuW6vAp5cZtVnAPRNdO5zgyztypuYeVQWsfT69+tde61CoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] objtool/klp: simplify read_exports file handling
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 12:50=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.=
com> wrote:
>
> Consolidate the Module.symvers handling in klp-diff's read_exports()
> with a single error path.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/live-patching/20260514204741.1ECCAC2BCB3@sm=
tp.kernel.org/
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Song Liu <song@kernel.org>
