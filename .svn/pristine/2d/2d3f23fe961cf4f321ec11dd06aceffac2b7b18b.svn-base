
#include "PLSR811.CH"
#IFDEF TOP
	#INCLUDE "TOPCONN.CH"
#ENDIF

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё PLSR811 Ё Autor Ё Natie Sugahara         Ё Data Ё 06/07/03 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Primeiras Consultas Por Unidade                            Ё╠╠╠
╠╠Ё          Ё Gera listagem  com as primeiras consultas por unidade e    Ё╠╠╠
╠╠Ё          Ё Atrasos Medicos                                            Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё PLSR811()                                                  Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё Advanced Protheus                                          Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Alteracoes desde sua construcao inicial                               Ё╠╠╠
╠╠цддддддддддбддддддбдддддддддддддбддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Data     Ё BOPS Ё Programador Ё Breve Descricao                       Ё╠╠╠
╠╠цддддддддддеддддддедддддддддддддеддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё          |      |             |                                       Ё╠╠╠
╠╠юддддддддддаддддддадддддддддддддаддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/                                
User Function XPLSR811()
/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Define variaveis padroes para todos os relatorios...                     Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
PRIVATE wnRel         
PRIVATE cNomeProg   := "XPLSR811"
PRIVATE nLimite     := 132
PRIVATE nTamanho    := "M"
PRIVATE Titulo		:= oEmToAnsi(STR0001)				//-- Primeiras Consultas Por Unidade
PRIVATE cDesc1      := oEmToAnsi(STR0001)
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BBD"
PRIVATE cPerg       := "PLR811"
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

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis Utilizadas na funcao IMPR                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cCabec
PRIVATE Colunas		:= 80
PRIVATE AT_PRG  	:= "XPLSR811"
PRIVATE wCabec0 	:= 0
PRIVATE wCabec1		:= ""
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

/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Envia controle para a funcao SETPRINT                        Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
wnrel:="XPlsr811"					           //Nome Default do relatorio em Disco
wnrel:=SetPrint(cAlias,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  | Verifica se foi cancelada a operacao                                     Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
If nLastKey  == 27
	Return
Endif
/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Configura impressora                                                     Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
SetDefault(aReturn,cAlias)
If nLastKey = 27
	Return
Endif 

MsAguarde({|lEnd| XR811Imp(@lEnd,wnRel,cAlias)},Titulo)

Return


/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё XR811Imp  Ё Autor Ё Natie Sugahara        Ё Data Ё 06/07/03 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Emite relatorio                                            Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
/*/
Static Function XR811Imp()
Local   cOperadora		:= ""
Local   cUnidade		:= ""  
Local   cEspec			:= ""
Local   cDet     		:= ""
Local   cData			:= ""
Local   cHorCheg		:= ""
Local 	cHorSai			:= ""
Local   cHorOpen		:= ""
Local   cHorClose		:= "" 
Local   cAtraso			:= ""
Local   cNomeMed		:= ""
Local   cDescEspec		:= ""
Local 	lFirst			:= .T.
Local   aAtrasos		:= {} 
local   nX             

Local   cAAG            := "" // Motta

/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Acessa parametros do relatorio...                                        Ё
  Ё Variaveis utilizadas para parametros                                     Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
cOpeDe   	:= mv_par01					//-- Codigo da Operadora de
cOpeAte  	:= mv_par02					//-- Codigo da Operadora Ate
cUnidaDe	:= mv_par03					//-- Codigo da Unidade de Atendimento De
cUnidaAte	:= mv_par04					//-- Codigo da Unidade de Atendimento Ate
cCodMedDe	:= mv_par05					//-- Codigo Medico De
cCodMedAte	:= mv_par06					//-- Codigo Medico Ate
cCodEspDe	:= mv_par07					//-- Especialiade De
cCodEspAte	:= mv_par08					//-- Especialiade Ate
dDataDe		:= mv_par09  				//-- Periodo De
dDataAte	:= mv_Par10					//-- Periodo Ate  
nSomAAG     := mv_Par11                //-- Somente AAG Motta  

/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Faz filtro no arquivo...                                                 Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
#IFDEF TOP
	// function de aag do oracle-Motta
	//cSQL := "SELECT * FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	cSQL := "SELECT TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA)) AAG " 
	cSQL += "," + BBD->(RetSQLName("BBD"))+ ".* FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	//
	cSQL += "BBD_FILIAL = '"+xFilial("BBD")+"' "
	cSQL += "AND D_E_L_E_T_ = ' '  AND "
	cSQL += "BBD_CODINT >= '" + cOpeDe          +"' AND BBD_CODINT <= '"+ cOpeAte   +"' AND "
	cSQL += "BBD_CODLOC >= '" + cUnidaDe        +"' AND BBD_CODLOC <= '"+ cUnidaAte +"' AND "
	cSQL += "BBD_CODESP >= '" + cCodEspDe       +"' AND BBD_CODESP <= '"+ cCodEspAte+"' AND "
	cSQL += "BBD_CODIGO >= '" + cCodMedDe       +"' AND BBD_CODIGO <= '"+ cCodMedAte+"' AND "
	cSQL += "BBD_DATA   >= '" + DTOS(dDataDe)   +"' AND BBD_DATA   <= '"+ DTOS(dDataAte) + "' "

	/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	  Ё Se houver filtro executa parse para converter expressoes adv para SQL    Ё
	  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	If ! Empty(aReturn[7])
		cSQL += " and " + PLSParSQL(aReturn[7])
	Endif 
	// Motta
    If nSomAAG == 2 
      cSQL += " AND TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA))='S' " 
    Endif
	/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	  Ё Define order by de acordo com a ordem...                                 Ё
      юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */
	cSQL += " ORDER BY BBD_FILIAL + BBD_CODINT + BBD_CODLOC + BBD_DATA + BBD_CODESP + BBD_CODIGO +  BBD_HORA "
	cSQL := PLSAvaSQL(cSQL)
	PLSQuery(cSQL,"BBDTrb")
#ENDIF

/*       10        20        30        40        50        60        70        80        90       100       110       120       130                
012345678901234567890123459789012345978901234597890123459789012345978901234597890123459789012345978901234597890123459789012345978901234597890
   "Codigo Medico                  Espec      Codigo                 Paciente              Cheg   Atd   Contratada    Entra Saida"                                                                       
    xxxxxxxxxxxxxxxxxxxx 99:99 99:99   99:99 99:99   99:99 99:99
*/

BBDTrb->(dbgoTop())
Li 		:= 0
While  !( BBDTrb->(Eof()) )

	Impr( oEmToAnsi(STR0005)+ BBDTrb->BBD_CODINT + space(1)+ fDesc("BA0", BBDTrb->BBD_CODINT,"BA0_NOMINT" ) ,"C",,,03,.T.)		//-- Operadora
	Impr( oEmToAnsi(STR0007)+ dtoc(dDataDe) + " a " + dtoc(dDataAte)   ,"C",,,03)	
	
	cOperadora	:= 	BBDTrb->BBD_CODINT
	While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT == cOperadora
		cOperadora	:= 	BBDTrb->BBD_CODINT
		cUnidade	:=  BBDTrb->BBD_CODLOC
		Impr("","C")
		Impr( oEmToAnsi(STR0006) + cUnidade	 + SPACE(1) +  fDesc("BD1",(cOperadora+cUnidade	) , "BD1_DESLOC" )    ,"C",,,03,.T.)					//-- Unidade de Atendimento
		/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		  Ё Cabecalho da Linha de Detalhe                                            Ё
		  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */
		If Li + 4 >= 58 
			Impr("","P")
		Endif		
		Impr("","C")
		Impr(__PrtThinLine() ,"C")
		Impr( OemToansi(STR0008), "C",,,03,.T.)			
		Impr(__PrtThinLine() ,"C")
		While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT + BBDTrb->BBD_CODLOC == cOperadora + cUnidade
			cOperadora	:= 	BBDTrb->BBD_CODINT
			cUnidade	:=  BBDTrb->BBD_CODLOC
			cBB7Data	:= 	BBDTrb->BBD_DATA			                                                
			Impr("","C")                          
			Impr( "Data : " +  substr(dTos(cBB7Data),7,2) + "/" + substr( dTos(cBB7Data),5,2) + "/" + substr(dTos(cBB7Data),1,4)  , "C",,,03,.T.)	
			Impr("","C")                                			
			While !BBDTrb->(Eof()) .and. BBDTrb->BBD_CODINT + BBDTrb->BBD_CODLOC + dTos(BBDTrb->BBD_DATA) == cOperadora + cUnidade + dTos(cBB7Data)
				cOperadora	:= 	BBDTrb->BBD_CODINT
				cUnidade	:=  BBDTrb->BBD_CODLOC
				cBB7Data	:= 	BBDTrb->BBD_DATA
				cEspec 		:=  BBDTrb->BBD_CODESP
				While !BBDTrb->(Eof()) .and. BBDTrb->(BBD_CODINT + BBD_CODLOC + dTos(BBD_DATA) + BBD_CODESP ) =;
											 cOperadora + cUnidade+ dTos(cBB7Data) + cEspec
					cOperadora	:= 	BBDTrb->BBD_CODINT
					cUnidade	:=  BBDTrb->BBD_CODLOC     
					cBB7Data	:= 	BBDTrb->BBD_DATA
					cEspec 		:=  BBDTrb->BBD_CODESP
					cMedico		:=  BBDTrb->BBD_CODIGO
					lFirst 		:= .T.
					While !BBDTrb->(Eof()) .and. BBDTrb->(BBD_CODINT + BBD_CODLOC + dTos(BBD_DATA) + BBD_CODESP + BBD_CODIGO) =;
												  cOperadora + cUnidade + dTos(cBB7Data) + cEspec + cMedico
					
						/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						  Ё Verifica se foi abortada a impressao...                            Ё
						  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
						If Interrupcao(lAbortPrint)
							Exit
						Endif
	
						//Motta
						//cNomeMed	:= substr(fDesc("BAU", cMedico, "BAU_NOME")+ SPACE(25) ,1,25)    
						cNomeMed	:= substr(fDesc("BAU", cMedico, "BAU_NOME")+ SPACE(25) ,1,23)
						//
				    	/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					 	  Ё Exibe mensagem...                                                  Ё
						  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
						MsProcTXT("Imprimindo " +  cMedico  + "-" + cNomeMed + "..." )
					
						If lFirst
							fHrContratada( @cHorCheg, @cHorSai )
							fVerSala(@cHorOpen, @cHorClose)        
							
							//Motta
						    If Trim(BBDTrb->AAG) == "S"
				               cAAG            := "*" 
			                Else 
				               cAAG            := " " 
			                Endif  
							
							cDescEspec	:= LEFT(fDesc("BAQ", cOperadora+ cEspec ,"BAQ_DESCRI"),10)
							cDet	:= cMedico             + space(1) + cNomeMed   + space(1) 					//-- Medico
							cDet	+= cDescEspec          + space(1) 											//-- Especialidade Medica
							cDet	+= BBDTrb->(Transform(BBD_CODPAC,"@R #.###.####.######-##-#") + space(1)+ Left(BBD_NOME,20))  + space(1) 	//-- Paciente
							cDet	+= BBDTrb->(BBD_HORCHE + space(1)+ BBD_HORENT)                + space(3)	//-- Hor Chegada / Hor Atd Ou Marcada
							cDet	+= cHorCheg + space(1) + cHorSai                              + Space(3)	//-- Hora Contratada (Medico)
							//cDet	+= cHorOpen + space(1) + cHorClose 						                  	//-- Hora entrada e Saida (Medico)- Abertura da Sala 
							cDet	+= cHorOpen + space(1) + cHorClose + space(1) + cAAG // Motta
							Impr(cDet, "C",,,03,.T.)
							If Li + 4 >= 58 
								Impr("","P")
							/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							  Ё Cabecalho da Linha de Detalhe                                            Ё
							  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */
								Impr(__PrtThinLine() ,"C")
								Impr( OemToansi(STR0008), "C",,,03,.T.)			
								Impr(__PrtThinLine() ,"C")
								Impr("","C")
							Endif	
							/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							  Ё Atraso  Medico 
							  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */                       
							cAtraso := PlsSubHor(cHorCheg, cHorOpen)
							If Val(cAtraso) > 0 
								//-- 12345678901234567890123456789012345678901234567890123456789012345678901234567890
								//--"Codigo Medico                    Espec                 Data  Tempo Atraso"
								//-- 999999 XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXX      99/99/9999    
								cData   := substr(dTos(BBDTrb->BBD_DATA),7,2) + "/" + substr(dTos(BBDTrb->BBD_DATA),5,2) + "/" + substr(dTos(BBDTrb->BBD_DATA),1,4)
								aadd(aAtrasos,cMedico  +space(1)+ cNomeMed +space(1) + cDescEspec  + space(6) + cData  + space(2) + cAtraso  )
							Endif
							/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							  Ё Inicializa variaveis 
							  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */                       
							cDet			:= ""
							cHorCheg		:= ""
							cHorSai			:= ""
							cHorOpen		:= ""
							cHorClose		:= "" 
							lFirst 			:= .F.
						Endif
				       	BBDTrb->(dbSkip())
					Enddo
				Enddo
			Enddo
		Enddo
		If Len(aAtrasos) > 0
			/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			  Ё Atrasos do dia                                                           Ё
			  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */
			Impr("","C")
			Impr( oEmToAnsi(STR0005)+ cOperadora + space(1)+ fDesc("BA0", cOperadora,"BA0_NOMINT" ) ,"C",,,03,.T.)				//-- Operadora
			Impr( oEmToAnsi(STR0006)+ cUnidade  + SPACE(1)+ fDesc("BD1",cOperadora + cUnidade , "BD1_DESLOC" ) ,"C",,,03,.T.)		//-- Unidade de Atendimento
			Impr( OemToansi(STR0011),"C",,,03,.T.)
			Impr(__PrtThinLine()    ,"C")
			Impr( OemToansi(STR0009),"C",,,03,.T.)
			Impr(__PrtThinLine()    ,"C")
			For nX := 1 to Len(aAtrasos)
				Impr(aAtrasos[nx]   ,"C",,,03,.T.)
			Next
		Endif  
		aAtrasos	:= {}		
		/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		  Ё Muda de Pagina a cada mudanca de Unidade de Atendimento                  Ё
		  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */
		Impr("","P")

	Enddo
EndDo
Impr("","F")

/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Fecha arquivo...                                                   Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
BBDTrb->(DbCloseArea())

/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Libera impressao                                                         Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
If  aReturn[5] == 1
	Set Printer To
	Ourspool(wnRel)
EndIf
/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Fim do Relat╒rio                                                         Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
Return


/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁfHrContratada╨Autor  ЁMicrosiga           ╨ Data Ё  07/08/03   ╨╠╠
╠╠лммммммммммьмммммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     Ё busca Hora Contratada do Medico                               ╨╠╠
╠╠╨          Ё                                                               ╨╠╠
╠╠лммммммммммьммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                            ╨╠╠
╠╠хммммммммммоммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function fHrContratada(cHorCheg,cHorSai )
Local cSQLBB7	:= ""

/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Faz filtro no arquivo...                                                 Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	cSQLBB7 := "SELECT * FROM "+BB7->(RetSQLName("BB7"))+" WHERE "
	cSQLBB7 += "BB7_FILIAL = '"+xFilial("BB7")+"' "
	cSQLBB7 += "AND D_E_L_E_T_ = ' '  AND "
	cSQLBB7 += "BB7_CODINT >= '" + BBDTrb->( BBD_CODINT ) 				+"' AND "
	cSQLBB7 += "BB7_ANO    >= '" + BBDTrb->( substr(dTos(BBD_DATA),1,4) )	+"' AND "
	cSQLBB7 += "BB7_MES    >= '" + BBDTrb->( substr(dTos(BBD_DATA),5,2) )	+"' AND "
	cSQLBB7 += "BB7_DIAMES >= '" + BBDTrb->( substr(dTos(BBD_DATA),7,2) )	+"' AND "	
	cSQLBB7 += "BB7_CODLOC >= '" + BBDTrb->( BBD_CODLOC ) 			  	+"' AND "	
	cSQLBB7 += "BB7_CODESP >= '" + BBDTrb->( BBD_CODESP ) 				+"' AND "
	cSQLBB7 += "BB7_CODIGO >= '" + BBDTrb->( BBD_CODIGO ) 				+"' "

	/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	  Ё Se houver filtro executa parse para converter expressoes adv para SQL    Ё
	  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
	If ! Empty(aReturn[7])
		cSQLBB7 += " and " + PLSParSQL(aReturn[7])
	Endif   
	/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	  Ё Define order by de acordo com a ordem...                                 Ё
      юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды */
	cSQLBB7 += " ORDER BY BB7_DIAMES "

	cSQLBB7 := PLSAvaSQL(cSQLBB7)
	PLSQuery(cSQLBB7,"BB7Trb")
	

	/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	  Ё Atribui Valores                                                          Ё
	  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
    //Motta
	//cHorCheg	:= BB7Trb->BB7_HORENT
	//cHorSai	:= BB7Trb->BB7_HORSAI
	cHorCheg	:= BB7Trb->BB7_HORENT  + Space(5-Len(Trim(BB7Trb->BB7_HORENT)))
	cHorSai		:= BB7Trb->BB7_HORSAI  + Space(5-Len(Trim(BB7Trb->BB7_HORSAI)))
    //
/*здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
  Ё Fecha arquivo...                                                   Ё
  юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды*/
BB7Trb->(DbCloseArea())
Return 


/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁfVerSala     ╨Autor  ЁMicrosiga           ╨ Data Ё  07/08/03   ╨╠╠
╠╠лммммммммммьмммммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     Ё Abertura de Sala                                              ╨╠╠
╠╠╨          Ё                                                               ╨╠╠
╠╠лммммммммммьммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                            ╨╠╠
╠╠хммммммммммоммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function	fVerSala( cHorOpen,  cHorClose) 

dbSelectArea("BGF")
dbSetOrder(3)					//-- codigo de Abertura da Sala 
BB7->(dbGoTop()) 
If BGF->(dbSeek( xFilial("BGF") +  BBDTrb->( BBD_CODSAL + dTos(BBD_DATA) )  ) )
	//Motta
	//cHorOpen	:= BGF->BGF_HORINI
	//cHorClose	:= BGF->BGF_HORFIN
	cHorOpen	:= BGF->BGF_HORINI + Space(5-Len(Trim(BGF->BGF_HORINI)))
	cHorClose	:= BGF->BGF_HORFIN + Space(5-Len(Trim(BGF->BGF_HORFIN)))
Endif
BGF->(dbCloseArea())
Return


/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁPlsSubHor    ╨Autor  ЁMicrosiga           ╨ Data Ё  07/08/03   ╨╠╠
╠╠лммммммммммьмммммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     Ё Calcula diferenca entre dois valores de horas                 ╨╠╠
╠╠╨          Ё                                                               ╨╠╠
╠╠лммммммммммьммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                            ╨╠╠
╠╠хммммммммммоммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function PlsSubHor(cHor1,cHor2)
LOCAL cHora := Space(05)
LOCAL nMin1 := 0
LOCAL nMin2 := 0
LOCAL nMin  := 0
LOCAL nHor  := 0
nMin1 := (Val(SubStr(cHor1,1,2))*60)+Val(SubStr(cHor1,4,2))
nMin2 := (Val(SubStr(cHor2,1,2))*60)+Val(SubStr(cHor2,4,2))
nHor  := Int((nMin2 - nMin1) / 60)
nMin  := (  ( (nMin2 - nMin1) / 60 ) - nHor   )  * 60 
cHora := StrZero(nHor,2)+":"+StrZero(nMin,2)

Return cHora
