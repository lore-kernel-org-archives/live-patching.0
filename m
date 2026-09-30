Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6C4E4C38
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777524; cv=none; b=DAyoyxOkI+nwswHwhwLRUdObPjRQrFbDV36KkaRxEt8WaM87ztE4/IUbdC+nNZLZfzI2puu8Kgox6XlHcaYx2ycHZE/8Y2gVaWO00mEVbExvGYKuX9A5pw/JNDMwQ9pQksFmAqycNDM9tVCGAsJEr5j8KfvGOkJZwOvXUVMYR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777524; c=relaxed/simple;
	bh=j35vEpIPMoY28tuw8z89btjkr+NCLOZ/6D4QTxytxCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdjBmrL4rgtQPxyTc/OOMqPeJG2m9jDB621z6yNhAvZIAcTG7Qm47br8rNC1lko1ktJDz1V9eoJ/YbFvxpiSXvUWWF4nADzXoWJOfSdJACvxrB7Xf4of+pcMxV3I69zJAl4sj8ZW4/c94eO6dLii4OXoP5vtZY4MKn88+NVfJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcPsC064; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcPsC064"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881d9da69b1so1331633b3a.0
        for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777498; x=1791382298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZD5Wk2pVEzvLwEM+dw1Nh8s2zTNtUbkNWimSe6i9Hnc=;
        b=lcPsC064BTceT5wRuKF64Z4IBo4BirDhMITw+WPxU8RRgpTXq4aqbDkrd7qmNq2Rcr
         ezRAICh6//tiKucpKYwid6kRgpgce7656JsKFEfD7pOL4bIMqcJe7F/9Owd/Myd+v9au
         f12Y5IAFWUjk3d7PogxqWxPCgG5Tlj5O9E1wWnjEmN2BIcbAhHM1E5nHiSUY9aG1OhRm
         6dujQ9CIrolq55/FrstNzg4IxIXCwJbiSiG63DEQrTcqvymG3AZj++0pPJJ37s6ub6Ph
         lcW/OO1QMQIKBqG18CNNeulOrsXKb1mpIt5hgg3I3i4IRQ/W1kvMHwO9C1LLQZZa6dHU
         5FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777498; x=1791382298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZD5Wk2pVEzvLwEM+dw1Nh8s2zTNtUbkNWimSe6i9Hnc=;
        b=voZHNwLTvxhG5K0LXP//2EnA6ylfxqpuLJN1Uh/6cBB+07YodJaOd5ncDWrcgj/FWS
         sHXT/wg+opD46+7bgT1VkA4kV4c0XWbhv8w+KEe5uKRyHemZ9PL7lr0vizl0X3B3GKg/
         KfI+xWcAXboJA/wpu9fBNtZOyu3hCRaHZ9WGkhNIOFdDECZRtU0bdSWRmJ71554Vtt3j
         /ZZVRY/0+9BZHsC2HCSoMSc9wqKrpi2gJK5eQgHVrFizvxXCAaG1tJ6anKNOVn5kbPBk
         3/A6a/PVCDL2PeLslE/G98/wZK8t9Az56k5Jzo2SJcsZgCzMCG97F33M0ZQcDEEwiw+6
         vPkw==
X-Forwarded-Encrypted: i=1; AKwUvBx6SHNrU0PEZqNaCR7t5ps8OCNqzpiDGseNIsbANBR4+c65mVxPU+zxNiEa2/sCl6VQHByBdQoeDjiMD+dy@vger.kernel.org
X-Gm-Message-State: AFuF++kHl89eIEawee2frUp3KmXZ+05/BWVlX/E7zYTcI3QqTkepZIiE
	dVrCsrols/r2m65Bipw/ncMfVdUH6FJs+tSe+9NVONh3JE5XslozeAVf
X-Gm-Gg: AYBFou2dFrU3+eJNm0RmUlUZmjw1se2RkFBN9PtTNwJ9cD0tDu5TqJWcsHY4GqzWcnC
	lMSPofVLVcHVY8WyhDKrqNFlLatg4mPm7apSY3+8i1uH0hbhpYPiGVlNfySA5Lo+faqcD9+CM+p
	oUAOu378Ohve4+OUQjBXFEwXE3OrgkX3JB5CpdOrkk81PDH/VBK2Xg9nhsFRsEc15w61/b/niU3
	Kh9HLUksJvlrPfyqRSXEQWdUYfVEnZQnsX89kVOKAqAUMuX0LMxQHf48h33RnUCzE5xhMM3pYYL
	SdWesawuchhmtNr9MBlg7KsfzU5epekKRRANpB1WzaKOpKnD8kjlZUKNrTnsA7cXqPU0Fmsi7Kd
	BE0R+WVhOECbIxd0Sn48Qa6MPfNw0kCMOXJ+iJioDVasvftfMz2Avoxd555PF8t7oWhKAebPaMg
	aZ3ivC0cRdORAb+RkjRijKKkWR0SEHA4byKEUB9mBVvE0Q7/CbkOGYZ0cAJ0vsRVvmPCjLwQJeo
	wDRbw6jIfogdDyMH3HiCB5THFXyxtbnH8e0MKUQ/zetQ9JFaOCZ3b4zzu4+00q3I2+0wl8gCA==
X-Received: by 2002:a05:6a00:1d93:b0:87c:9094:b72d with SMTP id d2e1a72fcca58-8874980140dmr1107172b3a.6.1790777497986;
        Wed, 30 Sep 2026 07:11:37 -0700 (PDT)
Received: from lima-arm64-dev.hitronhub.home (180-176-144-38.dynamic.kbronet.com.tw. [180.176.144.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88726c0c243sm916905b3a.58.2026.09.30.07.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:11:37 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: mbenes@suse.cz,
	pmladek@suse.com
Cc: jikos@kernel.org,
	joe.lawrence@redhat.com,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	shuah@kernel.org,
	song@kernel.org,
	x90613@gmail.com
Subject: Re: [PATCH v4 1/3] livepatch: Fail object initialization on duplicate patched function
Date: Wed, 30 Sep 2026 22:11:32 +0800
Message-ID: <20260930141132.373715-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <alpine.LSU.2.21.2609181452160.21788@pobox.suse.cz>
References: <alpine.LSU.2.21.2609181452160.21788@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for catching this.

I've updated the duplicate-address check in klp_init_object_loaded() to
only reject the pair when both klp_funcs are nops:

    if (prev_func->old_func == func->old_func) {
            if (prev_func->nop && func->nop)
                    continue;
            pr_err(...);
            return -EINVAL;
    }

nops added by klp_add_nops() for two replaced aliases are
interchangeable. Both just fall through to the original function, so
allowing that combination fixes exactly the scenario you described: an
atomic replace patch that inherits nops for __do_sys_fork and
__x64_sys_fork from two separate previous patches will now load fine.

The check still rejects two non-nop funcs that resolve to the same
address, since that's still genuinely ambiguous. It also still rejects
a non-nop func colliding with an auto-generated nop for its alias.
klp_add_nops() always appends nops after the explicitly-listed funcs,
and klp_patch_func() always pushes new entries onto the head of
ops->func_stack, so allowing that combination would let the nop
silently land on top and disable the real replacement instead of
failing loudly.

Petr, do you have any further changes on your side for this series?
And once this fix gets an Ack, would you like me to send v5, or would
it be more convenient for you to fold my commit in and send it
together with yours? Happy to go either way, just let me know what
works best for you.

Harry
