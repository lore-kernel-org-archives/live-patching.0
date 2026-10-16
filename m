Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686836F8EB
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136980; cv=pass; b=b6jyFk41V4W32lV2jvm6eqNQpabPMdboU+Re2fs0ufx3tnJAuxI5w/UF5EqOJcwPxHxrUcKODRZ5rRjFMpNqiEktEYDQJfZxCUbIL1FY+yjBBN3aJ6+IsvoBBtUY6cKk60Iyw0JoXuf60vhsY0LsMRiByFOQuNCWDDgSvz00/9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136980; c=relaxed/simple;
	bh=whnBvS+hjOpoEfJvISXHS2HkcWtJ/KX8D8iCC7vcpnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqT7ufsg7tsDnAGOtDfhrQr8Wy3/xznTnQ91F98DDUOJRH7tX5jha8seexjtQr0IkrRUjDjW6FGqBTciDtMbh2z6VPGtFZhTi3Hxu8g1wADZfCsbqyXIxXZmdubB2NXnDIDb5nOSf/yXmkfFglwnu3c2tbLehsSirCeWLZfehh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYV+Mar0; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYV+Mar0"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67921b515a7so6278364d50.2
        for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 00:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792136978; cv=none;
        d=google.com; s=arc-20260327;
        b=d0tYrInzfUPxkLhj6rUapCrrNv/D4BYQBOghxHBfUxgIW87yjsHCOV5d9nVIEmGh8M
         oAJMcmXm0B0yC5ylHnSqQvMfbfXnk+CgUl2oZBI19GGGwBqI9d3wb7io7E7nawdGl/LX
         bngZLgy2z065b21jNxdmMeBS8u58/H6Ks67zdIODzpH6s7CkOAGe8YY6wyIK/at3YpHm
         Ci8posueM7damxS1uGhdIm+v8L4OdZ7LgQYDN5Afa/OatKpUapCLvWnq2Yr6md6Ar3wo
         26aQpBxFCJUc8TDLb8XhMwRLuUNEMdRKhNKZ3vvwhkw4Z5zDTnwRVQP6g5QA0JmvwCtu
         0O/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=whnBvS+hjOpoEfJvISXHS2HkcWtJ/KX8D8iCC7vcpnY=;
        fh=fxaNbOHEYgY8folBC6ybVTAZovmf8ld41Qa4mShhF1A=;
        b=qIu+33aYTl45IWBNgAwIMaUSbfGF3nRukP9CBY2i9k40MlPAeBpS/gum+5kq5RN9IN
         c4KbAy6eLfZ3xda/sqIkMJyfbIAtulMp10UrumMwRJ/bmfw0+dSF8tQF6Xh4ILoYv3+N
         gtxSmPyCZszkW1QksMs9UaAJbji1CjszYczvbXlCjHrifQnauAjGExf0B0d2qQD/NK5T
         U8MzeM5IrXPyBHv3An1ZbRwaLocCf3VenryPjjQSXlB9XbzNR9y7Y0V0RRTHNlf+1CWG
         CLN9KAFgoN4RDpxYR5IlQLWu9ir+LGB//KoWNEFIv7i96HhFdjUyBs4MaxTZvocinW7u
         oPfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792136978; x=1792741778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=whnBvS+hjOpoEfJvISXHS2HkcWtJ/KX8D8iCC7vcpnY=;
        b=hYV+Mar08/6zgtNSNY2B34tJrSzqf9H3a5wIMiAIkM/31wPw+NXlw2Gb/eof1tW8cM
         ahAko7T/hARJA8QPjROcnRt2h6VW/HdhGUjRs+9aT8PiY93/mf1e/F00YoGomMwyogkO
         Ht0VGTP+t/auFbOx7WbCJq+9a9BFo4pfRsEC1lMca32W4WoHSbgL2ZxRxqnGjFzLptMq
         1lsZv4e1V/TMh18qCh0vWmpRyECSqDpwWbcKJM+lqVrz8BBhKExgzVqavuypkOXO0AYp
         iIbqSFWZPX8oPupKxduD35FAQjXXgNsmmyw/57d2mwL9O/Ph5zOK8qi383dpxB2MthS8
         i1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792136978; x=1792741778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=whnBvS+hjOpoEfJvISXHS2HkcWtJ/KX8D8iCC7vcpnY=;
        b=JxEDo5GCTOJ3975k/Z5wIyd4HQDmouKPF3Hq4Ttf6PchNgIxp55tFWAsYY7PwHj6Ci
         CXYieNQk8By2bCsIe6rkME/45qbt7zb4rQhpLUu2XoDiKlJgMNOWcsWTt0h08HyPlTzq
         NXGA9m67b+Svkm1WBnx/1rIbxRx5/Ljj6bjaHOyXA99oED3ZJDu0XmfH35M5wozmpKXj
         jm6eFN6Su2pz501lf1nq1apompD7An6CmVG+S6bGVW2B1ZwEEfIRMIaqSjU9b4rbkpUz
         qLPAJTw0opmlsegDPTqBHn3IsD8B8lScfk3l+Nf+m7UPRVWi8GPYxqWqjNrodMIwZpTr
         3ZdA==
X-Forwarded-Encrypted: i=1; AKwUvBzxUng7/1DIv11HzUDAF2i+/lLa6gJ4xb9r1A7mP+tjQ+hHUjbvCqdVTQKg+fHgisgXcZqLeDh1Ly4Zp/Z9@vger.kernel.org
X-Gm-Message-State: AFq9FYKlNErMvoOliPEUmYFFKAMV2KDPj946VwZUcA8BlB6XA1fn/hDy
	HG9YhZv5NCymuPXK90nxAVoVdIM2Swz2/aljv6GceqlsF2KFutRF+FJInytmaYzgBDaqrYsvpJU
	AQUf9Mn3+9CdIUC6am9lwk2oZfISEZcssVpfiNKU=
X-Gm-Gg: AYBFou2CAPDsvC9FBUNDr2vLSSsgtWTn5v7dqqbLXnVE0Txyom/Sm2390V/c9ALPXWb
	Gk+1s1eSdqUEH919KxOQbJvVg5TfJYJ78cf9puxGVow2zFg0fZx9QGCpYbxNXZyTc+8QTuPSDOZ
	qZAJAbib+plXQh85mf0KtpThYRlis9kbmqj/cd0L2SI4oDl2nJhkGsNceUTfgcavPclkjkwH7uu
	Yzhsk6mIrrqAJkjf2kCd9etSFCM8iKSAYTB2jKdail/I/3kIzawAjpD8nJT9xozYGJdGjiRSbhb
	Bsj+GxoWE6GBjS8e2qcjqe4DGREYKVD5urk+R5SMUeSXV6tle64EGmnwN5Y9B1cycdo1PK8Zm8S
	PQtbuEEDb/0UuYBfleTtpGQ==
X-Received: by 2002:a05:690e:140d:b0:679:9e90:a984 with SMTP id
 956f58d0204a3-6799e90ab65mr2165537d50.23.1792136978099; Fri, 16 Oct 2026
 00:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016053708.47089-1-laoar.shao@gmail.com> <20261016053708.47089-5-laoar.shao@gmail.com>
 <sashiko-outbox-173836@kernel.org>
In-Reply-To: <sashiko-outbox-173836@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 16 Oct 2026 15:49:01 +0800
X-Gm-Features: AclHuK-Cuns4kegDALmYjCUNXS0KVVlvLsygQavt2shzotEo_AKNDGRd0fdPKDY
Message-ID: <CALOAHbD5QQVEXpoy44G9voXTn6rz3u8E6n0ZRV5miwSf=9U_aQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/9] livepatch: Call klp_init_patch_early() earlier
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] livepatch: UAF on module unload if klp_is_patch_compatible() f=
ails with DEBUG_KOBJECT_RELEASE

This pre-existing issue has already been fixed in the for-next branch. [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatchi=
ng.git/commit/?id=3D7f4ca0d0b40ac1ccd82ebaf1514c2d26c3db71c4

--=20
Regards
Yafang
