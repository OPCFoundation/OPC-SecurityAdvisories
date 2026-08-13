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

- OPC UA Specification Part 6 - Mappings <1.05.07

## Vulnerabilities
### GCVE-105-2026-008
If the private key of a server is compromised, a Session can be hijacked by an attacker that can intercept network traffic.  

### CVSS Scope Assessment (vendor / reporter disagreement)
The CVSS v3.1 score published here uses Scope:Unchanged (S:U): 5.9 (MEDIUM). The reporters assess Scope:Changed (S:C): 7.7 (HIGH). The disagreement concerns only the Scope metric. Reporter position: OPC UA secure-channel security (UA-SC/PKI) and session-and-user authentication are two distinct security authorities, each with its own certificate exchange and potentially implemented as separate components or processes; the attack chains a channel-layer key compromise into a session/user-identity compromise, crossing from one authority to the other, which the reporters consider a scope change. OPC Foundation position: the impacted resources (the Server's nodes, address space, and operations) are governed by exactly one security authority which evaluates the client certificate, the endpoint used, the user token, and other configured criteria as inputs to a single access-control decision applied on every operation (OPC 10000-18 4.4). The SecureChannel and PKI authenticate endpoints; they do not define or enforce which operations a subject may perform on Server resources. A separable implementation is not a separate security authority; CVSS Scope concerns authorization domains, not library, process, or code boundaries. The attack is a horizontal move to impersonate another user to the same Server and reach that Server's resources, which is the standard Scope:Unchanged pattern.  

[CWE-384](https://cwe.mitre.org/data/definitions/384.html): Session Fixation  

### Threats
- [**Impact**] An attacker can take over a SecureChannel by exploiting the compromised server key during channel renewal. The attacker can then send requests using the legitimate client's session authentication token, which the server accepts as coming from the legitimate client.
- [**Precondition**] The attacker must have access to the private key of the server and must have normal (unprivileged) access as a legitimate client connected to that server.

### CVSS Score
**Base Score:** <span style='color:orange'>5.9 (MEDIUM)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:H/PR:H/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C)  

### Remediations
**Vendor Fix** ([link](https://reference.opcfoundation.org/Core/Part6/v105/docs/6.8.1))  
OPC UA Part 6 - Mappings 1.05.07 §6.8.1: When a SecureChannel is renewed the shared secret used to derive the current set of keys is XORed with the new shared secret negotiated during renewal to create the value used to derive the new keys.  
  
**Mitigation**  
Following the OPC UA guidelines on managing private keys would reduce the likelihood that the prerequisites can be met. Specifically, protect Server private keys in hardware or a secure element where feasible and enforce strict decommissioning of retired keys; rotate private keys regularly; and segment the network so that the traffic interception this attack requires is not available from general network positions.  
  

### Acknowledgments
- Vincent Diemunsch, ANSSI & Inria, France
- Lucca Hirschi, Inria, France
- Steve Kremer, Inria, France

For discovering the issue using the ProVerif protocol analyzer, see eprint https://eprint.iacr.org/2025/148.

##  References

[Advisory Source](https://github.com/OPCFoundation/SecurityAdvisories/tree/latest/csaf/2026/008)  
[Mantis Issue](https://mantis.opcfoundation.org/view.php?id=10056)  
[A Comprehensive Formal Security Analysis of OPC UA](https://eprint.iacr.org/2025/148)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
