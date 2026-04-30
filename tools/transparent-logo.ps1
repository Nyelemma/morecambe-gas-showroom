param(
  [Parameter(Mandatory=$true)] [string]$Source,
  [Parameter(Mandatory=$true)] [string]$Destination,
  [int]$Threshold = 240
)

Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Image]::FromFile($Source)
$bmp = New-Object System.Drawing.Bitmap $src.Width, $src.Height, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::FromArgb(0,0,0,0))
$g.DrawImage($src, 0, 0, $src.Width, $src.Height)
$g.Dispose()
$src.Dispose()

# Lock bits for fast pixel access
$rect = New-Object System.Drawing.Rectangle 0,0,$bmp.Width,$bmp.Height
$data = $bmp.LockBits($rect,[System.Drawing.Imaging.ImageLockMode]::ReadWrite,$bmp.PixelFormat)
$bytesCount = [Math]::Abs($data.Stride) * $bmp.Height
$buffer = New-Object byte[] $bytesCount
[System.Runtime.InteropServices.Marshal]::Copy($data.Scan0,$buffer,0,$bytesCount)

for ($i = 0; $i -lt $bytesCount; $i += 4) {
  $b = $buffer[$i]
  $gr = $buffer[$i+1]
  $r = $buffer[$i+2]
  if ($r -ge $Threshold -and $gr -ge $Threshold -and $b -ge $Threshold) {
    $buffer[$i+3] = 0
  }
}

[System.Runtime.InteropServices.Marshal]::Copy($buffer,0,$data.Scan0,$bytesCount)
$bmp.UnlockBits($data)
$bmp.Save($Destination,[System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Get-Item $Destination | Select-Object Name, Length
