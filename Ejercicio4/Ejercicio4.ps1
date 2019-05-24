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
    Este script realiza lo siguiente: En un Path que contiene logs (PathLogs) busca una
    cadena de texto ($Cadena), en caso de encontrar esa cadena al menos una vez, copia
    ese log a un segundo path ($PathSalida) y al terminar, comprime la carpeta en un archivo .zip
    Suponemos que $PathLogs no tiene subcarpetas.
    .PARAMETER Path
    "Path" es aquel directorio padre que hay que revisar

    .EXAMPLE
    .\Ejercicio2.ps1 -path '

    .Link
    Zipping/Unzipping Files: https://blog.netwrix.com/2018/11/06/using-powershell-to-create-zip-archives-and-unzip-files/
    Copiar archivos: https://stackoverflow.com/questions/16004984/powershell-command-to-copy-only-text-files
    Encontrar una cadena de texto: https://devblogs.microsoft.com/scripting/powertip-using-powershell-to-search-text-files-for-letter-pattern/

    
    #>

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

#Para cada archivo .log en $PathLog, si lo encuentra, pasa ese archivo a pipe y luego lo copia. Terminada la operacion, lo pasa a pipe y lo comprime
Select-String -Pattern '$Cadena'-Path '$PathLog'\*.log | Copy-Item -Destination $PathSalida
#

#Ahora para 