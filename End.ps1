$body = @"
{
    `"serviceAccountId`" : `"`",
    `"secret`" : `"`"
}
"@

$response = Invoke-RestMethod 'https://server.local/api/v1/service_account/session' -Method 'POST' -Body $body

$accessToken = $response.token -split ':'[1]
$formattedToken = $accessToken -join ''
$formattedToken

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $formattedToken")

$End_SnapShot = Invoke-RestMethod 'https://server.local/api/internal/managed_volume/ManagedVolume<volumeKey>/end_snapshot' -Method 'POST' -headers $headers

$End_SnapShot
Write-Host "Snapshot Ended."

$Delete_Auth = Invoke-RestMethod 'https://server.local/api/v1/session/me' -Method 'DELETE' -headers $Headers
