#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"
#include "rwmake.ch" 
/*-----------------------------------------------------------------------
| Funcao   | CABR050a  | Autor | Otavio Pinto        | Data | 11/08/2014 |
|------------------------------------------------------------------------|
| Descricao| Relatorio de beneficiarios que estao nao estao aptos a      |
|          | terem a carteirinha gerada e o motivo.                      |
|------------------------------------------------------------------------|
|          |     | UTILIZADO NO MÓDULO DE TREINAMENTO                    |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
User Function CABR050a

Local   aRegs     := {}

private cNomRot   := "CABR050a" 
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR050a"
private nLastKey  := 0   
private nPos1     :=  9
private nPos2     := 40
private nPos3     := 15
private _cDeli    := ';'
Private cAlias    := "TRB"  //GetNextAlias()

AjustaSX1()
if Pergunte(cPerg,.T.)
   Processa({ ||IMP_REL2()},"Gerando Arquivo ...")
endIf    

Return Nil


/*-----------------------------------------------------------------------
| Funcao   | IMP_REL2  | Autor | Otavio Pinto        | Data | 11/08/2014 |
|------------------------------------------------------------------------|
| Descricao| Rotina de impressao                                         |
 -----------------------------------------------------------------------*/
static function IMP_REL2()
Local _lCabec       := .T.	
Local cCabCSV       := ""

Local cPosTit   	:= alltrim(GetNewPar("MV_PLPOSTI","1")) // 1-titulos em aberto  2-titulos em aberto/baixados
Local nTits  		:= 0
Local cCodCli   	:= ""
Local cLoja     	:= ""
Local cNivCob		:= ""
Local aDadUsr
Local nMesLim 		:= 2 //Quantidade de meses a considerar a partir da data do subcontrato  
Local nMes			:= Month(dDataBase) + nMesLim
Local cMes			:= strZero( If( nMes > 12, nMes % 12, nMes ),2 )
Local cAno			:= cValToChar( If( nMes > 12, Year(dDataBase) + 1, Year(dDataBase) ) )  
Local dLimite 		:= StoD(cAno + cMes + strZero(Day(dDataBase),2))
Local nTitAtrMax	:= GetNewPar("MV_YQATRE1",1)
Local cEstIni		:= mv_par01
Local cEstFim		:= mv_par02
Local cMunicDe 		:= mv_par03
Local cMunicAte		:= mv_par04
Local cMatUsrD      := mv_par06
Local cMatUsrA      := mv_par07
Local cGrpEmpresa	:= mv_par08
//Local cNomeIni		:= Upper(cLetraDe) + Space(TamSx3('BTS_NOMUSR')[1] - 1)
//Local cNomeFim		:= Upper(cLetraAte) + Replicate('Z',TamSx3('BTS_NOMUSR')[1] - 1)
Local cMatrD		:= Substr(cMatUsrD,9,6)
Local cMatrA		:= Substr(cMatUsrA,9,6)
Local lCritBloq		:= .T.

private _cDirDocs   := MsDocPath()
private _cPath		:= "C:\TEMP\"
private _cArquivo  	:= cNomRot+".csv"    // Alterada a extensão de TXT para CSV 
private cBuffer		:= ""
private oAbrArq 
private nHandle    

private nTotCCusto  := 0

Private cQuery		:= ''
Private nCont		:= 0

/*-----------------------------------------------------------------------
| Apaga arquivo se existir                                               |
 -----------------------------------------------------------------------*/
FErase( Alltrim(_cPath)+_cArquivo )
	                      
/*-----------------------------------------------------------------------
| Cria novo arquivo                                                      |
 -----------------------------------------------------------------------*/
nHandle := FCreate(Alltrim(_cPath) + _cArquivo)
	
if nHandle == -1
	MsgStop("Erro na criacao do arquivo na estacao local. Verifique se a planilha encontra-se aberta.")
	return
EndIf

/*-----------------------------------------------------------------------
| Montagem da query                                                      |
 -----------------------------------------------------------------------*/

cStrSQL := " SELECT BA1_DATNAS,BA1_DATINC,BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO,BA1_NOMUSR,BA1_TIPUSU,BA1_TIPUSU,BA1_ESTCIV,"	+ cCRLF
cStrSQL += "   BA1_DATCAR,BA1_VIACAR,BA1_OPERES,BA1_SEXO,BA1_CODPLA,BA1_GRAUPA,BA3_TIPOUS,BA1_CPFUSR,BA1_YDTLIM,BA1_CONEMP,BA1_SUBCON,BA1_DATBLO,"+ cCRLF
cStrSQL += "   BA1_DTVLCR,BA3_VALID, BA1_EMICAR " 																								+ cCRLF
cStrSQL += " FROM " + RetSqlName('BA1') + " BA1" 																									+ cCRLF
cStrSQL += " INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3.D_E_L_E_T_ = ' '"						 											+ cCRLF
cStrSQL += "  AND BA3_FILIAL = '" + xFilial('BA3') + "'"																							+ cCRLF
cStrSQL += "  AND BA3_CODINT = BA1_CODINT" 																										+ cCRLF
cStrSQL += "  AND BA3_CODEMP = BA1_CODEMP" 																										+ cCRLF
cStrSQL += "  AND BA3_MATRIC = BA1_MATRIC" 																										+ cCRLF
cStrSQL += " INNER JOIN " + RetSqlName('BTS') + " BTS ON BTS.D_E_L_E_T_ = ' '" 																	+ cCRLF
cStrSQL += "  AND BA1_MATVID = BTS_MATVID"																										+ cCRLF
cStrSQL += "  AND BTS_FILIAL = '" + xFilial('BTS') + "'"																							+ cCRLF
cStrSQL += " WHERE BA1.D_E_L_E_T_ = ' '"						 																					+ cCRLF
cStrSQL += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'"																							+ cCRLF
//cStrSQL += "  AND BA1_IMAGE = 'ENABLE'"   																											+ cCRLF // em 20.03.2014 por OSP
//cStrSQL += "	 AND BTS_NOMUSR BETWEEN '" + cNomeIni + "' AND '" + cNomeFim + "'"																	+ cCRLF
cStrSQL += "	 AND BTS_CODMUN BETWEEN '" + cMunicDe + "' AND '" + cMunicAte + "'"	 																+ cCRLF
cStrSQL += "	 AND BTS_ESTADO BETWEEN '" + cEstIni + "' AND '" + cEstFim + "'"	 																+ cCRLF
//cStrSQL += "	 AND BA1_CODEMP || BA1_MATRIC = ' '"																			  					+ cCRLF // em 20.03.2014 por OSP
cStrSQL += "	 AND BA1_MOTBLO = ' '"															   								  					+ cCRLF 
cStrSQL += "	 AND BA1_CODEMP = '" + cGrpEmpresa + "'" 								 															+ cCRLF

If !empty(mv_par10) .and. !empty(mv_par11)
	cStrSQL += "	 AND (	BA1_DTVLCR BETWEEN '" + DtoS(mv_par10) + "' AND '" + DtoS(mv_par11) + "' OR " 											+ cCRLF
	cStrSQL += "	 		(BA1_DTVLCR = ' ' AND BA3_VALID BETWEEN '" + DtoS(mv_par10) + "' AND '" + DtoS(mv_par11) + "'))"						+ cCRLF
EndIf

If  cMatUsrD >= cMatUsrA .AND. ( !empty(cMatUsrD) .AND. !empty(cMatUsrA) )
	cStrSQL 	+= "	AND BA1_MATRIC BETWEEN '" + cMatrD + "' AND '" + cMatrA + "' "		                     									+ cCRLF
EndIf

cStrSQL 	+= " ORDER BY BA1_NOMUSR "																												+ cCRLF

/*-----------------------------------------------------------------------
| Escreve a query na pasta TEMP                                          |
 -----------------------------------------------------------------------*/
MemoWrite(Alltrim(_cPath)+cNomRot+".SQL", cStrSQL)
                               
/*-----------------------------------------------------------------------
| Otimiza a query                                                        |
 -----------------------------------------------------------------------*/
cStrSQL := ChangeQuery( cStrSQL )                            

If Select(cAlias) > 0 ; dbSelectArea(cAlias) ; (cAlias)->( dbCloseArea() ) ; Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), cAlias, .T., .F.)                        

ProcRegua( (cAlias)->( RecCount() ) )

//+----------------------------------------------------------------+
//| Se tabela TRAB retornar VAZIO, não gera resumo e exibe mensagem |
//+----------------------------------------------------------------+
nCrit	:= 0
nTits  	:= 0
_lcab   := .T.
WHILE  (cAlias)->( !Eof() )
   _nConta  := 0
 
    nIdadeFut	:= nCalcIdade(StoD((cAlias)->BA1_DATNAS), dLimite)
	lDepend		:= (cAlias)->BA1_TIPUSU == 'D'  
	lMater		:= (cAlias)->BA1_CODPLA == '0001'
	lGrauPar	:= (cAlias)->BA1_GRAUPA $ '05|06|12|13|23|24' //(BRP) Graus de parentesco aos quais se aplica a regra
	cCodInt		:= (cAlias)->BA1_CODINT
	cCodEmp		:= (cAlias)->BA1_CODEMP
	cMatrUs		:= (cAlias)->BA1_MATRIC
	cConEmp   	:= (cAlias)->BA1_CONEMP
	cSubCon   	:= (cAlias)->BA1_SUBCON
	
	//INICIO DAS CRITICAS
    
	lCritBloq	:= .T.
	lCritica 	:= .F.
	cCritica 	:= ""
    
    If !empty((cAlias)->BA1_DATBLO) .and. StoD((cAlias)->BA1_DATBLO) <= dLimite
		lCritica 	:= .T.
		cCritica 	:= "Data de bloqueio (" + DtoC(StoD((cAlias)->BA1_DATBLO)) + ") menor ou igual a data limite (" + DtoC(dLimite) + ")"
    EndIf
    
    If ( lMater .and. lDepend .and. lGrauPar .and. nIdadeFut >= 24 ) .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Mater, dependente, parentesco (" + allTrim(posicione('BRP',1,xFilial('BRP')+(cAlias)->BA1_GRAUPA,'BRP_DESCRI')) + ") e " + ;
		"idade >= a 24 anos (em " + DtoC(dLimite) + ")"                                  
	EndIf                                                             

	If ( !empty((cAlias)->BA1_YDTLIM) .and. dLimite > StoD((cAlias)->BA1_YDTLIM) ) .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Data limite superior ao parametrizado - BA1_YDTLIM:" + (cAlias)->(DtoC(StoD((cAlias)->BA1_YDTLIM))) + "- data cálculo: " + DtoC(dLimite)
	EndIf

	If ( cEmpAnt == "02" .and. cGetNivel(cCodInt, cCodEmp, cMatrUs) < "4" ) .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Empresa INTEGRAL e nível de cobrança menor que 4"
		lCritBloq 	:= .F.
	EndIf
	
	If (cAlias)->(BA1_EMICAR) == '0'
    	lCritica 	:= .T.
		cCritica 	:= "Marcado para NUNCA EMITIR"
		lCritBloq 	:= .T.
	EndIf

	aDadUsr 	:= PLSDADUSR((cAlias)->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)

	If !aDadUsr[1] .and. !lCritica
    	lCritica 	:= .T.
	    cCritica 	:= "Usuário inválido"
    EndIf    
    
    If !lCritica
    
    	cCodCli := aDadUsr[58]
		cLoja   := aDadUsr[59]
		cNivCob	:= aDadUsr[61]
	
		If cPosTit == "1" // considerar apenas titulos em aberto
	
		    SE1->(dbSetOrder(8))
	
		    If SE1->(MsSeek(xFilial("SE1")+cCodCli+cLoja+"A"))
	
		       While ! SE1->(Eof()) .And. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_STATUS) == xFilial("SE1")+cCodCli+cLoja+"A"
	
		          If DtoS(dDataBase) > DtoS(SE1->E1_VENCREA)
	
		             If ( cNivCob >= "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC) == cCodInt+cCodEmp+cMatrUs ) .Or. ;
		                ( cNivCob <  "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_CONEMP+E1_SUBCON) == cCodInt+cCodEmp+cConEmp+cSubCon )
	
		                nTits     += 1
	
		             EndIf   
	
		          EndIf
	
		          SE1->(DbSkip())
	
		       EndDo
		
		    EndIf
		
		Else  //Considerar titulos em aberto/baixados
		
		    dDatIni := dDataBase - 365 // verifica ate 1 anos atraso
		
		    SE1->(dbSetOrder(8))
		
		    If SE1->(MsSeek(xFilial("SE1") + cCodCli + cLoja))
		
		       While ! SE1->(Eof()) .And. SE1->(E1_FILIAL + E1_CLIENTE + E1_LOJA) == xFilial("SE1") + cCodCli + cLoja
		
		          If DtoS(dDataBase) > DtoS(SE1->E1_VENCREA) .and. DtoS(dDatIni) <= DtoS(SE1->E1_EMISSAO)
		
		             If ( BA3->BA3_TIPOUS == "1" .And. SE1->(E1_CODINT + E1_CODEMP + E1_MATRIC) == cCodInt + cCodEmp + cMatrUs ) .or. ;
		                ( BA3->BA3_TIPOUS == "2" .And. SE1->(E1_CODINT + E1_CODEMP) == cCodInt + cCodEmp )
		
		                If SE1->E1_SALDO > 0
		                    nTits += 1
		                EndIf
		
		             EndIf
		
		          EndIf
		
		          SE1->(DbSkip())
		
		       EndDo
		
		    EndIf
		    	
		EndIf

	EndIf
		
	If nTits > nTitAtrMax .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Usuário inadimplente: títulos em aberto (" + cValToChar(nTits) + "), máximo permitido (" + cValToChar(nTitAtrMax) + ")"
	EndIf           
	
	//nTits  	:= 0
	
	If lCritica
		++nCrit
	EndIf
    
	//FIM DAS CRITICAS
	     
	lImpSoCrit := mv_par09 == 2 //Imprime somente com criticas
	
	If ( lImpSoCrit .and. lCritica ) .or. !lImpSoCrit


       if _lCab    
       _cCabec := PADR("MATRICULA"   ,022 ," ")+_cDeli+""+;
                  PADR("NOME_USUARIO",050 ," ")+_cDeli+""+;
                  PADR("CPF"         ,012 ," ")+_cDeli+""+;
                  PADR("NASCIMENTO"  ,014 ," ")+_cDeli+""+;                  
                  PADR("PARENTESCO"  ,015 ," ")+_cDeli+""+;                  
                  PADR("DTLIMITE"    ,011 ," ")+_cDeli+""+;                  
                  PADR("VIACAR"      ,005 ," ")+_cDeli+""+;                  
                  PADR("VALIDADE"    ,011 ," ")+_cDeli+""+;                  
                  PADR("CRITICA"     ,090 ," ")+_cDeli+""+;
                  PADR("TIPOCRITIC"  ,010 ," ")

       nCol1 := len(_cCabec) + 1  

       cBuffer :=  PADR( _cCabec ,nCol1,"") + cCRLF  
       FWrite(nHandle, cBuffer)
       _lcab := .f.
       endif
//       while (cAlias)->( !Eof() )
          lRet := .T.
          cValidade := If ( !empty((cAlias)->(BA1_DTVLCR)),DtoC(StoD((cAlias)->(BA1_DTVLCR))),DtoC(StoD((cAlias)->(BA3_VALID))) )	        

          _cLinha := (cAlias)->( PADR("'"+BA1_CODINT + '.' + BA1_CODEMP + '.' + BA1_MATRIC + '.' + BA1_TIPREG + '-' + BA1_DIGITO ,022 ," ")+_cDeli+""+;
                                 PADR(BA1_NOMUSR  ,050 ," ")+_cDeli+""+;
                                 PADR("'"+BA1_CPFUSR  ,012 ," ")+_cDeli+""+;  
                                 PADR(DtoC(StoD(BA1_DATNAS)) ,011 ," ")+_cDeli+""+;
                                 PADR(Posicione("BRP",1,xFilial("BRP") + BA1_GRAUPA,"BRP_DESCRI") ,015 ," ")+_cDeli+""+;
                                 PADR(DtoC(StoD(BA1_YDTLIM)) ,011 ," ")+_cDeli+""+;
                                 PADR(cValToChar(BA1_VIACAR) ,005 ," ")+_cDeli+""+;        
                                 PADR(cValidade ,011 ," ")+_cDeli+""+;                          
                                 PADR(If(lCritica,cCritica,'-') ,090 ," ")+_cDeli+""+;
                                 PADR(If(lCritica,If(lCritBloq,'BLOQUEIA','LIBERA'),'-'),010 ," ") )
          IncProc( (cAlias)->(BA1_CODINT + '.' + BA1_CODEMP + '.' + BA1_MATRIC + '.' + BA1_TIPREG + '-' + BA1_DIGITO) )
          _nConta ++    
          cBuffer :=  PADR( _cLinha ,nCol1,"") + cCRLF  
          FWrite(nHandle, cBuffer)                                         
*          (cAlias)->( DbSkip() )               	
*          if (cAlias)->( eof() )
*             //+---------------------------------------------------------------------+
*             //| Finaliza a listagem                                                 |
*             //+---------------------------------------------------------------------+
*             cBuffer := "Fim "
*             FWrite(nHandle, cBuffer)
*          endif
//      ENDDO
   ENDIF    
             (cAlias)->( DbSkip() )               	
          if (cAlias)->( eof() )
             //+---------------------------------------------------------------------+
             //| Finaliza a listagem                                                 |
             //+---------------------------------------------------------------------+
             cBuffer := "Fim "
             FWrite(nHandle, cBuffer)
          endif

ENDDO //ENDIF // (cAlias)->( !Eof() )

FClose(nHandle)

/*-----------------------------------------------------------------------
| Abre o arquivo no bloco de notas.                                      |
 -----------------------------------------------------------------------*/ 
cArq := Alltrim(_cPath)+_cArquivo

If ! ApOleClient( 'MsExcel' )
   MsgAlert( 'MsExcel nao instalado')
   Return
endIf

oExcelApp:= MsExcel():New()
oExcelApp:WorkBooks:Open( &("cArq" ) ) // Abre uma planilha
oExcelApp:SetVisible(.T.)              

//oExcelApp:WorkBooks:Close()
//oExcelApp:Quit()
//oExcelApp:Destroy()        

If Select(cAlias) > 0 ; dbSelectArea(cAlias) ; (cAlias)->( dbCloseArea() ) ; Endif

return

/*-----------------------------------------------------------------------
| Funcao   | cGetNivel  | Autor | Otavio Pinto       | Data | 11/08/2014 |
|------------------------------------------------------------------------|
| Descricao| Rotina de impressao                                         |
 -----------------------------------------------------------------------*/
Static Function cGetNivel(cCodInt, cCodEmp, cMatrUs)

Local a_BA1Area := BA1->( GetArea() )
Local a_BA3Area := BA3->( GetArea() )
Local c_Nivel := "10"
                
dbSelectArea("BA1")
dbSetOrder(1)
MsSeek( xFilial("BA1") + cCodInt + cCodEmp + cMatrUs)                           

dbSelectArea("BA3")
dbSetOrder(1)
MsSeek( xFilial("BA3") + cCodInt + cCodEmp + cMatrUs )

aCliente := PLSRETNCB(cCodInt, cCodEmp, cMatrUs, NIL)

c_Nivel := aCliente[5]

RestArea( a_BA1Area )
RestArea( a_BA3Area )

Return c_Nivel


/*-----------------------------------------------------------------------
| Funcao   | AjustaSX1  | Autor | Otavio Pinto       | Data | 11/08/2014 |
|------------------------------------------------------------------------|
| Descricao| Ajusta as perguntas do SX1                                  |
 -----------------------------------------------------------------------*/
Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aAdd(aHelp, "Estado (Unidade Federativa) inicial")      
PutSX1(cPerg , "01" , "Do Estado" 		,"","","mv_ch1","C",TamSx3('A1_EST')[1]		,0,0,"G",""	,"12"		,"","","mv_par01",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Estado (Unidade Federativa) final")      
PutSX1(cPerg , "02" , "Até o Estado" 	,"","","mv_ch2","C",TamSx3('A1_EST')[1]		,0,0,"G",""	,"12"		,"","","mv_par02",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o municipio inicial")      
PutSX1(cPerg , "03" , "Município de" 	,"","","mv_ch3","C",TamSx3('BTS_CODMUN')[1]		,0,0,"G",""	,"B57PLS"	,"","","mv_par03",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o municipio final")      
PutSX1(cPerg , "04" , "Município até" 	,"","","mv_ch4","C",TamSx3('BTS_CODMUN')[1]		,0,0,"G",""	,"B57PLS"	,"","","mv_par04",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a operadora do usuario")      
aAdd(aHelp, "(4 primeiros digitos da matricula)")      
PutSX1(cPerg , "05" , "Operadora"  		,"","","mv_ch5","C",TamSx3('BD7_OPEUSR')[1]	,0,0,"G",""	,""			,"","","mv_par05",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula do usuario.")      
aAdd(aHelp, "Caso este parametro esteja em")      
aAdd(aHelp, "branco, sera ignorado.")      
PutSX1(cPerg , "06" , "Matríc usuário De" 	,"","","mv_ch6","C",TamSx3('BE4_USUARI')[1],0,0,"G",""	,"MATUSR"	,"","","mv_par06",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a matricula do usuario.")      
aAdd(aHelp, "Caso este parametro esteja em")      
aAdd(aHelp, "branco, sera ignorado.")      
PutSX1(cPerg , "07" , "Matríc usuário Ate" 	,"","","mv_ch7","C",TamSx3('BE4_USUARI')[1],0,0,"G",""	,"MATUSR"	,"","","mv_par07",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

/*
aHelp := {}
aAdd(aHelp, "Informe letra inicial do nome")      
aAdd(aHelp, "do beneficiario.")      
PutSX1(cPerg,"07","Letra inicial de"		,"","","mv_ch7","C",01						,0,0,"G","","" ,"","","mv_par07",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe letra inicial do nome")      
aAdd(aHelp, "do beneficiario.")      
PutSX1(cPerg , "08" , "Letra inicial até" 	,"","","mv_ch8","C",01						,0,0,"G","",""	,"","","mv_par08",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)
*/
aHelp := {}
aAdd(aHelp, "Informe o grupo de empresas")      
PutSX1(cPerg , "08" , "Grupo de empresas" 	,"","","mv_ch8","C",TamSx3('BA1_CODEMP')[1],0,0,"G","",""	,"","","mv_par08",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Imprime somente com críticas?")      
PutSX1(cPerg , "09" , "Somente criticas" 	,"","","mv_ch9","N",1						,0,1,"C","",""	,"","","mv_par09","Não"			,"","","","Sim"		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de validade inicial")      
aAdd(aHelp, "Caso nao seja informado sera")      
aAdd(aHelp, "desconsiderado")      
PutSX1(cPerg , "10" , "Validade inicial" 	,"","","mv_cha","D",8						,0,0,"G","",""	,"","","mv_par10",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de validade final")      
aAdd(aHelp, "Caso nao seja informado sera")      
aAdd(aHelp, "desconsiderado")      
PutSX1(cPerg , "11" , "Validade final" 		,"","","mv_chb","D",8						,0,0,"G","",""	,"","","mv_par11",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return   

