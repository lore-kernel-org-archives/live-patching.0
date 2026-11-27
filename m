Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795806804;
	b=vmaIWaDoY2vmigH0D83fJLRP2s5SeLfqjrjZq6TUagzA/lS9Dh3mnz0kUg5XpmpClc4t
	 sMw20wssuXjnunOmU/zfBiwVTiuXHWTnU3HnfV300KhaqWr0gJqz/nR7+hA26q3qwpdhd
	 tVxlZ3GZdqT5s2OjQQvUbDBIZ++/m0SQyh1gwW3VtgP1TCiTNLqbHmoBmh8tnR5oHKOqN
	 ipwJ5XWaddq0ZJ8qxEWH05BXRfa290sc6oHcsBaz6WUt+yybsZ+NMoI6lWfIEzkznhVxy
	 5DWaU//d+NFdRw+0cXfRAG1UyYTN7oLM1t6wd2O2XvbvjJfjNBZJwFnEBHuu6el0Jww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806804;
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
	bh=bI98mXTvhZ2VxOpRD3MePaxrqF+Y5JKcxRA4yg5o5ZE=;
	b=ic6dfy766tfnTd9D1sApXxZipzgYwEyectfaBQhojZJnEx2RC5jJp5uTehjxvDhdyAhG
	 AREYj7Y2Zh6YWWaSPtWUon8OSARBrcaQzJnsCi1RUbXH4Pfci9qxY4Pra491BUtYGb7Q2
	 tUr3by1UGuYORk9zEXxLPXQa00ZYuPoFp12dU2ye0cBeUotCnGAOsY0g7I0guT/clnZeO
	 hDbuWvnerRO/9mo8LERkqPZu0TsRaoFoicMKM/COPjN7yU7ngyg/W7mq0DVAYM6rzZi3j
	 1XKIFqzMypi6kMow8Rfcx/wWmT+GC9BLVbTZkR3271Bc3joVGwL61M65rZY+fBlHtjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=xAB9WiKe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.128
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021128.outbound.protection.outlook.com [52.101.52.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF4606A31F;
	Fri, 27 Nov 2026 19:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DF4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=xAB9WiKe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI6qUo8Ccdb2o3GXTRcm1rMdLv7KQ5feFllrd65yjkWvS3jTtT8GGQmMM8qmN/nPUEeMfxERmKrMSStauHuUucOlOnFHaexBiHDVkNC4W+lxMOztdGp3zARXvOLsMs4CKlsQNecvfjuDmNhF/XD9v8VzlpavHcdEimM6SAfNrK5gtp4fHBbt5jLL8p56PZws6Qas1X3LMqMy+RXRpkOo5L2DpeSprj3fkxiHUKddq18xK1VcEQ0b5XsC6U2WB3WTezCQjpEdOcXOzD0TdDqG+fnQ8vNs3DeD0tp0arFCYpGAK5tp5XW+JjHizA/sEuppXf2CJflS/9Qa1uPvaGgjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=bI98mXTvhZ2VxOpRD3MePaxrqF+Y5JKcxRA4yg5o5ZE=;
 b=ejCCbNd2TvKJKoGPw4ttlL/rwr0Euzv8aE7HW8LU3vvjDMJ3tr2Pl34zZ8LCqMNBY7GR7pJrVxgLkEEMagbcdG/TBgkFlLXvzE6r3FM7BA9Ut/UTx720riLha56xx602vLOv6bhO3rt3R1R+5Ci0FxvzLY9Ole1PEGnk/UeBo9IaYgDkGNmaip5t0Vjl0FbhQ+gozrS+rHb1YV7dr2WKngMB1ZTu4K4Zgl4Ac4QUoRtWE+6ZyfnO1P6NJkBXY3Z4AyoyMf+eoLCJyw6X63IUTQOLyqqIcScdEGf0fsW+Ed83rrdiCb1gQFq2FQUDI0xGmT53yUqCjBP9Y3gm9B2SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI98mXTvhZ2VxOpRD3MePaxrqF+Y5JKcxRA4yg5o5ZE=;
 b=xAB9WiKeaWQzO0tERYqHxPN7Bv2as6XSPkUzX4tSUQwyn4Xk8uQVaBS6JY+Yr6CWnFyvOc574tAEDlZcQXyPnm0s+qgq36WBdt/opv2TjEYvO/OxjBqlW1hjyNVcebDJ6EZz7UlaEKPso+bZCMhCtYZrO1pPs6VZpqhmqYHqMvM=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 PH0PR05MB8919.namprd05.prod.outlook.com (2603:10b6:510:d8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.10; Fri, 27 Nov 2026 19:13:20 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 19:13:20 +0000
From: "Ravindran, Binoy" <binoy@vt.edu>
To: Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
	<frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>, Song
 Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Kosina
	<jikos@kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "live-patching@vger.kernel.org"
	<live-patching@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] livepatch: Include exiting tasks in the transition
Thread-Topic: [PATCH v3 2/3] livepatch: Include exiting tasks in the
 transition
Thread-Index:
 AQHdfTJuiyumefKm6UKWCWT4PZeyLrc/cFoAgAAFQiqAADftgIACUjiAgAAIpgCAAEK+eQ==
Date: Fri, 27 Nov 2026 19:13:20 +0000
Message-ID:
 <DM6PR05MB413770978C88C4345C856FC4D1412@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
 <sashiko-outbox-234405@kernel.org>
 <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbAQuYG__4b054bRobVRyT+v143wBcVAN26T_PtiO-oqmA@mail.gmail.com>
 <awmWExtIJGM805__@pathway.suse.cz> <awmdVLfnwgrS9VfS@pathway.suse.cz>
In-Reply-To: <awmdVLfnwgrS9VfS@pathway.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|PH0PR05MB8919:EE_
x-ms-office365-filtering-correlation-id: c4295acc-376b-488f-a4f0-08df4cba7fdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|366016|10070799003|786006|1800799024|38070700021|10067099003|56012099006|11063799006|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 Bzn0sT2Q+M5POeFp53rTH+CCPOfMSsB1hWUe4/JTMVjiiXHiBbOpxKrp2Atyorg2BDWZjI412a6cPBRuP58V7Yow6ph+f2ObsbTQ33xk86UJn2haMPyK+Jzg9exmW4wk6mk6UnZS3xBsG0aHjoXpZiSRKTyYChzRllcB8cE+nVWtE6Iqj6boL/us8Ou11xnanxSCmYCv1G3NhJe4WXkMymN0gpciYaVS36APNyQZxt8emfzAcHrheaCXLxUpuL0Gc/Omm6i1EZJj29aG7zyZBp7+0a/iUIg5Haf2V2jsFQcNMZB+z1eDM207OmNGfI55qt+mWmIeFrTt6MUSrdmOYZ6B6to4h0DdvKlAVhsFdl705/yjJTVbo5Nhu2oG0T0QpQFF73WSoFt+NhsK6fMpPXFOBM8EOm7m4hBMjEhaxMCHTfkvcXh1Z6CgU2HGbjvF5vGTIF8Q9VFtdpZitxl8IuD00giDM/JCqfAKQnDCu7TGbeZqgxDJj5apmV0rKxmlAk4GLbczxxahPSaKid5N5CiFZUoCT6F6ngJkavGChd2G5JOJqxsEtbwjpnXnwsaJ6mgB2xZx+ZJVfJqi2kbmFmgryBqCcRSFuXgLkt9mzdgprN7M+T+AY0ac5JdQ+3+ObGSagkJq4bWwHoivfjh6Cz9BqGntSINewnE+zsXWqe0W8KA4nJmmOreDoIGdo095DklD0TbMqX1vg30K4/IUMQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(10070799003)(786006)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?z8HydYWR6ewyXRc6dQ7j/768wxC2AEceUT8b8Er3uNYDAXqHARTNTXJ4XL?=
 =?iso-8859-1?Q?cFZJ2ASaXZMzU7OoecGaNhHgZiLKEOJiUt6K17Zho4Uf6hxIjzpqExcnWT?=
 =?iso-8859-1?Q?ce60mqKEIVPdRFKztQN8lJkOyZ0qnSkcvVkVJBjUcaA3Z6HOwqJXciUZW+?=
 =?iso-8859-1?Q?9061BaIAdLkehRuOMPkwAD7P5gN0sMcAgD/Cu2ZIDJNkLc7Upq2iBNOpfP?=
 =?iso-8859-1?Q?dpn5DywtTmzzRpD7Qj9LV95b9B1dwfwYvMUL3imbLtL0uieDdM8FFTnfTJ?=
 =?iso-8859-1?Q?m8XpW1YIQ92XIB1rxKrF5BI+kKtTR+FNhR/I7oYbaudkRHqej2XqOb+gHA?=
 =?iso-8859-1?Q?CX2ynbGNbumHiDdOOKnrz2IQ+hWhNkdOEhISN9ShgaJHaiMTHTXCdIMd5y?=
 =?iso-8859-1?Q?ewFJw2zV+bzBIQcpeGXl5LUGWa74q3yTPcmwxnGKqGfvl1FZlEHQMZ77Ov?=
 =?iso-8859-1?Q?oWtptBG18BXcsV1juOybB65ToBWvHnXvP/vKPg38GS7JNLEQ0Dhqzv+s3C?=
 =?iso-8859-1?Q?mI5YakbH4WotJaoRD64z8zmxDmbkNOb1QE9m4ahT0Fm9PA4Dps7xJ6ttTy?=
 =?iso-8859-1?Q?dzLvY26knb5NoMDcuwbkuqSt+Rl3HxUEEX+iJmLSshLNHvcDyEfNhFCrU1?=
 =?iso-8859-1?Q?C9e4pueYJkVwKsO5Wl+X9Zq+hGm+MlzB+3fw9JTw5cTrRPhqKjCBEUPGCf?=
 =?iso-8859-1?Q?xp49Y589S/Q95H4z9AuINJLgCsWTrFgVVAhXFpAQ5JyB5kwtC3P3SrvhQ4?=
 =?iso-8859-1?Q?5b/nSoLdbImuavesvhpUjmyKO8h4tLRN+IHjg4bwU+0FtNahVOyjy/SPOA?=
 =?iso-8859-1?Q?Na5s3X0XJnL7+4dQSoYrfPwW0oiTQpk7xPD60MV37KYZBXOhyGI+/pZsjh?=
 =?iso-8859-1?Q?GMJbs+cBGTRBoVov2J2Z1Bu0iocvEDakpzQujjNLhUr38kXuFmb4QUS1OZ?=
 =?iso-8859-1?Q?H5tO948F2ln4vzvJnmltQQXu4hXx5Er06VVbA+p3G6QHhmd4xqlBul12Jc?=
 =?iso-8859-1?Q?BUf9iGVaRyv3SvJMsi4bYc/HwUqJghUkIJhxLw6RIWBENuF42vADSwa7gd?=
 =?iso-8859-1?Q?MkOK82aakNC5l6eazxspj42y68IlEpn1MtaXImLiKwoswvbOBhUC4rWME2?=
 =?iso-8859-1?Q?wdNuRnMZbU7dqWZWcKtJz8F/rJp5sUoTzs9GIpoghCAWz5hZcsnESVw9Zt?=
 =?iso-8859-1?Q?96r29LwA4zFI5sr32C00K3Lm6aXxd9BD9HWvdVZUPxWvMKXulrxbU7Ar4F?=
 =?iso-8859-1?Q?UTD81tvOd4IYCOkVQ9bYOhSTh0aAJV6dtDcpGZs7qSq2tH3Ql2O91EFzSF?=
 =?iso-8859-1?Q?O1p4/DXekULLA0ljF3tgLnyLd2JvR28+gQUIRWbph08ThQ7fzKcG4U325p?=
 =?iso-8859-1?Q?1+RCS50lWzgP2ihMQ4BMWdn6c4q4V2798Xquk52Ttm4I4C0gYoJnavIORV?=
 =?iso-8859-1?Q?xqDB9pEXx667BINylbAJrCkTaF5qLw9UDJtbAfkrjnr24jSbgqpAc0H/jh?=
 =?iso-8859-1?Q?2WG6ztoLI/8JW3hrMNHPnGrPao7qtZvH7iskLoqfYLX/IgsZXz3vsNKNX1?=
 =?iso-8859-1?Q?i1c1O8yVFtnry2mKPajfJareTYtAN7tyTKBbYL23QPVikwPSXjQzZp3fSO?=
 =?iso-8859-1?Q?V6AqttL1toZbcyPR98LBB2Knprhmi2HoMva/YC4Ltfd2xzZoCtkLVFvTlu?=
 =?iso-8859-1?Q?LD8GEmw/19MwIshimXiE0vzzlRWkNnTjhljfyR/H0qp1LLsme0pC2XIbm9?=
 =?iso-8859-1?Q?SJo9ksbA+ESUl/Afqgede52lQbAOCu9Ii9F1g8x6DImbwh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4295acc-376b-488f-a4f0-08df4cba7fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 19:13:20.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skjt/0b6m9W9ZswqDeZGjkLXJCZLnraEN4hDBeyzgXSQOAuRaRSGju85SXwM3Qmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8919

=0A=
Hi Petr,=0A=
=0A=
> By other words, the task is removed from the rcu_tasks_exit_list=0A=
> in the later 2nd RCU period. So, if synchronize_rcu() is going=0A=
> to wait for this 2nd period then it might end prematurely because=0A=
> the quiescent state is reported by rcu_note_context_switch()=0A=
> early in __schedule().=0A=
=0A=
Yes, that matches my reading.=0A=
=0A=
> But I might miss something. I am not sure which period=0A=
> synchronize_rcu() is waiting for.=0A=
=0A=
synchronize_rcu() waits for RCU readers that started before it. Of the=0A=
two sections that the comment above rcu_tasks_postscan() describes,=0A=
only the second is an RCU reader: the stretch from the final=0A=
preempt_disable() in do_exit() to the final schedule().=0A=
=0A=
rcu_note_context_switch() notes the quiescent state early in=0A=
__schedule(), before switch_to(). With an expedited grace period in=0A=
progress, it also reports it right there, through rcu_report_exp_rdp()=0A=
(kernel/rcu/tree_plugin.h). The grace period can then end while the=0A=
task still runs traceable code in the rest of __schedule(). RCU does=0A=
not need to cover that code, but livepatch does.=0A=
=0A=
klp_synchronize_transition() covers it, because the work item can run=0A=
on that CPU only after the task has switched out. It was also cheaper=0A=
in my tests. With synchronize_rcu() (v3), the median transition time=0A=
went from 8 to 12 ms in the default mode and from 8 ms to 0.8 s with=0A=
preempt=3Dfull. With klp_synchronize_transition() (v4), the medians were=0A=
7 ms and 11 ms.=0A=
=0A=
So v5 keeps klp_synchronize_transition(), with the comment reworded as=0A=
you suggested.=0A=
=0A=
Thanks,=0A=
Binoy=0A=
=0A=
=0A=
