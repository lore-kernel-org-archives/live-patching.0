Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795805795;
	b=hIiuOwDVOs2XIi8zjhB1RNHM1fmh+wAfCNEltetlwrmyRV0BojxC6hoV/hoKVwYTuBlx
	 yT/IuP/GojnZ56dOJ6McXy94vUws4iglkHxCfiaek5zLtYmZYKV89R3YlEO4tn63Y5Q3m
	 C1mTGHD0DV9GooQil/LMQ+KA98OfmWHPHPjHFFXDHHv9v1em28lzNFUuDcqHUs9bj6cEY
	 Pw0fX3jus4R2FXgmyAm/9evkqkxIfs7ErbnKnWEwI49z2aCmgpLWcIHarOPoGM7/AXM09
	 OdIbqvwYurH6MuLFC1k3F3YjM9WyzrSh4++fuYZmJn60D/e66G82q1ktdLOjowNvjFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805795;
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
	bh=J38S554tA0ae8jo+rea55Yie05ifKiWTYGBOfAqNGYY=;
	b=TtvF5PeUZjsJNGW6SIDlD1mthNnf/LDU1jzvFFpHKnfavNAU+P9B3uawwj5sKTvNuOZO
	 yh9YMHe8oAnPa8DgsL6ZGJ/NlMuqm92GkUovMEjdOQMxsItDMuY3KH6V9dR+FAC0BRGf4
	 FCdWKjVDnWIjr6MhBD3KsgnFLBfAnFM//XqDh5HRVb9ONbIyLoXeMKZ8kiYH6H1WJfbTc
	 ms8pFYInHd+wac31tb6YWSJwGK1sdHJGa6WpIHBZsC0+TGAfmsCCzPBI/nCh8Xqq8O6RT
	 2p9PjG8aTyg18bA+gFFbj91AGM87IFaZG4wfEpk4qtcOWDqi/eHi5j9YTGAlQ4CDs5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=R6vc6Ojj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.82
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022082.outbound.protection.outlook.com [40.93.195.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D7606A334;
	Fri, 27 Nov 2026 18:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 766D7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=R6vc6Ojj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMol9I0At4cICi5squEvn9wCjad/qdSQ050J9J3huX/O1hooQlhpXZ4hDxuCCn794V7EmjvgzLkxnXa2F1YglOKPWfC/BfV6aCWNzNSLDkGll/hJMuQmPnt4jiysiMF3AiibBH8Vfb1b3n7Ag61ulskdHrDNUU6Ez7c1AXv+fQdYLAbuiHY6PeT/eQdTSVUY+bkjWk7Tp4T+mTFgj0yGRoHHv/9Z2eEyPk2EVhymWCF6eKL+PErbJ8FA5I1P7MOmmv9h+wDaFUK8anwHZmr0/d9blCvRkLVn2YJAZeHFMi8ZUyvbhkKQwNJloEUV1m/dPtcRHCBap8SL01rWuqwfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=J38S554tA0ae8jo+rea55Yie05ifKiWTYGBOfAqNGYY=;
 b=d6+lzvf9RYd251vhd0+9z/k+evZjpgEy3wE/kt0RtTEP0vKjJO+5UE6sVuMfPUbmg2bJOeayDnwHpBTpr0KmaGoRfyAbessn3WJxyNJ37RdJIrUioTYipa8gJe2T4XM0beiLBxruCSaCzO0MY6qIwGeQcRcbAvWVsaUWn73lyf0TeKzeTmtqo/Lv6XSUyqlv6ZiALYpVRiXyX5YqWZ5KysMnzytM9/m858dY/Y15aDfI7CCO+gGdNLWjDjCiDtcMsX7YtYGTcJ1tVMZ4YjH6fN4RaE0E5JcvHTldOEkjLghmTvPWtH5Z6sq3IQBA1H5zZ450TNkC3rFS6mtwx4I4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J38S554tA0ae8jo+rea55Yie05ifKiWTYGBOfAqNGYY=;
 b=R6vc6Ojj5aOuaM3bRJQgzhOUY4W5a5/gAz+3c9KIHtSNGFlBw1ziR+nX65YBlHM9nBa5BTz+5FfsZxE4jSXGOW5PvUCSNtzqZh0W814eaJYrHbl0oOXm8bXuyl0E+nEnhs0lsQuCO4g+/eatN7qb+EJO85q7QkimJWiBCX5miFA=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 SA1PR05MB8565.namprd05.prod.outlook.com (2603:10b6:806:1dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 18:56:32 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 18:56:31 +0000
From: "Ravindran, Binoy" <binoy@vt.edu>
To: Petr Mladek <pmladek@suse.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
	<frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>, Song
 Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Kosina
	<jikos@kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Yafang Shao
	<laoar.shao@gmail.com>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Subject: Re: [PATCH v4 1/3] rcu-tasks: Add helpers to visit tasks on the exit
 lists
Thread-Topic: [PATCH v4 1/3] rcu-tasks: Add helpers to visit tasks on the exit
 lists
Thread-Index: AQHdfcUQnIWlHKLdE0+Y6XoN8dKWBLdAsvMAgAGSdBM=
Date: Fri, 27 Nov 2026 18:56:31 +0000
Message-ID:
 <DM6PR05MB413799131C86AF92098DF630D1412@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
 <20261126-klp-series-v3-v4-1-2ad73e9c9254@vt.edu>
 <awh_3OkWvI7dIRA-@pathway.suse.cz>
In-Reply-To: <awh_3OkWvI7dIRA-@pathway.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|SA1PR05MB8565:EE_
x-ms-office365-filtering-correlation-id: 61bc91d8-8df4-4d5d-75cc-08df4cb826c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|786006|7416014|376014|366016|1800799024|23010399003|10067099003|38070700021|56012099006|11063799006|261021135927099003|261022075727099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 70NtvqkjVir9+AmlzGaj7+rjAW3DbpJP4jEzJo9P1W7nqngFTVQc6KNpFRHQ2EoSaPGAapnVDp4/kAnpxwf//iEeoVir+Lq0veVCtAjrScb7yExIoLuixKmXBLkLbG4Od17TQwSt93Vn+ITphpBuBq+QReZW6/PIcEl2aSq0+sM/1n8iBVqEgvfK+MI9j2tW9fvH1wezQKGTKv6gi+bfXBL6GyA8xAoMInBdYfgL9/4foqCIowUOOHhempt0YIHCLbCyf4mRM0eZ99TUpkkIjdAm5Ijih5kiwLrmR599hv4iBeOr9fVa7ayFM4AYltJri06B35pzVLCyPlLyh7A5MfEzkwL55ms+eodCckgY0G0QAImEXfMQpb8GxLl7HE6PZnIG/pN/3QQfYXb1DUiCI3IzsBTiPSMostcLSLZ7KYcZR8vHG1lMpHE4hGHac0RqRLCbjwI9+bB1JIPXqXXYeFL0/gCB6xu5qHwhpcvrq7TrbUh0NV/qABtWWQ9f2QkMm7lugx4btluI8FSYF+zpT/+WnMxdO58kT9y4SjaqyRLHhU8Huc6iONroBXdUbLE/2jKNaeuS7A+CpXsTlDpUYc3V4+5Hp9l570LIBPKe7a9XJuS/LH5Sz8TiyKGhIK+DDxjZTCCapkiaWI3Q4iPvzRLfAkDSxeaZ9Mxkvts/eUWSbmRcUuJDL7IYhW/bt6nyOn+dKu5vaWAGwZYwjOx33sH/Xz7Y9JVo7EHFGqE9cXA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(38070700021)(56012099006)(11063799006)(261021135927099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bsgupBvku8h9x7v+MgJVMYlHtYkCYfS1NzYq3UW1wS92X+idFh+ruSPR11?=
 =?iso-8859-1?Q?vtg2LBKStr8qeByeoA4kWnE2/3LZzchzhuj77xGdfM6eR+8ty8wrrW/SvT?=
 =?iso-8859-1?Q?aVkXUI6pAgyfowZ6xdIey4QSGwYN1z+kKOgJ2g2dgvFZZQoMwZjPGE/DCG?=
 =?iso-8859-1?Q?x3NUM0ZAcqaxZ1wSe1aIdUcMNlP+5nQYNGXmnE5Pr3lFu/tD9QnNRmafbK?=
 =?iso-8859-1?Q?gk0QFlAf3etb64XxtxNWAGO3wUtBrIRphugxapKf2WU9mgDZBASXSOwiA1?=
 =?iso-8859-1?Q?O2tV+nKn6oscd5L6IP5AxavsdtAK0jMWTSyTa2nroYmdEiZ73+UIV4Eguo?=
 =?iso-8859-1?Q?H7q0VrjSGGsGI9kHxG0pM1KKzfvL+NfR7k5NEwJexYQK3Rl+o7Js1aXJEk?=
 =?iso-8859-1?Q?0WJapQn1VNoNVQxcryt8oBH9T+j+90uPZutpxcLQYM5dT3RVSMgo2GNNFJ?=
 =?iso-8859-1?Q?tmw/eqQkxBMrQ7fyR+irl3dPfOGp1sKcGRD70hs6SBlNxuiEbWE57Tsdu/?=
 =?iso-8859-1?Q?XGwJDgdtN/AVY4YDUOawGDgtOJJWqFesfzSmCywH4zO0z9ew8i6N1JljF1?=
 =?iso-8859-1?Q?K+ufcbeI877Drtiv/7X90TPQUVEUBR6pa1S3ZiTQq9ZJ5pYEDug6+o6jdJ?=
 =?iso-8859-1?Q?Fx9TQLO1NADBO4V+DHMTnL7FY5zWeG0gudz/TnTEEioLy5mEv4f9nIXVk8?=
 =?iso-8859-1?Q?i9N1REmAwXiPInheFp297d/yPPdIJOwqG79qzOnVm7fYWmKNIS8alxnCqv?=
 =?iso-8859-1?Q?/AuurRNKBGVcJVg/D7aCI+HP+HnUNAnOYWLPSl7qijb6jlms+k0NFMctg4?=
 =?iso-8859-1?Q?iNw8Hz374gS9GIR3q4SRS10nolFcwa8XN5x+hlJ0J15DA4mmxRKkrmQUoI?=
 =?iso-8859-1?Q?8NP+rdVzIBVEx1iRtvPj7U87YSNxbx/CYCSEOKerP/mhrdzP0pIZMq1bfN?=
 =?iso-8859-1?Q?KPU3hCqPFwGQZUma5QtGz97JjCtzNDPL1fxFbw6PQEiKLwmG6PtifosePy?=
 =?iso-8859-1?Q?YVbt2scpdytvXzbcxjN2lGvesgc4EJ1qe2qs0llYBHduT0AfDmZvIWnoz8?=
 =?iso-8859-1?Q?OPqrK0zh4grldvmDsg2Gl67GMlQElr1gAGJ4EG+VvX1CtG8LZoCqTbIUBI?=
 =?iso-8859-1?Q?4UVhWrW+aOC2QAxXGVeWAK1jOSNSre0TM9+L8iiqmrXai0J2uBbznrdAu2?=
 =?iso-8859-1?Q?FYTc/Cx8ZmMOixFtG69Addj5Iywj+TMsiBUQcb8LLp1EKojJbGPDO5bUma?=
 =?iso-8859-1?Q?YRpe9Wo+R5axMsC3pslB5rF0g2XImrJ+Y99DA3QDJ8/4ESTnqiD0kaeO1i?=
 =?iso-8859-1?Q?HYfAIN7usRnBwOUGenacC8UGyXcxXRpmjzWisnpLUaVu5xqfrCWTG7s5XN?=
 =?iso-8859-1?Q?FH6avO6xy2riM7UcqlcMYcLy14KamlnaKggzJyXu6jagdMwb7qcGMu0yBv?=
 =?iso-8859-1?Q?8/9k9O/mycam7+J3Y+cGsmV3oBuGAj1Ft9N+0eRNwIt3Ikn4LynEuzAu6Q?=
 =?iso-8859-1?Q?s5IjG5HBlRdy14/LOCEnGj4/QkITPq3h5RYvobpKs9baYhTx3ngm4zyzRE?=
 =?iso-8859-1?Q?ox9L+W0SeIxyzDQc2eE7v16HGTcTq3KKI+ZIG+4ydgRDsblBek4BX4qWHl?=
 =?iso-8859-1?Q?DYKUv7NXEGnsOG02GkEyhUufw5byduzCsGJNAIY2Rv562iAxABMw4wHAwq?=
 =?iso-8859-1?Q?XWzn4/Uqb7A5N+WpIT1DyfTkZEczpIGX4knIdOE51MiRf00rNI4zt+a5Wr?=
 =?iso-8859-1?Q?6GjhJLYrRTrtaf1/cf8FjSYKtIvhPm2dlxN0hhQZ+PoS33?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bc91d8-8df4-4d5d-75cc-08df4cb826c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 18:56:31.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LYkK+B7RF0vS4qZN6oP1usamrI5sXhAovwLFX6eGf9iIgj/vsF5CEgyPro2CU6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB8565

=0A=
Hi Petr,=0A=
=0A=
> Nit: I would be nice to make the commit messages better human=0A=
> readable.=0A=
=0A=
Thanks. I will rewrite them in that style, with each helper in its own=0A=
numbered item.=0A=
=0A=
> Is it acceptable to process all entries while keeping the=0A=
> raw_spin_lock()?=0A=
=0A=
No, you are right. The walk length is unbounded when many tasks are=0A=
exiting.=0A=
=0A=
> IMHO, a better approach would be to make rcu_tasks_postscan()=0A=
> generic function to do an operation on the rcu_tasks_exit_list and=0A=
> release the spin lock regularly.=0A=
=0A=
Agreed. v5 will turn the lock-dropping loop in rcu_tasks_postscan()=0A=
into a helper that takes a callback, with one cursor per user, and=0A=
drop the snapshot array. The livepatch steps will not deduplicate=0A=
against the task list anymore, so they do not need to walk the exit=0A=
lists under tasklist_lock, and the lock can be dropped during the=0A=
walk.=0A=
=0A=
v5 will also handle a failed schedule_on_each_cpu() rather than assume=0A=
it succeeds, and I will check the recursive-fault path in=0A=
make_task_dead(), which skips the normal exit.=0A=
=0A=
Thanks,=0A=
Binoy=0A=
=0A=
