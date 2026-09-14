Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1033F44CD
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419316; cv=none; b=mRIcaWBaFtK6r3b5T2ZjDp0dYgjAQ0BCw+aiuk1STN7Ci6r4OTqYT2bVygmB7hjgtjjYK5riBKOzjt1izLXHs4ccIjBDSMw7tA8vXT79u9Buv2TU+ZylRWLM3Qm3L4KXVZgiIhkSlCJrazSltKPkt/RHYwGoNvIdAeEoR2HwMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419316; c=relaxed/simple;
	bh=8E7atf4YfYzQLMasJoiWHOnQRlBrufJewgMVbTUtEHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgcknkF6U+f3iAaH/MemAEV2ox1Xmc11irb2dK3O3tkYwxwX+ZwlH833TKW/tLJh/f0sG46YKp1spmOkm5WKF06D4PgVS0wlAKPJF1ow9kHESTsbPUSIm24YDP52ST6RmFBAf6zkOsr3KVt7Q4piHY/vZIqqf88GmzxrFKSlIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpk4jMEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpk4jMEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72CE1F00898
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789419314;
	bh=4ebf7YRHG/0h2NTh+FNZdL9/q1jcOd1htKo5h1HP4c0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cpk4jMEfnoZoLorOXnAJfj1JGNPyWrlXvMg4MMMBh3mpKGvkyf8gG/b/MU53V9Iw2
	 j/s2/GbIOxFc0zW165ycT9B6yXN9rUUgz3rrWyHH+S6NfpmDaDaMK2Th2lehrFE+3p
	 YBzXJgep1SW1DSA8J20dR4BXzm2XiYSqzMhh2AI3F5/ajAmw2XL0+pBWcvU2nK2IX8
	 AfLBQBeA+y1zOv715rRRgBE2HybI9QWK0O9LHCqboZIeItIeN7WWb5sptwkiAlmi+Y
	 eb4cbVAR04wiAa39LmNvVHM91FbWVyk2BWebQbnDBvM+Q6z1hGl+BhVjFQ636Hf1uM
	 umwPVW6mjYGng==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd7so252877285a.2
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 13:55:14 -0700 (PDT)
X-Gm-Message-State: AFuF++nFdfVpcSa+PPY6u/lOaf1K8fLxRsxYOXQy1bG4f1Wgx5f8G751
	jPEb9JkmymgvMTNj0Mce6P/OWsQHKMUWByTXVzkXqa6S4mWuA1PLc4ApnXnnx64NkUDPaA/kYJg
	uy0x/ZCz7SDBtC28NjGTelwMleo93fGA=
X-Received: by 2002:a05:620a:2a08:b0:939:5ae7:2dad with SMTP id
 af79cd13be357-93a29b94250mr643123885a.38.1789419313952; Mon, 14 Sep 2026
 13:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-17-song@kernel.org>
 <20260914063833.0F9951F000FF@smtp.kernel.org>
In-Reply-To: <20260914063833.0F9951F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 13:55:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW75MKDc93c=Ufi-Y3jcJj15Ox-yCUTjGGA9aU7sWO=Dmw@mail.gmail.com>
X-Gm-Features: AcwNN1WYAIJvb5G2MV2Veg9DIhsYGx0W0pvPyHkucKe4B44qmQQ3RQhiUlu68XY
Message-ID: <CAPhsuW75MKDc93c=Ufi-Y3jcJj15Ox-yCUTjGGA9aU7sWO=Dmw@mail.gmail.com>
Subject: Re: [PATCH v2 16/58] objtool/klp: Add test for cold function halves
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, puranjay@kernel.org, peterz@infradead.org, 
	joe.lawrence@redhat.com, pmladek@suse.com, mbenes@suse.cz, jikos@kernel.org, 
	kernel-team@meta.com, jpoimboe@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The test assertion for the carried cold function incorrectly p=
asses with `llvm-readelf` when the cold half is left behind.
> --
>
> commit a04e65cdf7036d7ab3a10a22fc0efb8a0c3873bd
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> objtool/klp: Add test for cold function halves
>
> The compiler splits unlikely code into a separate foo.cold symbol. Both
> halves are the same function and both belong in the livepatch. This adds
> a test to ensure cold paths branching into unpatched code are handled.
>
> > diff --git a/tools/objtool/tests/generic/test-cold-function.sh b/tools/=
objtool/tests/generic/test-cold-function.sh
> > new file mode 100755
> > index 0000000000000..dd4a7297af044
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-cold-function.sh
>
> [ ... ]
>
> > +assert_patched target
> > +# Not a bare name match: had the cold half been left behind, the branc=
h to
> > +# it would appear as an undefined .klp.sym.vmlinux.target.cold, whose =
name
> > +# contains the one being looked for.  Require a defined symbol.
> > +out_symbols | awk '$7 !=3D "UND" && $8 ~ /target\.cold/ { found =3D 1 =
}
> > +     END { exit !found }' ||
> > +     fail "cold half was not carried into the patch"
>
> [Severity: Medium]
> Will this awk script correctly detect missing cold halves when the test i=
s
> run with llvm-readelf?
>
> When the cold half is left behind, klp diff converts unresolved reference=
s
> into SHN_LIVEPATCH symbols. llvm-readelf formats these as:
>
> OS[0xff20] .klp.sym.vmlinux.target.cold,0
>
> Because there is no space between the section name and the symbol name in
> this output format, $7 evaluates to "OS[0xff20]" (which is not "UND") and=
 $8
> matches the /target\.cold/ regex.
>
> Does this condition evaluate to true and cause the test to falsely pass w=
hen
> the cold half is actually left behind?

Seems to be an issue introduced in v2. Fixing it in v3.

Thanks,
Song
