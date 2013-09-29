function Write-Color-LS
    {
        param ([string]$color = "white", $file)
        Write-host ("{0,-7} {1,25} {2,10} {3}" -f $file.mode, ([String]::Format("{0,10}  {1,8}", $file.LastWriteTime.ToString("d"), $file.LastWriteTime.ToString("t"))), $file.length, $file.name) -foregroundcolor $color 
    }

New-CommandWrapper Out-Default -Process {
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase)


    $compressed = New-Object System.Text.RegularExpressions.Regex(
        '\.(zip|tar|gz|rar|jar|war|iso|img|7z|bin|cab)$', $regex_opts)
    $executable = New-Object System.Text.RegularExpressions.Regex(
        '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg)$', $regex_opts)
    $text_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(txt|cfg|conf|ini|csv|log|java|c|cpp)$', $regex_opts)
    $html_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(xml|html|config|aspx|ascx|cshtml|asax|targets|svc)$', $regex_opts)
    $images = New-Object System.Text.RegularExpressions.Regex(
        '\.(png|jpg|gif|bmp)$', $regex_opts)
    $media_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(mp3|aac|avi|mkv|mp4|wmv)$', $regex_opts)

    $red_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(pdf|js|pdb)$', $regex_opts)
    $violet_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(sln|csproj|css|scss)$', $regex_opts)
    $green_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(cs|csv|xsl|xslx)$', $regex_opts)
    $dark_green_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(dll)$', $regex_opts)
    $blue_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(doc|docx|nupkg|nuspec)$', $regex_opts)

    if(($_ -is [System.IO.DirectoryInfo]) -or ($_ -is [System.IO.FileInfo]))
    {
        if(-not ($notfirst)) 
        {
           Write-Host
           Write-Host "    Directory: " -noNewLine
           Write-Host " $(pwd)`n" -foregroundcolor "DarkCyan"           
           Write-Host "Mode                LastWriteTime     Length Name"
           Write-Host "----                -------------     ------ ----"
           $notfirst=$true
        }

        if ($_ -is [System.IO.DirectoryInfo]) 
        {
            Write-Color-LS "DarkCyan" $_                
        }
        elseif ($compressed.IsMatch($_.Name))
        {
            Write-Color-LS "DarkBlue" $_
        }
        elseif ($executable.IsMatch($_.Name))
        {
            Write-Color-LS "Red" $_
        }
        elseif ($images.IsMatch($_.Name))
        {
            Write-Color-LS "Yellow" $_
        }
        elseif ($media_files.IsMatch($_.Name))
        {
            Write-Color-LS "Cyan" $_
        }
        elseif ($html_files.IsMatch($_.Name))
        {
            Write-Color-LS "DarkYellow" $_
        }
        elseif ($red_files.IsMatch($_.Name))
        {
            Write-Color-LS "Red" $_
        }
        elseif ($violet_files.IsMatch($_.Name))
        {
            Write-Color-LS "Magenta" $_
        }
        elseif ($green_files.IsMatch($_.Name))
        {
            Write-Color-LS "Green" $_
        }
        elseif ($dark_green_files.IsMatch($_.Name))
        {
            Write-Color-LS "DarkGreen" $_
        }
        elseif ($blue_files.IsMatch($_.Name))
        {
            Write-Color-LS "Blue" $_
        }
        else
        {
            Write-Color-LS "White" $_
        }

    $_ = $null
    }
} -end {
    write-host ""
}