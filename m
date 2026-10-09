Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562103C276E
	for <live-patching@vger.kernel.org>; Fri,  9 Oct 2026 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572358; cv=none; b=l1rpCPict9RyF/ZXcUqo+TBVWto3cj82bpCrrGMaW9k4T+LHpPwYsqZ9DG13QJY0TGba7dayyN2sAyXZDLQhIEGU+lyecqGJkVQWiqQjkJtAhOpATKiICL0AEnTZ8t5E80P7yS+rWcEfueOxTf/58Av8KIOG//rkuwHlHU7KTxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572358; c=relaxed/simple;
	bh=MUwT80gOWfAvuW29q252L7dGK6/yoX9ij9iHwsuwjqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikIlIOsQM/tBbKNnP2dEXjGKw1P8oerZr0+3/njC+07HTHhnfNm4IDK4MCSyl2sx7jieLxyrLn0hTuksc15tRqeD86PAS4PTg2gst/D1OzfIUGOe+I6wP8s86kxbeoWXLyAazGSiXzx2ZiSq/GABXTCZVKDxIiOnD0W4s0lD2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs3oe+qs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs3oe+qs"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso1437175e9.2
        for <live-patching@vger.kernel.org>; Fri, 09 Oct 2026 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791572355; x=1792177155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pJrTXNnvNyxoPy6a05idwZooJz9oMMxcUiIT8xGCw0Y=;
        b=Gs3oe+qsaAo6Qyb+uYz8NIy2rJdxahxKqbuXgczFYkOCY/Ta/j7CweECUa6PHIr4UH
         CDzGNqMOibkOXYfbhSDtAL6hIXjDj4yBbm/tIKvFRjyRNSC6iK0Un2Z8NwNoF0IkNPJe
         s+Q6qwLB6smocAz9Lpq7CvG+OrSmMSN/IigspZv5Cl5/82BNpLv+mkQU4tOhIoN4cxhP
         LgJhYWNQyTD3vLPlOr+EAt2Yp8liPhI1VH6ZVEnFQK4c4JUf+dwpfYYU1yia5A34O7Cf
         9DCmbiYJyWF9Em9gtkOkpEFW/G+ib+tIt+kiA3zbFEz4mCK0yMH+thWieK+osjleSYPS
         E7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791572355; x=1792177155;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJrTXNnvNyxoPy6a05idwZooJz9oMMxcUiIT8xGCw0Y=;
        b=gGpCcOQ653QjWf5rQJZUtgNzoVjNURuUQ85EVmkboJdBNRhL0gHRbweFBGpeZ2cTGK
         s8AaBdjv3oGmCc01IZKNlevt4FH5n9wYsVMTTYLdh08ObrfVUK4W1d9g04I1w3RMAw7y
         XnQqADo4UNETsp2g/K1Q5UCdDha/14gMhZzavWizP94PwWcKPOUgwLlzxL3OkpGZjoXe
         z6qpvD6GLA8wPabofx5hQGBfCkenG4Y8A7zS8kzek7BHkJ2M8fuq07QcE88TtQ1mvGyk
         2yxmWA7a90BdD7IGIchK02Vag9zZPoehjioB7+/ZWwv1ovu3AyLauaqpYMTFHNK5wQUQ
         JBLQ==
X-Forwarded-Encrypted: i=1; AKwUvByvSMiS5O2lGXc27tUtmKjp2WkOwiYYecL4Uvp7f+zz8Ag81b1LTPwO/clVC8xRHwPs+XYHjYphs5gVsyVQ@vger.kernel.org
X-Gm-Message-State: AFuF++mgqHGRFIFq3MEryRd3YxO+w4e17QzWVnRvveQ8fl2Ld3k8qXIJ
	1NeLH+JKpL9Q8ZJZkv+22IwgMLKaTi34/rhoZa+1TbRgQu+X0IN1yAkh
X-Gm-Gg: AYBFou0xHZ+LupV+lYahr2JNwc2iNugz0krTrRTI6VZFYGeXvmVAerKW7h7QLCIMrJa
	hDb+h9iADGfB5Zxir1cMrv8F1vnqFlJebBz1TZUKWDoCiXOxM2vTDQveYrYh0+bA+ONKFEwNnl+
	X6Q+nCx7zcAFhtpoMj/8khHQJw+D2Htljw2kK4a35btmtvLngekh6oQiWkQFeOHZKQGL08ZGzDA
	RWaS0etsjMcWbsY1MxjjccZNPpKshYdgDx5SE9JxyJdE6n2XnGsNvW25JaOExVsmGQlA98MqeZv
	bgE0cZNhkYJA27kd9yw0bxkEGw/1c0xPHcJis8ILhTINiF/2WyO4vISp29VMlpOlOOBSSXxXpLt
	rY/CkviG8QWkWL4ZBHFeqFRUTsYZ3UNX76UxwFxBwTIqaOlxL3hYpJ6X1z0fcwae6NLg0v+DLBp
	jimbh7b82yuXkvaIbAiat1P/yUDPSs+8SqPG6ga01mxlxX4mjCJ1bvEoTZbfAn+LWF3FXgj66zE
	KdIL8MfGEyr7YZQlokJLTZLrIKnv/619ZqWHt7BPabCv1kNfw3km7lzeGxBI8Z2+VRM8Cf3ZvyW
	xtJl8d77P90U+fWQOyLKnrtQcrm7ugPcaJrtB6ryxtzhrE0l5i9HRvTvs2CUYIoWXz+Xa7NszIH
	FhA==
X-Received: by 2002:a05:600c:8708:b0:4a1:7b05:3a6d with SMTP id 5b1f17b1804b1-4a18e49881amr52257515e9.8.1791572355206;
        Fri, 09 Oct 2026 11:59:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm122222075e9.8.2026.10.09.11.59.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:59:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	mpdesouza@suse.com,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	martin@kaiser.cx,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 5/7] riscv: stacktrace: switch to frame-pointer based unwinder
Date: Fri,  9 Oct 2026 20:59:04 +0200
Message-Id: <20261009185904.82385-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914092648.51254-6-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com> <20260914092648.51254-6-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On Mon, Sep 14, 2026 at 05:26:46PM +0800, Shuai Xue wrote:
> +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
> +				      void *cookie, struct task_struct *task,
> +				      struct pt_regs *regs)
> +{
> +	struct kunwind_consume_entry_data data = {
> +		.consume_entry = consume_entry,
> +		.cookie = cookie,
> +	};
> +
> +	kunwind_stack_walk(arch_kunwind_consume_entry, &data, task, regs);
> +}

Hi Shuai Xue,

With this patch and FRAME_POINTER enabled, return_address() returns the
caller one level further up than asked for.

return_address() in arch/riscv/kernel/return_address.c skips level + 3
entries from arch_stack_walk(). The arm64 original skips level + 2. The
third entry exists on mainline because the walk starts inside
walk_stackframe() and first reports the return into arch_stack_walk().
With 5/7 the walk starts at the caller of arch_stack_walk(), so
level + 3 now skips a real caller. CALLER_ADDR1 and up are built on
return_address(). The irqsoff tracer and the preemptirq tracepoints use
them.

A KUnit test that calls ftrace_return_address() from
leaf() <- middle() <- outer() <- check() returns:

             af32da41b032   with series   with series, level + 2
  level 0    middle         outer         middle
  level 1    outer          check         outer

The change to level + 2 has to depend on FRAME_POINTER. Without it the
series keeps walk_stackframe() and the result is the same as on
mainline. There, level + 2 makes return_address(0) return an address
inside return_address().

The same extra entry makes stack_trace_save() start one frame too early
on mainline. 5/7 fixes that. I have a small fix for it on mainline,
meant for stable kernels, which conflicts with 5/7. I would post it with
you in Cc. Tell me if you would rather take the return_address.c change
into 5/7 first.

Tested with clang 22 and the series applied on 52318cf0fa6e. The
"with series" column is the same on QEMU's virt machine and on a
BeagleV Ahead (TH1520). Everything else ran on QEMU only.

Karl
