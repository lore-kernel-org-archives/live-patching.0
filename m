Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDC2C11DB
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356566; cv=none; b=a92ZlzZfWD7zBAVhicGaiaDJXijo0caemAX7dcX8lwQBSIFUx1UkJFBCgzC5W0lK8wfaqvxZjIODRihX7xVCrTnEWOuvHVJkJLmrW1c7eN9WrG3IdbzeVoXfgVr2Ii6xM4I2bv+gniSDT4nBTZ2FFS7n9saNXxIv1H/NbW3MXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356566; c=relaxed/simple;
	bh=N1PY5YKKVDFHJzTC84djvOvPBot2xHPDVCEgWRMZYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW4o10EnBpsiPJWqnytvQuYuB6I5MVrT86ughDVeN1NdRn4i8KIGCoCVTzazzENMWO2DEJI/FOm99ogeC4+UyS47y9VkwPnClP51yUiBUPGS+zVzxUH+lmuZoORnfjvYw3mgvAquONX3M/iqQZ8cbAK4APtn2+yKeT7c3WP/Syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW+2LXTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW+2LXTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5116C19425
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771356565;
	bh=N1PY5YKKVDFHJzTC84djvOvPBot2xHPDVCEgWRMZYg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UW+2LXTgCMtn33S+ciPYqHkFCR9DV9rnx9SpLJTlTob2Ayq7RX1Iwy+zLC0obd965
	 V9cbZu6OotFI6u7qsa8oc7BMi/ZVYJQwwEQ0vH67PPTDdzoOFwMe410nW+ixcPPhTa
	 C/ubeDfgAcRignLzCxau7Lc8AcODO1Q/zGL0XB+CeN2Uzm4AZzVJZAalt7FtSpMcdo
	 GQb8ydeEIuB4qilfuOOf7Zu4MVI2Im7KUqHXSC1o0FL6rOsPmwlX5hBy3ai4CJN7oh
	 M5WXqQZh/gDX+QkiZyuVFKp4qEjRi/ktuIIvmvm/zNnRjWjET5MvdIXUDzGqI69Acy
	 lFjnR9VQpZx2Q==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5069ad750b7so41052151cf.2
        for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 11:29:25 -0800 (PST)
X-Gm-Message-State: AOJu0YxzR9QeTTkQa/2WH7SHk+bdKnxsUUsLrNo7bXfBF9Dw3E793fLD
	UZtMwENKBJBIQuIf3ZVrYrwkKiY7smPehxIC1tJjCI7xYQr/hNqBs8Ptrnrr4VnvHQbVr1GgcOA
	qvzIxnTMdL/kZULt8VIkYwh7SK9RSD9w=
X-Received: by 2002:a05:622a:1894:b0:4ee:1dd0:5a47 with SMTP id
 d75a77b69052e-506b403c1f0mr198294801cf.76.1771356564795; Tue, 17 Feb 2026
 11:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217160645.3434685-1-joe.lawrence@redhat.com> <20260217160645.3434685-14-joe.lawrence@redhat.com>
In-Reply-To: <20260217160645.3434685-14-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Tue, 17 Feb 2026 11:29:13 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6=9OUGdLBR1OhNDk2tbFncGfYe+z7HDr16si06g4AXGw@mail.gmail.com>
X-Gm-Features: AaiRm50HrOFM9fn11eASZDhuVvVNB4tAkftOIRpquz0qN8wYS9DQho0JApOyEoM
Message-ID: <CAPhsuW6=9OUGdLBR1OhNDk2tbFncGfYe+z7HDr16si06g4AXGw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] livepatch/klp-build: don't look for changed
 objects in tools/
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 8:07=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:

I guess we still need a short commit message.

Could you please share the patch that needs this change?

Thanks,
Song

> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  scripts/livepatch/klp-build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index 5367d573b94b..9bbce09cfb74 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build
> @@ -564,8 +564,8 @@ find_objects() {
>         local opts=3D("$@")
>
>         # Find root-level vmlinux.o and non-root-level .ko files,
> -       # excluding klp-tmp/ and .git/
> -       find "$OBJ" \( -path "$TMP_DIR" -o -path "$OBJ/.git" -o -regex "$=
OBJ/[^/][^/]*\.ko" \) -prune -o \
> +       # excluding klp-tmp/, .git/, and tools/
> +       find "$OBJ" \( -path "$TMP_DIR" -o -path "$OBJ/.git" -o -path "$O=
BJ/tools" -o -regex "$OBJ/[^/][^/]*\.ko" \) -prune -o \
>                     -type f "${opts[@]}"                                \
>                     \( -name "*.ko" -o -path "$OBJ/vmlinux.o" \)        \
>                     -printf '%P\n'
> --
> 2.53.0
>
>
