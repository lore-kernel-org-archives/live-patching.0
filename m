Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442998;
	b=QJwOxlE3xOFxMNfqQVps6AbgWFh68jmfu/7pd9L2fmSrU3u/+6qVpCzTZXDl433tt/c2
	 iCRjH6hLJMBpUIGLBsP8EB6xqhdz7Hq4gu4jo/Wmh2MjPwmr0sWMe8L0Yb2YnFMrvUIpQ
	 ytCtyK8UOyrUkklLa+agiNTZS8yX60Ps/UbgFFrNw1QD6GDLR2Vlf8S+xqlk+qQOGwXcN
	 tbm7+EzNLVCnRtU2+BhkqQXQUXEHFeXNSWT2nfc+a3JTbheUFR+F6kaPvJ4dmaLwOjfqu
	 efVjx7XLhAreEO1CNshB3Vq+P6ZvN5+M2HVoTpAudwkTYEgeOAUWzjfVCwlNKbjIPpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OVzKGhTc2TdUCcheqmq2vHcetEiudrFJGz5SKyy8AVA=;
	b=kaBycsVSOosz21eFsE6bh/9xXRR1UolbkEOddfRlTdxnBQUQE3rulVoO6F07iG1gjGUl
	 5KDCUjaB033YQu+WJvZyXPlhEirmK+g7uhhbwy8wK5SP6kFie3jitJ5gI+uBN+WEU4S42
	 bCsg5ByPOqFftYTMaLH3SWpBxSgit60FAtKADAkswwEsHWKUlOzG0pITjcEZ+rqnNgSvP
	 maQO5AwoXYwTShSiOKpN0vh7R9E3R99TOh53279fSv2QWQ6Svi2yaYeH4r/xOH1Isiyp1
	 a/YnrGcmV905o8D8tRTw10EO6iRAbcm1d5bigtFJ62TIpzAwLG217TkkR22c5EKtZBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WPrbHID9;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCA606A687
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 14:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25DCA606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WPrbHID9
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49412eb1474so2115827f8f.3
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795442993; x=1796047793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OVzKGhTc2TdUCcheqmq2vHcetEiudrFJGz5SKyy8AVA=;
        b=WPrbHID9L2Bx69Hoj9aaag8m7Nn82Ch5w/okkhQ85oOKWMS3hLXfKYlXvBZRskWL7/
         U7I35pQM1A5QNmxFmHpVwIryX8R1bmVWKp+yLFY5NPtmrMPaYzdT5soQm8z324suGSJ3
         48d1vc42UH/vNH4/Brsn8zFh1QffNx34CesHcc45DCscRXcrLpte2gZJ/slN+yl98ZkX
         vqDhgnTHIMhveLClYOqXs3DhOKdqlwiec7Aj+5XWH0YUpD2wUZXbv28JRCAWe/xEfAO6
         Oka6AhPr3d+CkXs45tKkclN1vdnzI6YDOkKBVuS+4GkSfds0OpY/FdqvfVtslxkWwULv
         8opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442993; x=1796047793;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OVzKGhTc2TdUCcheqmq2vHcetEiudrFJGz5SKyy8AVA=;
        b=JGfibVB4VKSVSmjQKmkr7DV4G87AzJqU4xl1XyB1SHIFs0KaB9aDwZSmuyaVNuvqIk
         RTROjsIIt9+n/ccW3ZKVTs1MfaoTmFysETa2b/Gxk3ESgirju0jBbW7Beq1cXU0kANeW
         xPKQdcEViDvbXhXFWSoRpWlwy14eA/x933fFNzY+eICv6ETUgE4B1PjnZrKsHYh5c/Us
         0sQCj4+YKlAx5cVtMsDS5Rmoro7sHOlF/3U8wyt8B2pT9cAPRNoSOln1N++teo4TeNSr
         MqRi1FspIpaEqt/Fh9O8yZsUK4h7vYyE591IHXuS5FZB5Zvt25+U8s0khqrrEbvJsDlB
         oIrQ==
X-Forwarded-Encrypted: i=1; AL+hErEuW4eQszSOFCOK8LTbPQUgFKf0JifzfqqHk3KpK2qT6+FJI29gIqZ6gFNZgmkeN20zLQi7FebYw0gbV5K0@vger.kernel.org
X-Gm-Message-State: APuU4Z8zr/ZuEYgmwWgHbEYlKiuym3Z2plDPKcs0mRfpOfEKyWkWBLYf
	BGp6iVuIauwdJ3MDcUnWArYwjxqpXtDa0NRgAtl2K/JX44/WJ7vxC8zk2uTGHFdj6/4=
X-Gm-Gg: AZFdTZdITjdGI5OoL3XmZtb4l2JC5ToKuDOIWk1p8Rutzbp2pCnelcr7dc5nCZ1dE9z
	SwW1MTlhE5ubHD8QAPzh/eJaVTuaezHa21G8/QKHA9xr3tN/Vz59U5PiUSP1h5F8I0KV5PEiL2I
	txBFEa9KD4qyIdacnITIZfer1MBFrjsjsSNz5aYyKPzK/Cm11BTwwtwj++Yj4dAa/Geud2aB8la
	9oNV3V1tuSuz4cARzMj82/YNusAX5LTk3sUxDyvyxa8cbmJv84cHiBN+YlpmDNdwH7HD49/NXIP
	z+XyihAAWZNoocr1F6ggVST7OQU3Oy+a4l1Z9bNf3OvPP5vdvIrFXvUVTj4nK3gIliBmZK/53xX
	t3sWXunuLHu6mWMijsIEsCdU+f+btM6UqiKzNIrsZ7wDhumBlExI/4ZnFEk7CiqZaZ4T6tmaTPP
	LhTZP/teNZY4nNxKdTJ3tPu0rvTUY+RcIaFMT4mHz8UzcuUC7dJhqdzDaUYNKyKhbwTqJ7rKsfR
	V/EduqzF/zuHFRZ281hc+4ZdpXIUe7ZBjRwd6c5N0haHBDOACkY/L6V5uXR79FzeMlfaz/imrk0
	z7N4flG5xy0DEKyCMp/qfUpX8YsC7FU=
X-Received: by 2002:a05:6000:29d2:b0:4aa:831a:d0eb with SMTP id ffacd0b85a97d-4abb3c37a50mr15526213f8f.9.1795442993474;
        Mon, 23 Nov 2026 06:09:53 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm21645821f8f.40.2026.11.23.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:09:52 -0800 (PST)
Date: Mon, 23 Nov 2026 15:09:50 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] selftests/livepatch: build the test modules
 against the kernel in O=
Message-ID: <awRJLs-Ajbacirg_@pathway.suse.cz>
References: <20261110161050.2451750-1-sashal@kernel.org>
 <20261110161050.2451750-4-sashal@kernel.org>
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
In-Reply-To: <20261110161050.2451750-4-sashal@kernel.org>

On Tue 2026-11-10 11:10:49, Sasha Levin wrote:
> Documentation/dev-tools/kselftest.rst describes building the selftests
> for a kernel built in a separate output directory:
> 
>   make O=/tmp/kselftest TARGETS=livepatch kselftest
> 
> The livepatch test modules are not built against the kernel in
> /tmp/kselftest, but against the running kernel, using its devel files
> in /lib/modules/$(uname -r)/build. When those are not installed, the
> modules are silently left out. Only an explicit KDIR=/tmp/kselftest
> builds them for the kernel in /tmp/kselftest.
> 
> When KDIR is not set, use the output directory given with O= or
> KBUILD_OUTPUT if a kernel was built there, then the kernel source tree
> if the kernel was built in it, and only then the running kernel.
> 
> The selftests also pass their O= on to the module build, and the kernel
> Makefile takes it as the kernel build directory instead of KDIR. The
> top-level selftests Makefile passes O= even when it is empty, so on a
> Debian machine with the devel files of the running kernel installed,
> 
>   make -C tools/testing/selftests TARGETS=livepatch
> 
> uses the source part of the devel files as the build directory and
> fails:
> 
>   /usr/src/linux-headers-6.19.13+deb14-common/Makefile:798: /usr/src/linux-headers-6.19.13+deb14-common/include/config/auto.conf: No such file or directory
> 
> Do not pass O= and KBUILD_OUTPUT on to the module build, since KDIR
> already names the kernel build directory.
> 
> Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

The patch looks and seems to work reasonably well.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
