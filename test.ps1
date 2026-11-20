# whoami-discovery.ps1
Write-Output "=== User ==="
whoami

Write-Output "`n=== Groups ==="
whoami /groups

Write-Output "`n=== Privileges ==="
whoami /priv
