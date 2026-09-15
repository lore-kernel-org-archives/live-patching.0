Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EA457E67
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505487; cv=none; b=Z7ACiUUzCsRN8gJ42WRxi64eOpnnT26Z+ZAoNhoD+qN9cjE0CDFP0/0UqtL4c60yp+L7CsFQLcIe+dMdGnZN5B3XPy8t+Bj645zR4UqWaR8V037l6V8Pe7YnIgQIFUtnCfAkPkXlQSooMk3AeRMdfd5x+ANCPUpO2D4YbGgG718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505487; c=relaxed/simple;
	bh=2RXqOYieXd+8ZLmjTfgu5R7hxsEobeAouElKzLhAGgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ6j5N3yeLjjBRJu8xsDOa78jWt9Wan3hIXRO4eadaR2IyV3MqLCY7DV2AnZL3sENQZSJzttYymkpOa+wqufP2gbINENiumHcgkl15hZ3iqrIUg5PeBEKG89vqfsaiL3EtuSHuMpO+NSsZqO95egl2LukTTruRX9gBvXBrmLWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0vWLLhp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0vWLLhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA07B1F00898
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789505482;
	bh=dQ7z3jw4gIsa59H3q6RnOlgfe0BtyVJNdMswSwd6YzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l0vWLLhpwlCddrnQfV1c7ZWRYPDfmPJndCW6EZSoaRq4FeZfxMlgCdGqCY5EXZPpy
	 ODiajgzGHBNqJ+VME7HUfVzzxFQh3GiBn8gDwDjLYthXQyjtH3yobCDPzCyz64xRZm
	 NLeHjaYWM9iQ4c0+RmphJW0i1jEScJ/jInFnNutWiwlyhGuUC+cNGmMz5qMJhC54Te
	 xV9Tl0az3HzYaCrIRVZPZ8mWhJR4avrjIngiio2j3Gf98sdbTaVlN2FtLIANuACEdc
	 miknfccg8dW/uwRfU2Ml7owrRen0drd4n+jaocwYXYuyvPxgytkgDiYEKzcJGxEQtx
	 hd0DxCLD0Sg5A==
Received: by mail-qk2-f38.google.com with SMTP id af79cd13be357-939109fafddso17944685a.0
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 13:51:22 -0700 (PDT)
X-Gm-Message-State: AFuF++kTFL7cR9Vkqs/owe7WziQ6t/damY+oX8dAN7xGpnk0VG4LkWY6
	x/AjJoQPk8+rA70uMycDEsfKLdRadDqaRjjqLzOUHJtOd1JNyA5mKwy9nLGd1PzlDz1htVBcIEM
	JGaXvYmRxUqsoCw08BJLvuGr8bGCzirY=
X-Received: by 2002:a05:620a:684a:b0:93a:14c3:72c2 with SMTP id
 af79cd13be357-93a299fbebdmr1300524385a.29.1789505482074; Tue, 15 Sep 2026
 13:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-8-song@kernel.org>
 <20260914233453.0FEEB1F000FF@smtp.kernel.org>
In-Reply-To: <20260914233453.0FEEB1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 13:51:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7B1nLU61j=js_nKQn5ctkk6Hk6aAF3uVNgPNvLSespgQ@mail.gmail.com>
X-Gm-Features: AcwNN1U79izZ3klTIp1OkhxlL_rKxbSY9XDT_fP-M0KZS3k48kljgiRjDwxRqsM
Message-ID: <CAPhsuW7B1nLU61j=js_nKQn5ctkk6Hk6aAF3uVNgPNvLSespgQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/58] objtool/klp: Give each run one working
 directory, one per test inside it
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, kernel-team@meta.com, jpoimboe@kernel.org, 
	jikos@kernel.org, joe.lawrence@redhat.com, mbenes@suse.cz, 
	peterz@infradead.org, puranjay@kernel.org, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:34=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool/klp: test harness leaks top-level tmpdir on interrupt
> --
>
> commit e3c2fe244875e7154ea4380414b6732281ba9cd6
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Give each run one working directory, one per test inside it
>
> Each test made its own mktemp directory, so a run scattered them through
> /tmp among everything else using the same names, and there was no way to
> inspect what a failing test built -- the objects are gone the moment it
> exits, which is right every time but the one that matters.
>
> Give the run one directory and each test a subdirectory of it, named for
> the test and nested the way the source is.
>
> > diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run=
-tests.sh
> > index 6b937fc7f5bda..e6f1ac1b5d0da 100755
> > --- a/tools/objtool/tests/run-tests.sh
> > +++ b/tools/objtool/tests/run-tests.sh
> [ ... ]
> > @@ -98,12 +103,18 @@ else
> >       done
> >  fi
> >
> > +# One directory for the whole run, one per test inside it, mirroring t=
he
> > +# source layout.  A run then leaves a single thing behind instead of 3=
9
> > +# scattered among everything else using mktemp.
> > +rundir=3D"$(mktemp -d "${TMPDIR:-/tmp}/klp-tests.XXXXXXXX")" ||
> > +     { echo "Bail out! cannot create a working directory" >&2; exit 1;=
 }
> > +
>
> [Severity: Medium]
> Could this leak the top-level temporary directory if the test suite is ab=
orted
> with a shell signal like SIGINT?
>
> Since there is no trap registered for shell signals or EXIT, an abnormal
> termination will bypass the cleanup logic at the end of the script.
>
> [ ... ]
> > @@ -156,4 +167,15 @@ done
> >  echo "# pass:$pass fail:$fail static-skip:$static_skip" \
> >       "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
> >
> > +# A failure is the one time the objects matter, and by default they ar=
e
> > +# already gone.  Say so then rather than in the usage text nobody read=
s while
> > +# something is broken.
> > +if [ -n "${KLP_TEST_KEEP:-}" ]; then
> > +     echo "# working directories kept in $rundir -- inspect, then rm -=
rf it"
> > +elif ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
>
> [Severity: Medium]
> Will this cleanup logic be completely bypassed if the script exits early =
due
> to an interrupt?
>
> Setting a trap could ensure this directory removal runs even when the scr=
ipt
> terminates abnormally.

We will add a trap to 10/58 in v4, where we make some other changes to
the cleanup logic.

Thanks,
Song
