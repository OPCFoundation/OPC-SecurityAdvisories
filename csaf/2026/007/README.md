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

- OPC UA Specification Part 4 - Services <1.05.07

## Vulnerabilities
### GCVE-105-2026-007
If the private key of a client is compromised, a Session can be hijacked with a ActivateSession when using Sign mode.  

[CWE-384](https://cwe.mitre.org/data/definitions/384.html): Session Fixation  

### Threats
- [**Impact**] An attacker could take control of a Session by intercepting and replaying an ActivateSession request with a compromised private key.
- [**Precondition**] The attacker has access to the private key of a client with access to the target server and the SecureChannel is in sign mode.

### CVSS Score
**Base Score:** <span style='color:orange'>5.9 (MEDIUM)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C)  

### Remediations
**Vendor Fix** ([link](https://reference.opcfoundation.org/Core/Part4/v105/docs/6.1.8))  
OPC UA Part 4 - Services 1.05.07 §6.1.8: Defines new calculations for user token signatures which prevent re-use of tokens.  
  
**Mitigation**  
Following the OPC UA guidelines on managing private keys would reduce the likelihood that the prerequisites can be met. Specifically, protect Client private keys in hardware or a secure element where feasible and enforce strict decommissioning of retired keys; rotate private keys regularly; prefer SignAndEncrypt over Sign on exposed endpoints, which prevents the ActivateSession request from being observed on the network; and segment the network so that the traffic interception this attack requires is not available from general network positions.  
  

### Acknowledgments
- Vincent Diemunsch, ANSSI & Inria, France
- Lucca Hirschi, Inria, France
- Steve Kremer, Inria, France

For discovering the issue using the ProVerif protocol analyzer, see eprint https://eprint.iacr.org/2025/148.

##  References

[Advisory Source](https://github.com/OPCFoundation/SecurityAdvisories/tree/latest/csaf/2026/007)  
[Mantis Issue](https://mantis.opcfoundation.org/view.php?id=10055)  
[A Comprehensive Formal Security Analysis of OPC UA](https://eprint.iacr.org/2025/148)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
