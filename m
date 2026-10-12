Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80C497B8B
	for <live-patching@vger.kernel.org>; Mon, 12 Oct 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817688; cv=none; b=IPfXUjZWtvp77pELEFYLsvlc8muVkooenZnI2QDQboAIbv60GzBG9z3tRGx9N5bJVv1aY7rDXVtK3pV8vGEusfZdMDfnsYZPQceSIAeaOCHnSpKwT4rGUwuikflNXbDN1ll8xodGGpQJIAxM82TEBcsGUqwsZXIzssB6yh2oPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817688; c=relaxed/simple;
	bh=OsG9QFWVI7GlIGSTCxFfoFpAyRAObqzzGqmR5pOuPKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O//Ox2PHOP2VC+jdERGgN9H4sga9UAWFdbuycxec641HaGaZ0MLcDjvKSy1vQeiNTFbjiIUb6x2vsPfQD+DvnXAyYbsjYKM09snmbMtmtOPMHh5yBJ1UzDPhSBTp21allP2TaUT8VsWri1oODVE0z1J4R58zzRKAiweFp+ih/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anZN/cUr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anZN/cUr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a168355946so17308805e9.0
        for <live-patching@vger.kernel.org>; Mon, 12 Oct 2026 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817685; x=1792422485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AWiLDXPot0/+PbKR6u2nu/eRULx+LiAnb5d3+K32M2g=;
        b=anZN/cUr65LkXxTiqGKr0m2qcOVQReSICYH3a1YFonZ6RuwtdfQd4DeqeIGvJNU8lk
         arw9EI0zpIsMZBxy2GFjspH5c9J4PwWKwIZEbSkn+pluDxI4f7V2Lpqfibqnap+55asF
         AY8o3BhHY1iTXhViXwyBN3MlwoNJu6iGo0bMICZjeJghEBBWBn4KXpVnO6vx1YK9pXn9
         EwVaW7sSUx1JgJa4N6Z5N/9O5bP3zwaq/huBiT8AOEnHoH3IXWJET9BIaHInsa4NmqyR
         NeJBCeGHqi0j89Q8d49IoxMfL7CxBEggEqs2OL0Kwux7FH32/c0kzgXXrFyQmoHQICoR
         GnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817685; x=1792422485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AWiLDXPot0/+PbKR6u2nu/eRULx+LiAnb5d3+K32M2g=;
        b=v/fRvp66VBDiR9rmnR5Hn/bFT/Uc0Q+aKIaB4pngzvATDaApCFD0Kq8diAdOAZQ9kh
         DRTdW9W5GfzgopGFl569XGhpo7alrvbSriQVsnmOqsIpJV9ZuqFGXvAOgjXAA7rovtNd
         iPjY9hhrtSQIyKdcvqyZVSx7AHrr1A8fD7Myqvl2JRRSp8qR1ZIiP99b4GFYryXgeK2C
         LUa/1u1M0MfnfaED1876Gap2eOss+JfWT6kox1CRQ00u5pNlKMPEdF/fs0TCBmpM6FIC
         NnqOV4pXpxM+Gf8F5M/hDTzqRQ3eap6wzTRkP6Z201a8eVbIVxY9zjDJxm224TtI8cI6
         vMMw==
X-Forwarded-Encrypted: i=1; AKwUvBwCpTCJhPJvcEa58RpGEKNa/SEgoGf7DTGywnv8U/EwwIUl9lnMtBDXldpUM7jhq34BQYOxcTW5hvChmPRI@vger.kernel.org
X-Gm-Message-State: AFq9FYKLyYlKNCULQ8ObKZNaN4X60UuzNkPgK1um/5PxvTFCF81azjcC
	OxrkuAQtbsj9sxPfIpMaCrDKv93Vuu2faWUZ/nrM/7Iz1HdP7SsqsNEo
X-Gm-Gg: AYBFou0zG9w02jDofQcJXzGa8zv7ejzKJVgiAl0lJ5Zh8/laOuQs7qIZgAoJkoP+LCY
	ir8cOYSvaNi7dZGSd/ZrHINpkgCccgosWj8VGtXTy7mdi+P/BIw86m5pKL0rT91WYUxitO+lvn8
	tOZaok6vTTraU3ZkSBHCvJH2VcY2IQ4eX/uyLukySkroDB+kzYtnZDVwiD9BKQ7FB2xcpB2bcaY
	5ewPEnv+mBK4CYVBrAQCYRQxySQXR9ORKC7YJafwS+yFParCiun28kn7RAnC4RSNzJklViWYHhZ
	uNtiBq1wI/7rWHHoip8HQl26q5epOwJFfPREvilQm0j/o2+Jjn9pLZyIZU4NzAELKQMoqkSMz2b
	N+D4YCSa1mSjF+GtYd64sW04Oj7QN1z5tYxq5gkJ2+7YFSsG6TWmos+JFAHBNMpNpHpBsA8NLof
	ZJXJxEt8RgJ5logG64ItH3Vw8pVy/VoUCZ06vTkwX9niyB6MRj8QL1Lx5JpaT6IAdA/6MZAGc7K
	VGRVB8SUEap3SxcYpZ5HkkgASxz5FkL2nCzEZtckGct
X-Received: by 2002:a05:600c:8b70:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a18e4a174amr181863895e9.7.1791817685033;
        Mon, 12 Oct 2026 08:08:05 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm9916f8f.1.2026.10.12.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:08:04 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] livepatch: Fix races between stack check and module load/unload
Date: Mon, 12 Oct 2026 17:07:25 +0200
Message-ID: <20261012150758.207983-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012144933.GW2009045@noisy.programming.kicks-ass.net>
References: <20261012140546.154730-1-parri.andrea@gmail.com> <20261012144933.GW2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 12, 2026 at 04:49:33PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 12, 2026 at 04:05:45PM +0200, Andrea Parri wrote:
> > @@ -201,12 +202,16 @@ void klp_update_patch_state(struct task_struct *task)
> >  /*
> >   * Determine whether the given stack trace includes any references to a
> >   * to-be-patched or to-be-unpatched function.
> > + *
> > + * Must be called under rcu_read_lock(), see klp_check_stack().
> >   */
> >  static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
> >  				unsigned int nr_entries)
>
> As per always, I much prefer things like lockdep_assert_held() and
> __must_hold() over comments.

Makes sense.  For v2 I'll annotate klp_check_stack_func() with
__must_hold_shared(RCU) and add lockdep_assert_in_rcu_read_lock() there,
dropping the comment.  For klp_find_ops() the requirement is "klp_mutex
or RCU", which list_for_each_entry_rcu()'s lockdep condition already
checks under PROVE_RCU_LIST, so I'll just drop the comment there.

I'll wait a bit for comments from the livepatch folks before sending v2.

Thanks,
  Andrea
