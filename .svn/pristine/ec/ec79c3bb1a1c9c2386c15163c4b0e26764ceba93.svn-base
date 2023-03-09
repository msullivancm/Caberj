#include "PLSA090.ch"
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "UTILIDADES.CH"
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO2     ºAutor  ³Marcela Coimbra     º Data ³  16/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina generica para geração de pedido e Nota fiscal       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function caba134()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta matriz com as opcoes do browse...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private aRotina	:=	{	{ "Pesquisar"				, 'AxPesqui'		, 0, K_Pesquisar	},;
		{ "&Visualizar"				, 'AxVisual'		, 0, K_Visualizar	},;
		{ "Incluir"	                , 'u_caba134I()'	, 0, K_Incluir		},;
		{ "Manutenção"				, 'u_CABA134M()'	, 0, K_Excluir		},;
		{ "Excluir"     			, 'u_caba134E()', 0, K_Incluir		}}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulo e variavies para indicar o status do arquivo                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	
	Private aCdCores	:= { 	{ 'BR_VERDE'    ,'Arquivo Gerado' },;
		{ 'BR_AZUL'     ,'Arquivo Exportado e Importado' } }
	
	Private aCores		:= {	{'PCV_TIPO = "1"', aCdCores[1,1]},;
		{'PCV_TIPO = "2"', aCdCores[2,1]}	}
	Private cAlias 		:= "PCV"
	Private cNomeProg   := "CABA134"
	Private cTitulo     := "Lote de NF Caberj"
	
	Private c_Aliastmp 	:= GetNextAlias()
	
	Private c_EOL    	:= "CHR(13)+CHR(10)"
	Private c_Mesnagem  := ""
	Private l_Criou 	:= .F.
	Private n_Tot 		:= 0
	
	
	If Empty(c_EOL)
		c_EOL := CHR(13)+CHR(10)
	Else
		c_EOL := Trim(c_EOL)
		c_EOL := &c_EOL
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Starta mBrowse...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PCV->(DBSetOrder(1))
	PCV->(mBrowse(006,001,022,075,"PCV" , , , , , Nil    , aCores, , , ,nil, .T.))
	PCV->(DbClearFilter())
	
	
Return

User Function caba134I()
	
	Local cPerg := "CABAZ134"
	
	VerPar( cPerg )
	
	If Pergunte(cPerg)
		
		c_Ano   := mv_par01
		c_Mes   := mv_par02
		n_Grupo := mv_par03
		
	Else
		
		Alert("Inclusão cancelada")
		
		Return
		
	EndIf
	
	Processa({||ProcesInc()}, "Gerando notas", "", .T.)
	
	
Return


Static Function ProcesInc()
	
	Local c_Qry 		:= ""
	Local a_Pedido 		:= {}
	Local c_Critica 	:= ""
	Local nRegs			:= 0 
	
	
	c_Qry := " SELECT  "+ c_EOL
	c_Qry += " E1_NUM , "+ c_EOL
	c_Qry += " E1_PREFIXO , "+ c_EOL
	c_Qry += " E1_CODEMP , "+ c_EOL
	c_Qry += " E1_SUBCON , "+ c_EOL
	c_Qry += " F2_DOC , "+ c_EOL
	c_Qry += " F2_EMINFE , "+ c_EOL
	c_Qry += " F2_HORNFE , "+ c_EOL
	c_Qry += " F2_CODNFE , "+ c_EOL
	c_Qry += " A1_EMAIL , "+ c_EOL
	c_Qry += " E1_CLIENTE  , "+ c_EOL
	c_Qry += " E1_LOJA  , "+ c_EOL
	c_Qry += " SUM (DECODE ( BM1_TIPO , 1 ,BM1_VALOR, (BM1_VALOR*-1))) VALOR "+ c_EOL
	
	
	c_Qry += " FROM BM1010 BM1 INNER JOIN SE1010 SE1 ON E1_FILIAL = '01' "+ c_EOL
	c_Qry += "                AND E1_PREFIXO = 'PLS' "+ c_EOL
	c_Qry += "                AND E1_NUM  = BM1_NUMTIT "+ c_EOL
	c_Qry += "                AND E1_TIPO = 'DP' "+ c_EOL
	c_Qry += "                AND E1_XDOCNF = ' ' "+ c_EOL
	c_Qry += "                AND se1.d_e_l_e_t_ = ' ' "+ c_EOL
	
	/*
	c_Qry += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' "+ c_EOL
	c_Qry += "                AND BA1_CODINT = BM1_CODINT "+ c_EOL
	c_Qry += "                AND BA1_CODEMP = BM1_CODEMP "+ c_EOL
	c_Qry += "                AND BA1_MATRIC = BM1_MATRIC "+ c_EOL
	c_Qry += "                AND BA1_TIPREG = BM1_TIPREG "+ c_EOL
	c_Qry += "                AND BM1.d_e_l_e_t_ = ' ' "+ c_EOL
	
	
	c_Qry += "  INNER JOIN BA3010 BA3 ON BA3_FILIAL = ' ' "+ c_EOL
	c_Qry += "                AND BA3_CODINT = BA1_CODINT "+ c_EOL
	c_Qry += "                AND BA3_CODEMP = BA1_CODEMP "+ c_EOL
	c_Qry += "                AND BA3_MATRIC = BA1_MATRIC "+ c_EOL
	c_Qry += "                AND BA3.d_e_l_e_t_ = ' ' "+ c_EOL
	*/
	
	c_Qry += "  INNER JOIN SA1010 SA1 ON A1_FILIAL = ' ' "+ c_EOL
	c_Qry += "                AND A1_COD = E1_CLIENTE "+ c_EOL
	//	c_Qry += "                AND A1_EMAIL = ' ' "+ c_EOL
	
	
	c_Qry += "  LEFT JOIN SF2010 SF2 ON F2_FILIAL = '01' "+ c_EOL
	c_Qry += "                AND F2_DOC = E1_XDOCNF "+ c_EOL
	c_Qry += "                AND F2_SERIE = E1_XSERNF "+ c_EOL
	
	c_Qry += " WHERE BM1_FILIAL = ' ' "+ c_EOL
	c_Qry += "       AND BM1_ANO = '" + c_Ano + "' "+ c_EOL
	c_Qry += "       AND BM1_MES = '" + c_Mes + "' "+ c_EOL
	c_Qry += "       AND F2_DOC IS NULL  "+ c_EOL
	//	c_Qry += "       AND ROWNUM <= 5 "+ c_EOL
	//	c_Qry += "       AND e1_num = '003175933' "+ c_EOL
	c_Qry += "       AND BM1_CODEMP IN ('0001', '0002', '0005') "+ c_EOL
	c_Qry += "       AND BM1.d_e_l_e_t_ = ' ' "     + c_EOL
	
	c_Qry += " GROUP BY  "+ c_EOL
	c_Qry += "         E1_NUM , "+ c_EOL
	c_Qry += "         E1_PREFIXO , "+ c_EOL
	c_Qry += "         E1_CODEMP , "+ c_EOL
	c_Qry += "         E1_SUBCON , "+ c_EOL
	c_Qry += "         F2_DOC , "+ c_EOL
	c_Qry += "         F2_EMINFE , "+ c_EOL
	c_Qry += "         F2_HORNFE , "+ c_EOL
	c_Qry += "         F2_CODNFE , "+ c_EOL
	c_Qry += "         A1_EMAIL , "+ c_EOL
	c_Qry += "         E1_CLIENTE  , "+ c_EOL
	c_Qry += "         E1_LOJA   "+ c_EOL
	
	MemoWrit("C:\Temp\CABA134.txt",c_Qry)
	
	
	for i:=1 to 5
		IncProc('Selecionando cobranças ...')
	next
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),c_Aliastmp,.T.,.T.)
	
	nLimita := 0
	
	(c_Aliastmp)->(dbEval({||nRegs++}))
	ProcRegua(nRegs)
	(c_Aliastmp)->( DBGOTOP() )
	
	if !(c_Aliastmp)->( EOF() )
		While !(c_Aliastmp)->( EOF() )
			
			a_Pedido:=  {{ "SERMED", 1, (c_Aliastmp)->VALOR } }
			IncProc()
			IncProc('Gerando nota PLS ' + (c_Aliastmp)->E1_NUM )
			
			
			//	If Empty( (c_Aliastmp)->A1_EMAIL )
			nLimita++
			
			fCriaPedido( 	(c_Aliastmp)->E1_CODEMP	,;
				'01'/*FILIAL*/			,;
				(c_Aliastmp)->E1_CLIENTE,;
				(c_Aliastmp)->E1_LOJA	,;
				a_Pedido				,;
				(c_Aliastmp)->E1_PREFIXO,;
				(c_Aliastmp)->E1_NUM	,;
				(c_Aliastmp)->E1_CODEMP,;
				(c_Aliastmp)->E1_SUBCON )
			
			//Else
			
			//	c_Critica +=    "EMAIL EM BRANCO. CLIENTE: " + (c_Aliastmp)->E1_CLIENTE + ", TÍTULO:  " + (c_Aliastmp)->E1_NUM
			
			
			//EndIf
			
			
			(c_Aliastmp)->( dbSkip() )
			
		EndDo
	Else 
		Alert("Não há notas a serem geradas!!!")
	Endif 
	
	If l_Criou
		
		fCriaPCV(c_Ano, c_Mes)
		Alert(n_Tot)
		
	EndIf
	
	(c_Aliastmp)->( dbCloseArea() )
	
	//alert(c_Critica)
	
Return

User Function CABA134M()
	
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oDlg1","oPanel1","oSay1","oSay2","oSay3","oSay4","oSay5","oGet1","oGet2","oGet3","oGet4","oGet5")
	SetPrvt("oSay6","oSay7","oSay8","oSay9","oSay10","oGet6","oGet7","oGet8","oGet9","oGet10","oBtn1","oPanel3")
	SetPrvt("oBtn2","oBtn3")
	
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oDlg1      := MSDialog():New( 092,232,786,1057,"oDlg1",,,.F.,,,,,,.T.,,,.T. )
	oPanel1    := TPanel():New( 004,004,"",oDlg1,,.F.,.F.,,,392,036,.T.,.F. )
	oSay1      := TSay():New( 008,008,{||"Ano:"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
	oSay2      := TSay():New( 008,048,{||"Mês:"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
	oSay3      := TSay():New( 008,096,{||"Status:"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay4      := TSay():New( 004,324,{||"Data Geração:"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
	oSay5      := TSay():New( 008,164,{||"Grupo:"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGet1      := TGet():New( 016,008,,oPanel1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet2      := TGet():New( 016,048,,oPanel1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet3      := TGet():New( 016,096,,oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet4      := TGet():New( 016,324,,oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet5      := TGet():New( 016,164,,oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oPanel2    := TPanel():New( 044,004,"",oDlg1,,.F.,.F.,,,392,040,.T.,.F. )
	oSay6      := TSay():New( 012,008,{||"Empresa:"},oPanel2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,010)
	oSay7      := TSay():New( 012,048,{||"Matricula:"},oPanel2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay8      := TSay():New( 012,116,{||"Grupo:"},oPanel2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay9      := TSay():New( 012,160,{||"Título:"},oPanel2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay10     := TSay():New( 012,216,{||"Emissão:"},oPanel2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGet6      := TGet():New( 020,008,,oPanel2,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet7      := TGet():New( 020,048,,oPanel2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet8      := TGet():New( 020,116,,oPanel2,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet9      := TGet():New( 020,160,,oPanel2,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet10     := TGet():New( 020,216,,oPanel2,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oBtn1      := TButton():New( 020,340,"Filtrar",oPanel2,,037,012,,,,.T.,,"",,,,.F. )
	oPanel3    := TPanel():New( 088,004,"oPanel3",oDlg1,,.F.,.F.,,,392,188,.T.,.F. )
	oPanel4    := TPanel():New( 280,004,"",oDlg1,,.F.,.F.,,,392,020,.T.,.F. )
	oBtn2      := TButton():New( 004,348,"Fechar",oPanel4,,037,012,,,,.T.,,"",,,,.F. )
	oBtn3      := TButton():New( 004,004,"Excluir",oPanel4,{ || oBtn3bAction },037,012,,,,.T.,,"",,,,.F. )
	
	oDlg1:Activate(,,,.T.)
	
Return


Static Function fStruct()
	
	Aadd(a_Campos,{" ",cCampoOk,"C",1,0,})
	Aadd(a_Struct,{cCampoOk,"C",1,0})
	
	Aadd(a_Campos,{"Mun","MUN","C",3,0,""})
	Aadd(a_Struct,{"MUN","C",3,0})
	
	Aadd(a_Campos,{"Prefixo","E1_PREFIXO","C",3,0,""})
	Aadd(a_Struct,{"E1_PREFIXO","C",3,0})
	
	Aadd(a_Campos,{"Numero","E1_NUM","C",9,0,""})
	Aadd(a_Struct,{"E1_NUM","C",9,0})
	
	Aadd(a_Campos,{"Valor","E1_VALOR","C",10,2,""})
	Aadd(a_Struct,{"E1_VALOR","N",10,2})
	
	Aadd(a_Campos,{"Empresa","E1_CODEMP","C",4,0,""})
	Aadd(a_Struct,{"E1_CODEMP","C",3,0})
	
	Aadd(a_Campos,{"Emissao","E1_EMISSAO","D",8,0,""})
	Aadd(a_Struct,{"E1_EMISSAO","D",8,0})
	
	
	Aadd(a_Campos,{"Posicao","POSIC","C",30,0,""})
	Aadd(a_Struct,{"POSIC","C",10,0})
	
	
	Aadd(a_Campos,{"Cliente","E1_CLIENTE","C",6,0,""})
	Aadd(a_Struct,{"E1_CLIENTE","C",6,0})
	
	Aadd(a_Campos,{"Nome","E1_NOMCLI","C",20,0,""})
	Aadd(a_Struct,{"E1_NOMCLI","C",20,0})
	
	Aadd(a_Campos,{"Emissao","E1_VENCREA","C",50,0,""})
	Aadd(a_Struct,{"E1_VENCREA","D",8,0})
	
	Aadd(a_Campos,{"Bordero","E1_NUMBOR","C",6,0,""})
	Aadd(a_Struct,{"E1_NUMBOR","C",6,0})
	
	Aadd(a_Campos,{"NFS Serie","E1_XSERNF ","C",3,0,""})
	Aadd(a_Struct,{"E1_XSERNF ","C",3,0})
	
	Aadd(a_Campos,{"NFS DOC","E1_XDOCNF  ","C",9,0,""})
	Aadd(a_Struct,{"E1_XDOCNF  ","C",9,0})
	
	If Select(c_AliasTmp) <> 0
		(c_AliasTmp)->(DbCloseArea())
	Endif
	If TcCanOpen(c_AliasTmp)
		TcDelFile(c_AliasTmp)
	Endif
	//cColunas += "D_E_L_E_T_ ,R_E_C_N_O_"
	DbCreate(c_AliasTmp,a_Struct,"TopConn")
	If Select(c_AliasTmp) <> 0
		(c_AliasTmp)->(DbCloseArea())
	Endif
	DbUseArea(.T.,"TopConn",c_AliasTmp,c_AliasTmp,.T.,.F.)
	(c_AliasTmp)->(DbCreateIndex(cAliasInd , cChave, {|| &cChave}, .F. ))
	(c_AliasTmp)->(DbCommit())
	(c_AliasTmp)->(DbClearInd())
	(c_AliasTmp)->(DbSetIndex(cAliasInd ))
	
	
Return
Static Function fCriaPedido(c_Empresa, c_Filial, c_Cliente,  c_Loja, a_DPedido, c_PreTit, c_NumTit, c_CodEmp, c_Subcon)
	
	Local aArea		:= GetArea()
	Local aAreaSF2	:= SF2->(GetArea())
	Local aAreaSD2	:= SD2->(GetArea())
	Local l_Ret 	:= .F.
	Local c_Num		:= ""
	Local a_Cabec   := {}
	Local a_Detalhe := {}
	Local a_ItensT 	:= {}
	Local n_Count	:= 0
	Local c_Serie   := "UNI"
	Local n_Total := 0
	Local c_Qry		:= ""
	Local cAliasTmp2 := GetNextAlias() 
	
	cFilAnt := c_Filial
	//Fabio Bianchini - 27/10/2020
	//Adaptação em Query porque o GetSXENum está pegando sequencia errada sabe-se lá de onde, Nem SX5, nem SF2, nem SD9
	
	c_Num		:= GetSXENum("SF2","F2_DOC")
	
	c_Qry := " SELECT LPAD(MAX(F2_DOC)+1,9,'0') F2_MAX "+ c_EOL
	c_Qry += "   FROM " + RetSqlName("SF2")         + c_EOL
	c_Qry += "  WHERE F2_FILIAL = '" + xFilial("SF2") + "'" + c_EOL
	c_Qry += "    AND F2_SERIE = '" + c_Serie + "'" + c_EOL
	c_Qry += "    AND D_E_L_E_T_ = ' ' "+ c_EOL

	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),cAliastmp2,.T.,.T.)

	If Val(c_Num) < Val(Trim((cAliasTmp2)->F2_MAX))
		c_Num := Trim((cAliasTmp2)->F2_MAX)
	Endif

	(cAliasTmp2)->(DbCloseArea())

	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+c_Cliente+c_Loja)
	
	**'Cria Detalhe'**
	
	For n_Count := 1 to Len(a_DPedido)
		
		aadd(a_Detalhe,{"D2_ITEM" ,"01",Nil})
		aadd(a_Detalhe,{"D2_COD" ,a_DPedido[n_Count][1],Nil})
		aadd(a_Detalhe,{"D2_QUANT",a_DPedido[n_Count][2],Nil})
		aadd(a_Detalhe,{"D2_PRCVEN",a_DPedido[n_Count][3] ,Nil})
		aadd(a_Detalhe,{"D2_TOTAL",a_DPedido[n_Count][2] * a_DPedido[n_Count][3],Nil})
		aadd(a_Detalhe,{"D2_TES",iif(trim(c_Filial) == '01', "600", "601"),Nil})
		aadd(a_Detalhe,{"D2_CF","5949",Nil})
		aadd(a_Detalhe,{"D2_XPREPLS",c_PreTit,Nil})
		aadd(a_Detalhe,{"D2_XTITPLS",c_NumTit,Nil})
		
		aadd(a_ItensT,a_Detalhe)
		
		n_Total += a_DPedido[n_Count][2] * a_DPedido[n_Count][3]
		
	Next
	
	**'Cria Cabeçalho'**
	
	aadd(a_Cabec,{"F2_TIPO"   ,"N"})
	aadd(a_Cabec,{"F2_FORMUL" ,"N"})
	aadd(a_Cabec,{"F2_DOC"    ,c_Num})
	aadd(a_Cabec,{"F2_SERIE" ,"UNI"})
	aadd(a_Cabec,{"F2_EMISSAO",dDataBase})
	aadd(a_Cabec,{"F2_CLIENTE",SA1->A1_COD})
	aadd(a_Cabec,{"F2_TIPOCLI",SA1->A1_PESSOA})
	aadd(a_Cabec,{"F2_LOJA"   ,SA1->A1_LOJA})
	aadd(a_Cabec,{"F2_ESPECIE","NF"})
	aadd(a_Cabec,{"F2_COND","001"})
	aadd(a_Cabec,{"F2_DESCONT",0})
	aadd(a_Cabec,{"F2_VALBRUT",n_Total })
	aadd(a_Cabec,{"F2_VALFAT",n_Total })
	aadd(a_Cabec,{"F2_FRETE",0})
	aadd(a_Cabec,{"F2_SEGURO",0})
	aadd(a_Cabec,{"F2_DESPESA",0})
	aadd(a_Cabec,{"F2_PREFIXO","1"})
	aadd(a_Cabec,{"F2_HORA",substr(TIME(),1,5)})
	
	lMsErroAuto := .F.
	
	MSExecAuto({|x,y,z| mata920(x,y,z)},a_Cabec,a_ItensT,3) //Inclusao
	
	If lMsErroAuto // se ocorrer um erro, avisa e mostra o erro na tela
		
		//	Alert("Erro na inclusao!")
		// MostraErro()
		
	Else
		
		ConfirmSX8()
		AtuF1(c_PreTit, c_NumTit, "UNI", c_Num, 'G', c_Filial )
		AtuF2( c_Filial, "UNI", c_Num, c_CodEmp, c_PreTit, c_NumTit, c_Subcon , n_Total)
		
		//AtuF3(c_Num, "UNI", SA1->A1_COD, SA1->A1_LOJA, n_Total  )
		
		l_Criou := .T.
		n_Tot++
		
	EndIf

	SA1->(DbCloseArea())
	RestArea(aAreaSF2)
	RestArea(aAreaSD2)
	RestAreA(aArea)
	
Return l_Ret

Static Function AtuF3(c_Nota, c_Serie, c_Cliente,c_Loja , n_ValDed)
	
	dbSelectArea("SF3")
	dbSetOrder(4)
	If dbSeek(xFilial("SF3") + c_Cliente + c_Loja + c_Nota + c_Serie )
		
		RecLock("SF3",.F.)
		
		SF3->F3_ISSSUB  := n_ValDed - SF3->F3_BASEICM
		
		SF3->( MsUnLock() )
		
	EndIf
	
	SF3->(DbCloseArea())
Return


Static Function VerPar( cPerg )
	
	
	PutSx1(cPerg,"01",OemToAnsi("Ano	") 		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"02",OemToAnsi("Mes    ") 		,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
	//PutSx1(cPerg,"03",OemToAnsi("Tipo   ")    	,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Ambos","","","","","Boleto","","","","Previ","","","","Sisdeb","","","")
	
Return

Static Function AtuF1( c_PreTit, c_NumTit, c_Serie, c_Doc, c_St, c_Filial )
	
	dbSelectArea("SE1")
	dbSetOrder(1)
	If dbSeek('01' + c_PreTit + c_NumTit )
		
		dbSelectArea("SE1")
		RecLock("SE1",.F.)
		
		SE1->E1_XSTDOC  := c_St
		SE1->E1_XSERNF  := c_Serie
		SE1->E1_XDOCNF  := IIF(c_St <> 'C', c_Doc    , "")  //SE1->E1_XDOCNF
		//SE1->E1_XFILNF  := IIF(c_St <> 'C', c_Filial , "")   //SE1->E1_XFILNF
		
		SE1->( MsUnLock() )
		
	EndIf
	SE1->( DbCloseArea() )
Return

Static Function AtuF2( c_Filial, c_Serie, c_Doc, c_Empresa, c_Prefix, c_NumTit, c_Subcon, n_Total )
	
	SF2->( dbCloseArea() )
	
	dbSelectArea("SF2")
	dbSetOrder(1)
	If dbSeek(trim(c_Filial) + c_Doc+ c_Serie )
		
		dbSelectArea("SF2")
		RecLock("SF2",.F.)
		
		SF2->F2_XCODEMP  := c_Empresa
		SF2->F2_XNOMEMP  := posicione("BG9", 1, XFILIAL("BG9") + '0001' + c_Empresa, "BG9_NREDUZ")
		SF2->F2_XPREPLS  := c_Prefix
		SF2->F2_XTITPLS  := c_NumTit
		SF2->F2_XSUBCON  := c_Subcon
		SF2->F2_VALBRUT  := n_Total
		SF2->F2_VALFAT   := n_Total
		
		
		SF2->( MsUnLock() )
		
	EndIf
	
Return

USer Function caba134E()
	
	Local c_Qry := ""
	Private c_AliasExc 	:= GetNextAlias()
	
	c_Qry := " SELECT R_E_C_N_O_ RECSF2 , SF2.* "
	c_Qry += " FROM " + RETSQLNAME("SF2") + " SF2 "
	c_Qry += " WHERE SF2.D_E_L_E_T_ = ' ' "
	
	MemoWrit("C:\Temp\CABA134EX.txt",c_Qry)
	
	for i:=1 to 5
		IncProc('Selecionando Notas ...')
	next
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),c_AliasExc,.T.,.T.)
	
	nLimita := 0
	
	While !(c_AliasExc)->( EOF() )
		
		dbSelectArea("SF2")
		dbGoTo( (c_AliasExc)->RECSF2 )
		
		aCabec := {}
		aItens := {}
		aadd(aCabec,{"F2_TIPO"   ,SF2->F2_TIPO})
		aadd(aCabec,{"F2_FORMUL" ,SF2->F2_FORMUL})
		aadd(aCabec,{"F2_DOC"    ,SF2->F2_DOC})
		aadd(aCabec,{"F2_SERIE"  ,SF2->F2_SERIE})
		aadd(aCabec,{"F2_EMISSAO",SF2->F2_EMISSAO})
		aadd(aCabec,{"F2_CLIENTE",SF2->F2_CLIENTE})
		
		dbSelectArea("SD2")
		//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
		dbSetOrder(3)
		dbSeek( xFilial("SD2") + SF2->( F2_DOC + F2_SERIE + F2_CLIENTE  ) )
		
		aLinha := {}
		While !SD2->( EOF() )	.AND. SD2->( D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE ) == SF2->( F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE )
			
			aadd(aLinha,{"D2_ITEM",SD2->D2_ITEM,Nil})
			aadd(aLinha,{"D2_COD",SD2->D2_COD,Nil})
			aadd(aLinha,{"D2_DOC",SD2->D2_DOC,Nil})
			aadd(aLinha,{"D2_PRCVEN",SD2->D2_PRCVEN,Nil})
			aadd(aLinha,{"D2_TOTAL",SD2->D2_TOTAL,Nil})
			
			aadd(aItens,aLinha)
			
			SD2->( dbSkip() )
			
		EndDo
		
		lMsErroAuto := .F.
		
		MATA920(aCabec,aItens,5)
		If !lMsErroAuto
			
			ConOut("Exclusao com sucesso! " + SD2->D2_DOC)
		Else
			MostraErro()
			ConOut("Erro na exclusao!")
		EndIf
		
		
		( c_AliasExc )->( dbSkip() )
		
		
	EndDo
	SD2->(DbCloseArea())
	SF2->(DbCloseArea())
	( c_AliasExc )->( dbCloseArea() )
	
Return

Static Function fCriaPCV(c_Ano, c_Mes)
	
	Local c_Qry := " "
	
	c_Qry := " SELECT MAX(PCV_SEQUEN) SEQUEN FROM PCV010 WHERE D_E_L_E_T_ = ' ' "
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,c_Qry),"FCRIAPCV",.T.,.T.)
	
	c_Sequen := soma1(FCRIAPCV->SEQUEN)
	
	RecLock("PCV",.T.)
	
	PCV->PCV_SEQUEN := c_Sequen
	PCV->PCV_ANO  	:= c_Ano
	PCV->PCV_MES  	:= c_Mes
	PCV->PCV_TIPO  	:= "1"
	
	SF2->( MsUnLock() )
	
	FCRIAPCV->(DbCloseArea())
Return