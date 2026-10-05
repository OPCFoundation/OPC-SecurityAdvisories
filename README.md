# OPC Security Advisories
## Overview
The OPC Foundation publishes security advisories that affect specifications or software that it maintains or distributes. In many cases these bulletins will affect code that OPC vendors incorporate into their products. As a result, vendors will have to patch their products to address the vulnerabilities identified. 

Any vulnerabilities or security concerns should be reported by:

1) Submitting a [private report](https://github.com/OPCFoundation/OPC-SecurityAdvisories/security) to GitHub;
2) Email to ‘securityteam AT opcfoundation DOT org’. 

A PGP key to encrypt any sensitive security report can be found [here](https://opcfoundation.org/SecurityBulletins/securityteam_public_key.txt). 

This repository provides machine-readable security advisories using the [OASIS Common Security Advisory Framework (CSAF) Version 2.0 standard](https://docs.oasis-open.org/csaf/csaf/v2.0/os/csaf-v2.0-os.html). By providing machine-readable advisories using CSAF v2.0, vendors and providers of software and hardware can take proactive steps to enable automation and help to reduce the time required for enterprises to understand organizational impact and drive timely remediation.

## OASIS CSAF 2.0 Standard
CSAF is a standard for machine-readable security advisories developed by the [OASIS CSAF Technical Committee](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=csaf). CSAF enables individuals and organizations to successfully disclose and consume security advisories in machine-readable format. The standard also specifies the distribution and discovery of CSAF documents. The CSAF Security Advisory files found in this repository were designed following the CSAF v2.0 standard published by [OASIS Open](https://docs.oasis-open.org/csaf/csaf/v2.0/os/csaf-v2.0-os.html).

## Process
If an issue is reported, the OPC UA Security WG assesses it using tools such as the [Common Vulnerability Scoring System (CVSS)](https://www.first.org/cvss/). If the  OPC UA Security WG determines that the issue is a reportable vulnerability then it will assign a [GCVE identifier](https://gcve.eu/about/). Vendors are encouraged to use the GCVE identifier when they publish updates to their products so users can associate a product patch with a vulnerability reported by the OPC Foundation. 

The OPC UA Security WG then determines the best course of action. A notice is sent out to a SDK vendor mailing list that an issue has been reported that may require action on their part. SDK vendors receive advance notice because many OPC products are built with SDKs and addressing a vulnerability requires that the SDKs be updated first. Any OPC Foundation corporate member that wishes to be informed before vulnerabilities are made public should send a request to join the [UA Security WG](https://opcfoundation.org/about/working-groups/view/1). 

After review, the OPC UA Security WG will set a time line for making the vulnerability public. The time line will depend on the severity of the vulnerability and the time needed by SDK vendors to produce a patch for their products. When a vulnerability is made pubic it will appear on this page with details on where to find updated software. Any member of the public who wishes to receive notifications when new Security Advisories should watch this repository.

When a vulnerability is made public, the OPC Foundation will post a [CSAF compliant](https://www.oasis-open.org/standard/common-security-advisory-framework-version-2-0/) document to this repository. The document will have a signature provided by the OPC Foundation using public keys which are published [here](https://github.com/OPCFoundation/SecurityAdvisories/keys).

