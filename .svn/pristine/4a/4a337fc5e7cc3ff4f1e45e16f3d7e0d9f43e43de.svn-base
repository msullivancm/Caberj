#include "Protheus.ch"

User function DPContaX (cConta,cEmp,cAno)  

Local cRet     	:= ""
Local _cQry		:= ""
Local cMes		:= ""
Default cAno	:= "2010"
Default cEmp	:= ""
Default cConta	:= ""

If Alltrim(cEmp)=="C" .Or. Alltrim(cEmp)=="c"//Caberj
	cEmp:="PAB010"
ElseIf Alltrim(cEmp)=="I" .Or. Alltrim(cEmp)=="i" //Integral
	cEmp:="PAB020"
Else
	Return
Endif

  _cQry := ""
  _cQry += " SELECT PAB_CTNOVA " + CRLF
  _cQry += " FROM " + cEmp + CRLF
  _cQry += " WHERE " + CRLF
  _cQry += " PAB_CTVELH='"+ALLTRIM(cConta)+"'" + CRLF  
  _cQry += " AND PAB_ANOVIG='" + cANO + "'" + CRLF                   
//  _cQry += " AND MES='" + cMES + "'" + CRLF
//  _cQry += " ORDER BY PLANO"
  
  If ( Select ( "cTemp" ) <> 0 )
	dbSelectArea ( "cTemp" )
	dbCloseArea ()
  Endif

  dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQry),"cTemp",.T.,.F.)

	
  If cTemp->(!eof())
	cRet:=cTemp->PAB_CTNOVA
  Else
    cRet:=cConta
  Endif
  
    
  
  //Alert(PB1_CTNOVA)

DbSelectArea("cTemp")
DbCloseArea("cTemp")
  		
Return cRet 
