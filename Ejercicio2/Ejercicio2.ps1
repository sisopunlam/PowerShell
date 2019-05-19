#--------------------------------------------------#
# Nombre del Script: Ejercicio2.ps1                #
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
    Este script busca dentro de un directorio y subdirectorios archivos duplicados,
    considerando "Duplicado" a aquellos archivos con igual nombre e igual peso (O, 
    mas concretamente, igual Hash)
    
    .PARAMETER Path
    "Path" es aquel directorio padre que hay que revisar

    .EXAMPLE
    .\Ejercicio2.ps1 -path '

    .Link
    Criterio: http://kenwardtown.com/2016/12/29/find-duplicate-files-with-powershell/
    
    #>

    # Validación del parámetro
    #Comando de referencia: Get-ChildItem $Path -File -Recurse | Get-FileHash | Group-Object -Property Name, Hash | Where-Object Count -GT 1 | foreach {$_.Group | Select -Unique Path, Hash}
Param
(
    [CmdletBinding()]
    [parameter(Mandatory=$True)]
    [string]$Path
)
if(!(Test-Path -PathType Container $Path)) {
    Write-Error "El $Path no existe "
    Exit
}
#Si el directorio existe y es valido
#La variable 'Archivo' es un array asociativo para almacenar key(hash de un archivo)/value (cantidad de apariciones)
$archivos=@{}
#Para cada archivo en $Path has
Get-ChildItem -File -Recurse $Path | ForEach-Object{
    #Obten el hash del archivo actual
    $hash = ($_ | Get-FileHash)
    #Si hay al menos un Hash en el hashtable y el Hash existe en el array, entoces muestralo
    if($archivos.Count -gt 0 -and $archivos.Contains($hash.Hash)){
        Write-Host "Archivo Duplicado, Path: " $_.FullName
    }else{
        #Sino agregalo al hashtable
        $archivos[$hash.Hash]++
    }
}
