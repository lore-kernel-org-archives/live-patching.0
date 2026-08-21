Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F02D781B
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345117; cv=none; b=Onso8qWPDveFPxYPtckhpRgN2Q7NaIjXkqwhOUy3ef+bRdH2PC6aczGjr03uWgvwdjTdrkegVs7i2GDfQFkidkH9uexBo6bDcmA6vEh4myzAENwJZQmR9kLicRJfAq/oP1o+A2YfNRlbaAaxoVNdsRs9+0s7SmR7BTR4cy0iCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345117; c=relaxed/simple;
	bh=SApEu1cg/ziHS3TXVLhYFwiKSC+a+3cYXecM89zWZfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coCUpAsW9eCB52YumQgZYOhh85vaE+eWaLYPP2Owr4ZN7VbWg6FU08H4E8UYboFRY/pu711Tl9tWFmOWc5coq6vCjN0nxeOSKFo63LxvWoUExm+poEkO1Ig3i64N9EbqpWMESbwHGV1Poryk9zwHMr4KxDbDOHxY+ssHWiD1xCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv04gTmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv04gTmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFD41F00AC4
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 20:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787345115;
	bh=PWKQ2xW1GmpDn3YqAG9Sfav4SORD73/XE9rMjOE6Q0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Uv04gTmqAiILLw5th0ryjVwJVUgd00PD6LInu+N757K94wDt6mm39Vx0Z5idWimMz
	 2hoKmQn7bhMq41yyIX1wqDFUzXdIRB6Z+fKQ0/9wMX324EmYFL53A8e8ZCfbEjQXfd
	 HuEAz4lfxAfc5YCKg3uXK2BSkosz89Oi84q3byOxWYLIOKxhGjzna12ikQJQPGD9YX
	 ZDDQJyV/EvvMnPhD6SS5tdLF1YbVW7XejFDzXGf+n4gnebJXOJ3gmou9zfj5kQxA+a
	 IMrYQPnAqKJR+5W26zxXcc+QBaDtIbS/wEBuMnRPfgjXR2JyHyhzQ1mJ76d4q0cmZY
	 Gb8Qq+CWYO7Xw==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52cd38ddcdfso8615481cf.3
        for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 13:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roj+cyEOm0kQ0/Zcur8eN1FB4m+4tqqHe86Kiq1y2LtmK/IpQiYf0pzlkEjl4CJCmHcsYHE2sOSYrf084oj@vger.kernel.org
X-Gm-Message-State: AFuF++lea3tdF6btNvQ63yuqBJgxQqgHw9hJPB4+enCxkhwikfU0YYw3
	QBBp1Ddsl1/gtce9ipik22xKx424Ay6JciIRvso0SUwOfsH6fQkgEpolKWXVWbfX4sJ6RpB3XYM
	Tylk9Ko44WqKoV7102nYRuKaSy0VuD2M=
X-Received: by 2002:a05:622a:e0c8:10b0:52e:a11:571e with SMTP id
 d75a77b69052e-52e0a1169f2mr4316841cf.11.1787345114752; Fri, 21 Aug 2026
 13:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821031648.48195-1-laoar.shao@gmail.com> <20260821031648.48195-2-laoar.shao@gmail.com>
In-Reply-To: <20260821031648.48195-2-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 21 Aug 2026 13:45:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW42q8KKHaYPVwoWH139btRpf_wFbEenbCa_xji5REbsKw@mail.gmail.com>
X-Gm-Features: AcwNN1XKosPn-3TthsxelqDWcm-lfxyQs-Rs4EAHm0z92xWdknDqckxuHwd-H-M
Message-ID: <CAPhsuW42q8KKHaYPVwoWH139btRpf_wFbEenbCa_xji5REbsKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] livepatch: Fix UAF of unregistered patch kobjects
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:17=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The kobjects of a livepatch are released via kobject_put().  When
> CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() does not release
> the kobject synchronously but schedules a delayed release with a random
> delay of up to 4 seconds (see kobject_release() in lib/kobject.c).

I think I have seen this issue before. Thanks for fixing it!

>
> klp_free_patch_finish() only waits for the release of the patch kobject:
>
>   klp_free_patch_finish():
>     kobject_put(&patch->kobj);
>     wait_for_completion(&patch->finish);
>
> patch->finish is completed by the patch kobject's release callback.  If
> the patch kobject was never added to sysfs, or if some child kobjects
> were initialized but never added to sysfs (e.g. when klp_enable_patch()
> fails after klp_init_patch_early()), those un-added children do not hold
> a reference on the patch kobject.  kobject_add() is what takes the parent
> reference, so the patch kobject can be released first, completing
> patch->finish while the child releases are still pending.
>
> The caller then unloads the livepatch module, which destroys the static
> klp_object and klp_func structures.  The delayed child release callbacks
> later access this freed memory, causing a use-after-free.
>
> Fix it by making every child kobject hold an explicit reference on its
> parent from the moment the object is initialized: klp_init_object_early()
> takes a reference on the patch kobject and klp_init_func_early() takes a
> reference on the object kobject.  Unlike the reference taken by
> kobject_add(), these references also exist for objects that are never
> added to sysfs, and the release callbacks drop them unconditionally.
> This guarantees the patch kobject is released only after all child
> kobjects have been released, so patch->finish cannot be completed before
> the static structures are safe to free.
>
> Because kobj->parent is set only by kobject_add(), add explicit
> back-pointers, obj->patch and func->obj, so the release callbacks can
> find the parent.  Dynamic objects and nop functions are freed by their
> release callbacks; save the parent pointer before freeing and drop the
> parent reference afterwards.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260809094046.50ED31F000E9@smtp.kern=
el.org/
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Song Liu <song@kernel.org>
