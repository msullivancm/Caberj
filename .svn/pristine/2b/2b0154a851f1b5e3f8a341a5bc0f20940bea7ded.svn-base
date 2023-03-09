#INCLUDE "PROTHEUS.CH"
#INCLUDE "TopConn.Ch"
#include "PLSMGER.CH"
#INCLUDE "FONT.CH"
#include "PRTOPDEF.CH"
/*-------------------------------------------------------------------------
| Programa  | CABR182      |Autor  |Otavio Pinto        | Data |  15/05/15 |
|--------------------------------------------------------------------------|
| Desc.     | Relatorio de Monitoramento de Risco                          |
|           |                                                              |
|           | 0019 - Risco Funcional                                       |
|           | 0020 - Risco Clinico                                         |
|           | 0021 - Risco Social                                          |
|           |                                                              |
|--------------------------------------------------------------------------|
| Uso       |                                                              |
-------------------------------------------------------------------------*/
user function CABR182()
	
	local cSQL   := ""
	local cEnt   := CHR(13)+CHR(10)
	private oDlg    := NIL
	private cTitulo := "Relatorio de Monitoramento de Risco"
	private oPrn    := NIL
	private oFont1  := NIL
	private oFont2  := NIL
	private oFont3  := NIL
	private oFont4  := NIL
	private oFont5  := NIL
	private oFont6  := NIL
	private cPerg   := "CABR182"
	private nLin    := 0
	private nLin1   := 0	
	private cPlano
	private cPnome
	private nIdade  := 0
	private cNumse
	private nTotReg := 0
	private nCont   := 0
	private cAlias  := "TMP"
	private aTMP    := {}
	Private nPagina := 0
	
	private lCd0019 := .F.
	private lCd0020 := .F.
	private lCd0021 := .F.	
	private nCd0019 := 0
	private nCd0020 := 0
	private nCd0021 := 0
	private cGrupo  := '    '
	private cSQL2   := ""
	private nSinistralidade := 0
	Private _cQuery	:= "" //Angelo Henrique - Data:01/09/2015          
	
	Private cNomAnt := " " //motta 22/09   
    Private cMatAnt := " " //motta 22/09 
    Private cRisAnt := " " //Motta 20/10/15   
    
    Private lavdi   := .T.       
    Private lavdii  := .T.
    Private lavdiii := .T.
	
	DEFINE FONT oFont1 NAME "System"      SIZE 0,12 OF oPrn BOLD
	DEFINE FONT oFont2 NAME "Arial"       SIZE 0,12 OF oPrn BOLD
	DEFINE FONT oFont3 NAME "Arial"       SIZE 0,12 OF oPrn
	DEFINE FONT oFont4 NAME "Courier New" SIZE 0,08 OF oPrn BOLD
	DEFINE FONT oFont5 NAME "Arial"       SIZE 0,18 OF oPrn BOLD
	DEFINE FONT oFont6 NAME "Courier New" BOLD
	DEFINE FONT oFont7 NAME "Arial"       SIZE 0,08 OF oPrn
	DEFINE FONT oFont8 NAME "Arial"       SIZE 0,10 OF oPrn BOLD
	DEFINE FONT oFont9 NAME "Arial"       SIZE 0,16 OF oPrn BOLD
	
	PutSx1(cPerg,"01","Codigo RDA?"               ,"","","mv_ch01","C",06,0,0,"G","","BAUPLS","","","mv_par01","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"02","Data Inicial?"             ,"","","mv_ch02","D",08,0,0,"G","","      ","","","mv_par02","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"03","Data Final?"               ,"","","mv_ch03","D",08,0,0,"G","","      ","","","mv_par03","","","","","","","","","","","","","","","","")
	
	Pergunte(cPerg,.T.)
	
	dbSelectArea("BI3")
	
	//------------------------------------------------------------------------------------	//
	//Angelo Henrique - Data:01/09/2015															//
	//------------------------------------------------------------------------------------	//
	//Aplicando validações referente a datas, pois não estava sendo contemplado 				//
	//na query principal, somente na query onde é validado/verificado a sinistralidade		//
	//------------------------------------------------------------------------------------	//
	
	_cQuery += " AND BXA_DATA BETWEEN '" + DTOS(MV_PAR02) + "' AND '" + DTOS(MV_PAR03) + "' "
	_cQuery := "%" + _cQuery + "%"
	
	/*
	NOME                                     HISTORICO                                          PLANO                                    IDADE SINISTRALIDADE RISCO FUNCIONAL RISCO CIRURGICO RISCO SOCIAL MEDIA
	XXXXXXXXXXXXXXXXX40XXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX50XXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXX40XXXXXXXXXXXXXXXXXXXXX XXXXX     XXX,XX         XXX,XX          XXX,XX         XXX,XX     XXX
	NOME_USU; DESCRI ; ??? ; IDADE ;
		
	*/
	
	
	/*-------------------------------------------------------------------------
	| Esta query monta a familia flegada.                                      |
	-------------------------------------------------------------------------*/
	beginsql Alias "TMP"
		
		SELECT BXA_CODQUE AS CODQUE
		, BXA_NUMERO AS NUMERO
		, BAM_DESCRI AS DESCRI
		, BXA_USUARI AS USUARI
		, BA1_NOMUSR AS NOME_USU
		, BA1_CODPLA AS CODPLA
		, BA1_DATNAS AS DATNAS
		, BXA_CODQUE AS CODQUEx
		, BAK_CODPER AS CODPERx
		, BAK_CODRES AS CODRESx
		, BXA_DATAUD AS DATAUD
		, BXA_DATA   AS DATA_QUEST
		, BXA_CODPRF AS CODPRF
		, BB0_NOME   AS NOME_PROF
		, BB0_CODSIG AS SIGLACRM
		, BB0_NUMCR  AS NUMCRM
		, BB0_ESTADO AS ESTADOCRM
		, BAJ_CODPER AS CODPER
		, BAJ_DESCRI AS DESPERG
		, BAJ_TIPRES AS TIPORES
		, BAK_DESCRI AS DESRESP
		
		, (SELECT (CASE WHEN BAK_CODRES = '1' and BAK_CODPER IN ('0001','0002')  THEN '1'
		WHEN BAK_CODRES = '0' and BAK_CODPER IN ('0001','0002')  THEN '2'
	ELSE BAK_CODRES
	END)
	FROM BAK010 BAK2
	WHERE BAK_FILIAL = BXA.BXA_FILIAL
	AND BAK_PROQUE = BXA.BXA_PROQUE
	AND BAK_CODQUE = BXA.BXA_CODQUE
	AND BAK_CODPER = BXB.BXB_CODPER
	AND BAK_CODRES = BXB.BXB_CODRES
	AND BAK_CODQUE = '0019'
	AND BAK2.D_E_L_E_T_ = ' '
	) AS COD0019
	, (SELECT BAK_CODRES
FROM BAK010 BAK3
WHERE BAK_FILIAL = BXA.BXA_FILIAL   
AND BAK_PROQUE = BXA.BXA_PROQUE
AND BAK_CODQUE = BXA.BXA_CODQUE
AND BAK_CODPER = BXB.BXB_CODPER        
AND BAK_CODRES = BXB.BXB_CODRES
AND BAK_CODQUE = '0020'
AND BAK3.D_E_L_E_T_ = ' '
) AS COD0020
, (SELECT (CASE WHEN BAK_CODPER = '0007'  THEN '0'
ELSE BAK_CODRES
END)
FROM BAK010 BAK4
WHERE BAK_FILIAL = BXA.BXA_FILIAL
AND BAK_PROQUE = BXA.BXA_PROQUE
AND BAK_CODQUE = BXA.BXA_CODQUE
AND BAK_CODPER = BXB.BXB_CODPER
AND BAK_CODRES = BXB.BXB_CODRES
AND BAK_CODQUE = '0021'
AND BAK4.D_E_L_E_T_ = ' '
) AS COD0021
, ZRF_CODRDA AS CODRDA
, ZRF_NOMRDA AS NOMRDA
, ZRF_TPRDA  AS TPRDA   
, TO_CHAR(ZRF_PDRRIS) AS PDRRIS  //Motta 20/10/15 

FROM ZRF010 ZRF
, BXA010 BXA
, BXB010 BXB
, BA1010 BA1
, BB0010 BB0
, BAM010 BAM
, BAJ010 BAJ
, BAK010 BAK
WHERE BXA_FILIAL = ZRF_FILIAL                       
AND  ZRF_CODRDA = %Exp:MV_PAR01%
AND  BXA_USUARI = ZRF_MATRIC                         
AND  BXA_NUMERO =  (SELECT MAX(to_number(BXA2.BXA_NUMERO))
FROM   BXA010 BXA2
WHERE  BXA2.BXA_FILIAL = BXA.BXA_FILIAL    
AND  BXA2.BXA_PROQUE = BXA.BXA_PROQUE
AND  BXA2.BXA_CODQUE = BXA.BXA_CODQUE
AND  BXA2.BXA_USUARI = BXA.BXA_USUARI
AND  BXA2.D_E_L_E_T_ = ' ')
AND  BXB_FILIAL = BXA_FILIAL
AND  BXB_NUMERO = BXA_NUMERO
AND  BA1_FILIAL = BXA.BXA_FILIAL
AND  BA1_CODINT = SubStr(BXA_USUARI,01,4)            
AND  BA1_CODEMP = SubStr(BXA_USUARI,05,4)
AND  BA1_MATRIC = SubStr(BXA_USUARI,09,6)
AND  BA1_TIPREG = SubStr(BXA_USUARI,15,2)
AND  BA1_DIGITO = SubStr(BXA_USUARI,17,1)
AND  BB0_FILIAL(+) = BXA_FILIAL
AND  BB0_CODIGO(+) = BXA_CODPRF
AND  BAM_FILIAL = BXA_FILIAL
AND  BAM_PROPRI = BXA_PROQUE
AND  BAM_CODQUE = BXA_CODQUE
AND  BAJ_FILIAL = BAK_FILIAL(+)
AND  BAJ_PROQUE = BAK_PROQUE(+)
AND  BAJ_CODQUE = BAK_CODQUE(+)
AND  BAJ_CODPER = BAK_CODPER(+)
AND  BAJ_FILIAL = BXA_FILIAL
AND  BAJ_PROQUE = BXA_PROQUE
AND  BAJ_CODQUE = BXA_CODQUE
AND  BAJ_CODPER = BXB_CODPER
AND  bak_codres = bxb_codres          
AND  ZRF.D_E_L_E_T_ = ' '
AND  BXA.D_E_L_E_T_ = ' '
AND  BXB.D_E_L_E_T_ = ' '
AND  BA1.D_E_L_E_T_ = ' '
AND  Nvl(BB0.D_E_L_E_T_,' ') = ' '
AND  BAM.D_E_L_E_T_ = ' '
AND  BAJ.D_E_L_E_T_ = ' '
AND  Nvl(Trim(BAK.D_E_L_E_T_),' ') = ' '
AND  BXA_PROQUE = '2'
AND  BXA_CODQUE IN ('0019','0020','0021')      
%exp:_cQuery%
ORDER BY BA1_NOMUSR,BXA_PROQUE,BXA_CODQUE,BXB_CODPER

endsql
//ZRF_FILIAL+ZRF_MATRIC+ZRF_TPRDA+ZRF_CODRDA+ZRF_DATINI

dbSelectArea( cAlias )
ProcRegua( (cAlias)->( LastRec() ) )
(cAlias)->( dbGoTop() )

//-----------------------------------
//Angelo Henrique - Data: 01/09/2015
//-----------------------------------
aTMP := {}
while (cAlias)->( !EOF() )    

    cNomeUsu := PADR((cAlias)->NOME_USU,40," ")
	cMatric  := PADR((cAlias)->USUARI  ,17," ")  
	cRisco   := PADR((cAlias)->PDRRIS  ,1," ") //Motta 20/10/15 		
	
	If cNomAnt <> " " 
		If cNomAnt <> cNomeUsu      //motta 
		  aADD( aTMP,{PADR(cNomAnt          ,40," "),;
			PADR(cMatAnt           ,17," "),;
			PADR(cPLANO            ,30," "),;
			PADR(nIdade            ,05," "),;
			PADR(nSinistralidade   ,12," "),;
			PADR(nCd0019           ,12," "),;
			PADR(nCd0020           ,12," "),;
			PADR(nCd0021           ,12," "),;
			PADR(cGrupo            ,05," "),;
			lCd0019 ,;
	        lCd0020 ,;
	        lCd0021 ,;
            PADR(cRisAnt           ,01," "); // Motta 20/10/15
			} )    
		  nCd0019 := 0
		  nCd0020 := 0
		  nCd0021 := 0  
		  lCd0019 := .F.
          lCd0020 := .F.
          lCd0021 := .F.	 
		  cNomAnt := cNomeUsu     
		  cMatAnt := cMatric  
		  cRisAnt := cRisco	 
		  lavdi   := .T.       
          lavdii  := .T.
          lavdiii := .T.	  
		Endif    
	Else
	  cNomAnt := cNomeUsu     
	  cMatAnt := cMatric 
	  cRisAnt := cRisco  //Motta 20/10/15 
	Endif	
	
	// Incrementa variável com o Código, Nome e Tipo do RDA...
	cNomeRDA := (cAlias)->(    CODRDA +" - "+ Alltrim(NOMRDA) + " ( "+if( TPRDA == "1","Ger. Acomp.","Medico")+" )"    )
	
	/* Calcula a SINISTRALIDADE do beneficiário -----------------------------------------------------------*/
	if SELECT("TMP2") > 0
		TMP2->( dbCloseArea() )
	endif
	
	cSQL2   := " SELECT (Case When Sign(NVL(Decode(Sum(MENSA),0,0,(Sum(APROVADO-PART))/Sum(MENSA)),0)) = -1 then 0 " + cEnt
	cSQL2   += "           else Round(100*NVL(Decode(Sum(MENSA),0,0,(Sum(APROVADO-PART))/Sum(MENSA)),0),2) " + cEnt
	cSQL2   += "           end) Sinistralidade " + cEnt
	cSQL2   += " FROM  COB_SINISTRALIDADE_MS_CAB " + cEnt
	cSQL2   += " WHERE CODINT='"+SubStr((cAlias)->USUARI,01,4)+"' " + cEnt
	cSQL2   += "   AND CODEMP='"+SubStr((cAlias)->USUARI,05,4)+"' " + cEnt
	cSQL2   += "   AND MATRIC='"+SubStr((cAlias)->USUARI,09,6)+"' " + cEnt
	cSQL2   += "   AND TIPREG='"+SubStr((cAlias)->USUARI,15,2)+"' " + cEnt
	cSQL2   += "   AND DIGITO='"+SubStr((cAlias)->USUARI,17,1)+"' " + cEnt
	cSQL2   += "   AND MES_ANO_REF BETWEEN TO_DATE('"+DTOS(MV_PAR02)+"','YYYYMMDD') AND TO_DATE('"+DTOS(MV_PAR03)+"','YYYYMMDD') " + cEnt
	
	PLSQuery(cSQL2,"TMP2")
	
    //memowrit("C:\temp\SINISTRA.SQL",cSQL2)
	
	TMP2->( dbGoTop() )
	
	nSinistralidade := TMP2->Sinistralidade
	
	If SELECT("TMP2") > 0
		TMP2->( dbCloseArea() )
	Endif
	/* FIM do cáldulo da SINESTRALIDADE.-------------------------------------------------------------------*/
	
	// Calcula a Idade em anos...
	nIdade := int( (dDataBase - CTOD( substr( (cAlias)->DATNAS,7,2)+"/"+substr( (cAlias)->DATNAS,5,2)+"/"+substr( (cAlias)->DATNAS,1,4) ) ) / 365.25 )   //(cAlias)->Idade
	
	//---------------------------------------------------------------------
	//Angelo Henrique - Data: 01/09/2015
	//---------------------------------------------------------------------
	//Removido as duas linhas abaixo e utilizado mais acima, pois
	//confiorme informado a query acima deve ser executada para cada
	//item listado na query principal
	//---------------------------------------------------------------------
	//aTMP := {}
	//while (cAlias)->( !EOF() )
	
	// Busca a descrição do plano...
	cPlano := BI3->( IIF ( dbSeek(xFilial("BI3")+SubStr((cAlias)->USUARI,01,4)+(cAlias)->CODPLA ) , BI3->BI3_NREDUZ, "" ) )
	
	//  Grupo  
	cGrupo := ' '
	if (cAlias)->( CODQUEx == '0019' .AND. CODPERx $ '0005,0006,0007' )
		cGrupo := 'AVD_1'
	elseif (cAlias)->( CODQUEx == '0019' .AND. CODPERx $ '0016,0017,0018,0019' )
		cGrupo := 'AVD_2'
	elseif (cAlias)->( CODQUEx == '0019' .AND. CODPERx $ '0025,0026,0027' )
		cGrupo := 'AVD_3'
	elseif (cAlias)->( CODQUEx == '0019' .AND. !CODPERx $ '0005,0006,0007' )
		cGrupo := (cAlias)->CODRESx
	endif
	
	if (cAlias)->CODQUEx == '0019'        
	  // valores que so agravam uma vez por grupo
	  If cGrupo == 'AVD_1' .AND. val( (cAlias)->COD0019 ) > 0 .AND. lavdi
	    lavdi := .F.  
	    nCd0019 += val( (cAlias)->COD0019 )     
	  endif
	  If cGrupo == 'AVD_2' .AND. val( (cAlias)->COD0019 ) > 0 .AND. lavdii
	    lavdii := .F.     
	    nCd0019 += val( (cAlias)->COD0019 )  
	  Endif     
	  If cGrupo == 'AVD_3' .AND. val( (cAlias)->COD0019 ) > 0 .AND. lavdiii
	    lavdiii := .F.  
	    nCd0019 += val( (cAlias)->COD0019 )     
	  Endif
	  If (cGrupo <> 'AVD_1' .AND. cGrupo <> 'AVD_2' .AND. cGrupo <>  'AVD_3')	  
	    nCd0019 += val( (cAlias)->COD0019 )     
	  Endif
	  lCd0019 := .T.
	endif  
	
	if (cAlias)->CODQUEx == '0020'
	  nCd0020 += val( (cAlias)->COD0020 )
      lCd0020 := .T.
	endif  
	
	if (cAlias)->CODQUEx == '0021'
	  if (cAlias)->( CODQUEx == '0021' .AND. CODPERx == '0007')
	    nCd0021 += 0
	  elseif  (cAlias)->( CODQUEx == '0021' .AND. CODPERx <> '0007')
	    nCd0021 += val( (cAlias)->COD0021 )
	  endif    
	  lCd0021 := .T.
	endif  
		
	(cAlias)->( dbSkip() )
enddo          

aADD( aTMP,{PADR(cNomAnt          ,40," "),;
		PADR(cMatAnt           ,17," "),;
		PADR(cPLANO            ,30," "),;
		PADR(nIdade            ,05," "),;
		PADR(nSinistralidade   ,12," "),;
		PADR(nCd0019           ,12," "),;
		PADR(nCd0020           ,12," "),;
		PADR(nCd0021           ,12," "),;
		PADR(cGrupo            ,05," "),;
		lCd0019 ,;
        lCd0020 ,;
        lCd0021 ,;
        PADR(cRisAnt           ,01," "); // Motta 20/10/15
		} )    

oPrn := TMSPrinter():New(cTitulo)
//oPrn:SetPortrait()
oPrn:SetLandsCape()
Processa({||Mont_impr(),"Processando..."})

/*-------------------------------------------------------------------------
Cria interface com o usuario
-------------------------------------------------------------------------*/

DEFINE MSDIALOG oDlg FROM 264,182 TO 441,613 TITLE cTitulo OF oDlg PIXEL
@ 004,010 TO 082,157 LABEL "" OF oDlg PIXEL

@ 015,017 SAY "Esta rotina tem por objetivo imprimir" OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE
@ 030,017 SAY "o "+cTitulo                            OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE
@ 045,017 SAY " **                                  " OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE
@ 060,017 SAY " **                                  " OF oDlg PIXEL Size 150,010 FONT oFont6 COLOR CLR_HBLUE

@  6,167 BUTTON "&Imprime"   SIZE 036,012 ACTION oPrn:Print()   OF oDlg PIXEL
@ 28,167 BUTTON "&Configura" SIZE 036,012 ACTION oPrn:Setup()   OF oDlg PIXEL
@ 49,167 BUTTON "&Visualiza" SIZE 036,012 ACTION oPrn:Preview() OF oDlg PIXEL
@ 70,167 BUTTON "Sai&r"      SIZE 036,012 ACTION oDlg:End()     OF oDlg PIXEL

ACTIVATE MSDIALOG oDlg CENTERED

oPrn:End()

return

/*-------------------------------------------------------------------------
Static Function Mont_impr()
	Monta o objeto com os detalhes
	-------------------------------------------------------------------------*/
static function Mont_impr()
	private nTotSinistro    := 0  // Total de Sinistralidade
	private nTotRFuncional  := 0  // Total de Risco Funcional
	private nTotRClinico    := 0  // Total de Risco Clinico
	private nTotRSocial     := 0  // Total de Risco Social
	
	private nTSNGer         := 0  // Total de Sinistralidade
	private nTRFGer         := 0  // Total de Risco Funcional
	private nTRCGer         := 0  // Total de Risco Clinico
	private nTRSGer         := 0  // Total de Risco Social        
	
	private cMedia          := " " //Motta 20/10/15
	
	//private nTipo           := 1 -- Angelo Henrique Data:15/09/2015
	
	Cabec(1)
	
	oPrn:Say (0175,0050,"Nome Usuario"      ,oFont2)
	oPrn:Say (0175,0500,"Matricula"         ,oFont2)
	oPrn:Say (0175,0850,"Plano"             ,oFont2)
	oPrn:Say (0175,1300,"Idade"             ,oFont2)
	oPrn:Say (0175,1650,"Sinistralidade"    ,oFont2)
	oPrn:Say (0175,2000,"Risco Funcional"   ,oFont2)
	oPrn:Say (0175,2350,"Risco Clínico"     ,oFont2)
    oPrn:Say (0175,2700,"Risco Social"      ,oFont2)   
    oPrn:Say (0175,2950,"Risco Maturidade"  ,oFont2)
	
	nLin := 0300
	
	(cAlias)->( dbGotop() )
	
	wNome     := ""
	wMat      := ""
	wPlano    := ""
	wIdade    := ""
	
	for x := 1 to len(aTMP)
		IncProc("Selecionando registros...")
		
		//if nLin > 2300 -- Angelo Henrique - Data:15/09/2015
		if nLin > 1700
			Cabec(2)
			
			//--------------------------------------------------------------------------------
			//Angelo Henrique - Data:15/09/2015
			//--------------------------------------------------------------------------------
			//Acrescentando as linhas abaixo para que o cabeçalho possa ser visualizado
			//nas próximas páginas
			//--------------------------------------------------------------------------------
			oPrn:Say (0175,0050,"Nome Usuario"      ,oFont2)
			oPrn:Say (0175,0500,"Matricula"         ,oFont2)
			oPrn:Say (0175,0850,"Plano"             ,oFont2)
			oPrn:Say (0175,1300,"Idade"             ,oFont2)
			oPrn:Say (0175,1650,"Sinistralidade"    ,oFont2)
			oPrn:Say (0175,2000,"Risco Funcional"   ,oFont2)
			oPrn:Say (0175,2350,"Risco Clínico"     ,oFont2)
			oPrn:Say (0175,2700,"Risco Social"      ,oFont2)
			oPrn:Say (0175,3050,"Média"             ,oFont2)
			
			nLin := 0300
					
		endIf
		
		cNome     := aTMP[x][1]
		cMat      := aTMP[x][2]
		cPlano    := aTMP[x][3]
		nIdade    := aTMP[x][4]
		xSinistra := aTMP[x][5]
		xRiscoFun := aTMP[x][6]
		xRiscoCli := aTMP[x][7]
		xRiscoSoc := aTMP[x][8]
		xGrupo    := aTMP[x][9]  
		xRisco    := aTMP[x][13] // Motta 20/10/15  
		
		nTotSinistro    := val(xSinistra)  // Total de Sinistralidade
		nTotRFuncional  := val(xRiscoFun)  // Total de Risco Funcional
		nTotRClinico    := val(xRiscoCli)  // Total de Risco Clinico
		nTotRSocial     := val(xRiscoSoc)  // Total de Risco Social
							
		//--------------------------------------------------------							
		//Angelo Henrique - Data:15/09/2015
		//--------------------------------------------------------
		//Zerando as variáveis pos estava calculando errado
		//--------------------------------------------------------
		nTSNGer := 0
		nTRFGer := 0
		nTRCGer := 0
		nTRSGer := 0 		
		
		//-------------------------------------------------------------------------------------------
		//Angelo Henrique - Data:08/09/2015
		//-------------------------------------------------------------------------------------------
		//Retirado a validação abaixo, trocado os operadores .AND. por .OR.,
		//para poder assim pegar os outros resultados da query
		//-------------------------------------------------------------------------------------------
		//if cNome <> wNome .and. cMat <> wMat .and. cPlano <> wPlano .and. nIdade <> wIdade
		
		if cNome <> wNome .OR. cMat <> wMat .OR. cPlano <> wPlano .OR. nIdade <> wIdade
			
			wNome    := cNome
			wMat     := cMat
			wPlano   := cPlano
			wIdade   := nIdade
			
			nLin += 0050 //Angelo Henrique - Data:01/09/2015
			
			oPrn:Say (nLin,0050,padr(cNome,20)                        ,oFont7)
			oPrn:Say (nLin,0500,cMat                                  ,oFont7)
			oPrn:Say (nLin,0850,cPlano                                ,oFont7)
			oPrn:Say (nLin,1300,Transform(nIdade,"@E 999")            ,oFont7)
			
			nTSNGer  += nTotSinistro    // Total de Sinistralidade
			
			//endif -- Angelo Henrique - Data:15/09/2015			
	  	 
			nTRFGer += nTotRFuncional  // Total de Risco Funcional
			nTRCGer  += nTotRClinico    // Total de Risco Clinico
			nTRSGer  += nTotRSocial     // Total de Risco Social		
			
			//next -- Retirado esse comando e colocado em baixo, para poder calcular um a um
			
			// Regra: Apartir de 40 anos é computado 1 ponto para cada década de vida
			// Ex.: Paciente com 60 anos deverá ser adicionado 2 pontos.  Se 74 deverá se adicionado 3 pontos (despreza a unidade)
			
			nTRCGer +=  iif( val(nIdade) > 40, int( (val(nIdade)-40)/ 10 ),0) 
			
			If xRisco != "0"                    // Motta 20/10/15
			  cMedia  := PADR(xRisco,16," ")   // Motta 20/10/15   
			Else                                // Motta 20/10/15        
			  cMedia  := PADR(" ",16," ")      // Motta 20/10/15   
			Endif                               // Motta 20/10/15 
			
			oPrn:Say (nLin,1650,PADR(Transform(nTSNGer, "@E 999,999,999.99%") ,20," ")	,oFont7)   
			If aTMP[x][10]
			  oPrn:Say (nLin,2000,PADR(Transform(nTRFGer, "@E 999,999,999.99"	) ,20," ")	,oFont7)
			Else
			  oPrn:Say (nLin,2000,PADR(" " ,20," ")	,oFont7)
			Endif    
			If aTMP[x][11]
			  oPrn:Say (nLin,2350,PADR(Transform(nTRCGer, "@E 999,999,999.99"	) ,20," ")	,oFont7)
			Else
			  oPrn:Say (nLin,2000,PADR(" " ,20," ")	,oFont7)
			Endif 
			If aTMP[x][12]
				oPrn:Say (nLin,2700,PADR(Transform(nTRSGer, "@E 999,999,999.99"	) ,20," ")	,oFont7) 
			Else
			  oPrn:Say (nLin,2000,PADR(" " ,20," ")	,oFont7)
			Endif	
			oPrn:Say (nLin,3050,PADR(cMedia ,15," ")                                  	,oFont7)
			
			//oPrn:Say (nLin,3050,PADR(Transform(cMedia , "@E 999.99") ,12," ")          ,oFont7)      			
			
			
		endif
		
	next
	
	(cAlias)->( dbCLoseArea() )
	
	//Angelo Henrique - Data:09/09/2015
	oPrn:EndPage()
	oPrn:StartPage()
	oPrn:End()
	
return

/*-------------------------------------------------------------------------
Static Function Cabec(ntipo)
	cabecalho
	-------------------------------------------------------------------------*/
static function Cabec(ntipo)	
		
	if ntipo == 1
		oPrn:StartPage()
		
		//Angelo Henrique - Data 09/09/2015
		nPagina++
		
	else
		
		oPrn:EndPage()
		
		//----------------------------------
		//Angelo Henrique - Data:09/09/2015
		//----------------------------------
		oPrn:StartPage()
		nPagina++
		
	endIf
	//                       2300
	
	oPrn:box (0030,0030,0150,3300)
	oPrn:Say (0050,0050,cPerg+".PRW"                        ,oFont8)
	oPrn:Say (0040,1250,cTitulo                             ,oFont9)
	oPrn:Say (0100,0050,"Mês/Ano: " + substr(DTOS(dDataBase),5,2) + "/" + substr(DTOS(dDataBase),1,4)   ,oFont2)
	oPrn:Say (0100,1100,PADC( cNomeRDA, 80, " ")            ,oFont8)
	oPrn:Say (0070,2870,"Pagina:" + Str(nPagina)            ,oFont2)
	oPrn:box (0170,0030,0250,3300)
	
return


// Fim da rotina CABR182.PRW