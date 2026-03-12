Received: from mailsender2.cdac.in (mailsender2.cdac.in [196.1.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9D38D010;
	Thu, 12 Mar 2026 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=196.1.1.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306286; cv=none; b=hiyh8G2sZ69SiT7s8WWm9zMOIfoSvM8KvEAZ3ISMtr9cQ0l2rP51lc+FUuqWlISqjUxRSN1iYtojl+QmJB+EXkHZW60I8C/6D16vbhMLgz3rwyTBCt5VJQPN3Vy70+u4hkqPlBPuSlgSkzMKaavxJoveWzdZuy4DWmztnU8WRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306286; c=relaxed/simple;
	bh=cc4sUo8ABmfAJfiB2Td65E0S841rDp6Ssvqun49TuE4=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=l/vuoX4dhgLHMXj289q/lqnzO+qzuqoMSeX1djWxud4gKOGi3Zt5oWnQ65OzSJOgqWTfVpg3JcVGyL3/LWqNNQUP+7ITvFaLpd9EVujvyrWgcq4+SRuYAg1qz5ucwA6+gIyH1OMHi2Hu1lEKY8K106QtpSO7iOIRfVWEW+MnMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdac.in; spf=pass smtp.mailfrom=cdac.in; dkim=pass (1024-bit key) header.d=cdac.in header.i=@cdac.in header.b=JlnKRyuB; arc=none smtp.client-ip=196.1.1.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdac.in header.i=@cdac.in header.b="JlnKRyuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
	t=1773305593; bh=cc4sUo8ABmfAJfiB2Td65E0S841rDp6Ssvqun49TuE4=;
	h=Date:To:From:From;
	b=JlnKRyuBoxttzfIT/D+Gcwxdah8FF+4gp9j1piGPmrT49Dx+lBTYKdajPZE+vvCKB
	 7qhhSa1ibrfQdjBIn3PA+dF/aKl6DuxLG83D9YnuYUdi9fsK4jNMWFghC/TpiFZl77
	 L1P1vwn3b6yvtWc1yTHad0scWkqeAYuhq5/li1q8=
Received: from mscr-int.pune.cdac.in (mscr-int.pune.cdac.in [10.208.193.2])
	by mailsender2.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 62C8rDgq3124766;
	Thu, 12 Mar 2026 14:23:13 +0530
Received: from mailgw-cip.pune.cdac.in (mailgw-cipdc.pune.cdac.in [10.208.193.4])
	by mscr-int.pune.cdac.in (Postfix) with ESMTP id F114E10006EE7;
	Thu, 12 Mar 2026 14:23:11 +0530 (IST)
X-Auth: premjith@cdac.in
Received: from [10.176.18.227] (hdg_hdg068.tvm.cdac.in [10.176.18.227])
	(Authenticated sender: premjith@cdac.in)
	by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id D6B5414E0D93;
	Thu, 12 Mar 2026 14:23:11 +0530 (IST)
Message-ID: <b8c3ea1b-4658-4278-9e16-578b3b802f9a@cdac.in>
Date: Thu, 12 Mar 2026 14:22:13 +0530
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: majordomo@vger.kernel.org, live-patching@vger.kernel.org
From: Premjith A V <premjith@cdac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more information
X-CDAC-PUNE-MailScanner-ID: F114E10006EE7.AE9BF
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-0.199, required 6, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80, TVD_SPACE_RATIO 0.00)
X-CDAC-PUNE-MailScanner-From: premjith@cdac.in

unsubscribe live-patching


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------

