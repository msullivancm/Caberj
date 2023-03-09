#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CABA022³    Autor ³ Renato Peixoto  ³ Data ³ 05/07/10       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Inclusão automática de PEGs. (Rateio AAG)      		       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³CABR026Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA022


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cRDAs         := ""

Private cNUPRE      := ""
Private cProd       := ""   
Private cEmpresa    := ""
Private nLoop       := 0  
Private lTrocouEmp  := .F.
Private lTrocouPro  := .F.

Private dDataIni    
Private dDataFim 
Private cCodRdaIni  := ""
Private cCodRdaFim  := ""
Private cCompet     := ""
Private dDtEvento //data da consulta que será passada por parâmetro (data do evento)
Private cGeraCtaM   := ""
Private cTipoRel    := ""
Private cCodAAG     := GetMV("MV_XCODAAG")
Private nCont       := 0
Private nTotNupre, nTotEmp, nTotGer, nQtdNUPRE, nQtdGeral := 0
Private aDados		:= {}
Private nValor      := 0
Private cPerg       := "CABA22"
Private aArray1     := {}  
Private cCodRDA     := ""
Private cOpeRDA     := ""
Private cLocalBB8   := "" //Local sequencial na tabela BB8
Private cCodEsp     := ""
Private cLocal      := "" //Local da tabela PA6 e da tabela BD1(Locais de atendimento)
Private cCodInt     := ""  
Private cNomInt     := ""
Private lOperDif    := .F. //Identifica se o usuário optou em processar mais de uma operadora 
Private cCodEmp     := ""
Private cMatric     := ""
Private cTipreg     := ""
Private cDigito     := ""
Private cNomUsr     := ""
Private cTelefone   := "" 
Private cSigla      := ""
Private cEstado     := ""
Private cNumReg     := ""
Private cCodPRF     := ""
Private cTpCon      := "1"
Private cSexo       := ""
Private cOpePeg     := ""
Private cAnoPag     := ""
Private cMesPag     := ""   
Private cMatAnt     := ""
Private cMatVid     := ""
Private cCodSol     := ""
Private cOpeUsr     := ""
Private cTipRDA     := ""
Private cTipReg     := ""
Private cCPFRDA     := ""
Private cDigito     := ""
Private cNomRDA     := ""
Private cNomSol     := ""
Private cCodEmp     := ""
Private cConEmp     := ""
Private cVerCon     := ""
Private cSubCon     := ""
Private cVerSub     := ""
Private dDatDig     := DDATABASE
Private cCodPad     := "01"
Private cCodPro     := "" //GETMV("MV_XPROAAG")
Private cTipPre     := ""
Private dDtDig1     := DDATABASE
Private nYVlTap     := 0
Private nVlrApr     := 0
Private nQtdApr     := 0 
Private nCont       := 0
Private nValNUPRE   := 0
Private cDesLocBB8  := ""
Private cBB8END     := ""
Private cBB8NR_END  := ""
Private cBB8COMEND  := ""
Private cBB8Bairro  := ""  
Private cIniProc    := "" //Data e hora de início do processo
Private cFimProc    := "" //Data e hora do final do processo  
Private lExistPGTO  := .F.
Private lExecuta    := .T.
private nOpcPag     := 1
Private cCompBd4	:= "" //Bianchini - P12 - Ajuste de Composição na BD7 de acordo com o procedimento a ser gravado
Private cCodProf    := "" //Bianchini - P12 - Ajuste de Composição na BD7 de acordo com o procedimento a ser gravado

cIniProc := "Data de início do processo: "+DTOC(date())+" - Hora: "+Time()
INCLUI := .T. //Chumbado como .T., pq essa variável é utilizada em um inicializador padrão de campo da tabela BD5
CriaSX1()

If !Pergunte(cPerg,.T.)
	Return
EndIf

nOpcPag     := Mv_Par13

If nOpcPag = 1
	If APMSGYESNO("Deseja gerar contas medicas para a competencia "+MV_PAR05+"?","Gerar contas medicas")
		DbSelectArea("PAE")
		DbSetOrder(1)
		If DbSeek(XFILIAL("PAE")+MV_PAR05)
			APMSGINFO("Atenção, já existe pagamento AAG gerado para a competência "+MV_PAR05+". Só serão processados pagamentos que ainda não tenham sido gerados.","Já existe pagamento AAG para esta competência!")
			lExistPGTO := .T.
		EndIf
	Else
		Return
	EndIf		                                                                                                                                                                                                                                                                                                            
Else 
	If APMSGYESNO("Deseja gerar pagamento complementar de contas medicas para a competencia "+MV_PAR05+"?","Gerar contas medicas")
	Else
		Return
	EndIf		                                                                                                                                                                                                                                                                                                            

EndIf
	
Processa({|| GERACTAMED()  },"Gerando contas médicas para o processo de rateio por NUPRE no projeto AAG...")

If !lExecuta //termina a execução caso não exista registro a ser processado...
	Return
EndIf

cFimProc := "Data do final do processo: "+DTOC(date())+" - Hora: "+Time()

MemoWrite("\Inclusao Ctas medicas rateio AAG\Controle_desempenho_inclusaoCtaMed_Rateio_AAG_"+DTOS(DDATABASE)+"_"+Time()+".txt", cIniProc + c_ent + cFimProc) //grava um txt na pasta especificada para controle de desempenho
APMSGINFO(cIniProc + c_ent + cFimProc,"Data de início e fim do processo.")

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERACTAMED  ºAutor  ³Renato Peixoto    º Data ³  13/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função que irá processar a geração de contas médicas para  º±±
±±º          ³ o processo de rateio por NUPREs no projeto AAG.            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GERACTAMED()

Local cQuery        := ""  
Local cQuery2       := ""   
Local cSQL          := ""       
Local cMatVids      := ""
Local cArqQry       := GetNextAlias()
Local cArqQry2      := GetNextAlias()
Local lDesblOK      := .T. 
Local aBloq         := {}
Local aDifUsu       := {} //Vetor que irá guardar a quantidade de usuários processados no caso de já haver pagamento gerado para a competencia escolhida

Private nContador   := 0  //contador para verificar se houve inclusão de algum registro no contas médicas e tb para constatar se não houve nenhum se for o caso...       

dDataIni    := Mv_Par01
dDataFim    := Mv_Par02
cLocalDe    := MV_PAR03
cLocalAte   := MV_PAR04
cCompet     := Mv_Par05
dDtEvento   := Mv_Par06
cTipoRel    := Mv_Par07 
cProjeto    := MV_PAR08
cOperIni    := MV_PAR09
cOperFin	:= MV_PAR10
cCodRdaIni  := Mv_Par11
cCodRdaFim  := Mv_Par12   
nOpcPag     := Mv_Par13

If nOpcPag = 1	  
  cCodPro     := GETMV("MV_XPROAAG")
  cCompBD4	  := 'RE1'	
Else
  cCodPro     := GETMV("MV_XPRCAAG")
  cCompBD4	  := 'REA'		
Endif	      

//VERIFICA DUPLICIDADE DE VIDA NO PAGAMENTO DO CP	
cSQL := "SELECT VERIF_DUPLIC_VIDAS_AAG(" + "'" + dtos(dDataIni) +  "'"  + "," 
cSQL += "'" + cLocalDe + "','" + cLocalAte + "') MATVIDS FROM DUAL "    
cSQL := ChangeQuery(cSQL)  
//MemoWrite("c:\caba022c.txt",cSQL)
PLSQuery(cSQL,"BDAAG")  
DbSelectArea("BDAAG")
BDAAG->(DbGotop())
While ! BDAAG->( Eof() )  
	cMatVids := BDAAG->MATVIDS
 	BDAAG->(DbSkip())
Enddo       
BDAAG->(DbCloseArea()) 

If !Empty(cMatVids)  
  Alert("Existem duplicidades de Vidas " + cMatVids + " nesta referencia, verifique antes de executar a rotina !!")  
  Final()
end if



If cOperIni <> cOperFin//MV_PAR10 <> MV_PAR11
	
	lOperDif := .T.

Else
	
	cNomInt := POSICIONE("BA0",1,XFILIAL("BA0")+cOperIni,"BA0_NOMINT")
	
EndIF


dbSelectArea("BF4")
                      
If !lExistPGTO // se não for encontrado nenhum registro gerado para a competência informada no parâmetro, será executada a query normal...
	cQuery := "SELECT PA6.PA6_CODNUP nupre, bf4_codpro, bf4_datbas, bf4_datblo, bf4_motblo, ba1_matvid, ba1_codint, ba1_codemp, ba1_matric, ba1_tipreg, "+c_ent //27-06-2011
	cQuery += "ba1_digito,ba1_nomusr, ba1_datblo, ba1_telefo, ba1_sexo, ba1_matant, ba1_conemp, ba1_vercon, ba1_subcon, ba1_versub, BA3_CODPLA, BI3_DESCRI, "+c_ent
	cQuery += "PA6_CODINT, PA6_CODNUP, PA6_NOMNUP, PA6_CODRDA, PA6_DESRDA, PA6_VALIND, PA6_DTINI, PA6_CODLOC "+c_ent
	cQuery += "FROM   "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BA3")+" BA3, "+RetSqlName("BI3")+" BI3, "+RetSqlName("PA6")+" PA6 "+c_ent
	cQuery += "WHERE  bf4.bf4_filial = '  ' AND ba1.ba1_filial = '  ' AND BA3.BA3_FILIAL = '  '    AND BI3.BI3_FILIAL = '  '    AND PA6.PA6_FILIAL = '  ' "+c_ent
	cQuery += "	   AND    bf4.bf4_codpro = '"+cProjeto+"' "+c_ent
	cQuery += "    AND BA1.BA1_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODLOC BETWEEN '"+cLocalDe+"' AND '"+cLocalAte+"' "+c_ent
	If cCodRDAIni < cCodRDAFim
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRdaIni+"' AND '"+cCodRDAFim+"' "+c_ent
	Else
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRDAFim+"' AND '"+cCodRDAIni+"' "+c_ent
	EndIf      
	
cQuery += "    AND    ba1.ba1_filial = bf4.bf4_filial "+c_ent
	cQuery += "    AND    ba1.ba1_codint = bf4.bf4_codint "+c_ent
	cQuery += "    AND    ba1.ba1_codemp = bf4.bf4_codemp "+c_ent
	cQuery += "	   AND    ba1.ba1_matric = bf4.bf4_matric "+c_ent
	cQuery += "    AND    ba1.ba1_tipreg = bf4.bf4_tipreg "+c_ent
	cQuery += "    AND BF4.BF4_CODINT = BA3.BA3_CODINT "+c_ent
	cQuery += "    AND BF4.BF4_CODEMP = BA3.BA3_CODEMP "+c_ent
	cQuery += "    AND BF4.BF4_MATRIC = BA3.BA3_MATRIC "+c_ent
	cQuery += "    AND BA3.BA3_CODPLA = BI3.BI3_CODIGO "+c_ent
		
 	cQuery += "    AND RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataIni)+"') = PA6.PA6_CODNUP "+c_ent //27-06-2011
    
    cQuery += "    AND PA6.PA6_DTBLOQ = ' ' "+c_ent
	
	// Motta 07/07/11 cQuery += "	   AND    ('"+DTOS(dDataFim)+"' BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),'"+DTOS(dDataFim)+"') OR ( (SELECT bg3_tipblo FROM "+RetSqlName("BG3")+" BG3 WHERE bg3_filial = ' ' AND bg3_codblo = bf4_motblo AND D_E_L_E_T_ = ' ' )='1')) "+c_ent
	// Motta 07/07/11 cQuery += "    AND    '"+DTOS(dDataFim)+"' BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),'"+DTOS(dDataFim)+"') "+c_ent
	If nOpcPag = 1
	  cQuery += "	   AND    ('"+DTOS(dDataIni)+"' BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),'"+DTOS(dDataFim)+"') OR ( (SELECT bg3_tipblo FROM "+RetSqlName("BG3")+" BG3 WHERE bg3_filial = ' ' AND bg3_codblo = bf4_motblo AND D_E_L_E_T_ = ' ' )='1')) "+c_ent
	  cQuery += "    AND    '"+DTOS(dDataIni)+"' BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),'"+DTOS(dDataFim)+"') "+c_ent
	Else
	  cQuery += "    AND    BA1_MATRIC IN (SELECT PAE_MATRIC " +c_ent 
      cQuery += " 							FROM "+RetSqlName("PAE")+" PAE "+c_ent
      cQuery += "							WHERE PAE.PAE_FILIAL = '  ' AND PAE.PAE_COMPET = '"+cCompet+"' AND PAE.PAE_CODNUP = PA6.PA6_CODRDA "+c_ent
      cQuery += "							AND PAE.PAE_CODEMP = BA1.BA1_CODEMP AND PAE.PAE_MATRIC = BA1.BA1_MATRIC AND PAE.PAE_TIPREG = BA1.BA1_TIPREG "+c_ent
      cQuery += "							AND PAE.PAE_DIGITO = BA1.BA1_DIGITO AND PAE.D_E_L_E_T_ = ' ') "+c_ent
    Endif
	
	cQuery += "    AND    bf4.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    ba1.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    BA3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    BI3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    PA6.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    ORDER  BY PA6.PA6_CODNUP, BF4_CODEMP, BA1_CODINT, BA3_CODPLA "   //CODINT acrescentado no order by	 //27-06-2011

Else //caso já exista algum registro gerado par a competência informada, a query a ser rodada será uma query que irá trazer apenas os resitros que não foram gerados ainda para a competência informada (se houver algum)...
    
	cQuery := "SELECT PA6.PA6_CODNUP nupre, bf4_codpro, bf4_datbas, bf4_datblo, bf4_motblo, ba1_matvid, ba1_codint, ba1_codemp, ba1_matric, ba1_tipreg, "+c_ent //27-06-2011
	cQuery += "ba1_digito,ba1_nomusr, ba1_datblo, ba1_telefo, ba1_sexo, ba1_matant, ba1_conemp, ba1_vercon, ba1_subcon, ba1_versub, BA3_CODPLA, BI3_DESCRI, "+c_ent
	cQuery += "PA6_CODINT, PA6_CODNUP, PA6_NOMNUP, PA6_CODRDA, PA6_DESRDA, PA6_VALIND, PA6_DTINI, PA6_CODLOC "+c_ent
	cQuery += "FROM   "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BA3")+" BA3, "+RetSqlName("BI3")+" BI3, "+RetSqlName("PA6")+" PA6 "+c_ent
	cQuery += "WHERE  bf4.bf4_filial = '  ' AND ba1.ba1_filial = '  ' AND BA3.BA3_FILIAL = '  '    AND BI3.BI3_FILIAL = '  '    AND PA6.PA6_FILIAL = '  ' "+c_ent
	cQuery += "	   AND    bf4.bf4_codpro = '"+cProjeto+"' "+c_ent
	cQuery += "    AND BA1.BA1_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODLOC BETWEEN '"+cLocalDe+"' AND '"+cLocalAte+"' "+c_ent
	If cCodRDAIni < cCodRDAFim
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRdaIni+"' AND '"+cCodRDAFim+"' "+c_ent
	Else
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRDAFim+"' AND '"+cCodRDAIni+"' "+c_ent
	EndIf                
	cQuery += "    AND    ba1.ba1_filial = bf4.bf4_filial "+c_ent
	cQuery += "    AND    ba1.ba1_codint = bf4.bf4_codint "+c_ent
	cQuery += "    AND    ba1.ba1_codemp = bf4.bf4_codemp "+c_ent
	cQuery += "	   AND    ba1.ba1_matric = bf4.bf4_matric "+c_ent
	cQuery += "    AND    ba1.ba1_tipreg = bf4.bf4_tipreg "+c_ent
	cQuery += "    AND BF4.BF4_CODINT = BA3.BA3_CODINT "+c_ent
	cQuery += "    AND BF4.BF4_CODEMP = BA3.BA3_CODEMP "+c_ent
	cQuery += "    AND BF4.BF4_MATRIC = BA3.BA3_MATRIC "+c_ent
	cQuery += "    AND BA3.BA3_CODPLA = BI3.BI3_CODIGO "+c_ent
	
	cQuery += "    AND RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataIni)+"') = PA6.PA6_CODNUP "+c_ent //27-06-2011
    
    cQuery += "    AND PA6.PA6_DTBLOQ = ' ' "+c_ent
	
	// Motta 07/07/11 cQuery += "	   AND    ('"+DTOS(dDataFim)+"' BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),'"+DTOS(dDataFim)+"') OR ( (SELECT bg3_tipblo FROM "+RetSqlName("BG3")+" BG3 WHERE bg3_filial = ' ' AND bg3_codblo = bf4_motblo AND D_E_L_E_T_ = ' ' )='1')) "+c_ent
	// Motta 07/07/11 cQuery += "    AND    '"+DTOS(dDataFim)+"' BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),'"+DTOS(dDataFim)+"') "+c_ent
	
	cQuery += "	   AND    ('"+DTOS(dDataIni)+"' BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),'"+DTOS(dDataFim)+"') OR ( (SELECT bg3_tipblo FROM "+RetSqlName("BG3")+" BG3 WHERE bg3_filial = ' ' AND bg3_codblo = bf4_motblo AND D_E_L_E_T_ = ' ' )='1')) "+c_ent
	cQuery += "    AND    '"+DTOS(dDataIni)+"' BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),'"+DTOS(dDataFim)+"') "+c_ent
	
	cQuery += "    AND    BA1_MATRIC NOT IN(SELECT PAE_MATRIC " +c_ent 
    cQuery += " 							FROM "+RetSqlName("PAE")+" PAE "+c_ent
    cQuery += "								WHERE PAE.PAE_FILIAL = '  ' AND PAE.PAE_COMPET = '"+cCompet+"' AND PAE.PAE_CODNUP = PA6.PA6_CODRDA "+c_ent
    cQuery += "								AND PAE.PAE_CODEMP = BA1.BA1_CODEMP AND PAE.PAE_MATRIC = BA1.BA1_MATRIC AND PAE.PAE_TIPREG = BA1.BA1_TIPREG "+c_ent
    cQuery += "								AND PAE.PAE_DIGITO = BA1.BA1_DIGITO AND PAE.D_E_L_E_T_ = ' ') "+c_ent
    //Fim alteração Renato Peixoto
	cQuery += "    AND    bf4.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    ba1.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    BA3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    BI3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    PA6.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    ORDER  BY PA6.PA6_CODNUP, BF4_CODEMP, BA1_CODINT, BA3_CODPLA " //27-06-2011
EndIf

memowrit("C:\CABA022.SQL",cQuery)

erro := 5 / 0;

If Select(cArqQry) > 0
	(cArqQry)->(DbCloseArea())
EndIf

*--------------------------------------------*
*** Cria o alias executando a query
*--------------------------------------------*
DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.F.,.T.)


dbSelectArea(cArqQry)
(cArqQry)->(DbGoTop()) 
COUNT to nCont // Conta o total de registros na tabela
DbGotop()

ProcRegua(nCont)

If nCont = 0
	APMSGINFO("Atenção, não existem pagamentos a serem gerados de acordo com os parâmetros informados.","Não existe registro a ser processado.")
	lExecuta := .F.
	Return
EndIf

While !((cArqQry)->(Eof()))
    aArray1 := {}//zero o vetor a cada loop
    
    If lExistPGTO
    	aAdd ( aDifUsu, { (cArqQry)->NUPRE, (cArqQry)->PA6_NOMNUP, (cArqQry)->PA6_CODRDA, (cArqQry)->BA1_CODINT, (cArqQry)->BA1_CODEMP, (cArqQry)->BA1_MATRIC, (cArqQry)->BA1_TIPREG, (cArqQry)->BA1_DIGITO, (cArqQry)->BA1_NOMUSR} )
    EndIf
    
    //teste motta lDesblOK := .T.
	//Motta 07/07/11//Trata quando o usuário já foi bloqueado no AAG em alguma data. Se o desbloqueio ocorreu após a data até do parâmetro, o registro não é para ser considerado.
    //Motta 07/07/11//Renato Peixoto em 29/09/10
    //Motta 07/07/11// Motta 30/05/2011 If !Empty((cArqQry)->BF4_MOTBLO )
    //Motta 07/07/11	
    //Motta 07/07/11	cQuery2 := "SELECT BGU_MATRIC, BGU_TIPO, BGU_DATA, BGU_MOTBLO, BGU_CODPRO "+c_ent
    //Motta 07/07/11	cQuery2 += "FROM "+RetSqlName("BGU")+" BGU "+c_ent	
	//Motta 07/07/11	cQuery2 += "WHERE BGU_FILIAL = '"+XFILIAL("BGU")+"' "+c_ent
	//Motta 07/07/11	cQuery2 += "AND BGU_MATRIC = '"+(cArqQry)->BA1_CODINT+(cArqQry)->BA1_CODEMP+(cArqQry)->BA1_MATRIC+"' "+c_ent
	//Motta 07/07/11	cQuery2 += "AND BGU_CODPRO = '"+(cArqQry)->BF4_CODPRO+"' "+c_ent
	//Motta 07/07/11	cQuery2 += "AND BGU_TIPREG = '"+(cArqQry)->BA1_TIPREG+"' "+c_ent
	//Motta 07/07/11	cQuery2 += "AND BGU.D_E_L_E_T_ = ' ' "+c_ent
	//Motta 07/07/11	cQuery2 += "ORDER BY BGU_DATA, BGU_TIPO "  //BGU_TIPO incluído por Renato Peixoto, pois certas vezes ocorre bloqueio de desbloqueio no mesmo dia.
    //Motta 07/07/11
    //Motta 07/07/11	If Select(cArqQry2) > 0
    //Motta 07/07/11			(cArqQry2)->(DbCloseArea())
	//Motta 07/07/11	EndIf
    //Motta 07/07/11
	//Motta 07/07/11	*--------------------------------------------*
    //Motta 07/07/11	*** Cria o alias executando a query
	//Motta 07/07/11	*--------------------------------------------*
	//Motta 07/07/11	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery2),cArqQry2,.F.,.T.)
	//Motta 07/07/11	
    //Motta 07/07/11	While !((cArqQry2)->(Eof())) .AND. AllTrim((cArqQry2)->BGU_MATRIC) == AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC)	
    //Motta 07/07/11		If (cArqQry2)->BGU_TIPO = "0" 
    //Motta 07/07/11			If STOD((cArqQry2)->BGU_DATA) < dDataIni 
    //Motta 07/07/11				lDesblOK := .F.
    //Motta 07/07/11				(cArqQry2)->(DbSkip())
    //Motta 07/07/11				Loop
    //Motta 07/07/11			Else
    //Motta 07/07/11				If STOD((cArqQry2)->BGU_DATA) < dDataFim
    //Motta 07/07/11					lDesblOK := .T.
    //Motta 07/07/11					Exit
    //Motta 07/07/11				Else
    //Motta 07/07/11					lDesblOK := .T.
    //Motta 07/07/11				EndIf
    //Motta 07/07/11			EndIf  
    //Motta 07/07/11		Else
    //Motta 07/07/11			If STOD((cArqQry2)->BGU_DATA) > dDataFim
    //Motta 07/07/11				lDesblOK := .F.
    //Motta 07/07/11			Else
    //Motta 07/07/11				If STOD((cArqQry2)->BGU_DATA) >= dDataIni .AND. STOD((cArqQry2)->BGU_DATA) <= dDataFim
    //Motta 07/07/11					lDesblOK := .T.
    //Motta 07/07/11					Exit
    //Motta 07/07/11				Else
    //Motta 07/07/11					lDesblOk := .T.
    //Motta 07/07/11				EndIf
    //Motta 07/07/11			EndIf
    //Motta 07/07/11		EndIf
    //Motta 07/07/11		(cArqQry2)->(DbSkip())
    //Motta 07/07/11	EndDo
    //Motta 07/07/11	(cArqQry2)->(DbCloseArea())
    //Motta 07/07/11// Motta 30/05/2011 EndIf
    //Motta 07/07/11
    //Motta 07/07/11If !lDesblOK 
    //Motta 07/07/11	aAdd ( aBloq, { (cArqQry)->NUPRE, (cArqQry)->PA6_CODRDA,AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC), (cArqQry)->BA1_NOMUSR } )
    //Motta 07/07/11	(cArqQry)->(DbSkip())
    //Motta 07/07/11	Loop
    //Motta 07/07/11EndIf
    				
    
	IncProc("Processando inclusão de contas médicas para rateio AAG...")
	nLoop++ 
	cCodEmp     := (cArqQry)->BA1_CODEMP
    cMatric     := (cArqQry)->BA1_MATRIC
    cTipreg     := (cArqQry)->BA1_TIPREG
	cDigito     := (cArqQry)->BA1_DIGITO
	
	If lOperDif
	
		If nLoop = 1
	 
			cNomInt := POSICIONE("BA0",1,XFILIAL("BA0")+(cArqQry)->BA1_CODINT,"BA0_NOMINT")
	
		Else
		
			If cCodInt <> (cArqQry)->BA1_CODINT
		
				cNomInt := POSICIONE("BA0",1,XFILIAL("BA0")+(cArqQry)->BA1_CODINT,"BA0_NOMINT") 
		
			EndIf
		
		EndIf
	
	EndIf
	  

	If (cArqQry)->PA6_CODRDA <> cCodRDA
		cCodRDA   := (cArqQry)->PA6_CODRDA
		cCodInt   := (cArqQry)->BA1_CODINT
		nValNUPRE := (cArqQry)->PA6_VALIND
		DbSelectArea("BAU")
		DbSetOrder(1)
		MSSeek(XFILIAL("BAU")+(cArqQry)->PA6_CODRDA)
		cLocalBB8  := POSICIONE("BB8",3,XFILIAL("BB8")+(cArqQry)->PA6_CODRDA+(cArqQry)->BA1_CODINT+(cArqQry)->PA6_CODLOC,"BB8_CODLOC")
		cDesLocBB8 := POSICIONE("BB8",3,XFILIAL("BB8")+(cArqQry)->PA6_CODRDA+(cArqQry)->BA1_CODINT+(cArqQry)->PA6_CODLOC,"BB8_DESLOC")
		cBB8END    := POSICIONE("BB8",3,XFILIAL("BB8")+(cArqQry)->PA6_CODRDA+(cArqQry)->BA1_CODINT+(cArqQry)->PA6_CODLOC,"BB8_END")
		cBB8NR_END := POSICIONE("BB8",3,XFILIAL("BB8")+(cArqQry)->PA6_CODRDA+(cArqQry)->BA1_CODINT+(cArqQry)->PA6_CODLOC,"BB8_NR_END")
		cBB8COMEND := POSICIONE("BB8",3,XFILIAL("BB8")+(cArqQry)->PA6_CODRDA+(cArqQry)->BA1_CODINT+(cArqQry)->PA6_CODLOC,"BB8_COMEND")
		cBB8Bairro := POSICIONE("BB8",3,XFILIAL("BB8")+(cArqQry)->PA6_CODRDA+(cArqQry)->BA1_CODINT+(cArqQry)->PA6_CODLOC,"BB8_BAIRRO")
		cCodEsp    := POSICIONE("BAX",1,XFILIAL("BAX")+(cArqQry)->PA6_CODRDA+(cArqQry)->BA1_CODINT+cLocalBB8,"BAX_CODESP")
	
		cCodProf   := BAU->BAU_CODBB0
	EndIf
	
	If Empty(cLocalBB8)
		APMSGSTOP("Atenção, não existe código de localidade cadastrado para o RDA "+(cArqQry)->PA6_CODRDA+", operadora "+(cArqQry)->BA1_CODINT+" e local "+(cArqQry)->PA6_CODLOC+". Favor cadastrar antes de realizar este processo. ","Processo não pode ser realizado.")
		Return
	EndIf

	If Empty(cCodEsp)
		APMSGSTOP("Atenção, não existe especialidade cadastrada para o RDA "+(cArqQry)->PA6_CODRDA+", operadora "+(cArqQry)->BA1_CODINT+" e local "+(cArqQry)->PA6_CODLOC+". Favor cadastrar antes de realizar este processo. ","Processo não pode ser realizado.")
		Return
	EndIf
   
	aAdd ( aArray1  , { {"FILIAL",XFILIAL("BAU")},;
	{"CODRDA",(cArqQry)->PA6_CODRDA},;
	{"OPERDA",(cArqQry)->PA6_CODINT},;
	{"CODINT",(cArqQry)->BA1_CODINT},;  //No BD5 é CODOPE
	{"NOMINT",cNomInt},;
	{"DATA",dDtEvento},; 
	{"DATPRO", dDtEvento},; 
	{"HORPRO",STRTRAN(substr(time(),1,5),":","")},;
	{"NOMUSR",(cArqQry)->BA1_NOMUSR},;
	{"TELEFO",(cArqQry)->BA1_TELEFO},;
	{"CODESP",cCodEsp},;
	{"CODLOC",cLocalBB8},;
	{"LOCAL",(cArqQry)->PA6_CODLOC},;
	{"SIGLA",BAU->BAU_SIGLCR},;
	{"ESTCR",BAU->BAU_ESTCR},;  
	{"REGSOL",BAU->BAU_CONREG},;
	{"NOMSOL",BAU->BAU_NOME},;
	{"CDPFSO",BAU->BAU_CODBB0},;
	{"REGEXE",BAU->BAU_CONREG},; //Acrescentado por Renato Peixoto em 25/10/2010   {"NOMEXE",BAU->BAU_NOME},;   //Esse campo é virtual
	{"TIPCON","1"},;  //Estava "TPCON", mas na BD5 e BD6 esse campo aparece como "TIPCON". Alterado em 25/10/2010 por Renato Peixoto.
	{"SEXO",(cArqQry)->BA1_SEXO},;
	{"ANOPAG",SUBSTR(cCompet,3,4)},;
	{"MESPAG",SUBSTR(cCompet,1,2)},;
	{"MATANT",(cArqQry)->BA1_MATANT},;    
	{"MATVID",(cArqQry)->BA1_MATVID},;
	{"OPEUSR",(cArqQry)->BA1_CODINT},;
	{"TIPRDA",BAU->BAU_TIPPE},;
	{"MATRIC",(cArqQry)->BA1_MATRIC},;  
	{"TIPREG",(cArqQry)->BA1_TIPREG},;	   
	{"CPFRDA",BAU->BAU_CPFCGC},; 
	{"DIGITO",(cArqQry)->BA1_DIGITO},;
	{"NOMRDA",BAU->BAU_NOME},;  //{"NOMSOL",BAU->BAU_NOME},; estava logo após NOMRDA. Alterado por Renato Peixoto em 25/10/2010
	{"CODEMP",(cArqQry)->BA1_CODEMP},;  
	{"CONEMP",(cArqQry)->BA1_CONEMP},;
	{"VERCON",(cArqQry)->BA1_VERCON},;
	{"SUBCON",(cArqQry)->BA1_SUBCON},;	
	{"VERSUB",(cArqQry)->BA1_VERSUB},;
	{"DATDIG",DDATABASE},;
	{"CODPAD","01"},;
	{"CODPRO",cCodPro},;
	{"TIPPRE",BAU->BAU_TIPPRE},;
	{"DTDIG1",DDATABASE},;
	{"YVLTAP", (cArqQry)->PA6_VALIND},;//nao aparece no BD5
	{"VLRAPR", (cArqQry)->PA6_VALIND},;
	{"QTDAPR", 1},;//nao aparece na bd5
	{"QTDPRO", 1},;//nao aparece na BD5
	{"BLOCPA", "1"},;  //bloqueia a cobranca da co-participacao     Na BD5 o campo é BLOPAG
	{"DESBPF", "INFORMAR A DESCRICAO DO MOTIVO"},; 
	{"TIPSAI", "5"},;
	{"ORIMOV", "1"},; 
	{"DESLOC", cDesLocBB8},;
	{"ENDLOC", AllTrim(cBB8END)+"+"+AllTrim(cBB8NR_END)+"-"+AllTrim(cBB8COMEND)+"-"+AllTrim(cBB8BAIRRO)},; 
	{"MOTBPF", "999"},;     // INFORME O CODIGO DO BLOQUEIO DA COPARTICIPACAO DE ACORDO COM A TABELA DE BLOQUEIO  Na BD5 é MOTBPG
	{"TIPATE", "04"} }) //código 04 - Consulta
	 //colocar "QTDEVE" como 1

	If nLoop = 1
	
		cNUPRE := (cArqQry)->PA6_CODNUP
		nValor := (cArqQry)->PA6_VALIND
		
	EndIf
	
   	U_CABAGRVGUI()
   	
	//Após cada inclusão no contas médicas, processar a inclusão na tabela de controle (PAE)  
	If nOpcPag = 1
		RecLock("PAE",.T.)
		PAE->PAE_FILIAL := XFILIAL("PAE")
		PAE->PAE_CODNUP := (cArqQry)->PA6_CODRDA
		PAE->PAE_COMPET := cCompet
		PAE->PAE_NOMNUP := (cArqQry)->PA6_NOMNUP
		PAE->PAE_CODINT := (cArqQry)->BA1_CODINT
		PAE->PAE_CODEMP := (cArqQry)->BA1_CODEMP
		PAE->PAE_MATRIC := (cArqQry)->BA1_MATRIC
		PAE->PAE_TIPREG := (cArqQry)->BA1_TIPREG
		PAE->PAE_DIGITO := (cArqQry)->BA1_DIGITO
		PAE->PAE_NOMUSR := (cArqQry)->BA1_NOMUSR
		PAE->(MsUnlock())
	Endif

	(cArqQry)->(DbSkip())
	   		
Enddo
//Gera um relatório em excel com usuários com problema de bloqueio no AAG
If Len(aBloq) > 0
	DlgToExcel({{"ARRAY","Os usuários abaixo apresentam problemas com bloqueio no AAG:","",aBloq}}) 
EndIf
//Se já houve pagamento para a competencia escolhida, ao final do processo irá gerar um relatorio em excel dos usuarios que foram processados
If lExistPGTO .AND. Len(aDifUsu) > 0
   	DlgToExcel({{"ARRAY","Os usuários abaixo foram processados com sucesso para esta competência:","",aDifUsu}}) 
EndIf

dbSelectArea(cArqQry)
(cArqQry)->(dbCloseArea())

APMSGINFO("Processo de inclusão automática de contas médicas finalizado com sucesso. O Relatório de total de usuários por NUPRE será exibido em seguida. Por favor, aguarde.","Processo finalizado.")
//Chama o relatório de qtd de usuários por NUPRE
//03/05/11 novo parametro do CABR026 (Base Carregada) 
U_CABR026(dDataIni,dDataFim,cLocalDe,cLocalAte,cCompet,dDtEvento,cTipoRel,cProjeto,cOperIni,cOperFin,cCodRdaIni,cCodRdaFim,2) 

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CriaSX1  ³ Autor ³ Renato Peixoto        ³ Data ³ 22/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Atualiza perguntas                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Dt. Analise de:")		 ,"","","mv_ch1","D",08,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina a partir de qual data será feito o filtro"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Dt. Analise ate:")		 ,"","","mv_ch2","D",08,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina ate qual data será feito o filtro"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Local atendimento de:") ,"","","mv_ch3","C",06,0,0,"G","","PA6LOC","","","mv_par03",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina a partir de qual local de atendimento será feito o filtro"},{""},{""})
PutSx1(cPerg,"04",OemToAnsi("Local atendimento ate:"),"","","mv_ch4","C",06,0,0,"G","","PA6LOC","","","mv_par04",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina ate qual local de atendimento será feito o filtro"},{""},{""})
PutSx1(cPerg,"05",OemToAnsi("Competencia Pgto:")     ,"","","mv_ch5","C",06,0,0,"G","","   ","","","mv_par05",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será a competencia de Pgto no formato mmaaaa"},{""},{""})
PutSx1(cPerg,"06",OemToAnsi("Data do Evento:")       ,"","","mv_ch6","D",08,0,0,"G","","   ","","","mv_par06",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será a data do evento"},{""},{""})
PutSx1(cPerg,"07",OemToAnsi("Tipo de Relatório:")    ,"","","mv_ch7","C",01,0,0,"C","","   "   ,"","","mv_par07","Analitico","","","","Sintetico","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Qual Projeto?")         ,"","","mv_ch8","C",04,0,0,"G","","BI3COD","","","mv_par08",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será o Projeto"},{""},{""})
PutSx1(cPerg,"09",OemToAnsi("Código Operadora de:")  ,"","","mv_ch9","C",04,0,0,"G","","B89PLS","","","mv_par09",""   ,"","","",""   ,"","","","","","","","","","","",{"A partir de qual operadora?"},{""},{""})
PutSx1(cPerg,"10",OemToAnsi("Código Operadora Ate:") ,"","","mv_ch10","C",04,0,0,"G","","B89PLS","","","mv_par10",""   ,"","","",""   ,"","","","","","","","","","","",{"Ate qual operadora?"},{""},{""})
PutSx1(cPerg,"11",OemToAnsi("RDA De:")               ,"","","mv_ch11","C",06,0,0,"G","","PA6RDA","","","mv_par11",""   ,"","","",""   ,"","","","","","","","","","","",{"A partir de qual RDA?"},{""},{""})
PutSx1(cPerg,"12",OemToAnsi("RDA Ate:")              ,"","","mv_ch12","C",06,0,0,"G","","PA6RDA","","","mv_par12",""   ,"","","",""   ,"","","","","","","","","","","",{"Ate qual RDA?"},{""},{""})
PutSx1(cPerg,"13",OemToAnsi("Opcão do Relatório:")    ,"","","mv_ch13","C",01,0,0,"C","","   "   ,"","","mv_par13","Mensal","","","","Complementar","","","","","","","","","","","",{"Pagamento Mensal ou Complementar."},{},{})

Return                           



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CABAFRVGUI ³ Autor ³ Luzio Tavares        ³ Data ³ 24.06.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Grava dados de consulta em um PEG e GUIA                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function CABAGRVGUI(/*cNumAte,dDataBase*/)

Local nQ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local I__f := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declara variaveis da rotina...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nH := PLSAbreSem("CABAGRVGUI.SMF")
LOCAL cNumGuia
LOCAL nFor
LOCAL nTmp
LOCAL nAux
LOCAL aFiles
LOCAL cAliasAux
LOCAL nPos
LOCAL cAliasPri
LOCAL cCpoFase
LOCAL aColsAux
LOCAL cCampos
LOCAL aStruARQ    := {}

LOCAL aRetCal     := PLSXVLDCAL(dDtEvento,cCodInt,.F.)    // Valida o calendario de pagamento da operadora
LOCAL cAnoBase    := aRetCal[4]
LOCAL cMesBase    := aRetCal[5]
LOCAL nHESP
LOCAL nStackSX8   := GetSx8Len()
Local aHeaderBE2  := {}

PRIVATE cOpeRDA   := cCodInt
//PRIVATE cCodRDA   := cCodRda já é declarada como private na função que chama esta
PRIVATE cNomRDA   := BAU->BAU_NOME
PRIVATE cTipRDA   := BAU->BAU_TIPPE
PRIVATE cFunGRV
PRIVATE cTipGRV
PRIVATE cTipoGuia
PRIVATE cGuiRel
PRIVATE cNewPEG
PRIVATE aDadUSR := PLSDADUSR(cCodInt+cCodEmp+cMatric+cTipreg+cdigito,"1",.T.,dDataBase/*dDatLan*/)  //busca dados do usuario a ser lancado

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe o PEG eletronico do mes para o credenciado...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BCI->(DbSetOrder(4))

If !(aRetCal[1])
	APMSGSTOP("Atenção, não existe calendario de pagamento para a data em questão ou os parâmetros de pagamento desse mês não foram configurados. Favor Verificar antes de realizar este processo.","Processo não pode ser realizado.")
	Return
EndIf

nHESP := PLSAbreSem("PLSPEG.SMF")
//Ordem 4 da BCI: BCI_FILIAL + BCI_OPERDA + BCI_CODRDA+ BCI_ANO + BCI_MES + BCI_TIPO + BCI_FASE + BCI_SITUAC + BCI_TIPGUI + BCI_CODLDP + BCI_ARQUIV                               
//If ! BCI->(MsSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoBase+cMesBase+"211"+"02"+"0001")) 
If ! BCI->(MsSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoBase+cMesBase+"211"+"02"+"0017")) 
	
	cNewPEG := PLSA175Cod(cOpeRDA,"0001")//GetNewPar("MV_PLSPEGE","0000"))
	
	BCI->(RecLock("BCI",.T.))
	BCI->BCI_FILIAL := xFilial("BCI")
	BCI->BCI_CODOPE := cOpeRDA
	BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
	BCI->BCI_CODLDP := '0017'//"0001" //GetNewPar("MV_PLSPEGE","0001")
	BCI->BCI_CODPEG := cNewPEG
	BCI->BCI_OPERDA := cOpeRDA
	BCI->BCI_CODRDA := cCodRDA//cOpeRDA  
	BCI->BCI_NOMRDA := cNomRDA
	BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
	BCI->BCI_TIPGUI := GetNewPar("MV_PLSTPGS","01")//GetNewPar("MV_PLSTPGC","01")  alterado para guia de serviços a pedido do Dr. Jose Paulo em 25/10/10 por Renato Peixoto.
	BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
	
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
	BCI->BCI_VLRGUI := 0 //REVER
	BCI->BCI_DATREC := dDataBase//Base
	BCI->BCI_DTDIGI := dDtEvento
	BCI->BCI_QTDDIG := 1
	BCI->BCI_CODCOR := BCL->BCL_CODCOR
	BCI->BCI_FASE   := "1"
	BCI->BCI_SITUAC := "1"
	BCI->BCI_MES    := cMesBase
	BCI->BCI_ANO    := cAnoBase
	BCI->BCI_TIPO   := "2" 
	BCI->BCI_STATUS := "1"
	BCI->(MsUnLock())
	
	While GetSx8Len() > nStackSX8
		BCI->( ConfirmSX8() )
	EndDo
	
Else
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
Endif
PLSFechaSem(nHESP,"PLSPEG.SMF")

cTipoGuia := BCL->(BCL_TIPGUI)
cGuiRel   := BCL->BCL_GUIREL
cFunGRV   := BCL->BCL_FUNGRV
cTipGRV   := BCL->BCL_TIPGRV
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do processo de gravacao das guias...                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFiles := PLSA500Fil(BCI->BCI_CODOPE,BCI->BCI_TIPGUI)

For nQ := 1 to Len(aArray1)  //Loop para gerar uma guia para cada ususario contido no array
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta os Objetivos...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nFor := 1 To Len(aFiles)
		cAliasAux := aFiles[nFor,1]
		
		If Empty(cAliasPri)
			cAliasPri := aFiles[nFor,1]
			cNumGuia  := PLSA500NUM(cAliasPri,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
		Endif
		//BIANCHINI - P12 - RETIRADO O IF. SE NA BCS A BD6 E BD7 FICAREM COM O TIPO 2 DÁ ERRO
		//NA INCLUSAO E VISUALIZAO DE GUIAS NO CONTAS MEDICAS
		//If aFiles[nFor,3] == "2"		
			aStruARQ := (cAliasAux)->(DbStruct())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta RegToMemory...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Copy cAliasAux To Memory Blank
						
			//Dados fixos para todos os arquivos a serem procesados do contas medicas
			&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
			&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
			&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
			&("M->"+cAliasAux+"_NUMERO") := cNumGuia
			&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
			
			//Dados variados para cada arquivo que esta sendo processado
			For nAux := 1 To Len(aArray1[nQ])   //Processa a quantida de campos contidos no array do usuario em questao
				nPos := ascan(aStruARQ, {|x| alltrim(x[1]) = cAliasAux+"_"+aArray1[nQ,nAux,1]}) //ascan(aStruARQ,aArray1[nQ,nAux,1])   //Verifica se o campo a ser gravado nesta tabela corresponde ao do array
				If nPos > 0
					&("M->"+cAliasAux+"_"+aArray1[nQ,nAux,1]) := aArray1[nQ,nAux,2]
				Endif
			Next
			
			PLUPTENC(cAliasAux,K_Incluir)
		//Else
		//	CONOUT("Gravacao de itens nao implementada") //
		//Endif
	Next
Next

//Crio o vetor aHeaderBE2 com os dados do SX3 para os campos BE2_CODPAD, BE2_CODPRO e BE2_STATUS
DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(dbSeek("BE2"))
_Recno := Recno()
Do While !Eof() .And. (X3_ARQUIVO == "BE2")
	If X3_CAMPO = "BE2_CODPAD" .or. X3_CAMPO = "BE2_CODPRO" .or. X3_CAMPO = "BE2_STATUS"
		Aadd(aHeaderBE2,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,".T.", X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT})
	Endif
	dbSkip()
Enddo
DbGoto(_Recno)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao de gravacao dos dados...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cFunGRV)
	aPar   := {K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.,cAliasPri,"01","","1",{{cCodPad,cCodPro,"1"}}, aHeaderBE2 }//{K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.}
	cMacro := (AllTrim(cFunGRV)+"(aPar)")
	&(cMacro)
Endif

//Gravo os campos BD6_YVLTAP com o valor correspondente ao NUPRE e o campo QTDAPR
DbSelectArea("BD6")
//BIANCHINI - AJUSTES P12 - SEM NENHUMA RAZAO SE USAVA UM DBSELECTAREA AQUI SEM SEEK E DESPONTEIRAVA A BD6, QUE POR SI SÓ JA VEM 
//DESPONTEIRADA DEPOIS DA GRAVAÇÃO PELO PLSA720
//TAMBÉM FEITO O TRATAMENTO DE CAMPOS QUE ERAM PREENCHIDOS NA P11 E NÃO MAIS NA P12
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))

	RecLock("BD6",.F.)
	BD6->BD6_DESPRO := POSICIONE("BR8",1,XFILIAL("BR8")+'01'+cCodPro,"BR8_DESCRI")
	BD6->BD6_NIVEL  := '3'
	BD6->BD6_CODTAB := '008'
	BD6->BD6_ALIATB := 'BH0'
	BD6->BD6_YVLTAP := nValNUPRE
	BD6->BD6_VLRAPR := nValNUPRE
	//BD6->BD6_QTDAPR := 1   //DESCONTINUADO P12 
	BD6->BD6_QTDPRO := 1 
	BD6->BD6_BLOCPA := "1"
	BD6->BD6_DESBPF := "RATEIO NUPRE"
	BD6->BD6_MOTBPF := "501"
	BD6->(MsUnlock())

Endif

//BIANCHINI - 05/05/2019 - AJUSTES P12 - CAMPOS QUE ERAM PREENCHIDOS NA P11 E NÃO MAIS NA P12
DbSelectArea("BD7")
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	
	RecLock("BD7",.F.)
	BD7->BD7_CODUNM := cCompBD4
	BD7->BD7_CDPFPR := cCodProf
	BD7->BD7_PERCEN := 100
	BD7->BD7_TIPCOE := 'R$'
	BD7->BD7_FATMUL := 1
	BD7->BD7_REFTDE := 1 
	BD7->BD7_UNITDE := 'R$'
	BD7->BD7_TIPEVE := '2'
	BD7->BD7_PROBD7 := '1'
	BD7->BD7_UTHRES := '0'
	BD7->BD7_DTCTBF := dDatabase
	BD7->BD7_VALORI := nValNUPRE
	BD7->(MsUnlock())
	
Endif
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Muda a fase da guia...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCpoFase := (cAliasPri+"->"+cAliasPri+"_FASE")

If !Empty(BCL->BCL_FUNMFS)
    
     //Leonardo Portella - 26/09/13 - Inicio - Virada P11: alteracao nos parametros. Incluido vetor de glosas
     
     aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri,{}}
     //aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri}
     
     //Leonardo Portella - 26/09/13 - Fim
     
     cMacro := (AllTrim(BCL->BCL_FUNMFS)+"(aPar)")
     aRetAux := &(cMacro)
Endif 

//BIANCHINI - 04/05/2019 - AJUSTES P12 - LIMPANDO A GLOSA EM BD6 E BD7 NA MARRA. GLOSANDO 100%.ESSE PRESTADOR NÃO PODE USAR O PARAMETRO
//NOVO(BAU_TPCALC) PARA PAGAR VALORES APRESENTADOS VISTO QUE ELE APRESENTA OUTRAS GUIAS EM DIFERENTES LOCAIS, CODIGOS E VALORES
//O RATEIO NÃO PODE GLOSAR
DbSelectArea("BD6")
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD6",.F.)
	BD6->BD6_VLRGLO := 0
	BD6->(MsUnlock())
Endif

DbSelectArea("BD7")
DbSetOrder(1)
If DbSeek(BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV))
	RecLock("BD7",.F.)
	BD7->BD7_VLRGLO := 0
	BD7->(MsUnlock())
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza transacao fisica...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PLSFechaSem(nH,"CABAGRVGUI.SMF")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
