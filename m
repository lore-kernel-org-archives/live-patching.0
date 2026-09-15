Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622743CE77
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514888; cv=none; b=QmocSfvDctGe3Gj0F1eHRYp5wvGpMI8jR2KpcZyUzoa/3ZDBDB8VIeN422S7OlouJ1jYA0ZIwIDBeWhG5rzYiGwbftpseEds5A2ryQCEQsXCybvUb328jd1r3MrTK0+8ik9ijerQMgwCkQZaHmyM694YZcEyhlIhPTBWoNFwC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514888; c=relaxed/simple;
	bh=p5li6YCdrlYRyDbdj26m9qWvlfHrYaeL5FmelQpo/PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHfsQjDeUqdkU0ftgh+JGNYr9jofcVja4S+XWAAGhBsgjVf0sdnlBP7LmrwTJ2Ad0EZxx8taJ1UMInu88SuQEIblSYrXW0QoqP2Y1VIiExFJXTMTS/JNWDqWxPOAGArh6VlIL4gTBXQ2ACqlZIngnjSTs6oFix5FrkpFwSuJayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMCOI7Pu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMCOI7Pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101C31F00898
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789514887;
	bh=hHDEypJSbV/BoGHDqqMgsWc+pHQcgZmCeL8Plv/fQAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aMCOI7PufeC7h/K3/cWpoG9MyF95NMakODWtN8+rqMQv2ISXfIcAeWYm/1MjnTzPU
	 294DI1H1vFFzZ/GDiiRf6LpB8/In88LnFG4zxzVeeevoMv8teBdo4/9B9iKpE+SOWx
	 9EGOvxVQB/tKGR3h+tNMehWQAvCsGRDKAHgkbR0HRfJKz3rqDZZKrOk9raE9mAMYWS
	 w8EBb59YRr0nDmAc853/QtTwPcp4vOGgpjoE3vhEYMWSVtPHkYXw9xjyCr693QFsgV
	 GrVUEsV+OFvOdjnoprNjFostOOASgiPLLI46OFzRqbOAJBW8aJtKX35ohacvy8+kT4
	 hBahcE+3oI0VA==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ca5aa7so36470485a.1
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 16:28:07 -0700 (PDT)
X-Gm-Message-State: AFuF++kEupjw33ifv9YXdGnXAVji92IuzBzi4oQ6VZJsawGi6jEd5W8x
	NSAJ82lIB8Sv047YFocHvC/Whv7HbMPvckA+7xGocS5jHlWtLo+KODkCJJaACEKjMyn3C6HUU2F
	3cLMOI4ao+/UWm69zFK2ViTaGlNBtHeg=
X-Received: by 2002:a05:620a:800e:b0:939:5c62:fddd with SMTP id
 af79cd13be357-93bb772cd8cmr75710985a.19.1789514886307; Tue, 15 Sep 2026
 16:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-41-song@kernel.org>
 <20260915002658.69B5C1F000FF@smtp.kernel.org>
In-Reply-To: <20260915002658.69B5C1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 16:27:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6jRSdtA2grJu_FYZpB3iuWakuX83SFWdLMJBKw_-bH3g@mail.gmail.com>
X-Gm-Features: AcwNN1U6r-BNOMPkZYIFN7X-tPFxM1l81_bVg9RT7NKoyDFGGgBoJZ13IMDR43k
Message-ID: <CAPhsuW6jRSdtA2grJu_FYZpB3iuWakuX83SFWdLMJBKw_-bH3g@mail.gmail.com>
Subject: Re: [PATCH v3 40/58] objtool/klp: Add test for __bug_table,
 __ex_table and __mcount_loc extraction
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, puranjay@kernel.org, jikos@kernel.org, 
	kernel-team@meta.com, peterz@infradead.org, jpoimboe@kernel.org, 
	joe.lawrence@redhat.com, mbenes@suse.cz, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool/klp: temp directory leak in test script loop
> --
>
> commit 9f7016f6d159ad52d6af43f36ec58a96806eaf3b
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Add test for __bug_table, __ex_table and __mcount_loc extrac=
tion
>
> This commit adds a test to verify the extraction of __bug_table, __ex_tab=
le,
> and __mcount_loc sections by klp diff. The test uses a hand-crafted speci=
al
> sections fixture. The test script repeatedly uses setup and cleanup to ru=
n diff
> checks for each section.
>
> > diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/o=
bjtool/tests/x86/test-special-sections.sh
> > new file mode 100755
> > index 0000000000000..8dfaa4fc9a360
> > --- /dev/null
> > +++ b/tools/objtool/tests/x86/test-special-sections.sh
> > @@ -0,0 +1,42 @@
>
> [ ... ]
>
> > +# section, entry size, relocations per entry
> > +for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; d=
o
> > +     set -- $spec
> > +     sec=3D$1
> > +
> > +     # A fresh workdir per section: run_diff caches its checksums.
> > +     setup
>
> [Severity: Medium]
> Will calling setup() inside this loop overwrite the $workdir variable wit=
h a
> new temporary directory without removing the old one?
>
> > +     build_pair special_sections.c \
> > +             -DSPECIAL_SEC=3D"\"$1\"" -DSPECIAL_ENTSIZE=3D"$2" -DSPECI=
AL_RELOCS=3D"$3"
> > +
> > +     assert_input_section "$sec"
> > +     run_diff
>
> [ ... ]
>
> > +     assert_not_patched other
> > +     assert_no_reloc_sym "$sec" other
> > +
> > +     cleanup
>
> [Severity: Medium]
> Does calling cleanup() here fail to remove the directory because it
> intentionally skips deletion until pass() or fail() sets KLP_TEST_REPORTE=
D?
>
> This appears to leave temporary directories in /tmp/ during successful ru=
ns
> and clutter stdout with spurious '# kept' messages.

Fold a fix into 10/58 in v4.

Thanks,
Song
