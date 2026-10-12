# Security Update for the OPC UA .NET Standard Stack

|||
|---|---|
|**Publication Date**|2026-10-12|
|**Version**|1.0.0|
|**Status**|final|
|**Distribution**|[WHITE](https://www.first.org/tlp/)|
|**Publisher**|OPC Foundation|
|**Publisher Type**|vendor|
|**Namespace**|[https://opcfoundation.org/security/csaf](https://opcfoundation.org/security/csaf)|

## Affected Products

- OPCFoundation/UA-.NETStandard <=1.5.378.176
- OPCFoundation/UA-.NETStandard 2.0.174-preview+e73e71184d

## Vulnerabilities
### GCVE-105-2026-010
Uncontrolled resource consumption vulnerability  

### Summary
An unauthenticated attacker can exhaust server memory by opening multiple connections and sending malformed messages.  

[CWE-400](https://cwe.mitre.org/data/definitions/400.html): Uncontrolled Resource Consumption  

### Threats
- [**Impact**] Uncontrolled memory consumption leads to the server crashing or being terminated by the operating system, denying service to all legitimate clients.
- [**Precondition**] The attacker needs network access to a server endpoint and the ability to open a large number of concurrent connections. No authentication and no user interaction are required.

### CVSS Score
**Base Score:** <span style='color:red'>7.5 (HIGH)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H)  

### Remediations
**Vendor Fix** ([link](https://github.com/OPCFoundation/UA-.NETStandard/tree/1.5.378.182))  
Update to OPC UA .NET Standard Stack 1.5.378.182 or later.  
  
**Vendor Fix** ([link](https://github.com/OPCFoundation/UA-.NETStandard/releases/tag/2.0.0))  
Update to OPC UA .NET Standard Stack 2.0.0 or later.  
  
**Mitigation**  
Restrict network access to server endpoints to trusted networks so that an attacker cannot open large numbers of connections, and lower the configured limits on the number of concurrent channels and sessions so that the memory a single unauthenticated peer can pin is bounded.  
  

### Acknowledgments
- CVCN, Centro di Valutazione e Certificazione Nazionale, Italy

For reporting the issue in responsible disclosure CVCN-RD-49C7E879.

##  References

[Advisory Source](https://opcfoundation.org/security/csaf/2026/010/gcve-105-2026-010.json)  
[OPC UA .NET Standard Stack](https://github.com/OPCFoundation/UA-.NETStandard)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
