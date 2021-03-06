#--------------------------------------------------#
# Nombre del Script: Ejercicio3.ps1                #
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
    Este script toma los datos de un archivo .csv (Patente,ValorMulta,Fecha) ($inputPath), 
    ordena de forma ascendente por patente y suma las multas que sean de la misma patente en el mismo año.
    Luego envia todo a un archivo .csv($outputPath)
    
    .PARAMETER inputPath
    "inputPath" es aquel directorio padre que tiene los datos a procesar

    .PARAMETER outputPath
    "outputPath" archivo destino

    .EXAMPLE
    Ejecucion: .\ejercicio3.ps1 .\patentes.csv patentesOut

#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$TRUE, Position=1)]
    [ValidateNotNullOrEmpty()]
    [string] $inputPath,

    [Parameter(Mandatory=$TRUE, Position=2)]
    [ValidateNotNullOrEmpty()]
    [string] $outputPath

)

$existe_input = Test-Path $inputPath
    if(!($existe_input))
{ 
         Write-Host "VACIO"
         Exit
}
    if(!($inputPath.Split(".")[2] -eq "csv")){
      Write-Host "SOLO SE ADMITEN ARCHIVOS .CSV"
      Exit
    }

$cvs = Import-Csv $inputPath -Delimiter "," | Select-Object -Property Patente,ValorMulta,Fecha 
$ArrayList1 = [System.Collections.ArrayList]@() 
$hash =@{}
foreach($pat in $cvs)
{   
     $date = Get-Date $pat.Fecha     
    
     if($hash.ContainsKey($pat.Patente+"/"+$date.Year)){

     $hash.($pat.Patente+"/"+$date.Year) += [int]$pat.ValorMulta
    
     }
     else
     {
      $hash.Add(($pat.Patente+"/"+$date.Year),[int]$pat.ValorMulta)
      }
}

foreach($obj in $hash.Keys){
    $objeto = Select-Object @{n= 'Patente' ; e = {$obj.Split("/")[0]}},@{n= 'Anio'; e = {$obj.Split("/")[1]}},@{n='TotalMultas';e= {$hash.$obj}} -InputObject ' '
    $array = $ArrayList1.Add($objeto) 
   
}

$ArrayList1 | Sort-Object -Property Patente

$ArrayList1 | Export-Csv $outputPath".csv" -Delimiter ","  -NoTypeInformation
