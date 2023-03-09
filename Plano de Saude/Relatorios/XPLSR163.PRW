
#include "PLSR163.CH"
#IFDEF TOP
#INCLUDE "TOPCONN.CH"
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSR163 ³ Autor ³ Natie Sugahara         ³ Data ³ 06/07/03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Consultas Desmarcadas no Periodo                           ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR163()                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³          |      |             |                                       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                
User Function XPLSR163()
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Define variaveis padroes para todos os relatorios...                     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
PRIVATE wnRel         
PRIVATE cNomeProg   := "XPLSR163"
PRIVATE nLimite     := 132
PRIVATE nTamanho    
PRIVATE Titulo		:= oEmToAnsi(STR0001)				//-- Marcacao de  consultas por Operadora 
PRIVATE cDesc1      := oEmToAnsi(STR0001)
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BBD"
PRIVATE cPerg       := "PLR163"
PRIVATE Li         	:= 0
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aReturn     := { oEmToAnsi(STR0002), 1,oEmToAnsi(STR0003) , 1, 1, 1, "",1 }
PRIVATE aOrd		:= { STR0004}														//--Unidade de Atendimento
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCabec
PRIVATE Colunas		:= 80
PRIVATE AT_PRG  	:= "XPLSR163"
PRIVATE wCabec0 	:= 0
PRIVATE wCabec1		:=""
PRIVATE wCabec2		:=""
PRIVATE wCabec3		:=""
PRIVATE wCabec4		:=""
PRIVATE wCabec5		:=""
PRIVATE wCabec6		:=""
PRIVATE wCabec7		:=""
PRIVATE wCabec8		:=""
PRIVATE wCabec9		:=""
PRIVATE CONTFL		:=1
PRIVATE cPathPict	:= ""

Pergunte(cPerg,.F.)

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Envia controle para a funcao SETPRINT                        ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
wnrel:="XPlsr163"					           //Nome Default do relatorio em Disco
wnrel:=SetPrint(cAlias,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  | Verifica se foi cancelada a operacao                                     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If nLastKey  == 27
   Return
Endif
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Configura impressora                                                     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
SetDefault(aReturn,cAlias)
If nLastKey = 27
	Return
Endif 

MsAguarde({|lEnd| XR163Imp(@lEnd,wnRel,cAlias)},Titulo)

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ XR163Imp  ³ Autor ³ Natie Sugahara        ³ Data ³ 06/07/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Emite relatorio                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function XR163Imp()
Local   cPict			:= "@E    999"
Local   cOperadora		:= ""
Local   cUnidade		:= ""
Local   cString			:= ""
Local	nDesmarcada		:= 0 
Local	nTotUnid		:= 0
Local   nTotOper		:= 0
LOCAL   cMedicoDe, cMedicoAte, cEmpresaDe, cEmpresaAte, cEspecialDe, cEspecialAte	//, cCabec1, cCabec2
LOCAL	cMedico, cEmpresa, cEspecial, cCancela, cCodPac, cNomPac, cHora, cMedNome
LOCAL 	cData			:= ''   
Local   cAGG            := ""

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Acessa parametros do relatorio...                                        ³
  ³ Variaveis utilizadas para parametros                                     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
cOpeDe   		:= mv_par01					//-- Codigo da Operadora De
cOpeAte  		:= mv_par02					//-- Codigo da Operadora Ate
cUnidaDe		:= mv_par03					//-- Codigo da Unidade de Atendimento De
cUnidaAte		:= mv_par04					//-- Codigo da Unidade de Atendimento Ate
dDataDe			:= mv_par05  				//-- Periodo De
dDataAte		:= mv_Par06					//-- Periodo Ate
cMedicoDe		:= mv_Par07 				//-- Codigo do Medico De
cMedicoAte		:= mv_Par08                 //-- Codigo do Medico Ate
cEmpresaDe		:= mv_Par09                 //-- Codigo da Empresa De
cEmpresaAte		:= mv_Par10                 //-- Codigo da Empresa Ate
cEspecialDe		:= mv_Par11                 //-- Codigo da Especialidade de
cEspecialAte	:= mv_Par12                 //-- Codigo da Especialidade ate
cCancela		:= mv_Par13					//-- Codigo do Tipo de Cancelamento   
nSomAAG         := mv_par15                 //-- Somente AAG -- Motta 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP

	// function de aag do oracle-Motta
	//cSQL := "SELECT * FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	cSQL := "SELECT TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA)) AAG " 
	cSQL += "," + BBD->(RetSQLName("BBD"))+ ".* FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	//
	cSQL += "BBD_FILIAL = '"+xFilial("BBD")+"' "
	cSQL += "AND D_E_L_E_T_ = ' '  AND "
	cSQL += "BBD_CODINT >= '" + cOpeDe        +"' AND BBD_CODINT <= '"+ cOpeAte        +"' AND "
	cSQL += "BBD_CODIGO >= '" + cMedicoDe     +"' AND BBD_CODIGO <= '"+ cMedicoAte     +"' AND "
	cSQL += "BBD_CODEMP >= '" + cEmpresaDe    +"' AND BBD_CODEMP <= '"+ cEmpresaAte    +"' AND "
	cSQL += "BBD_CODESP >= '" + cEspecialDe   +"' AND BBD_CODESP <= '"+ cEspecialAte   +"' AND "
	cSQL += "BBD_CODLOC >= '" + cUnidaDe      +"' AND BBD_CODLOC <= '"+ cUnidaAte      +"' AND "
	cSQL += "BBD_DATA   >= '" + DTOS(dDataDe) +"' AND BBD_DATA   <= '"+ DTOS(dDataAte) +"' AND "
	cSQL += "BBD_STATUS = '7' "
	IF !EMPTY(cCancela)
		cSQL += "AND BBD_CODCAN = '"+cCancela+"'" //SELECIONA O TIPO DE CANCELAMENTO
	EndIf
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Se houver filtro executa parse para converter expressoes adv para SQL    ³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If ! Empty(aReturn[7])
		cSQL += " and " + PLSParSQL(aReturn[7])
	Endif  
	// Motta
   If nSomAAG == 2 
     cSQL += " AND TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA))='S' " 
   Endif
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Define order by de acordo com a ordem...                                 ³
      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
	cSQL += " ORDER BY BBD_FILIAL + BBD_CODINT + BBD_CODLOC + BBD_CODIGO + BBD_DATA + BBD_HORA"

	cSQL := PLSAvaSQL(cSQL)
	TCQUERY cSQL NEW ALIAS "BBDTrb"

#ENDIF
If MV_PAR14 == 1
//	  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//	  ³ EXIBE O RELATORIO NO MODO SINTETICO                                      ³
//    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	nTamanho := "P"
    BBDTrb->(dbgoTop())
	Li 		:= 0
	While  !( BBDTrb->(Eof()) )

		Impr( oEmToAnsi(STR0005)+ BBDTrb->BBD_CODINT + space(1)+ fDesc("BA0", BBDTrb->BBD_CODINT,"BA0_NOMINT" ) ,"C",,,03,.T.)		//-- Operadora
		Impr( oEmToAnsi(STR0007)+ dtoc(dDataDe) + " a " +dtoc(dDataAte)  ,"C",,,03,.T.)	//-- Periodo 
		cOperadora	:= 	BBDTrb->BBD_CODINT
		While !BBD->(Eof()) .and. BBDTrb->BBD_CODINT = cOperadora
			Impr( oEmToAnsi(STR0006) + BBDTrb->BBD_CODLOC + SPACE(1) +  fDesc("BD1",BBDTrb->(BBD_CODINT +BBD_CODLOC) , "BD1_DESLOC" )    ,"C",,,03,.T.)					//-- Unidade de Atendimento
			cOperadora	:= 	BBDTrb->BBD_CODINT
			cUnidade	:=  BBDTrb->BBD_CODLOC
		  /*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		  	³ Cabecalho da Linha de Detalhe                                            ³
		  	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
			Impr("","C")
			Impr(repl("-",30),"C",,,03,.T.)
			Impr(oemToAnsi(STR0008), "C",,,03,.T.)
			Impr(repl("-",30),"C",,,03,.T.)

			While !BBD->(Eof()) .and. BBDTrb->BBD_CODINT + BBDTrb->BBD_CODLOC = cOperadora + cUnidade
		
				/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			  	³ Verifica se foi abortada a impressao...                            ³
			  	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				If Interrupcao(lAbortPrint)
					Exit
				Endif

	    		/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		 	  	³ Exibe mensagem...                                                  ³
			  	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				MsProcTXT("Imprimindo Local " +  cUnidade  + "..." )

				cOperadora	:= 	BBDTrb->BBD_CODINT
				cUnidade	:=  BBDTrb->BBD_CODLOC
				cData		:=  BBDTrb->BBD_DATA
				While !BBD->(Eof()) .and. BBDTrb->BBD_CODINT + BBDTrb->BBD_CODLOC + BBDTrb->BBD_DATA= cOperadora + cUnidade + cData
					nDesmarcada	++
					nTotUnid	++ 
					nTotOper	++
					BBDTrb->(dbSkip())
				Enddo
				cString := substr(cData,7,2) + "/" + substr(cData,5,2) + "/" + ;
                       substr(cData,1,4)
				Impr( cString + space(15) + Transform( nDesmarcada, cPict ),"C",,,03,.T.)
				nDesmarcada	:= 0
			Enddo
			/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		  	³ Total por Unidade                                                        ³
	      	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
			Impr("","C")
			Impr(repl("-",30),"C",,,03,.T.)
			Impr(oEmToAnsi(STR0009) + cUnidade + space(7) + Transform(nTotUnid, cPict),"C",,,03,.T.)
			nTotUnid	:= 0
		Enddo
		/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  	³ Total por Operadora                                                      ³
      	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
		Impr("","C")
		Impr(repl("-",30),"C",,,03,.T.)
		Impr( oEmToAnsi(STR0010) + cOperadora + space(5) + Transform(nTotOper, cPict),"C",,,03,.T.)
	EndDo
	Impr("","F")
Else
//	  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//	  ³ EXIBE O RELATORIO NO MODO ANALITICO                                      ³
//    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	nTamnaho := "M"
	nTipo:=GetMv("MV_COMP")
    //  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
    //  ³ Cabecalho da Linha de Detalhe                                            ³
    //  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cabec1	:= "           CODIGO DA OPERADORA --> NOME DA EMPRESA"
	// Motta
	//cabec2 	:= "UNID MEDICO               ESPECIALIDADE        DATA        HORA USUARIO               NOME                         CANCELAMENTO"
    cabec2 	:= "UNID MEDICO               ESPECIALIDADE        DATA        HORA USUARIO               NOME                         CANCELAMEN X"
    //          1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    //                   1         2         3         4         5         6         7         8         9         10        11        12        13        15        15        16        17        18        19        20        21        22
	cabec(Titulo,cabec1,cabec2,cNomeProg,nTamanho,nTipo)

	BBDTrb->(dbgoTop())
	While  !( BBDTrb->(Eof()) )
	  	Impr( SPACE(8)+BBDTrb->BBD_CODINT + " --> " + fDesc("BA0", BBDTrb->BBD_CODINT,"BA0_NOMINT" ) ,"C",,,03,.T.)		//-- Operadora
		cOperadora	:= 	BBDTrb->BBD_CODINT
		While BBDTrb->BBD_CODINT = cOperadora
			cUnidade	:=  BBDTrb->BBD_CODLOC
            While BBDTrb->BBD_CODLOC = cUnidade
			
//		        ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//			  	³ Verifica se foi abortada a impressao...                            ³
//			  	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Interrupcao(lAbortPrint)
					Exit
				Endif
//	    		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//		 	  	³ Exibe o detalhe do relatorio                                       ³
//			  	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cMedico		:=  BBDTrb->BBD_CODIGO
				While BBDTrb->BBD_CODIGO = cMedico
						MsProcTXT("Imprimindo Local " +  cUnidade  + "..." )
						cData		:=  BBDTrb->BBD_DATA

						While BBDTrb->BBD_DATA = cData .AND. BBDTrb->BBD_CODIGO = cMedico
							cHora		:=  BBDTrb->BBD_HORA
							cMedNome	:=	SUBS(fDesc("BAU", BBDTrb->BBD_CODIGO,"BAU_NOME" ),1,20)
							cEmpresa	:=  BBDTrb->BBD_CODEMP
							cEspecial	:=	SUBS(fDesc("BAQ", BBDTrb->BBD_CODINT+BBDTrb->BBD_CODESP,"BAQ_CODINT+BAQ_DESCRI" ),5,20)
							//Motta
							//cCancela	:=  SUBS(fDesc("BTJ", BBDTrb->BBD_CODCAN,"BTJ_DESCRI"),1,15)
							cCancela	:=  SUBS(fDesc("BTJ", BBDTrb->BBD_CODCAN,"BTJ_DESCRI"),1,13)
							If Trim(BBDTrb->AAG) == "S"
				               cAAG            := "*" 
			                Else 
				               cAAG            := " " 
			                Endif  
							//
							cCodPac		:=  SUBS(BBDTrb->BBD_CODPAC,1,4)+"."+SUBS(BBDTrb->BBD_CODPAC,5,4)+"."+SUBS(BBDTrb->BBD_CODPAC,9,6)+"."+SUBS(BBDTrb->BBD_CODPAC,15,2)+"."+SUBS(BBDTrb->BBD_CODPAC,17,1) //9999.9999.999999.99.9 
							cNomPac		:=  Subs(BBDTrb->BBD_NOME,1,28)

							nTotUnid	++ 
							nTotOper	++
					
							cString := substr(cData,7,2) + "/" + substr(cData,5,2) + "/" + substr(cData,1,4) //CONVERTENDO DATA
//     						ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//						  	³ IMPRIME O DETALHE DO RELATORIO                                     ³
//						  	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							//Motta
							//Impr(cUnidade+space(1)+cMedNome+space(1)+cEspecial+space(1)+cString+space(1)+cHora+space(1)+cCodPac+space(1)+cNomPac+space(1)+cCancela,"C",,,01,.T.)
                            Impr(cUnidade+space(1)+cMedNome+space(1)+cEspecial+space(1)+cString+space(1)+cHora+space(1)+cCodPac+space(1)+cNomPac+space(1)+cCancela+space(1)+cAAG,"C",,,01,.T.)

							BBDTrb->(dbSkip())
						Enddo
				Enddo
			EndDo
//		    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//		  	³ Total por Unidade                                                        ³
//	      	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
			Impr(repl("-",132),"C",,,00,.T.)
			Impr(SPACE(80)+"TOTAL DA UNIDADE .....:" + cUnidade + space(7) + Transform(nTotUnid, cPict),"C",,,03,.T.)
			nTotUnid	:= 0
		Enddo
//	    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// 	  	³ Total por Operadora                                                      ³
//     	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
		Impr(repl("-",132),"C",,,00,.T.)
		Impr(SPACE(60)+oEmToAnsi(STR0010) + cOperadora + space(5) + Transform(nTotOper, cPict),"C",,,03,.T.)
	  
	EndDo
	Impr("","F")

EndIf

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Fecha arquivo...                                                   ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
BBDTrb->(DbCloseArea())

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Libera impressao                                                         ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If  aReturn[5] == 1
	Set Printer To
	Ourspool(wnRel)
EndIf
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Fim do Relat¢rio                                                         ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Return  