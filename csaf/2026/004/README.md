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

- OPC UA Specification Part 4 - Services

## Vulnerabilities
### GCVE-105-2026-004
If the keys for any encrypted channel (OPC UA and non-OPC UA) are compromised, user passwords transmitted within the channel can be recovered.  

### Disposition: Informational
TThis item is published for the record as an informational advisory. No CVSS score and no vulnerability severity are assigned. The issue was reported by security researchers, however, the working group concluded that no normative change to the specification was needed. The specification already recommends that applications never set the SecurityPolicy to None for UserIdentityTokens that include a secret, and the exposure described depends on the compromise of the keys that protect the channel, a condition that applies to any protocol which carries a password inside an encrypted channel.  

[CWE-319](https://cwe.mitre.org/data/definitions/319.html): Cleartext Transmission of Sensitive Information  

### Threats
- [**Impact**] An attacker can decrypt packets and recover user passwords if secure channel keys are compromised.
- [**Precondition**] This is a hypothetical problem that applies to all encrypted communication that use simple password authentication (this includes almost all HTTPS applications).

### Remediations
**Mitigation**  
OPC UA Part 4 - Services §7.40.2.1: "It is recommended that applications never set the SecurityPolicy to None for UserIdentityTokens that include a secret because these secrets could be used by an attacker to gain access to the system." Encrypting the user token with its own SecurityPolicy means the password is not exposed if the keys protecting the SecureChannel are compromised.  
  

### Acknowledgments
- Vincent Diemunsch, ANSSI & Inria, France
- Lucca Hirschi, Inria, France
- Steve Kremer, Inria, France

For discovering the issue using the ProVerif protocol analyzer, see eprint https://eprint.iacr.org/2025/148.

##  References

[Advisory Source](https://github.com/OPCFoundation/SecurityAdvisories/tree/latest/csaf/2026/004)  
[Mantis Issue](https://mantis.opcfoundation.org/view.php?id=9432)  
[A Comprehensive Formal Security Analysis of OPC UA](https://eprint.iacr.org/2025/148)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
