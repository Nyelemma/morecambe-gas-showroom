param(
  [string]$Repo = "c:\Users\mikey\OneDrive\Desktop\Websites\morecambe-gas-showroom"
)

Add-Type -AssemblyName System.Drawing

$pngPath = Join-Path $Repo "images\logo-mgs-flame-lockup.png"
$bmp = New-Object System.Drawing.Bitmap 760,220
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::FromArgb(0,0,0,0))

$blue = [System.Drawing.ColorTranslator]::FromHtml("#0B1F3B")
$red  = [System.Drawing.ColorTranslator]::FromHtml("#E30613")
$gold = [System.Drawing.ColorTranslator]::FromHtml("#F2B705")
$brushBlue = New-Object System.Drawing.SolidBrush($blue)
$brushRed  = New-Object System.Drawing.SolidBrush($red)
$brushGold = New-Object System.Drawing.SolidBrush($gold)

$left = New-Object System.Drawing.Drawing2D.GraphicsPath
$left.AddBezier((New-Object System.Drawing.PointF(108,30)),(New-Object System.Drawing.PointF(40,75)),(New-Object System.Drawing.PointF(28,130)),(New-Object System.Drawing.PointF(55,180)))
$left.AddBezier((New-Object System.Drawing.PointF(55,180)),(New-Object System.Drawing.PointF(74,198)),(New-Object System.Drawing.PointF(95,200)),(New-Object System.Drawing.PointF(108,200)))
$left.AddLine(108,200,108,30)
$g.FillPath($brushBlue,$left)

$right = New-Object System.Drawing.Drawing2D.GraphicsPath
$right.AddBezier((New-Object System.Drawing.PointF(108,30)),(New-Object System.Drawing.PointF(176,75)),(New-Object System.Drawing.PointF(188,130)),(New-Object System.Drawing.PointF(161,180)))
$right.AddBezier((New-Object System.Drawing.PointF(161,180)),(New-Object System.Drawing.PointF(142,198)),(New-Object System.Drawing.PointF(121,200)),(New-Object System.Drawing.PointF(108,200)))
$right.AddLine(108,200,108,30)
$g.FillPath($brushRed,$right)

$inner = New-Object System.Drawing.Drawing2D.GraphicsPath
$inner.AddBezier((New-Object System.Drawing.PointF(108,70)),(New-Object System.Drawing.PointF(86,96)),(New-Object System.Drawing.PointF(84,128)),(New-Object System.Drawing.PointF(96,150)))
$inner.AddBezier((New-Object System.Drawing.PointF(96,150)),(New-Object System.Drawing.PointF(102,162)),(New-Object System.Drawing.PointF(106,170)),(New-Object System.Drawing.PointF(108,176)))
$inner.AddLine(108,176,108,70)
$g.FillPath($brushGold,$inner)

$fontTop = New-Object System.Drawing.Font("Arial",56,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Pixel)
$fontBottom = New-Object System.Drawing.Font("Arial",42,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Pixel)
$textBrush = New-Object System.Drawing.SolidBrush($blue)
$g.DrawString("Morecambe Gas",$fontTop,$textBrush,200,40)

$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$rect = New-Object System.Drawing.RectangleF(220,118,400,60)
$g.DrawString("Services",$fontBottom,$textBrush,$rect,$sf)

$bmp.Save($pngPath,[System.Drawing.Imaging.ImageFormat]::Png)

$sf.Dispose(); $fontTop.Dispose(); $fontBottom.Dispose(); $textBrush.Dispose()
$left.Dispose(); $right.Dispose(); $inner.Dispose()
$brushBlue.Dispose(); $brushRed.Dispose(); $brushGold.Dispose()
$g.Dispose(); $bmp.Dispose()

# Square mark for favicons / OG icon
$icoPath = Join-Path $Repo "images\logo-mgs-flame.png"
$bmp2 = New-Object System.Drawing.Bitmap 256,256
$g2 = [System.Drawing.Graphics]::FromImage($bmp2)
$g2.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g2.Clear([System.Drawing.Color]::FromArgb(0,0,0,0))

$bb = New-Object System.Drawing.SolidBrush($blue)
$br = New-Object System.Drawing.SolidBrush($red)
$bg = New-Object System.Drawing.SolidBrush($gold)

$leftI = New-Object System.Drawing.Drawing2D.GraphicsPath
$leftI.AddBezier((New-Object System.Drawing.PointF(128,30)),(New-Object System.Drawing.PointF(40,80)),(New-Object System.Drawing.PointF(28,150)),(New-Object System.Drawing.PointF(60,210)))
$leftI.AddBezier((New-Object System.Drawing.PointF(60,210)),(New-Object System.Drawing.PointF(85,230)),(New-Object System.Drawing.PointF(112,232)),(New-Object System.Drawing.PointF(128,232)))
$leftI.AddLine(128,232,128,30)
$g2.FillPath($bb,$leftI)

$rightI = New-Object System.Drawing.Drawing2D.GraphicsPath
$rightI.AddBezier((New-Object System.Drawing.PointF(128,30)),(New-Object System.Drawing.PointF(216,80)),(New-Object System.Drawing.PointF(228,150)),(New-Object System.Drawing.PointF(196,210)))
$rightI.AddBezier((New-Object System.Drawing.PointF(196,210)),(New-Object System.Drawing.PointF(171,230)),(New-Object System.Drawing.PointF(144,232)),(New-Object System.Drawing.PointF(128,232)))
$rightI.AddLine(128,232,128,30)
$g2.FillPath($br,$rightI)

$innerI = New-Object System.Drawing.Drawing2D.GraphicsPath
$innerI.AddBezier((New-Object System.Drawing.PointF(128,90)),(New-Object System.Drawing.PointF(96,118)),(New-Object System.Drawing.PointF(94,160)),(New-Object System.Drawing.PointF(112,190)))
$innerI.AddBezier((New-Object System.Drawing.PointF(112,190)),(New-Object System.Drawing.PointF(120,202)),(New-Object System.Drawing.PointF(124,210)),(New-Object System.Drawing.PointF(128,216)))
$innerI.AddLine(128,216,128,90)
$g2.FillPath($bg,$innerI)

$bmp2.Save($icoPath,[System.Drawing.Imaging.ImageFormat]::Png)
$leftI.Dispose(); $rightI.Dispose(); $innerI.Dispose()
$bb.Dispose(); $br.Dispose(); $bg.Dispose()
$g2.Dispose(); $bmp2.Dispose()

Get-Item $pngPath, $icoPath | Select-Object Name,Length
