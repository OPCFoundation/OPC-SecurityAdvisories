# Informational Advisory for the OPC UA Specification

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

- OPC UA Specification Part 2 - Security

## Vulnerabilities
### GCVE-105-2026-001
User context may not propagate to in-flight requests when session credentials change.  

### Disposition: Informational
This item is published for the record as an informational advisory. No CVSS score and no vulnerability severity are assigned. The issue was reported by security researchers, however, the working group concluded that fix cannot be implemented as a general normative requirement because the correct behaviour depends on the Server and on the specific operation and the requirements for different operations can be mutually exclusive. The specification has been updated to add non-normative design guidance reproduced below.  

[CWE-270](https://cwe.mitre.org/data/definitions/270.html): Privilege Context Switching Error  

### Threats
- [**Impact**] Access to data and operations that should be restricted to the new user context.

### Remediations
**Mitigation**  
OPC UA Part 2 - Security 6.20 (non-normative design guidance): Developers should consider the effect of user context changes. In some cases, a change from low privilege user to a high privilege user could allow a destructive action initiated by the low privilege user to execute under the high privilege user's context. In other cases, the data accessible to a high privilege user could be returned after the low privilege user has taken over. Developers need to consider the risk to the system to determine the best course of action for each operation. Servers may choose to implement a minimum privilege check. i.e. a request that was sent under one user context but processed under another user context will only allow the operation if it is allowed by both user contexts.  
  

### Acknowledgments
- Vincent Diemunsch, ANSSI & Inria, France
- Lucca Hirschi, Inria, France
- Steve Kremer, Inria, France

For discovering the issue using the ProVerif protocol analyzer, see eprint https://eprint.iacr.org/2025/148.

##  References

[Advisory Source](https://github.com/OPCFoundation/SecurityAdvisories/tree/latest/csaf/2026/001)  
[Mantis Issue](https://mantis.opcfoundation.org/view.php?id=9351)  
[A Comprehensive Formal Security Analysis of OPC UA](https://eprint.iacr.org/2025/148)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
