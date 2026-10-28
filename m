Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206015;
	b=kNSQ7WV6qN0K3E2lDiFoIy6WQW/6DptMnp0zOMvcNfNsaENrIrstskCalt8WZSgsU8W/
	 BE84XFd24z9AoUyyfddZl8U3al4Ta+iSUcszApZA5PB+qZya1NU7FmtISA+unuRsiWV6Q
	 UQ6iWCTU3Waqqo0QTePSpWgeD+lG1s5GHce5rqeLtJOE6B5fyLOmW1xIf8gs+F8jEdpxN
	 VxKWe7a22FoAWg60DAjLTWo9p7/1xRpZFEoeSu7sZYnqwR29UAvNG2GaCg1Ls4FxyBuvn
	 0qzm9d4ud9+b/9kuRoYdzq2hNauG0nRvZfmwv9OGlAI6FLC+MFVttGUFM5N86bn6GiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g09dqGgfkECLzBz+aB2tJ6NeeH7OBTuBnp9ZDOSrA+g=;
	b=Z2H9rX0qBttiTfx0Uou4SXKqge0p8IMMkIsLhjXz3xcpjGShsxCq3pdnghQ+Ol6WyJTX
	 VKQt/RLV+ryYcmsj9m91YC1lXOSxvQDkEkjtLyUM+2TiTyEaVgOOIzUOzzykAroi0vYGO
	 rWU42XtexSHjjlxWshRrVRiTaztg5ROqRWTE+c7nb8mpD/SaRY/Y5j+iIBx4eeTy6+H2I
	 K/PoTp6k4357dD1xQuUxDjQje5/X7HUcSo0HGJGnheCK1LcvERpXoPdn1MEYlon191OYI
	 EMpAtrUe1G9vxS1Cnz/QoDunqyld0zqVlW1MZZy+TS0NG3swVgErH14LHQohp1kfPxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kfw5lTIe;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2202606A31C
	for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 16:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2202606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kfw5lTIe
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1034624a91.1
        for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206014; x=1793810814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g09dqGgfkECLzBz+aB2tJ6NeeH7OBTuBnp9ZDOSrA+g=;
        b=Kfw5lTIeK0b+pOQ6UeoU3otNbG/F+hJLBbHJEngSvUZJX2T+MxRia790fWsYRjO+gu
         zctBZmF6vri7AvKN6vl25fZ88lMKL7xNhzGmKT5vzAphBDKRfVmSdyXMt2boyd+sNC+B
         Y1eJ5ALziL3Ty0kZRoBFzS4YX6Y4PuZhr4o2RfgzX2saVF4UCTFpQvJusL3w0/JWqHaf
         ih2ZAjpf2pjMmCimMqDGyF+XyRi/GjPmTkkK4NbKvltpVB3SR+/ronU3UaaWcfwCqTx+
         UocDFBZjP3PAzqQgzwwW0MdCOLVUhWoTHd6LJWzNZ2Wyqulal0tkpXusZpW5jqqLYHQQ
         Ylcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206014; x=1793810814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g09dqGgfkECLzBz+aB2tJ6NeeH7OBTuBnp9ZDOSrA+g=;
        b=UGHxud0BWdZAhC6fGIrYi0DrPtIbNIwVQhYMBiTFVqGWc7aP+3jAUd2YrYtjOwpXyn
         k12FJFijtgmdwjYWLE3Jp/Ez+dLGQFmMPH9bPkePhRot9f8l3rY1kxBD3xKmX8vqHPNu
         Nj9LapkFK4+GzfCgcuyAjXGq78WtV1wZeJhTncAwQBQGCKnDS6v0/5+OkEW5NDKZzrm1
         mrpeI5NnsTGVUI3+681Q/kliRqXiP8FUZBkiVlpcPeXmYjGWbdxuwtXHsl5ZTFzXEOnp
         0oto0xdgkhKak0S7QAaGGnbJi2cYLlwkXB+9lxA9thR5SriNaD7Kgh/rQzLvBxTRht6D
         R4fA==
X-Forwarded-Encrypted: i=1; AKwUvBwtm9xwtxne+mE3lPbF31ZnJcy04F8T8Bes5237b39L/LMomWThNIcvaKYvgNj1/8CFs0NlOCazJdACzq9B@vger.kernel.org
X-Gm-Message-State: AFq9FYKDNN3gKkQuPcNy9oKvBy8pfjGvmmgxOJ7KMtm8lafeuJzxBwrc
	x9WTSWsTivZKTjE0U06WaIzQbtGZL8ueT7F2Xc6FKRwVoKa6AmR9TIBL
X-Gm-Gg: AYBFou3M3iKOPon55NOKnt2sh22tLYFDi6hFpiPxeiww13NaexR5U9u5OvUl/AzecO0
	s1SLiHVkIsmRwDZNYXpfk9QIyI6CyMqpVaFie6g/uX0Iy/J9koagSmOzcbtGGu0roe7E9c9YTxC
	w8r7eGtJY4IXx8D+mUB1O93BwSB5RwUcJvVGPmCkao+++tCYtMNHsUUAxNO/jOi7KPeEKVIQ0bO
	M5SeRDQeIep44crW0Vc40lWHc9VND2CvRIa4Op7s0sAEop519WjuP7ynoABMHkZO46wnw29LX9p
	MVB1Vf1LHN2KRvIwomu0+lFYQdNKdBX5UCeC7wNQcdHP7xiXY2H8YzR9IoOQXCoaszCqgd8fesT
	XBb4IQrTXwsyWDSxCFgsZ1vBB8oZyL9QeAoqm6b57GOCq3LQEnQN3MNZB4WC6wH8Cbp7OoUEyal
	G2OQfvDB6eTthcyvmevxi4TqqHGahhgd7Q1c8FzBgBycYxt3nINierz81FVeVPnGuDFXQMFA+Bz
	dVWCNJ7BjaX3V9adpv6jzFFyM671rJFsx1CEN2pha6rdIRK5cJK3bNKIoYbTnA1qwl2OwMwj7ye
	QmOiNkyuLH1LMBCLIKTfiJpM6jouC+VqLZ4dwIWa9/Hlo7/6/Jx7jX3UL770UoLxNxOc8te8pdE
	fpsWLf1V8H/hqZ9MdE9ac+tvqRcRigX8/lhENPvSNGs3xaPU55g==
X-Received: by 2002:a17:90b:5348:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ae58228c0bmr2122376a91.31.1793206013689;
        Wed, 28 Oct 2026 09:46:53 -0700 (PDT)
Received: from lima-arm64-dev.hitronhub.home (180-176-144-38.dynamic.kbronet.com.tw. [180.176.144.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5797f6aasm2083346a91.2.2026.10.28.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:53 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: pmladek@suse.com,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	shuah@kernel.org,
	song@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] livepatch: Fail object initialization on duplicate patched function
Date: Thu, 29 Oct 2026 00:46:49 +0800
Message-ID: <20261028164649.337479-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <att7GJXA7hK7Ic64@pathway.suse.cz>
References: <att7GJXA7hK7Ic64@pathway.suse.cz>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri 2026-10-23, Petr Mladek wrote:
> I wonder how to move forward with this patchset. There seems to be
> three unresolved problems:
>
>   1. How to handle aliased functions when replacing two livepatches
>      with aliased symbols, aka two NOPs on the same stack [1].
>
>      My take: I would fix this later on top of scoped atomic replace.
>               The aliased symbols should conflict.
>   2. Fix the low-level __write_relocate_add() to clean its own
>      mess on failure.
>
>      My take: I would fix this a follow up patch.
>
>   3. Better describe the purpose of klp_write_object_relocs_limited().
>      Or clean its own mess a better way (code duplication)?
>
>      My take:  This requires v5.

For 1, I have a proposal to create only one NOP in the first place,
as in your solution 1 from the earlier mail.


Recap: The problem
-----------

Take two livepatches that are already loaded:
  A patches __do_sys_fork
  B patches __x64_sys_fork        (same address as __do_sys_fork)

and an atomic replace livepatch C that patches neither of them.
klp_add_nops() finds the functions by name and sympos only, so C
inherits two NOPs. Both resolve to the same address and end up on
the same ops->func_stack: [A, B, nop1, nop2]. When the transition
is reverted, the stack goes from nop2 to nop1 instead of back to B.


Proposal
--------

klp_add_nops() runs from klp_init_patch() before klp_init_object(),
so the new NOPs have no address yet. But func->old_func of the old
livepatches is already resolved when their object is loaded. So the
address can be used as a hint when the NOPs are created:

  1. Copy the already resolved address of the old function into the
     new NOP (func->old_func) as an address hint.
  2. Do not create another NOP when a NOP with the same address
     already exists in the object.

The hint is overwritten by klp_find_object_symbol() in
klp_init_object_loaded() with the same value. It is cleared again by
klp_free_object_loaded(), so it never outlives the loaded object.

A sketch of the change in kernel/livepatch/core.c:

+/*
+ * Return true when @obj already has a nop whose address hint is @addr.
+ * The hint is only set when the livepatched object was already loaded.
+ */
+static bool klp_nop_exists_at(struct klp_object *obj, void *addr)
+{
+	struct klp_func *func;
+
+	if (!addr)
+		return false;
+
+	klp_for_each_func(obj, func) {
+		if (func->nop && func->old_func == addr)
+			return true;
+	}
+
+	return false;
+}
+
 static int klp_add_object_nops(struct klp_patch *patch,
 			       struct klp_object *old_obj)
 {
@@
 	klp_for_each_func(old_obj, old_func) {
 		func = klp_find_func(obj, old_func);
 		if (func)
 			continue;

+		/*
+		 * Aliased symbols resolve to the same address. A single nop
+		 * is enough. More nops on the same ops->func_stack would
+		 * break reverting the transition.
+		 */
+		if (klp_nop_exists_at(obj, old_func->old_func))
+			continue;
+
 		func = klp_alloc_func_nop(old_func, obj);
 		if (!func)
 			return -ENOMEM;
+
+		/* Address hint for klp_nop_exists_at(). */
+		func->old_func = old_func->old_func;
 	}

That's only one way I can come up with :D

Best Regards,
Harry
