#--------------------------------------------------#
# Nombre del Script: Ejercicio6.ps1                #
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
	 Se desarrollo un script que permite realizar producto escalar y trasposición de matrices. 
	
    .DESCRIPTION
	Informacion del grupo
	#--------------------------------------------------#
	# Nombre del Script: Ejercicio6.ps1                #
	# Trabajo Practico n°2                             #
	# Integrantes:                                     #
	# Amato, Luciano            DNI: 40.378.763        #
	# Del Greco, Juan Pablo     DNI: 38.435.945        #
	# Meza, Julian              DNI: 39.463.982        #
	# Pompeo, Nicolas Ruben     DNI: 37.276.705        #
	# Entrega: 27/05/2019                              #
	# Entrega n°1                                      #
	#--------------------------------------------------#
	
	 Se desarrollo un script que permite realizar producto escalar y trasposición de matrices. 
	 La entrada de la matriz al script se realizará mediante un archivo de texto plano. 
	 La salida se guardará en otro archivo que se llamará “salida.nombreArchivoEntrada”. 
	 El archivo se genera automaticamente. Si se repite la ejecucion del Script, el contenido del archivo sera reemplazado por el nuevo contenido.
	 El formato de los archivos de matrices debe ser el siguiente: 
					0|1|2
					1|1|1 
					-3|-3|1
				
	.PARAMETER -Entrada
	Path del archivo de entrada. No se debe realizar validación por extensión de archivo. 
	Se asume que todos los archivos de entrada tienen matrices válidas. 

	.PARAMETER -Producto
	De tipo entero, recibe el escalar a ser utilizado en el producto escalar. No se puede usar junto con “-Trasponer”. 
	.PARAMETER -Transponer
	 De tipo switch, traspone la matriz. No se puede usar junto con “-Producto”.
	.EXAMPLE
														Trasponer Matriz:
	Se solicita ingresar el archivo de Entrada y luego especificamos la funcion -Transponer
	.\Ejercicio6.ps1 -Entrada .\ArchivoDeEntrada.txt -Transponer
	Se creara en el mismo directorio un Archivo cuyo nombre sera salida.ArchivoDeEntrada.txt y alli se vera la matriz Transpuesta
	.EXAMPLE
														Multiplicar Matriz:
	Se solicita ingresar el archivo de Entrada, la especificacion de la funcion -> "-Producto" y luego el numero el cual queremos multiplicar la matriz.
	
	.\Ejercicio6.ps1 -Entrada .\ArchivoDeEntrada.txt -Producto 5
	Se creara en el mismo directorio un Archivo cuyo nombre sera salida.ArchivoDeEntrada.txt y alli se vera la matriz multiplicada por el numero indicado


	.LINK
	https://docs.microsoft.com/en-us/powershell/






#>

[Cmdletbinding(DefaultParameterSetName='Name')]
Param ( [Parameter( Mandatory = $true, HelpMessage= "Ingrese la direccion del archivo que contiene la matriz:", Position=1, ParameterSetName="PR")][Parameter( Mandatory= $true, HelpMessage= "Ingrese el archivo matriz:", Position=1,ParameterSetName='TR')][ValidateNotNullOrEmpty()][String] $Entrada,
		[Parameter(Mandatory = $true,HelpMessage= "Ingrese numero a multiplicar:", Position=2,ParameterSetName = 'PR' )][int] $Producto,
		[Parameter(Mandatory = $true,ParameterSetName = 'TR')][Switch] $Transponer
	)  

<#----------------------------------------------------------------------#>
Function ValidaRutas {
			if (Test-Path $Entrada){	
			
					return $true
				
			}
			else{
				"Ruta de entrada invalida."
				}
			
}				
<#----------------------------------------------------------------------#>

function armarSalida{
		param( 
		[String]
		$entrada)
    
    $armarSal=$entrada.Split("\")
    $salida=""
    for($i=0; $i -lt ($armarSal.Count-1); $i++)
    {
        $salida+=$armarSal[$I]+"\"
    }
    $salida+="salida."+$armarSal[$armarSal.Count-1]
    return $salida
}
<#----------------------------------------------------------------------#>
function TransponerMatriz{

			param([String]$sal,[int] $fila, [int] $col )
			if(Test-Path $sal){
			Clear-Content $sal}
			$matTrap = New-Object 'Object[,]' $fila,$col
		for($i=0;$i -lt $fila;$i++)
			{
			for($j=0;$j -lt $col;$j++)
			{
			
			$matTrap[$i,$j]= $matriz[$j,$i]
			
			}
			}
		for($x=0;$x -lt $col ; $x++ )
			{
				$numero=""
			for($y=0; $y -lt ($fila - 1); $y++)
			{
				$numero+=$matTrap[$x,$y]
				$numero+='|'
			}
				$numero+=$matTrap[$x,($fila-1)]
			Add-Content "$sal" "$numero" 
			}

	}
<#----------------------------------------------------------------------#>
function multiplicarMatriz{
	
param([String]$sal,[int]$Prod,[int] $fila, [int] $col )
			if(Test-Path $sal){
			Clear-Content $sal}
			$matprod = New-Object 'Object[,]'$fila,$col
			for($i=0;$i -lt $fila;$i++)
			{
			for($j=0;$j -lt $col;$j++)
			{
				$matprod[$i,$j]=($matriz[$i,$j])*$Prod
				}
			}
			for($x=0;$x -lt $col ; $x++ )
			{
				$numero=""
			for($y=0; $y -lt ($fila - 1); $y++)
			{
				$numero+=$matprod[$x,$y]
				$numero+='|'
			}
				$numero+=$matprod[$x,($fila-1)]
				Add-Content "$sal" "$numero" 
			}
	
		}
#-----------------------------------------------------------------------------------------------------------------------#
$RutasValidas = ValidaRutas
if($RutasValidas -ne $true)
{
exit 1}
	$ArchivoEntrada = get-content $Entrada #Leo el archivo de entrada
	$ArchivoSalida= armarSalida $Entrada
	$filas=$ArchivoEntrada.split(" ")
	$cantFilas= $filas.Count
	$columnas= $filas[0].Split("|").Count

	$matriz = new-object 'object[,]' $cantFilas,$columnas   #Creo las matrices y los vectores
	$nueva = new-object 'object[,]' $cantFilas,$columnas

	for ($y = 0; $y -lt $cantFilas; $y++)   # Lleno la matriz segun el archivo de entrada
	{   
		$aux= $filas[$y].Split("|")
		for($x=0; $x -lt $columnas; $x++)
			{
        $matriz[$y,$x]=[double]$aux[$x]    
			}
	}
if( $Transponer -eq $true )
{
    TransponerMatriz $ArchivoSalida $cantFilas $columnas
}
else
{	
    multiplicarMatriz $ArchivoSalida $Producto $cantFilas $columnas
}


