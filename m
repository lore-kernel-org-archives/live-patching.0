Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A873AA9EF
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939083; cv=pass; b=H4LS34Wc6H/6m9P3hPqeHNcP1/Wk5U184hxdWSpEtZa+ZHeam8iI2IwwoWXXSgGHSd8H+uhzvY1iARenY54kzOZIp0aa9dpYJ25WyAdoWsIx+DjJ4sQXAXQC+sob+9rrKt2dOSMSK/5K79MRjoTf/RrQ3KY6GgBQPnxcbVEA3kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939083; c=relaxed/simple;
	bh=p5yzCPStQZlFYqWgsz/tWvBj/3blYllpwvjlsk3DA2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQMRGZ2TcuiTMxv3aGrzuS4jx8PL6Vyydd/nt8+/meFOo1e6doLtgstD2bOfffhUt5IhyTx4y6USGztbTzc1+qqkK1wUdki2Dc9P8RvWeMsMRU3Vtw9T2eyGKPoUKmCx0wFuoynL1PXiioFKuO+7UkpYeVPsaZCKO99odZEwiNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eml8NDlN; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eml8NDlN"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcbso6734117b3.0
        for <live-patching@vger.kernel.org>; Wed, 09 Sep 2026 00:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788939081; cv=none;
        d=google.com; s=arc-20260327;
        b=lhyp290qpowD34Niusb6G74jveprR6u9DWXAlmmi2dlpw+DYOM/keShEUjiHR6IxQw
         3LZkL5yWkvGrZI9jp8D27zSQQFDC5QwnxDfA0PUVBtW1EY9j7SMnHLeu9HQWOzHeQZd6
         QYSTEkF7Ctk7YQZL7vUAlHb7d7EM7P7FDwJn+xWKjEdjd3mgWeemx0RIgDoD2ax0bzvZ
         T8hh+hXGFl3VnGARXEsx32VNIrNhMJTyv3mpDffY37Gnt/npl2SUsX6y2xJiQTDTuZFv
         NZA5titpXgkbkrwDSRs2u+OSfSCm0u7s7J0UlzNe2GTdNaUg9b9qcejL12hkfsQfRNyy
         ywhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zR3F/9DDyLDml5HLZtlb3GBYAZ72/4f2Si1r92K3OLs=;
        fh=xAS8kwPmABbk6Q5k+pYnsr0tjST8GNS5uuHTnn4FkjA=;
        b=N/dSVttOewRFQburltkv99lyzo0nNllRqSd1v1HFjCxYXjK71oeC+bvBBpVaNPTTkr
         T1x4GTjNIYz/4POXn2PnctRtTyG3EIZCq5mYobbfWciE3QCkkR+A4JamJiwJdtXVD+sw
         189FKdqbauIvE7GoOCiwsFH9pZJObj5ohpZgQULw271/8zs9sBHQWWQ84e6Xamw2UegJ
         YJTYi77ZM8Xt805OQTRujA5RV84k9q779QdqDTDBqxbf0tWVZD9cvhrqL1lMhHuec/8G
         yDkVp1b1Kf1yALNFHJdg/OUULYgEkmDEexOpXkylef0Drzt+Gqw3Ayqvgc8IMQ7ZSpy0
         INww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788939081; x=1789543881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zR3F/9DDyLDml5HLZtlb3GBYAZ72/4f2Si1r92K3OLs=;
        b=eml8NDlNHReTLC2vk9SpOjs1JVB9xUuuiqBhJkeiNKoF6PzL8rFCiVXYg0ja999H7C
         pqYTNX6JLtUJl67NMBDVdAdJSbwjBjy6kYrjcFSCrzkSCRdJ9vXBdRv5/tRHqNoCDSJy
         pr5lZbLMoo3XAAGvHsTB2S/fVxT2KBP9q2dsPgEn80TIpEf9sii0TIOXBOFhdmnaCDPe
         lTCCXB6HFnEpPnCJbX2y83DkcCVZisNN+0H2MXblmyADUHzajomygkkMbwyCo+ioLaPN
         tpGQ2YZ+e4T3krH47UGh4/1LwHDWD+/D4wEYHj+qq2Xg3y1LQgNo4C8ycE2ZivhtJkYc
         P3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939081; x=1789543881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zR3F/9DDyLDml5HLZtlb3GBYAZ72/4f2Si1r92K3OLs=;
        b=G4yhY1OfuWEIypx4ngY42vTUFsjlPOqePDUuYLpHGFMKS+dNSWo+TwIfN/0J04K5Cp
         gdOc88YXYdj0dcg4xG8DdY9vmAz9jiFd/GRjlqYuX0vdK3ITzQ8afbsloRAQDvcNb4oc
         MgPB43+iY+f6yN8PZWn2GKyvRtTbX6/l/BOYsxfZFzf8Nn7p53bjFjyyv+NCE8M+bZ0H
         0rmopHDL/r610P+lBvOFzKeYHkDwVjxoLY3jSJP2dpo2J057PHBZXOKNNe4HRBSi3cvx
         LO6fPO297ZqlxrVUhNFFlbWFQ49LNrSgN2jFpOb39xUPzHYiHU2cSJmmtetZl4hTH70X
         sFgw==
X-Forwarded-Encrypted: i=1; AKwUvByoqNDTIRGiDSAOfZtOVaOKby20COAqjHwtwMeEQONr5wAw/Uec2uztLfHWPj+uQaX0fv4VnuhYgU1muWvt@vger.kernel.org
X-Gm-Message-State: AFuF++l9N9tPwgUjuad1WoWNyRYzseQy1awjvJcnfYX0jtiP8hDLntNl
	k/fjss1BE8ny4FkxJEDI0Ja91lv5/Y+ZMBfR4toF+J+8ULifcXtnnFm5QIgEpqWrveA7XhP0dbb
	eaPjHgiQc9eLCPH2Pfg/ka+t2G4TqL88g7CvnSH8=
X-Gm-Gg: AYBFou2PhnNUC/MeXdQAJMcMIZuQZlW4aaeuQ//fDevW5ZwPPGW20uh0BEL/PTu5Qcj
	As8z6oLcLwN0YUZyGrPBMUu7OFgwq/AYAJrwsTKAltnnqEyk7oObhp8GCxqne60TUMHnVHozdBO
	XAH4kHtcKxZR7uIPF+til0lrqQHclmkzNR/2sSFruR3lCFJGfRY4hVyI0+aGyVYy9iXhQa4zwiH
	ryR4DBwLhwedp1/aSwFiyfN7ZcnufpE83+MpbCf8oIlSBmijDIWqfpyENOTnqfRKeQyBNjc4zQO
	ES4Hgh3yxp8Yis0lc2RDpmb20e0pdukn8dpoFCmMtbXJDmDzlK1s6sHLoYtVpK2GGSY/hukGva+
	Xxn9xz+XaHLjOo8RVI6nAUAA=
X-Received: by 2002:a05:690c:e691:10b0:81e:6bd6:39a5 with SMTP id
 00721157ae682-87f22b7f1f5mr17134887b3.1.1788939080568; Wed, 09 Sep 2026
 00:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024324.16002-1-laoar.shao@gmail.com> <20260909024324.16002-9-laoar.shao@gmail.com>
 <20260909025756.19AEF1F00A3A@smtp.kernel.org>
In-Reply-To: <20260909025756.19AEF1F00A3A@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 9 Sep 2026 15:30:43 +0800
X-Gm-Features: AcwNN1WlnXUbKH1a-V5kY1yknsJbl7P2Fl8izGKWXaQQ2vwTHlxZ-sqwJ_vAplE
Message-ID: <CALOAHbAft8tOO4H-Zo2tnDH1xP+u-QnKeTN3ofSngr2cK_7b=w@mail.gmail.com>
Subject: Re: [PATCH v8 8/9] selftests/livepatch: Add state test for provides/obsoletes
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, song@kernel.org, pmladek@suse.com, mbenes@suse.cz, 
	jikos@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:57=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] Unloading independent livepatches in FIFO order permanently al=
ters the global `console_loglevel`.
> - [Medium] Mutable module parameter 'state' causes a memory leak and fail=
ure to restore kernel state if modified via sysfs after load.
> - [Low] Missing sysfs value verification in test 'misc states, misc provi=
des'.
> --
>
> commit 253fd167cb01a1b8aeead3420135a4b275836ef3
> Author: Yafang Shao <laoar.shao@gmail.com>
> Subject: selftests/livepatch: Add state test for provides/obsoletes
>
> This commit adds `provides` and `obsoletes` module parameters to
> `test_klp_state` and `test_klp_state2` selftests. It introduces testing
> coverage to ensure that reusing a state ID across different provides IDs
> is rejected, while it is allowed when the new livepatch obsoletes the old
> one.
>
> > diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.=
sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > index c2fbac3d0e06f..8b7b5eded80c7 100755
> > --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> [ ... ]
> > @@ -213,4 +215,238 @@ livepatch: '$MOD_CMDLINE': unpatching complete
> [ ... ]
> > +# - load two livepatches with different provides ids (provides=3D1 and
> > +#   provides=3D2) that modify different system states (state=3D1 and
> > +#   state=3D2). Neither of them replaces the other, because their
> > +#   provides ids differ (and the obsoletes lists are empty), so they
> > +#   can coexist.
> > +# - verify the provides sysfs value of both livepatches
> > +# - disable and unload both livepatches
> > +
> > +start_test "misc states, misc provides"
> > +
> > +load_lp $MOD_STATE state=3D1 provides=3D1
> > +load_lp $MOD_STATE2 state=3D2 provides=3D2
> > +
>
> [Severity: Low]
> The test documentation states it will "verify the provides sysfs value of=
 both
> livepatches". Is this verification missing here before we disable and unl=
oad
> them?

will update it

--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -404,6 +404,9 @@ start_test "misc states, misc provides"
 load_lp $MOD_STATE state=3D1 provides=3D1
 load_lp $MOD_STATE2 state=3D2 provides=3D2

+check_sysfs_value "$MOD_STATE" "provides" "1"
+check_sysfs_value "$MOD_STATE2" "provides" "2"
+
 disable_lp $MOD_STATE
 unload_lp $MOD_STATE
 disable_lp $MOD_STATE2

>
> > +disable_lp $MOD_STATE
> > +unload_lp $MOD_STATE
> > +disable_lp $MOD_STATE2
> > +unload_lp $MOD_STATE2
>
> [Severity: Medium]
> Does unloading these livepatches in FIFO order permanently alter the glob=
al
> console_loglevel?
>
> If MOD_STATE saves the original loglevel and sets it to 15, and then
> MOD_STATE2 saves 15 and sets it to 15, wouldn't unloading MOD_STATE first
> restore the original loglevel, only for unloading MOD_STATE2 to subsequen=
tly
> overwrite it with 15? Should the teardown be LIFO to properly unwind the
> loglevel changes?

Ah, it should be LIFO
I will update it.

>
> > +
> > +check_result "% insmod test_modules/$MOD_STATE.ko state=3D1 provides=
=3D1
> [ ... ]
> > diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_st=
ate.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> > index 5c5872ff25665..1de63c2438d68 100644
> > --- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> > +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> > @@ -9,10 +9,25 @@
> >  #include <linux/printk.h>
> >  #include <linux/livepatch.h>
> >
> > -#define CONSOLE_LOGLEVEL_STATE 1
> >  /* Version 1 does not support migration. */
> >  #define CONSOLE_LOGLEVEL_STATE_VERSION 1
> >
> > +static unsigned int state =3D 1;
> > +module_param(state, uint, 0644);
>
> [Severity: Medium]
> Could this mutable module parameter cause a memory leak and failure to re=
store
> the kernel state if modified via sysfs after load?
>
> Since the permissions are set to 0644, if root modifies the state paramet=
er
> while the livepatch is loaded, subsequent callbacks like free_loglevel_st=
ate()
> using klp_get_state(&patch, state) will return NULL. Does this silently s=
kip
> cleanup (kfree) and state restoration during patch unload?
>
> This same issue also applies to test_klp_state2.c.

will change it to 0444 to fix it.

--=20
Regards
Yafang
