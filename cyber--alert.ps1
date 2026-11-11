
$webhookUrl = "https://YOUR-N8N-DOMAIN/webhook-test/YOUR-WEBHOOK-ID"
$webhookSecret = "YOUR_SECRET"

$payload = @{
    source="CrowdStrike"
    severity="high"
    hostname="LAB-WIN11"
    detection="Suspicious PowerShell Activity"
    user="jono.lab"
    src_ip="198.51.100.25"
} | ConvertTo-Json -Compress

$temp = "$env:TEMP\n8n.json"

$payload | Set-Content $temp

curl.exe -k `
-X POST `
"$webhookUrl" `
-H "Content-Type: application/json" `
-H "X-HomeLab-Key: $webhookSecret" `
--data-binary "@$temp"

Remove-Item $temp
