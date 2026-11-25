Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795648149;
	b=EZWcb0w/Nfpo5En5xhcbCafNLH9NIvido4uhrPc8P5MhXKi/NB2og5r2PX01K0tlwqsB
	 pB7cjdhv9vMd8uv8fY/cUAF1W2kG9ZZ0W+paoe/QUDIkIwL1jdSk7LvxzZ5petgRmfV2S
	 3QorEBn28QeOpecyRW4k0wEwVwoUu2JgKqLV7GBISLLLlfsmGZSt6oO4f4PE5nLV7S14a
	 q9NQTDjaFjSe2hL0u8KVrJVhYUQdmg4uD/wInCkPQOX5C4AvtIqW0eBggoTu38d7qolkh
	 GDEoCg6uaXzPENk12uoVdntAWDQV8x/5GwrgSDNbrGyCazsSIyZLkvxxa75MMk6TIiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648149;
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
	bh=5PiyDVhNF0dRr1J2kLFRQZyuceWh1Ki+1kWbHNtK0fg=;
	b=fJvDLl3QWMZ/jtqWg5xgINSRPEkNyk8HFEjOUOVutKQ8PHC8S4SaD571e4etJ2igJLCI
	 s7As3FmA0KMRw2pL+r8zUEoGzeUWjnKL1iJd4sidhfoLHpnzTGetPkeciTZl+3PzzAQwZ
	 qlwaIsVO6WVmhgtI7YZkOu4yumnAuNKCMJS26eyJ3JekIkgNQV6B3NpU0Rew6rrrsCEQf
	 1V13pCPbWAKne274WiKGY+Lvy1JEjwYmz+a4IZw4JRdaKDPN6gUpIuOx5luoGm6QvuX9F
	 TA5tuUekWCGjleFNlSQbdRFEE5FMOuGgcn6SKU8QxkHi3tWyh15bklsfzgUm//2fvoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=aglEhUsb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.98
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022098.outbound.protection.outlook.com [40.107.200.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB86606A323;
	Wed, 25 Nov 2026 23:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB86606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=aglEhUsb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0EPYT8O94QQJngG/O7oXAPJEVO9OYNcfXy+jz2SBKk8pPkGmLdMFoHtnOP5HYGgxVrYV31WbAiAypuB8BlmjBrFCrmpiGOvyXbGTyKfWTxq02aKSLT/GTRowrmexlG96DsvwnjqOV/8+qpw4Q/CUaz4uxDtIrggmA+m8ScZYKJBTKbVuKo534pUXka87QaGku6WCLV5JhudfLdY6maM6/1T8lY/nn7EJhXxEFHn/SsCAjwBy+My0VQME28wBpfLhnG4ynzY4Jp1QnASLETfjiPlGbabVNE3RaEdgIebMeuuDaUMTcKjg7SmAoUXI32SV/S98oD2PWWp60JSkJ4aGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5PiyDVhNF0dRr1J2kLFRQZyuceWh1Ki+1kWbHNtK0fg=;
 b=W6zDwupKPl0FJtrs8JzkbEDVFbjINQX+JBNQR345EYK1VFmzTAwV/nFP54vvFkgYslxn2aK1XNLYiY1qz7R+5g5HEW+OgmBwApzS+uIKxssCBF4ATigjzsNI8jiYexa2LReyRdEyTNrEjAaGjRlDfYcqwvxsXcxbHlUJ90UKGQvZRg2yKHjzMiwFq2OVxTvPkjAMZtxHF+SOULhcxn1AFEoa6urHtllhig9WJka7E3pgTkxFbu++xwOsCQ53rDn/W7lcv2NpACuF06tBvBzRj3+M5weuf+pZPnTrYKYA6PAyOjSMMKVdWERNj+byJ1HjEmNZ7claohhloe7Z2t2TZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PiyDVhNF0dRr1J2kLFRQZyuceWh1Ki+1kWbHNtK0fg=;
 b=aglEhUsblJvh4Yv99cSn3M6DJqTmWsdM3cWWdYBLdCNuLQHrPe4Orq5twN5hmEoj23T9Y4cWZgqDjApNYGGEx9fdb4oN4sQ3B+k+FJs14m+3a9b/kZMF1pZ0XnQ4rD2ZA+ZqMBjZGYptDhp1yWeJx8hkoEorLKcrK5GlCx+B36I=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 SN6PR05MB6638.namprd05.prod.outlook.com (2603:10b6:805:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 25 Nov
 2026 23:08:59 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 23:08:58 +0000
From: "Ravindran, Binoy" <binoy@vt.edu>
To: Yafang Shao <laoar.shao@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
	<frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
	<joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "live-patching@vger.kernel.org"
	<live-patching@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Subject: Re: [PATCH v2 2/3] livepatch: Include exiting tasks in the transition
Thread-Topic: [PATCH v2 2/3] livepatch: Include exiting tasks in the
 transition
Thread-Index: AQHdfClvNP3k139GOk6eHZFGrstIR7c+0a0AgACYqmI=
Date: Wed, 25 Nov 2026 23:08:58 +0000
Message-ID:
 <DM6PR05MB4137BC9878BC4D758AC9C191D1432@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261124-klp-series-v3-v2-0-50d20829a337@vt.edu>
 <20261124-klp-series-v3-v2-2-50d20829a337@vt.edu>
 <CALOAHbAtgHUU+eY7LMOscmua23mqEd0EpU8v7Z0wG-E3qh-dvA@mail.gmail.com>
In-Reply-To:
 <CALOAHbAtgHUU+eY7LMOscmua23mqEd0EpU8v7Z0wG-E3qh-dvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|SN6PR05MB6638:EE_
x-ms-office365-filtering-correlation-id: 5e9321cf-4a68-4ab5-abf9-08df4b491619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|366016|23010399003|786006|376014|1800799024|38070700021|261022075727099003|261026121527099003|4143699003|11063799006|10067099003|261028144727099003|261022105027099003|261026140227099003|56012099006|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 S47CRz83soi1KLvDsHJgPeuiUORJoDerKhfozwP/ODx7I8Ogw82g2+i+g3zOYEzCAzQJtvs3LCbyi8U2EeTK0RH3m39+xc8Mhmr3Tq7bO6IrIC+RIjO+/BKDLMo1a91ptdkuV+MMkn1eoRJdzd1PkTXUabyDuA2GUjK5c6hIl7KzmN/SJ/q5H+qMUBJ/Fd0+4ENoBouFXHdWsjsLJkBOp7kQ16NphcWFXr2doyzH+0La1de7hNv+0LCEWMyRUUQKNYn2slgnWJnVGRggy5KWFpJzdgDOKnlfoht0p4KhTJTrwpdKe1lxSuyHF6TgY0RJ1OpiBVF58PHrjuodRKIn8xHxjKfkXOBERTKnYUhmUQTJV5fwDYZIyTXk9ROrIvF5oK5PuPVeX+j/4w4REvNjPRJdiAUaIrt2NMmWDILF1virSzop630+sAURJSnG3P29e7ERYi0GuNbejjlZz8U7qMg6a7uKQnc5cG+QxCXCoCJs4GJz5yU48euVu2hvNAYZjZYWzw390YaHskW8aOLd/tRBH1QRbTD5QG0DRBNSp8zqoMpexffkHVgBmR9AJdwOHOW24p4gxxR+0wAUEbYL3fQdbkzr+LJGxNBvwfdO8+G73Bm1/LYv20OrsmfBGGn16VJBqnXbrCGEN2kJv3pekjYKpN7/287XdXzxYHAeU5hhTZEsxFH+fmhJAfrQLIfF9qa+XqffZV+m+3Ga4GBIUMTJb224fAAao3bVAp5+6Kc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(23010399003)(786006)(376014)(1800799024)(38070700021)(261022075727099003)(261026121527099003)(4143699003)(11063799006)(10067099003)(261028144727099003)(261022105027099003)(261026140227099003)(56012099006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?L4PzBZ9E3KGF09wXPEcL/eRAyBtqJO1HrMzjdxrl1lg3X5s6IH8iKsz0qV?=
 =?iso-8859-1?Q?QKiyHTt48m6tMHQTKXyulCpsy/w/jc4SxU7dj/dudD6jMJWM41CdM7ohVm?=
 =?iso-8859-1?Q?f5tl7y2B7jRhR5o+wlBUfbsaGbkC4w5Y6FXYuBu9QGRo/QUK+aGX855WdY?=
 =?iso-8859-1?Q?yKCcrqREQW92zumoHs0RXRjF6T36C7IsNpl1hxPex5ufdzP8DOkatgAV8M?=
 =?iso-8859-1?Q?uchfoQ0k2cpCS0Zmn+I1RNnWXLuefu0qud/vLvEXDdwXPovP8AUV8PA3ro?=
 =?iso-8859-1?Q?xnUWJk0SDwgjEr0aGxuD2UqHa34WD9EPtDIiRn11wASK55LOY2zC0edF/o?=
 =?iso-8859-1?Q?9NvCr63BX1FDzK4sGFlQxNwHGmCTpqAwwO9KuYoYn2unBMXj8UJZ+C13rh?=
 =?iso-8859-1?Q?cYAbwX7deI+BVuOT6fX8WPke8/LUbtLgZLQQPvge2p76HOwvVKO2C3XrDY?=
 =?iso-8859-1?Q?+xaa1IINaDhWbq4W0mM9xfsaNck0oiWycjFEiZahxRKxcZ1tAAx40s8E0x?=
 =?iso-8859-1?Q?e5eupEKP2qGhH4DbkB/4+oXIAfjqcAlUKCDXNmHddSfuhkwZZg7mnmaE+B?=
 =?iso-8859-1?Q?GIHRlZgwXXzcJ+jGjmDnw9M1G70bzqz26Hg89cqhKLxy6P9rBzHxeCCR6G?=
 =?iso-8859-1?Q?+f8UWX+bATNwbnpCQywJmG6TEBawKp8zTy6NkWmATJu6+BaM1dsMDCWjQc?=
 =?iso-8859-1?Q?syipzJzutKmvWEX0bNcfamNTE76FNeAiyt9W8yB8V3bnjJsnaKEBxXBNrt?=
 =?iso-8859-1?Q?kASCsKRyrsDsntRcIeEgUvqUMdNdiD+no9S81PzmzoZSiAeJtIypJx8lhm?=
 =?iso-8859-1?Q?ulV1WyUlAKpuNW70xi1vnVXmGvBEtI3yG1ZOnU8RvrDhDckFsrdKolg19L?=
 =?iso-8859-1?Q?yS26r2W6gGolUVeBITrAi44fXiBf8KzgAiHe/bWxkx7hD66L3PGuBEixhv?=
 =?iso-8859-1?Q?19E/qh9IHUmmqPts6LHaqfGS8WtVXVtGYQxpxF6advo0cbM5wjBrHOy28Z?=
 =?iso-8859-1?Q?dE7bWj7+C2A4C4D181G7fjq7GK5lxxJR2lC3HoJ0gbQ1yvOYBSCKfqg3QC?=
 =?iso-8859-1?Q?MZfgH7hsUI7oEeyrxyKA1mKWij27h7gLcc1yifeotEeNlVxq9N9A1bUcgY?=
 =?iso-8859-1?Q?vjTJtXZC+OVjwwXeqtkmW3Snhk8et6hauXxrlHmslqZgs6Axu3lG/1loGD?=
 =?iso-8859-1?Q?CM6/6fTPNKAj08RfaA2lKiHDNtI5tuq+CS6UeNo8pug7xb/nWVAH/7R8Lo?=
 =?iso-8859-1?Q?Gezvn6I32djv9sc4RmV/j0R6nNKkxswny8aJOfONa/f3mEMv8icuE1TevG?=
 =?iso-8859-1?Q?vnjGTU9CRxXXvNN8svSmLiOvdZZ5CIUd0HsZl4nIKWQoD1QG/PsJiK/ShU?=
 =?iso-8859-1?Q?2iDhVixA5AwJrKU1Ds8J/tSLMk+Vjj/Dr0iftHFSrPZiE3TMHhD54kUsPU?=
 =?iso-8859-1?Q?ulzLUuaZQLPFftXzZ03i/ovUBy5AfPDMujJI41RiVBM+azh9Y29BE/zjx+?=
 =?iso-8859-1?Q?CmGES4dYcUTOkzeRGJ1rCp+HWb82L8xlT70UY0oduvHBAkmC8KclW5cl66?=
 =?iso-8859-1?Q?oLCFsEcmk9RAwefBx2+u2AixShL7MABQUvQ4+P6yhn2Ft2XEl8ZBQ0xP3u?=
 =?iso-8859-1?Q?4uuJ2/PLOBG1RVpAeWaZOOBtGuxncYG4k/cGNYVjXcdkr4Ah1WztiScHQ1?=
 =?iso-8859-1?Q?RXFstqN6MfDhOog5yXgeKBu2eYHxuu688hopV+NwnscQ8uYpSajJ3ommO5?=
 =?iso-8859-1?Q?Ast5W9zriAYPq0bgo1d+XqZMbFynuZP9iVge1HRWCeMZDd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9321cf-4a68-4ab5-abf9-08df4b491619
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 23:08:58.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFFGi/t1tVu7rj9iG8R7+JkqYp0SXrrCC5pYZrwk8QuOEzCQzbxw1aEfcY6Kws6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB6638

=0A=
On Wed, Nov 25, 2026, Yafang Shao wrote:=0A=
> klp_exiting_try() is the only function ever passed as @fn, so does the=0A=
> callback indirection buy us anything?  We could drop @fn and @arg and=0A=
> let klp_visit_exiting_tasks() return the result directly, which would=0A=
> also get rid of the "*(bool *)arg =3D false".=0A=
=0A=
No, it does not. v3 replaces klp_visit_exiting_tasks() and=0A=
klp_exiting_try() with=0A=
=0A=
  static bool klp_try_switch_exiting_tasks(void)=0A=
=0A=
which returns false if a task in the snapshot has not switched yet or=0A=
the snapshot was incomplete. It sits right before=0A=
klp_try_complete_transition(), so the forward declaration of=0A=
klp_try_switch_task() goes away too.=0A=
=0A=
> Can we use synchronize_rcu() instead in the two places this series=0A=
> adds, the same way rcu_tasks_postgp() does?=0A=
=0A=
Yes. Both waits only cover the do_exit() tail after=0A=
exit_tasks_rcu_finish(), which runs with preemption disabled, in normal=0A=
kernel context, until the final schedule(). synchronize_rcu() waits for=0A=
that region, which is exactly what rcu_tasks_postgp() relies on, and I=0A=
agree that the "RCU is not watching" argument behind=0A=
klp_synchronize_transition() does not apply here. It also avoids=0A=
queuing work on every CPU.=0A=
=0A=
I reran the tests with both changes. The reproducer, the lockdep and=0A=
PROVE_RCU runs, and 20,000 replace cycles without the injected sleep all=0A=
passed with no fault or report. One cost showed up: with preempt=3Dfull,=0A=
the median transition time in my exit-storm test rose from 8 ms to=0A=
0.8 s, while the 90th and 99th percentiles stayed about the same. I=0A=
think that is acceptable, since a transition is not latency-critical,=0A=
but I can go back to klp_synchronize_transition() if you prefer. The=0A=
details are in the v3 cover letter, which I am sending now.=0A=
=0A=
Thanks for the review.=0A=
=0A=
Binoy=0A=
=0A=
=0A=
