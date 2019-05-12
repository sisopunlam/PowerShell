#--------------------------------------------------#
# Nombre del Script: Ejercicio1.ps1                #
# Trabajo Practico n°2                             #
# Integrantes:                                     #
# Amato, Luciano            DNI: 40.378.763        #
# Del Greco, Juan Pablo     DNI: 38.435.945        #
# Meza, Julian              DNI: 39.463.982        #
# Pompeo, Nicolas Ruben     DNI: 37.276.705        #
# Entrega: 27/05/2019                              #
# Entrega n°1                                      #
#--------------------------------------------------#
# Dado el siguiente codigo, respnder:
Param($pathsalida)
$existe = Test-Path $pathsalida
if($existe -eq $true) {
    $lista = Get-ChildItem -File
    foreach ($item in $lista) {
        Write-Host "$($item.Name) $($item.Lenght)"
    }
} else {
    Write-Error "El path no existe"
}
<#
    a) ¿Cual es el objetivo del script?
    El objetivo del script es escribir en un archivo de salida
    un listado de los archivos disponibles en el directorio actual, sin ser recursivo, 
    comprobando a priori la existencia del path de salida. 
    En caso de no existir, da un mensaje de error.
    
    b) ¿Que validaciones agregaria a la definicion de parametros?
    Validaria que $pathsalida no es un string vacio mediante
    Param ([ValidateNotNullOrEmpty()][ValidateScript({Test-Path $_})] [string] $path = ".")
    
    c) ¿Con que cmdlet se podria reemplazar el script para mostrar una salida similiar?
    El cmdlet que realiza una salida similar a Get-ChildItem es Get-Item, aunque, su formato
    para llamarlo se hace particularmente diferente: 
    Con Get-Item:  Get-Item * | Where {$_.Attributes -match "Archive"}
    Con Get-ChildItem: Get-ChildItem -File
#>