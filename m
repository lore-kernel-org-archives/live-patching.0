Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F31DA23
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780839066; cv=none; b=BJGaR9JVVCJpGwy+b85kdpVnvNe0wgg9/c1IAHSjBqSd0p1ztoOTaxidqR5GL9ywhuxfZAQDaP7pOIqpGypTDw8uMz9qMxVT15kpo/0BO0KJnecLH8UDRVyuVOWa8+L/k/In1ygBM6A+QhIug6eYJl0hcrTFuAyHknN0JaPpfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780839066; c=relaxed/simple;
	bh=PGPU10UEiIISZXfOQks5Xix3VpWEwskmh59ywyTwiSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLiJFSIJIM36YNz1EWlIhdlNMpqcs500pQNPjMo/9vvZTN6JAo7753BkrzWwPZSSP8+4K/5W7XyPem2QKLpUsiJCQtzQP0iGnh8S1bSDD/e+kjMCVV17QoOAosaM+P3rWy/xQ7bg2ltlQkrTtB1r6zhq3SxHsHdXoUroJ5YcUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/Gj/MP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/Gj/MP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADEE1F00893;
	Sun,  7 Jun 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780839065;
	bh=U9YH/iVCn+ijLvAiWUhWBKNjp1ZCRO052Tcrt+Kzozc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/Gj/MP2822Up0VsukLa3BPb79/2AnDRsWgXm3EC5ftJ0JHwz08C/jGHrk5a0CHad
	 Lx6OJMfdJtb2a1a6DPFPzILONAwKteZoKHkt7N25HqDSgzXQjCyyeYgzILFfbCmRol
	 FIj9e2SxbxrexHK110CQ8t3QhxtDH1amdm/f9KeBH9emWFrpkAYAYSMDG1eWljmPgA
	 Xa0HK5XNvl1Ehn7tpKd/jCPJYI5UkLBN9cbr5uQ7skctxH39l1XiCE4XvuFeyUePuo
	 Jr4n5w1OKTY5Y13bbWu7g2YeN88tNzJcgtDv51HfqLkynxAHyl5qbCQX2ZOnnHnoRm
	 P0p9yrBCFzyOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] livepatch: Deprecate stack_order
Reply-To: sashiko-reviews@lists.linux.dev
To: pmladek@suse.com, mbenes@suse.cz, jpoimboe@kernel.org, song@kernel.org, joe.lawrence@redhat.com, jikos@kernel.org
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>, Wardenjohn <zhangwarden@gmail.com>
In-Reply-To: <20260607131659.29281-5-laoar.shao@gmail.com>
References: <20260607131659.29281-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 13:31:04 +0000
Message-Id: <20260607133104.DADEE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Returning `-1` as the dummy value for the deprecated `stack_orde=
r` sysfs attribute risks breaking backward compatibility.
- [Low] Test coverage for the deprecated `stack_order` sysfs attribute was =
completely removed instead of being updated.
- [Low] The deprecated `stack_order` ABI documentation is placed in the wro=
ng directory and contains an outdated description.

Pre-existing issues:
- [High] A NULL pointer dereference occurs in `klp_find_func()` when verify=
ing patch compatibility with a malformed livepatch that omits `.old_name`.
--

commit ea264255177cd1b15e55c6d6aa2b21dbb4abd6c2
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Deprecate stack_order

stack_order is no longer needed for atomic-replace livepatches, as a
single function can only be modified by a unique replace_set.
To maintain backward compatibility, print a dummy value, as suggested by
sashiko-bot.

> diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documenta=
tion/ABI/removed/sysfs-kernel-livepatch
> new file mode 100644
> index 0000000000000..72c1ce0ea8647
> --- /dev/null
> +++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
> @@ -0,0 +1,9 @@
> +What:		/sys/kernel/livepatch/<patch>/stack_order
> +Date:		Jan 2025
> +KernelVersion:	6.14.0
> +Description:
> +		This attribute specifies the sequence in which live patch modules
> +		are applied to the system. If multiple live patches modify the same
> +		function, the implementation with the biggest 'stack_order' number
> +		is used, unless a transition is currently in progress.

[Severity: Low]
Is Documentation/ABI/removed/ the right place for this file since the
attribute is still present in the kernel?

According to Documentation/ABI/README, the removed/ directory is strictly
for interfaces that have been completely deleted. Since the attribute still
exists and returns a dummy value, should this be placed in obsolete/ instea=
d?

Also, should the description be updated to explain that the attribute is now
obsolete and just returns a dummy value, rather than claiming it specifies
the sequence in which live patch modules are applied?

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 361999e5ce3da..c73eccd2cd139 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
[ ... ]
> @@ -436,25 +436,11 @@ static ssize_t replace_set_show(struct kobject *kob=
j,
>  	return sysfs_emit(buf, "%u\n", patch->replace_set);
>  }
> =20
> +/* This interface is deprecated and will be removed in the next release =
*/
>  static ssize_t stack_order_show(struct kobject *kobj,
>  				struct kobj_attribute *attr, char *buf)
>  {
> -	struct klp_patch *patch, *this_patch;
> -	int stack_order =3D 0;
> -
> -	this_patch =3D container_of(kobj, struct klp_patch, kobj);
> -
> -	mutex_lock(&klp_mutex);
> -
> -	klp_for_each_patch(patch) {
> -		stack_order++;
> -		if (patch =3D=3D this_patch)
> -			break;
> -	}
> -
> -	mutex_unlock(&klp_mutex);
> -
> -	return sysfs_emit(buf, "%d\n", stack_order);
> +	return sysfs_emit(buf, "-1\n");

[Severity: Medium]
Will returning -1 break userspace tools that expect a non-negative integer
or parse this as unsigned?

The commit message mentions printing a dummy value to maintain backward
compatibility. Since the previous implementation returned a strictly positi=
ve
sequence (1, 2, ...), could we use a previously valid integer like 1 to
ensure older scripts don't fail when encountering a negative sign?

[Severity: High]
This isn't a bug introduced by this patch, but an earlier commit in this
series ("livepatch: Support scoped atomic replace using replace_set")
appears to introduce a NULL pointer dereference when a malformed patch
omits .old_name.

When klp_enable_patch() is called, it invokes klp_is_patch_compatible()
before klp_init_patch() validates that func->old_name is non-NULL.

The klp_is_patch_compatible() function passes unvalidated functions to
klp_find_func() as the old_func argument:

kernel/livepatch/state.c:klp_is_patch_compatible() {
    ...
    if (klp_find_func(old_obj, func))
        return false;
    ...
}

Inside klp_find_func(), old_func->old_name is unconditionally dereferenced
in the first argument to strcmp():

kernel/livepatch/core.h:klp_find_func() {
    ...
    if ((func->old_name && strcmp(old_func->old_name, func->old_name) =3D=
=3D 0) &&
    ...
}

Could this trigger a kernel panic during patch load?

> diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/test=
ing/selftests/livepatch/test-sysfs.sh
> index 58fe1d96997cd..0c31759f34f63 100755
> --- a/tools/testing/selftests/livepatch/test-sysfs.sh
> +++ b/tools/testing/selftests/livepatch/test-sysfs.sh
> @@ -21,8 +21,6 @@ check_sysfs_rights "$MOD_LIVEPATCH" "enabled" "-rw-r--r=
--"
>  check_sysfs_value  "$MOD_LIVEPATCH" "enabled" "1"
>  check_sysfs_rights "$MOD_LIVEPATCH" "force" "--w-------"
>  check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
> -check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
> -check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"

[Severity: Low]
Does removing these checks completely leave the deprecated attribute untest=
ed?

Since stack_order is intentionally kept to maintain backward compatibility,
should the test suite still verify its presence, correct permissions, and
the new dummy output? This would ensure future changes don't accidentally
remove the sysfs node before the deprecation period ends.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607131659.2928=
1-1-laoar.shao@gmail.com?part=3D4
