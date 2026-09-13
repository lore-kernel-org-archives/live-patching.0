Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8C2C21D9
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267698; cv=none; b=NxqTe8Xvt6M03cE7ELy10zhu5d/9jhNx590zHpAWOAu3ApUcf6sZO7LK8aJwVU72ZPiNsNpoFSAfaR+XImRRXd0g8ccFvhWbaP/kZFyDIGYzuGGH76Z8l1tn49DDkivXBl98t/MeoEIWaAaUFMkNz6SEiJbY3nxtcF2qZMOja7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267698; c=relaxed/simple;
	bh=HzKb/cSIkXUXwECfvm9rOApB18mZEa3JUDtAwlV9G+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NAmbS3jhNvKv5ieehH4a1mcx5jN/RO+YlnFUx4Lqzmt6Bezy8Fx1rvJAp3yUc3drhCOUAY7V1+Lt9EtZzIdvLZSdgV9ESRjctwBfPt/+AnDmSnqGjInGObdPV6qwxtuh1kmfmY0IT/BHPTZfurpuuMxhjZqApjp/TnWlybzKeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a29X3zAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a29X3zAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6DE1F00893;
	Sun, 13 Sep 2026 02:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267697;
	bh=r6EbI/kSYABfQgLuQEVYiiuHc09DNL2oCJ7mhJEW0oE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a29X3zAR9ZHsTQcUyGlZtiIyrl7qcUn2gN6MIbKKyw97NoHQp6SaCJwRC2d87lalh
	 eEkckc2OqeFQ907QgoadDjiUSuiG0r0Jsn6PmhhZ4t1mQeGFNaWwNR0kPbwlNo5EYY
	 lQNBp26u17YMnR1xYthAjuW70CoDPAbmn7jb/IT0j7kT5t2AYTPLQMGLd6VG2GwfZE
	 scRqi4R3T+tIEeSSC7Ax0cDstHSp9NUGUObfzCgtEmHwZWHu/S5u7uEzJoCChkAB+A
	 jF7uWsnOMiMwTtzhp0YbLDQ4no8o+LAzaGqiur+jFBewR3piO0bHBLkMVoVfg3gTfX
	 hqMoRaXefn+LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/9] livepatch: Deprecate stack_order
Reply-To: sashiko-reviews@lists.linux.dev
To: song@kernel.org, mbenes@suse.cz, pmladek@suse.com, jikos@kernel.org, jpoimboe@kernel.org, "Yafang
 Shao" <laoar.shao@gmail.com>, joe.lawrence@redhat.com
Cc: live-patching@vger.kernel.org, Wardenjohn <zhangwarden@gmail.com>
In-Reply-To: <20260913024228.72317-7-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
 <20260913024228.72317-7-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:48:16 +0000
Message-Id: <20260913024817.2A6DE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch removes the 'stack_order' sysfs attribute from the kernel=
 but does not remove the corresponding test code from the livepatch selftes=
ts, leaving a block of dead test code.
--

commit a8f748fc5d239275aee15cc15603ad2749191463
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Deprecate stack_order

The stack_order sysfs attribute was added to determine which active
livepatch is used for a given function. It is no longer needed because
recent changes refuse loading another livepatch which would modify
an already livepatched function unless the new livepatch would replace
the conflicting one.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 8813f035087de..a5ff34a377a57 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -477,40 +476,17 @@ static ssize_t obsoletes_show(struct kobject *kobj,
>  	return len;
>  }
> =20
> -static ssize_t stack_order_show(struct kobject *kobj,
> -				struct kobj_attribute *attr, char *buf)
> -{
[ ... ]
> -}
> -
>  static struct kobj_attribute enabled_kobj_attr =3D __ATTR_RW(enabled);
>  static struct kobj_attribute transition_kobj_attr =3D __ATTR_RO(transiti=
on);
>  static struct kobj_attribute force_kobj_attr =3D __ATTR_WO(force);
>  static struct kobj_attribute provides_kobj_attr =3D __ATTR_RO(provides);
>  static struct kobj_attribute obsoletes_kobj_attr =3D __ATTR_RO(obsoletes=
);
> -static struct kobj_attribute stack_order_kobj_attr =3D __ATTR_RO(stack_o=
rder);
>  static struct attribute *klp_patch_attrs[] =3D {
>  	&enabled_kobj_attr.attr,
>  	&transition_kobj_attr.attr,
>  	&force_kobj_attr.attr,
>  	&provides_kobj_attr.attr,
>  	&obsoletes_kobj_attr.attr,
> -	&stack_order_kobj_attr.attr,
>  	NULL
>  };

[Severity: Low]
Since the stack_order sysfs attribute is being removed, should the
corresponding test code in tools/testing/selftests/livepatch/test-sysfs.sh
be removed as well?

Because the test script checks for the existence of the sysfs attribute
before testing it, the dead code will not cause the test to fail. However,
it leaves behind blocks that will never execute:

tools/testing/selftests/livepatch/test-sysfs.sh:sysfs test() {
    ...
    if does_sysfs_exist "$MOD_LIVEPATCH" "stack_order"; then
        check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
        check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
        HAS_STACK_ORDER_ATTR=3D1
    fi
    ...
}

Which leaves the following test block permanently dead:

tools/testing/selftests/livepatch/test-sysfs.sh:sysfs test stack_order valu=
e() {
    ...
    if [[ "$HAS_STACK_ORDER_ATTR" =3D=3D "1" ]]; then
        start_test "sysfs test stack_order value"

        load_lp $MOD_LIVEPATCH

        check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913024228.7231=
7-1-laoar.shao@gmail.com?part=3D6
