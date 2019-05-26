#--------------------------------------------------#
# Nombre del Script: Ejercicio4.ps1                #
# Trabajo Practico n°2                             #
# Integrantes:                                     #
# Amato, Luciano            DNI: 40.378.763        #
# Del Greco, Juan Pablo     DNI: 38.435.945        #
# Meza, Julian              DNI: 39.463.982        #
# Pompeo, Nicolas Ruben     DNI: 37.276.705        #
# Entrega: 27/05/2019                              #
# Entrega n°1                                      #
#--------------------------------------------------#

<#
    .SYNOPSIS
    Este script realiza lo siguiente: En un Path que contiene logs (PathLogss) busca una
    cadena de texto ($Cadena), en caso de encontrar esa cadena al menos una vez, copia
    ese log a un segundo path ($PathSalida) y al terminar, comprime la carpeta en un archivo .zip
    Suponemos que $PathLogs no tiene subcarpetas.
    El script no puede ser invocado multiples veces con la misma cadena.
    El script no funciona con archivos .docx, si con .doc, .rtf, etc.
    .PARAMETER PathLogs
    "Path" es aquel directorio padre que hay que revisar
    .PARAMETER PathSalida
    "PathSalida" es aquel directorio que se elige para copiar los archivos que cumplan con el parametro -Cadena
    .EXAMPLE
    c:\Users\Nick\Documents\GitHub\PowerShell\Ejercicio4\Ejercicio4.ps1 -PathLogs 'C:\Users\Nick\Documents\Word y Texto' -Cadena 'No funciona' -PathSalida 'C:\Users\Nick\Desktop\TSKF'-Extension 'txt'
    Genera el archivo "No Funciona.zip"

    .Link
    Comprimir un archivo: https://www.youtube.com/watch?v=tzvqnpXElOA
    Comprimir un archivo: https://www.pdq.com/blog/powershell-zip-up-files-using-net-and-add-type/
    Copiar archivos: https://stackoverflow.com/questions/16004984/powershell-command-to-copy-only-text-files
    Encontrar una cadena de texto: https://devblogs.microsoft.com/scripting/powertip-using-powershell-to-search-text-files-for-letter-pattern/

    
    #>

    Param
(
    [CmdletBinding()]
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory = $True)] [string]$PathLogs,
    [Parameter(Mandatory = $True)] [String]$Cadena,
    [Parameter(Mandatory = $True)] [string]$PathSalida,
    [Parameter(Mandatory = $True)] [ValidateLength(3,5)] [string]$Extension
)
#Si no es valido el PathLogs o el PathSalida, solo sal del programa
if(!(Test-Path $PathLogs)){
    Write-Error "El Path de logs es invalido, por favor, Provea algo "
}

if(!(Test-Path $PathSalida)){
    Write-Error "El Path de salida es invalido, por favor, Provea algo "
}
function ComprimirArchivo{
    param (
        [Parameter(Mandatory=$True)][string]$PathDestino,
        [Parameter(Mandatory=$True)][string]$PathOrigen,
        [Parameter(Mandatory=$False)][string]$CompressionLevel = "Optimal",
        [Parameter(Mandatory=$False)][switch]$IncludeParentDir
    )
    $Archivo = $Cadena+'.zip'
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $CompressionLevel    = [System.IO.Compression.CompressionLevel]::$CompressionLevel  
    [System.IO.Compression.ZipFile]::CreateFromDirectory($PathOrigen, $PathDestino+$Archivo, $CompressionLevel, $IncludeParentDir)
}
#Si el directorio existe y es valido
#Muestro un aviso en donde se encontrara el archivo
Write-Host "El directorio actual en donde se alojara el archvivo comprimido es" $PWD
#Para cada archivo .log en $PathLogs, si lo encuentra, pasa ese archivo a pipe y luego lo copia. Terminada la operacion, lo pasa a pipe y lo comprime
Select-String -Pattern $Cadena -Path $PathLogs\*.$Extension | Copy-Item -Destination $PathSalida
#Mando a comprimir
ComprimirArchivo -PathDestino $PWD\ -PathOrigen $PathSalida
#Borro el contenido de $PathSalida para 'limpiar el buffer'
Remove-Item $PathSalida\*.*