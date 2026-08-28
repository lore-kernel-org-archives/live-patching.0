Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BB3DF00B
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921588; cv=none; b=JQINa1UBtEc5HuzpwCybyH1uUtO0Q4ZG6etZ8CzHflvssriiA3jgTgKdDky9KIf9FlEICgQEw4ZB4sHrKcQgbbc6xit7cVnp0b3o9t/uu0QiG3ehF4LckVKq436nUgmHHnGF0T1wHlASXJTzzGjXmAkZB+0YpvZCzy8hcfbR3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921588; c=relaxed/simple;
	bh=sX8+PgNmVuz6gz4zkSBUo3MDj/DrFGBj4JWJHqs22sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qhxm1tvr4Vp0eJ8D5ud5mUaTHxOizIQjcAOM50yCcK65R17K1zvzXvTPr1DFicWbHcJtcPRTPqX0yppduB4IquORRjd8VOFx0DA0HHM+yJITC6nKwMWThWCbRlJOKwv6ddzq84xAPrtqbsarjCbDAOTpPeGG5JVkcX7tb6VtBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jp48fLkV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jp48fLkV"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47db714766aso1539751f8f.0
        for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787921583; x=1788526383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=To9XkYtlLGviSaSKQOufK24S4NixdMY1ShlY2DU3Z2A=;
        b=Jp48fLkV8PkUGPBQfApahTjNnelmusf/znK88NSQkWrWQ66Abem/T/0GGL1b+bmfmG
         N3XzZ+ysqlQxMVNOCXbUngkTtVYOdiMYV4kl7PrAUJttl/fMYE3rik5kma6KzfLkxHvX
         bszuk88be/gKurXpfr7ybDHTSP5ftdCVVi3rCsp76f7rhIyNkV4B5LPCaASBj46ALYf0
         h/DD9b6FJORyXWjOhX9+CbqIhohGlD36ZrCAl629q9RV7eeI1neIsvJfq2K6NXFqRQpV
         B4phikIJR8hpM+fNq42oWHC1e2+v6c+z2sBeooShjtYENQg3ItYCXz93M+hVpEcyjZy1
         Kecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921583; x=1788526383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=To9XkYtlLGviSaSKQOufK24S4NixdMY1ShlY2DU3Z2A=;
        b=YZ1QMr2wo+PJJisYx9Vc5AXNJaoFQFtWCNo+MtmBmhfQRCXP8c0D1i26uCy5b0pHqO
         4RT1gWecBPUZ6j3YkBdguOUAbi7zOcjUlNSooWWIDSLvgtXn3FrxrEv7dfu5CXDituj2
         8sfnHc6VeXmkhaE2NQNHVtEhFgtx//QS13UgSU9fekaeYt+MkGu+oosOMs4xOZ93Yjx5
         c5WNdlof+z7fLKHjRnZ9v5egrJrn/hF/YUD9SmTaTHR409naSha2dSIlMewLxQdWGbj4
         4H3qrSy6/dMnS3pOZgMWFMLvn9S6FzMXjSa9clQeYbDs7o3xif8UGdCdkSflcZWuXmhQ
         0V8A==
X-Forwarded-Encrypted: i=1; AHgh+RqhJpFvIPS+VzrwYUiqjpfX2MBAyufJW7etNxZ+aoBn4meo3Hl/o+6sjhu60Y8VXnWCOQF2jlH+K+tgS9/Y@vger.kernel.org
X-Gm-Message-State: AFuF++mVQZLUpnk2LmHCW+1BaN4iyi7neJIdoMrEtpfR77l2CIWXN6Ul
	PwaWjGs/EJvEThpIlXi/cTVjKIjNzspg6tvwWH1N1HFijlKQF7TVbjuDNJqQyRBGxNw=
X-Gm-Gg: AR+sD120rBP5at3uQRQeghDWUSVAVGtZqDc8ZAOxzdJ6hwuckw8O02zUJwyvscnTsAa
	y9qiD3Cc704cmdasGITBuW/7eW0BfDXP7tVPwLd2nyvKp9b43b8hXLbK8huapkKvhs5tueVzfzZ
	t3z8R3uTJCNMKjhisIjr7ye/54zGQbpGHagXuMpQv3V2ucSwhMf6Tt6LItLIRK29x1EtYyHa+/n
	EVGvn9xUMDNZxZGNkDShcrQM81suIUCJ/vMnlhZq/7VcLCIqgquJF/w/2AmxUk3d7ZC+Q5OJzf5
	8xueNo9ZvMb6ndRbKu84K0RhnLrFw30iDuslQQsKNz/J9u+QkPOodBuJzlyCvgmXJwU4sqXOuhd
	zcqLL+m9xRTWtsygUXPNK1YLynYmZIJp5ZcMa5C5HB2JqbhxQxsWnFB9uhQdn1MncUNNWvHSCbH
	s+IJ/Df23aLzG1lqz+dmbHyjPFz1/zP7vZw4P6VtltHPwiE2rUc94Pj6Vi2uNHow==
X-Received: by 2002:a05:6000:268a:b0:475:da0e:744d with SMTP id ffacd0b85a97d-482f75bb6b8mr10103544f8f.8.1787921582923;
        Fri, 28 Aug 2026 05:53:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb278f7sm4469487f8f.26.2026.08.28.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:53:02 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/2] livepatch: Clear relocations when klp_init_object_loaded() fails
Date: Fri, 28 Aug 2026 14:52:42 +0200
Message-ID: <20260828125244.509977-1-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apBbjoEHJ98DWN_W@pathway.suse.cz>
References: <apBbjoEHJ98DWN_W@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this patchset fixes an older problem found by Sashiko AI,
see https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.org

The first patch just shuffles the existing code.
The second patch is the real fix.

The patchset is made on top of the patch where Sashiko found
this older problem, see
https://lore.kernel.org/all/20260823060734.58443-1-x90613@gmail.com/

It might make sense to handle them together in a single patchset
because they touch the same code and conflict.

It seems that we will need v3 for the original patch.
Harry, could you please send it together with these additional fixes? [*]

[*] I am not sure if you did this before. It is easy. You create
    the patchset as usual and send it. git will do the trick
    and keep me as the author of the two additional patches.

Alternatively, I could send this separately and solve
the conflicts when merging. They are simple after all.
I just must not forget to replace the new "return err"
with "goto err" ;-)


Petr Mladek (2):
  livepatch: Move code for updating livepatch object relocations
  livepatch: Clean up klp_init_object_loaded() when fails

 kernel/livepatch/core.c | 102 ++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

-- 
2.55.0

