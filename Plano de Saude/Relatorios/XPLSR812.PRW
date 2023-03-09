#INCLUDE "PLSR812.CH"
#IFDEF TOP
#INCLUDE "TOPCONN.CH"
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSR812 ³ Autor ³ Natie Sugahara         ³ Data ³ 10/07/03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Agenda Medica                                              ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR812()                                                  ³±±±
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
User Function XPLSR812()
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Define variaveis padroes para todos os relatorios...                     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
PRIVATE wnRel         
PRIVATE cNomeProg   := "XPLSR812"
PRIVATE nLimite     := 80
PRIVATE nTamanho    := "P"
PRIVATE Titulo		:= oEmToAnsi(STR0001)				//-- Primeiras Consultas Por Unidade
PRIVATE cDesc1      := oEmToAnsi(STR0001)
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BBD"
PRIVATE cPerg       := "PLR812"
PRIVATE Li         	:= 0
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aReturn     := { oEmToAnsi(STR0002), 1,oEmToAnsi(STR0003) , 1, 1, 1, "",1 }
PRIVATE aOrd		:= { STR0004}														//--Unidade de Atendimento + Medico
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCabec
PRIVATE Colunas		:= 80
PRIVATE AT_PRG  	:= "XPLSR812"
PRIVATE wCabec0 	:= 2
PRIVATE wCabec1		:= space(3) + oEmToAnsi(STR0007)
PRIVATE wCabec2		:= space(5) + oEmToAnsi(STR0008)
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
wnrel:="XPlsr812"					           //Nome Default do relatorio em Disco
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

MsAguarde({|lEnd| XR812Imp(@lEnd,wnRel,cAlias)},Titulo)
//MsAguarde({|lEnd| R812Imp(@lEnd,wnRel,cAlias)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ XR812Imp ³ Autor ³ Natie Sugahara        ³ Data ³ 10/07/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Emite relatorio                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function XR812Imp()
Local   cOperadora		:= ""
Local   cUnidade		:= ""  
Local   cEspec			:= ""
Local   cMedico			:= ""
Local   cDet     		:= ""   
Local   cAAG            := "" 
Local   cNupre          := ""
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Acessa parametros do relatorio...                                        ³
  ³ Variaveis utilizadas para parametros                                     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
cOpeDe   	:= mv_par01					//-- Codigo da Operadora de
cOpeAte  	:= mv_par02					//-- Codigo da Operadora Ate
cUnidaDe	:= mv_par03					//-- Codigo da Unidade de Atendimento De
cUnidaAte	:= mv_par04					//-- Codigo da Unidade de Atendimento Ate
cMedDe  	:= mv_par05					//-- Codigo Medico De
cMedAte 	:= mv_par06					//-- codigo medico Ate
cEspecDe 	:= mv_par07					//-- Especialidade de 
cEspecAte	:= mv_par08					//-- especialidade Ate
dDataDe		:= mv_par09  				//-- Periodo De
dDataAte	:= mv_Par10					//-- Periodo Ate

cNupre      := mv_Par11					//-- Nupre

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Faz filtro no arquivo...                                                 ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
#IFDEF TOP
	// function de aag do oracle-Motta
	//cSQL := "SELECT * FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	cSQL := "SELECT TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA)) AAG " 
	cSQL += "," + BBD->(RetSQLName("BBD"))+ ".* FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	cSQL += "BBD_FILIAL = '"+xFilial("BBD")+"' "
	cSQL += "AND D_E_L_E_T_ = ' '  AND "
	cSQL += "BBD_STATUS IN ('1','4','5','6')  AND "
	cSQL += "BBD_CODINT >= '" + cOpeDe          +"' AND BBD_CODINT <= '"+ cOpeAte   +"' AND "
	cSQL += "BBD_CODLOC >= '" + cUnidaDe        +"' AND BBD_CODLOC <= '"+ cUnidaAte +"' AND "
	cSQL += "BBD_CODIGO >= '" + cMedDe          +"' AND BBD_CODIGO <= '"+ cMedAte   +"' AND "
	cSQL += "BBD_CODESP >= '" + cEspecDe        +"' AND BBD_CODESP <= '"+ cEspecAte +"' AND "	
	cSQL += "BBD_DATA   >= '" + DTOS(dDataDe)   +"' AND BBD_DATA   <= '"+ DTOS(dDataAte)+"' "   
	/*nupre*/
	cSQL += " AND BBD_LOCAL = '" + cNupre + "' " // Nupre	
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Se houver filtro executa parse para converter expressoes adv para SQL    ³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If ! Empty(aReturn[7])
		cSQL += " and " + PLSParSQL(aReturn[7])
	Endif 
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Define order by de acordo com a ordem...                                 ³
      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
	//cSQL += " ORDER BY BBD_FILIAL + BBD_CODINT + BBD_CODLOC + BBD_CODESP +  BBD_CODIGO + BBD_DATA"
	cSQL += " ORDER BY BBD_DATA + BBD_HORA"
	cSQL := PLSAvaSQL(cSQL)
	TCQUERY cSQL NEW ALIAS "BBDTrb"
#ENDIF

/*       10        20        30        40        50        60        70        80
012345678901234567890123459789012345978901234597890123459789012345978901234597890
     Data       Codigo                 Paciente                Hora  Cheg   Atd"
 	 99/99/9999 9.999.9999.999999-99-9 xxxxxxxxxxxxxxxxxxxx   99:99 99:99 99:99
*/

Li 		:= 0
BBDTrb->(dbgoTop())

While  !( BBDTrb->(Eof()) )
	cOperadora	:= 	BBDTrb->BBD_CODINT
	Impr("","C",,,03,.T.,.T.)
	Impr( oEmToAnsi(STR0005)+ BBDTrb->BBD_CODINT + space(1)+ fDesc("BA0", BBDTrb->BBD_CODINT,"BA0_NOMINT" ) ,"C",,,03,.T.)		//-- Operadora
	Impr( oEmToAnsi(STR0007)+ dtoc(dDataDe) + " a " + dtoc(dDataAte)   ,"C",,,03)
	Impr("","C",,,03,.T.,.T.)
	While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT = cOperadora
		cOperadora	:= 	BBDTrb->BBD_CODINT
		cUnidade	:=  BBDTrb->BBD_CODLOC

		Impr( oEmToAnsi(STR0006) + BBDTrb->BBD_CODLOC + SPACE(1) +  fDesc("BD1",BBDTrb->(BBD_CODINT +BBD_CODLOC) , "BD1_DESLOC" )    ,"C",,,03,.T.)					//-- Unidade de Atendimento
		Impr("","C")
		/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		  ³ Cabecalho da Linha de Detalhe                                            ³
		  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
		While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT + BBDTrb->BBD_CODLOC = cOperadora + cUnidade
			cOperadora	:= 	BBDTrb->BBD_CODINT
			cUnidade	:=  BBDTrb->BBD_CODLOC
			cEspec 		:=  BBDTrb->BBD_CODESP
			If (li + 3) >=58
				li := 0
			Endif	
			Impr(cEspec + space(1) + fDesc("BAQ", cOperadora + cEspec ,"BAQ_DESCRI"),"C",,,03,.T.)
			Impr(__PrtThinLine() ,"C")
			Impr("","C")
			While !BBDTrb->(Eof()) .and. BBDTrb->(BBD_CODINT + BBD_CODLOC + BBD_CODESP ) = cOperadora + cUnidade+ cEspec
				cOperadora	:= 	BBDTrb->BBD_CODINT
				cUnidade	:=  BBDTrb->BBD_CODLOC
				cEspec 		:=  BBDTrb->BBD_CODESP
				cMedico		:=  BBDTrb->BBD_CODIGO
				cDet		:= cMedico  + space(1) + fDesc("BAU", cMedico, "BAU_NOME")				//-- Medico
				Impr(cDet ,"C",,,03,.T.)
							
				/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				  ³ Verifica se foi abortada a impressao...                            ³
				  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				If Interrupcao(lAbortPrint)
					Exit
				Endif

		    	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 	  ³ Exibe mensagem...                                                  ³
				  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				MsProcTXT(STR0010 + cDet  + "..." ) //"Imprimindo "

				While !BBDTrb->(Eof()) .and. BBDTrb->(BBD_CODINT + BBD_CODLOC +BBD_CODESP + BBD_CODIGO) = cOperadora + cUnidade + cEspec + cMedico
				
					//cString		:= 	BBDTrb->(SUBSTRING(BBD_DATA,7,2)+'/'+SUBSTRING(BBD_DATA,5,2)+'/'+SUBSTRING(BBD_DATA,1,4) )
				    If Trim(BBDTrb->AAG) == "S"
					  cAAG            := "*" 
					Else 
					  cAAG            := " " 
					Endif  
					cString		:= 	cAAG+" "+BBDTrb->(SUBSTRING(BBD_DATA,7,2)+'/'+SUBSTRING(BBD_DATA,5,2)+'/'+SUBSTRING(BBD_DATA,1,4) )
					//
					cDet	:= BBDTrb->(cString  + space(1) + Transform(BBD_CODPAC,"@R #.###.####.######-##-#" )+ space(1)+ Left(BBD_NOME,20)) + space(3) 		//-- Paciente
					cDet	+= BBDTrb->(BBD_HORA)  + Space(1) 										//-- Hora Marcada
					cDet	+= BBDTrb->(BBD_HORCHE + space(1)+ BBD_HORENT )                        //-- Hor Chegada e Hor Atd
					//Impr(cDet, "C",,,05,.T.) 
					Impr(cDet, "C",,,3,.T.)
					//
               		BBDTrb->(dbSkip())
				Enddo
				Impr("","C")
			Enddo
			Impr("","C")			
		Enddo
		Impr("","C")
	Enddo
EndDo
Impr("","F")

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
