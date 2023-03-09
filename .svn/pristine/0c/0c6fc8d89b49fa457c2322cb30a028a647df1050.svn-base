/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA564   ºAutor  ³Motta               º Data ³  nov/14     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ F3 que usa a views V_AGRUP_EMP_GER_CABERJ                  º±±
±±º          ³                    V_AGRUP_EMP_GER_INTEGRAL                º±±    
±±º          ³              das tabelas Tabelas                           º±±  
±±º          ³                    AGRUPAMENTO_EMPRESA_GERENCIAL           º±±
±±º          ³                    AGRUPAMENTO_EMPRESA_GER_DET             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA564()

Local aVetBx	:= {}         
Local cLog 		:= " "
Local nOpca		:= 0     
Local aCab		:= {"Codigo","Nome","Empresas"} //564
Local aTam		:= {50,100,100} //564
Local bDesMarca	:= {||aVetBx := DesMarca(aVetBx)}
Local lBuffer	:= .F.

Local lUnicaMar := .T. //564

Private oDlg 	:= nil
Private oBrowse	:= nil

SetPrvt("oDlg1","oCBox1")

Processa({||aVetBx := RetArrGrp()}) //564

oDlg := MSDialog():New(0,0,510,850,"Grupo de Empresas",,,.F.,,,,,,.T.,,,.T. ) //564

bClick 	:= {||lBuffer := !aVetBx[oBrowse:nAt,1],If(lUnicaMar,Eval(bDesMarca),),aVetBx[oBrowse:nAt,1] := lBuffer, oBrowse:Refresh()}                                                                          

oBrowse := TCBrowse():New(030,010,410,190,,aCab,aTam,oDlg,,,,,bClick,,,,,,,.F.,,.T.,,.F.,,, )
oBrowse:SetArray(aVetBx) 
    
oBrowse:bLine := {||{aVetBx[oBrowse:nAt,1]  				,;
                      aVetBx[oBrowse:nAt,2] 				,;
				      aVetBx[oBrowse:nAt,3]}}   
					
oBrowse:nScrollType := 1 // Scroll VCR        
    
oSBtn1     := SButton():New(230,365,1,{||cLog := aVetBx[oBrowse:nAt][1],oDlg:End()}	,oDlg,,"", )   
oSBtn2     := SButton():New(230,395,2,{||oDlg:End()}					,oDlg,,"", )

oDlg:Activate(,,,.T.) 

Return cLog  

*********************************************************************************************************

Static Function RetArrGrp
      
Local aRet 		:= {}
Local aGrps  	:= {}     
lOCAL cTab564   := "" 

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros...')
Next                    

//Carga sql (view tem as tabelas Oracle que guardam as empresas "agrupaveis"             

If cEmpAnt = "01" 
  cTab564 := "V_AGRUP_EMP_GER_CABERJ" 
Else  
  cTab564 := "V_AGRUP_EMP_GER_INTEGRAL" 
End if  

cSQL := " SELECT  COD_GRUPO , NOME_GRUPO , LISTA_EMPRESAS "
cSQL += " FROM "+ cTab564 + " "

PLSQuery(cSQL,"TRBGRP")

While !TRBGRP->(Eof())
	aAdd(aGrps,{TRBGRP->COD_GRUPO,TRBGRP->NOME_GRUPO,TRBGRP->LISTA_EMPRESAS})
	TRBGRP->(DbSkip())
Enddo

TRBGRP->(DbCloseArea())

Return aGrps