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
        Este script realizam dos fuciones(no en simultaneo) :
        -Informar la cantidad de procesos que se encuentran corriendo en ese momento. • 
        -Indicar la cantidad de archivos que contiene un directorio.


.Description
        Este script recibe como primer parametro la funcionalidad a realizar

    
.EXAMPLE
   .\Ej5.ps1 -procesos
   Cantidad de procesos activos: 275

.EXAMPLE
   .\Ej5.ps1 -archivo "E:\test"
   Cantidad de archivos: 4

#>

Param(
    [Parameter(Mandatory = $true, position = 0, ParameterSetName = "procesos")][switch]$Procesos,
    [Parameter(Mandatory = $true, position = 0, ParameterSetName = "archivos")][switch]$Archivo,
    [Parameter(Mandatory = $false, ParameterSetName = "directorio")][switch]$Directorio,

    [Parameter(Mandatory = $false, Position = 1, HelpMessage = "Ingrese el directorio que quiere vigilar.")]
    [validateScript( {                    
            if ( $_ -eq $null -or $_ -eq '' -or -not ( Test-Path -Path $_ -PathType Container) ) {
                throw 'Debe ser un directorio valido' 
            }
            $True                    
        })]    
    [string] $Path = ''
       
)


if ($Procesos) {
    [TimeSpan]$interval = [System.TimeSpan]::FromMilliseconds( 1000 ) # 1 sec.
    while ( $true ) {
        write-host  "Cantidad de procesos activos: $((Get-Process).count)"
        [System.Threading.Thread]::Sleep( $interval )
    }
    
}
if ($Directorio) {
    write-host "Directorio actua: $Path"
}
elseif ($Archivo) {
     
    $interval = [System.TimeSpan]::FromMilliseconds( 1000 ) # 1 sec.
    while ( $true ) {
        $cant = $((Get-ChildItem -Recurse $Path).count)  #forma de directorios recursivos
        write-host  "Cantidad de archivos: $cant"  
        [System.Threading.Thread]::Sleep( $interval )
    }
         
}
