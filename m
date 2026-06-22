Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1E38E5C8
	for <live-patching@vger.kernel.org>; Mon, 22 Jun 2026 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117769; cv=none; b=ojUOS3pcYEgsQMOYrCTRaIkQGFE+x0IXujMaT745+qm+HaeQ3q/bSaVGooSkPoemn4o/FGzRxf1HAT+z+suL4AqAwaCHSxt93OxnQ/0AHt0k2XVgnOYj4Iso3faQr88aAVo/7aYo7WBJypF5Yc7Rpd01bxFjmN9fDtX3hw8bglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117769; c=relaxed/simple;
	bh=IER6Q4RbEHU+TqBNCFXousE9wjBARqNFqdXSUnckiEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLVeNsCmZXJbf2GpVbtQEyfEbgxhdEKzXndO//tokSNcUb5iTFWxjOFoKcSjd6Wcj7Lvlkb+SxzQGb9Ai4MkjvNNmTVGvj3sMGvO16oi5FzbqJpRPMXJXkiFWSkQIyu+6XUpOpVon+OmDzzXTbVUtoY80E3DFK+LIHQmPEQxl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROskh/8t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROskh/8t"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46255b269c2so3112294f8f.3
        for <live-patching@vger.kernel.org>; Mon, 22 Jun 2026 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117765; x=1782722565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFnA4MB3rhX4hW9kwKpEDdWQh6n3FEg0cpZAkJWsmhQ=;
        b=ROskh/8tfIJaOesnEZqCHlQNJbZWki5RbTqza/lsX5eovRkaYimKsd+YXB/k2zMi/m
         /oMxYwZTti4VBo4Zu7g+ne/XnDzRPkeytOwEHJ1QPmKrsfs8gcwvBhLar3NiR6OJGf0L
         +J8cEmu4EM9EXTaOXzKCB3rcDsY6oG2rx0tNv24ObV21OlAfSpd7lVCwHX7BM5qlSMrU
         0Y+stJ4hQbL/MqG06XGIR3AP4JZd7J5kU0fBgPGMIRm0x4a2O+CoKjF5iYge8niCKb3T
         4w+mIabC6ghr2q6JO+5qYmEFnGpSPuxK8BZC5l6QgOh4KqNC3bjBRyqs8iNZbdgiJDoz
         PvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117765; x=1782722565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFnA4MB3rhX4hW9kwKpEDdWQh6n3FEg0cpZAkJWsmhQ=;
        b=Ic4UngJFrDlBeRPLOdum2MP1IyY7JZaEhMWlTqxAvO0JdNnUfMKwp1OrFNdczmMQG1
         eG4fSSvc0H1DmM4P1+ZZVQkNKVvRwstH2qYX15w79QIyeVgMnJmJOsGyVwT1f6yh9hQO
         VWK8EPSlZV9fROVkridkwVHMR6ByjRe0ZKPS98pCAh6wpENwQXU/VYKRbCNmQGzOTFeK
         ZbguHPNX8cxZNqOBT8FPTZmXW0CczYgwU7a0bjI05YAkg/VRvkrj5JdZi6cllVRZA5mW
         rO3pPKlNygzNEzJueV1uCiaMQVzWD5CYec+uXPLzhyefFeAjeUJPIYlabZwkdP9+qyyF
         z7wA==
X-Forwarded-Encrypted: i=1; AHgh+RqwcsOE87Y8T+JSuFzS3altN3McH1ajw2smb8qWQywhXa9bYLnA66o1N2woE2rcmz+wZ0r4eMxScWdccPzQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vS2rtB8crczP2po0xR4VBk8hvDhHytwqRNiDH1mj0aWRm2tX
	W8woCMwovhXHapuAxsa2WOxfF0sEqgpAmNQQFIt3Z5CWbBBkUdMNKFDC
X-Gm-Gg: AfdE7cmBbISDov9HRInMZTmidWCg6qIGVSyytmzF2gjPtta/KZwi3Blg8FL6T/DeaQD
	N3PDuutVqss2aN7PBEUUxu7B7BRtgsVvFE963Op0Sz+OiM/kiVpE3uJWhQ5qZqwvxsgBwPk8iOK
	G/J6idBwjFMZxkd+E3gr4FvZKqmFGgAJtnN+twZxTJ1+GS3GxGHWTWZnbzfR+74CjFk/zLRMtdD
	GMf0PW/AvbZ7sUdB/Qin3ZVPSze/MSWUNd5kfPa2wLb165N/Wjs6q1Wklww0xHSz3duBqjxgtw7
	QpwRD1x9cPUBLu4wULorOgOZ8lGvgtROw+EGm+IDiiuc4PKDAXBwB8CHawHqiR0om65fLFxD7WZ
	6/rluDka5t3vKyAqTcNuOl0wSkTEuWDyU9qjBvxPE8/iWjQMsoU0MvdpGbg58EpN2Zn5NaLPaeD
	g8L0XbnMW4RGg8Nz44CzETjuucsXAx4C8Q6mUwsutTu9RwsoRlNvrz1+oaAv9Y
X-Received: by 2002:a05:6000:2006:b0:460:1e5a:2267 with SMTP id ffacd0b85a97d-4650090b736mr21019711f8f.17.1782117764761;
        Mon, 22 Jun 2026 01:42:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm24839972f8f.29.2026.06.22.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:42:44 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:42:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo
 <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Paul Moore <paul@paul-moore.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Howells
 <dhowells@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, Randy Dunlap
 <rdunlap@infradead.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Philipp
 Stanner <phasta@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kexec@lists.infradead.org, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-mm@kvack.org, virtualization@lists.linux.dev, damon@lists.linux.dev,
 llvm@lists.linux.dev, Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v3 1/7] list: Add mutable iterator variants
Message-ID: <20260622094242.64531b9a@pumpkin>
In-Reply-To: <20260622040533.29824-2-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
	<20260622040533.29824-2-kaitao.cheng@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 12:05:31 +0800
Kaitao Cheng <kaitao.cheng@linux.dev> wrote:

> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> The list_for_each*_safe() helpers are used when the loop body may
> remove the current entry.  Their API exposes the temporary cursor at
> every call site, even though most users only need it for the iterator
> implementation and never reference it in the loop body.
> 
> Add *_mutable() variants for list and hlist iteration.  The new helpers
> support both forms: callers may keep passing an explicit temporary cursor
> when they need to inspect or reset it, or omit it and let the helper use
> a unique internal cursor.

I'm not really sure 'mutable' means anything either.
It is possible to make it valid for the loop body (or even other threads)
to delete arbitrary list items - but that needs significant extra overheads.

It might be worth doing something that doesn't need the extra variable,
but there is little point doing all the churn just to rename things.

> 
> This makes call sites that only mutate the list through the current entry
> less noisy, while keeping the existing *_safe() helpers available for
> compatibility.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  include/linux/list.h | 269 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 231 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 09d979976b3b..1081def7cea9 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -7,6 +7,7 @@
>  #include <linux/stddef.h>
>  #include <linux/poison.h>
>  #include <linux/const.h>
> +#include <linux/args.h>
>  
>  #include <asm/barrier.h>
>  
> @@ -763,28 +764,72 @@ static inline void list_splice_tail_init(struct list_head *list,
>  #define list_for_each_prev(pos, head) \
>  	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
>  
> -/**
> - * list_for_each_safe - iterate over a list safe against removal of list entry
> - * @pos:	the &struct list_head to use as a loop cursor.
> - * @n:		another &struct list_head to use as temporary storage
> - * @head:	the head for your list.
> +/*
> + * list_for_each_safe is an old interface, use list_for_each_mutable instead.
>   */
>  #define list_for_each_safe(pos, n, head) \
>  	for (pos = (head)->next, n = pos->next; \
>  	     !list_is_head(pos, (head)); \
>  	     pos = n, n = pos->next)
>  
> +#define __list_for_each_mutable_internal(pos, tmp, head)		\
> +	for (typeof(pos) tmp = (pos = (head)->next)->next;		\

Use auto

> +	     !list_is_head(pos, (head));				\
> +	     pos = tmp, tmp = pos->next)
> +
> +#define __list_for_each_mutable1(pos, head)				\
> +	__list_for_each_mutable_internal(pos, __UNIQUE_ID(next), head)
> +
> +#define __list_for_each_mutable2(pos, next, head)			\
> +	list_for_each_safe(pos, next, head)
> +
>  /**
> - * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
> + * list_for_each_mutable - iterate over a list safe against entry removal
>   * @pos:	the &struct list_head to use as a loop cursor.
> - * @n:		another &struct list_head to use as temporary storage
> - * @head:	the head for your list.
> + * @...:	either (head) or (next, head)
> + *
> + * next:	another &struct list_head to use as optional temporary storage.
> + *		The temporary cursor is internal unless explicitly supplied by
> + *		the caller.
> + * head:	the head for your list.
> + */
> +#define list_for_each_mutable(pos, ...)					\
> +	CONCATENATE(__list_for_each_mutable, COUNT_ARGS(__VA_ARGS__))	\
> +		(pos, __VA_ARGS__)

The variable argument count logic really just slows down compilation.
Maybe there aren't enough copies of this code to make that significant.
But just because you can do it doesn't mean it is a gooD idea.
I'm also not sure it really adds anything to the readability.

And, it you are going to make the middle argument optional there is
no need to change the macro name.

	David


