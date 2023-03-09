#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

#define c_Eol chr(13)+chr(10)

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA347
Rotina para gerenciamento financeiro do bloqueios
			solicitados pela RN 412
@author   Marcela Coimbra
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
User Function CABA347()


	Private lEnchBar	:= .F. // Se a janela de diálogo possuirá enchoicebar (.T.)
	Private lPadrao		:= .F. // Se a janela deve respeitar as medidas padrões do Protheus (.T.) ou usar o máximo disponível (.F.)
	Private nMinY		:= 400 // Altura mínima da janela

	Private aSize		:= MsAdvSize(lEnchBar, lPadrao, nMinY)
	Private aInfo		:= {aSize[1],aSize[2],aSize[3],aSize[4],3,3} // Coluna Inicial, Linha Inicial
	Private aObjects	:= {}
	Private aPosObj		:= {}

	Private c_AliaBlq 	:= "QRYBLOQ"
	Private lAgCarta   	:= .F.
	Private lAgCob     	:= .F.
	Private lAgPgto    	:= .F.
	Private lAnalisar  	:= .F.
	Private lCartaGer  	:= .F.
	Private cBloqAte   	:= ctod("  /  /  ")
	Private cBloqDe    	:= ctod("  /  /  ")

	Private _dDatPg    	:= ctod("  /  /  ")

	Private oAnalisar	:= Nil
	Private oAgCob		:= Nil
	Private oAgPgto		:= Nil
	Private oAgCarta	:= Nil
	Private oCartaGer	:= Nil
	Private oAumPgto	:= Nil
	
	Private oDlg1		:= Nil
	Private oBrAn		:= Nil
	Private oPanel1		:= Nil
	Private oSay1		:= Nil
	Private oPanel2		:= Nil
	Private oBrw1		:= Nil
	Private oPanel3		:= Nil
	Private oBtn1		:= Nil
	Private oBtn2		:= Nil
	Private oBtn3		:= Nil
	Private oBtn5		:= Nil
	Private oBtn6		:= Nil

	Private oCom02		:= Nil
	Private aFiltro		:= {"RN 412", "RN 438", "OBITO"}
	Private cStatusAt	:= Space(06)

	Private c_Chave 	:=	"MATRICULA"
	Private a_Campos 	:= 	{}
	Private a_Struct 	:= 	{}
	Private c_CampoOk   := "XOK"  
	Private oOk        	:= LoadBitMap(GetResources() , "LBOK_OCEAN" )
	Private onOk       	:= LoadBitMap(GetResources() , "LBNO_OCEAN" )
	Private nTotReg    	:= 0

	//------------------------------------------------
	//RN 412 - Bloqueio
	//------------------------------------------------
	Private c_MotUsuFn 	:= GetMv("MV_XBQFUSU")
	Private c_MotFamFn 	:= GetMv("MV_XBQFFAM")

	//------------------------------------------------
	//Angelo Henrique - Data:19/07/2019
	//------------------------------------------------
	//RN 438 - Portabilidade
	//------------------------------------------------
	Private c_MotPotUs 	:= GetMv("MV_XBQPOUS")
	Private c_MotPotFm 	:= GetMv("MV_XBQPOFM")

	//------------------------------------------------
	//Angelo Henrique - Data:19/07/2019
	//------------------------------------------------
	//Bloqueio via AXF (Obito)
	//------------------------------------------------
	Private c_MotObtUs 	:= GetMv("MV_XBQOBUS")
	Private c_MotObtFn 	:= GetMv("MV_XBQOBFM")

	Private c_AlIndNF  := "u_"+c_AliaBlq

	Private oBtn2bAction := {|| }

	aAdd(aObjects,{50,50,.T.,.F.  })		// Definicoes para a Enchoice
	aAdd(aObjects,{150,150,.T.,.F.})	// Definicoes para a Getdados
	aAdd(aObjects,{100,015,.T.,.F.})

	aPosObj := MsObjSize(aInfo,aObjects)// Mantem proporcao - Calcula Horizontal

	fStrNF()

	Define FONT oFont 	NAME "Arial" SIZE 0,20  Bold

	oDlg1 := MSDIALOG():New(aSize[7],aSize[2],aSize[6],aSize[5],"Analise de Bloqueio",,,.F.,,,,,,.T.,,,.T. )

	oPaneL1 := TPanel():New(000,000,"",oDlg1,NIL,.T.,.F.,NIL,NIL,560,16,.T.,.F.)
	oPaneL1:Align := CONTROL_ALIGN_TOP

	oSayDt      := TSay():New( 007,530,{||"Dt Pgto:"}	,oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,020)
	oDt    		:= TGet():New( 005,560,{|u| If(PCount()>0,_dDatPg	:=u,_dDatPg	)},oPanel1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_dDatPg"	,,)

	oSay1      	:= TSay():New( 007,004,{||"Bloqueio de:"}	,oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay2      	:= TSay():New( 007,080,{||"Bloqueio até:"}	,oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

	oAnalisar  	:= TCheckBox():New( 007,164,"Analisar"				,{|u| If(PCount()>0,lAnalisar	:=u,lAnalisar	)},oPanel1,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oAgCob     	:= TCheckBox():New( 007,208,"Aguardando cobrança"	,{|u| If(PCount()>0,lAgCob		:=u,lAgCob		)},oPanel1,068,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oAgPgto    	:= TCheckBox():New( 007,280,"Aguardando Pagamento"	,{|u| If(PCount()>0,lAgPgto		:=u,lAgPgto		)},oPanel1,068,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oAgCarta   	:= TCheckBox():New( 007,352,"Aguardando Carta"		,{|u| If(PCount()>0,lAgCarta	:=u,lAgCarta	)},oPanel1,056,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCartaGer  	:= TCheckBox():New( 007,420,"Carta gerada"			,{|u| If(PCount()>0,lCartaGer	:=u,lCartaGer	)},oPanel1,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

	oBloqDe    	:= TGet():New( 005,036,{|u| If(PCount()>0,cBloqDe	:=u,cBloqDe	)},oPanel1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cBloqDe"	,,)
	oBloqAte   	:= TGet():New( 005,112,{|u| If(PCount()>0,cBloqAte	:=u,cBloqAte)},oPanel1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cBloqAte"	,,)

	oPanel2    	:= TPanel():New( 028,004,"",oDlg1,,.F.,.F.,,,448,196,.T.,.F. )

	ListaAn()

	oPanel3    	:= TPanel():New( 028,456,"",oDlg1,,.F.,.F.,,,064,196,.T.,.F. )
	oPaneL3:Align := CONTROL_ALIGN_RIGHT

	oCom02 		:= TComboBox():New( 006,472,bSetGet(cStatusAt),aFiltro ,040,10,oPanel1,,,,,,.T.,,,,{||.T.})

	oBtn1      	:= TButton():New( 004,004,"&Analisar"			,oPanel3,	{ || fAnalisar() 		},056,012,,,,.T.,,"",,,,.F. )

	oAumPgto	:= TButton():New( 020,004,"Gerar Pgto"			,oPanel3,	{ || fPagamento() 		},056,012,,,,.T.,,"",,,,.F. )
	oBtn4      	:= TButton():New( 036,004,"Gerar Carta"  		,oPanel3,	{ || fGerCart()  		},056,012,,,,.T.,,"",,,,.F. )

	oBtn6      	:= TButton():New( 052,004,"Excluir Pagamento"	,oPanel3,	{ || fExcPgto()  		},056,012,,,,.T.,,"",,,,.F. )

	oBtn3      	:= TButton():New( 068,004,"&Imprimir Browse"	,oPanel3,	{ || fImprime() 		},056,012,,,,.T.,,"",,,,.F. )

	oBtn5      	:= TButton():New( 084,004,"&Imprimir Relatorio" ,oPanel3,	{ || fRelatFim()		},056,012,,,,.T.,,"",,,,.F. )

	oBtn5      	:= TButton():New( 100,004,"Filtrar"  			,oPanel3,	{ || fPegaBloqs( "C" ) 	},056,012,,,,.T.,,"",,,,.F. )

	oBtn2      	:= TButton():New( 172,004,"&Fechar"				,oPanel3,	{ || oDlg1:End() 		},056,012,,,,.T.,,"",,,,.F. )

	oDlg1:Activate(,,,.T.)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function ListaAn
 lista
@author  marcela
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function ListaAn()

	Local nIt := 0

	DbSelectArea(c_AliaBlq)
	(c_AliaBlq)->(DbGoTop())

	oBrAn:=TcBrowse():New(037,008,435,180,,,,oDlg1,,,,,,,oDlg1:oFont,,,,,.T.,c_AliaBlq,.T.,,.F.,,,.F.)    
	
	oBrAn:align:= CONTROL_ALIGN_ALLCLIENT

	For nIt := 1 To Len(a_Campos)

		c2 := If(nIt == 1," ",a_Campos[nIt,1])
		c3 := If(nIt == 1,&("{|| If(Empty("+c_AliaBlq+"->"+c_CampoOk+"),onOk,oOk)}"),&("{||"+c_AliaBlq+"->"+a_Campos[nIt,2]+"  }"))

		c4 := If(nIt == 1,5,CalcFieldSize(a_Campos[nIt,3],a_Campos[nIt,4],a_Campos[nIt,5],"",a_Campos[nIt,1]))
		c5 := If(nIt == 1,"",a_Campos[nIt,6])
		c6 := If(nIt == 1,.T.,.F.)

		oBrAn:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
		oBrAn:bLDblClick   := {|| fAtuBrw(c_AliaBlq,c_CampoOk     )}

	Next

	oBrAn:bHeaderClick := {|| fAtuBrw(c_AliaBlq,c_CampoOk,,.T.)}
	fPegaBloqs( "I" )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fStrNF
 Cria a estrutura do grid
@author  marcela
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fStrNF()

	Aadd(a_Campos,{" ",c_CampoOk,"C",1,0,})
	Aadd(a_Struct,{c_CampoOk,"C",1,0})

	Aadd(a_Campos,{"SIT. ANALISE","BCA_XSTATU","C",15,0,""})
	Aadd(a_Struct,{"BCA_XSTATU","C",15,0})

	Aadd(a_Campos,{"PROTOCOLO","Protocolo","C",19,0,""})
	Aadd(a_Struct,{"PROTOCOLO","C",19,0})

	Aadd(a_Campos,{"GRP COB ANT","BA3YTPPAG","C",6,0,""})
	Aadd(a_Struct,{"BA3YTPPAG","C",6,0})

	Aadd(a_Campos,{"GRP COB ATU","GRUPO","C",6,0,""})
	Aadd(a_Struct,{"GRUPO","C",6,0})

	Aadd(a_Campos,{"MATRICULA","Matricula","C",21,0,""})
	Aadd(a_Struct,{"MATRICULA","C",21,0})

	Aadd(a_Campos,{"NOME","BA1_NOMUSR","C",70,0,""})
	Aadd(a_Struct,{"BA1_NOMUSR","C",70,0})

	//----------------------------------------------------------------
	//Angelo Henrique - Data: 30/07/2019
	//----------------------------------------------------------------
	Aadd(a_Campos,{"PLANO","BA1_CODPLA","C",6,0,""})
	Aadd(a_Struct,{"BA1_CODPLA","C",6,0})

	Aadd(a_Campos,{"DESCRICAO PLANO ","BI3_DESCRI","C",TAMSX3("BI3_DESCRI")[1],0,""})
	Aadd(a_Struct,{"BI3_DESCRI","C",TAMSX3("BI3_DESCRI")[1],0})
	//----------------------------------------------------------------

	Aadd(a_Campos,{"DATA LANÇAMENTO","BCA_DATLAN","D",8,0,""})
	Aadd(a_Struct,{"BCA_DATLAN","D",8,0})

	Aadd(a_Campos,{"DATA BLOQUEIO","BA1_DATBLO","D",8,0,""})
	Aadd(a_Struct,{"BA1_DATBLO","D",8,0})

	Aadd(a_Campos,{"PLS","E1_NUM","C",9,0,""})
	Aadd(a_Struct,{"E1_NUM","C",9,0})

	Aadd(a_Campos,{"ANO/MES","ANOMES","C",9,0,""})
	Aadd(a_Struct,{"ANOMES","C",7,0})

	Aadd(a_Campos,{"VALOR","E1_VALOR","N",17,2,""})
	Aadd(a_Struct,{"E1_VALOR","N",17,2})

	Aadd(a_Campos,{"SALDO","E1_SALDO","N",17,2,""})
	Aadd(a_Struct,{"E1_SALDO","N",17,2})

	Aadd(a_Campos,{"CREDITO","BCA_XCREDI","C",9,0,""})
	Aadd(a_Struct,{"BCA_XCREDI","C",9,0})

	//----------------------------------------------------------------
	//Angelo Henrique - Data:30/07/2019
	//----------------------------------------------------------------
	Aadd(a_Campos,{"VALOR CREDITO","BSQ_VALOR","N",17,2,""})
	Aadd(a_Struct,{"BSQ_VALOR","N",17,2})

	Aadd(a_Campos,{"TITULO CR","TITULOCR","C",17,0,""})
	Aadd(a_Struct,{"TITULOCR","C",17,0})
	//----------------------------------------------------------------

	Aadd(a_Campos,{"PAGAMENTO","PAGAMENTO","C",15,0,""})
	Aadd(a_Struct,{"PAGAMENTO","C",15,0})

	Aadd(a_Campos,{"Data Carta","BCA_XDTCAR","D",8,0,""})
	Aadd(a_Struct,{"BCA_XDTCAR","D",8,0})

	//Angelo Henrique - Data:27/02/2023
	//Melhorias RN 412 - Chamado: 96304
	Aadd(a_Campos,{"Mensalidade","MENSAL","D",8,0,""})
	Aadd(a_Struct,{"MENSAL","N",17,2})

	Aadd(a_Campos,{"RECBCA","RECBCA","C",20,0,""})
	Aadd(a_Struct,{"RECBCA","C",20,0})

	If Select(c_AliaBlq) <> 0
		(c_AliaBlq)->(DbCloseArea())
	Endif
	If TcCanOpen(c_AliaBlq)
		TcDelFile(c_AliaBlq)
	Endif

	DbCreate(c_AliaBlq,a_Struct,"TopConn")
	If Select(c_AliaBlq) <> 0
		(c_AliaBlq)->(DbCloseArea())
	Endif

	DbUseArea(.T.,"TopConn",c_AliaBlq,c_AliaBlq,.T.,.F.)
	(c_AliaBlq)->(DbCreateIndex(c_AlIndNF , c_Chave, {|| &c_Chave}, .F. ))
	(c_AliaBlq)->(DbCommit())
	(c_AliaBlq)->(DbClearInd())
	(c_AliaBlq)->(DbSetIndex(c_AlIndNF ))

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fPegaBloqs
pega bloqueados
@author  marcela
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fPegaBloqs( c_FilIni )

	Local l_Ret := .T.
	Local c_Fil := ""
	Local ni 	:= 0

	If lAgCarta

		c_Fil += "3,"

	EndIf

	If lAgCob

		c_Fil += "2,"

	EndIf

	If lAgPgto

		c_Fil += "4,"

	EndIf

	If lCartaGer

		c_Fil += "5,"

	EndIf

	If !Empty( c_Fil )  .OR. lAnalisar

		If lAnalisar

			c_Fil += "1,"

		Else

			c_Fil := substr(c_Fil, 1, len(c_Fil)-1)

		EndIf

		c_Fil:= FormatIn( c_Fil, "," )

	EndIf

	c_Qry := ""

	c_Qry += " SELECT DISTINCT ' 'XOK, BA1_CODINT||'.'||BA1_CODEMP||'.'||BA1_MATRIC||'.'||BA1_TIPREG||'-'||BA1_DIGITO MATRICULA, "  + c_Eol
	c_Qry += " 		ZX_SEQ PROTOCOLO, "+ c_Eol
	c_Qry += " 		BA1_NOMUSR, "+ c_Eol
	c_Qry += " 		BA1_CODPLA, "+ c_Eol
	c_Qry += " 		BI3_DESCRI, "+ c_Eol
	c_Qry += " 		BA1_DATBLO, "+ c_Eol
	c_Qry += " 		E1_NUM,     "+ c_Eol
	c_Qry += " 		E1_MESBASE||'/'||E1_ANOBASE ANOMES,    "+ c_Eol
	c_Qry += " 		BCA_XDTCAR,    "+ c_Eol
	c_Qry += " 		BCA_XCREDI,    "+ c_Eol
	c_Qry += " 		BSQ_VALOR, 	   "+ c_Eol //Angelo Henrique - data: 30/07/2019
	c_Qry += " 		NVL(BSQ_PREFIX||BSQ_NUMTIT||BSQ_PARCEL||BSQ_TIPTIT,' ') TITULOCR,"+ c_Eol //Angelo Henrique - data: 30/07/2019
	c_Qry += " 		E1_SALDO,    "+ c_Eol
	c_Qry += " 		E1_VALOR,    "+ c_Eol

	c_Qry += " 		DECODE(BA3_TIPPAG,'00','SEM ENVIO', "
	c_Qry += " 		                               '01','PREVI', "
	c_Qry += " 		                               '02','LIQ',  "
	c_Qry += " 		                               '03','EMP',  "
	c_Qry += " 		                               '04','112', "
	c_Qry += " 		                               '05','175', "
	c_Qry += " 		                               '06','SISDEB', "
	c_Qry += " 		                               '07','ITAU', "
	c_Qry += " 		                               '08','PREVI','') GRUPO, "

	c_Qry += " 		DECODE(BA3_YTPPAG,'00','SEM ENVIO', "
	c_Qry += " 		                               '01','PREVI', "
	c_Qry += " 		                               '02','LIQ',  "
	c_Qry += " 		                               '03','EMP',  "
	c_Qry += " 		                               '04','112', "
	c_Qry += " 		                               '05','175', "
	c_Qry += " 		                               '06','SISDEB', "
	c_Qry += " 		                               '07','ITAU', "
	c_Qry += " 		                               '08','PREVI','') BA3YTPPAG, "

	c_Qry += " 		DECODE(TRIM(BCA_XSTATU), '', 'AGUARDANDO', '1', 'AGUARDANDO', '2', 'AGUARDANDO COBRANCA','3', 'AGUARDANDO CARTA', '4', 'AGUARDANDO PGTO', '5' ,'CARTA ENVIADA') BCA_XSTATU ,   "+ c_Eol
	c_Qry += " 		( CASE  WHEN E1_SALDO IS NULL THEN 'NAO COBRADO'  "+ c_Eol
	c_Qry += " 		        WHEN E1_SALDO > 0 THEN 'COBRADO EM ABERTO' ELSE 'COBRADO BAIXADO' END ) STATUS_COB, "+ c_Eol
	c_Qry += " 		NVL(SE2.E2_FILIAL||SE2.E2_PREFIXO||E2_NUM, ' ') PAGAMENTO ,    "+ c_Eol
	c_Qry += " 	    NVL(E2_NUM, ' ') E2_NUM,"+ c_Eol
	c_Qry += " 		MAX(BCA_DATLAN) BCA_DATLAN,"+ c_Eol
	c_Qry += " 		MAX( TO_CHAR(BCA.R_E_C_N_O_) ) RECBCA"+ c_Eol
	c_Qry += " 		FROM " + RETSQLNAME("BCA") + " BCA INNER JOIN " + RETSQLNAME("BA3") + " BA3 ON  BA3_FILIAL = ' ' "+ c_Eol
	c_Qry += " 		                                  AND BA3_CODINT||BA3_CODEMP||BA3_MATRIC = BCA_MATRIC  " + c_Eol
	c_Qry += " 		                                  AND BA3.D_E_L_E_T_ = ' ' " + c_Eol

	c_Qry += " 		                INNER JOIN " + RETSQLNAME("BA1") + " BA1 ON BA1_FILIAL = ' '   " + c_Eol
	c_Qry += " 		                                  AND BA1_CODINT = BA3_CODINT " + c_Eol
	c_Qry += " 		                                  AND BA1_CODEMP = BA3_CODEMP  " + c_Eol
	c_Qry += " 		                                  AND BA1_MATRIC = BA3_MATRIC " + c_Eol
	c_Qry += " 		                                  AND BA1_TIPREG = BCA_TIPREG " + c_Eol
	c_Qry += " 		                                  AND BA1_DATBLO = BCA_DATA   " + c_Eol
	c_Qry += " 		                                  AND BA1_MOTBLO = BCA_MOTBLO " + c_Eol
	c_Qry += " 		                                  AND BA1.D_E_L_E_T_ = ' '   " + c_Eol

	//---------------------------------------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data:30/07/2019
	//---------------------------------------------------------------------------------------------------------------------------------------
	c_Qry += " 		                INNER JOIN " + RETSQLNAME("BI3") + " BI3 ON BI3_FILIAL = '" + xFilial("BI3") + "'   " + c_Eol
	c_Qry += " 		                                  AND BI3.BI3_CODIGO = BA1.BA1_CODPLA  " + c_Eol
	c_Qry += " 		                                  AND BI3.D_E_L_E_T_ = ' '  " + c_Eol
	//---------------------------------------------------------------------------------------------------------------------------------------

	c_Qry += " 		                LEFT JOIN " + RETSQLNAME("BM1") + " BM1 ON BM1_FILIAL = ' '  " + c_Eol
	c_Qry += " 		                                  AND BM1_CODINT = BA1_CODINT  " + c_Eol
	c_Qry += " 		                                  AND BM1_CODEMP = BA1_CODEMP " + c_Eol
	c_Qry += " 		                                  AND BM1_MATRIC = BA1_MATRIC  " + c_Eol
	c_Qry += " 		                                  AND BM1_TIPREG = BA1_TIPREG " + c_Eol
	c_Qry += " 		                                  AND BM1_ANO    = SUBSTR(BA1_DATBLO, 1, 4) " + c_Eol
	c_Qry += " 		                                  AND BM1_MES    = SUBSTR(BA1_DATBLO, 5, 2) " + c_Eol
	c_Qry += " 		                                  AND BM1_CODTIP = '101' " + c_Eol //Angelo Henrique - Data: 14/02/2022 - Para contemplar somente titulos de mensalidade
	c_Qry += " 		                                  AND BM1.D_E_L_E_T_ = ' ' " + c_Eol

	c_Qry += " 		                LEFT JOIN " + RETSQLNAME("SE1") + " SE1 ON E1_FILIAL = '" + XFILIAL("SE1") +"' " + c_Eol
	c_Qry += " 		                                  AND E1_PREFIXO = BM1_PREFIX  " + c_Eol
	c_Qry += " 		                                  AND E1_NUM     = BM1_NUMTIT " + c_Eol
	c_Qry += " 		                                  AND E1_TIPO    = 'DP' " + c_Eol
	c_Qry += " 		                                  AND SE1.D_E_L_E_T_ = ' ' " + c_Eol

	c_Qry += " 		                LEFT JOIN " + RETSQLNAME("BSQ") + " BSQ ON  BSQ_FILIAL = ' '  " + c_Eol
	c_Qry += " 		                				  AND BSQ.BSQ_CODINT||BSQ.BSQ_CODEMP||BSQ.BSQ_MATRIC  = BCA.BCA_MATRIC  " + c_Eol
	c_Qry += " 		                                  AND BSQ_CODSEQ = BCA_XCREDI " + c_Eol
	c_Qry += " 		                                  AND BSQ.D_E_L_E_T_ = ' ' " + c_Eol

	c_Qry += " 		                LEFT JOIN " + RETSQLNAME("SE2") + " SE2 ON E2_FILIAL = '" + XFILIAL("SE2") +"' " + c_Eol
	c_Qry += " 		                                  AND E2_PREFIXO = 'DEV'  " + c_Eol
	c_Qry += " 		                                  AND E2_NUM     = BSQ_NUMTIT " + c_Eol
	c_Qry += " 		                                  AND E2_TIPO    = 'REM' " + c_Eol
	c_Qry += " 		                                  AND SE2.D_E_L_E_T_ = ' ' " + c_Eol

	//------------------------------------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 28/06/2021
	//------------------------------------------------------------------------------------------------------------------------------------
	//Como para a casa da moeda são gerados dois lotes (mensalidade e Copart)
	//estava duplicando o beneficiário na rotina da RN e assim gerando 2 creditos
	//Dessa forma apliquei a visualização da parametrização do lote, onde só irá trazer os lotes de mensalidade
	//ou lotes que contemplem mensalidade/coparticipação (opção ambos)
	//------------------------------------------------------------------------------------------------------------------------------------
	c_Qry += " 		                LEFT JOIN " + RETSQLNAME("BDC") + " BDC ON BDC.BDC_FILIAL = '" + XFILIAL("BDC") +"' " + c_Eol
	c_Qry += " 		                                  AND BDC.BDC_CODOPE||BDC.BDC_NUMERO = SE1.E1_PLNUCOB  	" + c_Eol
	c_Qry += " 		                                  AND BDC.BDC_MODPAG IN ('1','3')  						" + c_Eol
	c_Qry += " 		                                  AND BDC.D_E_L_E_T_ = ' '  							" + c_Eol
	//------------------------------------------------------------------------------------------------------------------------------------

	c_Qry += "						LEFT JOIN (                                                             " + c_Eol
	c_Qry += "                                        SELECT                                                " + c_Eol
	c_Qry += "                                            SZX_INT.ZX_CODINT,                                " + c_Eol
	c_Qry += "                                            SZX_INT.ZX_CODEMP,                                " + c_Eol
	c_Qry += "                                            SZX_INT.ZX_MATRIC,                                " + c_Eol
	c_Qry += "                                            MAX(SZX_INT.ZX_SEQ) ZX_SEQ                        " + c_Eol
	c_Qry += "                                        FROM                                                  " + c_Eol
	c_Qry += "                                            SZX020 SZX_INT                                    " + c_Eol
	c_Qry += "                                                                                              " + c_Eol
	c_Qry += "                                            INNER JOIN                                        " + c_Eol
	c_Qry += "                                                SZY020 SZY_INT                                " + c_Eol
	c_Qry += "                                            ON                                                " + c_Eol
	c_Qry += "                                                SZY_INT.ZY_FILIAL       = SZX_INT.ZX_FILIAL	" + c_Eol
	c_Qry += "                                                AND SZY_INT.ZY_SEQBA    = SZX_INT.ZX_SEQ      " + c_Eol
	c_Qry += "                                                AND SZY_INT.ZY_TIPOSV   = '1104'              " + c_Eol
	c_Qry += "                                                AND SZY_INT.D_E_L_E_T_  = ' '                 " + c_Eol
	c_Qry += "                                                                                              " + c_Eol
	c_Qry += "                                        WHERE                                                 " + c_Eol
	c_Qry += "                                            SZX_INT.ZX_FILIAL = ' '                           " + c_Eol
	c_Qry += "                                            AND SZX_INT.d_e_l_e_t_ = ' '                      " + c_Eol
	c_Qry += "                                        GROUP BY SZX_INT.ZX_CODINT,                           " + c_Eol
	c_Qry += "                                            SZX_INT.ZX_CODEMP,                                " + c_Eol
	c_Qry += "                                            SZX_INT.ZX_MATRIC                                 " + c_Eol
	c_Qry += "                        ) SZX                                                                 " + c_Eol
	c_Qry += "                        ON                                                                    " + c_Eol
	c_Qry += "                            SZX.ZX_CODINT = BA1.BA1_CODINT                                    " + c_Eol
	c_Qry += "                            AND SZX.ZX_CODEMP = BA1.BA1_CODEMP                                " + c_Eol
	c_Qry += "                            AND SZX.ZX_MATRIC = BA1.BA1_MATRIC                                " + c_Eol

	c_Qry += " 		WHERE BCA_FILIAL = ' ' " + c_Eol

	If AllTrim(cStatusAt) == "RN 412" .Or. Empty(AllTrim(cStatusAt))

		c_Qry += " 		      AND BCA_MOTBLO in ('" + c_MotUsuFn + "', '" + c_MotFamFn + "')   " + c_Eol

	ElseIf AllTrim(cStatusAt) == "RN 438"

		c_Qry += " 		      AND BCA_MOTBLO in ('" + c_MotPotUs + "', '" + c_MotPotFm + "')   " + c_Eol

	ElseIf AllTrim(cStatusAt) == "OBITO"

		c_Qry += " 		      AND BCA_MOTBLO in ('" + c_MotObtUs + "', '" + c_MotObtFn + "')   " + c_Eol

	EndIf

	If c_FilIni == "I" .or. lAnalisar// CARGA INICIAL COM OS TITULOS AGUARDANDO

		c_Qry += " 		               AND NOT EXISTS (  SELECT BCA_MATRIC||BCA_TIPREG  " + c_Eol
		c_Qry += "                            FROM " + RETSQLNAME("BCA") + " BCAD  " + c_Eol
		c_Qry += "                            WHERE BCAD.BCA_FILIAL = ' '  " + c_Eol
		c_Qry += "                            AND BCAD.BCA_MATRIC = BCA.BCA_MATRIC " + c_Eol
		c_Qry += "                            AND BCAD.BCA_TIPREG = BCA.BCA_TIPREG " + c_Eol
		c_Qry += "                            AND BCAD.BCA_XSTATU <> ' '  " + c_Eol

		If AllTrim(cStatusAt) == "RN 412" .Or. Empty(AllTrim(cStatusAt))

			c_Qry += "                            AND BCAD.BCA_MOTBLO in ('" + c_MotUsuFn + "', '" + c_MotFamFn + "')   " + c_Eol

		ElseIf AllTrim(cStatusAt) == "RN 438"

			c_Qry += "                            AND BCAD.BCA_MOTBLO in ('" + c_MotPotUs + "', '" + c_MotPotFm + "')   " + c_Eol

		ElseIf AllTrim(cStatusAt) == "OBITO"

			c_Qry += "                            AND BCAD.BCA_MOTBLO in ('" + c_MotObtUs + "', '" + c_MotObtFn + "')   " + c_Eol

		EndIf

		c_Qry += "                            AND D_E_L_E_T_ = ' '  ) " + c_Eol


		c_Qry += " 		      AND BCA_XSTATU in (' ', '1')   " + c_Eol

	ElseiF !EMPTY(TRIM(c_Fil))

		c_Qry += " 		      AND BCA_XSTATU in " + c_Fil + "   " + c_Eol

	EndIf

	If trim(dtos(cBloqDe)) <> '' .and.  trim(dtos(cBloqAte)) <> ''

		c_Qry += " 		      AND BA1_DATBLO >= '" + dtos(cBloqDe) + "' AND BA1_DATBLO <= '" + dtos(cBloqAte) + "' " + c_Eol

	EndIf

	c_Qry += " 	      AND BCA.D_E_L_E_T_ = ' ' " + c_Eol

	c_Qry += " 	      	        GROUP BY ' ' , "+ c_Eol
	c_Qry += " 	                  BA1_CODINT||'.'||BA1_CODEMP||'.'||BA1_MATRIC||'.'||BA1_TIPREG||'-'||BA1_DIGITO , "+ c_Eol
	c_Qry += " 	                  BA1_NOMUSR, "+ c_Eol
	c_Qry += " 	                  ZX_SEQ, 	  "+ c_Eol
	c_Qry += " 	                  BA1_CODPLA, "+ c_Eol //Angelo Henrique - data: 30/07/2019
	c_Qry += " 	                  BI3_DESCRI, "+ c_Eol //Angelo Henrique - data: 30/07/2019
	c_Qry += " 	                  BA1_DATBLO, "+ c_Eol
	c_Qry += " 	                  E1_NUM,     "+ c_Eol
	c_Qry += " 	                  E1_MESBASE||'/'||E1_ANOBASE,     "+ c_Eol
	c_Qry += " 	                  BCA_XDTCAR, " + c_Eol
	c_Qry += " 	                  BCA_XCREDI, " + c_Eol
	c_Qry += " 					  BSQ_VALOR,  " + c_Eol //Angelo Henrique - data: 30/07/2019
	c_Qry += " 					  NVL(BSQ_PREFIX||BSQ_NUMTIT||BSQ_PARCEL||BSQ_TIPTIT,' '), " + c_Eol //Angelo Henrique - data: 30/07/2019
	c_Qry += " 	                  E1_VALOR,   "    + c_Eol
	c_Qry += " 		DECODE(BA3_TIPPAG,'00','SEM ENVIO', "    + c_Eol
	c_Qry += " 		                               '01','PREVI', "  + c_Eol
	c_Qry += " 		                               '02','LIQ',  "   + c_Eol
	c_Qry += " 		                               '03','EMP',  "  + c_Eol
	c_Qry += " 		                               '04','112', " + c_Eol
	c_Qry += " 		                               '05','175', "    + c_Eol
	c_Qry += " 		                               '06','SISDEB', "    + c_Eol
	c_Qry += " 		                               '07','ITAU', "        + c_Eol
	c_Qry += " 		                               '08','PREVI','') , "	+ c_Eol

	c_Qry += " 		DECODE(BA3_YTPPAG,'00','SEM ENVIO', "     + c_Eol
	c_Qry += " 		                               '01','PREVI', "+ c_Eol
	c_Qry += " 		                               '02','LIQ',  "  + c_Eol
	c_Qry += " 		                               '03','EMP',  "   + c_Eol
	c_Qry += " 		                               '04','112', "  + c_Eol
	c_Qry += " 		                               '05','175', "   + c_Eol
	c_Qry += " 		                               '06','SISDEB', "  + c_Eol
	c_Qry += " 		                               '07','ITAU', "   + c_Eol
	c_Qry += " 		                               '08','PREVI','') , "	+ c_Eol

	c_Qry += " 	                  E1_SALDO,   " + c_Eol
	c_Qry += " 	                  DECODE(TRIM(BCA_XSTATU), '', 'AGUARDANDO', '1', 'AGUARDANDO', '2', 'AGUARDANDO COBRANCA','3', 'AGUARDANDO CARTA', '4', 'AGUARDANDO PGTO', '5' ,'CARTA ENVIADA')  , "+ c_Eol
	c_Qry += " 	                  ( CASE  WHEN E1_SALDO IS NULL THEN 'NAO COBRADO'  "+ c_Eol
	c_Qry += " 	                          WHEN E1_SALDO > 0 THEN 'COBRADO EM ABERTO' ELSE 'COBRADO BAIXADO' END ), "+ c_Eol
	c_Qry += " 	                  NVL(SE2.E2_FILIAL||SE2.E2_PREFIXO||E2_NUM, ' '), "+ c_Eol  //Angelo Henrique - data: 30/07/2019
	c_Qry += " 	                  NVL(E2_NUM, ' ') "+ c_Eol

	c_Qry += " 	    ORDER BY 2 " + c_Eol

	memowrite("c:\temp\caba347.sql",c_Qry)
	If Select("QRYBLOQ") <> 0

		("QRYBLOQ")->(DbCloseArea())

	Endif

	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"QRYBLOQ",.T.,.T.)

	For ni := 2 to Len(a_Struct)
		If a_Struct[ni,2] != 'C'
			TCSetField("QRYBLOQ", a_Struct[ni,1], a_Struct[ni,2],a_Struct[ni,3],a_Struct[ni,4])
		Endif
	Next

	cTmp2 := CriaTrab(NIL,.F.)
	Copy To &cTmp2

	dbCloseArea()

	dbUseArea(.T.,,cTmp2,"QRYBLOQ",.T.)

	("QRYBLOQ")->(DbGoTop())

	If ("QRYBLOQ")->(Eof())

		l_Ret := .F.

	Endif

	oBrAn:Refresh()
	oDlg1:Refresh()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fAtuBrw
atualiza browse
@author  marcela
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fAtuBrw(cTmpAlias,c_CampoOk,cGet,lTodos)

	Local c_Marca 	:= " "//Space(TamSx3(c_CampoOk)[1])
	Local c_MatTmp 	:= ""

	SA1->(DbSetOrder(1))
	If lTodos <> Nil .And. lTodos
		(c_AliaBlq)->(DbGoTop())
		c_Marca := If(Empty((c_AliaBlq)->&(c_CampoOk)),"X","")
		While (c_AliaBlq)->(!Eof())
			(c_AliaBlq)->(RecLock(c_AliaBlq,.F.))
			(c_AliaBlq)->&(c_CampoOk) := c_Marca
			(c_AliaBlq)->(MsUnLock())
			If Empty((c_AliaBlq)->&(c_CampoOk))
				nTotReg --
			Else
				nTotReg ++
			Endif
			(c_AliaBlq)->(DbSkip())
		EndDo
		(cTmpAlias)->(DbGoTop())
	Else

		c_MatTmp := substr((c_AliaBlq)->Matricula, 1, 16)

		(c_AliaBlq)->(DbGoTop())
		c_Marca := If(Empty((c_AliaBlq)->&(c_CampoOk)),"X","")
		While (c_AliaBlq)->(!Eof())

			If c_MatTmp == substr((c_AliaBlq)->Matricula, 1, 16)

				(c_AliaBlq)->(RecLock(c_AliaBlq,.F.))
				(c_AliaBlq)->&(c_CampoOk) := c_Marca
				(c_AliaBlq)->(MsUnLock())

				If Empty((c_AliaBlq)->&(c_CampoOk))
					nTotReg --
				Else
					nTotReg ++
				Endif

			EndIf

			(c_AliaBlq)->(DbSkip())

		EndDo
		(cTmpAlias)->(DbGoTop())
	Endif

	oBrAn:Refresh()
	oDlg1:Refresh()

Return(.T.)

//-------------------------------------------------------------------
/*/{Protheus.doc} function fAnalisar
 Função principal responsável por analisar as cobranças
@author  marcela
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static function fAnalisar()

	Local a_DadUsr := {}

	dbSelectArea( c_AliaBlq )
	(c_AliaBlq)->( dbGotop())

	While !(c_AliaBlq)->( EOF() )

		If trim((c_AliaBlq)->XOK) == "X"

			c_Matric:= replace((c_AliaBlq)->MATRICULA, '.', '')
			c_Matric:= replace(c_Matric, '-', '')

			dbSelectArea("BA1")
			dbSetOrder(2)
			If dbSeek( xFilial("BA1") + c_Matric )

				a_DadUsr := {	BA1->BA1_CODINT,; // 1
					BA1->BA1_CODEMP,; // 2
					BA1->BA1_MATRIC,; // 3
					BA1->BA1_CONEMP,; // 4
					BA1->BA1_VERCON,; // 5
					BA1->BA1_SUBCON,; // 6
					BA1->BA1_VERSUB,; // 7
					"",;// 8
					BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),; // 9
					BA1->BA1_TIPREG,;    //10
					trim(str(Calc_Idade(((c_AliaBlq)->BA1_DATBLO - 30),BA1->BA1_DATNAS))),; // 11
					BA1->BA1_MUDFAI,;  //12
					BA1->BA1_FAICOB }// 13

			Else

				Alert("Ruim BA1")
				m := 1 + n

			EndIf

			If TRIM( (c_AliaBlq)->BCA_XSTATU ) == "AGUARDANDO"

				n_ValCob 	:= fCalcCob( BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC, BA1->BA1_TIPREG, a_DadUsr[11], (c_AliaBlq)->BA1_DATBLO, a_DadUsr[12], a_DadUsr[13], (c_AliaBlq)->E1_NUM )

				If n_ValCob <> 0

					c_CodCred 	:= fGeraCred( a_DadUsr, SUBSTR(DTOS(BA1->BA1_DATBLO), 1, 4), SUBSTR(DTOS(BA1->BA1_DATBLO), 5, 2), n_ValCob )

				Else

					c_CodCred 	:= ""

				EndIf

				dbSelectArea("BA3")
				dbSetOrder(1)
				dbSeek( xFilial("BA3") + BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC )

				dbSelectArea("BCA")
				dbGoto( VAL((c_AliaBlq)->RECBCA) )

				RecLock("BCA",.F.)

				BCA_XSTATU := iIf( n_ValCob == 0 .OR. BA3->BA3_COBNIV <> '1', "3", "2")
				BCA_XCREDI := c_CodCred

				MsUnLock()

			EndIf

		EndIf

		(c_AliaBlq)->( dbSkip() )

	EndDo

	(c_AliaBlq)->( dbGotop())

	fPegaBloqs( "C" )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fCalcCob
calcula cobrança
@author  marcela
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fCalcCob(c_CodInt, c_Codemp, c_Matric, c_TipReg, c_Idade, d_Data, c_MudFai, c_FaiCob, c_NumTit)

	Local c_Qry 	:= ""
	Local l_BDK 	:= .F.
	Local n_PerDesc := 0
	Local n_ValDesc := 0
	Local n_Valor   := 0
	Local n_ValFin  := 0
	Local n_ValPRata:= 0
	Local n_ValAber := 0
	Local c_Comp    := substr(dtos(d_Data),1, 6)
	Local nTipo		:= 	''	 // 20/12/2018 - Mateus Medeiros

	c_Qry := " SELECT BDK_CODFAI, (CASE WHEN BDK_ANOMES <= '" + c_Comp + "' THEN BDK_VALOR ELSE BDK_VLRANT END) BDK_VALOR " + c_Eol
	c_Qry += " FROM " + RETSQLNAME("BDK") + " " + c_Eol
	c_Qry += " WHERE BDK_FILIAL = ' ' " + c_Eol
	c_Qry += " 	     AND BDK_CODINT = '" + c_CodInt + "' " + c_Eol
	c_Qry += " 	     AND BDK_CODEMP = '" + c_Codemp + "' " + c_Eol
	c_Qry += " 	     AND BDK_MATRIC = '" + c_Matric + "' " + c_Eol
	c_Qry += " 	     AND BDK_TIPREG = '" + c_TipReg + "' " + c_Eol
	c_Qry += " 	     AND d_e_l_e_t_ = ' ' " + c_Eol

	If c_MudFai == '0'

		c_Qry += " 	     AND   BDK_CODFAI = '" + c_FaiCob + "'  " + c_Eol

	Else

		c_Qry += " 	     AND   '" + c_Idade + "' >= BDK_IDAINI AND '" + c_Idade + "' <= BDK_IDAFIN   "   + c_Eol

	EndIf

	c_Qry += " 	     AND ROWNUM = 1 " + c_Eol

	TCQUERY c_Qry ALIAS "QRYBDK" NEW

	If !QRYBDK->( EOF() )

		l_BDK := .T.

		n_Valor := QRYBDK->BDK_VALOR

		c_Qry := " SELECT BDQ_PERCEN, BDQ_VALOR, BDQ_TIPO   "+ c_Eol
		c_Qry += " FROM " + RETSQLNAME("BDQ") + " "+ c_Eol
		c_Qry += " WHERE BDQ_FILIAL = ' ' "+ c_Eol
		c_Qry += " 	     AND BDQ_CODINT = '" + c_CodInt + "' "+ c_Eol
		c_Qry += " 	     AND BDQ_CODEMP = '" + c_Codemp + "' "+ c_Eol
		c_Qry += " 	     AND BDQ_MATRIC = '" + c_Matric + "' "+ c_Eol
		c_Qry += " 	     AND BDQ_TIPREG = '" + c_TipReg + "' "+ c_Eol
		c_Qry += " 	     AND BDQ_CODFAI = '" + QRYBDK->BDK_CODFAI + "' "+ c_Eol
		c_Qry += " 	     AND '" + DTOS( d_Data ) + "' BETWEEN BDQ_DATDE and BDQ_DATATE "+ c_Eol
		c_Qry += " 	     AND d_e_l_e_t_ = ' ' "	+ c_Eol

		c_Qry += " 	     AND ROWNUM = 1 "+ c_Eol

		TCQUERY c_Qry ALIAS "QRYBDQ" NEW

		If !QRYBDQ->( EOF() )

			n_PerDesc := QRYBDQ->BDQ_PERCEN
			n_ValDesc := QRYBDQ->BDQ_VALOR

			// -----------------------------------------------------
			// Mateus Medeiros - 20/12/2018 - - GLPI - 54870
			// Ajuste para identificar se é acréscimo ou decréscimo.
			// -----------------------------------------------------
			nTipo     := QRYBDQ->BDQ_TIPO
			// -----------------------------------------------------
			// FIM - MATEUS MEDEIROS
			// -----------------------------------------------------

		EndIf

		QRYBDQ->( dbCloseArea(  ) )

	EndIf

	QRYBDK->( dbCloseArea(  ) )

	If !l_BDK

		c_Qry := " SELECT BBU_CODFAI, (CASE WHEN BBU_ANOMES <=  '" + c_Comp + "' THEN BBU_VALFAI ELSE BBU_VLRANT END) BBU_VALFAI " + c_Eol
		c_Qry += " FROM " + RETSQLNAME("BBU") + " "
		c_Qry += " WHERE BBU_FILIAL = ' ' "
		c_Qry += " 	     AND BBU_CODOPE = '" + c_CodInt + "' "
		c_Qry += " 	     AND BBU_CODEMP = '" + c_Codemp + "' "
		c_Qry += " 	     AND BBU_MATRIC = '" + c_Matric + "' "
		c_Qry += " 	     AND d_e_l_e_t_ = ' ' "

		If c_MudFai == '0'

			c_Qry += " 	     AND   BBU_CODFAI = '" + c_FaiCob + "'  " + c_Eol

		Else

			c_Qry += " 	     AND   '" + c_Idade + "' >= BBU_IDAINI AND '" + c_Idade + "' <= BBU_IDAFIN   "   + c_Eol

		EndIf


		c_Qry += " 	     AND ROWNUM = 1 "

		TCQUERY c_Qry ALIAS "QRYBBU" NEW

		If !QRYBBU->( EOF() )

			l_BBU := .T.

			n_Valor := QRYBBU->BBU_VALFAI

			c_Qry := " SELECT BFY_PERCEN, BFY_VALOR,BFY_TIPO "
			c_Qry += " FROM " + RETSQLNAME("BFY") + " "
			c_Qry += " WHERE BFY_FILIAL = ' ' "
			c_Qry += " 	     AND BFY_CODOPE = '" + c_CodInt + "' "
			c_Qry += " 	     AND BFY_CODEMP = '" + c_Codemp + "' "
			c_Qry += " 	     AND BFY_MATRIC = '" + c_Matric + "' "
			c_Qry += " 	     AND BFY_CODFAI = '" + QRYBBU->BBU_CODFAI + "' "
			c_Qry += " 	     AND '" + DTOS( d_Data ) + "' BETWEEN BFY_DATDE and BFY_DATATE "
			c_Qry += " 	     AND d_e_l_e_t_ = ' ' "
			c_Qry += " 	     AND ROWNUM = 1 "

			TCQUERY c_Qry ALIAS "QRYBFY" NEW

			If !QRYBFY->( EOF() )

				n_PerDesc := QRYBFY->BFY_PERCEN
				n_ValDesc := QRYBFY->BFY_VALOR
				// -------------------------------------------
				// 20/12/2018 - Mateus Medeiros - GLPI - 54870
				// -------------------------------------------
				// correção para identificar se é acréscimo
				// ou decréscimo
				// -------------------------------------------
				nTipo     := QRYBFY->BFY_TIPO
				// ----------------------
				// FIM - MATEUS MEDEIROS
				// ----------------------
			EndIf

			QRYBFY->( dbCloseArea(  ) )

		EndIf

		QRYBBU->( dbCloseArea(  ) )

	EndIf

	If n_PerDesc == 0 .AND. n_ValDesc == 0

		n_ValFin := n_Valor

	ElseIf  n_PerDesc == 0 .AND. n_ValDesc <> 0

		// -------------------------------------------
		// 20/12/2018 - Mateus Medeiros - GLPI - 54870
		// -------------------------------------------
		// correção para identificar se é acréscimo
		// ou decréscimo
		// -------------------------------------------
		IF nTipo == '1' // decréscimo
			n_ValFin := n_Valor - n_ValDesc
		elseif  nTipo == '2' // acréscimo
			n_ValFin := n_Valor + n_ValDesc
		endif
		// ----------------------
		// FIM - MATEUS MEDEIROS
		// ----------------------

	ElseIf  n_PerDesc <> 0 .AND. n_ValDesc == 0

		// -------------------------------------------
		// 20/12/2018 - Mateus Medeiros - GLPI - 54870
		// -------------------------------------------
		// correção para identificar se é acréscimo
		// ou decréscimo
		// -------------------------------------------
		IF nTipo == '1' // decréscimo
			n_ValFin := n_Valor-(n_Valor*n_PerDesc/100)
		elseif  nTipo == '2' // acréscimo
			n_ValFin := n_Valor+(n_Valor*n_PerDesc/100)
		endif
		// ----------------------
		// FIM - MATEUS MEDEIROS
		// ----------------------

	Else

		n_ValFin := n_Valor

	EndIf

	//**'Calcula prorata'**//
	n_DiasMes := val( substr( dtos( lastday( d_Data ) ), 7 ,2 ) )
	n_DiasCob := val( substr( dtos( d_Data ) , 7 ,2 ) )

	n_DiasCob := n_DiasMes - n_DiasCob

	If !Empty( c_NumTit ) .and. n_DiasMes == n_DiasCob

		n_ValPRata := 0

	Else

		n_ValPRata := round((n_ValFin/n_DiasMes)*n_DiasCob, 2)

	EndIf

Return n_ValPRata  + n_ValAber

//-------------------------------------------------------------------
/*/{Protheus.doc} function fGeraCred
gera credito
@author  marcela
@since   01/01/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fGeraCred( a_DadosUsr, c_Ano, c_Mes, n_Valor )

	Local c_Nivel

	dbSelectArea("BA3")
	dbSetOrder(1)
	If dbSeek( xFilial("BA3") +  a_DadosUsr[1] + a_DadosUsr[2] + a_DadosUsr[3])

		If BA3->BA3_COBNIV == '1'

			c_Nivel := "5"

		Else

			c_Nivel := "3"

		EndIf

	EndIf

	BSQ->(Reclock("BSQ",.T.))
	BSQ->BSQ_FILIAL	:= xFilial("BSQ")
	BSQ->BSQ_CODSEQ	:= PLSA625Cd("BSQ_CODSEQ","BSQ",1,"D_E_L_E_T_"," ")
	BSQ->BSQ_CODINT := a_DadosUsr[1]
	BSQ->BSQ_CODEMP	:= a_DadosUsr[2]
	BSQ->BSQ_MATRIC	:= a_DadosUsr[3]
	BSQ->BSQ_CONEMP	:= a_DadosUsr[4]
	BSQ->BSQ_VERCON	:= a_DadosUsr[5]
	BSQ->BSQ_SUBCON	:= a_DadosUsr[6]
	BSQ->BSQ_VERSUB	:= a_DadosUsr[7]
	BSQ->BSQ_COBNIV := c_Nivel

	If c_Nivel == '5'

		BSQ->BSQ_USUARI	:= a_DadosUsr[9]
		//Conforme regra de inclusao de debito/credito,
		//quando eh informado o campo BSQ_USUARI, o
		//nivel devera sempre ser 5

	Endif

	BSQ->BSQ_ANO	:= c_Ano
	BSQ->BSQ_MES	:= c_mes
	BSQ->BSQ_CODLAN	:= iIf(cEmpAnt == '01', '037', '014' )
	BSQ->BSQ_VALOR	:= n_Valor
	BSQ->BSQ_NPARCE	:= "1"

	If AllTrim(cStatusAt) == "RN 438"

		BSQ->BSQ_OBS	:= "DEVOLUCAO RETROATIVA RN 438"

	Else

		BSQ->BSQ_OBS	:= "DEVOLUCAO RETROATIVA RN 412"

	EndIf

	BSQ->BSQ_AUTOMA	:= "1"
	BSQ->BSQ_TIPO	:= "1"
	BSQ->BSQ_TIPEMP	:= "2"
	BSQ->BSQ_ATOCOO	:= "1"

	BSQ->(MsUnlock())

Return BSQ->BSQ_CODSEQ

//-------------------------------------------------------------------
/*/{Protheus.doc} function fPagamento
pagamento
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fPagamento( c_Cliente, c_Prefix, c_Ncc )

	Local c_MatFil := ""

	// Seleciona area tmp
	dbSelectArea( c_AliaBlq )
	(c_AliaBlq)->( dbGotop())

	While !(c_AliaBlq)->( EOF() )

		If trim((c_AliaBlq)->XOK) == "X" .AND. ALLTRIM((c_AliaBlq)->BCA_XSTATU) == "AGUARDANDO PGTO"

			dbSelectArea("BCA")
			dbGoTo(val((c_AliaBlq)->RECBCA))

			//--------------------------------------------------
			//Angelo Henrique - Data:06/10/2021
			//--------------------------------------------------
			//Melhorando a chave da BSQ
			//--------------------------------------------------
			dbSelectArea("BA1")
			dbSetOrder(2)//BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
			dbSeek( xFilial("BA1") + BCA->(BCA_MATRIC+BCA_TIPREG))

			dbSelectArea("BSQ")
			dbSetOrder(1)
			If dbSeek( xFilial("BSQ") + BCA->BCA_XCREDI + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) ) .AND. BSQ->BSQ_TIPTIT == 'NCC'

				If !(BSQ->BSQ_NUMTIT $ c_MatFil)

					fGeraPgto( BSQ->BSQ_PREFIX, BSQ->BSQ_NUMTIT, val((c_AliaBlq)->RECBCA) )
					c_MatFil += BSQ->BSQ_NUMTIT + '||'

				Else

					dbSelectArea("BCA")
					dbGoTo( val((c_AliaBlq)->RECBCA) )

					BCA->(Reclock("BCA",.F.))

					BCA->BCA_XSTATU	:= "3"

					BCA->(MsUnlock())

				EndIf

			Else

				Aviso("Atenção","Não foi encontrado o lançamento: " + BCA->BCA_XCREDI + ". Favor analisar.",{"OK"})

			EndIf

		EndIf

		(c_AliaBlq)->( dbSkip() )

	EndDo

	fPegaBloqs( "C" )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fGeraPgto
gera pagamento
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fGeraPgto( c_Prefix, c_Ncc , n_RecBCA)

	Local aDadSe1	:= {}
	Local _aDadSe2	:= {}
	Local cCodFor	:= Space(TamSX3("A2_COD")[1])
	Local cLojFor	:= "01"
	Local cContab	:= GETMV("MV_XCTBFOR") //"211119031"  - Angelo Henrique - Data: 06/06/2019
	Local cDirf		:= "2"
	Local cHistor	:= ""
	Local cTitOrig	:= Space(TamSx3("E2_TITORIG")[1])
	Local cBanco    := "341"
	Local cAgencia  := "6015 "
	Local cConta    := "017251    "

	Private lMsHelpAuto	:= .T.
	Private lMsErroAuto	:= .F.
	Private aRotina		:= {{"","",0,1},{"","",0,2},{"","",0,3},{"","",0,4},{"","Fa050Delet",0,5}}
	Private cCadastro	:= ""
	Private lAltera		:= .F.
	Private lF050Auto	:= .T.
	Private nRecno		:= 0
	Private lRet		:= .F.
	Private c_CPF 	    := ""
	Private c_Nome 	    := ""
	Private c_Banco 	:= ""
	Private c_Agencia 	:= ""
	Private c_Conta 	:= ""
	Private c_Digito    := ""
	Private c_DigAge    := ""
	Private c_Plano     := ""
	Private c_Empresa   := ""
	Private _nSaldNcc 	:= 0

	SA1->(DbSetOrder(1))
	SA2->(DbSetOrder(3))
	SE1->(DbSetOrder(1))
	SE2->(DbSetOrder(1))
	B44->(DbSetOrder(3))

	If AllTrim(cStatusAt) == "RN 412"

		cHistor	 := "PAGTO. DEV RN 412"

	ElseIf AllTrim(cStatusAt) == "RN 438"

		cHistor	 := "PAGTO. DEV RN 438"

	Else

		cHistor	 := "PAGTO. DEV OBITO"

	EndIf

	Begin Transaction
		nRegs := 0

		c_Ncc := c_Ncc + SPACE(tamsx3("E1_PARCELA")[1]) + "NCC" //Angelo Henrique - Data: 02/10/2020 - Release 27

		dbSelectArea("SE1")
		dbSetOrder(1)
		If dbSeek( xFilial("SE1") +  c_Prefix + c_Ncc )

			dbSelectArea("SA1")
			dbSetOrder(1)
			If !DbSeek( xFilial("SA1") + SE1->E1_CLIENTE )

				Alert("Não tem cliente")

				Return

			EndIf

			dbSelectArea("BA1")
			dbSetOrder(2)
			If dbSeek( xFilial("BA1") + SE1->E1_CODINT + SE1->E1_CODEMP + SE1->E1_MATRIC + '00' )

				c_Plano     := BA1->BA1_CODPLA
				c_Empresa 	:= BA1->BA1_CODEMP

			EndIf

		Else

			Alert("Não tem NCC")
			Return

		EndIf


		dbSelectArea("BCA")
		dbGoTo( n_RecBCA )

		d_VencRea := DATAVALIDA(BCA->BCA_DATA + 30)

		If d_VencRea <= dDataBase

			d_VencRea := DATAVALIDA(dDataBase + 30)

		EndIf

		A_RET := {}
		A_RET := TelaConta( SE1->E1_CLIENTE, SE1->E1_LOJA, SA1->A1_CGC, SA1->A1_NOME, SA1->A1_XBANCO, SA1->A1_XAGENC, SA1->A1_XCONTA, SA1->A1_XDGCON, , d_VencRea  )

		// Se retornou dados no vetor e se a tela foi confirmada
		If Len( A_RET ) > 0 .AND. A_RET[1] == 'C'

			c_CPF 	    := A_RET[2]
			c_Nome 	    := A_RET[3]
			c_Banco 	:= A_RET[4]
			c_Agencia 	:= A_RET[5]
			c_Conta 	:= A_RET[6]
			c_Digito    := A_RET[7]
			c_DigAge    := A_RET[8]
			d_VencRea   := A_RET[9]

		Else

			c_CPF 	    := SA1->A1_CGC
			c_Nome 	    := SA1->A1_NOME
			c_Banco 	:= SA1->A1_XBANCO
			c_Agencia 	:= SA1->A1_XAGENC
			c_Conta 	:= SA1->A1_XCONTA
			c_Digito 	:= SA1->A1_XDGCON
			c_DigAge 	:= SA1->A1_XDVAGE

		EndIf

		dbSelectArea("SA2")
		dbSetOrder(3)
		If !SA2->(DbSeek(xFilial("SA2")+c_CPF))

			cCodFor := GetSX8Num("SA2","A2_COD")

			aDadSa2 := {{"A2_COD"     ,cCodFor  ,Nil},;
				{"A2_LOJA"    ,cLojFor         	,Nil},;
				{"A2_NOME"    ,c_Nome          	,Nil},;
				{"A2_NREDUZ"  ,"TESTE" 			,.F.},;
				{"A2_CGC"     ,c_CPF           	,Nil},;
				{"A2_END"     ,SA1->A1_END     	,Nil},;
				{"A2_EST"     ,'RJ'            	,Nil},;
				{"A2_COD_MUN" ,'04557'         	,Nil},;
				{"A2_MUN"     ,'RIO DE JANEIRO'	,Nil},;
				{"A2_CEP"     ,SA1->A1_CEP     	,Nil},;
				{"A2_CONTATO" ,SA1->A1_CONTATO 	,Nil},;
				{"A2_TEL"     ,SA1->A1_TEL     	,Nil},;
				{"A2_DDD"     ,SA1->A1_DDD     	,Nil},;
				{"A2_FAX"     ,SA1->A1_FAX     	,Nil},;
				{"A2_CONTA"   ,cContab         	,Nil},;
				{"A2_TIPO"    ,SA1->A1_PESSOA  	,Nil},;
				{"A2_DIRF"    ,cDirf           	,Nil},;
				{"A2_YTPTITU" ,'4'             	,Nil}}

			MSExecAuto({|x,y| MATA020(x,y)},aDadSa2,3)

			If lMsErroAuto
				RollBackSX8()
				DisarmTransaction()
				MostraErro("\PDF_RN412\ERROS", cCodFor + DTOS(DDATABASE)+".TXT")
				MostraErro()

				Alert("Fornecedor " + c_Nome +"  não pode ser criado. ")

				Return .F.

			Else

				ConfirmSX8()

				//------------------------------------------------------------------
				//Angelo Henrique - Data: 07/05/2019
				//------------------------------------------------------------------
				//Após a migração o ExecAuto estava apresentando erro
				//para as informações que funcionavam na P11
				//------------------------------------------------------------------
				DbSelectArea("SA2")
				DbSetOrder(1)
				If DbSeek(xFilial("SA2") + cCodFor + cLojFor)

					RecLock("SA2", .F.)

					SA2->A2_BANCO	:= c_Banco
					SA2->A2_AGENCIA	:= c_Agencia
					SA2->A2_NUMCON	:= c_Conta
					SA2->A2_YDAC   	:= c_Digito
					SA2->A2_XDVAGE	:= c_DigAge
					SA2->A2_NREDUZ	:= AllTrim(c_Nome)
					SA2->A2_BAIRRO	:= SA1->A1_BAIRRO
					SA2->A2_EMAIL	:= SA1->A1_EMAIL

					SA2->(MsUnLock())

				Endif

			EndIf

		Else

			SA2->(Reclock("SA2",.F.))
			SA2->A2_END		:= SA1->A1_END
			SA2->A2_BAIRRO	:= SA1->A1_BAIRRO
			SA2->A2_MUN		:= SA1->A1_MUN
			SA2->A2_EST		:= SA1->A1_EST
			SA2->A2_CEP		:= SA1->A1_CEP
			SA2->A2_CONTATO	:= SA1->A1_CONTATO
			SA2->A2_TEL		:= SA1->A1_TEL
			SA2->A2_DDD		:= SA1->A1_DDD
			SA2->A2_FAX		:= SA1->A1_FAX
			SA2->A2_EMAIL	:= SA1->A1_EMAIL
			SA2->A2_CONTA	:= cContab
			SA2->A2_TIPO	:= SA1->A1_PESSOA
			SA2->A2_BANCO	:= c_Banco
			SA2->A2_AGENCIA	:= c_Agencia
			SA2->A2_NUMCON	:= c_Conta
			SA2->A2_YDAC	:= c_Digito
			SA2->A2_XDVAGE  := c_DigAge
			SA2->(MsUnlock())

			cCodFor := SA2->A2_COD

		EndIf

		DBSelectArea("SE1")
		DbSetOrder(1)//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		DbSeek(xFilial("SE1")+c_Prefix + c_Ncc)

		If SE1->E1_SALDO <> 0

			_nSaldNcc := SE1->E1_SALDO

			aDadSe1 := {{"E1_PREFIXO"  ,SE1->E1_PREFIXO , Nil }, ;
				{"E1_NUM"      ,SE1->E1_NUM     , Nil }, ;
				{"E1_PARCELA"  ,SE1->E1_PARCELA , Nil }, ;
				{"E1_TIPO"     ,SE1->E1_TIPO    , Nil }, ;
				{"E1_CLIENTE"  ,SE1->E1_CLIENTE , Nil }, ;
				{"E1_LOJA"     ,SE1->E1_LOJA    , Nil }, ;
				{"AUTMOTBX"    ,'REE'           , Nil }, ;
				{"AUTBANCO"    ,cBanco          , Nil }, ;
				{"AUTAGENCIA"  ,cAgencia        , Nil }, ;
				{"AUTCONTA"    ,cConta          , Nil }, ;
				{"AUTDTBAIXA"  ,dDataBase       , Nil }, ;
				{"AUTDTCREDITO",dDataBase       , Nil }, ;
				{"AUTHIST"     ,cHistor         , Nil }, ;
				{"AUTVALREC"   ,SE1->E1_SALDO   , Nil }}

			lMsErroAuto := .F.
			MsExecAuto({ |x,y| Fina070(x,y)},aDadSe1,3)

			If lMsErroAuto

				DisarmTransaction()
				MostraErro()

				Alert("Pagamento não pode ser criado. ")

				Return .F.

			Else

				cTitOrig:= SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO

				cCusto  := "998"
				cNatPln := "41300"

				_aDadSe2 := {{"E2_PREFIXO"  ,"DEV" 		,.F.},;
					{"E2_NUM"      ,SE1->E1_NUM     	,.F.},;
					{"E2_PARCELA"  ,SE1->E1_PARCELA 	,.F.},;
					{"E2_TIPO"     ,'REM'           	,.F.},;
					{"E2_NATUREZ"  ,cNatPln         	,.F.},;
					{"E2_FORNECE"  ,cCodFor         	,.F.},;
					{"E2_LOJA"     ,cLojFor         	,.F.},;
					{"E2_EMISSAO"  ,SE1->E1_EMISSAO 	,.F.},;
					{"E2_VENCTO"   ,d_VencRea  			,.F.},;
					{"E2_VENCREA"  ,d_VencRea 			,.F.},;
					{"E2_HIST"     ,'PAGTO. DEV RN 412' ,.F.},;
					{"E2_CCD"      ,cCusto          	,.F.},;
					{"E2_VALOR"    ,_nSaldNcc			,.F.},; //Angelo Henrique - Data: 02/10/2020 - Release 27 - trocado E1_VALOR PARA E1_SALDO
					{"E2_VLCRUZ"   ,_nSaldNcc			,.F.},;
					{"E2_CLVLDB"   ,c_Empresa       	,.F.},;
					{"E2_CLVLCR"   ,c_Empresa       	,.F.},;
					{"E2_ITEMD"    ,c_Plano         	,.F.},;
					{"E2_ITEMC"    ,c_Plano         	,.F.} }

				lMsErroAuto := .F.

				MsExecAuto({ |x,y,z| FINA050(x,y,z)},_aDadSe2,,3)

				If lMsErroAuto

					DisarmTransaction()
					MostraErro()

				Else

					SE2->(Reclock("SE2",.F.))

					SE2->E2_ORIGEM 	:= 'CABA347'
					SE2->E2_TITORIG := cTitOrig

					SE2->(MsUnlock())

					lRet := .T.

					dbSelectArea("BCA")
					dbGoTo( n_RecBCA )

					BCA->(Reclock("BCA",.F.))

					If AllTrim(cStatusAt) == "OBITO" .Or. AllTrim(cStatusAt) == "RN 438"

						BCA->BCA_XSTATU	:= "5"

					Else

						BCA->BCA_XSTATU	:= "3"

					EndIf

					BCA->(MsUnlock())

				Endif

			EndIf

		Else

			Alert("Atencao, titulo: " + c_Prefix + c_Ncc + " encontra-se com saldo zerado, favor avaliar.")

		EndIf

	End Transaction

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function fGerCart
gera cart
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fGerCart( c_Cliente, c_Prefix, c_Ncc )

	Local c_MatRaiz:= ""

	// Seleciona area tmp
	dbSelectArea( c_AliaBlq )
	(c_AliaBlq)->( dbGotop())

	While !(c_AliaBlq)->( EOF() )

		If trim((c_AliaBlq)->XOK) == "X" .AND. ALLTRIM((c_AliaBlq)->BCA_XSTATU) == "AGUARDANDO CARTA"

			dbSelectArea("BCA")
			dbGoTo(val((c_AliaBlq)->RECBCA))

			If !( substr( ( c_AliaBlq )->MATRICULA , 1, 16) $ c_MatRaiz )

			c_MatRaiz := substr( ( c_AliaBlq )->MATRICULA , 1, 16) + "||"

			fCarta( substr( ( c_AliaBlq )->MATRICULA , 1, 16) )

		EndIf

		EndIf

		(c_AliaBlq)->( dbSkip() )

	EndDo

	fPegaBloqs( "C" )

	Aviso("Atenção","Enviado e-mail(s) para o(s) Beneficiario(s)",{"OK"})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fCarta
carta
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fCarta( c_Matric )

	Local a_TiposFat 	:= {}
	Local n_Total    	:= 0
	Local a_Dados 		:= {}
	Local n_Pos			:= 0

	c_Matric := rEPLACE(c_Matric, '.', '')

	a_TiposFat := {	{ '946'						, 'Credito Prorata'  , 0 },; // 1
		{ '101'						, 'Mensalidade'      , 0 },; // 2
		{ '181||922||952||930||916'	, 'Parcelamento'     , 0 },; // 3
		{ '151||907||152'			, 'Copart'           , 0 },; // 4
		{ '901'						, 'FARMACIA'         , 0 },; // 5
		{ 'XXX'						, 'Outros         '  , 0 },; // 6
		{ 'TTT'						, 'Total          '  , 0 }}  // 7


	c_Qry := " SELECT 	BM1_CODINT,   				"+ c_Eol
	c_Qry += "          BM1_CODEMP,   				"+ c_Eol
	c_Qry += "          BM1_MATRIC,   				"+ c_Eol
	c_Qry += "          BM1_TIPREG,   				"+ c_Eol
	c_Qry += "          BM1_CODTIP,   				"+ c_Eol
	c_Qry += "     		BM1_DESTIP,   				"+ c_Eol
	c_Qry += "     		E1_CLIENTE,   				"+ c_Eol
	c_Qry += "     		BA1_TIPUSU,   				"+ c_Eol
	c_Qry += "     		BA1_NOMUSR,   				"+ c_Eol
	c_Qry += "     		BA1_DIGITO,   				"+ c_Eol
	c_Qry += "     		BA1_DATBLO,   				"+ c_Eol
	c_Qry += "     		BCA.R_E_C_N_O_ RECBCAQ ,   	"+ c_Eol
	c_Qry += "     		BA1_CODINT,    				"+ c_Eol
	c_Qry += "     		BA1_CODEMP,    				"+ c_Eol
	c_Qry += "     		BA1_MATRIC,    				"+ c_Eol
	c_Qry += "     		BA1_TIPREG,   				"+ c_Eol
	c_Qry += "     		BA1_DIGITO,   				"+ c_Eol
	c_Qry += "     		RETORNA_DESC_PLANO_MS('" + iif(cEmpAnt == '01', 'C', 'I') + "', BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG) PLANO,   "+ c_Eol
	c_Qry += "    		NVL(SUM (DECODE ( BM1_TIPO , 1 ,BM1_VALOR, (BM1_VALOR*-1))),0) VALOR "+ c_Eol

	c_Qry += "	FROM " + RETSQLNAME("BCA") + " BCA INNER JOIN " + RETSQLNAME("BA3") + " BA3 ON  BA3_FILIAL = '" + XFILIAL("BA3") + "' "+ c_Eol
	c_Qry += "	                                  AND BA3_CODINT||BA3_CODEMP||BA3_MATRIC = BCA_MATRIC " + c_Eol
	c_Qry += "	                                  AND BA3.D_E_L_E_T_ = ' ' "+ c_Eol
	c_Qry += "	                INNER JOIN " + RETSQLNAME("BA1") + " BA1 ON BA1_FILIAL = '" + XFILIAL("BA1") + "' "  + c_Eol
	c_Qry += "	                                  AND BA1_CODINT = BA3_CODINT "+ c_Eol
	c_Qry += "	                                  AND BA1_CODEMP = BA3_CODEMP " + c_Eol
	c_Qry += "	                                  AND BA1_MATRIC = BA3_MATRIC "+ c_Eol
	c_Qry += "	                                  AND BA1_TIPREG = BCA_TIPREG "+ c_Eol
	c_Qry += "	                                  AND BA1_DATBLO = BCA_DATA "  + c_Eol
	c_Qry += "	                                  AND BA1_MOTBLO = BCA_MOTBLO "+ c_Eol
	c_Qry += "	                                  AND BA1.D_E_L_E_T_ = ' '  " + c_Eol
	c_Qry += "	                LEFT JOIN " + RETSQLNAME("BM1") + " BM1 ON BM1_FILIAL = '" + XFILIAL("BM1") + "' " + c_Eol
	c_Qry += "	                                  AND BM1_CODINT = BA1_CODINT " + c_Eol
	c_Qry += "	                                  AND BM1_CODEMP = BA1_CODEMP "+ c_Eol
	c_Qry += "	                                  AND BM1_MATRIC = BA1_MATRIC " + c_Eol
	c_Qry += "	                                  AND BM1_TIPREG = BA1_TIPREG "+ c_Eol
	c_Qry += "	                                  AND BM1_ANO||BM1_MES    >= SUBSTR(BA1_DATBLO, 1, 6) "+ c_Eol
	c_Qry += "	                                  AND BM1.D_E_L_E_T_ = ' ' "+ c_Eol

	//------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 26/07/2019
	//------------------------------------------------------------------------------------------
	//Na INTEGRAL por ser empresa o título não esta vinculado a matricula
	//------------------------------------------------------------------------------------------
	If cEmpAnt == '01' //CABERJ

		c_Qry += "	                INNER JOIN " + RETSQLNAME("SE1") + " SE1 ON E1_FILIAL = '" + XFILIAL("SE1") + "' "+ c_Eol

	Else

		c_Qry += "	                LEFT JOIN " + RETSQLNAME("SE1") + " SE1 ON E1_FILIAL = '" + xFilial("SE1") + "' "+ c_Eol

	EndIf

	c_Qry += "		                                  AND E1_PREFIXO = BM1_PREFIX " + c_Eol
	c_Qry += "	                                  AND E1_NUM     = BM1_NUMTIT "+ c_Eol
	c_Qry += "	                                  AND SE1.D_E_L_E_T_ = ' '   " + c_Eol
	c_Qry += "        							     AND ((E1_TIPO    IN ( 'DP','NCC') AND E1_SALDO = 0)  OR (E1_TIPO = 'DP' AND E1_SALDO > 0 ) ) "+ c_Eol // 28/11/2018 - MATEUS MEDEIROS - RETORNADA LINHA PARA BUSCAR SOMENTE TÍTULOS OS QUAIS NÃO FORAM BAIXADOS
	c_Qry += "	                LEFT JOIN " + RETSQLNAME("SE2") + " SE2 ON E2_FILIAL = '" + XFILIAL("SE2") + "' " + c_Eol
	c_Qry += "		                                  AND E2_PREFIXO = E1_PREFIXO " + c_Eol
	c_Qry += "		                                  AND E2_NUM     = E1_NUM "+ c_Eol
	c_Qry += "	                                  AND E2_TIPO    = 'REM' "+ c_Eol
	c_Qry += "	                                  AND SE2.D_E_L_E_T_ = ' ' "+ c_Eol
	c_Qry += "	WHERE BCA_FILIAL = '" + xfilial("BCA") + "' "+ c_Eol

	If AllTrim(cStatusAt) == "RN 412" .Or. Empty(AllTrim(cStatusAt))

		c_Qry += "	      AND BCA_MOTBLO in ('" + c_MotUsuFn + "', '" + c_MotFamFn + "')"   + c_Eol

	ElseIf AllTrim(cStatusAt) == "RN 438"

		c_Qry += "	      AND BCA_MOTBLO in ('" + c_MotPotUs + "', '" + c_MotPotFm + "')"   + c_Eol

	ElseIf AllTrim(cStatusAt) == "OBITO"

		c_Qry += "	      AND BCA_MOTBLO in ('" + c_MotObtUs + "', '" + c_MotObtFn + "')"   + c_Eol

	EndIf

	c_Qry += "	      AND BCA_XSTATU in ('3') 					" + c_Eol
	c_Qry += "        AND BCA.BCA_MATRIC = '" + c_Matric + "' 	" + c_Eol
	c_Qry += "        AND BCA.D_E_L_E_T_ = ' ' 					" + c_Eol
	c_Qry += "      	GROUP BY  BM1_CODINT, 					" + c_Eol
	c_Qry += "                    BM1_CODEMP, 					" + c_Eol
	c_Qry += "                    BM1_MATRIC, 					" + c_Eol
	c_Qry += "                    BM1_TIPREG, 					" + c_Eol
	c_Qry += "                    BM1_CODTIP, 					" + c_Eol
	c_Qry += "                    BM1_DESTIP, 					" + c_Eol
	c_Qry += "                    E1_CLIENTE, 					" + c_Eol
	c_Qry += "                    BA1_TIPUSU, 					" + c_Eol
	c_Qry += "                    BA1_NOMUSR, 					" + c_Eol
	c_Qry += "                    BA1_DIGITO, 					" + c_Eol
	c_Qry += "                    BA1_DATBLO, 					" + c_Eol
	c_Qry += "                    BCA.R_E_C_N_O_, 				" + c_Eol
	c_Qry += "     				  BA1_CODINT,    				" + c_Eol
	c_Qry += "     		          BA1_CODEMP,    				" + c_Eol
	c_Qry += "     		          BA1_MATRIC,    				" + c_Eol
	c_Qry += "     		          BA1_TIPREG,   				" + c_Eol
	c_Qry += "     		          BA1_DIGITO,   				" + c_Eol
	c_Qry += "                    RETORNA_DESC_PLANO_MS('" + iIf(cEmpAnt == '01', 'C', 'I') + "', BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG) " + c_Eol

	c_Qry += "          ORDER BY 4 "+ c_Eol

	//memowrite("c:\temp\caba347_carta.sql",c_Qry)
	If Select("QRYCARTA") <> 0

		("QRYCARTA")->(DbCloseArea())

	Endif

	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"QRYCARTA",.T.,.T.)

	c_Plano := ""

	While !QRYCARTA->( EOF() )

		n_Pos := aScan( a_TiposFat, {|x| QRYCARTA->BM1_CODTIP $ x[1] } )

		If n_Pos <> 0

			a_TiposFat[n_Pos][3]+= QRYCARTA->VALOR

		Else

			a_TiposFat[6][3]+= QRYCARTA->VALOR

		EndIf

		c_Plano := QRYCARTA->PLANO

		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek( xFilial("SA1") + QRYCARTA->E1_CLIENTE )

		//------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 26/07/2019
		//------------------------------------------------------------------------------------------
		//Na INTEGRAL por ser empresa o título não esta vinculado a matricula
		//------------------------------------------------------------------------------------------
		If cEmpAnt == '01' //CABERJ

			c_MatFil := 	QRYCARTA->BM1_CODINT + "." + QRYCARTA->BM1_CODEMP + "." +QRYCARTA->BM1_MATRIC + "." + QRYCARTA->BM1_TIPREG+ "-" + QRYCARTA->BA1_DIGITO

		Else

			c_MatFil := 	QRYCARTA->BA1_CODINT + "." + QRYCARTA->BA1_CODEMP + "." +QRYCARTA->BA1_MATRIC + "." + QRYCARTA->BA1_TIPREG+ "-" + QRYCARTA->BA1_DIGITO

		EndIf

		n_Total += QRYCARTA->VALOR

		If aScan( a_Dados, {|x| c_MatFil == x[3] } )  == 0

			aadd( a_Dados, { 'B', 	QRYCARTA->BA1_TIPUSU, ;
				c_MatFil,;
				QRYCARTA->BA1_NOMUSR,;
				c_Plano,;
				DTOC(STOD(QRYCARTA->BA1_DATBLO)),;
				SA1->A1_XBANCO,;
				SA1->A1_XAGENC,;
				SA1->A1_XCONTA + '-' + SA1->A1_XDGCON ,;
				BA1->BA1_EMAIL} )
			dbSelectArea("BCA")
			dbGoTo( QRYCARTA->RECBCAQ )
			RecLock("BCA",.F.)

			BCA_XSTATU := "5"
			BCA_XDTCAR := DATE()

			MsUnLock()

		EndIf

		QRYCARTA->( dbSkip() )

	EndDo

	a_TiposFat[7][3] := n_Total

	If aScan( a_TiposFat, {|x| "T" == x[2] } )  == 0

		dbSelectArea( "BA1" )
		dbSetOrder( 1 )
		dbSeek( xFilial("BA1") + c_Matric + 'T' )

		aadd( a_Dados, { 'N', 	BA1->BA1_TIPUSU ,;
			BA1->BA1_CODINT + "." + BA1->BA1_CODEMP + "." +BA1->BA1_MATRIC + "." + BA1->BA1_TIPREG+ "-" + BA1->BA1_DIGITO,;
			BA1->BA1_NOMUSR ,;
			c_Plano ,;
			DTOC(STOD(QRYCARTA->BA1_DATBLO)) ,;
			SA1->A1_XBANCO ,;
			SA1->A1_XAGENC ,;
			SA1->A1_XCONTA + '-' + SA1->A1_XDGCON ,;
			BA1->BA1_EMAIL } )

	EndIf

	aSort( a_Dados,,,{|x,y| x[2] > y[2]} )

	If AllTrim(cStatusAt) == "RN 412"

		u_CABR239( a_Dados, a_TiposFat )

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fImprime
imprime
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fImprime()

	Local a_Dados  := {}
	Local a_Cabec  := {}

	a_Cabec :=  { "Status",;
		"Protocolo",;
		"Matricula",;
		"Nome",;
		"Plano",; //Angelo Henrique - Data: 30/07/2019
		"Descricao Plano",; //Angelo Henrique - Data: 30/07/2019
		"Data Lançamento",;
		"Data Bloqueio",;
		"Numero",;
		"Competência",;
		"Credito",;
		"Valor Credito",; //Angelo Henrique - Data: 30/07/2019
		"Titulo CR",; //Angelo Henrique - Data: 30/07/2019
		"Valor",;
		"Saldo",;
		"Pagamento"}

	// Seleciona area tmp
	dbSelectArea( c_AliaBlq )
	(c_AliaBlq)->( dbGotop())

	While !(c_AliaBlq)->( EOF() )

		If trim((c_AliaBlq)->XOK) == "X"

			aadd( a_Dados, { (c_AliaBlq)->BCA_XSTATU	,;
				"'" + (c_AliaBlq)->PROTOCOLO	,;
				(c_AliaBlq)->Matricula  ,;
				(c_AliaBlq)->BA1_NOMUSR	,;
				"'" + (c_AliaBlq)->BA1_CODPLA	,; //Angelo Henrique - Data: 30/07/2019
				(c_AliaBlq)->BI3_DESCRI	,; //Angelo Henrique - Data: 30/07/2019
				(c_AliaBlq)->BCA_DATLAN	,;
				(c_AliaBlq)->BA1_DATBLO	,;
				(c_AliaBlq)->E1_NUM		,;
				(c_AliaBlq)->ANOMES		,;
				(c_AliaBlq)->BCA_XCREDI		,;
				(c_AliaBlq)->BSQ_VALOR		,; //Angelo Henrique - Data: 30/07/2019
				(c_AliaBlq)->TITULOCR		,; //Angelo Henrique - Data: 30/07/2019
				(c_AliaBlq)->E1_VALOR		,;
				(c_AliaBlq)->E1_SALDO		,;
				(c_AliaBlq)->E2_NUM})

		EndIf

		(c_AliaBlq)->( dbSkip() )

	EndDo

	DlgToExcel({{"ARRAY"," " ,a_Cabec,a_Dados}})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function TelaConta
tela
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function TelaConta( c_Cliente, c_Loja, c_Cpf, c_Nome, c_GetBco, c_GetAge, c_GetConta, c_GetDigi, c_RetDAge, d_VencRea  )

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	Private oDlg2
	Private oPanel1
	Private oSay1
	Private oSay2
	Private oSay3
	Private oSay4
	Private oGet1
	Private oGet2
	Private oGet3
	Private oGet4
	Private oPanel2
	Private oPanel3
	Private oSay6
	Private oSay7
	Private oSay8
	Private oSay9
	Private oGet5
	Private oGet6
	Private oGet7
	Private oGet8
	Private oGet9
	Private oPanel4
	Private oBtn1
	Private oBtn2
	Private c_RetNome  	:= c_Nome
	Private c_RetCPF	:= c_Cpf
	Private d_VencInf	:= iif(empty(d_VencRea), ctod(" / / "), d_VencRea)
	Private c_RetBco 	:= iif( empty(c_GetBco)		, space(03), c_GetBco    )
	Private c_Agencia	:= iif( empty(c_GetAge)		, space(05), c_GetAge    )
	Private c_Conta 	:= iif( empty(c_GetConta)	, space(11), c_GetConta  )
	Private c_RetDigito := iif( empty(c_GetDigi)	, space(02), c_GetDigi   )
	Private oFont01 	:= TFont():New("Courier New",,16,,.F.)

	If Empty(c_RetDAge)

		c_RetDAge := space(02)

	EndIf

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oDlg2      := MSDialog():New( 092,232,436,714,"Cadastro de dados para pagamento",,,.F.,,,,,,.T.,,,.T. )
	oPanel1    := TPanel():New( 020,004,"",oDlg2,,.F.,.F.,,,228,040,.T.,.F. )

	oSay1      := TSay():New( 005,004,{||"Cliente"    },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay2      := TSay():New( 020,004,{||"Nome"       },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
	oSay3      := TSay():New( 004,098,{||"CPF Cliente"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay4      := TSay():New( 004,056,{||"Loja"       },oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,012,008)

	oGet1      := TGet():New( 004,024,{|u| If(PCount()>0,c_Cliente:=u,c_Cliente)},oPanel1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_Cliente",,)
	oGet1:Disable()
	oGet2      := TGet():New( 020,024,{|u| If(PCount()>0,c_Nome:=u,c_Nome)},oPanel1,192,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_Nome",,)
	oGet2:Disable()
	oGet3      := TGet():New( 003,069,{|u| If(PCount()>0,c_Loja:=u,c_Loja)},oPanel1,015,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_Loja",,)
	oGet3:Disable()
	oGet4      := TGet():New( 004,132,{|u| If(PCount()>0,c_Cpf:=u,c_Cpf)},oPanel1,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_Cpf",,)
	oGet4:Disable()

	oSay11     := TSay():New( 004,004,{||"Confirme os dados bancários para criação do fornecedor"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,228,008)
	oPanel3    := TPanel():New( 064,004,"",oDlg2,,.F.,.F.,,,228,072,.T.,.F. )
	oSay5      := TSay():New( 004,004,{||"CPF"    },oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
	oSay6      := TSay():New( 020,004,{||"Nome"   },oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
	oSay7      := TSay():New( 036,004,{||"Banco"  },oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
	oSay8      := TSay():New( 036,044,{||"Agencia"},oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
	oSay9      := TSay():New( 036,129,{||"Conta"  },oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,014,008)
	oSay10     := TSay():New( 036,188,{||"Dig"    },oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay12     := TSay():New( 036,100,{||"Dig"    },oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,008,008)
	oSay13     := TSay():New( 004,140,{||"Vencimento"},oPanel3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

	oGet5      := TGet():New( 004,024,{|u| If(PCount()>0,c_RetCPF    :=u,c_RetCPF    )},oPanel3,060,008,'@R 999.999.999-99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_RetCPF",,)
	oGet12     := TGet():New( 004,172,{|u| If(PCount()>0,d_VencInf   :=u,d_VencInf   )},oPanel3,044,008,''                 ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","d_VencInf",,)
	oGet6      := TGet():New( 020,024,{|u| If(PCount()>0,c_RetNome   :=u,c_RetNome   )},oPanel3,192,008,''                 ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_RetNome",,)

	oGet7      := TGet():New( 036,024,{|u| If(PCount()>0,c_RetBco    :=u,c_RetBco    )},oPanel3,016,008,''                 ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_RetBco",,)
	oGet8      := TGet():New( 036,066,{|u| If(PCount()>0,c_Agencia   :=u,c_Agencia   )},oPanel3,028,008,''                 ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_Agencia",,)
	oGet11     := TGet():New( 036,116,{|u| If(PCount()>0,c_RetDigito :=u,c_RetDAge   )},oPanel3,012,008,''                 ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_RetDAge",,)
	oGet9      := TGet():New( 036,149,{|u| If(PCount()>0,c_Conta     :=u,c_Conta     )},oPanel3,036,008,''                 ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_Conta",,)
	oGet10     := TGet():New( 036,200,{|u| If(PCount()>0,c_RetDigito :=u,c_RetDigito )},oPanel3,016,008,''                 ,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_RetDigito",,)

	oPanel4    := TPanel():New( 140,004,"",oDlg2,,.F.,.F.,,,228,020,.T.,.F. )
	oBtn1      := TButton():New( 004,188,"&Fechar"   ,oPanel4,{|| c_Opc := "F",oDlg2:End()},037,012,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 004,148,"&Confirmar",oPanel4,{||c_Opc := "C", oDlg2:End()},037,012,,,,.T.,,"",,,,.F. )

	oDlg2 :Activate(,,,.T.)

Return  { c_Opc, c_RetCPF, c_RetNome, c_RetBco, c_Agencia, c_Conta, c_RetDigito , c_RetDAge, d_VencInf}

//-------------------------------------------------------------------
/*/{Protheus.doc} function fExcPgto
exec pagt
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function fExcPgto( c_Cliente, c_Prefix, c_Ncc )

	Local c_MatFil := ""
	Local l_Exclui := .F.

	// Seleciona area tmp
	dbSelectArea( c_AliaBlq )
	(c_AliaBlq)->( dbGotop())

	While !(c_AliaBlq)->( EOF() )

		If trim((c_AliaBlq)->XOK) == "X" .AND. ALLTRIM((c_AliaBlq)->BCA_XSTATU) == "AGUARDANDO CARTA"

			dbSelectArea("BCA")
			dbGoTo(val((c_AliaBlq)->RECBCA))

			dbSelectArea("BSQ")
			dbSetOrder(1)
			If dbSeek( xFilial("BSQ") + BCA->BCA_XCREDI ) .AND. BSQ->BSQ_TIPTIT == 'NCC'

				If !(BSQ->BSQ_NUMTIT $ c_MatFil)

					l_Exclui := fExclui( BSQ->BSQ_PREFIX, BSQ->BSQ_NUMTIT, val((c_AliaBlq)->RECBCA) )
					c_MatFil += BSQ->BSQ_NUMTIT + '||'

				EndIf

				If l_Exclui

					dbSelectArea("BCA")
					dbGoTo( val((c_AliaBlq)->RECBCA) )

					BCA->(Reclock("BCA",.F.))

					BCA->BCA_XSTATU	:= "4"

					BCA->(MsUnlock())

				EndIf

			EndIf

		ElseIf trim((c_AliaBlq)->XOK) == "X" .AND. ALLTRIM((c_AliaBlq)->BCA_XSTATU) == "AGUARDANDO PGTO"

			dbSelectArea("BCA")
			dbGoTo( val((c_AliaBlq)->RECBCA) )

			DbSelectArea("BSQ")
			DbSetOrder(1) //BSQ_FILIAL+BSQ_CODSEQ+BSQ_USUARI+BSQ_ANO+BSQ_MES
			If DbSeek(xFilial("BSQ")+ BCA->BCA_XCREDI)

				If Empty(BSQ->BSQ_NUMCOB)

					BCA->(Reclock("BCA",.F.))
					BCA->BCA_XSTATU	:= "2"
					BCA->(MsUnlock())

				Else

					Aviso("Atenção","Lançamento: " + BCA->BCA_XCREDI + " ainda vinculado a um titulo",{"OK"})

				EndIf

			EndIf

		EndIf

		(c_AliaBlq)->( dbSkip() )

	EndDo

	fPegaBloqs( "C" )

Return

Static Function fExclui( c_Prefix, c_Ncc , n_RecBCA)

	Local aDadSe2		:= {}

	Private lMsHelpAuto	:= .T.
	Private lMsErroAuto	:= .F.
	Private aRotina		:= {{"","",0,1},{"","",0,2},{"","",0,3},{"","",0,4},{"","Fa050Delet",0,5}}
	Private cCadastro	:= ""
	Private lAltera		:= .F.
	Private lF050Auto	:= .T.
	Private nRecno		:= 0
	Private lRet		:= .F.

	Private c_CPF 	    := ""
	Private c_Nome 	    := ""
	Private c_Banco 	:= ""
	Private c_Agencia 	:= ""
	Private c_Conta 	:= ""
	Private c_Digito    := ""
	Private c_DigAge    := ""

	Private l_Ok		:= .F.

	SA1->(DbSetOrder(1))
	SA2->(DbSetOrder(3))
	SE1->(DbSetOrder(1))
	SE2->(DbSetOrder(1))
	B44->(DbSetOrder(3))

	Begin Transaction

		nRegs := 0

		dbSelectArea("SE1")
		dbSetOrder(1)
		If !dbSeek( xFilial("SE1") +  c_Prefix + c_Ncc )

			Alert("Não tem NCC")
			Return

		EndIf

		dbSelectArea("SE2")
		dbSetOrder(1)
		iF dbSeek( xFilial("SE2") + "DEV"+ SE1->E1_NUM )

			cCusto := "998"
			cNatPln = '41300'

			aDadSe2 := {{"E2_PREFIXO"  ,"DEV" 			,.F.},;
				{"E2_NUM"      ,SE1->E1_NUM     ,.F.},;
				{"E2_PARCELA"  ,SE1->E1_PARCELA ,.F.},;
				{"E2_TIPO"     ,'REM'           ,.F.},;
				{"E2_FORNECE"  ,SE2->E2_FORNECE ,.F.},;
				{"E2_LOJA"     ,SE2->E2_LOJA    ,.F.}}

			lMsErroAuto := .F.

			MsExecAuto({ |x,y,z| FINA050(x,y,z)},aDadSe2,,5)

			If lMsErroAuto

				DisarmTransaction()
				MostraErro()

			Else

				ALERT("Pagamento excluido")
				l_Ok := .T.

			Endif

		EndIf

	End Transaction

Return l_Ok


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³ Marcela Coimbra       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³  Rotina para gerenciamento financeiro do bloqueios         ³±±
±±³          ³  solicitados pela RN 412                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´*/

Static Function fRelatFim()

	Local oReport	:= Nil

	// Seleciona area tmp
	dbSelectArea( c_AliaBlq )
	(c_AliaBlq)->( dbGotop())

	oReport := u_fRelatFM2()
	oReport:PrintDialog()

	dbSelectArea( c_AliaBlq )
	(c_AliaBlq)->( dbGotop())

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function fRelatFM2
relatorio
@author  marcela
@since   00/00/00
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
User Function fRelatFM2()

	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Private _cPerg		:= "CABA347"

	oReport := TReport():New("CABA347","RELACAO DE TITULOS PARA PAGAMENTO - RESSARCIMENTO "	,_cPerg,{|oReport| fRelatFM3(oReport)},"RELACAO DE TITULOS PARA PAGAMENTO - RESSARCIMENTO ")

	oReport:ParamReadOnly(.T.)
	oReport:HideParamPage(.F.)

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(10)

	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"RELACAO DE TITULOS PARA PAGAMENTO","SE2, SA2, BA1, BI3")

	TRCell():New(oSection1,"TITULO" ,"SE2")
	oSection1:Cell("TITULO"):SetAutoSize(.F.)
	oSection1:Cell("TITULO"):SetSize(TAMSX3("E2_FILIAL")[1] + TAMSX3("E2_PREFIXO")[1] + TAMSX3("E2_NUM")[1] + 10)

	TRCell():New(oSection1,"BENEFICIARIO" ,"BA1")
	oSection1:Cell("BENEFICIARIO"):SetAutoSize(.F.)
	oSection1:Cell("BENEFICIARIO"):SetSize(TAMSX3("BA1_NOMUSR")[1] - 5)

	TRCell():New(oSection1,"BLOQUEIO" ,"BA1")
	oSection1:Cell("BLOQUEIO"):SetAutoSize(.F.)
	oSection1:Cell("BLOQUEIO"):SetSize(12)

	TRCell():New(oSection1,"COMPETENCIA" 		,"SE2")
	oSection1:Cell("COMPETENCIA"):SetAutoSize(.F.)
	oSection1:Cell("COMPETENCIA"):SetSize(12)

	TRCell():New(oSection1,"PLANO" 		,"BI3")
	oSection1:Cell("PLANO"):SetAutoSize(.F.)
	oSection1:Cell("PLANO"):SetSize(TAMSX3("BI3_NREDUZ")[1])

	TRCell():New(oSection1,"TITULAR DA CONTA" 		,"SA2")
	oSection1:Cell("TITULAR DA CONTA"):SetAutoSize(.F.)
	oSection1:Cell("TITULAR DA CONTA"):SetSize(TAMSX3("A2_NOME")[1] - 5 )

	TRCell():New(oSection1,"DATA P PAG" 		,"SE2")
	oSection1:Cell("DATA P PAG"):SetAutoSize(.F.)
	oSection1:Cell("DATA P PAG"):SetSize(12)

	TRCell():New(oSection1,"BANCO" 		,"SA2")
	oSection1:Cell("BANCO"):SetAutoSize(.F.)
	oSection1:Cell("BANCO"):SetSize(TAMSX3("A2_BANCO")[1])

	TRCell():New(oSection1,"AGENCIA" 		,"SA2")
	oSection1:Cell("AGENCIA"):SetAutoSize(.F.)
	oSection1:Cell("AGENCIA"):SetSize(TAMSX3("A2_AGENCIA")[1])

	TRCell():New(oSection1,"CONTA" 		,"SA2")
	oSection1:Cell("CONTA"):SetAutoSize(.F.)
	oSection1:Cell("CONTA"):SetSize(TAMSX3("A2_NUMCON")[1] + TAMSX3("A2_YDAC")[1])

	TRCell():New(oSection1,"CPF FORNECEDOR" 		,"SA2")
	oSection1:Cell("CPF FORNECEDOR"):SetAutoSize(.F.)
	oSection1:Cell("CPF FORNECEDOR"):SetSize(20)

	TRCell():New(oSection1,"VALOR" 		,"SE2",,"@E 999,999,999,999.99")
	oSection1:Cell("VALOR"):SetAutoSize(.F.)
	oSection1:Cell("VALOR"):SetSize(TAMSX3("E2_VALOR")[1])

	TRCell():New(oSection1,"FORNECEDOR" 		,"SE2")
	oSection1:Cell("FORNECEDOR"):SetAutoSize(.F.)
	oSection1:Cell("FORNECEDOR"):SetSize(TAMSX3("E2_NOMFOR")[1])

	//-----------------------------------------------------------------------------------------------
	// Rotina para totalizar os campos.
	//-----------------------------------------------------------------------------------------------
	oBreak := Nil
	TRFunction():New(oSection1:Cell("VALOR"),"VALOR" ,"SUM",oBreak,"Total Geral ",PesqPict("SE2", "E2_VALOR"),,.T.,.F.) //Função de totalizador dentro do oBreak

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fRelatFM3  ºAutor  ³Angelo Henrique     º Data ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para montar a query e trazer as informações no       º±±
±±º          ³relatório.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fRelatFM3(oReport,_cAlias1)

	Local _aArea 		:= GetArea()
	Local _aArSE2 		:= SE2->(GetArea())
	Local _aArSA2 		:= SA2->(GetArea())
	//Local _dDatPg		:= CTOD(" / / ")
	Local _cTitPag 		:= ""

	Private oSection1 	:= oReport:Section(1)

	oSection1:Init()
	oSection1:SetHeaderSection(.T.)

	While !(c_AliaBlq)->( EOF() )

		If trim((c_AliaBlq)->XOK) == "X" .And. !(Empty(AllTrim((c_AliaBlq)->PAGAMENTO)))

			If (c_AliaBlq)->PAGAMENTO != _cTitPag

				_cTitPag := (c_AliaBlq)->PAGAMENTO

				oReport:IncMeter()

				If oReport:Cancel()
					Exit
				EndIf

				DbSelectArea("SE2")
				DbSetOrder(1) //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
				If DbSeek(AllTrim((c_AliaBlq)->PAGAMENTO))

					DbSelectArea("SA2")
					DbSetOrder(1) //A2_FILIAL+A2_COD+A2_LOJA
					If DbSeek(xFilial("SA2") + SE2->E2_FORNECE + SE2->E2_LOJA)


						oSection1:Cell("TITULO"				):SetValue( (c_AliaBlq)->PAGAMENTO 	)
						oSection1:Cell("BENEFICIARIO"		):SetValue( (c_AliaBlq)->BA1_NOMUSR )
						oSection1:Cell("BLOQUEIO" 			):SetValue( (c_AliaBlq)->BA1_DATBLO )
						oSection1:Cell("COMPETENCIA"		):SetValue( (c_AliaBlq)->ANOMES		)
						oSection1:Cell("PLANO"				):SetValue( (c_AliaBlq)->BI3_DESCRI )
						oSection1:Cell("TITULAR DA CONTA"	):SetValue( SA2->A2_NOME 			)

						//-------------------------------------------------------------
						//Regra para calcular a data de pagamento (Prévia)
						//-------------------------------------------------------------

						/* MMT
						Alterado para receber data via digitação
						_dDatPg := DaySum(DDATABASE,10)

						While !(cValToChar(Dow(_dDatPg)) $ "3|5")

							_dDatPg := DaySum(_dDatPg,1)

						EndDo
						*/

						oSection1:Cell("DATA P PAG"			):SetValue( DTOC(_dDatPg) 			)
						oSection1:Cell("BANCO"				):SetValue( SA2->A2_BANCO 			)
						oSection1:Cell("AGENCIA"			):SetValue( SA2->A2_AGENCIA 		)
						oSection1:Cell("CONTA"				):SetValue( AllTrim(SA2->A2_NUMCON) + "-" + AllTrim(SA2->A2_YDAC) )
						oSection1:Cell("CPF FORNECEDOR"		):SetValue( TRANSFORM(AllTrim(SA2->A2_CGC),"@R 999.999.999-99") )
						oSection1:Cell("VALOR"				):SetValue( SE2->E2_VALOR			)
						oSection1:Cell("FORNECEDOR"			):SetValue( SA2->A2_COD 			)

						oSection1:PrintLine()

					Else

						Aviso("Atenção","Não foi encontrado registro para o fornecedor do título: " + (c_AliaBlq)->PAGAMENTO , {"OK"} )

					EndIf

				Else

					Aviso("Atenção","Não foi encontrado o título: " + (c_AliaBlq)->PAGAMENTO , {"OK"} )

				EndIf

			EndIf

		EndIf

		(c_AliaBlq)->( dbSkip() )

	EndDo

	oSection1:Finish()

	RestArea(_aArSA2 )
	RestArea(_aArSE2 )
	RestArea(_aArea	 )

Return(.T.)
