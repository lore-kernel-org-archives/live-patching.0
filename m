Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021115.outbound.protection.outlook.com [52.101.65.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC83BFE4C;
	Wed, 30 Sep 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760206; cv=fail; b=kGTS2C2QA6zmi+x5WActVWxHdpQzgfH87IJPP41yU36CwI4rdR3RmAVilu9jUcbl3HQIPj6O3xNRvqK0u7AtdZT9Q1ScVAjrgS9oIriB4Ez6MJEd+pFh/P5xDXit1wnTTSAmZxe9MXM8phL/FivrVLmtJ6opOESBEKtymOVy4Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760206; c=relaxed/simple;
	bh=ABcmZjCGNR6vsgciixBcRJ/lF0QMuCx366c6+5qJFBQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bbpvm3RdGjYb6p/jS0GzORw0Lt4goHMCBXZfSj44Ijg7b6dUUKgieargLISx/Ep6N45JiL17EjvQzb01ZgOhKa40sX9AiNYzFYA0vTtJ6H7vbrvnTtmF17q8oLSsOTjT4mWp0Kq9kIms+AmPJ8xbIy6H0vV6N/iphpZ7eXcadvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com; spf=pass smtp.mailfrom=nebius.com; dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b=U8LpiSYh; arc=fail smtp.client-ip=52.101.65.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebius.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b="U8LpiSYh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH0Q0V7AfLkfGjZ2ev/33dUsZpmKmHmmEHsXUG4fukROzvNrKjCrfRBDxrEGN8K0ZEoxFwM4NzRnObpUdPapN+n5HnnuagLgxT2NUA+rakXD0VDoKrqDzFtiPKRokV7oOu9ahDE+V3+dsZB3H8qpBHVgM/R/nWxHDxOFnP9c6SPbrM0C9Y0rii/wFUXc484+G5imHjuLaBWGAVSjitp4vXFyy4eAeqlJ2G5kvwPEcUf6tg9N8zI6yYfgkQXIdYwHg4vnuvZhhqDrTohawGRXv4ZntCERiHfju8/n/Ucjj4XYnMz2eVfzE3pmqpBUZXxz+v/0FNXa2hAxKbskrA84ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lSdgahW7xBc4gA5XvwDX366k00q47Q8hwFNKYK0cjw=;
 b=OipsQpZHdsISiZNoOY51sVE5+k0KUGc7srD52cZ+T/Eg49S6q829hMYc/khBV/1a/GiQ08TjpG/X3Wxn5XDV/g8RZbb/i/KYEflhhsphTM5wyg2ney51lVK39ybSinJ976wnKpbfs+T0Wf3qXiHWddOXOXTcm3QJ8EhtUcRLV87HVtJOXleXZoeJE10XnJewiziEkNV2yZKAbaDfTvU91FkuGXK24xuQcAcnzLKQ4mZldAenRXVvbkemOS/F5aF6uOQWE5fpdxj+2gn6dYtpV9mBnWTJwQ5PTpuwE5ELofBbcmqom6mKjntFcR6Lk7SIXYryzcOAdhh/LkzJdQzTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lSdgahW7xBc4gA5XvwDX366k00q47Q8hwFNKYK0cjw=;
 b=U8LpiSYh+/RpbqA6w38PgBMv3n3mpPz8aU97/jlH1FwKqSR4mqk8oa1EERrEnVXXUal/oypbCarQCG6KaX9PurSxZFO466RyBv0aGDS4fucSu0ZuhZ0x1qB0rLl4+uRwXd1WG2ihWL5Grtvh7adu1IYOaBbjptse4P0ysVmo+44iP11PC7/WYCvNt6bWpy0EYiB2qUJyxPo1wgJHLTj7KuYmiJOr/fmaiAkAebuZRClM4qAc3M4ASI7WoUZ7h9J96oHB1VxWSltir3XN5hBRW55Gmjed7s3awnGEhEOgMQ9+lyv/lOnJF2+JViB7ImdRbNKT/CTDmcOtAooo//cX9g==
Received: from AM9P190MB1666.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3e5::12)
 by DB9P190MB1745.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:23:19 +0000
Received: from AM9P190MB1666.EURP190.PROD.OUTLOOK.COM
 ([fe80::5466:4545:3e0a:8e43]) by AM9P190MB1666.EURP190.PROD.OUTLOOK.COM
 ([fe80::5466:4545:3e0a:8e43%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 09:23:19 +0000
From: Dmitry Malkin <dma@nebius.com>
To: "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NB-Core
 Team <NB-CoreTeam@nebius.com>
Subject: [PATCH] klp-build: Add an option to set the livepatch module version
Thread-Topic: [PATCH] klp-build: Add an option to set the livepatch module
 version
Thread-Index: AQHdULvoHTLwfEESW0CL9UwJl5Ssng==
Date: Wed, 30 Sep 2026 09:23:19 +0000
Message-ID:
 <AM9P190MB1666E0A06E9F75E93BF960C9DB8B2@AM9P190MB1666.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P190MB1666:EE_|DB9P190MB1745:EE_
x-ms-office365-filtering-correlation-id: 6438e043-1321-44cb-9c61-08df1ed47798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10070799003|10067099003|11063799006|56012099006|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info:
 4aXSMDpE0uSRp4KWyuDFzsTUzvP5opWcpyFmRbClKgxExlwSKlpA+kCI6/SQYKE3rwAi5i4xTBpbehmPg43YqtuJhYT+GFu/rQt9thb9QYRiZbbNAp2iPZcSgHyLm/DJcXhWuPNLBznTdBdWVTsoFZFROxbNYSKd1tgGk+DV+bkjPzKV528JgRmqlrqo6wMWZdN4T5DXyXqALvC8h43Rb5dLK67N/hIHNvNfwKdC5xaD2JmUcQoiA4e33iO8QpBRH7MJ1RDHOS63HEqFtYG/AwZ++cR8E7VOl0wdAtcS8rgtyiMCe4qoB+L6K/Yth2I3YTuYarpjhiRQOvO34vS+vz4ZbwC2bcnB7iM+mRt7BzOyL/iEevivZKmH83NZkC5TedUZkxx0y4Per9l8bH+32hPYFeMnOAnxRUnd1Jm5nyei8SCFa6omoj9QJNSpuEBfvtVpVRsma/XP+Z0hKUKkKxVvt/8XBn3JtmSTvpf98qkY8jn4o5fVUCzePk3oo0Rk4o1MVH8nEyXPhpuxs0l8LH2by4IyaV0HQFmC2EB7VJtxr7yuP4UII1ruEalmwov929Oat4yUKEaK0Hw6nJUKqFCnWqTErFUmuDViDJC+tv7CBoX10Ko7jnahtFQzhyygKMMhpeZ5xJEp90msORA+jUBwUatyh0gCT9IwJVkGhSoeSfm+mclQ4KN8DNPZOWjhUeQ6Eh3+woYCLmDKXXB5knEAqnzcCL6OUxBpvS2FbzI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P190MB1666.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10070799003)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WRqAHj7JyKtRabb0ou4pXQ4y4/wPnKETD3fuf4I+9pr4l4VrW8pLIB0g1m?=
 =?iso-8859-1?Q?FAUUOEa5YjEk1/fXGiEzXllpMn7c+mUDQEnTiDanakMhc5eB6D/DsKTEUS?=
 =?iso-8859-1?Q?9Nb2VW6wMBfEqIGbO13pO+eWuqvlCtgVVzt9F9si4aD6kP/upT9gJAmeLH?=
 =?iso-8859-1?Q?aWOaY8JDOMsJrpZ4k8g/kVo6+QGX8h4tCiElZcY5mZMWv5V2JyuRtdLquZ?=
 =?iso-8859-1?Q?akJOs0YOX4FNm0zfSziOVpSz7MUwGTMxbdZUZIpU/l1A/44egGC5ILuy8O?=
 =?iso-8859-1?Q?iQh3k+cderSPzmqA7e+aANN1WrEQ+OlsKrDcfKnsLSLpS/Rkswybef8kJK?=
 =?iso-8859-1?Q?MCv4+M6OKmrjkfwEWkQL/iaZc9gIUG6sg7yGVl8OtmI3ADWkTGpFWVv3kR?=
 =?iso-8859-1?Q?JzAiwZsy2iI3mbpPAWh7JIQW1dBjk8D0bnVvI99OotmoZEES2n/o+4WWMQ?=
 =?iso-8859-1?Q?9J/4lH0q9Rf6HDsu+d6IkAxeWJwlgfy/KZrhcf6CFe4gtmeL7t7AhdTb7X?=
 =?iso-8859-1?Q?JgdW6duATc7vGtR90aC988/XzZylrCJjNrAtEALuDRGm0iPVgRbUefRY2+?=
 =?iso-8859-1?Q?0fow73XkCpkF08TbDqXLacWf3wI1dXGG3+VSTmRIlL74TG9pehr8zdTlN+?=
 =?iso-8859-1?Q?Ycj+/kEY/pHrGC1QuREvetSc6RSNSQ/P6L7cLL/uGD0lZvXhCUZd+tD4U5?=
 =?iso-8859-1?Q?2XtE0FFHzESoxL/y8TcXfm/jfaI/KiOktetVbjWWQ/gBwqNXVqfbedZ4LU?=
 =?iso-8859-1?Q?QQ4+WPNd1KMbr/HS0oOCHIIl2XZFK3n3EN0sUUPzBOM97kkb/zldISuWMt?=
 =?iso-8859-1?Q?qKV9G4pQ4D/pAGHwEBN0qk8QDqiwKxM68ByqILcrftv6zW6vsxH0U/Vhxj?=
 =?iso-8859-1?Q?8UYlB55gnRWUBGp21usNqp0B46XVEAlOzzEZh/lk/2HOWl1NM9gErSlb5K?=
 =?iso-8859-1?Q?MbBInIXxfJWLT7YWplkdCUR9kcG7jcg785MM3ENMD1H713J/yiuQq7kQVC?=
 =?iso-8859-1?Q?Ue8ZJ54FpRmHkJBtCEK9TouGusO34oa6ctjM0iMAIz6l4DNjVwF4yLCuqx?=
 =?iso-8859-1?Q?EMrSA5ZtMIugpkfXUvxQRGxSj23No4BjgYRUP5MeV6tu4Jh9p5kaOFU8RU?=
 =?iso-8859-1?Q?0m+rgVR/4PdH49VK4ZygsspwcdhVG3qQjDEiWcygjY+O4sCE7ehv6erSXC?=
 =?iso-8859-1?Q?ODSxi0m567vdr9flKRk2MG+ICA+SHAWlDJzEjbe9MzOSzXTnN/16v3e9yY?=
 =?iso-8859-1?Q?BiRcUh7pqRNzMstp85ldxFVyAmPWnfZ7BNYz927fQjl0hbnOGP/1pJ82Df?=
 =?iso-8859-1?Q?vT/Jkr8ubxiyGDn3uhFj0pO8BL4biZAmR+xyRsBVixXz66AhRt6IDGknTQ?=
 =?iso-8859-1?Q?3/tHvXQI3bxClXwq9FkLIvBEasB3vJ/n3I0I/FqceM1tSp3bGc5UWA3KhH?=
 =?iso-8859-1?Q?wJPuAKIlKLig/xlMaUSm02Hq6xpHJjFb617fhqL7qm3t+FbPGbZ2+yRuCL?=
 =?iso-8859-1?Q?Vh17LNWhxac9ywv6DZs/5C1t8p3zpHJA9SeZ3FmOc8pjETCoTBbGOATGQY?=
 =?iso-8859-1?Q?ov58enk/DrB9o5kNs0cRbfgS8euuekMt6nCSyxWy/quJd0IVHuOzJJaUex?=
 =?iso-8859-1?Q?N9L0GvjoivRzsPYyM8Pd1gQmkrGJ6C29Jre9t+AROZXu87w0LhLRRY5nUn?=
 =?iso-8859-1?Q?OAbpwtvLQoFHzmsou6lOD4OEOQx93hg5PX6YMORguRGE0cikfRrkAKI0KN?=
 =?iso-8859-1?Q?DADF5Vrl4fQnMKn2u+2+ElEjirULbYz1gJXcG/aT25HFRmNtejRZwcTiHD?=
 =?iso-8859-1?Q?K1Xh7ha4DQeRwrola7xMiIQxhrh7jANeJY+sdYQaeVpeCKMbzSpZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1666.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6438e043-1321-44cb-9c61-08df1ed47798
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 09:23:19.8239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SczqzPor3wwqaQVLif7KHNvUW+KjmST8BiGM2bD8eSI8avtK3ZNPbbbQvbKemFkW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1745

Livepatch modules generated by klp-build do not contain MODULE_VERSION=0A=
metadata. Add --module-version to identify a livepatch release=0A=
independently of its module name.=0A=
=0A=
Append MODULE_VERSION() to the temporary copy of init.c when the option=0A=
is supplied. Restrict the accepted characters so the value can be=0A=
embedded safely in a C string literal. Leave the source template and=0A=
default build behavior unchanged.=0A=
=0A=
For example:=0A=
=0A=
$ scripts/livepatch/klp-build --module-version=3D1.2.3 fix.patch=0A=
=0A=
The version can be read from the resulting module file without loading it:=
=0A=
=0A=
$ modinfo -F version livepatch-fix.ko=0A=
=0A=
The version is descriptive module metadata; it does not control=0A=
livepatch replacement or compatibility.=0A=
=0A=
Signed-off-by: Dmitry Malkin <dma@nebius.com>=0A=
---=0A=
 scripts/livepatch/klp-build | 14 +++++++++++++-=0A=
 1 file changed, 13 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build=0A=
index b52a8489d9f6..25e91fef3fa7 100755=0A=
--- a/scripts/livepatch/klp-build=0A=
+++ b/scripts/livepatch/klp-build=0A=
@@ -22,6 +22,7 @@ shopt -s lastpipe=0A=
 unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE=0A=
 =0A=
 REPLACE=3D1=0A=
+MODULE_VERSION=3D=0A=
 SHORT_CIRCUIT=3D0=0A=
 JOBS=3D"$(getconf _NPROCESSORS_ONLN)"=0A=
 shopt -o xtrace | grep -q 'on' && XTRACE=3D1=0A=
@@ -132,6 +133,7 @@ Options:=0A=
    -f, --show-first-changed	Show address of first changed instruction=0A=
    -j, --jobs=3D<jobs>		Build jobs to run simultaneously [default: $JOBS]=
=0A=
    -o, --output=3D<file.ko>	Output file [default: livepatch-<patch-name>.k=
o]=0A=
+       --module-version=3D<ver>	Set MODULE_VERSION metadata (letters, digi=
ts, . _ + : -)=0A=
        --no-replace		Disable livepatch atomic replace=0A=
    -v, --verbose		Pass V=3D1 to kernel/module builds=0A=
 =0A=
@@ -160,7 +162,7 @@ process_args() {=0A=
 	local patch=0A=
 =0A=
 	short=3D"hfj:o:vdS:T"=0A=
-	long=3D"help,show-first-changed,jobs:,output:,no-replace,verbose,debug,sh=
ort-circuit:,keep-tmp"=0A=
+	long=3D"help,show-first-changed,jobs:,output:,module-version:,no-replace,=
verbose,debug,short-circuit:,keep-tmp"=0A=
 =0A=
 	args=3D$(getopt --options "$short" --longoptions "$long" -- "$@") || {=0A=
 		echo; usage; exit=0A=
@@ -189,6 +191,12 @@ process_args() {=0A=
 				NAME=3D"$(module_name_string "$NAME")"=0A=
 				shift 2=0A=
 				;;=0A=
+			--module-version)=0A=
+				[[ "$2" =3D~ ^[a-zA-Z0-9._+:-]+$ ]] || \=0A=
+					die "module version must contain only letters, digits, '.', '_', '+',=
 ':' or '-'"=0A=
+				MODULE_VERSION=3D"$2"=0A=
+				shift 2=0A=
+				;;=0A=
 			--no-replace)=0A=
 				REPLACE=3D0=0A=
 				shift=0A=
@@ -827,6 +835,10 @@ build_patch_module() {=0A=
 =0A=
 	cp -f "$SCRIPT_DIR/init.c" "$KMOD_DIR"=0A=
 =0A=
+	if [[ -n "$MODULE_VERSION" ]]; then=0A=
+		printf '\nMODULE_VERSION("%s");\n' "$MODULE_VERSION" >> "$KMOD_DIR/init.=
c"=0A=
+	fi=0A=
+=0A=
 	echo "obj-m :=3D $NAME.o" > "$makefile"=0A=
 	echo -n "$NAME-y :=3D init.o" >> "$makefile"=0A=
 =0A=
