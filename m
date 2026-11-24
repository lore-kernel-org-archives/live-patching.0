Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795496268;
	b=Qxg3sbYutpB33NPf3/uXAc5GAtt1nNydWioQNZtSuXuqwkuRTWX3dKIS8L2p4Et3XA3h
	 hf9mgbeiWooDK0j4sSe+pQtDQnBHcoyltVil7+cDNuoT0CeNL+L6y2RU/FTdbl5ZlymrZ
	 jApC9AjaxqxHa1cbrBcQrYQllTxJZBT+8Dyh93gV6D/+PuZt+trFZoUSvmzPmIejSPTTm
	 f6RthgAqw5K5nWD3lIqPIytQZ/DTwn3onM+JW5vQKW9nCVfclkhNde1I8cQVF4KM6NoUS
	 p64l+Enz5fBzMCEMyFTuaN62oRB8woLvQ3TCqr5sGEQUfP6Y8Eb++OjOqnPEjPkAE2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795496268;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Z0iSzh50XNuuriptWIm/rtMzuW6UzsvxUaDnRg53SM4=;
	b=rbCUIGHpeb8yKlSDqyG2ZDblFm7F7mMVefeIehCSulFIUZDP3lvSEmDgO/TJz/XAjLfL
	 igPVhzwZR0aOWxq9tzGHj+z3KzA/shQQuOcH3fmEQLgUb57CMDe3DN/QWw7dSVeGuBLWu
	 pDgLZeoV++lhFvLJWXIRvrE9lqIPotDQmFOJmW6z5R4NzGSZyIo2wgabOlS0HlJ5W+/Uj
	 vAAB3KzRl3D1PJhn4iKb7bb0zuG7eETV8LObDsBAkeactdJdvpNK5xxcYcOKoAYvm/A8h
	 x7WtsSe25va3wf0QMnW0WFwHxEEA2smBzTdAMU9f2ZfUAYgIYIY7KdT29KQZYi7w5HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=2mStwHrF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.108
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021108.outbound.protection.outlook.com [52.101.57.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F1606A685;
	Tue, 24 Nov 2026 04:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05F1606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=2mStwHrF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ils53fkjXlzKEAQeF7wJ0bYbfvLR59Z6ylxa4D4/KSkd7pPpwUdgwTSA0KH0lBG5SR27R3Hx0cbo/py5pSVZBMS3Ns+yIA0xejvfBIAihb3GcQ6da0/qdMGvdECezzUb3fq7O9wHFluqcphHkxDHt5EnBRfqXVwIkOT7KnRAgPfI3yT9THKyG8SqeTktW5yChNBdEll8s+46YkkhblM3KchXKdR16DD7bwJdoPZX4XtY27G9NwtXgRjvzPV32xa36TYWKdUDpT+SJuZachsMt8/h2T8R8Jrid+UYrAzxLa++XUxsPI8Vp+pGvRgMJfvTNsbJv45d7xWTVVvoPhHjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Z0iSzh50XNuuriptWIm/rtMzuW6UzsvxUaDnRg53SM4=;
 b=NAvmraXonKdQUxEdhQEL35eURJaDyOzbO4FEHPcI2f648f4xf5UXLIZh3vbDwuWdCL09G5nOHt7thZdrk5v0mGcjgh7pXACwrCE0pHo5APUfTA4ZtxtY9gqAkQZeszXqC9qSfLxIdeHi/kgsOY0SPh8PEd6vR3bVNCXFfbiM+oNRTfV00ktdE4hhgpCAs1MBDq60jP2cbikZgFn+fm6dYWsIYR/DGE8jlSz+OA0qMkgAGoVCX6S9jfkcs/7PyiEu86HY5YnoLn6gwuV1bP21qZud8FKRCMX9gbOftnm01EYygl2J5wlM8yC82PfgCxuJOZZQ+HpA35XH9nDNwBFd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0iSzh50XNuuriptWIm/rtMzuW6UzsvxUaDnRg53SM4=;
 b=2mStwHrFLEvBJn+w5zwDINe8jF9zY+VVA4ziybRIsLiBmKQL8WPjVUBodsSOyNpMnGhiqtiCDEP/3QvC016nqlJueR0cAPdARkMm1L55Z8NHLsWtVHd/tHDEjX8WDd6P67Bi92OBtIPDReMHdXIhMzCxbtD/Cd3MmJu/lXW3wR4=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 PH0PR05MB999056.namprd05.prod.outlook.com (2603:10b6:510:42e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 04:57:43 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 04:57:42 +0000
From: "Ravindran, Binoy" <binoy@vt.edu>
To: Yafang Shao <laoar.shao@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
	<frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, "live-patching@vger.kernel.org"
	<live-patching@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
	<joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "live-patching@vger.kernel.org"
	<live-patching@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Subject: Re: [PATCH 0/2] livepatch: Do not lose exiting tasks during a
 transition
Thread-Topic: [PATCH 0/2] livepatch: Do not lose exiting tasks during a
 transition
Thread-Index: AQHde4yeIwbsGnp4R0y51MdXMm7dBLc8PZ1JgABb5oCAAAiQFw==
Date: Tue, 24 Nov 2026 04:57:23 +0000
Message-ID:
 <DM6PR05MB41377901DA5182DDFAD6E3D4D1442@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
 <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbDu5NmVowk4SHzeUDxASaxKkbL_w1dModFWzdi8yK9tBw@mail.gmail.com>
In-Reply-To:
 <CALOAHbDu5NmVowk4SHzeUDxASaxKkbL_w1dModFWzdi8yK9tBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|PH0PR05MB999056:EE_
x-ms-office365-filtering-correlation-id: e2f9058b-4cd7-471f-99e2-08df49e77927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|786006|10070799003|23010399003|261028144727099003|38070700021|10067099003|4143699003|11063799006|261021121427099003|56012099006|261021123027099003|261022105027099003|261009223027099003|261022075727099003|261026140227099003|261026121527099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 vtS+9/2vIAVwhcUAnNl+/8R1xydNKLFIUp6Uhh7SJXxoy0076btySmUVHrstDTk4GOcwR5EMK5eskTjbvFyZjmmgMZExJvqwMJhH9M153jePHV79eCLs84sl1VRp98Rc/dzBgl7SWzugJbUa9oOkIo5mLMxRYN02/DywFz1SzXTifW3kDAWNleIwOzLLGqYDbZfx4XhA6nmIJaCBK+B0/+is1+8gsXycvkinQV7GGNDUswD1jveD/YQlhUQLmKYcBhEzzdxuTgeNBkvKn1YQHY52WJOdwMjEGC/YtufV2IIjZW7DTmJ/IUIAKlOzz3G9eSBkQk8cjjeMZSFnzMtgxt/V9nZdqgbcNLCan0cRdB8LpOdzA2GaNxVlv+r5rEd6yNnGGfDN4A7Eo+4CYb4Y20LTUeBlc4/9nZfkIWQidzBR11/zFp/dz7h0yxis6fNw8U3hgwmFq7PXDshU/CYUQ1K43GWg34hhxS0btjmqgdZKPBQBNJOYJgxtSkQ0Az+mkwSi+3Z5eTBYOMJNWQB5WJvi/V0AmKLiT5zqXAXw9Bi08UUPgM80ny0eO7JXEkKjFvBgSLDDhwso4hAdaXqLUnZyARklNWQ3Io1ZWr4CbKvy5BcJI7rBZ35OBr0ehB6s/dMffQVPXDnpgd6Ta9V2N7b96g8nibf3TKMrqskvOOBuLZpn8a0fi0bY3AkbdwxD+23mfNTsRwobtkIlDqUHV740DJLczMomebY8JgU+E9U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(786006)(10070799003)(23010399003)(261028144727099003)(38070700021)(10067099003)(4143699003)(11063799006)(261021121427099003)(56012099006)(261021123027099003)(261022105027099003)(261009223027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2DzJy1s5MYBFPhLQy5scIQ2EcNEHOF8+RiOQlJIgk+4W1RfbNMe5pLrjPf?=
 =?iso-8859-1?Q?UU/x/s2jedFvCHOclzpxBF83tWeRK0eOPSkwEdCKYSTI+inuB4akbq14zd?=
 =?iso-8859-1?Q?aQDtTiOLRVCLoPc6CEdOHJUHDXoGgGCCTY/MALHqGngbqedvntF9zPciLk?=
 =?iso-8859-1?Q?QvUSYuVf2e8rmTQmh1NZgzf3E8YVhIhMoQyHzF1oVTeHPvyCouVRDrAAFb?=
 =?iso-8859-1?Q?3hY5ePY/+wYP6ZlAOSbv+M6iZi46JVjSCYQTUZua4RLFB26glN0Nf2HE0D?=
 =?iso-8859-1?Q?bAXbD6QYVdrvphsgBQTtUgI+wKHtRjxx2w06qgH9pHu4OFp/nsIy90iQGm?=
 =?iso-8859-1?Q?+0spI9BKqJXu99bbpz4NH3UdFa97xzLaSl8chhZe1Ub2c/XnA5a/+40yrR?=
 =?iso-8859-1?Q?LV4OPx6qYM1yGkzfMqbLC6TGzlB5yV/RWw8oSVbmjp9uevHHlAmvzbBGgk?=
 =?iso-8859-1?Q?3uKT6W69MC0w+WfAgAOErUsPpzag0gcjySZxM34SBJAyhYqk6Eo1GGVCSh?=
 =?iso-8859-1?Q?6ieF7KW+BZUvn3RA/9sntbYVnI74IFs0UUvRZWigntN/Irehe23Vw0Twdt?=
 =?iso-8859-1?Q?rmII3e99ld0sWIxtvmlSDHJdhsIIXIy9XBjlGWtb28qedeafqp5QVBhY35?=
 =?iso-8859-1?Q?hHuda+MQ67tVW4Pbb/L2yD08ifk+d7EMAb8lwtiMriZM9yLJC+gVrW9eDy?=
 =?iso-8859-1?Q?5V8RbV9YbLTgkgz2uBBvYqTAX49HnI3ay81UCmo7AGxVqpclgz6ZyMRXDa?=
 =?iso-8859-1?Q?b7VjhHM+xBAkQgg2I+LFLeBBjpO2qbb3Bi8rWRbeCGcM8eO1L7/2xkNAPi?=
 =?iso-8859-1?Q?qdHre4lPVw4NRw2HGCxcQ2zgY2Of/RZx+ikP2jyAwPGv2CYT1JQgs+SIi7?=
 =?iso-8859-1?Q?b3r7c19qTYn6D9JfmvtAL4U27aXiXchUozyeENnawMg/KP7aVKoNFLjEj2?=
 =?iso-8859-1?Q?mMWNVPBsAqLAAyZBVnJMj7+yAlnzszDAEaYjL4/lzyVRUtPg0GRpYZFMq2?=
 =?iso-8859-1?Q?Rh/YFz7Op5zc5dHFcPpF1SCsXVV3LTJ7bGmbGv7Km9V5RZ9V/x1z/xWift?=
 =?iso-8859-1?Q?TtmCk8sW81PInpjB6SgNBZ4V12RuxnX8FK1iXATlCqIcU9RUuros1Ed1RX?=
 =?iso-8859-1?Q?nqyKVzZgAmT99raxWKHcdVLHF2TnMMDNgM8h3w4NHIPahHO3bhwRkSZNyC?=
 =?iso-8859-1?Q?ZgKc2aeE09HxPDDnU98qDpjbAaeKHM2UMG25+2orbsBw7+vl8ayKsPzqEq?=
 =?iso-8859-1?Q?rmftUqbXWmDHcA7Lh+FaIvNtGtWoWYmSPMo2g/vTq72ng9lfUxlVlwlEsk?=
 =?iso-8859-1?Q?P9A80YfUgCTAkXqab75mCJn0NIkVIJS96H1ex/uo8PjI3HYQpB/5rkapfo?=
 =?iso-8859-1?Q?hohzRRAxxeUl7tQcwMH1CXPaz79R2+VxtjsdysuqbZFZtaEGZcbtCcVas8?=
 =?iso-8859-1?Q?jH8xR0lsv9tvlwu76cyQvUV9UGkPp+n9yn9qz2VhCyL3/UNRfCcAKnwfnX?=
 =?iso-8859-1?Q?Txnw/y4SSmAhRXw6prR0qqXFzTIYHpl8kXlpVFe4mBF1TJAcngHxiJjB3l?=
 =?iso-8859-1?Q?ljEoBJKA1/Zf3MQ6aEyfB7HvS3AkLCBOPySp/f9aTVeTF7iQjlWDZAmPtq?=
 =?iso-8859-1?Q?khJnQ8U7hxwt6AbAXCyXkDEpqArzwwKVvD6Yj0TZkB9IdL+DP6OeHkbrgC?=
 =?iso-8859-1?Q?q9oFIuL4b8sKGC9iaVOHpc4mzLfHJIdr+M1jwy8Ua/otRnIep0tTsew+KB?=
 =?iso-8859-1?Q?F6Zp/rMGgOdS7ewa6bMdy48HGdPIBdFTAWbXovjBdBU3lX5oktInuK2SeW?=
 =?iso-8859-1?Q?r0kFp+JrSg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: vt.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB4137.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f9058b-4cd7-471f-99e2-08df49e77927
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 04:57:42.8270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VefxIqF4dzVihkuLjjlHpl0Mjt/CWLviZCkcglFznRBTVvrfCSlNA9JrASzruJit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB999056

=0A=
Hi Yafang,=0A=
=0A=
Thanks for the pointers to the earlier thread and to Josh's=0A=
suggestion.=0A=
=0A=
> I did not take it for the same reason Sashiko raised in issue 2: the=0A=
> RCU exit list narrows the race window but does not close it.=0A=
> I could not see how klp_synchronize_transition(), as you describe=0A=
> below, completely resolves it. Could you please explain that in=0A=
> detail?=0A=
=0A=
The exit list alone does not close it, and v2 does not rely on it=0A=
alone. The exit list covers the part of the exit path that can sleep.=0A=
The part it misses cannot sleep or be preempted, and=0A=
klp_synchronize_transition() waits it out. In detail:=0A=
=0A=
1. Where the gap is. An exiting task is on an exit list from=0A=
   exit_tasks_rcu_start() to exit_tasks_rcu_finish(). exit_notify()=0A=
   runs inside that range, and the task is unhashed no earlier than=0A=
   exit_notify(). So until exit_tasks_rcu_finish() the task is on the=0A=
   task list, an exit list, or both. After exit_tasks_rcu_finish() it=0A=
   may be on neither, if it has already been unhashed. That is the=0A=
   gap in issue 2.=0A=
=0A=
2. What the task can do in the gap. do_exit() calls preempt_disable()=0A=
   before exit_rcu() and exit_tasks_rcu_finish(). After that the task=0A=
   runs only lockdep_free_task() and do_task_dead(), whose __schedule()=0A=
   is its last. From preempt_disable() on, the task stays on its CPU:=0A=
   it cannot sleep, be preempted, or migrate. So once a task is in the=0A=
   gap, the next context switch on its CPU is the task's final one.=0A=
=0A=
3. What klp_synchronize_transition() guarantees. It calls=0A=
   schedule_on_each_cpu() and returns only after a work item has run=0A=
   on every online CPU, so every CPU has switched context since the=0A=
   call began. Any task that was in the gap when the call began has=0A=
   reached its final __schedule() and will never run again.=0A=
=0A=
4. Where v2 calls it.=0A=
=0A=
   a. In klp_init_transition(), after patch_state has been set on=0A=
      every task (the task list and the exit lists, walked under=0A=
      tasklist_lock) and before func->transition is set. A task that=0A=
      the walk did not visit had left the exit lists before or during=0A=
      the walk, so it was in the gap when the sync began, and it is=0A=
      dead before any function enters the transition. So when=0A=
      func->transition is set, every task that can still run has a=0A=
      valid patch_state.=0A=
=0A=
   b. In klp_try_complete_transition(), before it calls=0A=
      klp_complete_transition(). A task in the gap can still be=0A=
      running code reached through the old function, and the switch=0A=
      check cannot see it. The sync makes it dead before=0A=
      func->transition is cleared and before the old patch can be=0A=
      freed. A task that leaves the exit lists after this sync was=0A=
      already counted as switched, so it runs the new code.=0A=
=0A=
So there is no point at which a task that can still run patched code=0A=
is invisible to the transition: before exit_tasks_rcu_finish() it is=0A=
on a list the transition walks, and after it, the sync waits for it to=0A=
die.=0A=
=0A=
One limit: the exit lists exist only with CONFIG_TASKS_RCU. Without=0A=
it, the helpers are empty and only the final non-preemptible stretch=0A=
is covered.=0A=
=0A=
I tested v2 on v7.4-rc2 with two klp-build livepatches that each=0A=
replace do_exit() and replace each other ten times per run while=0A=
short-lived tasks exit, with a test-only 2 s delay after=0A=
exit_notify(). Without the series, 9 of 12 runs crashed: the last=0A=
transition finished in about 2 ms, the old patch's module was=0A=
unloaded, and the delayed task then faulted executing freed module=0A=
memory. With the series, all 12 runs completed their 120 replace=0A=
cycles without a fault. I will put this argument in the v2 changelog.=0A=
=0A=
Thanks,=0A=
Binoy=0A=
=0A=
