// Ponto de entrada para acrescentar bot�es no Call Center
// Marcelo Giglio - 29/01/2013

#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"

User function PLSTMKBUT()
                                                                                                                                 
Local aButtonsEn  := {}
Local k_Direitos  := 2    // Somente em visualiza��o
Local cBotao 
Local CodOcorr                                               
LOCAL aOldRotina := aClone(aRotina)
                                                                                                                                                                                            
//chamar rdmake CABEXEBT passando o comando a ser executado chamando a aplica��o e o n�mero da solicita��o/ocorrencia para grava��o chamando a fun��o
// PlsTmkOco do fonte padr�o PLSxTMK

// Chama a tela de dados da Familia somente em visualiza��o - Op��o 2
// Pode ser implementado com direitos de altera��o - testar grupo de usu�rios e usar 4 se quiser altera��o 
    Aadd(   aButtonsEn,  {  "DEPENDENTES" , "Fam�lia" ,  { ||  U_CABEXEBT("CAB01", "61")  }  } )  

// Chama a tela do Mural - Aplica��o Customizada CABERJ
    Aadd(   aButtonsEn,  {  "SELECT" , "Mural" ,  { || U_CABEXEBT("CAB02", "62")  }  } )
    
// Chama a tela do Protocolo de Reembolso - Aplica��o Customizada CABERJ
    Aadd(   aButtonsEn,  {  "BAIXATIT" , "Reembolso" ,  { || U_CABEXEBT("CAB03", "63") }  } )    

// Chama a tela da Carta IR - Aplica��o Customizada CABERJ
    Aadd(   aButtonsEn,  {  "BMPPOST" , "Carta IR" ,  { || U_CABEXEBT("CAB04", "64")  }  } )

// Chama o Relat�rio de Reembolso para IR - Aplica��o customizada CABERJ
    Aadd(   aButtonsEn,  {  "VENDEDOR" , "Reemb.Us." ,  { || U_CABEXEBT("CAB05", "65")  }  } )          

// Chama a tela da Altera��o Dados Unificada - Aplica��o Customizada CABERJ
    Aadd(   aButtonsEn,  {  "GROUP" , "Dados Us." ,  { || U_CABEXEBT("CAB06", "66")  }  } )
                                                                                                                             
// Chama a tela da Autoriza��o Provis�ria - Aplica��o Customizada CABERJ
    Aadd(   aButtonsEn,  {  "PEDIDO" , "Aut. Prov." ,  { || U_CABEXEBT("CAB07", "67")  }  } )          
    
// Chama a tela do Relat�rio Faturamento Empresas - Aplica��o Customizada CABERJ
    Aadd(   aButtonsEn,  {  "LINE" , "Rel.Fat." ,  { || U_CABEXEBT("CAB08", "68")  }  } )                
    
// Chama a tela da Aplica��o Posi��o Usu�rios
    Aadd(   aButtonsEn,  {  "USER" , "Pos.Usu." ,  { || U_CABEXEBT("CAB09", "69")  }  } )          
    
// Chama a tela do Relat�rio M�dico por Usu�rio
    Aadd(   aButtonsEn,  {  "ANALITICO" , "Rel.Med.Us." ,  { || U_CABEXEBT("CAB10", "70	")   }  } )      

// Chama a tela de Inclus�o de Ocorr�ncias Cadastradas
    Aadd(   aButtonsEn,  {  "BMPCPO" , "Ocorr�nc.." ,  { || U_CABINCOCO("CAB11", "XX	")   }  } )      

aRotina := aClone(aOldRotina)   

Return(aButtonsEn)                               


//Fun��o para executar as a��es dos bot�es               
User Function CABEXEBT(cBotao, CodOcorr)
                                                  
// Guarda as areas para posterior recuperacao

Local aAreaBA1 := BA1->(GetArea())    
Local aAreaBTS := BTS->(GetArea())    
Local aAreaSA1 := SA1->(GetArea())    
LOCAL aOldRotina := aClone(aRotina)

    Do Case

  		Case cBotao == "CAB01"
  		    // Chama a tela de dados da Familia somente em visualiza��o - Op��o 2
		    // Pode ser implementado com direitos de altera��o - testar grupo de usu�rios e usar 4 se quiser altera��o 
		    PLSA260MOV( "BA1", BA1->(  RECNO() ) , 2  ) 
		
  		Case cBotao == "CAB02"
		    // Chama a tela do Mural - Aplica��o Customizada CABERJ
		    U_CDMURAL()
		    
  		Case cBotao == "CAB03"
		    // Chama a tela do Protocolo de Reembolso - Aplica��o Customizada CABERJ

		    U_CDPROTREE()
		    
  		Case cBotao == "CAB04"
		    // Chama a tela da Carta IR - Aplica��o Customizada CABERJ
		    U_UPLR253()
		
  		Case cBotao == "CAB05"
		    // Chama o Relat�rio de Reembolso para IR - Aplica��o customizada CABERJ
		    U_CABR098()
		
  		Case cBotao == "CAB06"
		    // Chama a tela da Altera��o Dados Unificada - Aplica��o Customizada CABERJ
		    U_CRJP100()
		                                                                                                                             
  		Case cBotao == "CAB07"
		    // Chama a tela da Autoriza��o Provis�ria - Aplica��o Customizada CABERJ
		    U_AUTPRO()
		    
  		Case cBotao == "CAB08"
		    // Chama a tela do Relat�rio Faturamento Empresas - Aplica��o Customizada CABERJ
		    U_CRJR999()
		    
  		Case cBotao == "CAB09"
		    // Chama a tela da Aplica��o Posi��o Usu�rios
		   PLSA730()
		    
  		Case cBotao == "CAB10"
		    // Chama a tela do Relat�rio M�dico por Usu�rio
		    PLSR025()

    EndCase

           //Chama a rotina PlsTmkOco do PLSxTMK para gravar o atendimento passando o n�mero da B20
           
           U_PlsTmkOc(CodOcorr)
           
RestArea(aAreaSA1)           
RestArea(aAreaBTS)
RestArea(aAreaBA1)
      
aRotina := aClone(aOldRotina)   

Return
                   
//Fun��o para Inserir ocorr�ncias no grid
User Function CABINCOCO(cBotao, CodOcorr)
                                                  
// Guarda as areas para posterior recuperacao

Local aAreaBA1 := BA1->(GetArea())    
Local aAreaBTS := BTS->(GetArea())    
Local aAreaSA1 := SA1->(GetArea())    
Local ocOcorr := Nil 

Local aSalvAmb := {}
Local cTitulo  := "Consulta Ocorr�ncias Call Center"
Local cRetorno
LOCAL aOldRotina := aClone(aRotina)
Private cClique

Private aVetor   := {}
Private oDlg     := Nil
Private oLbx     := Nil


dbSelectArea("B20")
aSalvAmb := GetArea()
dbSetOrder(1)
dbSeek(xFilial("B20"))

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While !Eof() .And. B20_FILIAL == xFilial("B20")
   aAdd( aVetor, { B20_OCORRE, B20_DESCAS, B20_DESCOC } )
    dbSkip()
End

If Len( aVetor ) == 0
   Aviso( cTitulo, "Nao existe dados a consultar", {"Ok"} )
   aRotina := aClone(aOldRotina)   
   Return
Endif

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 320,650 PIXEL

@ 10,10 LISTBOX oLbx  FIELDS HEADER ;
  "C�digo", "Assunto", "Ocorr�ncia" ;      //nome do cabecalho
   SIZE 310,130 OF oDlg PIXEL             

//define com qual vetor devera trabalhar
oLbx:SetArray( aVetor )
//lista o conteudo dos vetores, variavel nAt eh a linha pintada (foco) e o numero da coluna
oLbx:bLine := {|| {aVetor[oLbx:nAt,1],;
                          aVetor[oLbx:nAt,2],;
                          aVetor[oLbx:nAt,3]}}                  

// Duplo clique seleciona e fecha a listbox                   
oLbx:blDblClick := {|| fAtuBrw(@cRetorno ), oDlg:End()}

//Bot�o OK                        
DEFINE SBUTTON FROM 145,253 TYPE 1 ACTION { || fAtuBrw(@cRetorno ), oDlg:End()} ENABLE OF oDlg   

//Bot�o Cancelar
DEFINE SBUTTON FROM 145,283 TYPE 2 ACTION { || fSaiDlg(@cRetorno), oDlg:End()} ENABLE OF oDlg   

//Cria os bot�es
ACTIVATE MSDIALOG oDlg CENTER

CodOcorr := cRetorno

/*
//Chama a rotina PlsTmkOco do PLSxTMK para gravar o atendimento passando o n�mero da B20 ou sai sem fazer nada
If cClique=="C"                // Foi apertado o bot�o de cancelar
    Return
Elseif cClique=="O"   // Apertado o bot�o de OK ou duplo clique
		U_PlsTmkOc(CodOcorr)
Else
	Return // Apertado qualquer outra coisa como o fechar janela	
Endif                                                     
*/

If cClique=="O"   // Apertado o bot�o de OK ou duplo clique
		U_PlsTmkOc(CodOcorr)
Else
	Return // Apertado qualquer outra coisa como o X fechar janela	 ou o bot�o de Cancelar
Endif                                                     
                    
RestArea( aSalvAmb )
RestArea(aAreaSA1)           
RestArea(aAreaBTS)
RestArea(aAreaBA1)

aRotina := aClone(aOldRotina)   

Return

Static Function fAtuBrw(cRetorno)          

    cRetorno:=aVetor[oLbx:nAt,1]    
    cClique:="O"

Return

Static Function fSaiDlg(cRetorno)

    cRetorno:=Nil
    cClique:="C"

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    PlsTmkOco     �Autor  �                  � Data �            ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava Ocorr�ncias de cada Func��o acessada via Tela de     ���
���          �integra��o CALL X PLS                                       ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PlsTmkOco(cFunc)

Local nInd			:= 0 		
Local nLinA,nColA,I	:= 0
Local cAssunto 		:= ""
Local cDesAssu		:= ""
Local cOcorre		:= ""
Local cDesOco		:= ""
Local cOperad		:= __CUSERID
Local cDesOpe		:= CUSERNAME
Local cStatus   	:= SuperGetMV( "MV_PLTKST",.F.,"2")
Local aRet			:= {}
Local aColAux  		:= aClone(aCols)
LOCAL aOldRotina := aClone(aRotina)

DbSelectArea("B20")
B20->(DbSetOrder(1))

If !Empty(cFunc) .and. MsSeek(xFilial("B20")+StrZero(Val(cFunc),6))

	nLinA := Len(aCols) 
	
	If !Empty(aCols[1,PLRETPOS("UD_ASSUNTO",aHeader)])
		
		aadd(aCols,{})
		nLinA++
		
		For nInd :=  1 To Len(aHeader)+1
	
		    If nInd <= Len(aHeader)
		       If     aHeader[nInd,8] == "C"  
		              aadd(aCols[Len(aCols)],Space(aHeader[nInd,4]))  
		       ElseIf aHeader[nInd,8] == "D"                          
		              aadd(aCols[Len(aCols)],ctod(""))  
		       ElseIf aHeader[nInd,8] == "N"                         
		              aadd(aCols[Len(aCols)],0)                        
		       ElseIf aHeader[nInd,8] == "L"                                        
		              aadd(aCols[Len(aCols)],.T.)                                         
		       ElseIf aHeader[nInd,8] == "M"                                        
		              aadd(aCols[Len(aCols)],"")
		       Endif                                         
		    Else                                              
		       aadd(aCols[Len(aCols)],.F.)                                                
		    Endif                                               
		
		Next

 	EndIf

	DbSelectarea("SX5")
	DbSetorder( 1 )		
	If DbSeek( xFilial("SX5")+"T1"+B20->B20_ASSUNT )
		cAssunto 	:= SX5->X5_CHAVE
		cDesAssu	:= X5DESCRI()
	Else
		Help(" ",1,"ASSUNTO" )
		lRet := .F.
	Endif
	
	DbSelectarea("SU9")
	DbSetorder( 1 )
	If DbSeek( xFilial("SU9")+B20->B20_ASSUNT+B20->B20_OCORRE )
		cOcorre	:= SU9->U9_CODIGO
		cDesOco	:= SU9->U9_DESC
	Else
		Help(" ",1,"OCORRENCIA")
		lRet := .F.
	Endif
	
	If ExistBlock("PLTMKOCO")
		                   
		aRet := ExecBlock( "PLTMKOCO",.F.,.F., {cAssunto,cDesAssu,cOcorre,cDesOco,cOperad,cDesOpe,cStatus, cFunc, aCols, aHeader} )
        lRet		:= aRet[1]
		aOcorrencias:= aRet[2]		
		
		If lRet .and. len(aOcorrencias) > 0
			For I:= 1 to Len(aOcorrencias)
				nColA := PLRETPOS(aOcorrencias[I,1],aHeader) 
				If nColA > 0 .and. nColA < (Len(aHeader)+1)
					aCols[nLinA,nColA] := aOcorrencias[I,2]
				EndIf 
			Next
			
		Else
			aCols := aClone(aColAux)
		EndIf
		 		
	Else	
		aCols[nLinA,PLRETPOS("UD_ASSUNTO",aHeader)]	:= cAssunto
		aCols[nLinA,PLRETPOS("UD_DESCASS",aHeader)]	:= cDesAssu
		aCols[nLinA,PLRETPOS("UD_OCORREN",aHeader)] := cOcorre
		aCols[nLinA,PLRETPOS("UD_DESCOCO",aHeader)] := cDesOco
		aCols[nLinA,PLRETPOS("UD_OPERADO",aHeader)] := cOperad
		aCols[nLinA,PLRETPOS("UD_DESCOPE",aHeader)] := cDesOpe
		aCols[nLinA,PLRETPOS("UD_STATUS",aHeader)] 	:= cStatus			
	EndIf

Else 
	aCols 	:= aClone(aColAux)
	MsgAlert("!!PLS x TMK n�o encontrada!!") //"!!PLS x TMK n�o encontrada!!"
EndIf

N	:= Len(aCols)

If	ValType(oGetTmkPls:oBrowse) <> "O"
	oGetTmk:SetArray(aCols)
    oGetTmk:ForceRefresh()
Else
	oGetTmkPls:SetArray(aCols)
	oGetTmkPls:ForceRefresh() 		
EndIf
      
aRotina := aClone(aOldRotina)   

Return
