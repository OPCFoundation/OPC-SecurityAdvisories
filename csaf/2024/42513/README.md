# Security Advisory for CVE-2024-42513

|||
|---|---|
|**Publication Date**|2026-10-10|
|**Version**|1.0.1|
|**Status**|final|
|**Distribution**|[WHITE](https://www.first.org/tlp/)|
|**Publisher**|OPC Foundation|
|**Publisher Type**|vendor|
|**Namespace**|[https://opcfoundation.org/security/csaf](https://opcfoundation.org/security/csaf)|

## Affected Products

- OPC UA .NET Standard Stack <1.5.374.158

## Vulnerabilities
### CVE-2024-42513
Also tracked as GCVE-105-2024-42513  

Authentication bypass via HTTPS in OPC UA .NET Standard Stack  

[CWE-305](https://cwe.mitre.org/data/definitions/305.html): Authentication Bypass by Primary Weakness  

### Threats
- [**Impact**] An unauthorized attacker can bypass application authentication using HTTPS endpoints with security policies other than 'None'.

### CVSS Score
**Base Score:** <span style='color:orange'>6.5 (MEDIUM)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:L/A:N](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:L/A:N)  

### Remediations
**Vendor Fix** ([link](https://github.com/OPCFoundation/UA-.NETStandard/tree/1.5.374.158))  
Update to OPC UA .NET Standard Stack version 1.5.374.158 or later.  
  
**Workaround**  
Disable all HTTPS endpoints or configure them to use the 'None' security policy. Ensure HTTPS client certificates are used if application authentication is required.  
  

### Acknowledgments
- Tom Tervoort, Secura B.V.

Reported the issue.

##  References

[Advisory Source](https://opcfoundation.org/security/csaf/2024/42513/gcve-105-2024-42513.json)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
