Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795473622;
	b=DNJ4X8eW4010UxrF9r81+3etr7bS6Yhy9/Ea0W8WfWY3A8E0CdnhyaT28+r6pSdfFyX0
	 d8cvgF5l5vq4VU2RlvPF47T5AQoeleBMVG2twtkx5L4ombJlPyCKG3GJ0Eg0W5O/9EPBp
	 rO0i7DwAfecqfPvKDvVj0DzkdD4SRODO4plbpwAPBdeQHxVd9eaanjsd8bAlTjZU/dWbn
	 H0KwjriKD+M644fN/JR8FqUvaNfR05Ql60pm1rW6ghvJixKp3189+qI18AQeW1EsDg36Z
	 haAZPRpOCwVYfPcoA+DXMvoHGUTGF3Y04xLspqVLE9MZ8vjH47boRfg219w9877JF5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473622;
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
	bh=aQvvsDAoMaydkfdpwVgovOoWQOhdfjdy6EKGp7SOfTo=;
	b=0QknGLEUMSN0UN/QQi1bV9HTBIMvlryw6+vcdd///vA8KjmMnaiaa2AL7Vm+OCB2HZ8K
	 u5AhqzOVjYXl/XvY+FYP7kYWhQG5etuaWl7a1wYdY2dmSImpygp0syPFAlIuD68xBEL87
	 Qwi0LcGzgSTwz2aykfwGRWJPhGTxgR6KfUK+BeSLJg+OR5r5lnwpjtV5dzMcPVDGbgrwj
	 ORXT0ItpeBHxtWCMzeLnl0rz+ced8SrtmApiPvcWZIJyLJoYJCu/UwRLnWWoHo/N0SgOY
	 mdTMjfgzIuv66zFhlw7T7BxeOxKK1yAx2civMRlGbAfvSIaM9feQub8ssWiYNNIdKvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=NwRZRpBA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.135
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023135.outbound.protection.outlook.com [40.93.196.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAC606A31E;
	Mon, 23 Nov 2026 22:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FBAC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=NwRZRpBA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/51TJlq08uN/gEuuMPbNAr6amNQySYRaWMy/2YkveBwO400odYKYo9FrCjNhDRliBVTKxtUpgJAUa/gRhsz0rDF1flLEpVHkWVnhn499RirC5+wMK0ocmNcdFRYpTpUNtmDyGPaJ8/MpwHEequAbVI4liik+bc8T9YIOe5rYZuLb3iMHn0G43pZRKPZvrOrEJYkKqR9wAyqIw8PSMFONq9EEAHk2qbhqsItMAjqIffKCjaJvwiasSUo823CjTQ4q4Z091ZSJtjJ0A45V4xQqBJzj+WOuj0x5oRmrgxqc9xtYy3CWcLGzWpxv82fhcOem7qkODvxtjvdRPgs3oPN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=aQvvsDAoMaydkfdpwVgovOoWQOhdfjdy6EKGp7SOfTo=;
 b=Z+hHDbTjFm0pMUJFE12r0Q8UMiiVuGzaNhMBPBR7C1wmKCHPhZTfHm6Goo9Y407sH+W/eT3Hae4oHI8GwucPgzsGRgax1w1mqWUsKBWXig6yUUUpg6xStcs5HIXe7LLlUZ3YQ6YxNS3wYIwCnCjnaBHiX5yywLQw96KCN7VxZLxloHqY+7wffFuzkWm9Onjs49To2oTVFxNb/9yOEygpmX6HOgfCQQFgDuEBvTvCYeexdTMmkG0bnGeBCidKW2JQXUrSOK1zwImfGPzAheSOIKqVW72p8JfaDzMgw6qgowAKEcMV5OMj5qPQ9ev9HkqVpnfbBuuKHfhKJ+x98xArsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQvvsDAoMaydkfdpwVgovOoWQOhdfjdy6EKGp7SOfTo=;
 b=NwRZRpBAW26a/rddfTXSBilEYxuv3ydtSLNkuCRHg2XfgdYMR6KydzVlE/SyMVXVBqxqdKKA0Sis9LhFXdHQEzgwtQaPg/u4auAEwF8QHGYu1JONPirIO+ipbvQvlX6DCpis+RV2KDSMKPku1xlNmMc15k4DPoKW5mbkk93S8Bs=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 DS6PR05MB998884.namprd05.prod.outlook.com (2603:10b6:8:461::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 22:40:17 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:40:17 +0000
From: "Ravindran, Binoy" <binoy@vt.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
	<frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
	<joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, "Ravindran, Binoy"
	<binoy@vt.edu>
CC: "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Yafang Shao
	<laoar.shao@gmail.com>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Subject: Re: [PATCH 0/2] livepatch: Do not lose exiting tasks during a
 transition
Thread-Topic: [PATCH 0/2] livepatch: Do not lose exiting tasks during a
 transition
Thread-Index: AQHde4yeIwbsGnp4R0y51MdXMm7dBLc8PZ1J
Date: Mon, 23 Nov 2026 22:40:17 +0000
Message-ID:
 <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
In-Reply-To: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|DS6PR05MB998884:EE_
x-ms-office365-filtering-correlation-id: c816fcf1-85af-492e-40cb-08df49b2bf67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|786006|376014|7416014|366016|23010399003|10070799003|261009223027099003|22082099003|18002099003|261022105027099003|921020|261026140227099003|261026121527099003|261028144727099003|56012099006|10067099003|38070700021|11063799006;
x-microsoft-antispam-message-info:
 ogzAkxpA/YDfI2QiooGVDFP/ZEXzTWXtbdir99aXQGyDGD2sNlGDK/OSAiVoGeOdzJ7HeRLTi5WFtEh87flOxP6wMcG4/ta0GfoeTu42kyMyDVHJAK4QqpbQt98TnJZEWJXJyuZHIO3p0gT9cq9CTFOduRmNHXUbs+ev0xnE/y/+Mav4TMOAXYVSGf2y/3Vw5CY8CwoVe/vZig6HTZjd8Uf4q1SIVvw4wV1fp8p0Uid5xCMt4ROVdo4nX/dE0n+1oh2iejwPhzg9jRuCOaDXqYKgg5IWiXOtqSdaA7uWB6jXYT5IH1CPEhmV/51ZVQeBRRMxDb6AF7Sig6AVwS/8Usd0HSUrqBUAX/vSY1J6rRqnBaW56q0kxb3yK0Q5cFEq3AOCEiTDsmnwrbXC2t/0YW8SsN5PYYTHOWAbNsdUsf/nutt0AJaocW6iaqXzQ2eL9V0kT8y4a3x2GToGjEdF3bWixw9yYfrSUIVyhKAESqwz5ZikBzKpUvWL4ThYF4cyKy9LE6xnXEvw4YSQpGbFNAByjltzYx6EUjJfO+vV3dBTrol/TDdUNCwDdjZ4rCIq2OUqn9llIrTk2ep23aao3guQhLPEx4r3jDsatSkDm38mEQz5JgCf0m7sqhz0fMno10Cs9KtVG9HV4VuoxVkJpVWrbIQWvJU3GUVI/B84Ts6EYwM+Z5bMkxa8iY9zxmkXv9QJ8heQPEmoPatKjYRvPdOWxWE+Q2JsVcMHWrQzUIY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(376014)(7416014)(366016)(23010399003)(10070799003)(261009223027099003)(22082099003)(18002099003)(261022105027099003)(921020)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(38070700021)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TwxYP0xy4YE3K95bDzVHJP5z/aSOvOf6g5Ezd85qvDJ3OcTTNsp9fgZDWx?=
 =?iso-8859-1?Q?vKlJ3dK4VlFtWWFBcJrTDS9tobXXOfW8Helg+5w8xPNgJAJ2zb+0HIjd6R?=
 =?iso-8859-1?Q?zSQ+QsRqKE0z7LreK/Uq12WlHsV6MPPALl2W3hkK3W45lGkTbtEZqofiC3?=
 =?iso-8859-1?Q?ZMk4xopLcLx5QbAA+LjYUe0ft0blJhs1UXdhLj0IKLc5qgsytIefje3IWT?=
 =?iso-8859-1?Q?VG9FgrsPIx8Evv5iRmL4UUQ4cCF6okFfDbSdIz8sVuYnABU6LUrfqMlbG5?=
 =?iso-8859-1?Q?uSrtTkHZMsQ5WuEghG5VznwXkb0pKNQxF0rvdnk4pZCx7YqDZtGTYtJr1C?=
 =?iso-8859-1?Q?dkRJhm3cTV2ZbAaj8jgogb+qp8yqqpH4fAsP8be6C4IA2rymxJQtczdlqO?=
 =?iso-8859-1?Q?GYkjE8KXBH7f0slQGAQ7/eeUJ0NEMVt6U6ZHQSKuSSBWq+3iy7TD77yTa3?=
 =?iso-8859-1?Q?O1M/DMBJJG9ILu9nNtt+OCgtLnUAUFsQaNcjqaMIq0+5cmaTwE4oDRMoVN?=
 =?iso-8859-1?Q?ukqQBUboX0bLUM7RbvTqOTW+40xVg5WnsPRyn+auHEQY1yEc5vVnvkGgYR?=
 =?iso-8859-1?Q?mc6VNGmq45UbCXHALNqwxny49cStnAVo/y0uI2VRcUv03WNxfhtIHCszfR?=
 =?iso-8859-1?Q?9f5hFB+uiGHoJQPxnAp5sjBlHsftMFzXsvoc59gnY+quVnCHWZaySFBZBE?=
 =?iso-8859-1?Q?jJFS9l3GD9LZGguTZz16nKHOn1hm1bq7WiMwxJc02Z9wMVTfxDDSNQrn/S?=
 =?iso-8859-1?Q?eqn6/XnFLYEBEPs7We5BKXsP8iSAw/y7HRdlP82m17/HZl3oqwkoxTxTjB?=
 =?iso-8859-1?Q?VOke7AvN4eP01pU0fcCX0iaNVjRGleAoQruFNn6GljLvuhqK4ko09zg/UQ?=
 =?iso-8859-1?Q?785dcQh26aYM2X7xvHeu12YY9NCAzSbwSQxYPa08VOlELDg35Yysj1RhIq?=
 =?iso-8859-1?Q?mIp2QCSDxRJJDmhOVWkoqXGsgG9UiZH+qv29REthYsnD1LHpK0hTpcijvU?=
 =?iso-8859-1?Q?Y24NWLwy/dvQctSbvH0xxzy92vufHHOrT+apL5IBwn6ppyXd8IezEI+CyE?=
 =?iso-8859-1?Q?1HNuLkL0bLCh5cog3Cg25vTMjgQFivkf3dwudDKyKnzCRaGNsk/180U4IK?=
 =?iso-8859-1?Q?+zQIF+CRLKxGkNjm1SJvMzIZvS/dSenQdS5HUGtV96CJ1QDc70uLsDYpQI?=
 =?iso-8859-1?Q?fUvGLmio1SvQwA1pJqu4I4nCFgvRKf1k/hdOD7ZPxTlUoYjhMx2JNzgj/b?=
 =?iso-8859-1?Q?MJgYMhyiJRWHVuwq1JaYbnxjX3GfRL+B6Iib393r4cGoMjFjsevJq1KKqU?=
 =?iso-8859-1?Q?Up4L3dowGjg3XJVZ0ZzTBKfYUE2ybM2y3NQ6IXoLJWywoYSTtVQQ8VrmGC?=
 =?iso-8859-1?Q?klhAD7K7Whj7/Q3FJzcK2VTojMvG0fFWgETWasFIKRHrTuM9VvywxXGvQW?=
 =?iso-8859-1?Q?CWuo0yZvEu0Mh3lxdVc1RqliwzuNqYByIGMkbRuRHgyhiPeueM3Iqwq2xv?=
 =?iso-8859-1?Q?FgbxTMGiAIjNQPfSSWKYcYGDbPuyhnBBEFmsb0OYGqUm5wh+GurN90Q1kc?=
 =?iso-8859-1?Q?zKP5fDpbRauWu5zX6E0tSJtWK3IBfje8qHw6VGHUrmDvdzoGLTfwlRY6Fi?=
 =?iso-8859-1?Q?KBrvyj0Pp/q5eRGTPCDjX2KrzLavQH4mgGyVIGpFkv/kV3aREATvtpDUwW?=
 =?iso-8859-1?Q?Msv8Jz+V8qlX/JfWUSMZp98/z97pcBZnAizHg89oVLnye6LjTHw1ldMN8e?=
 =?iso-8859-1?Q?W8mtTuYD5srYzHqIV6FdJX5TMURdd8pVdHfB0l5m2neuKu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c816fcf1-85af-492e-40cb-08df49b2bf67
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 22:40:17.3556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeuQuODqiSW0yNtH3jTflG6l5z8GHSyuTG1JgkSkoKCobgtAvDdwiQ/wF5zHQnrF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR05MB998884

=0A=
The two issues Sashiko reported on patch 2 are valid:=0A=
=0A=
1. An exiting task that has not been unhashed is on both the task list=0A=
   and an exit list, so klp_start_transition() can visit it twice and=0A=
   set TIF_PATCH_PENDING again after it has switched.=0A=
=0A=
2. Between exit_tasks_rcu_finish() and its final switch, an exiting=0A=
   task is on neither list and can still enter patched code with a=0A=
   stale patch_state.=0A=
=0A=
v2 will walk the exit lists under tasklist_lock and skip tasks that are=0A=
still hashed, so each task is visited exactly once. It will also call=0A=
klp_synchronize_transition() before func->transition is set and before=0A=
completion, to wait out tasks in that last stretch. It will document=0A=
rtp_exit_cursor as well.=0A=
=0A=
I'll post v2 after testing it on mainline. Please hold off on=0A=
reviewing v1.=0A=
=0A=
Thanks,=0A=
Binoy=0A=
=0A=
=0A=
