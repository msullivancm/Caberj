*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | FA080PE  | Autor | Edilson Leal  (Korus Consultoria)       |*
*+------------+------------------------------------------------------------+*
*|Data        | 18.12.2007                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Ponto de entrada na baixa contas a pagar. Cria titulo de   |*
*|            | Despesa Juridica com o valor da baixa, caso Motivo da      |*
*|            | Baixa seja Desp. Juridica.                                 |*
*+------------+------------------------------------------------------------+*
*|Arquivos    | SE2                                                        |*
*+------------+------------------------------------------------------------+*
*|Alteracoes  | 														   |*
*+-------------------------------------------------------------------------+*
*****************************************************************************     

////////////
/*
***********************
User Function F300FIL()  
***********************

	Local lAchou		:= .T.
	Local cTrb			:= GetNextAlias()
	Local aAreaSEA		:= SEA->(GetArea())
	Private lMsErroAuto	:= .F. 
	Private aBaixa		:= {}

	Public  nRecTit     := SE2->(Recno())
	
	SE2->(DbSetOrder(11)) // Filial+IdCnab
 
	If !SE2->(DbSeek(xFilial("SE2")+SubStr(Paramixb[1],1,10)))

		//Se não achou utiliza chave antiga
		SE2->(DbSetOrder(1))

		If !SE2->(DbSeek(xFilial("SE2")+Pad(Paramixb[1],Paramixb[3])))

			lAchou := .F.
			Help("",1,"NOESPECIE",,Paramixb[1],5,1)

			//Localiza o primeiro titulo totalmente baixado para que o Fina300 pule a linha.
			cQry := "SELECT R_E_C_N_O_ REC FROM " + RetSqlName("SE2")
			cQry += " WHERE D_E_L_E_T_ = ' '"
			cQry += "   AND E2_FILIAL = '" + xFilial("SE2") + "'"
			cQry += "   AND E2_SALDO = 0"
			cQry += "   AND ROWNUM   = 1"

			If Select(cTrb) > 0; (cTrb)->(DbCloseArea()); EndIf
			dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), cTrb, .F., .T.)

			(cTrb)->(dbGoTop())

			If (cTrb)->(!Eof())
				SE2->(DbGoTo((cTrb)->REC))
			EndIf

			(cTrb)->(dbCloseArea())
		EndIf
	EndIf
 
	If lAchou
		If AllTrim(cRetorno) == "DV" .And. !Empty(SE2->E2_BAIXA)
			nRecSE2		:= SE2->(Recno())
			cAutMotbx	:="NORMAL"
			cHistBx		:= "Cancelamento de Baixa"
			aBaixa		:={}

			dDataOld  := dDataBase
			dDataBase := SE2->E2_BAIXA

			aAdd(aBaixa, {"E2_PREFIXO"	, SE2->E2_PREFIXO			, Nil})
			aAdd(aBaixa, {"E2_NUM"		, SE2->E2_NUM				, Nil})
			aAdd(aBaixa, {"E2_PARCELA"	, SE2->E2_PARCELA			, Nil})
			aAdd(aBaixa, {"E2_TIPO"		, SE2->E2_TIPO				, Nil})
			aAdd(aBaixa, {"E2_FORNECE"	, SE2->E2_FORNECE			, Nil})
			aAdd(aBaixa, {"E2_LOJA"		, SE2->E2_LOJA				, Nil})
			aAdd(aBaixa, {"AUTHIST"		, cHistBx					, Nil})
			aAdd(aBaixa, {"AUTVLRPG"	, SE2->(E2_VALOR-E2_SALDO)	, Nil})

			Begin Transaction

			MsExecAuto({|x,y|FINA080(x,y)},aBaixa,5)

			Pergunte("AFI300", .F.)   

			If lMSErroAuto
				MostraErro()
				dDataBase := dDataOld
				Return .F.
			EndIf

			SEA->(DbSetOrder(1))
			If SEA->(DbSeek(xFilial("SEA")+SE2->(E2_NUMBOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
				RecLock("SEA", .F.)
				SEA->(DbDelete())
				SEA->(MsUnlock())

				SE2->(dbGoTo(nRecSE2))
				RecLock("SE2", .F.)
				SE2->E2_NUMBOR  := Space(Len(SE2->E2_NUMBOR))
				SE2->E2_PORTADO := Space(Len(SE2->E2_PORTADO))
				SE2->(MsUnlock())
			EndIf

			dDataBase := dDataOld

			End Transaction
		EndIf
	EndIf

	RestArea(aAreaSEA)
Return
         



*///////////////////////
    #include "rwmake.ch"
    #include "protheus.ch"
    #include "topconn.ch"
    
    User Function CABADPJ(cPref ,cNum,cParc,cTipo,cFornec,cLoja)

    Private lMsErroAuto := .F.   
    private adados := {}     
    private vlrbxa := 0.00


    dbSelectArea("SE2")
    SE2->(dbSetOrder(1))
    SE2->(dbGoTop())      
    //U_CABADPJ(TMP->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA))  
    If SE2->(dbSeek(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja)) 
       if SE2->E2_SALDO > 0

          fConsDpj(cFornec)    
    
          For i:= 1 to i >  len(adados) .and. SE2->E2_SALDO > 0
 
             vlrbxa:= (SE2->E2_SALDO * (adados[i,3])/100)                                                        

             If adados[i,4] < ( adados[i,5]+ cVlrbxa )
                vlrbxa:= adados[i,4] -  adados[i,5]
             endIf   
             
             cHistBaixa := str(adados[i,1],6,0) + "Bx. Automat. DPJ"
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
    //³Monta array com os dados da baixa a pagar do título³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
             aBaixa := {}
             AADD(aBaixa, {"E2_FILIAL" , xFilial("SE2") , Nil})
             AADD(aBaixa, {"E2_PREFIXO" , cPref , Nil})
             AADD(aBaixa, {"E2_NUM" , cNUM , Nil})
             AADD(aBaixa, {"E2_PARCELA" , cParc , Nil})
             AADD(aBaixa, {"E2_TIPO" , cTIPO , Nil})
             AADD(aBaixa, {"E2_FORNECE" , cFornec , Nil})
             AADD(aBaixa, {"E2_LOJA" , cLoja , Nil}) 
             AADD(aBaixa, {"AUTMOTBX" , "COMP. CR " , Nil})
             AADD(aBaixa, {"AUTBANCO" , "001" , Nil})
             AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
             AADD(aBaixa, {"AUTCONTA" , "000001 " , Nil})
             AADD(aBaixa, {"AUTDTBAIXA" , dDataBase , Nil}) 
             AADD(aBaixa, {"AUTDTCREDITO", dDataBase , Nil})
             AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
             AADD(aBaixa, {"AUTVLRPG" , vlrbxa , Nil})
             ACESSAPERG("FIN080", .F.)
             
             MSEXECAUTO({|x,y| FINA080(x,y)}, aBaixa, 3)

             If lMsErroAuto
                MOSTRAERRO() 
                Return .F.
             Else
                fgravadpj(str(adados(i,1),6,0),vlrbxa,(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja))
     			Alert("Baixa realizada, verifique a SE5")
    		    SE2->(dbSeek(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja)) 
			 EndIf
			  
	      Next
	      	 
       Else
           Alert("O título não possui saldo a pagar em aberto")
       EndIf 
    Else
        Alert("O título a pagar não foi localizado")
    EndIf
Return()            


////////grava atuaização do DPJ
Static function fgravadpj(nIdDpj,cVlrbxa,cTit)   

	dbselectarea("PC4")
	PC4->(DbSetOrder(1))   
    dbSeek(xFilial("PC4")+str(nIdDpj,6,0))    
    
     PC4->PC4_VLRLIM:=(PC4->PC4_VLRRET + cVlrbax)
     if PC4->PC4_VLRLIM == PC4->PC4_VLRRET 
        PC4->PC4_DTFIM  := dDatabase
        PC4->PC4_ATVDPJ := .F. 
        PC4->PC4_OBSDPJ += CRLF+'Titulo DPJ - '+ cTit
     endIf                 

            RecLock("PC4",.F.)     
	        fMVarArq()
	        Msunlock("PC4")    
            

Return()           

///Consulta Padrao DPJ
Static function fConsDpj(cFornec)    

local ret        := 0
local cAliastmp  := GetNextAlias()  
Private cQuery   := " "   

cQuery := "select * "
cQuery += CRLF+ " from  " + RetSqlName("PC4") +" PC4 "
cQuery += CRLF+ " where PC4_filial = '"+xFilial('PC4')+ "' and PC4.d_E_L_E_T_ = ' ' "  
cQuery += CRLF+ " PC4_CODFOR = '"+cFornec+"' "   
cQuery += CRLF+ " PC4_VLRLIM > PC4_VLRRET "  
cQuery += CRLF+ " PC4_DTINC  <= '"+dDatabase+"' "
cQuery += CRLF+ " PC4_DTFIM  = ' ' "   
cQuery += CRLF+ " PC4_ATVDPJ = 'T' "
cQuery += CRLF+ " PC4_FINDPJ = 'T' "
cQuery += CRLF+ " PC4_PRCDPJ > 0 "

                                                                                           
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

TCQuery cQuery New Alias (cAliastmp)   
    
     dbSelectArea(cAliastmp) 
    
     (cAliastmp)->( DbGoTop() )      
     (cAliastmp)->(dbGoTop())                    
     While !((cAliastmp)->(Eof()))                                  
    
       aAdd(aDados, {(cAliastmp)->PC4_IDDPJ  , ;
                     (cAliastmp)->PC4_CODFOR , ;
                     (cAliastmp)->PC4_PRCDPJ , ;
                     (cAliastmp)->PC4_VLRLIM , ;
                     (cAliastmp)->PC4_VLRRET  }) 
  
       (cAliastmp)->(DbSkip())
   
     EndDo 
    
	(cAliastmp)->(DbCloseArea())
			
Return( adados )  


/*
#Include "Rwmake.ch"
#Include "Topconn.ch"

/*
************************
User Function FA080PE() 
************************
 
 Private aArea := GetArea()
 Private cTrb  := GetNextAlias()
 Private cQry  := ""
 Private aTit  :={}

 If TrazCodMot(cMotBx) <> "DPJ"
    Return 
 EndIf
 
 cQry := " SELECT E2_NUM "
 cQry += " FROM "+RetSqlName("SE2") 
 cQry += " WHERE D_E_L_E_T_ <> '*'"
 cQry += "    AND E2_FILIAL  = '"+xFilial("SE2")+"'"
 cQry += "    AND E2_NUM     = '"+SE2->E2_NUM+"'"
 cQry += "    AND E2_PREFIXO = 'DPJ'" 
 cQry += "    AND E2_PARCELA = '"+SE2->E2_PARCELA+"'"
 cQry += "    AND E2_TIPO    = 'DP'"  
 cQry += "    AND E2_FORNECE = '"+SE2->E2_FORNECE+"'"
 cQry += "    AND E2_LOJA    = '"+SE2->E2_LOJA+"'"                                        
 
 cQry += "    AND E2_HIST    = '"+Hist070 +"'"  

 If Select((cTrb)) > 0;(cTrb)->(DbCloseArea());EndIf 
 DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), cTrb, .F., .T.)    
 (cTrb)->(DbGoTop())
 
 If (cTrb)->(!Eof())
    MsgBox("ATENÇÃO : já existe este titulo como Despesa Juridica !!! DPJ não gerado. Verifique.")
    If Select(cTrb)>0;(cTrb)->(DbCloseArea());EndIf 
    Return 
 EndIf 
 
 AADD(aTit,{"E2_NUM"    ,SE2->E2_NUM                      ,NIL})
 AADD(aTit,{"E2_PREFIXO","DPJ"                            ,NIL})
 AADD(aTit,{"E2_PARCELA",SE2->E2_PARCELA                  ,NIL})
 AADD(aTit,{"E2_TIPO"   ,"DP"                             ,NIL})
 AADD(aTit,{"E2_NATUREZ","12605"                          ,NIL})
 AADD(aTit,{"E2_FORNECE",SE2->E2_FORNECE                  ,NIL})
 AADD(aTit,{"E2_LOJA"   ,SE2->E2_LOJA                     ,NIL})
 AADD(aTit,{"E2_EMISSAO",dDataBase                        ,NIL})
 AADD(aTit,{"E2_VENCTO" ,dDataBase+30                     ,NIL})
 AADD(aTit,{"E2_VENCREA",dDataBase+30                     ,NIL})
 AADD(aTit,{"E2_VALOR"  ,nValPgto                         ,NIL})               
 AADD(aTit,{"E2_VLCRUZ" ,nValPgto                         ,NIL}) 
 AADD(aTit,{"E2_HIST"   ,cHist070                         ,NIL})
 AADD(aTit,{"E2_CCD"    ,"998"                            ,NIL})
 AADD(aTit,{"E2_YNPARCE",SE2->E2_YNPARCE                  ,NIL}) 
 
 lMsErroAuto:=.F.
 lRetF050   :=.T.

 Begin Transaction    
    MSExecAuto({|x,y| FINA050(x,y)}, aTit, 3)
    If lMsErroAuto
       DisarmTransaction()    
    EndIf 
 End Transaction
 
 If lMsErroAuto
    lRetF050:=.F.
    MostraErro()
 EndIf
 
 If lMsErroAuto
    MsgBox("Não foi possivel criar o titulo de Despesa Juridica !!! Entre em contato com o Administrador do Sistema.")    
 Else
    MsgInfo("Titulo de Despesa Juridica criado com sucesso !!!") 
 EndIf
 
 If Select(cTrb) > 0;(cTrb)->(DbCloseArea());EndIf 
 
 RestArea(aArea) 
 
Return
