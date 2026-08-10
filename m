Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D601256C8B
	for <live-patching@vger.kernel.org>; Mon, 10 Aug 2026 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334034; cv=pass; b=OGvzYUBeK94F+Z4JPNUAhf5wRGTL18cLbJd4UJTio48T25Rl+nJqSEp1/BmDHa372bFqgnX6Lsu/SzwCRT4XR9oK4YIIEYmdwJP4IsaObvp1hhz1fQYcN+8tw4OoD4GvNtVmjCppO3LoqJeT/baHl5JVgEjmJQkZOAgSLvpO2RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334034; c=relaxed/simple;
	bh=EU2KI1CRt6zOh0x+9oq4Ezjjo2sFpM135RQqO45Ttw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9LQrG0Uuiwf0wI+f7LQDdkDO8aM6Nf1lK91CmGb2xEBAYZBc48BMVZhdDnX1MC70QH0jPf6pqlAlpbsrVXFJkc9xBXXTYHx0HFSWl35KeOtyDX44IzprX9N0Qxpi+WLlXhLXmxZwij7w/HkUZN5jMbkp9o8m1XTRh6rsfLGngI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHRmEMxU; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHRmEMxU"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-82011c59e66so20832697b3.0
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 20:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786334032; cv=none;
        d=google.com; s=arc-20260327;
        b=Ep2XtUBn4LG9lqSEEYdq1BqBebSBvfhdb7YG+vJ41nMEL0YPnfYkT/ypwv4yxU3SmR
         jV4c9lkoD6VFpm/pe4dBIYkQj3yOxC4F4NXkAVCgggYOUeuFhedF5i+LBzBvAF1qN+MH
         Jc8UF882kkaDhe9HbItSs2z2xxGUDs4v4bD5ih8WCyRxl38mElqysFBiRMFbSp4plkCV
         tD9KNk+wENos/nI8ifs9QJyP7GIRKe5Noj/+BNeTs/Fk6hSzCWDwcKs1Kk3oungieF8j
         UC0srslBpooeOyR5pCLMUyHui+cupsUtRl/+bivvcCjWn476IkAOgXT0ixeymxk6IHd2
         knig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EU2KI1CRt6zOh0x+9oq4Ezjjo2sFpM135RQqO45Ttw8=;
        fh=iBeLoFKxFuf2oXOFVD6Oqiup3F3gAzSLGqKKLwmLRRs=;
        b=MdnJPzP+8eJfJ8GaTWX3MEiKwbBu9RArA5VSzjO/5g6vRqYlDgw7if1rJsGpIwoPkG
         aPAsVKMpGvwwLNUpSRK5AR4F+9zv0pWx1UcPZpTdZAXqKeI+VDGg3c30V1b0c2D+J8Hk
         hpf0pBGKbII4bIX2UsM0CZj9ecGNSDb+jMomiteIpk0GAt6/6QiUZ4TBISE0H4Y2oBR9
         TOpSbcCOzFVa8kdkYPAyRdFB+5hSO9NulrejgMoOOO1Qw17v5CNQwMR28ZBuYQsMdaSV
         Lz6+8nl3O1bBPa79NEi8NDaCmLQ04vurBHlKG8sMqCH9LdNTWxtIVE26yWQEstaitVTU
         blIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786334032; x=1786938832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EU2KI1CRt6zOh0x+9oq4Ezjjo2sFpM135RQqO45Ttw8=;
        b=LHRmEMxUbAGMCIMHzSgEQ5zwahA7W8shsrDkmVRFDb0gk35rOMFIPwtAN3eMwIc041
         thQg6Uri6yT1JzATziVgTWvky9u/yBQEjGkn9kTZxTv4Syzvko7Ub9NirLt7dXDRu8ch
         Jv62Ru1tFooiKuTUfkF8IHRoyNVKWHDoR1HJnLdnTLIHraV/wLSixp7kiedRigWcghDN
         1lOs6BDwGGCOZmEZcRyhRGGcUS6J7YSq6wyDJSf/gBUJfQ+b4uoiFEb6eg7Gxp+IwxGV
         I7+WvUo+f2eZYuw2Ht2t4UdHW5PfSAmHUR90ptCkvpoNXBBq9/5ydXNQEy4SFY4eNI91
         2T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786334032; x=1786938832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EU2KI1CRt6zOh0x+9oq4Ezjjo2sFpM135RQqO45Ttw8=;
        b=c7WBtqxR7cReK6pTqRzO+xHAwXSQMt0k320aqC9wpaSjr+gXvMDNfljCxjgGJKo7x8
         C7vRIMZHMGroKckfltrsEtZmc1Q40CWPN8OyrjlzxQA6xBvDX3XAtZfLXuwOPMH7Nfq0
         NA0t21uColbJavqS5wuBndZKZkSeemrNnKFU8W7s6nlspHNLw5muoyV/FJzin5oqB0h7
         adYhGgwTbybpAEsjrbvxEMnb6gcPIWnvoYasFUg7K+7haB2jPNqTsARc8uembywfW4DC
         UNHVDt0AZPdBqzWmePdjmq+vis7q4xTg/mM8/RF7Ww/weZLpuN32JybEWxrN6kFC187K
         CfLw==
X-Forwarded-Encrypted: i=1; AHgh+Rrg057AqRmIh5dqe4YB7O+DMtxALFe6CH3v2iE1GGG5grX0JdZAjwa2zgEfVu/ZU65XmVdXRk01kw/Dc5KL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PYiLfbrZgpdgz3jzgphf9f9fAA7GICgaB5Xm1mViBxEz7WyP
	eUXiKpu5iH9SFzskwqFj2wllTvXFE8UdMgWKXmDh0jEWzO7zIR8ftOh88GGsJzzdpR5GKHLKsM7
	VS52Mt9qEwXOetSpClV3nOoXmn3GDdYw=
X-Gm-Gg: AR+sD11O3NWx0PrVXtf1WoEh79BeEZ1E/P8s0g5NiBK0PrOQdHX+3sgNunHau8uzAGv
	10Wnk4/Dj1ewEppMA6eTvX1RKzLoW4Bb19vptID+r8+jfIindLAxY6aknDgNprTtp/KAMqUWCh8
	YKleAogo0pEcuZ4cH1RIb8Jw2GAGMEnKVUkSegpA2y/9VagZMzVjSA2XubiTjqhX7y+HNyk4SC3
	irfToYzyK9ZfsPSYYigzKjZXZeXt0DlQE20hz0n9QMNJclFPZTYmkcy1WGDGFe0qq/CJ0G6gDRx
	vbtqvU8oVAql78GeolJB5ZaOUujlpGhcW/0yuSB3doQ4V4QtGpE33oShOz8DhmC/19C68ohAthP
	/
X-Received: by 2002:a05:690c:260e:b0:81e:695b:585c with SMTP id
 00721157ae682-8201bcaf7a0mr264944807b3.4.1786334032195; Sun, 09 Aug 2026
 20:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091954.22930-1-laoar.shao@gmail.com> <20260809091954.22930-4-laoar.shao@gmail.com>
 <20260809094046.50ED31F000E9@smtp.kernel.org>
In-Reply-To: <20260809094046.50ED31F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 10 Aug 2026 11:53:13 +0800
X-Gm-Features: AUfX_mxElC9ze2AWpHHfl_SsxT2A2aEpQ3-OGyPTjU89ordFkAdgLF6AN-Fm3UI
Message-ID: <CALOAHbAuSypXjKoPiGuSDMNe5WJ5DNKy0kkv-1QjFZc0wRZi2g@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] livepatch: Call klp_init_patch_early() earlier
To: sashiko-reviews@lists.linux.dev
Cc: song@kernel.org, jikos@kernel.org, mbenes@suse.cz, jpoimboe@kernel.org, 
	joe.lawrence@redhat.com, pmladek@suse.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] When CONFIG_DEBUG_KOBJECT_RELEASE is enabled, an error during pa=
tch initialization causes a Use-After-Free during module unload due to dela=
yed kobject release.

Makes sense.
I will fix this pre-existing issue in the next version.

--=20
Regards
Yafang
