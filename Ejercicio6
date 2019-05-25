[CmdLetBinding()]
Param ( [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][String] $InputPath = ".", 
		[Parameter(Mandatory = $true)][String] $OutputPath = ".",
		[Parameter(Mandatory = $true)][String] $funcion ='.'
	)  
	
Function ValidaRutas {
			if (Test-Path $InputPath){	
			
					return $true
				
			}
			else{
				"Ruta de entrada invalida."
				}
}				
#-----------------------------------------------------------------------------------------------------------------------#
Function multiplicar
{
Param([Parameter(Mandatory = $true)][int] $factor ='.')
[int] $cont=0;


for($i=0;$i -lt $fila;$i++)
{
for($j=0;$j -lt $col;$j++)
{
	$nueva[$i,$j]=($matriz[$i,$j])*$factor
}
}
	$nueva
	$nueva -join'|' | Format-table -Wrap > $OutputPath	
}
<#----------------------------------------------------------------------#>
Function transponer
{
[int] $cont=0;

for($i=0;$i -lt $fila;$i++)
{
for($j=0;$j -lt $col;$j++)
{

$nueva[$i,$j]= $matriz[$j,$i]

}
}
	$nueva
	$nueva | Format-list > $OutputPath	

}
<#----------------------------------------------------------------------#>
$RutasValidas = ValidaRutas
if($RutasValidas -eq $true)
{
	$ArchivoEntrada = get-content $InputPath #Leo el archivo de entrada
	
	$N = 3
	$fila = 3
	$col = 3
	$matriz = new-object 'object[,]' $N,$N   #Creo las matrices y los vectores
	$nueva = new-object 'object[,]' $N,$N

	for ($y = 0; $y -lt $N; $y++)   # Lleno la matriz segun el archivo de entrada
	{     
		for ($x = 0; $x -lt $N; $x++)   
		{     
			$matriz[($y),$x] = [double](($ArchivoEntrada[$y] -split " ")[$x])
			$matriz[($y),$x]
			
		} 
	}
	Write-Host "---------------"
	if($funcion -eq 'transponer')
	{
		transponer
	}
	if($funcion -eq 'multiplicar')
	{
		multiplicar
	}
	
	
	}
