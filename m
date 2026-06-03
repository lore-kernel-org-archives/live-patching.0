Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CCF481A82
	for <live-patching@vger.kernel.org>; Wed,  3 Jun 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492389; cv=none; b=pyxCPcjI5ai419Is+Sxa+QjS4HN10zCofuYY3kLOPDDFFc2YQ2W5kGDKhVEa8WMJ/OQ1WBFAXHKpKmb3dvf+kgCZzHUc1/lsw7xkPd7VCJj9kOWERdtFhnkzfl3/L6DfTiw1mxOWWxmSZl8cuZDaejHXOheaKBjXCppfO2Dro9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492389; c=relaxed/simple;
	bh=WW2wDfU3rnVBaaI+fGCSWfTRuMYvZQ+UdYJSw/wuQp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHx+mG7m0lAFXE7mDw7m1Q9Bb82KftwgsQ1NjgPG4dYvo/evTPFqDHjqe+uN4ZlTq80KUNb9WRpqVLQ+akClvaFv6uszfdwU6RpZ6mL7hGFt3HS2t4Vtp9TJ0yNPsf/j8YDR9CyaCS+1z7tJ2cDoXq8vJnUhA9S5fPicpF8vcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZdXcDzDK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZdXcDzDK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eec22fab7so3510603f8f.3
        for <live-patching@vger.kernel.org>; Wed, 03 Jun 2026 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780492382; x=1781097182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yq2UHVEOUzdIFU3R/Oloopokibw3ZVQerM+BGv9opQE=;
        b=ZdXcDzDK6y1ROvv/Q38nRZ8CLfk7VwWDD0kC+i0is9zpz7+NNg41V9WaMr4ytE/whJ
         4B7EnptelKcQ8y4nJRhyNz9nVFTOgo5RaNvWC4513zeqC731hIauD7UWLZZOAE0I5AoM
         6s0bHF3FYpDs7/akHsfZrNbTwV4EXX5Itra2q+0R+GGNG4Seqsz8kuvm10mPAFk+Sy5+
         /wvZdl6B6b/iVPVnvrcTqqo5UvkuMAirEsBWRSnRID7tOFVfCSjjcn9OUxMj2fet4xTS
         rzB+/h51A84BV5lMTQc1koFjR99niBLfFDxWJxTLQXHHKc3bZeRhVmhx2ndb5wsgzBMX
         X1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492382; x=1781097182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yq2UHVEOUzdIFU3R/Oloopokibw3ZVQerM+BGv9opQE=;
        b=JklF3v/YNRmu188Dq1Ykf107Yq6d+LF6k5fuxMqzB78i+/5vQI7uGPaseYL43hIzxf
         RY91lPwba3wb7PVe2u5r2v96AshOko8Bj2LAjIo0gD7EfqPXv1EmYqXRRdkO/1PoEdav
         nV+kLLcuzxFOzGen0F81RTCrq8YPJ+dsfP6/XfhpXnSEglrIS8fWOzPStv/jmZaKoApT
         qP4TMESUQMxayHh29Fa51rAiTmyUJHJYxWxImZziJlijt5gca9Ptx1eaUlLOM9jgxx4e
         w9DJT8s5KMBolOOcuTu2NhCKpT2bbK+yKk3cX1tJfTinIkBqF8gZC2AEuV6gfFknYGup
         P+Hw==
X-Forwarded-Encrypted: i=1; AFNElJ9+6l3cEYDbc/K0c7kUN8LUWt0CJ1YFsw3Jo1wFrwMG4GWSbstsqRc2HmkigHP91HWbLKX5iXnFurP8zjhL@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdWc2EQ6aO+VXu2qdQetw0pKoMqZm1v3Ck7ywCK3ZhaALRZpK
	Une9+FuD1vrFVbT9FY0bBAvRaGSeql/fqVpZI0xs9egpBl/HSWwPXfhpvZT1n1xIs6E=
X-Gm-Gg: Acq92OFmNb0qUZbGkiDTzSYYsqJlKrX6WCyUaJ9f9ll/nJw7jOBOOrTQRL9/zI7qytV
	DExxXkMs2ljaHaDvVbaGxpupyoEFrWIvk7r2eFGp0xYbyesuJyCDofjZQOOs4zfAL2h9YnJ9ftj
	C8rmrCF21im9HnxED0ykmpOk9n7UEc5FiTXU7/vZ/4d+qMHtcg2Fd0N+NNXG8EvU6YFMUjYSkM8
	QzVYUDITas/0rYHyqiCMjhTWGcI9lhH0igWUqIzHwhMT5lo9dSLEbWIKNFI7yUqAkH7BDm8xf9N
	qwH0FPtzJibsaVCm0wRyKzLIQIWYwrsLhDpqGDBkkKuH3FpLwLVY0i6Yvyls63jfSJj1PYL6UwM
	Jxgvwh5d+jGpQ6W7Sd5wmW522RqECM7RO0h/xoG78TCcgUd20F4upl86gsOFJr1+nhHr3NkBdrf
	6BRtipbEFKxHnPd5V8e+RhhHdLgVFsrRM/HwjTwyuxzp6uZ1k=
X-Received: by 2002:a5d:44d2:0:b0:45e:9431:ee3c with SMTP id ffacd0b85a97d-46021792538mr3739740f8f.10.1780492382374;
        Wed, 03 Jun 2026 06:13:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm7479703f8f.26.2026.06.03.06.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:13:01 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:12:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: set LC_ALL=C to fix
 locale-dependent test failure
Message-ID: <aiAoW4bdorRlWZs9@pathway.suse.cz>
References: <20260527095929.1504032-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527095929.1504032-1-maqianga@uniontech.com>

On Wed 2026-05-27 17:59:29, Qiang Ma wrote:
> When executing the command
> "make -C tools/testing/selftests TARGETS=livepatch run_tests",
> the following error message was reported.
> 
> TEST: livepatch interaction with ftrace_enabled sysctl ... not ok
> ...
> livepatch: sysctlo
> : setting key "kernel.ftrace_enabled": Device or resource busy
> livepatch: sysctl: setting key "kernel.ftrace_enabled": 设备或资源忙
> ...
> ERROR: livepatch kselftest(s) failed
> not ok 5 selftests: livepatch: test-ftrace.sh # exit=1
> 
> To fix it, set LC_ALL=C.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>

JFYI, the patch has been committed into livepatching.git,
branch for-7.2-selftests.

Best Regards,
Petr
