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
    considerando "Duplicado" a aquellos archivos con igual nombre e igual peso
    
    .PARAMETER Path
    "Path" es aquel directorio padre que hay qeu revisar

    .EXAMPLE
    .\Ejercicio2.ps1 -path '
    
    #>

    # Validación del parámetro
Param
(
    [CmdletBinding()]
    [parameter(Mandatory=$True)]
    [string]$Path
)
if(!(Test-Path -PathType Container $Path)) {
    Write-Error "Path incorrecto."
    Exit
}
$Archivos=@()
$Archivos=Get-ChildItem $Path -File -Recurse | Get-FileHash | Group-Object -Property Name, Hash | Where-Object Count -GT 1 | foreach {$_.Group | Select -Unique Path, Hash}
foreach ($directorio in $Archivos){
    Write-Output "$directorio $Archivo[$directorio]"
}
