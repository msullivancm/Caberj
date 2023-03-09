#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

//Static cEOL := chr(13) + chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA092    บ Autor ณ Angelo Henrique    บ Data ณ  21/05/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para importar lan็amentos contแbeis de d้bito e     บฑฑ
ฑฑบ          ณ crr้dito.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function Gbsqbm1()
	Local aArea    		:= GetArea()
	Local cDescr		:= ""
	
	Private cProg       := "CABA092"
	Private cArqCSV		:= "C:\"
	Private nOpen		:= -1
	Private cDiretorio	:= " "
	Private oDlg		:= Nil
	Private oGet1		:= Nil
	Private oBtn1		:= Nil
	Private oGrp1		:= Nil
	Private oSay1		:= Nil
	Private oSBtn1		:= Nil
	Private oSBtn2		:= Nil
	Private oCombo		:= Nil
	Private nLinhaAtu  	:= 0
	Private cTrbPos
	Private lEnd	    := .F.
	Private _cTime		:= TIME()
	Private _aDadGrv	:= {}
    Private _cUsuario   := SubStr(cUSUARIO,7,15)	
    Private cMatAnt     := ' ' 
    Private cAno        := '2020'
    Private cMes        := '10'
    Private cMesRef     := '10'
	cDescr := "Este programa irแ importar os lan็amentos de D้bito /Cr้dito apartir de um arquivo CSV."

    Processa({|lEnd|ImportCSV()},"Aguarde , buscanco dados  no servidor ...","",.T.)
	
	RestArea(aArea)
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImportCSV  บ Autor ณ Angelo Henrique    บ Data ณ  08/01/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Efetua a importal็ao do arquivo .CSV                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

//Static Function ImportCSV(lEnd,cArqCSV)
Static Function ImportCSV()	

	Local nTotal		:= 0
    local I             := 0
	local cdescBfq      := ' '
	Private nMat 		:= 0
	Private nValor	 	:= 0
	Private nObs	   	:= 0
	Private nCdLan     	:= 0
	Private nDbCrd   	:= 0
	
	Private _cTime		:= TIME() //Hora inicial da importa็ใo
	Private aLinha		:= {}
	
	Private a_ItFim     := {}
	Private a_Cab		:= {"Matricula","Ano","Mes","Lan็amento","Mensagem"}	
	
    Private cAliastmp   := GetNextAlias()
	Private cAliastmp1  := GetNextAlias()
    Private cQuery      := " "   

	lInicio 	:= .T.
	lCabecOk 	:= .T.

cQuery :=       " select DISTINCT BSQ.* , nvl(bm1_prefix,' ')bm1Pref , nvl(bm1_numtit,' ')bm1Num , nvl(bm1_parcel,' ')bm1Parc , nvl(bm1_tiptit,' ')bm1Tipt , nvl(bm1_plnuco, ' ')bm1Plnuc  , ba3_mesrea mesrea"
cQuery += CRLF+ "   from bsq010 bsq , bm1010 bm1 , se1010 se1  , ba3010 ba3 "
cQuery += CRLF+ "  where bsq_filial    = ' ' and bsq.d_E_L_E_T_ = ' ' " 
cQuery += CRLF+ "    and bm1_filial(+) = ' '  and bm1.d_E_L_E_T_(+) = ' ' "
cQuery += CRLF+ "    and e1_filial(+)  = '01' and se1.d_E_L_E_T_(+) = ' ' "
cQuery += CRLF+ "    and ba3_filial    = ' '  and ba3.d_E_L_E_T_    = ' ' "

cQuery += CRLF+ "    AND BA3_CODINT = bsq_codint "
cQuery += CRLF+ "    AND BA3_CODEMP = bsq_codemp "
cQuery += CRLF+ "    AND BA3_MATRIC = bsq_matric " 

cQuery += CRLF+ "    and bsq_ano    = '2200' and bsq_mes    = '"+cMesRef+"' "
cQuery += CRLF+ "    and bm1_ano(+) = '"+cAno+"' and bm1_mes(+) = '"+cMes+"' "
cQuery += CRLF+ "    and bsq_usuari = bm1_matusu(+) "
cQuery += CRLF+ "    and (nvl(bm1_matusu,' ') <>  ' ' and  nvl(bm1_numtit,' ') <> ' ') "
cQuery += CRLF+ "    and e1_prefixo = nvl(bm1_prefix,' ')"
cQuery += CRLF+ "    and e1_num     = nvl(bm1_numtit,' ')"
cQuery += CRLF+ "    and e1_parcela = nvl(bm1_parcel,' ')"
cQuery += CRLF+ "    and e1_tipo    = nvl(bm1_tiptit,' ')"
cQuery += CRLF+ "    and e1_plnucob = nvl(bm1_plnuco,' ')"
cQuery += CRLF+ "    and e1_anobase = '"+cAno+"'"
cQuery += CRLF+ "    and e1_mesbase = '"+cMes+"'"

//cQuery += CRLF+ "    and bsq_codemp = '0002'

//cQuery += CRLF+ "    and bsq_usuari IN   ('00010001000022007', '00010001000026002','00010001000026010') "

cQuery += CRLF+ "    order by bsq_usuari " 

If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 

TCQuery cQuery  New Alias (cAliastmp) 

	nTotal := (cAliastmp)->(LastRec()-1)
	
	ProcRegua(nTotal)
	
	(cAliastmp)->(dbGoTop()) 

	
	While !(cAliastmp)->(Eof())

		If  cMatAnt != (cAliastmp)->BSQ_USUARI      
	        cMatAnt := (cAliastmp)->BSQ_USUARI	

			For i := 1 To 2 

				c_Seq := STPEGASEQ()

				RecLock("BSQ",.T.)
							
					BSQ_FILIAL 	:= xFilial("BSQ")
					BSQ_CODSEQ 	:= soma1(c_Seq)
					BSQ_USUARI 	:= (cAliastmp)->BSQ_USUARI
					BSQ_CODINT 	:= (cAliastmp)->BSQ_CODINT
					BSQ_CODEMP	:= (cAliastmp)->BSQ_CODEMP
					BSQ_CONEMP	:= (cAliastmp)->BSQ_CONEMP
					BSQ_VERCON  := '001'
					BSQ_SUBCON	:= (cAliastmp)->BSQ_SUBCON
					BSQ_VERSUB	:= '001'
					BSQ_MATRIC  := (cAliastmp)->BSQ_MATRIC
					BSQ_ANO		:= cAno
					BSQ_MES		:= cMes
					BSQ_CODLAN 	:= IIf(i==1,"971","972")    	//971 - Debito // 972 - Credito
					BSQ_VALOR	:= (cAliastmp)->BSQ_VALOR
					BSQ_TIPO 	:= IIf(i==1,"1","2")  // 1=Debito 2=Credito
					BSQ_NPARCE	:= '1'
					BSQ_TIPEMP 	:= '2'
					BSQ_AUTOMA 	:= '0'
					BSQ_COBNIV  := (cAliastmp)->BSQ_COBNIV
					BSQ_OBS     := trim((cAliastmp)->BSQ_OBS) + (IIf(i==1,' - DEBITO - REF AGO/2020',' - CREDITO - REF AGO/2020') )//  AllTrim(aLinha[nObs]) 	//'DIFERENวA DE MENSALIDADE  - DEBITO'
					BSQ_ZHIST   := UPPER(_cUsuario) + " - " + DTOC(dDataBase) + " - " + _cTime
					BSQ_NUMCOB  := (cAliastmp)->bm1Plnuc
					BSQ_PREFIX  := (cAliastmp)->bm1Pref
					BSQ_NUMTIT  := (cAliastmp)->bm1Num
					BSQ_PARCEL  := (cAliastmp)->bm1Parc
					BSQ_TIPTIT  := (cAliastmp)->bm1Tipt

				BSQ->( MsUnlock() )

				cdescBfq:=(IIf(i==1,"DEB. DIF. DE REAJ. - AGO/2020",'CRED. DIF. DE REAJ. - AGO/2020') )

				GravaBM1(I , BSQ_VALOR , BSQ_NUMCOB , BSQ_PREFIX , BSQ_NUMTIT , BSQ_TIPTIT , BSQ_USUARI , BSQ_TIPO , BSQ_CODLAN , cDescbfq , BSQ_CODSEQ)

			/*
				//--------------------------------------
				//Gravar Log informativo
				//--------------------------------------
				aAdd(_aDadGrv,;
					"Matricula: " 		+ (cAliastmp)->BSQ_USUARI    + ;
					" - Ano: " 			+ cAno	                     + ;
					" - Mes: " 			+ cMes   	                 + ;
					" - Lan็amento: " 	+ BSQ_CODSEQ     		 	 + ;
					" - Valor :"    	+ Transform(BSQ_VALOR,"@E 999999999.99")   		 	     + ;
					" - Incluido com sucesso. " )
			*/
			Next
        
		EndIf 
        
		(cAliastmp)->(DbSkip())
	
	Enddo			
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ STPEGASEQ  บ Autor ณ Angelo Henrique    บ Data ณ  27/05/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Traz a numera็ใo para o sequencial dos lan็amentos.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function STPEGASEQ()
	
	Local c_Qry := ""
	Local c_Cod := ""
	
	c_Qry := " SELECT Max(BSQ_CODSEQ) VALMAX FROM " + retsqlname("BSQ") + " WHERE D_E_L_E_T_ = ' ' "
	
	TCQuery c_Qry Alias "TMPMXBSQ" New
	
	If !TMPMXBSQ->( EOF() )
		
		c_Cod	:= TMPMXBSQ->VALMAX
		
	Endif  
	
	TMPMXBSQ->( dbCloseArea() )
	
Return c_Cod

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGravaBM1Esp บAutor  ณTulio Cesar       บ Data ณ  12/22/03   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.                                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
//Static Function GravaBM1Esp(cCodTip,cCodInt,cCodEmp,cCodCli,cLoja,nValor,cPrefixo,cNumero,cTipReg,;
//                            cDigito,cTipTit,cMes,cAno)
Static Function GravaBM1(I , nValor    , cNumCob    , cPrefixo   , cNumero    , cTipTit    , cUsuario   , cDCbfq   , cCodbfq    , cDescbfq , cSeqBsq)

	Local cQueryBm1 := ""
    LOCAL cSeq  := ' '

	    
    cQueryBm1 :=       " select DISTINCT BM1.* "  
	cQueryBm1 += CRLF+ "   from bm1010 bm1 "
	cQueryBm1 += CRLF+ "  where bm1_filial = ' ' and bm1.d_E_L_E_T_ = ' ' "
	cQueryBm1 += CRLF+ "    and bm1_ano = '"+cAno+"' and bm1_mes = '"+cMes+"' "
	cQueryBm1 += CRLF+ "    and bm1_matusu ='"+cUsuario+"'"        

    If Select((cAliastmp1)) <> 0 
       (cAliastmp1)->(DbCloseArea())  
    Endif  

    TCQuery cQueryBm1  New Alias (cAliastmp1) 

	(cAliastmp1)->(dbGoTop()) 

    cSeq := PLSA625Cd("BM1_SEQ","BM1",1,"BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_ANO+BM1_MES+BM1_TIPREG)",;
    (cAliastmp1)->BM1_CODINT+(cAliastmp1)->BM1_CODEMP+(cAliastmp1)->BM1_MATRIC+(cAliastmp1)->BM1_ANO+(cAliastmp1)->BM1_MES+(cAliastmp1)->BM1_TIPREG)

    BM1->(RecLock("BM1",.T.))     
    BM1->BM1_FILIAL := xFilial("BM1")
    BM1->BM1_CODINT := (cAliastmp1)->BM1_CODINT
    BM1->BM1_CODEMP := (cAliastmp1)->BM1_CODEMP
    BM1->BM1_MATRIC := (cAliastmp1)->BM1_MATRIC
    BM1->BM1_TIPREG := (cAliastmp1)->BM1_TIPREG
    BM1->BM1_DIGITO := (cAliastmp1)->BM1_DIGITO
    BM1->BM1_NOMUSR := (cAliastmp1)->BM1_NOMUSR // PLNOMUSR(BM1->BM1_CODINT+BM1->BM1_CODEMP+BM1->BM1_MATRIC+BM1->BM1_TIPREG)
    BM1->BM1_SEQ    := cSeq
    BM1->BM1_CONEMP := (cAliastmp1)->BM1_CONEMP 
    BM1->BM1_VERCON := (cAliastmp1)->BM1_VERCON
    BM1->BM1_SUBCON := (cAliastmp1)->BM1_SUBCON 
    BM1->BM1_VERSUB := (cAliastmp1)->BM1_VERSUB
    BM1->BM1_ANO    := cAno
    BM1->BM1_MES    := cMes 
    BM1->BM1_TIPO   := cDCbfq
    BM1->BM1_VALOR  := nValor
    BM1->BM1_CODTIP := cCodbfq
    BM1->BM1_DESTIP := cDescbfq
    BM1->BM1_CODEVE := BM1->BM1_CODTIP // e iguar ao codigo do tipo , vide cadastro 
    BM1->BM1_DESEVE := IIf(i==1,"DEBITO DIF. DE REAJUSTE-REF AGO/2020","CREDITO DIF. DE REAJUSTE-REF AGO/2020")
    BM1->BM1_ALIAS  := "BSQ"
    BM1->BM1_ORIGEM := (cAliastmp1)->BM1_ORIGEM
    BM1->BM1_BASEIR := 0
    BM1->BM1_MATUSU := cUsuario // (cAliastmp1)->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG)
    BM1->BM1_PLNUCO := cNumCob
    BM1->BM1_LTOTAL := "0"
    BM1->BM1_SEXO   := (cAliastmp1)->BM1_SEXO
    BM1->BM1_GRAUPA := (cAliastmp1)->BM1_GRAUPA
    BM1->BM1_CODFAI := ' ' //(cAliastmp1)->BM1_NIVFAI
    BM1->BM1_NIVFAI := ' ' //(cAliastmp1)->BM1_NIVFAI
    BM1->BM1_TIPUSU := (cAliastmp1)->BM1_TIPUSU
    BM1->BM1_CARGO  := (cAliastmp1)->BM1_CARGO
    BM1->BM1_PREFIX := cPrefixo
    BM1->BM1_NUMTIT := cNumero
    BM1->BM1_TIPTIT := cTipTit
    BM1->BM1_NIVCOB := (cAliastmp1)->BM1_NIVCOB 
    BM1->BM1_INTERC := "0"
    BM1->BM1_NUMPAR := "001"
 
	BM1->BM1_ORIGEM := cSeqBsq
	BM1->BM1_ATOCOO := '2' 
	BM1->BM1_VALMES := nValor

	BM1->BM1_CODPLA := (cAliastmp1)->BM1_CODPLA
    BM1->BM1_DESPLA := (cAliastmp1)->BM1_DESPLA
    BM1->BM1_VERPLA := (cAliastmp1)->BM1_VERPLA
    BM1->BM1_CODSEQ := cSeqBsq

	BM1->BM1_NATURE := (cAliastmp1)->BM1_NATURE
    BM1->BM1_XISODO := (cAliastmp1)->BM1_XISODO

BM1->(MsUnLock())  

Return()