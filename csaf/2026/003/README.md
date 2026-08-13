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
- OPC UA Specification Part 6 - Mappings <1.05.07

## Vulnerabilities
### GCVE-105-2026-003
If private keys of a client and server are compromised, an attacker may re-use a certificate user identity sent over a different secure channel.  

[CWE-294](https://cwe.mitre.org/data/definitions/294.html): Authentication Bypass by Capture-replay  

### Threats
- [**Impact**] An attacker can re-use a certificate user identity sent over a different secure channel and bypass authentication and authorization mechanisms for a server.
- [**Precondition**] The attacker has access to the private key of a client, the private key of the server, and must be able to intercept network traffic sent by that client.

### CVSS Score
**Base Score:** <span style='color:orange'>5.9 (MEDIUM)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C)  

### Remediations
**Vendor Fix** ([link](https://reference.opcfoundation.org/Core/Part4/v105/docs/6.1.8))  
OPC UA Part 4 - Services 1.05.07 §6.1.8: Defines new calculations for user token signatures which prevent re-use of tokens.  
  
**Vendor Fix** ([link](https://reference.opcfoundation.org/Core/Part6/v105/docs/6.7.5))  
OPC UA Part 6 - Mappings 1.05.07 §6.7.5: Defines a unique identifier associated with a secure channel.  
  
**Mitigation**  
Following the OPC UA guidelines on managing private keys would reduce the likelyhood that the prerequisites can be met. Specifically, protect Client and Server private keys in hardware or a secure element where feasible and enforce strict decommissioning of retired keys; rotate private keys regularily; prefer SignAndEncrypt over Sign on exposed endpoints; and segment the network so that the traffic interception this attack requires is not available from general network positions.  
  

### Acknowledgments
- Vincent Diemunsch, ANSSI & Inria, France
- Lucca Hirschi, Inria, France
- Steve Kremer, Inria, France

For discovering the issue using the ProVerif protocol analyzer, see eprint https://eprint.iacr.org/2025/148.

##  References

[Advisory Source](https://github.com/OPCFoundation/SecurityAdvisories/tree/latest/csaf/2026/003)  
[Mantis Issue](https://mantis.opcfoundation.org/view.php?id=10055)  
[A Comprehensive Formal Security Analysis of OPC UA](https://eprint.iacr.org/2025/148)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
