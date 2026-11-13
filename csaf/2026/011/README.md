# Security Update for the OPC UA .NET Standard Stack

|||
|---|---|
|**Publication Date**|2026-11-13|
|**Version**|1.0.0|
|**Status**|final|
|**Distribution**|[WHITE](https://www.first.org/tlp/)|
|**Publisher**|OPC Foundation|
|**Publisher Type**|vendor|
|**Namespace**|[https://opcfoundation.org/security/csaf](https://opcfoundation.org/security/csaf)|

## Affected Products

- OPCFoundation/UA-.NETStandard 2.0.1

## Vulnerabilities
### GCVE-105-2026-011
A sessionless Call can read a Machinery result file handle that belongs to another session.  

### Summary
The ownership check for the transient result file handles of the optional Machinery ResultTransfer implementation grants access when either the stored owner session identifier or the session identifier of the caller is null. A sessionless Call carries no session identifier, so the check passes for a handle that was opened by a different principal and the file content is returned. The transient result file handles are documented as bound to the session that opened them.  

### Affected component
The weakness is in the result transfer manager of the optional Opc.Ua.Machinery.Server component (src/Opc.Ua.Machinery.Server/Results/MachineryResultTransferManager.cs). It was reported against release 2.0.1 of the OPC UA .NET Standard Stack. Deployments that do not use the Machinery ResultTransfer implementation are not affected.  

[CWE-863](https://cwe.mitre.org/data/definitions/863.html): Incorrect Authorization  

### Threats
- [**Impact**] An authenticated client can read the machinery result data of another principal. A sessionless Call to the Read method of a transient result file succeeds with a handle owned by a different session and returns that owner's result bytes, although the same call issued from the attacker's own session is denied with BadUserAccessDenied. The result is an unauthorized disclosure of application level machinery result data.
- [**Precondition**] Affects deployments that enable the optional Machinery ResultTransfer implementation together with sessionless service invocation, and in which the transient result subtree is reachable by Browse and Call. The attacker needs network access and a credential that is accepted for a sessionless call.

### CVSS Score
**Base Score:** <span style='color:orange'>6.5 (MEDIUM)</span>  
**Vector:**: [CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:N](https://www.first.org/cvss/calculator/3-1#CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:N)  

### Remediations
**Vendor Fix** ([link](https://github.com/OPCFoundation/UA-.NETStandard/releases/tag/2.0.2))  
Update to OPC UA .NET Standard Stack 2.0.2 or later.  
  
**Mitigation**  
If the update cannot be applied immediately, disable sessionless service invocation on endpoints that expose the Machinery ResultTransfer implementation, because a sessionless Call is the path on which the ownership check fails open; a Call made from a session of another principal is still denied. Where sessionless invocation is required, restrict Browse and Call access to the transient result subtree with role permissions, so that the result nodes of one principal are not reachable by another.  
  

### Acknowledgments
- Ievgen Bondarenko

For reporting the issue in a private disclosure to the OPC Foundation security team.

##  References

[Advisory Source](https://opcfoundation.org/security/csaf/2026/011/gcve-105-2026-011.json)  
[OPC UA .NET Standard Stack](https://github.com/OPCFoundation/UA-.NETStandard)  

##  Legal Disclaimer

The information provided in this disclosure is provided 'as is' without warranty of any kind. OPC Foundation disclaims all warranties, either express or implied, including the warranties of merchantability and fitness for a particular purpose. In no event shall OPC Foundation or its suppliers be liable for any damages whatsoever including direct, indirect, incidental, consequential, loss of business profits or special damages, even if OPC Foundation or its suppliers have been advised of the possibility of such damages. Some states do not allow the exclusion or limitation of liability for consequential or incidental damages so the foregoing limitation may not apply
