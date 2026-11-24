Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795533326;
	b=I3Adv/4b0yoeGlB7D07doX4UcRVQU2u5dKvMPEjsIe/t7Z+eaAoiNxPn6MdFk3Hv+QbB
	 hvCXGvjlNRNweUWBItwHWyUyuovs2T9MW6erfASHDf7ZWzoUfxLxMrb+eaF44zCxaKB1+
	 wJXKPPHjao0ocY4nvQgEayC+miHWx83vf8Hdl3N2xo6sKBUh84adLRcXdCEBah1rtcU9b
	 QP2EG/nUrT4uFoVRqOwqt19H5/7eUM1wGj23zBhV6VmWkI0uwFBKTx5agivnpQKaNN5h4
	 HLGxdrrAVjX/c4RBYlvrcCTquYOyAfbRb6ma+H7fzYX9zGp8F9G6e729FAULGlJhszw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533326;
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
	bh=5of6Fiqhz1ehQEp10+5JOSuFwML33ZAYYmPVFybHzZQ=;
	b=PQyvcF5+xahJPE9faNcm595kelyPk2ubkK8On1Zd/RnuuaWzDafU8LdyFQuGDxd31PeE
	 +r/ryF5+7gem4hCKhO3CRci/QVegqa6n6wz7WF+Mp6XEcfTOfyYDt5IzvqOL1tdX2+Ltf
	 VGres0v6OKssriRHxnFF5X2YoOzIr23lS2l664ixENE08eypDdgOQfgWWINFj918MtoYM
	 26BGkN+4AKo/soFkHAc4H0pJuVNYANd55DuTSTBenL4/+U0W8us0OrkFk+VOrRRx/fjch
	 2o0A9IdogqF7Pv5/wDIxSZvN8s/qm/iVFy5Pj2FimHrzbzZnv3fGzrF7TYhaGfGyqCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b="kN/UMlSD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.136
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020136.outbound.protection.outlook.com [52.101.201.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFF606A31E;
	Tue, 24 Nov 2026 15:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFFFF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=kN/UMlSD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SloLO37pcvdNeExm6Q8czweqwhjMldOV8UlD/TOql/jM7o3dW+KL2HM8LjA1r/PFs0lPinHmrIxoeok9X27LnfMNiEXIhfhSL6YPeO9IM5XdECHmR2ODjJ6/Lsw5XFeoju3NjaRuQ/eCBEA1PCj3cNTop51o9EKwRbpxHEZi9c9bk5x5toWf3/ncAayObv+rXoBvRSNuYB5r6GA6GQXCElG2WqaKusoDnzgytp3OFkkM49fD1R/7c9X1T1Ul3REjNZ26FVHLYAaUI68zntlGVRnpAU0JPACRkm/4RSu0exIGYrxvRy55LpVrW/lP0ufs3539AVhQ1h3R2aAsOVOLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5of6Fiqhz1ehQEp10+5JOSuFwML33ZAYYmPVFybHzZQ=;
 b=bD/hOmEF5dm/n0Ly2OyJZgmeNgVvqpje51KFOSnAGraj6W0MBEv2Xzi8jlWjBHzr5hcvdmS1JvHVyp/EbeITaFnNKvW2XqVa7LCnchnoKjF7LIuwEoTBEy+d7jaI9WvwCirugRYcLomzHlG4NJp40+Rb6OBbSO8lnSM9Fc8Pc/rynV8jYn99HFe9yRTHCe7UedZpJ6J9Mm6npT/wQ+5C4pT81wbB1T5deSM2llN6sCbwl2FgDT8Fowxu4dBcn+5pC9cWx9VVQ+jl4IHSeHkCIA+RHLXWQq/x9dkRa1GfoiMXd9ql8HMxE3yUaJeRRSvKMHMDr5zHLLfAsaE09q5opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5of6Fiqhz1ehQEp10+5JOSuFwML33ZAYYmPVFybHzZQ=;
 b=kN/UMlSDb9LAVAcBjw2TmzNma5G03iRy7rNcDitJaKV3zwUYXZ4nh+tnvm5Ws5FVbHVMVr5tXSnK9KGlozYPfQQnAOSf5jOViF4UBRY7Xvy4hnZZD11Rc1VZmmAU5dEwGbRrgO6FrTv7QjzNVqu1zP7M2k19WpQ3nuwORAUJ9+s=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 SJ0PR05MB7692.namprd05.prod.outlook.com (2603:10b6:a03:2e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 15:15:21 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 15:15:20 +0000
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
	<linux-kernel@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Subject: Re: [PATCH 0/2] livepatch: Do not lose exiting tasks during a
 transition
Thread-Topic: [PATCH 0/2] livepatch: Do not lose exiting tasks during a
 transition
Thread-Index: AQHde4yeIwbsGnp4R0y51MdXMm7dBLc8PZ1JgABb5oCAAAiQF4AAJg4AgACNPVs=
Date: Tue, 24 Nov 2026 15:15:20 +0000
Message-ID:
 <DM6PR05MB4137C1461A45A521072B526FD1442@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
 <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbDu5NmVowk4SHzeUDxASaxKkbL_w1dModFWzdi8yK9tBw@mail.gmail.com>
 <DM6PR05MB41377901DA5182DDFAD6E3D4D1442@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbCDSAuvxHt2jd-f5rvTrxeZ4KZkKUfqxrE09PXk+Te36Q@mail.gmail.com>
In-Reply-To:
 <CALOAHbCDSAuvxHt2jd-f5rvTrxeZ4KZkKUfqxrE09PXk+Te36Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|SJ0PR05MB7692:EE_
x-ms-office365-filtering-correlation-id: d7e04321-7b8d-42cb-84d6-08df4a3dc113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|786006|10070799003|23010399003|366016|6133799003|261009223027099003|22082099003|18002099003|4143699003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 jgfeRbMATzHLD4ylXrVWyJHolvfrlrAwgfLSiq8DqsMF6Npy+pDq4gN6aCI78M4xrFgKIxja1KTt/f2PKZbfduD55FuPc2YjftGSs6EqlvMvaKI0ub5MmDzRfkmNakVd5q2rKx/nleadKcgIlT3nTneNCFW1Zhlwm+XPXXxFaHdZPeK0SnBxq4k6zUd6gm57Ryn4cSHeoG8Fn8S2ddt83qg/rufwfyvsXLQstZIewCQYDjZyg/VHq7KRn8MVR2siKRLfFOGqDGS0nfw1Wp3skWKWXuugo1shPMn93JA16YWwfOr5XhN5c+FriPtIZE2+QHfGyjsYE/wdOWMVYP7t7diwOylvXBZp3XHp4B4UTJJVoNd97m686hh3YjdrNzy0j4h86qK8p/p86XOkHZunF2dgj0Reqji8YZ9PuiFflz28gUdlbZBYNW8xtdIjkIoFoVvGJXkgNGxEa0LXuz9e0Dpc9H/P09CLnUf6JuBPCxAxyjM2l0lRTch0AmIeQWTFsclf+i+6yVcfJk/SJkNCATRq8RJvaMAMlDzBT7FSmoipxCTlQyj5XHN7nftAWCw8R/g3pn9G2+3otqHidDrg2GJHcEVrYpgyZ+J/u11VpdoVEB+PG20i0HMUDotAd82TmULQmWHt6nnhSe5q/arU2Cy4obxPZKQDt98ZeSTJvasCPe3gobzoHKnaFkUUJWxg+HtWlRZWq9jc/mHtM7px/Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(786006)(10070799003)(23010399003)(366016)(6133799003)(261009223027099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zSuDwiU+RuM9UDBZYgh0KoP/Tl/73GyNiEmee0+UQhOZI2HH0TwPytUw5F?=
 =?iso-8859-1?Q?FP/13FTvhPy28kioP2sYCb5DzzIGYGy0YgwduRvS3UH9qGcAG8h2yjC5dV?=
 =?iso-8859-1?Q?GxYqpBdBkZ0efp/wz7FRzJ3P143r8vHzakjXXHHF8/8yMch/FmZrle4RGE?=
 =?iso-8859-1?Q?ttFjZLxnjGhxLckxvGrQaHKPJUJDFuk7MfgMlMtnR8vXdhcd2MUFd/Pqte?=
 =?iso-8859-1?Q?i88smKIGjtm6XuvrirGKN4WnryX9ZXgB2hiP0PWIhjaZnH6dvAKE7GbOQu?=
 =?iso-8859-1?Q?A4u1Hy0HQxh5mpURK0IGsxMChiLiM29gJYyNDVUg5Sowzb6Esc0eNjudEu?=
 =?iso-8859-1?Q?LEI2IdfAO8NIROD7beRzF0aympcyPwFVeCUZ8MwBN7ohFMRZqTriIRiDDs?=
 =?iso-8859-1?Q?gaHIw/+DTKQ9q9QDQDatMdr1Gxh2XpeueBVlqwKoQI+2JlVzh5znrfwBuI?=
 =?iso-8859-1?Q?++YY1YWOVzRjtL5m1vV9nIQLgwBalfKsKfV/cG8cNzkvHgqpMH6bK8MbGF?=
 =?iso-8859-1?Q?vQ+k+ZwjFmYFN1xqMCXcCgLS0fMDmkTiLNhTu2IT5Xl3JxLSa2tbap2XG4?=
 =?iso-8859-1?Q?gv2c86S0+eqfYUb2p0Xv0m2FmszCsDKQoD1yZ0aO2VzegP49IExayFt+km?=
 =?iso-8859-1?Q?NT5fuZX/rxSwe4y6AgzWvbwmGhdiPMkOBYfaMqS/Tq99GKuDQF07mHwQsw?=
 =?iso-8859-1?Q?cuNAs/dgeQzubJX4f4Vg8Cc6W7s9BeKFvlUJEsvfJQ1Df8+HqnFUVAfi4N?=
 =?iso-8859-1?Q?ZRnnadcwxoYEt3f+MjPXZTz4wwXtiiMddUkDjflV3TXBNU3my1XTx3gCpo?=
 =?iso-8859-1?Q?UJUe+OJ4zfPzI1RVPpF7BuZ2bx/PCpjJKbiY2Q3r6cRofP4T6GgYTmyjXh?=
 =?iso-8859-1?Q?hBjjBhUjcVT51R9SZ3eVDn5X+fTiXMAVaUMcJ7jYAdOXj41scPywKywdRF?=
 =?iso-8859-1?Q?hKimFAAkedehplEVu6RhsIkaDq1J/f6NOMIRyP4sQGEMBMMhL1Kmfnj8xC?=
 =?iso-8859-1?Q?e4yLa0KcBk9ZlLXICvYj8XeIpwlqOqefXRX8tjz6AJ/G0WDsPFBPd/KQoB?=
 =?iso-8859-1?Q?UR3znfdsGgNMimmldW2oWHTKm3fr/81LJ+pYwtVHHk7NzM7p3/TUpi+Dcb?=
 =?iso-8859-1?Q?7/lbGuVA/Minh0c/Md13H/6TRoMxLU70g+bcepktCaSJadFa6HHk6P4Q3u?=
 =?iso-8859-1?Q?qP82YcO1JSb0/OtPjvZFNmgY/oMFTSsWflsrC3wg57n4niwoitkd34gT2C?=
 =?iso-8859-1?Q?3IDkZX2y18bGi44UF7p12WIMjOU9JRxwKVBIrjEgVZepu0keyGuEbF4whM?=
 =?iso-8859-1?Q?a/jG1QZbzR5IV8YeSosneUU1bYdZWqEsVlfyElL3lAokp2aTKRstZ9fgC6?=
 =?iso-8859-1?Q?EmB1mTZ5/MKtpVphcV+kmubIDEHG2TAF7agQA2No1fp5fmmoi2sO0Ph4Rk?=
 =?iso-8859-1?Q?ohKOxpe2xPIyBTrxNGK2Clbur3MhDbgAFH0RJXirT5StSgbnKla3EVbO/9?=
 =?iso-8859-1?Q?y05Tj+1j+pY28cRerpS01ZlbpimV3n8PvZT0XcWZR3ePfImGobqONflG6Z?=
 =?iso-8859-1?Q?F4aAG7HdTzFDR5N9Sxh3VE5CN6sbHywqSE8CH7GuXaKjOj/x5J792cDFEo?=
 =?iso-8859-1?Q?CVqm+RsQelndQXPnUgRydyH2IYaShuvaO+OFN+Llf5m3m1x6KNUke0QjCj?=
 =?iso-8859-1?Q?WduDDLj3Qoo2cJDjG7OmOR8gtBJDYUJHA9Dy16qVeAo/AP0JTSEG0jFZ1o?=
 =?iso-8859-1?Q?A4apAjEXj4eQUZoB/OyLSOjXEuPJLT7E8aownTmbg+nOVbYCaRZiaElo4C?=
 =?iso-8859-1?Q?oMJYMPU6lA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e04321-7b8d-42cb-84d6-08df4a3dc113
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 15:15:20.2547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvfU/WF8o5rbLWh+s827sxyiEES2lwRzmOlgns8g9k03EfUPTOD/1vwKfuxRPwZE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7692

=0A=
Hi Yafang,=0A=
=0A=
Thanks for checking it.=0A=
=0A=
> Is it worth adding yet another separate list for the klp transition?=0A=
=0A=
I don't think so. The exit lists already cover the window we need,=0A=
from before exit_notify() until after do_exit() disables preemption,=0A=
and any separate list of exiting tasks would need its own insertion=0A=
and removal on every task exit.=0A=
=0A=
> If not, I think we should at least make the CONFIG_TASKS_RCU dependency=
=0A=
> explicit:=0A=
=0A=
Agreed. In v7.4, TASKS_RCU defaults to NEED_TASKS_RCU && PREEMPTION.=0A=
LIVEPATCH depends on DYNAMIC_FTRACE_WITH_REGS or=0A=
DYNAMIC_FTRACE_WITH_ARGS, which need DYNAMIC_FTRACE and therefore=0A=
FUNCTION_TRACER, and FUNCTION_TRACER selects NEED_TASKS_RCU. The five=0A=
architectures that select HAVE_LIVEPATCH (x86, arm64, powerpc, s390=0A=
and loongarch) all select ARCH_HAS_PREEMPT_LAZY, which rules out=0A=
PREEMPT_VOLUNTARY, and none of them selects ARCH_NO_PREEMPT, which=0A=
PREEMPT_NONE requires. The remaining models all enable PREEMPTION. So=0A=
every livepatch kernel already builds TASKS_RCU, and the select changes=0A=
no configuration today. It documents the dependency and keeps it if=0A=
those defaults change.=0A=
=0A=
I will add it to v2 as a separate patch with your Suggested-by, and=0A=
drop the !CONFIG_TASKS_RCU caveat from the changelogs.=0A=
=0A=
Thanks,=0A=
Binoy=0A=
=0A=
