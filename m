Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A3223708
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300357; cv=pass; b=gA6RmSZQ1zWyVFLk9ro2ex885A7shVphXArTov8B+0XLSzr9ybfdgAT9BXttqReSnbHQWccnIRLzXKTpxr3JnjEmOUJefARHjNAa29rlg3zcCneUqGHqgGe6rwYn5zLizvAHM5GzcIThaZazZmeAWeI44twDbzxsghhlkX7rJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300357; c=relaxed/simple;
	bh=ZRvxCPN/Pn6xKN4kzylsdN8URZcXpD40RKKAE4yvtcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEPd83kJeMsTXSB81dyiUDJ8J9tntcr/Li7q6LE0mFBQ2lGGZtZiYFTtFAJVlAwlqKY6MAMvrq6UB2q81eCWNIohkeeqmDUeKyZg3NMHIwTHBcSH5A9reob4ivwdmlNCHCz+obwXGfnyh2Z9/J4m4t/mTBvZkeeYcuLbx7TAwO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FfTink7w; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=gFUI2ecx; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FfTink7w";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="gFUI2ecx"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679FmEFj1464676
	for <live-patching@vger.kernel.org>; Sun, 9 Aug 2026 18:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=; b=FfTi
	nk7wAnz35vkjyqgaz5kxh8xN/mxzF5PiLfKFsxowFPJ9BLT4e4XeNrIcqhwaVXWE
	dGBuWprH5ZuhY0JxYqZkg7ERi1/Uw3uQDeZL5p+GAl04552mj2ToUocoVEuEfxa0
	jGf+GkVtd58SX5y0mu7mJ/JIAFmr21JTqSg6ish8OBzj6wGxO2Br5377wCjldAXd
	aKt69xzBWYA6ZnkoPLT9g4ZrFweGpVG8siwTezwba1nMzPleA5qh9ilPbtL81hok
	WQcJMzGLPZuXrL9ha2pTuEPlC1AHsbYrCXXU+1HjKsbLzd6VCqKhKFOUC5N4Oo8d
	LUMWSqijyLQ2I86EAg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fxj9116wf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 18:32:29 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-822ce245c5aso39248247b3.1
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 11:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786300349; cv=none;
        d=google.com; s=arc-20260327;
        b=lHBJdQtAUroQa9NSm/JbDUnRIavwetlnvddSmcSo0ghyjrbbsxiekrSJhhWPmcIXCa
         Y5+A6GIbOnTkXa7+MvoDLdQ7MIyF1BU2qQ6ITa8+kpt/9JmvI76td6wOWo4XYNFcnUDl
         5F5/KditsKSnIF+lvtiJ09AXSpxBIiK9fs/EA7YSBjFaOwDBY343NPLEgfW/LIhHKHyQ
         XKRm+4rqNfa2fE58o/5HKI9ikAKInNAjqFrw2O3JjHAbef2dLTbInpFMe65Fpdh8o/C5
         z4W6mYn7VV/6WaeeWxkJHtjkpdiiGznpYwLdEvc1++8BKxVFaEwqm8EMM7wPY1bV9MN0
         67cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        fh=diPlowXmee2OsTC9q/ENphXFyTNGGnkmzRIZ8NlojrE=;
        b=IG8BAs5O/dQTJnRsYGOmAR9F2gvbVg5WkW652IBo3LHPFODoj/dTtYezLBAU55G0ZC
         9j9tsJ5X/Ao074yVoRBPcI5HIPNGE9H61sHfjw7TPYGm5VeqkR7PV4EpbUVSlWOC8skM
         sTBanJAw+3UIMYdO1p7q0HlParNaQRUFB/2bFp1u4IXRpHNrbJBffthCo3Kl/QMQDuct
         yuIVWbgIfd7Li3m+++E/78NU5JdKaWNl4HxXvM5hnux1vlz+8a/PkixoIpvyHoWgX0cO
         VvY86reo4ZxOYgxRpQA8ZbqumkUB7MOuVpPi2WSg866efzijV6HltFFVSuLIP9hibhKc
         KCZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786300349; x=1786905149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=gFUI2ecxASqj86RV116VD5mzrU5KAA/rbb1xhqriAdMmI9cPJveswvJ71H3YGcfjok
         kJFDFvQBuproli1/q6go3sHtL3OGBP6WxYsJgMpeb2mfmRDZDlZBWKV0qLNYH01FomLa
         SzsO909KdkM7dwdTgO0szrEiZtKk7TSLADHNYkcybF/SG6S+sMQ5b4tp3z1JVb4Qlrmb
         OPlknHMUlotlus548ElwNxz4ZiwUN4ds1ZiTBJv7TcCb4p24FfzKM8ObatNScjjmaia3
         bayhQrZ/dA25V0vzx9R+tj2mTmHKtpri7FPpaBPnzX9BlnwpOMmcj1/dSxUfKKlUCQxi
         jMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786300349; x=1786905149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=rHUILDIyIMH7WsZQPCurkx1K42qjRSLX7b1TIMzYPv3u1+ohVevqzBf8XYtSHl4B5x
         kGSbbXLJObck3HXu10QoJfyPl5cP3a+M3xh1dUE9ZHK3zTvjFhC4FTQ657QPMbx5reCC
         0azXSBveXC4RapKOJ2Lqx2qxImrxA1VtAWsOL9Srkd2A6Q8zRCFe+BIAefw60E/3++YU
         pbDtDef3xus6cc0gPwFYYeNFdmx3muqcrK6om0jYZrLpxkMdQqwBgObbrCQkty06Vhhd
         1ykLmor/0xgWbU/p+SOPkvdC8XhnNE0pgHfLNIqMQO0UQaaP9AA+ul2WAN7KNhAj54H4
         IQFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNcwgIyAfZfYwMj/MscVwxtJvytxFZmXy2Vp3CUS+2Jccx5592PVlGb4+AX9c1gv8Y1pXCE5WD4mQM0fHs@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4PYFDXEy43CFeg9eAPbhZXIC8spanW4QzNwdCE3lz1zT2hoi
	i64RRGvGDox3TujLH3cVcQ9tGZxpkCaH1lZt+3Rx9RL45GzSgymlNWUmJbMX911h34KCNuyr7CZ
	/DJqtzuALHutP81d6lkhWGSZxP/TNfRtSnaFUUHuMEFIHjPmbIW/Ig6iwxTP/6NsGJg5McHnKq4
	efMJbQ/41wQ53PUNobxxBvMgKO8jrXL6Vk3uVgrgB64w==
X-Gm-Gg: AR+sD13L+DmKUd4iILDUB1wUFfS5fPOdgwltkyJpcj17QRbWFhgTDO8gn8HjOqPEKus
	Ibzx8u44CH8T/f5/1TdmlsyCfX7wl3vkuCGu67D5r4q3pRF4zhdW96X2W9ptAVsfERI5a6hGX35
	+vx3X4Y0MKb1H+DdOx7z55C6XnPuzLN6eQ4vw4BSTxLDvkh8Tm8z8oWMIJEw==
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id 00721157ae682-8257357f604mr89550477b3.13.1786300348845;
        Sun, 09 Aug 2026 11:32:28 -0700 (PDT)
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id
 00721157ae682-8257357f604mr89550147b3.13.1786300348210; Sun, 09 Aug 2026
 11:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
 <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com> <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
In-Reply-To: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sun, 9 Aug 2026 14:32:16 -0400
X-Gm-Features: AUfX_mxB61PImxk7Ub1YrOZ365ALM_DPyxKzut-8yKDjXWIjCGfwpeEyQKycU1U
Message-ID: <CAOu3gNhgRTh8uZdfNf+XBpYuJWAFu5i+UNjQC2jce4DdRc-bGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a78c7bd cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=pl6vuDidAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=jPl8K6pqbzkCHX85MxAA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: Ob_uspRuvRypH0duPIxtHsD5_3EORlTB
X-Proofpoint-ORIG-GUID: Ob_uspRuvRypH0duPIxtHsD5_3EORlTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfX1lFh5YAeGuFQ
 ISUHiCLd0KVgPtPGvhS7vNvoQGEavbSao1SHBry0lu6R6DqwZAr1o+akmTntho4GhegFNgr0p7R
 GDUOBqZBCgtYJxZpTOi4fvZZBxey8akazlFjeCd3LKCbMT2iUDQ3XCz9Nav6azj/jyRWHp4Mn57
 nGe2yW0CjLfelxvWVk0MenKYm26NDRDo/PPTQfnCUceZUJMhmfESM1hLqArLaRroJWTQAgh28Eb
 3D1EJbpPgq54BWDgLXIh9MDV6NYcfex8/jbGN+/vSaKx94CR97NxxpzG5VTbNBrWn2T05ROUB4h
 tpOq58cEj1/z1eqZEHVb5bcYOMkRf+1eMvVvrtMUV3564TK3Mso9w1W2AbXa1otZiiyrUszWHc1
 gD1B8tHhY6VU1AHGi7cgssqeijI9VPbE5ilGkrLmaXAeDKZvrukwPK+8JhqNKNd10RkF0wTzqzD
 EpEQwIxIl/83uYFhNXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfX3wvDRA/0FxsH
 vMcKKD40kLEQYMlrPQlsPDB+V0nBO6HLxQrdR4K2nYneXXIGKmi3kHtofm8y1Ei1CNha96HUPmE
 ++6OXL0zyCLgkIV7rLeWPRmfPn3k6H/jC9JHUfyZY6ztbGK8zet0
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090168

On Thu, Aug 6, 2026 at 5:52=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > > callers rely on ftrace always being on). Refuse the write instead of
> > > leaving it in an inconsistent "disables some, not all" state: return
> > > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > > unaffected.
> > >
> > > Update the docs to note the deprecation up front.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >
> > Sashiko's comments make sense. Other than those:
> >
>
> The bot has 2 comments.
>
> In my opinion, the test-breaking comment is wrong as he looked
> strictly at this patch w/o reviewing the follow-up live patch testing
> changes which update the tests to avoid breaks.
>
> The cleanup comment is valid but since we aren't sure if we'll need to
> revert this change later if it breaks userspace in some unseen way, I
> wonder how extensive the cleanup should be? Steven, can you advise
> please ?
>
> Andrey

Gentle ping on this question above Steven.

Andrey

>
> > Acked-by: Song Liu <song@kernel.org>
> >
> > > ---
> > >  Documentation/trace/ftrace.rst |  5 ++++
> > >  kernel/trace/ftrace.c          | 43 +++++---------------------------=
--
> > >  2 files changed, 11 insertions(+), 37 deletions(-)
> > >
