Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677654;
	b=T6lsVHPX0v0t0Yi7yU3sgbyDkgeX7qY1Z881AAXaTvaCH6cfKi6k6lYLpKVJbbcoWKJv
	 2/+J+k8KGldoU/tmgF1kzWfN9t3iphn8uJI3Vl6aDhm8O5I7rlp1VlaKdsOs2uIEGkGX6
	 7+2b6umvL2DhQkWO2Vdl5C+OBKWKwUsXpdmU0c7I11TkkTpyCoJLiV0vN5V9PORPjWwaQ
	 woWarNFSzRalYxHPHudTKcwRmmXk0T9N4ufYojO7g0o+Lyh+p7NHMdS+1rs9XJpf126dM
	 lUXf/jwN0myak0epABxLZ+AUsBWuLZgJA6ub9DfuScmUp9bf/vQqh25boWqBNUuoJuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=9igQSf6DxAgHu/mruOqfjXiz0BwnF03dcDyZmMucM/k=;
	b=hKXF9YrrrZb1T/hQAoOBKyy1juUWq0vH74lll9QWW9dTuF8DJUnY9hjLLP1WVD5PrnP5
	 iE7/WUKJFzbFMWfksDnr0wH147pt4fpsrxAKt5RO05kzFD8t2sOrZrf2s7LK94ZzJ44G0
	 MfBa0MuOnswvC3stM0VSKt94SyU2UH5Sj/2P5Ywmmemc+es6fKJJbhID8MbzyRwuhWh0z
	 Xf23aIfHCFRzXe4GQSfMIEo4QoM3l3hW+mQO0rIMWGhI9WS7mqWzAWrlXEBt6pD96bW0Q
	 VyhgWoRWFBFtWMWkbo9RzGtuCt+A6Auik0tMtQU50UYaMC9+GtVHAvaCKV6SwC1bHvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=InqnsJHy;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF64606A31D
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 14:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EF64606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=InqnsJHy
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso5400335e9.1
        for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792677652; x=1793282452; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9igQSf6DxAgHu/mruOqfjXiz0BwnF03dcDyZmMucM/k=;
        b=InqnsJHyKWA2U1bNEfbBRmP9dqXEskfN6dtfKd9mMd69DRQgV5kSCx8yCaaSp2Wrk7
         UsxBC8XIN3UOpdqw4niuPfG2TQLTqTwL74trGoO6+f5YmiDjnz9sjS8cwapEIxr7Nsb4
         1HihJMxRCb+t59KQC2pSQhvmc061FQP38dnyqspr9upjbUD0glT+qx41i7MoF8PJSdeU
         UtBoWlbyR6zuEa0YzsSf7p31dH40gshM8Jk/RL2I8Cw04aDIxkQ8HCxkgntnr+xllJOc
         li/X8mLbMXP+JfcbGWyl5gptyGItRTjZYElSAETXkFPMQeOT4vSQkmTTHSFQTB14JCl8
         xHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677652; x=1793282452;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9igQSf6DxAgHu/mruOqfjXiz0BwnF03dcDyZmMucM/k=;
        b=o7Kfr+qnh670TNqVtgj2F9n3p9bFsAqhkDMCGi+uRZtW6VCmfHQZoDSgVuFJe1O9YM
         YDuiUM1CosJi8C4jhiPqxV9hz1U7AxDTH0an8wc++bfbmxBbfqJwm0JqPeM2V/ks1N6C
         2Txi3MBVx/RosVlWNpP8N7QpdU/vLVY3ssyA04u8szYA7k/V3uXZClrLHQ5/gz7AZoBj
         aQUx9OOTmEBa4YD0f3Oqnd+C32XNi+OtwjgBKVNLseoJ+Lv0qsskcePUOutOWGN9U1Bg
         W/2gP5X05TYz1UPor7A2B+5bLfxcqJ1GeP4OUad97HA28752q5P0dTxuh0ygcNfML8Yq
         fFIQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2+hGT8u6prpYV+ka9FT1p5Byne5UFO71vfiMSqB2ITHZcdATtP8s5ow4lATOAtYCHQxK/zMjJtuLKnihu@vger.kernel.org
X-Gm-Message-State: AFq9FYLg5+H42pJqDQVDViJx2hAxLJM5QOcAEwucLrg+6Uq+RGfUS6eA
	B/+NasmlHlB+JaoU6xFZNmpGP2lKbrhcGhj2hC4Jtce+4HN5cuGKAWvzRzf2OntzZek=
X-Gm-Gg: AYBFou1s7OrqjOKMmBon02SlAfXYERlWfQaEXcJHB0AwDTe35w76mZJuYI2Ybkib70o
	JJ6m94SI9x6pEKnDPe0N63nSdLgdryTU3QNTIj5Uqb85aweqgCqQyiDj+HB1zjfEyIzoUtxQomV
	aaJLxGbkDtJ5/lOXsYnTJJd+R0ZIU/+B3zdV9Z71RouYh+KR6Dcsmx8QuBV+SoCUGYSTQBfYalA
	Dfih/C1cL5IZqlAEIaB+Kr2bwDloIbwZ8owOkGCPI/HBs/LoF944Bo7vvtnKgRGx06teVauBpjQ
	EpubWmHieh691+NClDr+WHGtDrBO7yy4doyAPhzezJw2uvtsGLfE0RRmn2BFwmS4I6aKLX1Aumq
	amqA1NV/eI0D4zGZfl4gV72u7umrhZworzkZAuwryIuCrbr7rT1NyXFV95zfYzO/YI+mmWMUJBV
	YVfvsi62qzvYGaIvrN85ErzwGj6LfYmfZ0pANARK5s/fy36WwxJp6I07pb7tsl7UdPVBiXlSlVz
	BK7JcX3dp/mMpaKvmy8lxr7OBMdC9tiwjhocFcmOYqWKfuE3m7j4dLci+nUkEJh5JlebeEA
X-Received: by 2002:a05:600d:8646:10b0:4a2:390:712d with SMTP id 5b1f17b1804b1-4a203907493mr40326325e9.33.1792677652321;
        Thu, 22 Oct 2026 07:00:52 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a71f6dsm71111305e9.0.2026.10.22.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:00:47 -0700 (PDT)
Date: Thu, 22 Oct 2026 16:00:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 7.4
Message-ID: <atoXC68mgjNhxhJj@pathway.suse.cz>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest livepatching changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.4

================================================================

- Update maintainers list: added Joe and Song, removed Jiri

- Prevent removing the livepatch module before releasing all kobjects

- Ignore debug messages from other subsystems in livepatch selftests

----------------------------------------------------------------
Jiri Kosina (1):
      livepatch: remove myself from MAINTAINERS

Josh Poimboeuf (1):
      livepatch: Add Joe and Song as maintainers

Petr Mladek (1):
      Merge branch 'for-7.4/kobject-release' into for-linus

Yafang Shao (2):
      livepatch: Fix UAF of unregistered patch kobjects
      selftests/livepatch: filter debug messages in check_result()

 MAINTAINERS                                    |  4 ++--
 include/linux/livepatch.h                      |  4 ++++
 kernel/livepatch/core.c                        | 10 ++++++++++
 tools/testing/selftests/livepatch/functions.sh | 12 +++++++++---
 4 files changed, 25 insertions(+), 5 deletions(-)
