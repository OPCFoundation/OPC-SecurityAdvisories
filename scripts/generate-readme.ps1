Get-ChildItem -Filter *.json | ForEach-Object {
    $jsonFile = $_.Name
    Write-Host $jsonFile
    $outFile = "README.md"
    Write-Host $outFile

    $json = Get-Content $jsonFile -Raw | ConvertFrom-Json 

    if (Test-Path $outFile) {
        Remove-Item $outFile
    }

    $line = "# " + $json.document.title
    Add-Content -Path $outFile -Value $line

    $line = ""
    Add-Content -Path $outFile -Value $line


    if ($json.document.tracking) {
        Add-Content -Path $outFile -Value "|||"
        Add-Content -Path $outFile -Value "|---|---|"

        if ($json.document.tracking.current_release_date) {
            $line = "|**Publication Date**|" + [datetimeoffset]::Parse($json.document.tracking.current_release_date).UtcDateTime.ToString("yyyy-MM-dd") + "|"
            Add-Content -Path $outFile -Value $line
        }
        if ($json.document.tracking.version) {
            $line = "|**Version**|" + $json.document.tracking.version + "|"
            Add-Content -Path $outFile -Value $line
        }
        if ($json.document.tracking.status) {
            $line = "|**Status**|" + $json.document.tracking.status + "|"
            Add-Content -Path $outFile -Value $line
        }

        if ($json.document.distribution) {    
            if ($json.document.distribution.tlp -and $json.document.distribution.tlp.label) {
                $url = "https://www.first.org/tlp/";
                if ($json.document.distribution.tlp.url){
                    $url = $json.document.distribution.tlp.url
                }
                $line = "|**Distribution**|[" + $json.document.distribution.tlp.label + "](" + $url + ")" + "|"
                Add-Content -Path $outFile -Value $line
            }
        }
    }

    if ($json.document.publisher) {
        if ($json.document.publisher.name) {
            $line = "|**Publisher**|" + $json.document.publisher.name + "|"
            Add-Content -Path $outFile -Value $line
        }
        if ($json.document.publisher.category) {
            $line = "|**Publisher Type**|" + $json.document.publisher.category + "|"
            Add-Content -Path $outFile -Value $line
        }
        if ($json.document.publisher.namespace) {
            $line = "|**Namespace**|[" + $json.document.publisher.namespace + "](" + $json.document.publisher.namespace + ")" + "|"
            Add-Content -Path $outFile -Value $line
        }
    }

    if ($json.product_tree.branches) {    
        Add-Content -Path $outFile -Value ""
        Add-Content -Path $outFile -Value "## Affected Products"
        Add-Content -Path $outFile -Value ""
        foreach ($branch in $json.product_tree.branches) {
            if ($branch.product) {    
                $line = "- " + $branch.product.name
                Add-Content -Path $outFile -Value $line
            }
        }
    }
    
    if ($json.vulnerabilities) {    
        Add-Content -Path $outFile -Value ""
        Add-Content -Path $outFile -Value "## Vulnerabilities"
        foreach ($vulnerability in $json.vulnerabilities) {
            $primaryId = $null
            if ($vulnerability.cve) {
                $primaryId = $vulnerability.cve
            }
            elseif ($vulnerability.ids) {
                $primaryId = $vulnerability.ids[0].text
            }

            if ($primaryId) {
                $line = "### " + $primaryId
                Add-Content -Path $outFile -Value $line
            }

            if ($vulnerability.ids) {
                $secondaryIds = @()
                foreach ($id in $vulnerability.ids) {
                    if ($id.text -and $id.text -ne $primaryId) {
                        if ($id.system_name -eq "CVE") {
                            $secondaryIds += "[" + $id.text + "](https://www.cve.org/CVERecord?id=" + $id.text + ")"
                        }
                        else {
                            $secondaryIds += $id.text
                        }
                    }
                }
                if ($secondaryIds.Count -gt 0) {
                    $line = "Also tracked as " + ($secondaryIds -join ", ") + "  "
                    Add-Content -Path $outFile -Value $line
                    Add-Content -Path $outFile -Value ""
                }
            }

            if ($vulnerability.title) {
                $line = $vulnerability.title + "  "
                Add-Content -Path $outFile -Value $line
            }

            if ($vulnerability.notes) {
                $summary = $vulnerability.notes | Where-Object { $_.category -eq "summary" } | Select-Object -First 1
                if ($summary) {
                    Add-Content -Path $outFile -Value ""
                    Add-Content -Path $outFile -Value "### Summary"
                    $line = $summary.text + "  "
                    Add-Content -Path $outFile -Value $line
                }
                $description = $vulnerability.notes | Where-Object { $_.category -eq "description" } | Select-Object -First 1
                if ($description) {
                    Add-Content -Path $outFile -Value ""
                    Add-Content -Path $outFile -Value "### Note"
                    $line = $description.text + "  "
                    Add-Content -Path $outFile -Value $line
                }
                $others = $vulnerability.notes | Where-Object { $_.category -notin @("summary", "description") }
                foreach ($other in $others) {
                    Add-Content -Path $outFile -Value ""
                    if ($other.title) {
                        Add-Content -Path $outFile -Value ("### " + $other.title)
                    }
                    else {
                        Add-Content -Path $outFile -Value "### Note"
                    }
                    $line = $other.text + "  "
                    Add-Content -Path $outFile -Value $line
                }
            }

            if ($vulnerability.cwe) {    
                Add-Content -Path $outFile -Value ""
                $line = "[" + $vulnerability.cwe.id + "](https://cwe.mitre.org/data/definitions/" + $vulnerability.cwe.id.Replace("CWE-", "") + ".html): " + $vulnerability.cwe.name + "  " 
                Add-Content -Path $outFile -Value $line
            }

            if ($vulnerability.threats) {    
                Add-Content -Path $outFile -Value ""
                Add-Content -Path $outFile -Value "### Threats"
                foreach ($threat in $vulnerability.threats) {
                    $line = "- "

                    if ($threat.category -eq "impact") {
                        $line += "[**Impact**] "
                    }  

                    if ($threat.category -eq "target_set") {
                        $line += "[**Precondition**] "
                    }  

                    $line += $threat.details
                    Add-Content -Path $outFile -Value $line
                }
            }

            if ($vulnerability.scores) {    
                Add-Content -Path $outFile -Value ""
                Add-Content -Path $outFile -Value "### CVSS Score"
                foreach ($score in $vulnerability.scores) {
                    if ($score.cvss_v3){
                    $color = "orange";
                    if ($score.cvss_v3.baseSeverity -eq "HIGH") { $color = "red"; }
                        $line = "**Base Score:** <span style='color:" + $color + "'>" + $score.cvss_v3.baseScore + " (" + $score.cvss_v3.baseSeverity + ")</span>  "
                        Add-Content -Path $outFile -Value $line
                        $line = "**Vector:**: [" + $score.cvss_v3.vectorString + "](https://www.first.org/cvss/calculator/" + $score.cvss_v3.version.Replace(".", "-") + "#" +  $score.cvss_v3.vectorString + ")  "
                        Add-Content -Path $outFile -Value $line
                    }
                }
            }

            if ($vulnerability.remediations) {    
                Add-Content -Path $outFile -Value ""
                Add-Content -Path $outFile -Value "### Remediations"
                $fixes = $vulnerability.remediations | Where-Object { $_.category -eq "vendor_fix" }
                $first = $true
                foreach ($fix in $fixes){
                    if (-not $first) { Add-Content -Path $outFile -Value "  " }
                    $line = "**Vendor Fix**" + " ([link](" + $fix.url + "))  "
                    Add-Content -Path $outFile -Value $line
                    $line = $fix.details + "  "
                    Add-Content -Path $outFile -Value $line
                    $first = $false
                }
                $mitigation = $vulnerability.remediations | Where-Object { $_.category -eq "mitigation" } | Select-Object -First 1
                if ($mitigation){
                    if (-not $first) { Add-Content -Path $outFile -Value "  " }
                    Add-Content -Path $outFile -Value  "**Mitigation**  "
                    $line = $mitigation.details + "  "
                    Add-Content -Path $outFile -Value $line 
                    Add-Content -Path $outFile -Value "  " 
                    $first = $false
                }
                $workaround = $vulnerability.remediations | Where-Object { $_.category -eq "workaround" } | Select-Object -First 1
                if ($workaround){
                    if (-not $first) { Add-Content -Path $outFile -Value "  " }
                    Add-Content -Path $outFile -Value  "**Workaround**  "
                    $line = $workaround.details + "  "
                    Add-Content -Path $outFile -Value $line 
                    Add-Content -Path $outFile -Value "  " 
                }
            }
            if ($vulnerability.acknowledgments) {
                Add-Content -Path $outFile -Value ""
                Add-Content -Path $outFile -Value "### Acknowledgments"
                foreach ($acknowledgment in $vulnerability.acknowledgments) {
                    $line = "- " + ($acknowledgment.names -join ", ")
                    if ($acknowledgment.organization) {
                        $line += ", " + $acknowledgment.organization
                    }
                    Add-Content -Path $outFile -Value $line
                }
                $summaries = $vulnerability.acknowledgments | Where-Object { $_.summary } | Select-Object -First 1
                if ($summaries) {
                    Add-Content -Path $outFile -Value ""
                    $line = $summaries.summary
                    Add-Content -Path $outFile -Value $line
                }
            }
        }
    }


    if ($json.document.references) {    
        Add-Content -Path $outFile -Value ""
        Add-Content -Path $outFile -Value "##  References"
        Add-Content -Path $outFile -Value ""
        foreach ($reference in $json.document.references) {
            $line = "[" + $reference.summary + "](" + $reference.url + ")" + "  "
            Add-Content -Path $outFile -Value $line
        }
    }

    if ($json.document.notes) {    
        $disclaimer = $json.document.notes | Where-Object { $_.category -eq "legal_disclaimer" } | Select-Object -First 1
        if ($disclaimer) {
            Add-Content -Path $outFile -Value ""
            Add-Content -Path $outFile -Value "##  Legal Disclaimer"
            Add-Content -Path $outFile -Value ""
            Add-Content -Path $outFile -Value $disclaimer.text
        }
    }
}