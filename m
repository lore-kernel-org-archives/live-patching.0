Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759532142B
	for <live-patching@vger.kernel.org>; Tue, 14 Jul 2026 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006677; cv=none; b=JENkS3oy6EMhtPDMFgXgFPveu0baCSqokVPtXlaUzaAymwHi5Q8YJH9kHi9L1n4KPWJK8pY622VdYmGAJ50uydPiLoec5QQ72sACxjtnEMOAu7N9ymSvHNt2xQyddq93VvT1Cl3v7Co2iZPkCiw5eksjI5LJsFyLkBqkIZ3is38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006677; c=relaxed/simple;
	bh=Hq4vB5pKBrqWRzwfNS+KUY+WzqTdD3qtKW69BtbY2q4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fHBLwDpAcxMM3R+d1jCQemxBhUqjlldNu5eTaNjm6qowUaHlpZ4TgE9FMDWyduIHHPpMb7b30o4/jorl6L7cW2TDImT1lJOZAI4vU46cJokduwb+4260qTKuha5FPiC9/W2MxfnVKhx25/NIbIaPwNB7upeHB209JRkEzH+mvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=O5siSh39; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="O5siSh39"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hq4vB5pKBrqWRzwfNS+KUY+WzqTdD3qtKW69BtbY2q4=; b=O5siSh39l8EaNdYBhU9OLvxZxW
	Jx4z5P0Dmtc5Piv8NdtbPLdtSIodYXxzwCyG5JdvrPGO8RayHSeN51MKDtlsGTDnljibZwJyz9X5d
	tU6XGVGR2lncmvUG3pdQOAsJdJTHtt7PoRzAqkbAVGRCf6T9eUi/7AC0dNJ2koxcMSEFtRqJxXbTW
	GD6HjJ1HybjRdyL8RjY+BiwA8wbSv5xUyngprNfKjRN+R9EFKjFhSQwSrgN9hINeQokeCdw7WHJm6
	mERejxJdfs8m3qkz9fGeEZmimCuRQwbPv8rwahzR0LuytOD9Xn8hPfTYXgDr9bb6+GdGe0FQGD3+4
	y9Ht8O2w==;
Received: from [207.189.26.187] (port=63325)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVdC-0000000FxHC-3G4f
	for live-patching@vger.kernel.org;
	Tue, 14 Jul 2026 12:24:33 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: live-patching@vger.kernel.org
Subject: Dear live-patching@vger.kernel.org, project stage
Date: 14 Jul 2026 00:24:30 -0500
Message-ID: <20260714002430.4F235841F3201888@inbox.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day live-patching,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


