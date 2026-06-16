Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF643E48C
	for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624152; cv=none; b=mZmsK4hbrzzCT+G5CFhLPfzRs76fFYglzYlyN1Y0ZvtTZUt63K7CuyLOr5XGJX+nE7h4hOjWDsScuyE/iGkogO587CQwe8CWN/6ByKEJqbnlKucqRGMQS+k/DBmRfmFnqPPmvrLyxAf7jh4wbrZ9AFq+pGK15EsDqINaQvG4i+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624152; c=relaxed/simple;
	bh=/8DFpduGkt4/ysrrDXUYrh9XhN1lymFN9Aa0WbeYTQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gKIub+M1n3ND61l9lHvqoTNBrk+TBYfWrCJ/xXpPEGoSpZQq8tr3ibj6QXLoX+CC7aamwIEBbjpCg5z1r050XEKT2XMt+hOTRxuaohpaC4Y1abX14cXvUWI6b3g+0lt3R6HnU0ht0YVLokx/cm4VSvr69fAuMPm3kWGdpUTvxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fIXHT/1u; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fIXHT/1u"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a76757e5so34299925e9.2
        for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781624149; x=1782228949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiEogWM+BJQUlMNsCb2HQpUOqr6pmgn69qszjOE3sR0=;
        b=fIXHT/1uYAyLz8su0w/BoeRlDHWU63vopt/biXyuJm3srbZJP3BGw/3KVYTeTYp6gy
         Nsi5XbN/nRy8tNS5yELKXcUCAX57RJuaqpNFj14xQMFLKmaXwoDiozGzSQsXq3aPN3XD
         oPR1cX9HHEnm+KEVMT5W6w/n+s27s7D7U1ejTSCnt8tmugQKLz1nmyGpNB+yio/C3/tL
         97zhRIW6WXJgXxSQQ/HfNSIjY6fVHvis5L0e2TsK4KjfYR9PXotJsfAZgQngD7ZqE2Ek
         CLB/UaeCREaPaLDXdKCgPzOy4bV8N+3Xs5B+Ds3eweFsuAxvEx6dqJVXSvFFgdCRwzgE
         gWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781624149; x=1782228949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiEogWM+BJQUlMNsCb2HQpUOqr6pmgn69qszjOE3sR0=;
        b=cddXAk+0hIBBQYPJYXYVYTE50MfxkQtCKdho4hLaSrxbiA4Xlo4NCwrbCq/bvgips6
         dLXRr8XZhSp6a4of9brU+JPoQAwUhbIQ8NQxJX2W6zu0K1jTzOPUtIZ4BWhgmm5S1ngd
         x1HcU0MXA3+lYfS3nI8eYK7dNRX6cJE+NB4lW7uiroFvYQi6O1PgA8TIIQSvV7jxUyuU
         ZlX4+0f1dCRPh910gTpwtONSe6+HvLdYE5p02P6Qab6XwvRkB9bbBE8x5XMqRPOSBYw+
         eek2++DxsdbiKBFWw67uwCClwxPT/C4PDQEQHusILNlQFzORn31Lpt2kSy1hdbfjNwmu
         2LPA==
X-Forwarded-Encrypted: i=1; AFNElJ8IGGP23gLYh5Zrn61pxnlg4I93yYmwA2SfJ/jZmGo+F19FX48ypGUyxbVhFFUpNrywGYra8iIU47P323Rq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaoop56mNb+8J249SqlbnOSs6nQ5+HdQidAaKj5ZSLVjc1WRgW
	2ooLdUainndoSpBT0/fznyYrsDFXjX6aKHW079WXZICTc+K215coqUNRzShloTiDHqtCdQ4YpY4
	izgQy
X-Gm-Gg: Acq92OEYgEq5TiR+Zz6TySlvLIaBUCVxTOMJfgmbxgmIRcwBLinqVyT10Ef8sFA33K3
	Ct4cBFA+49lDAjbzZitynxgKF6Zgnj/1q9NAjdIKt0UBIokUVnfUIBv8/2hTmG+YVD0Aes6v5uo
	lu8KIZRVVF5V+6sVenJdKiXG+Pd9SpfypfNH+PGJ/OJB8LpSqmWrFx3S1AxlzNvAGVlJU2yC1o6
	GYdSVSWU0ihnhciNwokxPYmvzUZM5MRhzbKaA2/lJO25nL99kIkhjYdU42eKCwrPLGfHWPPF7zD
	t5F+NfQN5XCWCy41ROopgQ1NaQ74Wu7x4+DQxnmjaMcWroJ9B5kPGo+UJyhSm1Mbq6ngRFGLOM7
	pOUA1BV/RrFx7yCVXMtyLfxbp/Uz0zAWhorGK9FBwjqk9bcyaLc9L+b13BfJLgxLV+VUiInSJKC
	3reK5jBInHDzF1IfykwNr0uO09MMKlm+A/ID7p
X-Received: by 2002:a05:600c:a104:b0:490:b1b8:95f5 with SMTP id 5b1f17b1804b1-492333bfb4cmr200525e9.15.1781624149482;
        Tue, 16 Jun 2026 08:35:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm46102740f8f.1.2026.06.16.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:35:49 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:35:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 7.2
Message-ID: <ajFtUxjbisYnAHSz@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest livepatching changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-7.2

===========================================

- Fix a potential memory leak in a selftest module

- Make selftests locale independent

- Allow to run the selftest with older kernels back to 4.12

----------------------------------------------------------------
Marcos Paulo de Souza (6):
      selftests: livepatch: Check for ARCH_HAS_SYSCALL_WRAPPER config
      selftests: livepatch: Replace true/false module parameter by y/n
      selftests: livepatch: Introduce does_sysfs_exist function
      selftests: livepatch: Check if patched sysfs attribute exists
      selftests: livepatch: Check if replace sysfs attribute exists
      selftests: livepatch: Check if stack_order sysfs attribute exists

Qiang Ma (1):
      selftests: livepatch: set LC_ALL=C to fix locale-dependent test failure

Rui Qi (1):
      selftests/livepatch: fix resource leak in test_klp_syscall init error path

 tools/testing/selftests/livepatch/functions.sh     |  12 ++
 tools/testing/selftests/livepatch/test-kprobe.sh   |   8 +-
 tools/testing/selftests/livepatch/test-sysfs.sh    | 213 +++++++++++----------
 .../livepatch/test_modules/test_klp_syscall.c      |  33 +++-
 4 files changed, 157 insertions(+), 109 deletions(-)
