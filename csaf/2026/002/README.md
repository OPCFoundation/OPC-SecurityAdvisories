# Security Update for the OPC UA Specification

|||
|---|---|
|**Publication Date**|2026-08-12|
|**Version**|1.0.0|
|**Status**|release|
|**Distribution**|[WHITE](https://www.first.org/tlp/)|
|**Publisher**|OPC Foundation|
|**Publisher Type**|vendor|
|**Namespace**|[https://opcfoundation.org/security/csaf](https://opcfoundation.org/security/csaf)|

## Affected Products

- OPC UA Specification Part 6 - Mappings <1.05.06

## Vulnerabilities
### GCVE-105-2026-002
If the private key of a client is compromised, an attacker can exploit the missing receiver identification in OpenSecureChannel to spoof another client identity.  

[CWE-290](https://cwe.mitre.org/data/definitions/290.html): Authentication Bypass by Spoofing  

### Threats
- [**Impact**] The server incorrectly attributes a legitimate client's session to a different client identity for the lifetime of the affected SecureChannel, resulting in incorrect security logging and potentially incorrect client-based access control decisions.
- [**Precondition**] The attacker must have access to the private key of a client with access to the target server and must be able to intercept and relay the OpenSecureChannel exchange between another client and the target server.

### CVSS Score
**Base Score:** <span style='color:orange'>3.7 (LOW)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:N/I:L/A:N/E:P/RL:O/RC:C](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:N/I:L/A:N/E:P/RL:O/RC:C)  

### Remediations
**Vendor Fix** ([link](https://reference.opcfoundation.org/Core/Part6/v105/docs/6.7.2.3))  
OPC UA Part 6 - Mappings 1.05.06 §6.7.2.3: Requires rejection of the message if the ReceiverCertificateThumbprint is not valid.  

### Acknowledgments
- Vincent Diemunsch, ANSSI & Inria, France
- Lucca Hirschi, Inria, France
- Steve Kremer, Inria, France

For discovering the issue using the ProVerif protocol analyzer, see eprint https://eprint.iacr.org/2025/148.

##  References

[Advisory Source](https://github.com/OPCFoundation/SecurityAdvisories/tree/latest/csaf/2026/002)  
[Mantis Issue](https://mantis.opcfoundation.org/view.php?id=9350)  
[A Comprehensive Formal Security Analysis of OPC UA](https://eprint.iacr.org/2025/148)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
