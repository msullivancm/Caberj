#Include "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

User Function fRetUnV11( _cUN, _nPorta, _cAmb )

Local   aIPs    := {}
Local   aTemp   := {}
Local   i		:= 0
Default _cUN    := ""
Default _nPorta := 1235
Default _cAmb   := ""
                           
//Lista de Servidores Remotos ( Unidades )
aAdd( aIPs, { "02", "10.0.100.215", _nPorta, "ORTOSP" , "02", "02", "São Paulo			","RJ", "SB" } )
aAdd( aIPs, { "03", "10.0.100.201", _nPorta, "ORTORJ" , "03", "02", "Rio de Janeiro		","RJ", "RJ" } )
aAdd( aIPs, { "04", "10.0.100.202", _nPorta, "ORTOMG" , "04", "02", "Minas Gerais		","RJ", "MG" } )
aAdd( aIPs, { "05", "10.0.100.203", _nPorta, "ORTOGO" , "05", "02", "Goias				","RJ", "GO" } )
aAdd( aIPs, { "06", "10.0.100.204", _nPorta, "ORTOMT" , "06", "02", "Mato Grosso		","RJ", "MT" } )
aAdd( aIPs, { "07", "10.0.100.205", _nPorta, "ORTOBA" , "07", "02", "Bahia				","RJ", "BA" } )
aAdd( aIPs, { "08", "10.0.100.206", _nPorta, "ORTOPE" , "08", "02", "Pernambuco			","RJ", "PE" } )
aAdd( aIPs, { "09", "10.0.100.207", _nPorta, "ORTOCE" , "09", "02", "Ceará				","RJ", "CE" } )
aAdd( aIPs, { "10", "10.0.100.208", _nPorta, "ORTOPR" , "10", "02", "Paraná				","RJ", "PR" } )
aAdd( aIPs, { "11", "10.0.100.209", _nPorta, "ORTOPA" , "11", "02", "Pará				","RJ", "PA" } )
aAdd( aIPs, { "15", "10.0.100.210", _nPorta, "ORTORS" , "15", "02", "Rio Grande do Sul	","RJ", "RS" } )
aAdd( aIPs, { "17", "10.0.100.201", _nPorta, "ORTORJ" , "58", "01", "TCO           		","RJ", "TC" } )
aAdd( aIPs, { "18", "10.0.100.201", _nPorta, "ORTORJ" , "18", "02", "Queimados		    ","RJ", "QM" } )
aAdd( aIPs, { "21", "10.0.100.6"  , _nPorta, "ORTOBOM", "21", "02", "OrtoFio			","RJ", "OF" } )
aAdd( aIPs, { "22", "10.0.100.213", _nPorta, "ORTOAF" , "22", "02", "All Fibra 			","RJ", "AF" } )
aAdd( aIPs, { "23", "10.0.100.205", _nPorta, "ORTOBA" , "23", "02", "Bahia				","RJ", "FC" } )
aAdd( aIPs, { "24", "10.0.100.205", _nPorta, "ORTOBA" , "24", "02", "CiaPlast   		","RJ", "CP" } )
aAdd( aIPs, { "25", "10.0.100.203", _nPorta, "ORTOGO" , "25", "02", "Goias				","RJ", "CO" } )
aAdd( aIPs, { "26", "10.0.100.209", _nPorta, "ORTOPA" , "26", "02", "Manaus				","RJ", "AM" } )

if !Empty(_cUN)
   for i:=1 to Len(aIPs)
      if _cUN == aIPs[i,5]
      	aTemp := { aIPs[i] }
      endif	
   Next i
   if !Empty(aTemp)
      aIPs := aTemp
   endif   
Endif

if !Empty(_cAmb)
   for i:=1 to Len(aIPs)
       aIPs[i,4]:=_cAmb
   Next
Endif

Return aIPs
