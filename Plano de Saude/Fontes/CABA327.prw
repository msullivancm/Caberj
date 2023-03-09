#include "PLSA090.ch" 
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"    

#DEFINE c_ent CHR(13) + CHR(10) 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA327   บMotta  ณCaberj              บ Data ณ  jan/14     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Realiza a baixa de titulos de Colaboradores com base nas   บฑฑ
ฑฑบ          ณ verbas da GPE utilizadas                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/        
    
User Function CABA327()

Private aBaixa		:= {}                
Private aErrImp	    := {}       
PRIVATE cPerg	    := "CAB327"   
PRIVATE cTitulo     := "Baixa Tit. Colaborador"
Private nTotBaixas	:= 0

AjustaSX1(cPerg)

If Pergunte(cPerg,.T.)
	Processa({|| Processa1() }, cTitulo, "", .T.)  
EndIf
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ                    บ Data ณ  jan/14     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local cSQLGPE := " " 
	Local cSQLPLS := " "    
	Local cRefGPE := " "     
	Local cRefPLS := " "  
	Local dDatBai := CtoD("  /  /    ")   
	
    Local dRefGPE := CtoD("  /  /    ")     
	Local dRefPLS := CtoD("  /  /    ")   
	
	Local nValGPE := 0
	Local nValor  := 0          
	
	Local lExc    := .F. //Apenas regera excel
	
	//sql do gpe count	  
	
	cRefGPE := AllTrim(mv_par01)    
	cRefPLS := AllTrim(mv_par02)   
	dDatBai := mv_par03   
	lExc    := (mv_par04 == 1)
	
	//Valida Parametros
	If (len(cRefGPE) <> 6 .OR. len(cRefPLS) <> 6)
	  Alert("Parametro(s) Invalido(s) !!")
	  Return
	Else
	  For i:=1 to Len(cRefGPE) 
	    If !(Substr(cRefGPE,i,1) $ "1234567890")    
	      Alert("Parametro(s) Invalido(s) , Referencia GPE !!")
	      Return
	    Endif  
	  Next  
	  For i:=1 to Len(cRefPLS) 
	    If !(Substr(cRefPLS,i,1) $ "1234567890")    
	      Alert("Parametro(s) Invalido(s) , Referencia PLS !!")
	      Return
	    Endif  
	  Next  
	  dRefGPE := StoD(cRefGPE+"01")     
	  dRefPLS := StoD(cRefPLS+"01")    
	  If ((dRefPLS - dRefGPE) < 28 .OR. (dRefPLS - dRefGPE) > 31) 
	    Alert("Parametro(s) Invalido(s) , Referencia GPE x PLS !!")
	    Return
	  Endif
	Endif       
	
	if !(lExc)
		If dDatBai > dDataBase
		  Alert("Parametro(s) Invalido(s) , Data de baixa futura !!")
		  Return
		Endif 
		
		If Empty(dDatBai)
		  Alert("Parametro(s) Invalido(s) , Data de baixa vazia !!")
		  Return
		Endif 
	Endif	 
	
	If lExc 
	  GeraExcel(cRefPLS,cRefGPE) 
	  Return
	Endif;
	
	If !MsgYesNo("Confirma Rotina de Baixa de Colaborador para o Referencia GPE " + cRefGPE +;
	             " e Referencia PLS " + cRefPLS + " Data de Baixa " + DToC(dDatBai) + " ?")	  
	  	Return             
	EndIf  	
	                                    
	/*
	LER SQL COM AS VERBAS UTILIZADAS (SRD) NO GPE
	*/
	cSQLGPE := " SELECT RD_MAT , "  
	cSQLGPE += "        SUM(CASE WHEN RV_TIPOCOD ='1' THEN (-1 * RD_VALOR) ELSE RD_VALOR END) VALOR "
	cSQLGPE += " FROM " + RetSQLName("SRD") + " SRD," + RetSQLName("SRV") + " SRV " 
	cSQLGPE += " WHERE  SRD.D_E_L_E_T_ = ' ' " 
	cSQLGPE += " AND    SRD.D_E_L_E_T_ = ' ' "  
	cSQLGPE += " AND    RD_FILIAL = '01' "  
	cSQLGPE += " AND    RV_FILIAL = '  ' "  
	//cSQLGPE += " AND    RD_MAT = '000043' " - Angelo Henrique - Data:16/05/19 - Conversado com o Paulo Motta sobre essa Matricula.  
	cSQLGPE += " AND    RV_COD = RD_PD "  
	cSQLGPE += " AND    RD_DATARQ = '" + cRefGPE + "' " 
	//cSQLGPE += " AND    RD_PD IN ('460','451','145','146','148','445','484','485','500','501','502','503','504','505') "  
	cSQLGPE += " AND    RD_PD IN ('485','460','451','145','146','148','445','484','500','501','502','503','504','505','473','511','474','512','510') "  
	cSQLGPE += " GROUP BY RD_MAT "  
	cSQLGPE += " ORDER BY 1,2 "  
	
	PLSQuery(cSQLGPE,"TRBGPE")		
	
	TRBGPE->(DbGotop())    
	
	While !TRBGPE->(Eof()) 
	
	    /*
	     LER SQL COM OS TITULOS GERADOS NO PLS
	    */
	    cSQLPLS := " SELECT  E1_PREFIXO , E1_NUM, E1_PARCELA , E1_TIPO , E1_SALDO "  
	    cSQLPLS += " FROM  " + RetSQLName("SE1") + " E1," + RetSQLName("BA3") + " BA3 " 
	    cSQLPLS += " WHERE  E1.D_E_L_E_T_ = ' '  "    
	    cSQLPLS += " AND    BA3.D_E_L_E_T_ = ' '  "            
	    cSQLPLS += " AND    E1_FILIAL = '01' "    
	    cSQLPLS += " AND    BA3_FILIAL = ' '  "            
	    cSQLPLS += " AND    BA3_CODINT = E1_CODINT  "    
	    cSQLPLS += " AND    BA3_CODEMP = E1_CODEMP  "            
	    cSQLPLS += " AND    BA3_MATRIC = E1_MATRIC  "    
	    cSQLPLS += " AND    BA3_CODEMP = '0003'  "            
	    cSQLPLS += " AND    E1_PREFIXO = 'PLS'  "    
	    cSQLPLS += " AND    E1_ORIGEM = 'PLSA510'  "   
	    cSQLPLS += " AND    E1_VALOR = E1_SALDO " // NAO REALIZA BAIXA COMPLMENTAR   
	    cSQLPLS += " AND    E1_PORTADO = ' ' "    // SEM ESTAR EM BANCO           
	    cSQLPLS += " AND    SIGA_RET_SIT_TIT_PRXREA('C',E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO) NOT IN ('CAN') "
	    cSQLPLS += " AND    BA3_AGMTFU = '" + TRBGPE->RD_MAT + "' "       
	    cSQLPLS += " AND    E1_ANOBASE||E1_MESBASE = '" + cRefPLS + "' "    
	    cSQLPLS += " ORDER BY 1,5 DESC  "            
	    cSQLPLS += "   "    
	
	    PLSQuery(cSQLPLS,"TRBPLS")		
	
	    nValGPE := TRBGPE->VALOR;
	    
	    TRBPLS->(DbGotop())
	
     	While !TRBPLS->(Eof())      
     	
			//trata titulo      
			if nValGPE > 0        
				If TRBPLS->E1_SALDO > nValGPE
				  nValor := nValGPE
				Else  
				  nValor := TRBPLS->E1_SALDO
				end if    
				
				aAdd(aBaixa,{"BNF",TRBPLS->E1_PREFIXO,TRBPLS->E1_NUM,TRBPLS->E1_PARCELA,TRBPLS->E1_TIPO ,dDatBai,"BX. AUTOM. FUNCIONARIOS. " + cRefGPE,nValor,{{cRefGPE,nValor}}})
				
				nValGPE := (nValGPE - nValor)		
		  	end if		
		
			TRBPLS->(DbSkip())	
		Enddo
	
		TRBPLS->(DbCloseArea())	
		
		TRBGPE->(DbSkip())	
		
	Enddo
	
	ProcRegua(TRBGPE->(LastRec()))
	
	TRBGPE->(DbCloseArea())
	
	cChaveTit := ""
	

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Ultimo registro...                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Len(aBaixa) > 0
		BxTitulo()
		aBaixa := {}
	Endif
	
	ProcRegua(Len(aBaixa))

	If Len(aErrImp) > 0
		PLSCRIGEN(aErrImp,{ {"Descri็ใo da crํtica","@C",300}},"Crํticas encontradas / Importa็ใo...",.T.)
	Endif        

	aErrImp		:= {}
	aBaixa		:= {}
	aParcela	:= {}
	aDadUsr		:= {}        
	
	
	If MsgYesNo("Gera Planilha Excel com posicao do Titulos?","Aten็ใo")
	  GeraExcel(cRefPLS,cRefGPE)  
	endif  

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBxTitulo  บAutor  ณMicrosiga           บ Data ณ  jan/14     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBaixa de titulo individual, para melhorar performance do    บฑฑ
ฑฑบ          ณsistema.                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BxTitulo()
	Local aAreaZZ5 := ZZ5->(GetArea())
	Local nCont2	:= 0
	Local _cRecSE1	:= 0
    local i__f
    local nCont


//	ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//	ณ Inicia a transacao / garantia de integridade na baixa do arquivo... ณ
//	ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Begin Transaction 

//	ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//	ณ Baixar os titulos conforme matriz de baixa...                       ณ
//	ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	For nCont := 1 to Len(aBaixa)
	
//		ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ----ฤฤฤ---ฤฟ
//		ณ Verificar se o titulo possui alguma composicao como baixa nao finaceira.   ณ
//		ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ----ฤ---ฤฤฤฤู	
		nPos := Ascan( aBaixa, { |x| x[1] == "BNF" } )	
	
//		ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//		ณ Caso nenhuma baixa ok seja encontrada, nao realizar operacao nenhumaณ
//		ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
		lBaixou := .F.
		lSemTit := .F.
	
		If nPos > 0
			lBaixou := BaixaTitulo(aBaixa[nCont,1],aBaixa[nCont,2],aBaixa[nCont,3],aBaixa[nCont,4],aBaixa[nCont,5],aBaixa[nCont,6],aBaixa[nCont,7],aBaixa[nCont,8])
		Else
			aadd(aErrImp,{"Nenhuma baixa autorizada no tํtulo: "+aBaixa[nCont,2]+aBaixa[nCont,3]+aBaixa[nCont,4]+aBaixa[nCont,5]})
			lSemTit := .T.
		Endif
		
		If lBaixou
			nTotBaixas += aBaixa[nCont,8]
		EndIf
			
		If aBaixa[nCont,1] == "NEG" .And. !lSemTit
			cAnoMesAd := U_SomaComp(Substr(DtoS(dDataBase),1,6))
			aadd(aParcela,{cAnoMesAd,aBaixa[nCont,8],"",GetNewPar("MV_YCDLNEG","999"),"","","LANCTO AUTOMATICO RIO PREV."})
			aDadUsr := {cCodInt,cCodEmp,cMatric,cConEmp,cVerCon,cSubCon,cVerSub,"",cBsqUsu}
			If !U_GerAdNeg(aParcela,aDadUsr,SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))
				MsgAlert("Impossํvel criar adicional para o(s) mes(es) solicitado(s) . Verifique!")
			Endif			
		Endif					
	Next

	End Transaction
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณBaixaTituloบ Autor ณ                   บ Data ณ  jan/14     บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Baixa de titulo financeiro, conforme parametros...         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function BaixaTitulo(cMotBx,cPrefixo,cNumero,cParcela,cTipo,dDtBaixa,cHisBaixa,nVlrBaixa)
	Local lRet := .F.

	Private lmsErroAuto := .f.
	Private lmsHelpAuto := .t. // para mostrar os erros na tela

	If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo))

		If SE1->E1_SALDO > 0
			nVlrBaixa := If(nVlrBaixa > SE1->E1_SALDO, SE1->E1_SALDO, nVlrBaixa)
			//SA6->(DbSetOrder(1)) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
			//SA6->(MsSeek(xFilial("SA6")+cBanco+cAgencia+cConta))

			aCamposSE5 := {}
			aAdd(aCamposSE5, {"E1_FILIAL"	, xFilial("SE1")	, Nil})
			aAdd(aCamposSE5, {"E1_PREFIXO"	, cPrefixo			, Nil})
			aAdd(aCamposSE5, {"E1_NUM"		, cNumero			, Nil})
			aAdd(aCamposSE5, {"E1_PARCELA"	, cParcela			, Nil})
			aAdd(aCamposSE5, {"E1_TIPO"		, cTipo				, Nil})
			aAdd(aCamposSE5, {"E1_LOTE"		, " "				, Nil})
			aAdd(aCamposSE5, {"AUTMOTBX"	, cMotBx			, Nil})
			aAdd(aCamposSE5, {"AUTDTBAIXA"	, dDtBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTDTCREDITO", dDtBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTHIST"		, cHisBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTVALREC"	, nVlrBaixa			, Nil})
			//aAdd(aCamposSE5, {"AUTBANCO"	, SA6->A6_COD		, Nil})
			//aAdd(aCamposSE5, {"AUTAGENCIA"	, SA6->A6_AGENCIA	, Nil})
			//aAdd(aCamposSE5, {"AUTCONTA"	, SA6->A6_NUMCON	, Nil})

			msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 3)

			If lMsErroAuto
				lRet := .F.
				aadd(aErrImp,{"Ocorreu um erro na baixa do titulo "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
				MostraErro()
			Else
				lRet := .T.
			EndIf
		Else
			aadd(aErrImp,{"O titulo encontra-se baixado. "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
		Endif
	Endif
Return lRet    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณGeraExcel บAutor  ณ                      บ Data ณ jan/14    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Gera planilha excel resumo                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraExcel(cRefPLS,cRefGPE) 

Local aCabec := {}
Local aDados := {} 

Local cTab327 := " "  
Local cEmp327 := " "      
Local nI 	  := 0              

  //Monta query 
  cQuery := " SELECT BA3_AGMTFU , BA1_NOMUSR , E1_PREFIXO , E1_NUM, E1_PARCELA , E1_TIPO , E1_PORTADO , E1_VALOR, E1_SALDO   " + c_ent
  cQuery += " FROM   " + RetSqlName("SE1") + " E1, " + RetSqlName("BA3") + " BA3, " + RetSqlName("BA1") + " BA1  " + c_ent   
  cQuery += " WHERE  E1.D_E_L_E_T_ = ' ' " + c_ent 
  cQuery += " AND    BA3.D_E_L_E_T_ = ' ' " + c_ent 
  cQuery += " AND    BA1.D_E_L_E_T_ = ' ' " + c_ent 
  cQuery += " AND    E1_FILIAL = '01'" + c_ent 
  cQuery += " AND    BA3_FILIAL = ' '" + c_ent 
  cQuery += " AND    BA3_CODINT = E1_CODINT" + c_ent 
  cQuery += " AND    BA3_CODEMP = E1_CODEMP" + c_ent 
  cQuery += " AND    BA3_MATRIC = E1_MATRIC" + c_ent 
  cQuery += " AND    BA1_CODINT = E1_CODINT" + c_ent 
  cQuery += " AND    BA1_CODEMP = E1_CODEMP" + c_ent  
  cQuery += " AND    BA1_MATRIC = E1_MATRIC" + c_ent 
  cQuery += " AND    BA1_TIPUSU = 'T'" + c_ent 
  cQuery += " AND    BA3_CODEMP = '0003'" + c_ent  
  cQuery += " AND    E1_ORIGEM = 'PLSA510'" + c_ent             
  cQuery += " AND    SIGA_RET_SIT_TIT_PRXREA('C',E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO) NOT IN ('CAN') " + c_ent    
  cQuery += " AND    E1_ANOBASE||E1_MESBASE = '" + cRefPLS + "' " + c_ent   
  cQuery += " ORDER BY 1,7 DESC" + c_ent      
  
  If Select("R327") > 0
	dbSelectArea("R327")
	dbCloseArea()
  EndIf

  DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R327",.T.,.T.)         

  For nI := 1 to 5
    IncProc('Processando...')
  Next	
	
	If ! R327->(Eof())
		nSucesso := 0
		aCabec := {"REF PLS","REF GPE","FUNCIONAL","NOME TITULAR","TITULO","BANCO","VALOR","SALDO"}
		
		R327->(DbGoTop())
		While ! R327->(Eof()) 
			IncProc()
			
			aaDD(aDados,{cRefPLS,cRefGPE,R327->BA3_AGMTFU , R327->BA1_NOMUSR,R327->E1_PREFIXO+R327->E1_NUM+R327->E1_PARCELA+R327->E1_TIPO,R327->E1_PORTADO,R327->E1_VALOR,R327->E1_SALDO}) 
			
			R327->(DbSkip())
		End
		 
		//Abre excel 
	    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})
	
	EndIf	
	
	If Select("R327") > 0
		dbSelectArea("R327")
		dbCloseArea()
	EndIf      

Return  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณ                      บ Data ณ jan/14    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Cria / ajusta as perguntas da rotina                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg) 

Local aHelpPor := {}
//Monta Help
Aadd( aHelpPor, 'Informe a Referencia no Formato ' ) 
Aadd( aHelpPor, 'AAAAMM, a Referencia Folha e sempre ' )
Aadd( aHelpPor, 'um mes posterior a Referencia PLS' ) 
Aadd( aHelpPor, 'Informe sim para apenas Regerar Excel' )
                                                                                          
PutSx1(cPerg,"01",OemToAnsi("Referencia Folha     :"),"","","mv_ch1","C",6,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Referencia PLS       :"),"","","mv_ch2","C",6,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Data da Baixa        :"),"","","mv_ch3","D",8,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"04",OemToAnsi("Apenas Regerar Excel :"),"","","mv_ch4","N",1,0,0,"C","","","","","mv_par04","Sim","","","","Nao","","","","","","","","","","","",{},{},{}) 

PutSX1Help("P."+cPerg+"01.",aHelpPor,{},{})
PutSX1Help("P."+cPerg+"02.",aHelpPor,{},{})
    
Return
