#Include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL260CAR  ºAutor  ³Leonardo Portella   º Data ³  19/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE para permitir selecionar os usuarios incluidos e gerar a º±±
±±º          ³autorizacao provisoria. Disparado apos incluir um usuario   º±±
±±º          ³e confirmar o processo na tela de Familia/Usuario.          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL260CAR

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aCabecFam 	:= PARAMIXB[1] //Array com informacoes da BA3
Local aDadosFam 	:= PARAMIXB[2] //Array com informacoes da BA3 filtrado de acordo com a rotina 
Local aCabHeader 	:= PARAMIXB[3] //aHeader do browse
Local aColsUsr		:= PARAMIXB[4] //aCols do browse
Local aTrab 		:= PARAMIXB[5] //Vetor com informacoes de trabalho do browse de usuarios. Se o conteudo for 0, a linha esta sendo incluida
Local nOpcao 		:= PARAMIXB[6] //Opcao executada pelo browse da rotina
Local oOk      		:= LoadBitMap(GetResources(),"LBOK")
Local oNo      		:= LoadBitMap(GetResources(),"LBNO")
Local lConfirm		:= .F. 
Local aCab			:= {" ","Matrícula","Nome"}
Local aUsrsInc		:= {}
Local aTam			:= {20,50,100}

Private oDlg 		:= nil
Private oBrowse		:= nil  

If nOpcao == 4//Incluindo
    
	nPosNome 	:= aScan(aCabHeader,{|x|allTrim(Upper(x[2])) == 'BA1_NOMUSR'})
	nPosMatric 	:= aScan(aCabHeader,{|x|allTrim(Upper(x[2])) == 'BA1_MATUSU'})
	
	For i := 1 to len(aTrab)
		If aTrab[i] == 0    
			aAdd(aUsrsInc,{.T.,aColsUsr[i][nPosMatric],aColsUsr[i][nPosNome]})
		EndIf
	Next
	
	If len(aUsrsInc) > 0

		oDlg := MSDialog():New(0,0,470,850,"Impresão de autorização provisória",,,.F.,,,,,,.T.,,,.T. )
		
		    oBrowse := TCBrowse():New(10,09,410,190,,aCab,aTam,oDlg,,,,,{||aUsrsInc[oBrowse:nAt,1] := !aUsrsInc[oBrowse:nAt,1], oBrowse:Refresh()},,,,,,,.F.,,.T.,,.F.,,, )
		    oBrowse:SetArray(aUsrsInc) 
		    
		    oBrowse:bLine := {||{If(aUsrsInc[oBrowse:nAt,1]	,oOk,oNo)							,;
								Transform(aUsrsInc[oBrowse:nAt,2],PesqPict('BA1','BA1_MATUSU'))	,;
								aUsrsInc[oBrowse:nAt,3]  				  							}}  
							
			oBrowse:nScrollType := 1 // Scroll VCR        
		    
		  	oSBtn1     := SButton():New(210,365,1,{||lConfirm := .T.,oDlg:End()}	,oDlg,,"", )
			oSBtn2     := SButton():New(210,395,2,{||oDlg:End()}					,oDlg,,"", )
		
		oDlg:Activate(,,,.T.)	  
		
		If lConfirm

			Private cCRPar		:="1;0;1;Relatório aUTORIZAÇÃO Provisoria"      
			Private cParam1     := ""    
			Private cParam2     := ""     
			Private cParam3     := ""      
	
			cMatrics 	:= "'"    
			lImp 		:= .F.
			
			For i := 1 to len(aUsrsInc)
			    If aUsrsInc[i][1]       
			    	lImp := .T.
			    	cMatrics += aUsrsInc[i][2] + ","
			    EndIf
			Next                             
			
			cMatrics := left(cMatrics,len(cMatrics)-1) + "'"		
			
			cParam2	:= cEmpAnt 
			cParam3	:= alltrim(cUserName)
			
			//Leonardo Portella - 28/11/11 - Incluir a data de validade ate. Data base + 60 dias
			//cParam1	:= cMatrics + ";" + dtoc(dDataBase) + ";" + cParam2 + ";" + cParam3
			cParam1	:= cMatrics + ";" + dtoc(dDataBase) + ";" + dtoc(dDataBase + 60) + ";" + cParam2 + ";" + cParam3
			
			CallCrys("AUTPRO",cParam1,cCRPar)     
			//LOGERROS('CallCrys("AUTPRO","' + cParam1 + '","' + cCRPar + '")')
		EndIf
	
	EndIf

EndIf

Return