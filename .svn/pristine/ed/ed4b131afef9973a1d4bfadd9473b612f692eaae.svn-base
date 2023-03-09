
/*/

Autor     : Ronaldo Pena
-----------------------------------------------------------------------------
Data      : 20/09/2007
-----------------------------------------------------------------------------
Descricao : Relatorio de Retencoes
-----------------------------------------------------------------------------
Partida   : Menu de Usuario

/*/

#Define CRLF Chr(13)+Chr(10)
#include "rwmake.ch"
#include "TopConn.ch"
#Include "Fileio.ch"
#Include "Colors.ch"                                       
#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}


**********************
User Function CAB003()
**********************
private cChaveE5  := " " 
Private lExibeINS := .F.
Private cPerg     := "CAB003"
Private cFilePath := GetMV("MV_XXDIRPA", .F., "C:\MICROSIGA\")+cPerg+".CSV"   
private nVlInss   :=  0

Private  nTotIn20p := 0.00

private aVetRda	:= {'003123','003182','003867','006483','012513','013943','015180','015776','016535','018686','019216','019860','022586','022683','023752','023795','024058',;
							 '026000','027332','028878','030422','033766','034860','036986','037575','038539','039284','039764','041289','044148','044393','046663','046841','049255','050474','052329','052795','053929','053953',; 
							 '057703','062685','063827','064661','065110','066915','068861','072311','074357','076350','082120','085642','086835','087130','087360','088056',;
							 '088129','092126','092410','092754','093050','099350','099759','101435','102156','102407','102890','103055','103403','104159','104710','104930','104949','105040','105058','105163',; 
							 '105180','105198','105325','105376','105597','105953','106968','108375','108561','108740','111317','111740','111856','112917','114367','115266','115320','116424','118249','119601','120316','120898','122220',;
							 '124249','124257','124370','124508','124591','124788','125326','125385','125415','126063','126284','127361','127868','128198','128201','128210','128368','129380','129941','129976',;
							 '127809'}

aSx1  := {}
Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3","DEF01","DEF02"     ,"DEF03" ,"DEF04"  ,"DEF05"})
Aadd(aSx1,{cPerg  ,"01"   ,"Data de Baixa De... ?","mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"02"   ,"Data de Baixa Ate.. ?","mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"03"   ,"Origem............. ?","mv_ch3" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par03",""  ,"PLS"  ,"Financeiro","Ambos" ,""       ,""     })
Aadd(aSx1,{cPerg  ,"04"   ,"Gerar "+cPerg+".CSV ?","mv_ch4" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par04",""  ,"Sim"  ,"Nao"       ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"05"   ,"Prestador P.Física  ?","mv_ch5" ,"C"   ,80       ,0        ,"G"  ,""     ,"mv_par05",""  ,"189688|INPUXG|INPWME"  ,"","" ,""       ,""     })

fCriaSX1(cPerg,aSX1)

SetMVValue("CAB003","MV_PAR05","189688|INPUXG|INPWME")

If !Pergunte(cPerg,.T.)
	Return
Endif

fFiltragem()

Return

***************************
Static Function fProcessa()
***************************

Private cCampoImp := ""

cFiltro := Substr(cFiltro,1,1)
if cFiltro == "1"; cCampoImp := "E2_IRRF"    ; Endif
if cFiltro == "2"; cCampoImp := "E2_INSS"    ; Endif
if cFiltro == "3"; cCampoImp := "E2_VRETPIS"     ; Endif
if cFiltro == "4"; cCampoImp := "E2_VRETCOF"  ; Endif
if cFiltro == "5"; cCampoImp := "E2_VRETCSL"    ; Endif
if cFiltro == "6"; cCampoImp := "E2_ISS"     ; Endif

cQry :=        " SELECT SE2.R_E_C_N_O_ RECSE2 , E2_CODRET, A2_NOME"
cQry += CRLF + " FROM " + RetSqlName("SE2") +" SE2"
cQry += CRLF + " LEFT JOIN " + RetSqlName("SA2") +" SA2"
cQry += CRLF + " ON E2_FORNECE = A2_COD"
cQry += CRLF + " AND E2_LOJA   = A2_LOJA  AND SA2.d_e_l_e_t_ = ' ' "
cQry += CRLF + " WHERE E2_FILIAL   = '"+xFilial("SE2") +"'"
cQry += CRLF + "   And SE2.D_E_L_E_T_ <> '*' "
cQry += CRLF + "   And E2_BAIXA   >= '"+Dtos(mv_par01)+"'"
cQry += CRLF + "   And E2_BAIXA   <= '"+Dtos(mv_par02)+"'"
cQry += CRLF + "   And E2_SALDO    = 0"          

//cQry += CRLF + "   And E2_num    in ('000023268') and e2_prefixo = 'CON' "    

If mv_par03 == 1
	cQry += CRLF + "   And E2_ORIGEM = 'PLSMPAG'"
ElseIf mv_par03 == 2
	cQry += CRLF + "   And E2_ORIGEM <> 'PLSMPAG'"
Endif

if cFiltro != "2"
	cQry += CRLF + "   And "+cCampoImp+" > 0"
endif

cQry += CRLF + "   ORDER BY E2_CODRET, A2_NOME"  
/*
//// ALTAMIRO EM 07/08/09 ///
/// para nao sair tit. de impostos baixados antes do principal /////
cQry :=        " SELECT SE2.R_E_C_N_O_ RECSE2 , E2_CODRET, A2_NOME"
cQry += CRLF + " FROM " + RetSqlName("SE2") +" SE2"
cQry += CRLF + " LEFT JOIN " + RetSqlName("SA2") +" SA2"
cQry += CRLF + " ON E2_FORNECE = A2_COD"
cQry += CRLF + " AND E2_LOJA   = A2_LOJA"
cQry += CRLF + " WHERE E2_FILIAL   = '"+xFilial("SE2") +"'"
cQry += CRLF + "   And SE2.D_E_L_E_T_ <> '*' "
cQry += CRLF + "   And E2_BAIXA   >= '"+Dtos(mv_par01)+"'"
cQry += CRLF + "   And E2_BAIXA   <= '"+Dtos(mv_par02)+"'"
cQry += CRLF + "   And E2_SALDO    = 0"
If mv_par03 == 1
	cQry += CRLF + "   And E2_ORIGEM = 'PLSMPAG'"
ElseIf mv_par03 == 2
	cQry += CRLF + "   And E2_ORIGEM <> 'PLSMPAG'"
Endif
if cFiltro != "2"
	cQry += CRLF + "   And "+cCampoImp+" > 0"
endif
cQry += CRLF + "and exists ( select null "
cQry += CRLF + " FROM " + RetSqlName("SE2") +" SE22" 
cQry += CRLF + " WHERE se22.E2_FILIAL   = '"+xFilial("SE2") +"'"
cQry += CRLF + "   And SE22.D_E_L_E_T_ <> '*' "
cQry += CRLF + "   And se22.E2_PREFIXO =  se2.E2_PREFIXO"
cQry += CRLF + "   And se22.E2_NUM = se2.e2_num
cQry += CRLF + "   And se22.E2_TIPO = 'TX'
if cFiltro == "1"    // "E2_IRRF"    
   cQry += CRLF + "   And se22.E2_PARCELA = SE2.E2_PARCIR"
elseif cFiltro == "2"// "E2_INSS"    
   cQry += CRLF + "   And se22.E2_PARCELA = SE2.E2_PARCINS"
elseif cFiltro == "3"// "E2_PIS" 
   cQry += CRLF + "   And se22.E2_PARCELA = SE2.E2_PARCPIS"
elseif cFiltro == "4"// "E2_COFINS" 
   cQry += CRLF + "   And se22.E2_PARCELA = SE2.E2_PARCCOF"
elseif cFiltro == "5"// "E2_CSLL"   
   cQry += CRLF + "   And se22.E2_PARCELA = SE2.E2_PARCSLL"
elseif cFiltro == "6"// "E2_ISS"  
   cQry += CRLF + "   And se22.E2_PARCELA = SE2.E2_PARCISS"             
endif
   cQry += CRLF + "   And SE22.E2_BAIXA = ' ' )  
cQry += CRLF + "   ORDER BY E2_CODRET, A2_NOME"  
///////////////////////////////////////////////
*/
//cQry := ChangeQuery(cQry)

MemoWrit(cPerg+".Sql",cQry)

If TcSqlExec(cQry) < 0
	MsgInfo("Erro na seleção de Registros !!!")
	lContinua := .F.
	Return
Endif

If Select("QRY") > 0 ; QRY->(DbCloseArea()) ; Endif
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'QRY', .F., .T.)

RptStatus({|| fImprime()},"Aguarde a Impressao...")

Return


**************************
Static Function fImprime()
**************************

Local B 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nTemp := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private nTemp, nTotal :=0
Private lImpFirst     := .F.

cNomeProg := "CAB003.PRG"
cTitRel1  := "Analise de Impostos"
IF mv_par03 == 1
	cTitRel2  := "Origem: PLS"
ElseIF mv_par03 == 2
	cTitRel2  := "Origem: Financeiro"
ElseIF mv_par03 == 3
	cTitRel2  := "Origem: PLS + Financeiro"
EndIf

cTitRel3  := "Período: " + DtoC(mv_par01) + " a " + Dtoc(mv_par02)
aBox      := {}
nLin      := 0
nDir 		:= 0
cCodReta  := Space(1)
aCodRet	:= {}
sCodRet	:= 0
nTotInss20 := 0

oFntCur08n:= TFont():New( "Courier New" ,,08,,.F.,,,,,.F. )
oFntCur08b:= TFont():New( "Courier New" ,,08,,.T.,,,,,.F. )
oFntCur09b:= TFont():New( "Courier New" ,,09,,.T.,,,,,.F. )
oFntCur09n:= TFont():New( "Courier New" ,,09,,.F.,,,,,.F. )
oFntCur10b:= TFont():New( "Courier New" ,,10,,.T.,,,,,.F. )
oFntCur11b:= TFont():New( "Courier New" ,,11,,.T.,,,,,.F. )
oFntCur13b:= TFont():New( "Courier New" ,,13,,.T.,,,,,.F. )

oPrn:=TMSPrinter():New("CABERJ")
oPrn:SetPortrait()
oPrn:SetPage(9)
oPrn:SetSize(210,297)

nRegs:= Contar("QRY","!Eof()")
SetRegua(nRegs)

If mv_par04 == 1
	If !lIsdir(GetMV("MV_XXDIRPA", .F., "C:\MICROSIGA\")); MakeDir(GetMV("MV_XXDIRPA", .F., "C:\MICROSIGA\")); EndIf
	If File(cFilePath)
		If FErase(cFilePath) == -1
			MsgBox("Arquivo nao pode ser apagado. Erro #" + AllTrim(Str(FError())))
			Return
		EndIf
	Endif
	nHandle := FCreate(cFilePath, FC_NORMAL)
	If nHandle == -1
		MsgBox("Arquivo nao pode ser criado. Erro #" + AllTrim(Str(FError())))
		Return
	EndIf
EndIf

cLinha := cNomeProg+" - "+cTitRel1+" "+cTitRel2+CRLF
cLinha += cTitRel3
If mv_par04 == 1
	FWrite(nHandle, cLinha+CRLF+CRLF)
EndIf

fImpCabGraf()

SA2->(DbSetOrder(1))
QRY->(DbGoTop())

//cArqSE2 := CriaTrab( NIL,.F. )
//cKeySE2 := "E2_FILIAL+E2_CODRET+E2_NOMFOR" //+Posicione('SA2',1,xFilial('SA2')+SE2->E2_FORNECE,'A2_NOME')"

//IndRegua("SE2",cArqSE2,cKeySE2,,,"Ordenando Registros...")

nQuant := 0
While QRY->(!Eof())
	
	IncRegua()
	
	SE2->(DbGoTo(QRY->RECSE2)) 
//    IF QRY->RECSE2 = 365473
//      A:= 'TESTE'  
//   ENDIF    

////DEPURAÇÃO DE ERRO NO RELATORIO , DEPURAÇÃO POR PREFIXO E NUMERO DO TITULO  ALTAMIRO	
//   If SE2->E2_prefixo = 'FIN' .AND. SE2->E2_NUM = '9630495' 
//      A:= 'TESTE'  
//   ENDIF                                                                          
///////////////////////////////////////////////////////////////////////////////////   

 	   
	// Pula os títulos de taxas (pegar pelo Pai)
	If SE2->E2_TIPO $ MVISS+"|"+MVTAXA+"|"+MVTXA+"|"+MVINSS+"|"+"|SES"
		QRY->(DbSkip()) ; Loop
	Endif
	
	If lExibeINS == .T. 	  	// Filtro para INSS
		***** Filtro de Tipos a Considerar *****
		If !Empty(cTpInc) .And. !TRIM(SE2->E2_TIPO) $ TRIM (cTpInc)
			QRY->(DbSkip()) ; Loop
		Endif
		
		***** Filtro de Tipos a Desconsiderar *****
		If !Empty(cTpExc) .And. SE2->E2_TIPO $ cTpExc
			QRY->(DbSkip()) ; Loop
		Endif
	EndIf   
	
	// Pula os títulos de baixados por cancelamento (can), dação (dac) e baixa nao financeiro (bnf)
	//////filtar motivo de baixa                                                             
	SE5->(dbSetOrder(7))
//	If fVldBaixa(SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)) $ "DAC|CAN|BNF"   para contemplar baixa nao finaceira <> de dação e cancelamento
	If fVldBaixa(SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)) $ "DAC|CAN"      
       QRY->(DbSkip()) ; Loop
    EndIf   
	SA2->(DbSeek(xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA))
    //////////	
	//cNomFor  := SA2->A2_NOME
	cNomFor  := QRY->A2_NOME
	cCodRet  := SE2->E2_CODRET
	
	cPrefixo := SE2->E2_PREFIXO
	cNumero  := SE2->E2_NUM
	cParcela := SE2->E2_PARCELA
	cTipo    := SE2->E2_TIPO  
	
	//
	If cFiltro == "2"
//		If SA2->A2_TIPO $ ("F|J") .AND. SE2->E2_INSS = 0 // alterado para atender o chamado 
//		If (SA2->A2_TIPO $ ("F|J") .AND. SE2->E2_INSS = 0 .AND. SE2->E2_ORIGEM != 'PLSMPAG'
		   
		If ((SA2->A2_TIPO == "F" .AND. SE2->E2_INSS == 0 .AND. SE2->E2_ORIGEM != 'PLSMPAG') ;
		 .OR. (SA2->A2_TIPO == "J" .AND. SE2->E2_INSS == 0))
			QRY->(DbSkip())
			Loop
		EndIf
	EndIf
	
	Aadd(aCodRet,{"0588",0}) 	// IR (PF)1
	Aadd(aCodRet,{"1708",0}) 	// IR (PJ)2
	Aadd(aCodRet,{"2100",0})    // INSS3
	Aadd(aCodRet,{"5979",0})	// PIS4
	Aadd(aCodRet,{"5960",0})	// COFINS5
	Aadd(aCodRet,{"5987",0})	// CSLL6
	Aadd(aCodRet,{"1090",0})	// ISS7

    Aadd(aCodRet,{"8045",0})	// IR COMISSAO(PJ)8 ok 
	Aadd(aCodRet,{"3208",0})	// IR ALUG(PF)9     
	Aadd(aCodRet,{"3280",0})	// IR COOP(PJ)10     ok
    Aadd(aCodRet,{"2631",0})    // INSS(PJ)11

	// Monta array para totalizar os códigos de retenção (Apenas para o IR)
	If cFiltro == "1"
		If !SA2->A2_TIPO $ cCodReta
			cCodReta += " | " + SA2->A2_TIPO
			sCodRet ++
		EndIf
	Else
		sCodRet := 1
	Endif
	
	cOrigem  := IIF(Alltrim(SE2->E2_ORIGEM)=="PLSMPAG","PLS","FINANCEIRO")
	
	If nLin > 3225 				// 3300
		oPrn:EndPage()
		fImpCabGraf()
	Endif
	
	If cFiltro == "3"		// PIS
		IF ALLTRIM(SE2->E2_PARCPIS) == ""
			QRY->(DbSkip())
			Loop
		ENDIF
	Endif
	
	If cFiltro == "4" // COFINS
		IF ALLTRIM(SE2->E2_PARCCOF) == ""
			QRY->(DbSkip())
			Loop
		ENDIF
	Endif
	
	If cFiltro == "5" // CSLL
		IF ALLTRIM(SE2->E2_PARCSLL) == ""
			QRY->(DbSkip())
			Loop
		ENDIF
	Endif
		
	For B:=1 To Len(aBox)-1
		oPrn:Box(nLin,aBox[B],nLin+50,aBox[B+1])
	Next
	
	oPrn:Say(nLin+15,(aBox[01]+10) , cNomFor            			, oFntCur09n,,,,0)
	cLinha := cNomFor+";"
	
	If cFiltro=="1"
		If  SA2->A2_TIPO == "F"
		    If  cEmpant =='01' .and. SA2->A2_COD $ ALLTRIM(MV_PAR05) //'189688|INPUXG'

    	        oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[9][1]      	, oFntCur09n,,,,0)
		   	    cLinha += aCodRet[9][1]+";"

            Else 

			    oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[1][1]      	, oFntCur09n,,,,0)
		   	    cLinha += aCodRet[1][1]+";"
			
			EndIf

		ElseIF SA2->A2_TIPO == "J"  //altamiro
            If SE2->E2_PREFIXO ='COM' 
			    // desATIVAR EM 20/01/2022
				// If ((cEmpant =='02' .and. SA2->A2_COD $('125344')) ;

			     If ((cEmpant =='02' .and. SA2->A2_COD $('131688|131784|149127|125344')) ;
			   	   .OR. (cEmpant =='01' .and. SA2->A2_COD $('159528|180919')))
                    oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[2][1]      	, oFntCur09n,,,,0)
	 		        cLinha += aCodRet[2][1]+";" 
				Else  	 
				    oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[8][1]      	, oFntCur09n,,,,0)
	 		        cLinha += aCodRet[8][1]+";" 
                EndIf 

		    Elseif (cEmpant =='01' .and. SA2->A2_COD ==('186711')) 
                oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[10][1]      	, oFntCur09n,,,,0)
	 		    cLinha += aCodRet[10][1]+";" 
            Else 
			   oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[2][1]      	, oFntCur09n,,,,0)
			   cLinha += aCodRet[2][1]+";"
			EndIf 
		Endif
	ElseIf cFiltro=="2" .and. SA2->A2_TIPO == "J" 

        oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[11][1]      , oFntCur09n,,,,0)
		cLinha += aCodRet[11][1]+";"

    Else 

		oPrn:Say(nLin+15,(aBox[02]+10) , aCodRet[val(cFiltro)+1][1]      , oFntCur09n,,,,0)
		cLinha += aCodRet[val(cFiltro)+1][1]+";"
	
	Endif
	
	oPrn:Say(nLin+15,(aBox[03]+10) , cPrefixo                    , oFntCur09n,,,,0)
	oPrn:Say(nLin+15,(aBox[04]+10) , cNumero                     , oFntCur09n,,,,0)
	oPrn:Say(nLin+15,(aBox[05]+10) , cTipo                       , oFntCur09n,,,,0)
	oPrn:Say(nLin+15,(aBox[06]+10) , cOrigem                     , oFntCur09n,,,,0)
	
	cLinha += cPrefixo+";"+cNumero+";"+cTipo+";"+cOrigem+";"
	
	If cCampoImp != "E2_INSS"
		nDir := 60
	EndIf
	
	If cFiltro == "1"
		oPrn:Say(nLin+15,(aBox[07]+150+nDir) , Transf(SE2->E2_IRRF,"@E 999,999.99") , oFntCur09n,,,,1)
		
		cLinha += Transf(SE2->E2_IRRF,"@E 999,999.99")+";"
		
		If  SA2->A2_TIPO == "F"

		    If  cEmpant =='01' .and. SA2->A2_COD $ ALLTRIM(MV_PAR05) //'189688|INPUXG' //ALTAMIRO 01/12/21 CHAMADO  

                aCodRet[9][2] += SE2->E2_IRRF

            Else 
		
			    aCodRet[1][2] += SE2->E2_IRRF
   
            EndIf

		ElseIF SA2->A2_TIPO == "J"
		    If SE2->E2_PREFIXO ='COM' 
			   // ATIVAR EM 20/01/2022
               If  ((cEmpant =='02' .and. SA2->A2_COD $('131688|131784|149127|125344')) .or. (cEmpant =='01' .and. SA2->A2_COD $('159528|180919') ))
			  // If  ((cEmpant =='02' .and. SA2->A2_COD $('125344')) .or. (cEmpant =='01' .and. SA2->A2_COD $('159528|180919') ))
                    
					aCodRet[2][2] += SE2->E2_IRRF
				
                Else 
				
					aCodRet[8][2] += SE2->E2_IRRF

                EndIf 

		    Elseif (cEmpant =='01' .and. SA2->A2_COD ==('186711')) 

                    aCodRet[10][2] += SE2->E2_IRRF
               
			Else 

			       aCodRet[2][2] += SE2->E2_IRRF

            EndIf 
		     
		Else
			
			Alert ("Cadastro do Fornecedor: " + SA2->A2_COD + " não possui informação de tipo pessoa!")
			
			Return
		
		Endif
	
	ElseIf  cFiltro == "2"

	    If  SA2->A2_TIPO == "J" 

            oPrn:Say(nLin+15,(aBox[07]+150+nDir) , Transf(SE2->E2_INSS,"@E 999,999.99") , oFntCur09n,,,,1)
		
		    cLinha += Transf(SE2->E2_INSS,"@E 999,999.99")+";"
		
		    aCodRet[11][2] += SE2->E2_INSS
		
        Else 
		
			oPrn:Say(nLin+15,(aBox[07]+150+nDir) , Transf(SE2->E2_INSS,"@E 999,999.99") , oFntCur09n,,,,1)
			
			cLinha += Transf(SE2->E2_INSS,"@E 999,999.99")+";"
			
			aCodRet[3][2] += SE2->E2_INSS

		EndIf 	
			
	ElseIf cFiltro == "3" //.AND. SE2->E2_VALOR >= 5000
		
		oPrn:Say(nLin+15,(aBox[07]+150+nDir) , Transf(SE2->E2_VRETPIS,"@E 999,999.99") , oFntCur09n,,,,1)
		
		cLinha += Transf(SE2->E2_VRETPIS,"@E 999,999.99")+";"
		
		aCodRet[4][2] += SE2->E2_VRETPIS
		
	ElseIf cFiltro == "4" //.AND. SE2->E2_VALOR >= 5000
		
		oPrn:Say(nLin+15,(aBox[07]+150+nDir) , Transf(SE2->E2_VRETCOF,"@E 999,999.99") , oFntCur09n,,,,1)
		
		cLinha += Transf(SE2->E2_VRETCOF,"@E 999,999.99")+";"
		
		aCodRet[5][2] += SE2->E2_VRETCOF
		
	ElseIf cFiltro == "5" //.AND. SE2->E2_VALOR >= 5000
		
		oPrn:Say(nLin+15,(aBox[07]+150+nDir) , Transf(SE2->E2_VRETCSL,"@E 999,999.99") , oFntCur09n,,,,1)
		
		cLinha += Transf(SE2->E2_VRETCSL,"@E 999,999.99")+";"
		
		aCodRet[6][2] += SE2->E2_VRETCSL
		
	ElseIf cFiltro == "6"
		
		oPrn:Say(nLin+15,(aBox[07]+150+nDir) , Transf(SE2->E2_ISS,"@E 999,999.99") , oFntCur09n,,,,1)
		
		cLinha += Transf(SE2->E2_ISS,"@E 999,999.99")+";"
		
		aCodRet[7][2] += SE2->E2_ISS
		
	Endif
	
	If cCampoImp == "E2_INSS"
		nTotal += SE2->E2_VALOR+SE2->E2_IRRF+SE2->E2_INSS
		If SA2->A2_TIPO == "F"                                          
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ ajuste necessario para acertar base de inss a empregador     ³
	   	//³ no valor 2,67 , erro ocorreu em 28/11/08 e foi verificado    ³
	   	//³ no pagamento de 20/01/09                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nVlInss:=0
         If SE2->(E2_ANOBASE+E2_MESBASE) == '200811'
            If ascan(aVetRda , SE2->E2_CODRDA) > 0
               nVlInss:=2.67
            Endif
         Endif          
  			// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ       
			nVlInss20 := (SE2->E2_VALOR+SE2->E2_IRRF+SE2->E2_INSS+nVlInss) * 0.20
			nTotInss20 += nVlInss20
		Else
			nVlInss20 := 0
		Endif
		
		oPrn:Say(nLin+15,(aBox[08]+160) , Transf(nVlInss20,"@E 999,999.99")  , oFntCur09n,,,,1)
		
		cLinha += Transf(nVlInss20,"@E 999,999.99")+";"
		
	Endif
	
	If mv_par04 == 1
		FWrite(nHandle, cLinha+CRLF)
	EndIf
	
	nQuant += 1
	
	nLin += 50
	QRY->(DbSkip())
	
End

If nLin + IIF(cFiltro == "1",sCodRet * 50,50) >= 3100
	oPrn:EndPage()
	fImpCabGraf()
EndIf

nLin += 100

cLinha := ""

If nQuant >0
	oPrn:Box(nLin+20,1000,nLin+70,1200)
	oPrn:Box(nLin+20,1200,nLin+70,1500)
	oPrn:Say(nLin+25,1150 , "COD RET" , oFntCur09n,,,,1)
	oPrn:Say(nLin+25,1400 , "TOTAL"   , oFntCur09n,,,,1)
	
	cLinha := CRLF+";;"+"COD RET"+";"+"TOTAL"+";"
	
	If cCampoImp == "E2_INSS"
		oPrn:Box(nLin+20,1500,nLin+70,1800)
		oPrn:Say(nLin+25,1750 , "TOTAL 20%" , oFntCur09n,,,,1)
		cLinha += "TOTAL 20%"+";"
	EndIf
	
	If mv_par04 == 1
		FWrite(nHandle, cLinha+CRLF)
	EndIf
	
	nLin += 50
	
	If cFiltro == "1"
		nTotalIR := 0
		
		If sCodRet == 1 // Ajusta impressao para quando existir apenas um dos codigos de IRRF com valor > 0 .
		   sCodRet++
		Endif    
		
//		For nTemp:=1  to sCodRet
        For nTemp:=1  to len(aCodRet)

			if aCodRet[nTemp][2] > 0
				oPrn:Box(nLin+20,1000,nLin+70,1200)
				oPrn:Box(nLin+20,1200,nLin+70,1500)
				oPrn:Say(nLin+25,1130 , aCodRet[nTemp][1]  , oFntCur09n,,,,1)
				oPrn:Say(nLin+25,1450 , Transf(aCodRet[nTemp][2] ,"@E 999,999.99")  , oFntCur09n,,,,1)
				
				cLinha := ";;"+aCodRet[nTemp][1]+";"+Transf(aCodRet[nTemp][2] ,"@E 999,999.99")
				If mv_par04 == 1
					FWrite(nHandle, cLinha+CRLF)
				EndIf
				nTotalIR += aCodRet[nTemp][2]
				nLin += 50
			EndIf 

		Next
		nLin += 50
		oPrn:Box(nLin+20,1000,nLin+70,1200)
		oPrn:Box(nLin+20,1200,nLin+70,1500)
		oPrn:Say(nLin+25,1170 , "Total IR", oFntCur09n,,,,1)
		oPrn:Say(nLin+25,1450 , Transf(nTotalIR,"@E 999,999.99")  , oFntCur09n,,,,1)
		
		cLinha := ";;"+"Total IR"+";"+Transf(nTotalIR,"@E 999,999.99")+";"
		If mv_par04 == 1
			FWrite(nHandle, cLinha+CRLF)
		EndIf
	Else
		oPrn:Box(nLin+20,1000,nLin+70,1200)
		oPrn:Box(nLin+20,1200,nLin+70,1500)
		oPrn:Say(nLin+25,1130 , aCodRet[val(cFiltro)+1][1]  , oFntCur09n,,,,1)
		oPrn:Say(nLin+25,1450 , Transf(aCodRet[val(cFiltro)+1][2] ,"@E 999,999.99")  , oFntCur09n,,,,1)
		
		cLinha := ";;"+aCodRet[val(cFiltro)+1][1]+";"+Transf(aCodRet[val(cFiltro)+1][2] ,"@E 999,999.99")+";"
        	
		If cCampoImp == "E2_INSS"
			oPrn:Box(nLin+20,1500,nLin+70,1800)
			oPrn:Say(nLin+25,1750 , Transf(nTotInss20,"@E 999,999.99") , oFntCur09n,,,,1)
			cLinha += Transf(nTotInss20,"@E 999,999.99")+";"
		EndIf

		If  aCodRet[11][2] > 0 
 
            nLin += 50
			oPrn:Box(nLin+20,1000,nLin+70,1200)
			oPrn:Box(nLin+20,1200,nLin+70,1500)
			oPrn:Say(nLin+25,1130 , aCodRet[11][1]  , oFntCur09n,,,,1)
			oPrn:Say(nLin+25,1450 , Transf(aCodRet[11][2] ,"@E 999,999.99")  , oFntCur09n,,,,1)
			
			cLinha := ";;"+aCodRet[11][1]+";"+Transf(aCodRet[11][2] ,"@E 999,999.99")+";"

			oPrn:Box(nLin+20,1500,nLin+70,1800)
			oPrn:Say(nLin+25,1750 , Transf(nTotIn20p,"@E 999,999.99") , oFntCur09n,,,,1)
			cLinha += Transf(nTotIn20p,"@E 999,999.99")+";"
        
		EndIf 

		If mv_par04 == 1
			FWrite(nHandle, cLinha+CRLF)
		EndIf
		
	EndIf

EndIf

If mv_par04 == 1
	FClose(nHandle)
	Aviso( "Relação de Impostos", "Arquivo " + cFilePath + " gerado com sucesso!", {"Ok"} )
	fGeraExcel(GetMV("MV_XXDIRPA", .F., "C:\MICROSIGA\"), cPerg+".CSV", GetMV("MV_XXDIRPA", .F., "C:\MICROSIGA\"),.T.)
EndIf

oPrn:Preview()

Return

*****************************************************
Static function fGeraExcel(xDir, xFile, xPath, lAbre)
*****************************************************

Local lAbre := If(lAbre == Nil,.F.,lAbre)
Local lOk   := !ApOleCliente("MsExcel")

If lOk
	ApMsgInfo("MsExcel não encontrado !")
Else
	If !lAbre
		CpyS2T(xDir + xFile,xPath,.T.)
		//fErase(xDir + xFile)
	EndIf
	oExcelApp:=MsExcel():New()
	oExcelApp:WorkBooks:Open(xPath + xFile)
	oExcelApp:SetVisible(.T.)
Endif

Return(lOk)


*****************************
Static Function fImpCabGraf()
*****************************

Local B 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nI 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

oPrn:StartPage()

cFileLogo := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP"
If !File(cFileLogo )
	cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP"
	If !File(cFileLogo)
		cFileLogo := "LGRL.BMP"
	Endif
Endi

oPrn:Box(020,010,0220,0420)
oPrn:SayBitmap(040,060,cFileLogo,0200,0120)
oPrn:Say(170,230,Alltrim(cNomeProg+" / "+cVersao),oFntCur09b,,,,2)

oPrn:Box(020,0420,0220,01900)

oPrn:Say(040,1160,cTitRel1,oFntCur13b,,,,2)
oPrn:Say(095,1160,cTitRel2,oFntCur11b,,,,2)
oPrn:Say(150,1160,cTitRel3,oFntCur11b,,,,2)

oPrn:Box(020,1900,0220,2310)
oPrn:Say(040,1920,"Página : "+Str(oPrn:nPage,8),oFntCur08b,,,,0)
//oPrn:Say(040,1920,"Página : "+ Alltrim(Str(oPrn:nPage,8)) + " / " + Alltrim(Str(nPages,8)),oFntCur08b,,,,0)
oPrn:Say(100,1920,"Emissão: "+Dtoc(dDataBase)  ,oFntCur08b,,,,0)
oPrn:Say(160,1920,"Hora   : "+Time()           ,oFntCur08b,,,,0)

nLin:= 260

If cCampoImp == "E2_INSS"
	aBox:= {20,0850,1050,1250,1450,1700,1950,2130,2310}
Else
	aBox:= {20,0850,1050,1250,1450,1700,1950,2310}
Endif

For B:=1 To Len(aBox)-1
	oPrn:Box(nLin,aBox[B],nLin+70,aBox[B+1])
Next

aCampos := { {"'Fornecedor'","@!"}, {"'Cod. Ret.'","@!"}, {"'Prefixo'","@!"}, {"'Titulo'","@!"}, {"'Tipo'","@!"}, {"'Origem'","@!"} }

For nI := 1 To Len(aCampos)
	oPrn:Say(nLin+25,(aBox[nI]+10) , &(aCampos[nI,1]), oFntCur09b,,,,0)
Next

If mv_par04 == 1 .And. !lImpFirst
	cLinha:=""
	aEval( aCampos, {|x|cLinha+=Alltrim(Transform(&(x[1]),x[2]))+";"} )
	FWrite(nHandle, cLinha)
EndIf

If cCampoImp == "E2_INSS"
	
	aCampos := {"Vlr." + Subs(cCampoImp,4), "INSS 20%"}
	oPrn:Say(nLin+25,(aBox[07]+173) , aCampos[1] , oFntCur09b,,,,1)
	oPrn:Say(nLin+25,(aBox[08]+173) , aCampos[2] , oFntCur09b,,,,1)
	cLinha := aCampos[1]+";"+aCampos[2]
	
Else
	
	aCampos := {"Vlr. " + Subs(cCampoImp,4)}
	oPrn:Say(nLin+25,(aBox[07]+200) , aCampos[1] , oFntCur09b,,,,1)
	cLinha := aCampos[1]
	
Endif

If mv_par04 == 1 .And. !lImpFirst
	lImpFirst := .T.
	FWrite(nHandle, cLinha+CRLF)
EndIf

nLin +=70
Return


**************************
Static Function fCriaSx1()
**************************

Local Z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

SX1->(DbSetOrder(1))

If !SX1->(DbSeek(cPerg+aSx1[Len(aSx1),2]))
	SX1->(DbSeek(cPerg))
	While SX1->(!Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
		SX1->(Reclock("SX1",.F.,.F.))
		SX1->(DbDelete())
		SX1->(MsunLock())
		SX1->(DbSkip())
	End
	For X1:=2 To Len(aSX1)
		SX1->(RecLock("SX1",.T.))
		For Z:=1 To Len(aSX1[1])
			cCampo := "X1_"+aSX1[1,Z]
			SX1->(FieldPut(FieldPos(cCampo),aSx1[X1,Z] ))
		Next
		SX1->(MsunLock())
	Next
Endif

Return



Static Function fFiltragem()

nDlg00Larg := 400
nDlg00Alt  := 80

cTpInc     := Space(80)
cTpExc     := Space(80)

lOk        := .F.
bOk        := {|| lOk:= .T. , oDlg01:End() }
bCancel    := {|| oDlg01:End()}
aButtons   := {}

oFnt12AriN := TFont():New( "Arial" ,,-12,,.F.,,,,,.F. )
oFnt13AriN := TFont():New( "Arial" ,,-13,,.F.,,,,,.F. )
oFnt14AriB := TFont():New( "Arial" ,,-14,,.T.,,,,,.T. )

Private aFiltro    := {"1 - IRRF" ,"2 - INSS" ,"3 - PIS" ,"4 - COFINS" ,"5 - CSLL", "6 - ISS"}
Private cFiltro    := aFiltro[1]

oDlg01:=TDialog():New(000,000,nDlg00Alt+90,nDlg00Larg+50,"Filtros adicionais",,,,,,,,,.T.)

oDlg01:nClrPane:= RGB(255,255,254)
oDlg01:bStart  := {||(EnchoiceBar(oDlg01,bOk,bCancel,,aButtons))}
//Fabio Bianchini - 12/03/2019 - Migração P12 - Ajuste Posicionamento de Tela
/*
oSayTipTx  :=TSay():New(020,005,{||"Filtrar o Imposto"    },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
oSayEmissa :=TSay():New(035,005,{||"Considerar Tipos"    },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
oSayEmiss2 :=TSay():New(050,005,{||"Desconsiderar Tipos" },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)

oGetFiltro :=TComboBox():New(020,075,{|u|If(PCount()>0,cfiltro :=u,cFiltro )},aFiltro,080,050,oDlg01,,{||fVldFiltro(cFiltro)},,,,.T.,oFnt13AriN,,,{||.T.},,,,,"cFiltro")
oGetTpInc  :=TGet():New(035,075,bSetGet(cTpInc)   ,oDlg01,142,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||lExibeINS},,,,.F.,,       ,"cTpInc"    )
oGetTpExc  :=TGet():New(050,075,bSetGet(cTpExc)   ,oDlg01,142,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||lExibeINS},,,,.F.,,       ,"cTpExc"    )
*/
oSayTipTx  :=TSay():New(032,005,{||"Filtrar o Imposto"   },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
oSayEmissa :=TSay():New(050,005,{||"Considerar Tipos"    },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)
oSayEmiss2 :=TSay():New(068,005,{||"Desconsiderar Tipos" },oDlg01,,oFnt13AriN,,,,.T.,,,100,10)

oGetFiltro :=TComboBox():New(032,075,{|u|If(PCount()>0,cfiltro :=u,cFiltro )},aFiltro,080,050,oDlg01,,{||fVldFiltro(cFiltro)},,,,.T.,oFnt13AriN,,,{||.T.},,,,,"cFiltro")
oGetTpInc  :=TGet():New(050,075,bSetGet(cTpInc)   ,oDlg01,142,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||lExibeINS},,,,.F.,,       ,"cTpInc"    )
oGetTpExc  :=TGet():New(068,075,bSetGet(cTpExc)   ,oDlg01,142,10,               ,{||.T.},,,oFnt12AriN,,,.T.,,,{||lExibeINS},,,,.F.,,       ,"cTpExc"    )

oGetTpInc:Disable()
oGetTpExc:Disable()

oDlg01:Activate(,,,.T.)

If lOk
	Processa({|| fProcessa()},"Selecionando Titulos...")
Endif

Return

***************************************************************
Static Function fVldBaixa(cChaveE5)
***************************************************************
local cMotBx:= " "	

    	If  SE5->( MsSeek(cChaveE5) )

		While ! SE5->(eof()) .and. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == cChaveE5

             cMotBx:=SE5->E5_MOTBX	

	   		 SE5->(dbSkip())	
				
	   enddo	
	else
	  cMotBx:=" "
	EndIf     
return ( cMotBx ) 		






***************************************************************
Static Function fVldFiltro(cFiltro)
***************************************************************

If Substr(cFiltro,1,1) == "2"
	lExibeINS:=.T.
	oSayEmissa:Enable()
	oSayEmiss2:Enable()
	oGetTpInc:Enable()
	oGetTpExc:Enable()
Else
	lExibeINS:=.F.
	oSayEmissa:Disable()
	oSayEmiss2:Disable()
	oGetTpInc:Disable()
	oGetTpExc:Disable()
EndIf

oDlg01:Refresh()
Return                                                             
