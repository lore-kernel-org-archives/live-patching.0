Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691824;
	b=GA0VNBpv12kVtEra3X/6qNloB7qNcOz9LO0z91o+2ILSbJBSvasDF9Tld4TuKfaLtIr4
	 +9LSVlVvMXXj+yjTlgD3t6g7kN2u/Yml3bzV+ucCmHOl7ziJZJvvOzNuvvpGQSqKY/ImG
	 WvFIPns2KDXLA2r1EF3nXc70iVzDjWtttWilsb+S6I3wTCHMlpZg6XmIj4pCO65MIMcp4
	 EAKspWI1q6OuTHoMPPZcRkip2uPTi5YcmvxARSUbWHx6K3uvOEg60VECZxkP6HFypyBm+
	 FVdH+wSYnlbx8eY+MP4Kvi4U1hHQhiMlKHFVJzThYyullZmxmnMbIWDBTCLMP5R+Gog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=czYZBdxur363VXW6RXUxmSDqGWBQiPGaiVhIHEEkG5Y=;
	b=xJ2axEJrxSy2Iqt0oHxvTc7ql7Z5umuX1/nSVg6qSp0YwqhMFnC1NIo0YqMm+4sbqHca
	 2Gh2ke/Kf5BjobIWCztbo+/YVxM0LlnxBwFu5rPgofe6vh9S8dS3MfYRIvyJbcixXgyNQ
	 SfmEjPWYHKp1veEpwV7hnuhINb5L8eFcLjMJNCEyq8o30+a16noXHKChX4NDlasInsR9K
	 hfzRsQPdoMuT3tZMG0f1cK8k/FXKgPBh9DzT0cQmu2uty3yfDMNUWKmWhpdJ/ISh4wh/b
	 3zo28iEx2g8qbOVwb20aP9t1BZs08nosfLDBrVOvaUKRVDZp4upNUdRl6sHd7UMmxkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyBQWANz;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7C606A32D
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 11:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D7C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyBQWANz
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso3288956a91.1
        for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 03:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795691823; x=1796296623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czYZBdxur363VXW6RXUxmSDqGWBQiPGaiVhIHEEkG5Y=;
        b=EyBQWANz1j1qfPDvGVsN8LvCj9Os8HsQNaVi1Kkr4N1NqYCaVX8CHFoeRWyGxLiwBM
         VAHKsW1r7PVcgOT0vR9krYofh3FEUe1+8VMOXLzr1btv8LL04hDFpzQ+l0mL1ls8lJYY
         CX3zOUiqEqWlFIggAMOPRfpn+IO7fJVox0XxGir7kQew5jnfOO9hVq/sLGV9uEwOgNMW
         AsudbaRDmrXHpVZyazL7tHR5vu0OFeik206wiFwDa3m/lFKYfcR6W0IB3bfE4B+hfAJU
         Jbyzeud8ApQOpR529kcNq9gifJxVbZf+vwAszcqyUn0TeBs/lz/uCeyJgzTk83mszXHB
         KOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795691823; x=1796296623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=czYZBdxur363VXW6RXUxmSDqGWBQiPGaiVhIHEEkG5Y=;
        b=nzR3xgSqQBmzH4jRGok6ZAPXzz0SXLTvZrnFL8OWxsny8QTGyFIzU0zfLQlAdF9+Eu
         vH1SbrV4KVNtVltGobvytimrabKj//z/2tYfncuiLslyw7FIMkLc0/+dDrWbwCmY29Mw
         qF8Q5orlZeug0XuuKtlLG1/URQHVEsPVOU4GoaZFmbYaf8xr7UqpepasLbYppZ0enexL
         VAF6WO38PTkR7/ltJJDmJOkbloXT1SmMRGbC4cq3ERl+tFGznb7Ttd5QHg5ZQMN9ecZC
         jwb9qOH8Vdt8qR6zDZx7LR+g1ZtQfSCTKd5t5VTor1aNOYnMvs53tdQ91XBJfjLCTG/3
         IR4A==
X-Forwarded-Encrypted: i=1; AL+hErEK/AI0XdSdNhNFZLnIrP0wzgSDq5Vy/67MyF2FJp3w3q2f4xnN6KbuDIPUPrMsZ9oVFVxfJGzYfZe0f5oI@vger.kernel.org
X-Gm-Message-State: APuU4Z8hqxDKSTCWW6umbavloRFT0E+PPCEsxbcPEb9FEStoL6JLDAN5
	mnfAxY51DKxjoURlPB95l6M3hIGbbHS3SIti/oVMPa+GE6VN1FDZdcil
X-Gm-Gg: AZFdTZednxPw1+rjoS0wemjcfcJNxhKw5+JlG4jjLCECvDxuogN+lgjVE5gX203ksf5
	sdOUMFbUW4TxqwaDCrNOuyuiIgoGIyPW1Q4OWd5QfLEsdeb+u/cWp0l1V+EA3ZHXqCe96u6k2+a
	NG1oQaT6ziRHAohKtFfWGBNKBAbmp8RJtLFIozoipErNCPrK6mcNQMv5vEeYCx0QRimkWPmzMI1
	wrmWGollGPKvqL0iGcpZ9O7XPhM+dN3tdmlIb+TbiqQ5SfOWkemLE8XIkjiJUI33EUJqOPs72R6
	2IefGmStqLRAv9r/q0KFPLgHp1fSkYw5P1FMh1P69tDTFbBaWGHdB7A3xMfo/VmRCrbRRT/Bnq8
	50+iWTK8z7ttcsRT7H+NU5CDF2IvB5EpT7kWwlt/lYv59WcgxHEJ+lSB/ux9ezRyz6rvMst1rua
	33tDe+rEcYVyUvgYLjeP4MPuKEB1vGa6codsHR0AnM2cUeL/DnDhOeoASEHZuSd+arxTosHXm0+
	1mrfpZiVkwrNNlQv8EY22x6FvULTK+8Dr/Ft5TucWFeA/08rSAbTon7WOJ4/RfF6X4OKgme+Ik+
	YsZxtwygtgFgN1o6OAG1NvT5hDaJF14MOWe2XC6uKKSo+OMiDSs=
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr19907158a91.20.1795691823100;
        Thu, 26 Nov 2026 03:17:03 -0800 (PST)
Received: from anatasluo-Precision-5560 ([2408:820c:d29:db90:58ff:756e:834a:9b39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8c2fcesm11796830a91.4.2026.11.26.03.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:17:02 -0800 (PST)
From: Longjun Luo <luolongjuna@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Longjun Luo <luolongjuna@gmail.com>,
	live-patching@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 1/3] objtool/klp: Build test fixtures with ftrace
Date: Thu, 26 Nov 2026 19:16:10 +0800
Message-ID: <20261126111625.2523320-1-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022171637.3298443-2-puranjay@kernel.org>
References: <20261022171637.3298443-1-puranjay@kernel.org> <20261022171637.3298443-2-puranjay@kernel.org>
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

When I rebased my patches onto tip/objtool/core (b99a5337da3c), I ran
the test suite on x86-64 with Debian GCC 12.2.0.

This GCC defaults to PIE. I got the same 35 failures with and without
my patches. For example, test-abs-and-addressable reported
"target: no ftrace call site, can't patch". With -fno-pie, 49 tests
passed and 4 were skipped.
