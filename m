Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74C381AE0
	for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196901; cv=pass; b=LoQ7jowrgCRlcb1xCX6XEcANbvSJxtJQ3zpNi5fetLk7ADyaqJ8/57lvuQtvJ4/Ho2OyM1YI7yfU/hBK/ZT5FKJHgVSqnvSOhuJJTGqqdvV5YQud2GTHa5cn8y+xVU8rbkxsafocRsPkIh05lRMNguZeB59C2fQJ/Ex5CJKYRvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196901; c=relaxed/simple;
	bh=re/VEJZBjY3EHqDMA966LgExFndcX848uoDoLCeDhpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXc042BOLJ9TGqoyrIz/3Ud6srPS4htZdUuZa77sCRiLN993+u/XQ1bs4IJCaT1a7beAjJUnq04tXpEIVtem3WR3i9dLHubph/zlPy3isxKRRvh6GRfRtZ5YUysG/kHGfBkSL6yy4wQnaIoEiWpn8nQv5tvaTEMiC8jgiKVoLp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZBaZrL1; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZBaZrL1"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836c436a6b3so27116967b3.0
        for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 20:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787196899; cv=none;
        d=google.com; s=arc-20260327;
        b=Wk5nrARPDkxWKUpfwwWGrE/c2iyUXrxhx9DbeLxpsN0Clt6sfrYRXV7li6to1+uCos
         /gVNb0Tx0fogTIH3RVXqFZ2IWGY/4AzbeLWeJcXUtzfZITmuoOwatdMo8TPwhqnRCDGK
         GWW6sXI2g4M2RTctu018Dt/sWaCuiPGyDYxNarxTNTJeBHQqff0G+ZZHskg/Z8jjhkZo
         I70S9jwLAsiMmp6COOjl19gjklOCUQxX5LZOu8Gc864varuQB256ndg51wgUYK94PoE6
         fMy6yXNBPTgwsoN50UK8QtS008aDPW5gCa/xHPYNeihMzn/cr7b7LC0h5McRVF0pddi7
         NQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9y62XQj2WlZxnn6J30KkZuG9xRhqGPsJo8zmRqauiok=;
        fh=1qzyR/EiiGFamg5AjSH9GjRmHIFxvTHFKNOwvnTTTvk=;
        b=Wn84ivY15nh/lLkVsP39S7mLV081hvquyZ0TarowuFk6v8v0i6Zuos+5/uXmj0SeTe
         VWL6I6eobsJD9IRqnnLtuHw5wPtMi1prCDArJtmsCEBDec0rn3uQix7aKx5l7Uwuwhrd
         LlCm3zwPhsT6oHFoGO42KzxKrwn5xUaUE+9JrVCOiKNvpIJ83rxr75noMMf5C0j6ECMG
         bhhddlDaAwfzaJDyR++gE2MGT8ahLPxStoZ/FKe8VbnA4GbYOVaVDIrApfavyoE7MRt7
         WigBQ7y7uBW+Gtz+jm7Ze+PKH0t3dZ+rA26CFLnMALTIadWUazXzknZqQtqgSSYSimrH
         O5WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787196899; x=1787801699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9y62XQj2WlZxnn6J30KkZuG9xRhqGPsJo8zmRqauiok=;
        b=YZBaZrL1RVjeppzrvvKlcgf1my7WOilp8Njg/JaJJjrfWCNwSc4ZG2YYCRw8iHLANk
         bKzkFNsEucqlNKS9Y6v3TVH7/v0XADOLWN6DhtvhSBgIkBMlPYLRYx+vjRtmUeNFS5rU
         6vQVsiMFLy5THEIwS2UN5/CCHKFRrwtLHNiTiionKQz2x3zm8i4z5ZCahWExKBZQk5ZA
         FH1XHRAc5l05oisZdZyBXWcAxPMgEiXxWeHbGBO9Qjj1v4Pr8bVzLsAaODEshC+4WU16
         tkSXub3qMi3A4AYST/8VDrr0Fuvl61mPGofR+GxuM1N4GH8NQjaMi1juKNiAXJF6Evs3
         vYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787196899; x=1787801699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9y62XQj2WlZxnn6J30KkZuG9xRhqGPsJo8zmRqauiok=;
        b=NCBu6uHpxJuRzGCWC7pZU/dJtCW0/JGHyHbw/9/FocuTpUnnzReyTLtHX+88dOmcDb
         uark1WRAlWMfEWKPcrv7uHisVwGSyQqThdZtCQE/P2mhZmzPCaVm6QVnxPMku90MYXz6
         ezaQz4GrDQThAqmI8khc6ZYiVIFmEVvNbs7geTX4cB4u4oxST7AEiqSQc+5c2H1Qz9GC
         MBTkNW2Kq0Ts55/e1iv6pINOmRrjDD5zFtGeLyOJD2eORvXLN5+R+6MFfiMRDDTB1DMc
         l3UvSSbsnKQp5JGixhhj8MDM8vcpsArVrQFmFSih9LyQuk32lV/W4t5ulotJIRByBXeQ
         TntQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1ovmKR1zILXWFP2IVIIK7Z2PE/bwrDXd7ooRrgah9tqrqI4e6sjFGhLXqhuxuAST65a77usWZsTZwQFuV@vger.kernel.org
X-Gm-Message-State: AFuF++lMvUouZ+LS7KHqK7OTO3tGBQrWaejUwj0ZuNBEbLu4fMhxS4DV
	rVtgN6h0WPk+i73JYCQHQlk0a8TjuaJ0CjUO5aypINBYaPL1UJh7lqXg6IMoVEQ7j5U8t/4o1hc
	ELp71x8uKcvdoHaTpCN81N2mwhdemBIg=
X-Gm-Gg: AR+sD100DnP8WFQomhb3cQjeP5MK30YtZfOM5uXF22cHbELFgmnEAZKg4JCYro/4WWs
	xERYYjG925g6UoS2d9Ou2yoTCXxW6aQbpY2+sl+PKDWiyzqU6nlBsPYcqB8ATWXtxoBt1oOa+Cv
	GrfzBLJfjFGfTvjrS/u24cQAwCu4GVS7t1hLfsuO+qvCElnncIASqzdOnkJtQA5Y3ewUgOC6d6f
	LdlpsItN7wSkJSefjhZz8LXyYpyO52m2J+0QjVlDIsJdFztXOTOy6xMvdZpgN1X5XW0her7tNq+
	BQvSgOkhD0dt34zFLdXKDKWId07R+PQKgBCs8yr3ozp0aScGp5Iug3JC4EJJx1Ji4OcMc3YIkOm
	EzA==
X-Received: by 2002:a05:690c:e289:10b0:841:8f97:e8cb with SMTP id
 00721157ae682-844e378e04emr33015157b3.17.1787196898607; Wed, 19 Aug 2026
 20:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818054629.69246-1-laoar.shao@gmail.com> <aoWvidB12l4oPIdK@pathway.suse.cz>
In-Reply-To: <aoWvidB12l4oPIdK@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 20 Aug 2026 11:34:22 +0800
X-Gm-Features: AcwNN1Wf_yGXi7FI070s1NOuz-P3Rlnifl4dZdvgBr-4ElNuwz2jfmSd53VgJSc
Message-ID: <CALOAHbCFt2H6CZ0Y0FJJ9+yHFDNkrKKHk5Y_c6JnArXQhaEj1A@mail.gmail.com>
Subject: Re: [PATCH] selftests: livepatch: filter kobject debug messages in check_result()
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 9:28=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2026-08-18 13:46:29, Yafang Shao wrote:
> > CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env()=
,
> > fill_kobj_path() and friends emit pr_debug() messages, and
> > CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
> > for every delayed kobject free.  All of these carry the "kobject:"
> > prefix via pr_fmt(), e.g.:
> >
> >   kobject: 'test_klp_livepatch' (ffff...): kobject_release, parent ... =
(delayed N)
>
> Yeah, this is pr_info() printed only when CONFIG_DEBUG_KOBJECT_RELEASE en=
abled.
>
> >   kobject: 'test_klp_livepatch' (ffff...): kobject_add_internal: parent=
: 'module', set: 'module'
>
> This one seems to be printed by pr_debug(). It is printed
> with CONFIG_DEBUG_KOBJECT but only when CONFIG_DYNAMIC_DEBUG
> is not enabled.
>
> > The livepatch test modules' kobjects are named "test_klp_*", so these
> > lines match the check_result() grep for "test_klp" and leak into the
> > result.  The extra lines no longer match the expected output, so the
> > selftests fail when either debug config is enabled.
> >
> > Filter out the "kobject:" lines from the result and note in the README
> > that both configs are safe to keep enabled.
>
> Honestly, I do not feel comfortable with this ignore-all-kobject-messages
> approach. We might miss real problems reported by the kobject API.
>
> It seems acceptable to ignore the quite specific "kobject: .*parent.*
> (delayed" pattern.

These messages are printed using pr_info:

  pr_info("'%s' (%p): %s, parent %p (delayed %ld)\n",
      kobject_name(kobj), kobj, __func__, kobj->parent, delay);

In addition to the specific "kobject: .*parent.*(delayed" pattern,
several other pr_debug messages are also produced.
For example:

# --- expected
# +++ result
# @@ -1,7 +1,13 @@
#  % insmod test_modules/test_klp_livepatch.ko
# +kobject: 'test_klp_livepatch' (000000009dbf565e):
kobject_add_internal: parent: 'module', set: 'module'
# +kobject: 'holders' (00000000d9fe84ca): kobject_add_internal:
parent: 'test_klp_livepatch', set: '<NULL>'
# +kobject: 'test_klp_livepatch' (00000000dcae1113):
kobject_add_internal: parent: 'livepatch', set: '<NULL>'
# +kobject: 'vmlinux' (000000007b8837e6): kobject_add_internal:
parent: 'test_klp_livepatch', set: '<NULL>'
#  livepatch: enabling patch 'test_klp_livepatch'
#  livepatch: 'test_klp_livepatch': initializing patching transition
#  livepatch: 'test_klp_livepatch': starting patching transition
# +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
# +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path:
path =3D '/module/test_klp_livepatch'
#  livepatch: 'test_klp_livepatch': completing patching transition
#  livepatch: 'test_klp_livepatch': patching complete
#  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
# @@ -9,4 +15,15 @@ livepatch: 'test_klp_livepatch': initial
#  livepatch: 'test_klp_livepatch': starting unpatching transition
#  livepatch: 'test_klp_livepatch': completing unpatching transition
#  livepatch: 'test_klp_livepatch': unpatching complete
# +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_cleanup,
parent 00000000f8785d63
# +kobject: 'test_klp_livepatch' (00000000dcae1113): auto cleanup kobject_d=
el
# +kobject: 'test_klp_livepatch' (00000000dcae1113): calling ktype release
# +kobject: 'test_klp_livepatch': free name
#  % rmmod test_klp_livepatch
# +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_cleanup,
parent 0000000052e5c022
# +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup kobject_d=
el
# +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup 'remove' =
event
# +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
# +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path:
path =3D '/module/test_klp_livepatch'
# +kobject: 'test_klp_livepatch' (000000009dbf565e): calling ktype release
# +kobject: 'test_klp_livepatch': free name

>
> But I would prefer to ignore the other debug messages by detecting
> the KERN_DEBUG loglevel. It seems that dmesg even allows to filter
> the output on its own. It is a bit ugly because we want all
> other loglevels but:
>
>    dmesg --level=3Dinfo,notice,warn,err,crit,alert,emerg
>
> might do the job.

The following issues will occur:

# --- expected
# +++ result
# @@ -1,12 +1,8 @@
#  % insmod test_modules/test_klp_livepatch.ko
#  livepatch: enabling patch 'test_klp_livepatch'
# -livepatch: 'test_klp_livepatch': initializing patching transition
#  livepatch: 'test_klp_livepatch': starting patching transition
# -livepatch: 'test_klp_livepatch': completing patching transition
#  livepatch: 'test_klp_livepatch': patching complete
#  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
# -livepatch: 'test_klp_livepatch': initializing unpatching transition
#  livepatch: 'test_klp_livepatch': starting unpatching transition
# -livepatch: 'test_klp_livepatch': completing unpatching transition
#  livepatch: 'test_klp_livepatch': unpatching complete
#  % rmmod test_klp_livepatch

This is because these messages are emitted using pr_debug:

  pr_debug("'%s': initializing %s transition\n", patch->mod->name,
      klp_target_state =3D=3D KLP_TRANSITION_PATCHED ? "patching" : "unpatc=
hing");

   pr_debug("'%s': completing %s transition\n",
       klp_transition_patch->mod->name,
       klp_target_state =3D=3D KLP_TRANSITION_PATCHED ? "patching" : "unpat=
ching");

In summary, we need to filter out the pr_info messages from kobject
while retaining the pr_debug messages from livepatch.
Therefore, the following change should address this:

diff --git a/tools/testing/selftests/livepatch/functions.sh
b/tools/testing/selftests/livepatch/functions.sh
index 46991a029f7c..54789fae8055 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -300,9 +300,9 @@ function start_test {
        # find new kernel messages since the test started.
        local last_dmesg_msg=3D"livepatch kselftest timestamp: $(date
--rfc-3339=3Dns)"
        log "$last_dmesg_msg"
-       loop_until 'dmesg | grep -q "$last_dmesg_msg"' ||
+       loop_until 'dmesg --raw | grep -q "$last_dmesg_msg"' ||
                die "buffer busy? can't find canary dmesg message:
$last_dmesg_msg"
-       LAST_DMESG=3D$(dmesg | grep "$last_dmesg_msg")
+       LAST_DMESG=3D$(dmesg --raw | grep "$last_dmesg_msg")

        echo -n "TEST: $test ... "
        log "=3D=3D=3D=3D=3D TEST: $test =3D=3D=3D=3D=3D"
@@ -318,9 +318,12 @@ function check_result {
        # - include lines matching keywords
        # - exclude lines matching keywords
        # - filter out dmesg timestamp prefixes
-       result=3D$(dmesg | awk -v last_dmesg=3D"$LAST_DMESG" 'p; $0 =3D=3D
last_dmesg { p=3D1 }' | \
+       result=3D$(dmesg --raw | \
+                awk -v last_dmesg=3D"$LAST_DMESG" 'p { if ($0 !~ /^<7>/
|| $0 ~ /livepatch:/) print; next } $0 =3D=3D last_dmesg { p =3D 1 }' | \
                 grep -e 'livepatch:' -e 'test_klp' | \
                 grep -v '\(tainting\|taints\) kernel' | \
+                grep -v 'kobject: .*parent.*(delayed' | \
+                sed 's/^<[0-9]*>//' | \
                 sed 's/^\[[ 0-9.]*\] //' | \
                 sed 's/^\[[ ]*[CT][0-9]*\] //')

--=20
Regards
Yafang
