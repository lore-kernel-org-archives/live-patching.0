Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4D356778
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419896; cv=none; b=gXs1QIXktwD2mrwOsG6XoXqP8yF46Hk+bCaTqQbZBqFNsr7MM8/RrqjeumfymUZEQfEXOmF3+HRTMQpRzGifukeOA0vJL71pbm0OEVgey5MLgmRDT+/vslVukhyija67kb4Gmc9eCTytFfhixDEVZcq5+8XvDc+sZf0ZCb5SrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419896; c=relaxed/simple;
	bh=1bA1WDzta09dsLb4d6SRynILoG7UePYi/H8rpBW3Qo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCej2s+gluFZV+5aO9ZNOUrjAur5ut8AOr+NQz8EuqyoRYqf8NzXD2mg88jMjORNepQxALTYikfOkCqrdRuWKE6BmxMNeWlrlGxXLDTB4M1QpOk8f4JWF/F2hTuYtlsaCG4JTyWVe/Yjd1m7YMk1t+gjg20QvZx0HEdhnivFHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWn+ZKp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWn+ZKp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E551D1F0089B
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789419894;
	bh=1bA1WDzta09dsLb4d6SRynILoG7UePYi/H8rpBW3Qo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EWn+ZKp63pXU2pvUiAdWv9jHIyjzUfyCgCV4+/v34pL0DuYTHgKDtelcWd/WtG7U4
	 CtvXLP5phI6SETAbZv+1bjPK8Kch1I4WemYIzNJbqR2rKn2vS2gYwpf7ilMh8cEOd/
	 epKWiRv1Xm4eidMYaovQoDN6Dnz94mWR9jpNbhJulY7kfreGTTIvwRr8O+2KI2/wNm
	 qhuSTlEqVMNF4E508DgSudfLoLd/SNma5SqDlxyZTYHkBZX6tjnwGIUCKZC0NX4gyb
	 QBp3z+WWuX8Icu5JojffkesO9YTMa9txNWbG6O5g8P4S8oOSWVHlNXedeJih0L+zKT
	 tWy5j/6AFpEkA==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a135ffb08so260382985a.2
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 14:04:54 -0700 (PDT)
X-Gm-Message-State: AFuF++lTIWdCKYWdmqK0lxp7pmy4n+O3SX4VPFytVel06Qtg3jQnpqvb
	i1y5D8wPFiV5j3FpWX/MhWZgu3FgzfLU8yElAj51nixpCcXgkEKbq5avcP9jFx9rEZJySTypYY+
	mr49kcEd310DyijFKIzMZx7Pr6MYSyiA=
X-Received: by 2002:a05:620a:1a06:b0:939:e71c:7740 with SMTP id
 af79cd13be357-93a294c304emr654245785a.0.1789419894154; Mon, 14 Sep 2026
 14:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-33-song@kernel.org>
 <20260914064509.D4D941F000FF@smtp.kernel.org>
In-Reply-To: <20260914064509.D4D941F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 14:04:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7tHh5Y=ekvi8NLE3JSnE2iheL39ER2raxDBkGJekcnsQ@mail.gmail.com>
X-Gm-Features: AcwNN1XN8C_IKoftckqYVe7le-VbrMS9Fi17sToJybmPuvgrzFQKsP87m-XSg3M
Message-ID: <CAPhsuW7tHh5Y=ekvi8NLE3JSnE2iheL39ER2raxDBkGJekcnsQ@mail.gmail.com>
Subject: Re: [PATCH v2 32/58] objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES
 references
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, puranjay@kernel.org, 
	joe.lawrence@redhat.com, jikos@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:45=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The test script claims to cover commit d8a2860b4a36 but fails =
to exercise its logic because it patches vmlinux instead of a module.
> --
>
> commit 0018f6f310cd6d22138d9d2b74d24fb1f9be4ab3
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES references
>
> This commit adds a test script to verify klp relocations for symbols
> exported with EXPORT_SYMBOL_FOR_MODULES(). The test aims to cover the
> behavior of previous fixes related to klp relocation section naming.
>
> > diff --git a/tools/objtool/tests/generic/test-export-symbol-for-modules=
.sh b/tools/objtool/tests/generic/test-export-symbol-for-modules.sh
> > new file mode 100755
> > index 0000000000000..7e7bdde6a7aca
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-export-symbol-for-modules.sh
> > @@ -0,0 +1,39 @@
> > +#!/bin/bash
>
> [ ... ]
>
> > +. "$(dirname "$0")/../lib.sh"
> > +
> > +setup
> > +build_pair cross_module.c
>
> [Severity: Medium]
> Does this test actually exercise the module-patching case fixed in
> d8a2860b4a36?
>
> By calling build_pair without a -DMODNAME flag, the test fixture defaults=
 to
> patching vmlinux. Because the patched object is vmlinux, the
> __klp_relocs.vmlinux section is generated regardless of the logic introdu=
ced
> in d8a2860b4a36.
>
> That commit forces the section to vmlinux when the target is a vmlinux
> symbol, overriding the patched module's name. As a result of patching
> vmlinux directly here, the test appears to pass even without the fix it
> claims to cover.
>
> Should this test pass a module name to build_pair to properly test the mo=
dule
> relocation behavior?

Good catch! Fixed in v3.

Song
