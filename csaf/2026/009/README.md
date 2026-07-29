# Security Update for the OPC UA LocalDiscoveryServer (LDS)

|||
|---|---|
|**Publication Date**|2026-06-30|
|**Version**|1.0.0|
|**Status**|draft|
|**Distribution**|[WHITE](https://www.first.org/tlp/)|
|**Publisher**|OPC Foundation|
|**Publisher Type**|vendor|
|**Namespace**|[https://opcfoundation.org/security/csaf](https://opcfoundation.org/security/csaf)|

## Affected Products

- OPCFoundation/UA-LDS-Installers <1.04.420

## Vulnerabilities
### GCVE-105-2026-009
An attacker can intercept a high privilege console window launched during installation of the LDS.  

[CWE-269](https://cwe.mitre.org/data/definitions/269.html): Improper Privilege Management  

### Threats
- [**Impact**] An attacker can grab a high privilege terminal during installation and run arbitrary commands.
- [**Precondition**] The attacker must be able to launch an installer with elevated privileges and have access to the keyboard and display while the installation is taking place.

### CVSS Score
**Base Score:** <span style='color:orange'>4.6 (MEDIUM)</span>  
**Vector:**: [CVSS:3.1/AV:L/AC:L/PR:L/UI:R/S:C/C:L/I:L/A:N](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:L/AC:L/PR:L/UI:R/S:C/C:L/I:L/A:N)  

### Remediations
**Vendor Fix** ([link](https://github.com/OPCFoundation/UA-LDS-Installers))  
Update to OPC UA LDS Installers 1.04.420 or later.  

### Acknowledgments
- Lukas Schumaker, Rockwell Automation

##  References

[Advisory Source](https://github.com/OPCFoundation/OPC-SecurityAdvisories/tree/latest/csaf/2026/009)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
