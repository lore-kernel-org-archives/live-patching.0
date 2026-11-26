Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654726;
	b=b6XVEttoWusfhV/JZUpiGBVr29VDaze19R5606UIxbCt6MM5lNKDOXsPhozx3GIDHM8Y
	 laO6ZNV2dPBgzmWGg5gxtrMWFt32leJid/vDD0kU+w0o1OS9N69/od/Lwz0VqvJD8RoEX
	 qY0iNcaVCJuz7DgTkDY3aJYi7MEC/m09yEuL4Dhox9UStStEkSiCSDcVyLTM/djn3sfJk
	 ZQqKiJZhoLBXjQvuMBHyHcmK9hOJGad5SKT7NNoolAzAkvsaMtH7FGk/S6HukBZKew+39
	 5CWI+rIho4OGgsFQK44jpuJqJ3eNbNrAit/BJYql+8Mp1j8J2hG9JL3gXOFZ0NJPJjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654726;
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
	bh=hXP8RZ3w0MGOH5VE+IOwLzvFeu2XWMfpV5TvVYyypFo=;
	b=am0ua0tvYkHHSPfvZwS2T7kZSxCLK8X5GPSfXwl8q6finixPGPfe5Jsh2nQeA0Wbh0fs
	 fGuiJ09cA9wS0j8xREPH6KyK9xZDEWuFM9J+jqzETxBacGhqGKJqjc/IPqGOW1DBXHDXi
	 Jps/p7720A2Bo8HXAaRFUrqt4BDffqhq/ZrYZoYEpsBv49u2/t1SmkcUjw1vYPKc0G41N
	 +wyzJ8f3bIyKxxa6v6KtvKOUUeCEbPM5mmhYAlg5AXZirsXvGIMsXRbOdkkUsMB8twUZK
	 hr4ocDZotDKp1azNwA4Z3dl/avQ0BDDHR17t6pbrFa28LpdY5fuF8G+259n4c28tq0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vt.edu;
	spf=pass smtp.mailfrom=vt.edu;
	dkim=pass header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=WaYpfYrJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.122
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023122.outbound.protection.outlook.com [40.93.196.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E05606A31E;
	Thu, 26 Nov 2026 00:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E05606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=VirginiaTech.onmicrosoft.com header.i=@VirginiaTech.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-VirginiaTech-onmicrosoft-com header.b=WaYpfYrJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lABFQriLyje+Hc4Tc2xZR06qBct88Su2jkBBHEEwmdBby58c2bMZKfkzK8vDaMQOksaecIGUPZy4Sof8texPH7IaQlnwvO2SEnRKdpMHbJLLSYLZjxmYFMQiuS+hDhyugf0LtK9TOeRikA9bz2VbTVSTf6IxOP3F/+3Z48EIPBJWIqRxvwBS8a7i9nmo2LUVqkDtfF9FCi9qQY/X2sNzc7Ud60b7K8PrzyKBL0CqzI3z0HknrK+adMTRf/nS9lfPgPG1mu0/tSi/miPep/H18hiLleUIR3L97Gc4BUk1urUhvdFlMMZPQCFvZXHt8F9CkSP3SDfn2hhUcZz9Z7rmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=hXP8RZ3w0MGOH5VE+IOwLzvFeu2XWMfpV5TvVYyypFo=;
 b=ipFwh2FF5zaw+dWZIu1VWgux59YDChsrZkPTINQMGrrtxgCPY8nXpNUCuoass6zVNfqXGBYpr95aCvB0Fpa8JQkFqRxyd73meagMs1xMrSwd/n79Y6t0twI40MmscEVZN1VqFQgYTskdmZWSN4C/bpjzNi/Mx16P5uskWy6pdTdGtJy7z4gzSQHVdVL5Dy+a3wb8b5fCuiFU4r5NFmIWvUvUxfgMmSPaYbhu6fS2NQURoBfu7oc+feb410boy84t5+D+xO02xZKCeuZrHbHlRApJCUl/zqCD5u+/87+zqPkD/Q16eNKnpiIGnpybhZBx0K8RG93T3sW2IBoo+1jYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vt.edu; dmarc=pass action=none header.from=vt.edu; dkim=pass
 header.d=vt.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=VirginiaTech.onmicrosoft.com; s=selector1-VirginiaTech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXP8RZ3w0MGOH5VE+IOwLzvFeu2XWMfpV5TvVYyypFo=;
 b=WaYpfYrJ9SExpZfx53vcalzMudWTnWcYvhGnD1ylCabDshUolHqEmwbiwlILEocVZBJiv6E4rjkot2ZUCtoFsQFAkBo1btaMvrbrjcXr5A3ybnsn/8sR8yeNxxuYY9tbFZRquiZMh4QWBO0vP0q8RXmm+2d3gg3TxD/IW5yxD8k=
Received: from DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) by
 BLAPR05MB7316.namprd05.prod.outlook.com (2603:10b6:208:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 00:58:41 +0000
Received: from DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b]) by DM6PR05MB4137.namprd05.prod.outlook.com
 ([fe80::a6db:3b91:d780:cd9b%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 00:58:41 +0000
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
	<mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Yafang
 Shao <laoar.shao@gmail.com>, "Shastri, Jaidev" <jaidevshastri@vt.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] livepatch: Include exiting tasks in the transition
Thread-Topic: [PATCH v3 2/3] livepatch: Include exiting tasks in the
 transition
Thread-Index: AQHdfTJuiyumefKm6UKWCWT4PZeyLrc/cFoAgAAFQio=
Date: Thu, 26 Nov 2026 00:58:34 +0000
Message-ID:
 <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
 <sashiko-outbox-234405@kernel.org>
In-Reply-To: <sashiko-outbox-234405@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vt.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4137:EE_|BLAPR05MB7316:EE_
x-ms-office365-filtering-correlation-id: cdcbfc76-f1ef-4f74-bb38-08df4b586989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|366016|7416014|376014|261026140227099003|38070700021|261026121527099003|261022075727099003|261022105027099003|261028144727099003|921020|11063799006|4143699003|56012099006|10067099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 lg5RMrnw18EEbaV9bL1++33OBxaGkBEMKjrie3xNv7gkI2KzjqnXS1A6tCA4XIw3n9y1t1xxi3A0orYscU1di4gcE35Yl9gVEJooXN5YekfOGFJD3FTzQkoC3E8ETqjDz+cVbSqWKCMijdiobb8W/epCoAycTms4PFcKRaNv6Ao7gz1zh1RBJN1OXfAuK3sVr9zeqmv9pTxfobMZtzwjpKl9vWjEELhwsmpSnYaha2dPzgYDMydaJKxAP3Biak8DfQWG2axHYolzU38zm21JRnNw5TWKBgFMcl1olegW2hRwqjiRkWzQjRO3nc8zkXIYDf85/RMCsczrM9fOdalKFV0UBRVTTYcQKxJaj+/VknROKvy2En2LbelZTkYo7x4sPNGrYJuJSI0pDOIFVAgKLbTy9fPJ58PEP05cqJN6pq/C/BRSNwD+zpl2grZPnRP5AGMsSPzJuvm+rd2JU6KGKV+rddL6GZx32wmBJMycE5yrX6U9xD0+YduEZ7176debNKt9Dm5KBeJExs4l9dytM/6KSS5gOuwJDRv42Nd7KfnpZc/8qItPmgbS3840wbaDpw5Yk4S3Vy5lUuaqt1D1X1KTkw+sxgr525kv6m8NQJToQQS5bTG+9Dxe8B64yX367lSE1+cVtDid4Kpt9q0KaqQ3JZ3cFbwuItwZuY/mrHoxZ+6ZYfSqgRXKVAoWOCgy6k+9mixPw2z0Buav3nBxsq58Err3Kbdnv8cNz2mFN4RRQCvHCeOMkFSszA5X1A/Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4137.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(366016)(7416014)(376014)(261026140227099003)(38070700021)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(921020)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7b2yigXtkepn2/zP+0TloShX78O7/DJHWuxkBCPSqCT3ybImJm7BvPn6Xl?=
 =?iso-8859-1?Q?Bihd4pBgR4+0kuBrSGfwrj3DMOGI/4sNh72oK+zuK/71SVDIGsjgSl1EiP?=
 =?iso-8859-1?Q?69DSNuckhyd0cxEU1Jri4WhxBtNyK6jkEeuhS7sGuLTsVOGO+Lg6hIv7IJ?=
 =?iso-8859-1?Q?bhz5OpW4Zajg+tzT09mjRz5CEa+8w7PvOjVA9fyEDlEPM2NxtBWCKeGfbl?=
 =?iso-8859-1?Q?UdVlHnjGC0IRxCu5uqejFv92V9U73H7Bl8+n0lks4HsxBOE/HWFbOzrtz7?=
 =?iso-8859-1?Q?LhIIANSRbzM6lUdMdr8vgeQnCG55Bw6T9UFfVkNYtb9I2y4MSws18k/LZG?=
 =?iso-8859-1?Q?1zB9UPAOUIgVgnaa3J6uvo28rY4QpckQZs7UpH+Jk8FY8JgQSsAPRLTYWm?=
 =?iso-8859-1?Q?94aRexUMlqs0+I7chk05TSQRF0q2t4boVuYxOogHrNg/fEXcJhsiNBYI+F?=
 =?iso-8859-1?Q?I8TdXWsTejEt5rY7wxFm+FxPqWxYvla3tUy/+GAbWQkxv3lhUWkfU3P7Ru?=
 =?iso-8859-1?Q?f5XZD+4uOIJGoypnRdEqlm+v+Y0I+eH1FyDK36y4/cvnPlGZFRN38ozBQq?=
 =?iso-8859-1?Q?ifgXV0PQsqJ474+6b6kyT5qvxWFHyH5kEnoGlw+UD8DTrwS45Boa1qbAYP?=
 =?iso-8859-1?Q?IQqx+V8vqJsbkOy65jDjF8hV2HNFJ/A9k6lGTwVcvq4USfAhN4gio+k3Ge?=
 =?iso-8859-1?Q?FB7tETSLKFPm1VcSzqtynXvwAmefXTFoRAi4k9OO0lGuU6HfsFyMmQP5bE?=
 =?iso-8859-1?Q?H/BN0zJVYZl5107HNHXzm8RulT5y1uByioveTo1K8Xmp745uMiCpV7g6ty?=
 =?iso-8859-1?Q?CcOw3qPkkNDBW3NzTNIxqsfRnozDkf/7tznzGYRlm/j6VuYQsKVBh1dPzp?=
 =?iso-8859-1?Q?Jk95+ZsDae94CurLXfI4swZVvB+v0cgkWtRatEv9wHHZwr9+pllsCJJrAn?=
 =?iso-8859-1?Q?2VNO36jIafsliDsoDERfI3gfElo1gjMGj4ncfKaSIbvxzs/waqQ8MWE5XN?=
 =?iso-8859-1?Q?2M2QGMYBnCULPjkgf4DqJgD4q8zaZ/oURvqM3mAnzIMUyFCtCCsFOgE4+q?=
 =?iso-8859-1?Q?H5zpwWpeGUxjYmO51sWcHWXtTgS5nVDf85MAuUpRerPKH6c031RZxYSmCT?=
 =?iso-8859-1?Q?lvMPwqDjsJMZUF3AkQceItZ58wCKDiYhMR+kz0NRe5833WceT9ryB+egE2?=
 =?iso-8859-1?Q?0NvKLGL7NVsdAHxMb9Ya3VU68fI9x+OWdFTo3Uuo6Eki1iLM8Nag4k4kwd?=
 =?iso-8859-1?Q?WDR7J6Cz6K8xfQVGdaoGjBFu1eLcpxzRlRSXoE0AKNepmYLbrKwjTkkMsC?=
 =?iso-8859-1?Q?/KWo34n5NCuale1GchRl8KKeJFaPiB5jYz7lzzwe8XnR8/39kkUnuhsarz?=
 =?iso-8859-1?Q?n+CoAqtWscEjeK909NOf9fAy0hlWkJBUPb/TlT0HlpY8wRTAv8KcqTWi08?=
 =?iso-8859-1?Q?QgBUG8W1nt3QgPLgIHmROPDZjC3mR6wODJ3BQLDopxRYGYzE6xtI2jQcu+?=
 =?iso-8859-1?Q?QffkPi08oPPiUqQ9fGW/2ikMJSRpGS4+qpAUvQEaR/J+tOsEuTzdxTDfCi?=
 =?iso-8859-1?Q?wLIZIJmtkMQzEfkz21v2O2J1uwEGbXC/EkjJf/HAQb2upv5kLT8PY0bOeV?=
 =?iso-8859-1?Q?bMc/L0U8jUnzEie8wXpYV2lE/aK7QeGsZK1mhNH7OGk0z+yaoplUYJf6hp?=
 =?iso-8859-1?Q?JHWJRqAxxA/cCB+CQnmjqB5zWy9blEt/iTkekhE5OGKOo1zPcotlCMnJMB?=
 =?iso-8859-1?Q?+GD3jW3Or+oZdLPcOLIFEHakryY5ob+SWp+91SdsajxIQkp1piMptfuvvy?=
 =?iso-8859-1?Q?wlEXgcfQ0Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcbfc76-f1ef-4f74-bb38-08df4b586989
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 00:58:40.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60956884-10ad-40fa-863d-4f32c1e3a37a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVT5AsG9JDfepCk1xXzl76xfBEWx5XoqbbzeQewCuJy549uNUbW1anYOOaVlzqrk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7316

=0A=
Thanks, this is right. A dying task reports its quiescent state in=0A=
rcu_note_context_switch(), early in __schedule(), and then still runs=0A=
traceable code, such as update_rq_clock() and pick_next_task(), until=0A=
switch_to(). RCU does not promise to wait for code after that point, and=0A=
with expedited grace periods the quiescent state is reported right=0A=
there, so synchronize_rcu() can return too early.=0A=
klp_synchronize_transition(), which v2 used, does not have this=0A=
problem: schedule_on_each_cpu() completes only after the work item has=0A=
run on every CPU, which on the dying task's CPU happens only after=0A=
switch_to().=0A=
=0A=
v4 goes back to klp_synchronize_transition() for both waits and keeps=0A=
klp_try_switch_exiting_tasks() from v3. I will send it after rerunning=0A=
the tests.=0A=
=0A=
Yafang, this reverses your second suggestion; I hope the reason above=0A=
makes sense. It also brings back the v2 transition times.=0A=
=0A=
Binoy=0A=
=0A=
=0A=
