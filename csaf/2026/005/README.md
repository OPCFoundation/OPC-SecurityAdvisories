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

- OPC UA Specification Part 4 - Services <1.03

## Vulnerabilities
### GCVE-105-2026-005
Servers implementing version 1.02 or earlier may be used as a signature oracle because the signature calculation is not restricted to the leaf certificate passed to CreateSession.  

[CWE-347](https://cwe.mitre.org/data/definitions/347.html): Improper Verification of Cryptographic Signature  

### Threats
- [**Impact**] An attacker could use a legacy server as a signature oracle to obtain a signature on data of its choosing and use it to impersonate that server to other applications that trust it.
- [**Precondition**] The attacker must be able to call CreateSession on a server that implements version 1.02 or earlier of the specification and that does not restrict the signature calculation to the leaf certificate. Other applications must trust the certificate of that server.

### CVSS Score
**Base Score:** <span style='color:red'>7.4 (HIGH)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:N/E:P/RL:O/RC:C)  

### Remediations
**Vendor Fix** ([link](https://reference.opcfoundation.org/Core/Part4/v105/docs/5.7.2.2))  
OPC UA Part 4 - Services 1.03 and later require that the signature calculation be done only with the leaf certificate if the clientCertificate contains a chain. A server that meets this requirement cannot be used to sign attacker supplied data.  
  
**Vendor Fix** ([link](https://reference.opcfoundation.org/Core/Part4/v105/docs/5.7.2.2))  
OPC UA Part 4 - Services 1.05.07 §5.7.2.2: The clientCertificate shall be validated according to the rules in §6.1.3 even if the server chooses to allow connections from untrusted clients. This makes the rejection of malformed input explicit.  
  
**Mitigation**  
Servers that implement version 1.02 or earlier should be contained. Do not include the certificate of such a server in the trust lists of other applications, so a signature obtained from it cannot be used against them. Disable the deprecated SecurityPolicies that use RSA PKCS#1 v1.5 and SHA-1, which are themselves vulnerable to oracle attacks, and restrict network access to legacy servers.  
  

### Acknowledgments
- Vincent Diemunsch, ANSSI & Inria, France
- Lucca Hirschi, Inria, France
- Steve Kremer, Inria, France

For discovering the issue using the ProVerif protocol analyzer, see eprint https://eprint.iacr.org/2025/148.

##  References

[Advisory Source](https://github.com/OPCFoundation/SecurityAdvisories/tree/latest/csaf/2026/005)  
[Mantis Issue](https://mantis.opcfoundation.org/view.php?id=9594)  
[A Comprehensive Formal Security Analysis of OPC UA](https://eprint.iacr.org/2025/148)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
