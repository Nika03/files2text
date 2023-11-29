param([switch]$debug)
# if you append "-debug" to the script, the boolean value of $debug will change - if appended: true

if ($debug)
{
    "`n>> Debug mode enabled <<`n";
} else 
{
    "`nFile names with extentions to a text document by Nika`n";
}

# The directory containing your files
$directory = Read-Host -Prompt 'Directory to scan for files';
if ($debug) {">> `"$($directory)`""}

$files = Get-ChildItem $directory;

$checkOutputDir = Read-Host -Prompt "`nDo you want the generated file to be created/edited in the same directory?`n[Y/n]";
if ($debug) {">> `"$($checkOutputDir)`""}


switch ($checkOutputDir)
{
    {'n', 'no' -eq $_ } 
    { 
        $OutputDir = Read-Host -Prompt "`nCustom output directory";
        break
    }

    default 
    {
        $OutputDir = $directory;
        break
    }
}
if ($debug) {">> `"$($OutputDir)`""}

$whitelist = Read-Host -Prompt "`nEnable Whitelist?`n[y/N]"

switch ($whitelist)
{
    {'y', 'yes' -eq $_}
    {
        $getExtn = Read-Host -Prompt "`nExtention to whitelist";
        $whitelistEnabled = $true;
    }

    default
    {
        $whitelistEnabled = $false
    }
}

$txtFile = Read-Host -Prompt "`nName the output file WITH the extention";
"`n";

if ($debug) {">> `"$($getExtn)`"`n>> `"$($txtFile)`""}

foreach($file in $files)
    {
        if ($whitelistEnabled)
        {
            $extn = [IO.Path]::GetExtension($file)
            if ($extn -eq $getExtn)
            {
                Add-Content "$($OutputDir)\$($txtFile)" $file.Name; 
                "Added `"$($file.Name)`" to `"$($OutputDir)\$($txtFile)`"";  
            } else 
            {
                "File `"$($file.Name)`" isn't a $($getExtn) file, skipping...";
            }
        } else
        {
            Add-Content "$($OutputDir)\$($txtFile)" $file.Name;
            "Added `"$($file.Name)`" to `"$($OutputDir)\$($txtFile)`"";
        }
    }

"`nDone!"