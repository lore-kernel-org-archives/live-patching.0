Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795807822;
	b=Yfg99ZRtHpYGNBC6CdgV7uJJKRzHQSYvMkBEGF0Rjjob6lmC/hjSoc/FgqfAN9pjOvEt
	 EQg5EGc+PbhOU8++QGkuoUqzp28p1SaOILj9kHketx4zrKOUrVOj4W0HxBMQvwS6BzOvD
	 zKPZC8jxmAT0MXdwLXVx/XLUoDZLYNsv7tSO68bFHSYW1RHJkFMJkLoesxBedKs1RWZie
	 zmXUeejXhFKhECIqX0tnfEKb2n1sc+fWg9UDhm+Mw5j66UDtcrH0rffoWPdf5zZV+jOsi
	 gJd8zMdNqSAAKsepHlVw3FUQmNs+6DMemUdQEkluUslgezRSk+shsD9gUcBPf/VXTCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807822;
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
	bh=DhKjhCM4hhQ5j/p4ULXGMz6ksRQ8n0MAJ6ykEy0k/r4=;
	b=Ijh1OhmZDp7d7dbfBhFr/t5Kb96szHoTqicBwH1i1aCXtMCbpx93WH4753I/t0a8MCUY
	 Y99vXT+BxY/yn1mcJWk+JFHBIL4+Tg6FKmwtPnraeb+xqyMxdPtjn9T2YBZeIjfi6Ys9G
	 TXJT1+rUHw101YXoD5VKysNPUHoaYlto5ZxbFebqP23iAdT48VI0c9fZ1oB/7M2FM98Lc
	 BeQbrlFKSeq+ybhHkZjozccs4SUUE20wSmKA6ZPIG+Ve76G0gVoheKYUzEWyteUbLjc52
	 e5NCcZWqLG1wLcv2Fh1AuPxrG09SIBb967SRcRJ6LRCsxsbfjzqHRd3faay1WTvxRJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=DRO3baZu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.120
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020120.outbound.protection.outlook.com [52.101.201.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87454606A31C;
	Fri, 27 Nov 2026 19:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87454606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=DRO3baZu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAeZ86PamoV/LCt5ISt2aZxMgLtLm+8lVRG6OVMZmnS5jWsPXGsCQXEPebKJy0TZ8vFkaazMAHCcUjOODW8B2qa/iN9xacOXDA/ScRN5vlng4DhJbwURHaN6fGd8kz1WngZIazbB1OCEpnT4IPcdK1oIh0DoJ45jFRDfmYmmzVPBWColdggOFTuKbgNP37cB10d752RHp8He/sDckAGpXp88XhGV+SpGNHIsQIAr/4yBNGmy7WoiWxUlrNe+kmcbaXfvU3vVa+C675iHJ7Ni35gRrHrCcWIpciCoAQ5bcW4D8lNB6r2ooNlrVkGXalZxPwVfWtk0bXeDaxHPYS/tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=DhKjhCM4hhQ5j/p4ULXGMz6ksRQ8n0MAJ6ykEy0k/r4=;
 b=xxDoh1D14RJLR76CSrI0h+jAAUcA3qswhlHKZp/s/J2WQau6BDOpXsPDTbFndkZyqpviFXfBusamM0kCDG6CqsGPx43o/oq/hxdFLp9jfgYBqT8oP3tWYIwyMTFtFSgpVnTgCi/DNB9iq4WCmJQ3zPkcOrYDgTcNotJly3qVvjvpmgOjjSrLeVEomaLX0MTBiGuQYyXiW/ckfJH1aAR9PRZOx3fdll9nbbX23N/8w0TYqfPp08LKG8doVVRyYGz8hXOw3uAQKOoBA2PrR4SMs4DvxKoVeaiS79rO6cdKk0vmeh96nS6T56W3/g8+HbFUqv+o/SsUJkGlASEOnITKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhKjhCM4hhQ5j/p4ULXGMz6ksRQ8n0MAJ6ykEy0k/r4=;
 b=DRO3baZufbrTZaNUIeg0kSQFdx3rPhXKmTy90/be0nvhrYVFkcoVnwS3e2Wz6KcDsAkVxD0ZiC2aB4QDQ+yqratCn3yFM6INeK7SU8HuIPup4de0OhH+9LIEba9ryxpunieVe2NXis+5qgNO4rEroll9OLNlenn7j0nOky3WVy0=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 DS7PR05MB7462.namprd05.prod.outlook.com (2603:10b6:5:2c2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.6; Fri, 27 Nov 2026 19:30:18 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 19:30:18 +0000
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
Subject: Re: [PATCH v4 2/3] livepatch: Include exiting tasks in the transition
Thread-Topic: [PATCH v4 2/3] livepatch: Include exiting tasks in the
 transition
Thread-Index: AQHdfcUSPOHbDMMHR0+ZuwKi7jdJKrdCGCQAgAA0ii0=
Date: Fri, 27 Nov 2026 19:30:18 +0000
Message-ID:
 <DM6PR05MB41378D88EA538581E2856DCBD1412@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
 <20261126-klp-series-v3-v4-2-2ad73e9c9254@vt.edu>
 <awmrfuzTlVWgGgEM@pathway.suse.cz>
In-Reply-To: <awmrfuzTlVWgGgEM@pathway.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|DS7PR05MB7462:EE_
x-ms-office365-filtering-correlation-id: 1c14e688-06d0-4e48-9868-08df4cbcdecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|786006|366016|7416014|376014|23010399003|1800799024|38070700021|10067099003|56012099006|5023799004|11063799006|261021121427099003|261009223027099003|261102123227099003|4143699003|261026121527099003|261022105027099003|261028144727099003|261026140227099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 XPluVoJfYLRXhQAtRCkvz6EuAjNyuhQWTFTx9eUrzBVbyHEIYPIQz92ei9Cp/2z/WkCO1QgaH99M5wglvdCC8IkGORdXz23fr+kDK+khGWfFicVF1xr3pG96i6TEipl4ZFSGv4fwr9GVmd32hAT7aY+oXEE8aHq9I+q5eMBpTRonyCmv9BWFdovpUzYq+72++e2OVX6imLv7KpMx08W2zJY/3j/ahShMIuI7BdaV4blZIZvbTtWfOPGjWkVrSvazrsD79TKxVAnmN0KiRCLqQgzEipPGoAMrZjahNk/pMEmugCfPzZ/mdjJnWmHZ+y0euOAj/NY7/rg/F78qbTiSj19n0gw+dFY8IF0fMvZhhdvIa94JKGQwX13QprJkEMX7YrE3qY7qMi+S0anI+CEvZSkf6HIo2jOqItxettuqSiQbfH1SEnOOhsc5tN0lm8MsWhIE4oz+fH0AcStKIGq1eh7YwNtKIL05OrI3mKA/eBA47sIs9KmN2bySDzIzVLt3699ayNt4lvO+Hnl8hkn+Z5HzTGblBFXodo6d3Adprh/zrnQCsODkNtCw4iTlIOuexb7CLnnVPPN+y153SPBGxXf3oquamaV2W9+iIH3jeuF9A2Upnng2f1w/4nrd1hraledwMZw7pnncOaZhMcnJFUF+ZlCnlsYu/EH0CNMyGlu5Q01SeK8te0zIRv5/Am81kb1R7hhMiHP9AFMGCuvGbsJ2HgldLG7w+ocdaL7ToB8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(366016)(7416014)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(4143699003)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VuFWZ/3tNyZLwEc2HwS/pKFCmzDg+wOxSVVUcnZGc5MgQ2as/xRBJrJxAg?=
 =?iso-8859-1?Q?rrLcZYb5IwWUYRepNyZkTxnEId0VAP+XG0nvcY9FPI345XudJGUuhaDQYH?=
 =?iso-8859-1?Q?uiKS0aPX6ZlGmARH4/XoHDY0APoDXadagVqf6aPCvXCVPP6Ouqv7mmm/rZ?=
 =?iso-8859-1?Q?GRfoPGCNDYWhUyPDG8ubOtZAClOxeKO8Hm2G4r0mLlHz/vizAlC1uRWCd/?=
 =?iso-8859-1?Q?cpY+7JSlEjFdRhD4r46I08kE2YPdwvr2eBBDcd4IQYmkXFX5Au2Ggmwpd8?=
 =?iso-8859-1?Q?aBYOhVTCVg4MlrbZ6qTnN8npEZks8ILo3oPe+epiSMiEILMZJPa/SZ91Pj?=
 =?iso-8859-1?Q?hQK2JSsMAO5AzZNVui/+Sd2ATriel2skiEwIwMlnAVJFBnqHxRI6WCPm3l?=
 =?iso-8859-1?Q?t2MKZu66L9OHK0qI50kKLm8acSdJvWV+ymeP+z9pSkFt9Oc4u5gr+ef6tw?=
 =?iso-8859-1?Q?SZ8fPQxSf3EEaZJeGGWakEViY9k6PH3kV9yqqjLk8PxVJCrutgDAf7dFN8?=
 =?iso-8859-1?Q?O6UiergHsLVXzKhfjgxOjYhHfnsTORTKJehIR0mdRdACwBL9sOvWuRVgfs?=
 =?iso-8859-1?Q?f8dfAmJpS8/9DSrU+tOSBOZH6OXcM8bTJbid3dzssQJX08FOxgVxvTBpuK?=
 =?iso-8859-1?Q?0jUxR7QYeC7PlVrpz0SrIfShhZn1VH8U0c5A5Zsr+e4b3WU1380RYavaSK?=
 =?iso-8859-1?Q?wb4bVDxVX3A8cxAwbFxQ/vMa/gF1+sJaJ3I/H6nT/8x15yC+LY6bp6hL9v?=
 =?iso-8859-1?Q?R8qFNe3GTEQFlw7dNJ+R6BMST/I262iSCFj1zwqeDU25yE9NqmNl0mvsPs?=
 =?iso-8859-1?Q?lN1BHmZsxuIlzKHa3Vzh4ryYQt5WTSwdyzIeB/Hk+FI++XZe2Klj0MnAf3?=
 =?iso-8859-1?Q?UOHyw6D9L4ZpNuNhMtAWkp4J3Ny3FZ56RhnWvXyQtrK6o7HP6AjSdE5SQj?=
 =?iso-8859-1?Q?TmnEyHh2ywkIQg4pR115DRMxm64apSdzJk95OxBZKB2ic5oTXDP8rQNM2n?=
 =?iso-8859-1?Q?L7pdRuP6ger3C4yz392khH3A7cwgJwjnm+Fm3R9Mjys7oEbS+pekWCCh54?=
 =?iso-8859-1?Q?PM0mvMpo5ydFiGZUDnmhhTMfZJu+1SPozzY3ElQaWzf8HSwKiLHjuuU/3u?=
 =?iso-8859-1?Q?72XgBFzXmGdqZeqU3iGTRkSs/6eotmPiORCKA6AV7NFwbd+4j2mabvPZvX?=
 =?iso-8859-1?Q?qgTLUmFoSI1jHiORADvW8TJUpaxaiU720+rSf3M3CGLCNFZNOh4PLvzO58?=
 =?iso-8859-1?Q?/QpESvkIl6brPt/COjv0NRT/M22fMLqQRtaqq1Vsw0LpqKxIJq0Fz9/9Ex?=
 =?iso-8859-1?Q?EDh7T1l0npWI+pGJcLsdDACs7TTr6o4k/rGYGVo8RaEE8vqIPQMvO1Y04W?=
 =?iso-8859-1?Q?aN5ssojJgOeBQGrXkhW++kktlZ18yyzBM6VXTD5Frv3OIVOEzEkmXtXJke?=
 =?iso-8859-1?Q?7yCjJMZZrOoyb/d5f/YHz8IQaxxBhJ6BaS/uiw7tsWaZZcOzRJnmL4HKO9?=
 =?iso-8859-1?Q?8+XVUdb+TqDMwcVWl9QdprEuEBwlqoLZG1lD+sFbJjOvxHlOFBZ61Zr823?=
 =?iso-8859-1?Q?SFJyOWwJ+d0vIgkyEdWdmc05ZqzrYitbLGJ7N7mJnMxDGdMN5LB1xYd0ZD?=
 =?iso-8859-1?Q?BlA2VSbtaAfXMfZFBZ6k51+MXvpott7V8pkhEbhBEWgMzgLP3iRhnve9wH?=
 =?iso-8859-1?Q?5Eb/DnIOO979y6VRcPVxLIfMMpwirtTtltVxf84q0Q7pjJrYJsWpeH/eaK?=
 =?iso-8859-1?Q?w3GdvAcC9ic6uaTukhumh8TMqfsnD53a3dgYAxN46SR4J3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c14e688-06d0-4e48-9868-08df4cbcdecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 19:30:18.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSUEiixSRe80A7Eja0JiHWirMEWrsPaOEtULHziJqCAT8+vBMtak4Q9rLfFFKYz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB7462

=0A=
Hi Petr,=0A=
=0A=
Thank you for the careful review.=0A=
=0A=
> I would use [1] to reference the discussion, see below.=0A=
> ...=0A=
> It might be better to mention here the mail where the discussion=0A=
> about livepatching do_exit() started.=0A=
=0A=
Will do, with the paragraph breaks you suggest.=0A=
=0A=
> Instead, I would write something like: "skip tasks which are still=0A=
> accessible via the for_each_process_thread() walk, so that each=0A=
> task is visited only once."=0A=
=0A=
Agreed, sorry for the confusing term. But see the next point: v5 will=0A=
not need the check at all.=0A=
=0A=
> BTW: Would it hurt to process the same task twice?=0A=
=0A=
No. Each callback is idempotent. Setting the same patch_state twice,=0A=
or setting or clearing TIF_PATCH_PENDING twice, changes nothing. A=0A=
second klp_update_patch_state() finds the flag already cleared, and=0A=
klp_try_switch_task() returns early for a task that has already=0A=
switched. So v5 drops the pid_alive() check, together with the=0A=
dependence on tasklist_lock and __unhash_process() that you found=0A=
tricky.=0A=
=0A=
Coverage does not depend on it. A task is added to the exit list in=0A=
exit_tasks_rcu_start(), before exit_notify() removes it from the task=0A=
list. So a walk of the task list followed by a walk of the exit lists=0A=
misses no task. A task that leaves the exit list before the second=0A=
walk is covered by the wait.=0A=
=0A=
> Assisted-by: Claude:claude-opus-5-5=0A=
>=0A=
> This is not needed.=0A=
=0A=
OK, I will drop it.=0A=
=0A=
> So, rename:=0A=
>=0A=
>   + klp_exiting_init     -> klp_exit_task_init_transition=0A=
>   + klp_exiting_start    -> klp_exit_task_start_transition=0A=
>   + klp_exiting_complete -> klp_exit_task_complete_transition=0A=
=0A=
Will do, with klp_exit_task_reverse_transition and=0A=
klp_exit_task_force_transition for the other two.=0A=
=0A=
> I would be more precise. I suggest something like:=0A=
=0A=
Thanks, I will use your text, with the synchronize_rcu() note in a=0A=
separate paragraph.=0A=
=0A=
> BTW: Do we need it in all situations, for example, when the 1st=0A=
>      livepatch gets enabled? In this case, nothing is removed.=0A=
=0A=
No. It is needed only when code can go away afterwards: when the=0A=
target state is KLP_UNPATCHED, or when the patch replaces others. I=0A=
can call it only in those cases, with a comment that says why. Or I=0A=
can keep it unconditional for simplicity, if you prefer.=0A=
=0A=
> Hmm, I would move this up, above the comment: "/* Done!  Now cleanup=0A=
> the data structures. */".=0A=
> ...=0A=
> Or is there any reason why it is done here?=0A=
=0A=
No reason. I will move it.=0A=
=0A=
> Why exactly do we need the synchronization here, please?=0A=
=0A=
It is about the check in klp_ftrace_handler(), as you say. Once=0A=
func->transition is set, the handler reads current->patch_state and=0A=
warns if it is KLP_TRANSITION_IDLE. A task that has already left the=0A=
exit lists is not visited by klp_init_transition(), so its state is=0A=
still IDLE. If it then calls one of the functions you listed, it hits=0A=
that warning. The wait makes sure all such tasks are gone before=0A=
func->transition is set.=0A=
=0A=
> But wait! If this is the problem then we might need to call=0A=
> klp_synchronize_transition() in each stage which calls=0A=
> rcu_tasks_visit_exiting().=0A=
=0A=
I think the other stages are already covered. klp_start_transition()=0A=
only sets TIF_PATCH_PENDING, which the handler does not read.=0A=
klp_reverse_transition() already calls klp_synchronize_transition().=0A=
klp_complete_transition() clears func->transition before it sets=0A=
patch_state to IDLE, and the handler reads patch_state only while=0A=
func->transition is set. klp_force_transition() gives up the=0A=
consistency check by design. I will spell this out in the comment.=0A=
=0A=
> PS: It is an amazing work for a newcomer.=0A=
=0A=
Thank you, that is very kind.=0A=
=0A=
Thanks,=0A=
Binoy=0A=
=0A=
=0A=
=0A=
=0A=
