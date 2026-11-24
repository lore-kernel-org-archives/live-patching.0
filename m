Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795492853;
	b=lLeixErNTUJmIYCuUElbs0dby/GnQTrEbXzO1l6p+6mEEuKEpdRfGoKmDhbNXCfFcCte
	 NYAdhDs9YhcyStE64kFd2qRwRF1oQAzCAVXBCOJaPFiZDMaYSox6+DhuYg0RzYWD/AwA0
	 sLn8tYRhAm+upOx9L3+tu2RihXmN51EAPWHXFhhj15a24VZh16nTXepZG0hoJ4lhYxxkI
	 0UdjENmMlgz7p13gbQfOOAflzwYWshJ6HCwxmqAM4g1+q4XnBPzbju1rP75ENm/vwanqG
	 Ys5ERBt2oW0tNYebDTPzD3DBjk4u96T0Nv81HHR2E+44BvJTVlQ/qZYDMXcrtMxkEsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795492853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
	b=AMU2Hw+GXtLd/Bs7Oo96nujWLDlO+EJIvESksVo6k31ZgM069IF4AFS8nkxW+K1NjrFx
	 ZK5Zxcj9Q8xOhcF5BPhaPIVO2pkxBF5Wt36WpxYH00P9h49DV0N4UR7qLcitVamflM0Ng
	 6GAnhILVaHRkO+940gOzlKuQCt2S1EHSAz0Hl7zQcFtOKCPEMgPHPFE/MfUDYwGLFsnwH
	 wlYd+5rmAGU3gViChPVSrMty7n8KN5EXD1LRhnWL/bP5hVLyla9Md1z5TZ9t2Z6jmP4Uw
	 gARq/WCe9mKKws8rrzETrYuiJB9O7PkwdqnjL6yCgCjbeHZ9C1uQ8ZUCo/VKIwNRpgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJydpIHZ;
	arc=fail smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DAE606A31E
	for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 04:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53DAE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJydpIHZ
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67db763cec7so4183657d50.1
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 20:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795492852; cv=none;
        d=google.com; s=arc-20260327;
        b=ob7XGD/1RnuUppXg3Pxcc1iuswYI1CEx7dIHNjWOVyiPeqVyGovoawtLlvalIizmdo
         YcawpAkeb74tSEL3FAIKPeZkYebJrYuokxElydq5yRgODoB/kZt7gwgWt8hss75KJgVz
         ETKAt0HBYJd2OYs2jKYQpOrYRmymd74gDppCj6tuOsa64O2TADAjMB+PLrHfWtM7tvRf
         zhE5H0rY+412+EBWT7yFRbscYSOvaUvj7PM3o9nWjSy0UlrZJvPB4Il+Ar/iIY7uZL2x
         1CZKp8B4QX9Yi6HSkD1B7hcaVsKSwYIXDPvbg70Q+7KpbXlHQdFNxMpCkfqR3RaMZO+9
         uErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
        fh=Cofr57AyoucVx73vLf69hWLBNEyNZKHewVJPaZp+Ifs=;
        b=qlqwNpNpVjCKY4i8LXsN6y9+ISb4Fuh7JN/BNzMdRVoRVJOwVloTDmKOSO0Y2ajlqX
         UM9o3fVidO6QCeXteJ0nrNhT9Mjls9a2ff0fWq8j+dYO7FjORgDGuOg9l/QNMO+9FMXI
         c7AkJLG5o2swnWsz6DuzHVFYDadMBbT0+Xbjq+yauf61yyXSg/BKAKiWSKUnIpvmseDG
         IooZZ1rX+jFKsXWpkoWoV8gBN4IpNHA31KbmozhwaGyjYJ/vRJCepVWsOSudOjh04b8Y
         e4LqKEwOqUdlavlZpBZbgVgvBqEl/e1ewyABluxH9v2RgujMfbnJHRktTuPHJQX0yKD+
         7BTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795492852; x=1796097652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
        b=pJydpIHZC+jgHMbGbpKTWCLHhOdsM07+l+r6Iur+1AhfH/oT988kwuWHphDXcip7/P
         cbRY9NEZIDjPm9AyosZX+sPvzjMrSZfr3OB+obOF2BcguyJL/e85jRu80yQge87IhNEV
         Pw5EtxwHAzUjKkh/1GENQ/1oXtMjOQo0ePqUidxQzhHZpuBboxaYE8e5Eof4XStZLPV+
         n4mJUPW412DeDIJ1zU0Hoct2/PlcexBGHDsxWGY01pkoS2/2OhMKIlICdZWKVWSh374T
         MRegLkHQLpWoA90n2Guv5NgKnEq40qd7n3BG22dlg0/MPsg5LP8t4ZYEG1zJdPvSu9jm
         Idtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795492852; x=1796097652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
        b=2dwCYE+oRlKHPxWA1u6HHsBLsmFwMRMorxJ/HkFHMYJy6GLZ8FeSy8QQvbriejAjac
         5c4Lqd5/ucK931v9ZnNQHgCAOaNoXNZojTBHpn7ZgD7IwBRS1z59n5d7GZOl1Lg0S/du
         JH3h74Yk8nYzRvhEtlXlUferaQUpC55pC2JgUKGrB2KS+ROxY1fpebmkxXkujiMiOFKC
         m16a+rrj5dq/6GjqRlh8l+ZsodHP5CaLqbgfzK8tK92ADrUc6CRiQbIGiazux3klADtx
         m/l4+K9zJCEH0uuRiWGtZTy/hqe4NaYIVknshcoRdI2wbvjfpBKf9sbVBnu+/Y7SGpkD
         1CVg==
X-Forwarded-Encrypted: i=1; AL+hErGzCJW59aFEDlvgXH8XIEF/g5jLZZZPJR4nnT5b42XsId+aDZhgzgljE5Ns8NkJ4bjvPeDW2nMIR3q3SSD+@vger.kernel.org
X-Gm-Message-State: APuU4Z/3chfkDi98XoSHSrjjAgz4CF+teauonMz8hWheOyUhzMHLivHS
	a3I0Zz6LHlJ1i459Oxbfq02+2OAmgxYjTmYjb/J2mlxXl9zEizWoNS2fVyeSCa37sOjBhAAQiIk
	tDd1LF5ONCs4oJ9AVJLNgEbEZf681jiI=
X-Gm-Gg: AZFdTZfjFkd+Gl7kZKDuK6tLvEvhLbFYuPygu2Ec12RXu8Yz/OoIC4Voc68q1OEpbNF
	2jQKQZwyA7bcXCXQJcQoJz2LUyJ2ObSix/cK0kAZQFGSAMpfTa+PHm+7pdV6FIW/FC/8/O+whXt
	x6ffubiX+ouMvhGHgummY3hKBAaPsXK4Dtsq2QQDuT5a7mNY7Q3kxwvkkqSnIFivcx0uSUDscKl
	T1qWMfMDb5S95+q2LBnJCJ7Tk5UvjeskO4hkAVYLqPkLlOJWzAZv2KV8cNlsAw5NmYGsG4YGPY4
	31hbCdTwtErq3jwYyMszRpPs36Rbx7WGYzpln9DYjAA2ACo6BPrTjgDe6xZX6WRgQar8fR4gbH0
	hD0LymBedP2eCnTevzdzSJQ4fIKobB5WdNii9v2r3tCgVWVV84i0MKSGGPOI5+SpG3k4=
X-Received: by 2002:a05:690e:4813:b0:67c:1907:922c with SMTP id
 956f58d0204a3-67df44257d7mr2356677d50.44.1795492852350; Mon, 23 Nov 2026
 20:00:52 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu> <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
In-Reply-To: <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 24 Nov 2026 12:00:13 +0800
X-Gm-Features: Aa3M54q7s3VMxk7FJweeUn3luJjDb4P7LcCfNfajJc0izoqcRUVhUDIdY_OqAjc
Message-ID: <CALOAHbDu5NmVowk4SHzeUDxASaxKkbL_w1dModFWzdi8yK9tBw@mail.gmail.com>
Subject: Re: [PATCH 0/2] livepatch: Do not lose exiting tasks during a transition
To: "Ravindran, Binoy" <binoy@vt.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:40=E2=80=AFAM Ravindran, Binoy <binoy@vt.edu> wro=
te:
>

Hello Ravindran,

Thanks for driving this fix.

>
> The two issues Sashiko reported on patch 2 are valid:
>
> 1. An exiting task that has not been unhashed is on both the task list
>    and an exit list, so klp_start_transition() can visit it twice and
>    set TIF_PATCH_PENDING again after it has switched.
>
> 2. Between exit_tasks_rcu_finish() and its final switch, an exiting
>    task is on neither list and can still enter patched code with a
>    stale patch_state.

We also discussed this issue at the thread:

   https://lore.kernel.org/live-patching/CALOAHbA9WHPjeZKUcUkwULagQjTMfqAdA=
g+akqPzbZ7Byc=3Dqrw@mail.gmail.com/

and Josh suggested something along the lines of what you are proposing,

  https://lore.kernel.org/live-patching/20250124010848.pdcxokfsk2ngrowl@jpo=
imboe/

I did not take it for the same reason Sashiko raised in issue 2: the
RCU exit list narrows the race window but does not close it.
I could not see how klp_synchronize_transition(), as you describe
below, completely resolves it. Could you please explain that in
detail?

>
> v2 will walk the exit lists under tasklist_lock and skip tasks that are
> still hashed, so each task is visited exactly once. It will also call
> klp_synchronize_transition() before func->transition is set and before
> completion, to wait out tasks in that last stretch. It will document
> rtp_exit_cursor as well.
>
> I'll post v2 after testing it on mainline. Please hold off on
> reviewing v1.


--=20
Regards
Yafang
