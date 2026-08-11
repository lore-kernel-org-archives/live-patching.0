Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0A331ED2
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465046; cv=pass; b=YwBbZv1UR4J71gVZ7ABwRxYJHYtjU6YthjeCCcTyRx3HNA+k5fDM3sFurpPKH6UBRIO79PkrURsyPFQCsX4gkOaM2CyE1cri4Q7IQgcRTe+5q0W/PI4S3Gku4x8s8OCbQzKMo1s3XdoxHXxy2BIikMPc0p5rr1UhZMcBS5DzfGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465046; c=relaxed/simple;
	bh=uS1uPWeUp0gwSJl4xgsxYxdmclbK2mcyeca4b5tZX4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZH0rntwJ+fhFb52lJnQhFSd9SVSB345VY03eQDF/9Vosr8y4/kuLrn0+a8lYySdo2lXe9HeJhYjTt4rAynIjp8KdiJS0sNqfopuqgAmA/zrllXYoO4ByY7KyKwVkKcd7Z/e+fKUnauWcQQucVkBWemZW0FRHR9c34YnPqzkAcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVRFtHB6; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVRFtHB6"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1f5208b38dso1919566b.0
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 09:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786465043; cv=none;
        d=google.com; s=arc-20260327;
        b=EQB3oRk71IvDWUCA+T0pah6M/avdjNxlOF4g0y5RbhdQ3/vpJASxw4D8NJo9tcezbX
         tyBk80abi68FfmIa7FIz0vMT4KHl35cOfv5iiCleB85A5Nmx1i/+D3LRCHwCjYKhN96S
         fjscbIQdj/JDLta/8LKEJ1r7FPdNpPt/Jd7fnkYB4hb1JqCNyBR3xVdBxyQ5W/mG/Syd
         1E7uypzBeGR0wiS3aZKi/XcX4njUg108BeI/fFjeAepz1Xj+zKjhxEnF7AdDcx+ZTlhn
         CC9HlNyCRFQcN1osLnE7Thx5X2I0M38fJswlc39jpoJuquqddH06q2p17wC6Pp1NDZVC
         MVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uS1uPWeUp0gwSJl4xgsxYxdmclbK2mcyeca4b5tZX4g=;
        fh=BqUhul14qCQtJXzfBvpAoufN4Up59SIs56eoZtpZZ9M=;
        b=WdXTx64ycyQBTFazpKgJi3ucfd1XvnwhaN2LC8R436D+1q7I/1RCFozuwMPLhw7cEu
         7zj4cWX99gCqmvBbbj3k8VuhLeazhzblsqAZ5fJ4oS+3/S/FDCtu79Q885HWIFHWlz7R
         m59e3OXYhiG+3hSuz1gUk6CpmtEr833PBq3kIZRhfNyfN/+17twq2avy7Rx8BtW/tFOP
         84CktAhLzCXLKaJf8j5EOAAYHsi81k+AJ9gBhOq3FMnaec3bFXAsI6VhTKHNpsdTcU2A
         u3/eDjzMH60U+UGmOokp0F3BwLk2bzUG8eaZmCDG8I19JqAsMatTSNb+sN2l2/EHciFn
         RU9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786465043; x=1787069843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uS1uPWeUp0gwSJl4xgsxYxdmclbK2mcyeca4b5tZX4g=;
        b=jVRFtHB61w2wV1rD1G0TEex2hSEJ8yQ6PyQZpGjbOo+wI8v3vI8BLC5XxcqOfHhKt5
         9J2ZWSoPAR03S6gr6mqc2P7+aiCnBnG5bptidQ/aMYm+hrE/Ikrs+iU29gxFw9PW/XWz
         lt/OwBuFQfUftOonF9JyDY10UFmpmxL0nHcM0063lAbkg79UVwrVikxLr81FSAFaZRtJ
         VJiuISxKSqJop1s4X2Ff3uXbR3gPHv8p7S71kz9GVpIFV0oApgHoJ9pjjJPZ9dEffj3A
         bQd2t3698SAZY6Skg0cfJqt4YMsE9w5nPXy5S3HVrrjxKDveat3Z5Dp504E5YKRMRREh
         g/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465043; x=1787069843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uS1uPWeUp0gwSJl4xgsxYxdmclbK2mcyeca4b5tZX4g=;
        b=biBMnf9yLLLoLsN2UmVlqC6f6HkBNqBb50CY9v4yhFnrKtY6c6x1gRdJqiTKoUBmhQ
         U/2Hu2BmQLHQkFurR1OcX7wpI23/Af+PQbpZ0uN4Qtw5jlZmXNrGS6sixFbUUpyN20BJ
         8T1o2Z5+Gp20ZUUKPM/Gn9HA+Z1j1w1zvQyXmy3vkXlE3DgHxMQzsKPa3Pn4A8sufUp8
         0tsQ9ZHj8KbCpdUMUdLOXIBMVNMfspkX44jMpGhoeLp5C02c22Dxq7tDf1ktvkKxL9G2
         DMPmyC5vsVvao6oownYYgNoLlt7KqFk8M3MkkGILF8B3XxFLgZHdXhzORlJ/4S+6PCSn
         5FVA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2qRMEKQdYwxzHE89rldEMYNp9rucSCxuYNxTvPUkA4l4ycoaerGRpJz713FRBxDIQoh5KDlAOMvU1QYd6@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNbliBoGldUo60t58g+vVrcwZ8drhpjsZzP5wdkpvhy+K7Ojc
	q47eg1xWUK4H8zEsmhgFHG7AEHObTm4WNNAMr9u3LMqfkTHuMUJE/pws3a/Wt5TrjsMEUuGFwhK
	EAellp3TEf4TxyMHwjAy96fODvffKRGErwdIFWH6V
X-Gm-Gg: AR+sD13LzDse5BOuYMQFhYRyx03agwmbM773F8oP0iybRN8cR2h9fNaftFHzIfEOoy4
	ImC+87vwn6zCt1Y0XZV8mwL/UGMqSlx9VNTAmWrcl5rOTzNd4KQ43/Ybf1yXs2uFy/ZiFc3QCMI
	UXOJ75bwbvi+/jntmDY+Z9IYVpos3JrHACQ5EhF1AW4zHtP4jAaNAMMJTOAKggflBDTLWjx7Hbd
	RgTjORvtZt0JdBiD4J6JAZnQXweNb/ChlNHnRG6j6JyspPzZKMNWZ446BfV1fhs1A2vIZ4JPD/Z
	47Gsfs9/u+n2IsaOo/n/WZ1CR8iroWo9qLHyEH/6YThNUl8bEmbBfUxL0b5vFEXL8e1zWJaJizq
	ioxndAzYEs+E4yex7wng4X+Irr6yUFB7BBJfad1xNCVTS1E9a0QVZ11gy
X-Received: by 2002:a17:907:9281:b0:c16:5f28:4575 with SMTP id
 a640c23a62f3a-c20ecc7e587mr83999566b.31.1786465042229; Tue, 11 Aug 2026
 09:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck> <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com> <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck> <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
 <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com>
In-Reply-To: <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 11 Aug 2026 09:17:09 -0700
X-Gm-Features: AUfX_myrZCwdGci7ik12sPfl_MO6F_0C3mcZPp-3E0jT-vc4rIXwgDm2Mzga6bE
Message-ID: <CAKwvOdkVxt-90Z_Af8s63RKCY-202r_0_bgF+8-g7iKn6XM_Sg@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 6:18=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
>
> On Tue, 11 Aug 2026, at 14:02, Ard Biesheuvel wrote:
> > On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
> >> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers wrote:
> >
> >>> Sure, but let's replace this with a link to a bug report in llvm's
> >>> issue tracker?
> >>
> >> Yes, please! I can apply the patch once we have the bug number.
> >>
> >
> > I can look into that.
>
> https://github.com/llvm/llvm-project/issues/215547

Thanks.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106671 was closed as
invalid pointing to the same commit in llvm. What's going on here?
Where's the corresponding feature request for GCC?

At the least, I could imagine there being a `-fno-omit-bti-pads` or
whatever for the kernel to opt into this behavior.
--=20
Thanks,
~Nick Desaulniers
