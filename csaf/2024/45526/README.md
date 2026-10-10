# Security Advisory for CVE-2024-45526

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

- OPC UA .NET Standard Stack <1.5.374.118

## Vulnerabilities
### CVE-2024-45526
Also tracked as GCVE-105-2024-45526  

Performance degradation attack in OPC UA .NET Standard Stack  

[CWE-770](https://cwe.mitre.org/data/definitions/770.html): Allocation of Resources Without Limits or Throttling  

### Threats
- [**Impact**] An unauthorized attacker can trigger a gradual degradation in performance.

### CVSS Score
**Base Score:** <span style='color:orange'>5.3 (MEDIUM)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:L](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:L)  

### Remediations
**Vendor Fix** ([link](https://github.com/OPCFoundation/UA-.NETStandard/releases/tag/1.5.374.118))  
Update to OPC UA .NET Standard Stack version 1.5.374.118 or later.  
  
**Workaround**  
Disable saving rejected certificates after authentication failure.  
  

### Acknowledgments
- Florian Kohnhäuser, ABB

Reported the issue.

##  References

[Advisory Source](https://opcfoundation.org/security/csaf/2024/45526/gcve-105-2024-45526.json)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
